local keymap= vim.keymap
-- Keymappings
-- command
-- keymap.set('n', ';', ':', { noremap = true })
-- leave insert
keymap.set('i', 'jj', '<esc>', { noremap = true, silent = true })
keymap.set('i', 'jk', '<esc>', { noremap = true, silent = true })

-- delete
keymap.set('i', '<C-d>', '<Del>', { noremap = true })
-- Increment/decrement
--keymap.set('n', '+', '<C-a>', { noremap = true, silent = true })
--keymap.set('n', '-', '<C-x>', { noremap = true, silent = true })
-- Select all
--keymap.set('n', '<C-a>', 'gg<S-v>G', { noremap = true, silent = true })

-- cursor move
keymap.set('n', '<C-j>', '5j', { noremap = true, silent = true })
keymap.set('n', '<C-k>', '5k', { noremap = true, silent = true })
keymap.set('v', '<C-j>', '5j', { noremap = true, silent = true })
keymap.set('v', '<C-k>', '5k', { noremap = true, silent = true })
keymap.set('i', '<C-l>', '<Esc><S-a>', { noremap = true, silent = true })
keymap.set('i', '<C-f>', '<Right>', { noremap = true, silent = true })
keymap.set('i', '<C-b>', '<Left>', { noremap = true, silent = true })

-- change tab
keymap.set('n', '<C-l>', ':bnext<CR>', { noremap = true, silent = true })
keymap.set('n', '<C-h>', ':bprev<CR>', { noremap = true, silent = true })
keymap.set('n', '<leader>d', '<Cmd>BufferClose<CR>', { noremap = true, silent = true })

--
keymap.set('v', '<', '<gv', { noremap = true, silent = true })
keymap.set('v', '>', '>gv', { noremap = true, silent = true })
keymap.set('n', '<leader><Space>', ':nohls<CR>', { noremap = true, silent = true })

-- Split
keymap.set('n', '<leader>s', ':split<Return><C-w>w')
keymap.set('n', '<leader>v', ':vsplit<Return><C-w>w')
--
keymap.set('', '<leader>h', '<C-w>h')
keymap.set('', '<leader>k', '<C-w>k')
keymap.set('', '<leader>j', '<C-w>j')
keymap.set('', '<leader>l', '<C-w>l')
