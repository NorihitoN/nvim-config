local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
    spec = {
        { import = "plugins" },
    }
})

require('options')
require('keymaps')
require('coc')

local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require("telescope.builtin")
--
local function telescope_buffer_dir()
    return vim.fn.expand('%:p:h')
end

-- keymaps
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set("n", "<leader>fi", function()
    telescope.extensions.file_browser.file_browser({
        path = "%:p:h",
        cwd = telescope_buffer_dir(),
        respect_gitignore = false,
        hidden = true,
        grouped = true,
        previewer = false,
        initial_mode = "normal",
        layout_config = { height = 40, width = 120 }
    })
end)

vim.cmd([[
    nmap <F1> <cmd>call vimspector#Launch()<cr>
    nmap <F2> <cmd>call vimspector#Reset()<cr>
    nmap <F5> <cmd>call vimspector#Continue()<cr>
    nmap <S-F5> <cmd>call vimspector#Stop()<cr>
    nmap <S-C-F5> <cmd>call vimspector#Restart()<cr>
    nmap <F6> <cmd>call vimspector#Pause()<cr>
    nmap <F8> <cmd>call vimspector#JumpToNextBreakpoint()<cr>
    nmap <S-F8> <cmd>call vimspector#JumpToPrevBreakpoint()<cr>
    nmap <F9> <cmd>call vimspector#ToggleBreakpoint()<cr>
    nmap <F10> <cmd>call vimspector#StepOver()<cr>")
    nmap <F11> <cmd>call vimspector#StepInto()<cr>")
    nmap <F12> <cmd>call vimspector#StepOut()<cr>")
]])
vim.keymap.set('n', '<Leader>gs', '<cmd>call vimspector#Launch()<cr>')
vim.keymap.set('n', "<C-CR>", "<Plug>VimspectorBalloonEval")

vim.env.LANG = "en_US.UTF-8"
