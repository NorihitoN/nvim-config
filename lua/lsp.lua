-- lua/lsp.lua

local lspconfig = require("lspconfig")

-- capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end
  nmap("gd", vim.lsp.buf.definition, "LSP: Go to definition")
  nmap("gr", vim.lsp.buf.references, "LSP: References")
  nmap("gi", vim.lsp.buf.implementation, "LSP: Implementation")
  nmap("K", vim.lsp.buf.hover, "LSP: Hover")
  nmap("<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
  nmap("<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")
  -- nmap("<leader>f", function() vim.lsp.buf.format({ async = true }) end, "LSP: Format")
  nmap("<leader>Fm", function() require("conform").format({ async = true }) end, "Format")
  nmap("[d", vim.diagnostic.goto_prev, "Diagnostic: Prev")
  nmap("]d", vim.diagnostic.goto_next, "Diagnostic: Next")
  nmap("<leader>e", vim.diagnostic.open_float, "Diagnostic: Float")
end

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- ★ここから：setup_handlers が無い場合もフォールバック
local ok_mlsp, mlsp = pcall(require, "mason-lspconfig")

local function default_setup(server_name)
  lspconfig[server_name].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- 個別設定（必要なものだけ上書き）
local custom = {
  rust_analyzer = function()
    lspconfig.rust_analyzer.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          cargo = { allFeatures = true },
          checkOnSave = { command = "clippy" },
        },
      },
    })
  end,

  lua_ls = function()
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    })
  end,

  scheme_langserver = function()
    lspconfig.scheme_langserver.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "scheme-langserver" },
      filetypes = { "scheme" },
    })
  end,
}

if ok_mlsp and type(mlsp.setup_handlers) == "function" then
  -- 新しめAPI
  mlsp.setup_handlers({
    function(server_name)
      if custom[server_name] then
        custom[server_name]()
      else
        default_setup(server_name)
      end
    end,
  })
else
  -- 古い/非対応: 主要サーバを手で setup（必要に応じて追加）
  local servers = {
    "hls", "pyright", "ts_ls", "rust_analyzer", "clangd", "metals", "elixirls",
    "scheme_langserver", "lua_ls",
  }
  for _, s in ipairs(servers) do
    if custom[s] then
      custom[s]()
    else
      default_setup(s)
    end
  end
end
