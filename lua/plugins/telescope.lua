--
-- On Ubuntu
-- https://github.com/sharkdp/fd
-- sudo apt install fd-find
-- ln -s $(which fdfind) ~/.local/bin/fd
-- :checkhealth telescope
local telescope = require("telescope")
local builtin = require('telescope.builtin')
local lga_actions = require("telescope-live-grep-args.actions")
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")

vim.keymap.set('n', '<leader>ff', builtin.find_files,
               {desc = "Telescope find files"})
vim.keymap.set('n', '<leader>fw', builtin.live_grep,
               {desc = "Telescope search for text"})

vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = 'Telescope buffers'})
vim.keymap.set('n', '<leader>fd', builtin.diagnostics,
               {desc = 'Telescope diagnostics'})
vim.keymap.set('n', '<leader>fn', builtin.resume, {})
-- vim.keymap.set('n', '<Tab>', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc = "Help tags"})
vim.keymap.set('n', '<leader>gb', builtin.git_branches,
               {desc = 'Telescope git branches'})
vim.keymap.set('n', '<leader>gc', builtin.git_commits,
               {desc = 'Telescope git commits'})
vim.keymap.set('n', '<leader>gs', builtin.git_status,
               {desc = 'Telescope git status'})
vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols,
               {desc = "Telescope show document symbols"})
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {
    noremap = true,
    silent = true,
    desc = 'Telescope LSP references'
})
vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, {
    noremap = true,
    silent = true,
    desc = "Jumps to the definition of the symbol under the cursor"
})
vim.keymap.set("n", ",ff",
               ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
               {desc = "Seaarch for text in files"})
vim.keymap.set("n", ",fc", live_grep_args_shortcuts.grep_word_under_cursor,
               {desc = "Search for text under cursor"})
vim.keymap.set("v", ",f", live_grep_args_shortcuts.grep_visual_selection,
               {desc = "Search for selected text"})

telescope.setup {
    pickers = {
        find_files = {no_ignore = false, hidden = true}, -- , , theme = "dropdown"
        live_grep = {additional_args = {"--hidden"}}

    },
    extensions = {
        live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            -- define mappings, e.g.
            mappings = { -- extend mappings
                i = {
                    ["<C-k>"] = lga_actions.quote_prompt(),
                    ["<C-i>"] = lga_actions.quote_prompt({postfix = " --iglob "}),
                    -- freeze the current list and start a fuzzy search in the frozen list
                    ["<C-space>"] = lga_actions.to_fuzzy_refine
                }
            }
            -- ... also accepts theme settings, for example:
            -- theme = "dropdown", -- use dropdown theme
            -- theme = { }, -- use own theme spec
            -- layout_config = { mirror=true }, -- mirror preview pane
        }
    }
}

telescope.load_extension("live_grep_args")
