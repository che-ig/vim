local hop = require("hop")
local directions = require("hop.hint").HintDirection

-- Переход к символу, стоящему после курсора в текущей строке
vim.keymap.set("", "f", function()
    hop.hint_char1({
        direction = directions.AFTER_CURSOR,
        current_line_only = true
    })
end, {remap = true})

-- Переход к символу, стоящему позади курсора в текущей строке
vim.keymap.set("", "F", function()
    hop.hint_char1({
        direction = directions.BEFORE_CURSOR,
        current_line_only = true
    })
end, {remap = true})

-- Переход к символу, стоящему после курсора и перед тем, который ищем в текущей строке
vim.keymap.set("", "t", function()
    hop.hint_char1({
        direction = directions.AFTER_CURSOR,
        current_line_only = true,
        hint_offset = -1
    })
end, {remap = true})

-- Переход к символу, стоящему перед курсора и после того, который ищем в текущей строке
vim.keymap.set("", "T", function()
    hop.hint_char1({
        direction = directions.BEFORE_CURSOR,
        current_line_only = true,
        hint_offset = 1
    })
end, {remap = true})

-- Поиск по 2 символам
vim.keymap.set("n", "<leader>j", function()
    hop.hint_char2({})
end, {remap = true})

vim.keymap.set({"n", "v"}, "<leader>ll", function()
    hop.hint_lines({})
end, {remap = true})
