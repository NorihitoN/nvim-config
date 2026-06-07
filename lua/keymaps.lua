local keymap = vim.keymap

-- leave insert
keymap.set('i', 'jj', '<esc>', { noremap = true, silent = true })
keymap.set('i', 'jk', '<esc>', { noremap = true, silent = true })

-- delete
keymap.set('i', '<C-d>', '<Del>', { noremap = true })

-- cursor move
keymap.set('n', '<C-j>', '5j', { noremap = true, silent = true })
keymap.set('n', '<C-k>', '5k', { noremap = true, silent = true })
keymap.set('v', '<C-j>', '5j', { noremap = true, silent = true })
keymap.set('v', '<C-k>', '5k', { noremap = true, silent = true })
keymap.set('i', '<C-l>', '<Esc><S-a>', { noremap = true, silent = true })
keymap.set('i', '<C-f>', '<Right>', { noremap = true, silent = true })
keymap.set('i', '<C-b>', '<Left>', { noremap = true, silent = true })

-- change buffer
keymap.set('n', '<C-l>', ':bnext<CR>', { noremap = true, silent = true })
keymap.set('n', '<C-h>', ':bprev<CR>', { noremap = true, silent = true })
keymap.set('n', '<leader>d', '<Cmd>BufferClose<CR>', { noremap = true, silent = true })

-- indent
keymap.set('v', '<', '<gv', { noremap = true, silent = true })
keymap.set('v', '>', '>gv', { noremap = true, silent = true })
keymap.set('n', '<leader><Space>', ':nohls<CR>', { noremap = true, silent = true })

-- split
keymap.set('n', '<leader>s', ':split<Return><C-w>w')
keymap.set('n', '<leader>v', ':vsplit<Return><C-w>w')
keymap.set('', '<leader>h', '<C-w>h')
keymap.set('', '<leader>k', '<C-w>k')
keymap.set('', '<leader>j', '<C-w>j')
keymap.set('', '<leader>l', '<C-w>l')

-- PlantUML: SVGを生成してHTTPサーバー経由でプレビュー (<leader>pu)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "plantuml",
    callback = function()
        keymap.set('n', '<leader>pu', function()
            local file = vim.fn.expand('%:p')
            local dir = vim.fn.expand('%:p:h')
            local stem = vim.fn.expand('%:t:r')
            vim.fn.system('plantuml -tsvg ' .. vim.fn.shellescape(file) .. ' -o ' .. vim.fn.shellescape(dir))
            vim.fn.system('lsof -i :8765 | grep -q LISTEN || (cd ' .. vim.fn.shellescape(dir) .. ' && python3 -m http.server 8765 &>/tmp/plantuml-server.log &)')
            vim.notify('PlantUML: http://localhost:8765/' .. stem .. '.svg', vim.log.levels.INFO)
        end, { buffer = true, desc = "PlantUML: preview SVG" })
    end
})

-- LSP
keymap.set('n', '<leader>lr', function()
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        client:stop()
    end
    vim.cmd('e')
end, { noremap = true, silent = true, desc = "LSP: Restart" })
