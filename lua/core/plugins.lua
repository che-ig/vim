local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local path_to_my_plugin = vim.fn.stdpath('config') .. "/my_plugins/"

if not vim.loop.fs_stat(lazypath) then
    vim.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        'smoka7/hop.nvim',
        version = "*",
        opts = {keys = 'etovxqpdygfblzhckisuran'}
    }, {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim", "s1n7ax/nvim-window-picker"
        }
    }, {"nvim-treesitter/nvim-treesitter"}, {"neovim/nvim-lspconfig"},
    {"williamboman/mason.nvim", build = ":MasonUpdate"}, {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {"williamboman/mason.nvim"},
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "clangd", "debugpy", "golangci-lint", -- "delve", 
                    "lua-language-server", "luaformatter", "prettierd",
                    "pyright", "shellcheck", "stylua", "bash-language-server",
                    "bash-debug-adapter", "texlab", "ruff"
                    -- "flake8", "isort", "pylint", "black" 
                },
                start_delay = 0
            })
        end
    }, {'sainnhe/gruvbox-material', lazy = false, priority = 1000},
    {"hrsh7th/cmp-nvim-lsp"}, {"hrsh7th/cmp-buffer"}, {"hrsh7th/cmp-path"},
    {"hrsh7th/cmp-cmdline"}, {"hrsh7th/nvim-cmp"},
    {"hrsh7th/cmp-nvim-lsp-signature-help"}, {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        -- branch = '0.1.x'
        dependencies = {
            {"nvim-lua/plenary.nvim"},
            {"nvim-telescope/telescope-live-grep-args.nvim"}
        }
    }, {"nvimtools/none-ls.nvim"},
    {"akinsho/toggleterm.nvim", version = "*", config = true},
    {"akinsho/bufferline.nvim", dependencies = {"nvim-tree/nvim-web-devicons"}},
    {
        "glepnir/dashboard-nvim",
        event = "VimEnter",
        dependencies = {{"nvim-tree/nvim-web-devicons"}}
    }, {"lewis6991/gitsigns.nvim"}, {
        "linrongbin16/lsp-progress.nvim",
        event = {"VimEnter"},
        dependencies = {"nvim-tree/nvim-web-devicons"},
        config = function()
            require("lsp-progress").setup()
        end
    }, {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons", "linrongbin16/lsp-progress.nvim"
        }
    }, {"folke/which-key.nvim"}, {"windwp/nvim-autopairs"},
    {"numToStr/Comment.nvim"}, {"mfussenegger/nvim-dap"},
    {"nvim-tree/nvim-web-devicons"}, {"ryanoasis/vim-devicons"}, {
        "rcarriga/nvim-dap-ui",
        dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}
    }, {"leoluz/nvim-dap-go"}, {"jbyuki/one-small-step-for-vimkind"},
    {"rcarriga/nvim-notify"}, {"yorickpeterse/nvim-window", config = true}, {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = {"rafamadriz/friendly-snippets"}
    }, {"rafamadriz/friendly-snippets"}, {"saadparwaiz1/cmp_luasnip"},
    {"mbbill/undotree"}, {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter"
        }
    }, {"kevinhwang91/nvim-ufo", dependencies = {"kevinhwang91/promise-async"}},
    {"mmarchini/bpftrace.vim"}, {
        "Wansmer/langmapper.nvim",
        lazy = false,
        priority = 1, -- High priority is needed if you will use `autoremap()`
        config = function()
            require("langmapper").setup({ --[[ your config ]] })
        end
    }, {"chentoast/marks.nvim", event = "VeryLazy", opts = {}},
    {"tpope/vim-surround"}, {"tpope/vim-fugitive"},
    {"nvim-pack/nvim-spectre", dependencies = {"nvim-lua/plenary.nvim"}}, {
        -- плагины для отрбражения картинок
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
            -- add options here
            -- or leave it empty to use the default settings
        },
        keys = {
            -- suggested keymap
            {
                "<leader>p",
                "<cmd>PasteImage<cr>",
                desc = "Paste image from system clipboard"
            }
        }
    }, {
        "iamcco/markdown-preview.nvim",
        cmd = {
            "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop"
        },
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = {"markdown"}
        end,
        ft = {"markdown"}
    }, {
        "lervag/vimtex",
        lazy = false, -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
            -- VimTeX configuration goes here, e.g.
            vim.g.vimtex_view_general_viewer = "okular"
        end
    }, -- подключение собстввенных плагинов
    {dir = path_to_my_plugin .. "switch_buffer"},
    {dir = path_to_my_plugin .. "surround"}
})
