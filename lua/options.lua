
vim.g.loaded_perl_provider = 0

vim.opt.ignorecase         = true
vim.opt.smartcase          = true
vim.opt.updatetime         = 300
vim.opt.clipboard          = "unnamedplus"
vim.opt.inccommand         = "split"

-- bufferline plugin needs termguicolors is true
vim.opt.termguicolors      = true
vim.opt.scrolloff          = 4
vim.opt.pumblend           = 10
vim.opt.winblend           = 20

-- Options
vim.opt.expandtab          = true
vim.opt.tabstop            = 4
vim.opt.softtabstop        = 4
vim.opt.shiftwidth         = 4
vim.opt.smartindent        = true
-- vim.cmd autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
vim.opt.number             = true
vim.opt.relativenumber     = true
-- vim.opt.wrap               = false
vim.opt.signcolumn         = "yes"
vim.opt.guicursor          =
"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait30-blinkoff20-blinkon15-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
vim.opt.list               = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'


vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
