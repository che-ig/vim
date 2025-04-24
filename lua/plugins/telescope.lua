--
-- On Ubuntu
-- https://github.com/sharkdp/fd
-- sudo apt install fd-find
-- ln -s $(which fdfind) ~/.local/bin/fd
-- :checkhealth telescope
local builtin = require('telescope.builtin')
local lga_actions = require("telescope-live-grep-args.actions")

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})

vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>fn', builtin.resume, {})
-- vim.keymap.set('n', '<Tab>', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, {})
vim.keymap.set('n', 'gr', builtin.lsp_references,
               {noremap = true, silent = true})
vim.keymap.set('n', 'gd', builtin.lsp_definitions,
               {noremap = true, silent = true})
vim.keymap.set("n", ",fg",
               ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

require('telescope').setup {
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
