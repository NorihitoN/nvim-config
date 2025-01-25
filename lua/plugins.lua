return {
    { -- colorscheme
        "EdenEast/nightfox.nvim",
        config = function()
            vim.cmd("colorscheme nightfox")
        end
    },
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
                size = 100,
                direction = "vertical",
                open_mapping = [[<C-t>]],
                close_on_exit = true,
                insert_mapping = true,
                terminal_mapping = true,
                stert_in_insert = false,
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
                signs_start = {
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
    { "chrisbra/csv.vim" },
    { "puremourning/vimspector" }
}
