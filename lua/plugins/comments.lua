-- local api = vim.api
--
-- require("nvim_comment").setup({
--     line_mapping = ",c",
--     operator_mapping = ",c",
--     hook = function()
--         local filetype = api.nvim_buf_get_option(0, "filetype")
--         if filetype == "c" or filetype == "cpp" then
--             api.nvim_buf_set_option(0, "commentstring", "// %s")
--         end
--     end
-- })
-- https://github.com/numToStr/Comment.nvim
require("Comment").setup({
    ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment
    ignore = nil,
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
        ---Line-comment toggle keymap
        line = ',cc',
        ---Block-comment toggle keymap
        block = ',cb'
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        ---Line-comment keymap
        line = ',cc',
        ---Block-comment keymap
        block = ',cb'
    },
    ---LHS of extra mappings
    extra = {
        ---Add comment on the line above
        above = ',cO',
        ---Add comment on the line below
        below = ',co',
        ---Add comment at the end of line
        eol = ',cA'
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true
    },
    ---Function to call before (un)comment
    pre_hook = nil,
    ---Function to call after (un)comment
    post_hook = nil
})
