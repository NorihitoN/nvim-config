-- lua/completion.lua
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                -- Copilot のインライン補完を Tab で受け入れる
                local copilot_keys = vim.fn["copilot#Accept"]("")
                if copilot_keys ~= "" then
                    vim.api.nvim_feedkeys(copilot_keys, "i", true)
                else
                    fallback()
                end
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }),
})

-- vimwiki の Tab マッピングを無効化（Copilot Tab を優先するため）
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "vimwiki", "markdown" },
    callback = function()
        vim.keymap.set("i", "<Tab>", function()
            local copilot_keys = vim.fn["copilot#Accept"]("")
            if copilot_keys ~= "" then
                vim.api.nvim_feedkeys(copilot_keys, "i", true)
            else
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
            end
        end, { buffer = true, silent = true })
    end,
})

-- nvim-cmp と autopairs の連携（←ここを追加）
local ok_ap, npairs = pcall(require, "nvim-autopairs")
if ok_ap then
  local cmp_ap = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_ap.on_confirm_done())
end

