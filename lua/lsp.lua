-- lua/lsp.lua

-- LspAttach autocmd でキーマップを設定（mason-lspconfig v2 対応）
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local nmap = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
		end
		nmap("gd", vim.lsp.buf.definition, "LSP: Go to definition")
		nmap("gr", vim.lsp.buf.references, "LSP: References")
		nmap("gi", vim.lsp.buf.implementation, "LSP: Implementation")
		nmap("K", vim.lsp.buf.hover, "LSP: Hover")
		nmap("<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
		nmap("<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")
		nmap("<leader>F", function()
			require("conform").format({ async = true })
		end, "Format")
		nmap("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Diagnostic: Prev")
		nmap("]d", function() vim.diagnostic.jump({ count = 1 }) end, "Diagnostic: Next")
		nmap("<leader>e", vim.diagnostic.open_float, "Diagnostic: Float")
	end,
})

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
	capabilities = cmp_lsp.default_capabilities(capabilities)
end

-- 全サーバー共通のデフォルト設定（vim.lsp.config 新 API）
vim.lsp.config("*", { capabilities = capabilities })

-- サーバー個別設定
vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			cargo = { allFeatures = true },
			checkOnSave = { command = "clippy" },
		},
	},
})

vim.lsp.config("lua_ls", {
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

-- mason-lspconfig の automatic_enable に任せず明示的に有効化
-- (ensure_installed 以外のサーバーも含む)
vim.lsp.enable({ "hls", "pyright", "rust_analyzer", "lua_ls", "metals" })
