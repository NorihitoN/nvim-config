return {
    { -- colorscheme
        "EdenEast/nightfox.nvim",
        config = function()
            require("nightfox").setup({
                options = {
                    transparent = true,
                },
            })
            vim.cmd("colorscheme nightfox")
        end
    },
    { "xiyaowong/transparent.nvim"},
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {},
    },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl",                               opts = {},    version = "3.5.4" },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup()
        end
    },
    { 'brenoprata10/nvim-highlight-colors' },
    { 'numToStr/Comment.nvim',               opts = {},                                  lazy = false, },
    { "folke/todo-comments.nvim",            dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
    { 'fedepujol/move.nvim',                 opts = {} },
    { 'phaazon/hop.nvim',                    opts = {} },
    -- {
    --     'kevinhwang91/nvim-hlslens',
    --     config = function()
    --         require("hlslens").setup()
    --     end
    -- },
    -- Filer
    {
        'lambdalisue/fern.vim',
        keys = {
            { "<C-e>", ":Fern . -reveal=% -drawer -toggle -width=40<CR>", desc = "toggle fern" },
        },
        dependencies = {
            { 'lambdalisue/nerdfont.vim', },
            {
                'lambdalisue/fern-renderer-nerdfont.vim',
                config = function()
                    vim.g['fern#renderer'] = "nerdfont"
                end
            },
            { 'lambdalisue/fern-git-status.vim' },
            { 'lambdalisue/glyph-palette.vim' },
        },
        config = function()
            vim.g['fern#default_hidden'] = 1
        end
    },
    -- Fuzzy Finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "tsakirist/telescope-lazy.nvim" },
            { "nvim-telescope/telescope-file-browser.nvim" },
            { "nvim-lua/plenary.nvim" },
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    lazy = {
                        -- Optional theme (the extension doesn't set a default theme)
                        theme = "ivy",
                        -- Whether or not to show the icon in the first column
                        show_icon = true,
                        -- Mappings for the actions
                        mappings = {
                            open_in_browser = "<C-o>",
                            open_in_file_browser = "<M-b>",
                            open_in_find_files = "<C-f>",
                            open_in_live_grep = "<C-g>",
                            open_in_terminal = "<C-t>",
                            open_plugins_picker = "<C-b>", -- Works only after having called first another action
                            open_lazy_root_find_files = "<C-r>f",
                            open_lazy_root_live_grep = "<C-r>g",
                            change_cwd_to_plugin = "<C-c>d",
                        },
                        -- Configuration that will be passed to the window that hosts the terminal
                        -- For more configuration options check 'nvim_open_win()'
                        terminal_opts = {
                            relative = "editor",
                            style = "minimal",
                            border = "rounded",
                            title = "Telescope lazy",
                            title_pos = "center",
                            width = 0.5,
                            height = 0.5,
                        },
                    },
                    file_browser = {
                        theme = "dropdown",
                        -- disables netrw and use telescope-file-browser in its place
                        hijack_netrw = true,
                        mappings = {},
                    },
                },
            })
            require("telescope").load_extension "lazy"
            require("telescope").load_extension "file_browser"
        end
    },
    {
        'stevearc/aerial.nvim',
        opts = {},
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require('aerial').setup({
                backends = { 'treesitter' },
                layout = {
                    placement = "window",
                    max_width = { 40, 0.2 },
                    min_width = 40,
                    default_direction = "prefer_right",
                },
                filter_kind = {
                    "Class",
                    "Constructor",
                    "Enum",
                    "Function",
                    "Interface",
                    "Module",
                    "Method",
                    "Struct",

                }
            })
            -- Key mapping
            vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>AerialToggle<CR>', { noremap = true, silent = true })
        end
    },
    -- Terminal
    {
        "akinsho/toggleterm.nvim",
        version = '*',
        config = function()
            require("toggleterm").setup({
                direction = "float",
                open_mapping = [[<C-t>]],
                close_on_exit = true,
                insert_mapping = true,
                terminal_mapping = true,
                start_in_insert = false,
            })

            function _G.set_terminal_keymaps()
                local opts = { buffer = 0 }
                vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', opts)
                vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
            end

             vim.cmd([[
                    autocmd! TermOpen term://* lua set_terminal_keymaps()
            ]])

            -- **TermOpen のたびに透明化を適用**
            vim.api.nvim_create_autocmd("TermOpen", {
                pattern = "term://*",
                callback = function()
                    vim.cmd("startinsert")  -- 開いた直後に挿入モードで開始
                    -- ターミナルの背景を透明にする
                    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
                    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
                    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
                end,
            })
        end
    },
    -- Tagbar
    { 'majutsushi/tagbar' },
    -- Git
    { "tpope/vim-fugitive" },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs      = {
                    add          = { text = '│' },
                    change       = { text = '│' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signs_staged = {
                    add          = { text = '│' },
                    change       = { text = '│' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signs_staged_enable = true,
                signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
                numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
            })
        end
    },
    { "sindrets/diffview.nvim" },
    -- LSP
    { "neoclide/coc.nvim",      branch = 'release' },
    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })()
        end,
    },
    { "github/copilot.vim" },
    { "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
          { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
          { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
          -- See Configuration section for options
        },
        -- See Commands section for default commands if you want to lazy load on them
      },
    { "chrisbra/csv.vim" },
    { "puremourning/vimspector" },
    { "vimwiki/vimwiki",
        init = function()
            vim.g.vimwiki_list = {
                {
                  path = os.getenv("HOME") .. "/Library/Mobile Documents/com~apple~CloudDocs/vimwiki/",
                  syntax = "markdown",
                  ext = "md",
                }
            }
            vim.g.vimwiki_global_ext = 0
        end
    }
}
