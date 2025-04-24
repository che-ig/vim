-- В данном модуле находятся пользовательские команды
local api = vim.api
-- Ищет слово под курсором в файле tags (созданный утилитой ctags)
api.nvim_create_user_command('Tags', function(opts)
    local cursor_word = vim.fn.expand("<cword>")
    print(cursor_word)
    print(vim.inspect(vim.fn.taglist(string.format("^%s", cursor_word))))
end, {desc = "Find tags"})

-- Переводит слово под курсоком в верхний регист
api.nvim_create_user_command('Upper', function(opts)
    local current_word = vim.fn.expand("<cword>")
    local current_word_upper = string.upper(current_word)
    vim.cmd("normal! diwi" .. current_word_upper)
end, {})

-- Переводит слово под курсоком в нижний регист
api.nvim_create_user_command('Lower', function(opts)
    local current_word = vim.fn.expand("<cword>")
    local current_word_upper = string.lower(current_word)
    vim.cmd("normal! diwi" .. current_word_upper)
end, {})

-- Переводит название сущности в snake case
api.nvim_create_user_command('SnakeCase', function(opts)
    local current_word = vim.fn.expand("<cword>")
    -- change case to snake case
    local snake_case = current_word:gsub("(%u)", "_%1"):gsub("(%u)",
                                                             string.lower):gsub(
                           "^_", "")
    vim.cmd("normal! diwi" .. snake_case)
end, {})

-- Переводит название сущности в camel case
api.nvim_create_user_command('CamalCase', function(opts)
    local current_word = vim.fn.expand("<cword>")
    -- change case to camal case
    local camal_case = current_word:gsub("_(.)", string.upper):gsub("^(.)",
                                                                    string.upper)
    vim.cmd("normal! diwi" .. camal_case)
end, {})

-- Обращение snake case в camel case и наоборот
api.nvim_create_user_command('ToggleCase', function(opts)
    local current_word = vim.fn.expand("<cword>")
    if current_word:match("_") then
        vim.cmd("CamalCase")
    else
        vim.cmd("SnakeCase")
    end
end, {})
