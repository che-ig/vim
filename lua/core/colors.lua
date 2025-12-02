-- берем цветовую палитру из эмулятора терминала.	
-- Enables 24-bit RGB color in the |TUI|.
vim.opt.termguicolors = true
function SetColor(color)
    color = color or "kanagawa" -- kanagawa onedark
    vim.cmd.colorscheme(color)

    -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#highlight
    -- создаем собственный глобальный (0) стиль подсветки
    vim.api.nvim_set_hl(0, 'MyComment', {ctermfg = 79, fg = "#767676"})
    vim.api.nvim_set_hl(0, 'MyFolded',
                        {ctermbg = 70, bg = "#005f5f", fg = "#ffd7af"})

    vim.api.nvim_set_hl(0, "Comment", {link = "MyComment"})
    vim.api.nvim_set_hl(0, "Folded", {link = "MyFolded"})
    -- Стили для строки под курсором
    vim.api.nvim_set_hl(0, "CursorLineNR", {
        ctermbg = 70,
        fg = "#f7a934",
        bg = "#373836",
        bold = true
    })
    -- Стиль для нумерации строк
    vim.api.nvim_set_hl(0, "LineNR", {ctermbg = 70, fg = "#b2b3af"})
    vim.api.nvim_set_hl(0, "CursorLine", {ctermbg = 70, bg = "#373836"})
    -- CursorLine     xxx ctermbg=236 guibg=#32302f
    -- CurSearch      xxx ctermfg=0 ctermbg=11 guifg=NvimDarkGrey1 guibg=NvimLightYellow
    -- Конфигурация результата поиска на котором находитя курсор
    vim.api.nvim_set_hl(0, "CurSearch",
                        {ctermbg = 70, bg = "#960610", fg = "#e6e8df"})

    -- Цвета меток для быстрого перехода по табам (для плагина BufferLine)
    vim.api.nvim_set_hl(0, "BufferLinePick", {ctermbg = 70, fg = "#f8fa89"})
    vim.api.nvim_set_hl(0, "BufferLinePickSelected",
                        {ctermbg = 70, fg = "#65fcfc"})
    -- Hop plugin
    -- Подсвечиваем символы к которым будет осуществляться переход
    vim.api.nvim_set_hl(0, "HopNextKey",
                        {ctermbg = 70, fg = "#FFFF00", bold = true})

    -- цветовое оформление активной строки в quickfix окон. 
    -- можно посмотреть при помощи команды (как пример) :grep bold и последующим 
    -- входом в quickfix окно через команду :copen
    -- vim.api.nvim_set_hl(0, "QuickFixLine", {
    --     ctermbg = 70,
    --     bg = "#d72323",
    --     fg = "#11cbd7",
    --     bold = true
    -- })

    -- цвет рамки плавающих окон
    -- vim.api.nvim_set_hl(0, "FloatBorder", {
    --     ctermbg = 70,
    --     bg = "#d72323",
    --     fg = "#11cbd7",
    --     bold = true
    -- })
    --
    -- рамка между вертикальными окнами
    vim.api.nvim_set_hl(0, "WinSeparator", {ctermbg = 70, fg = "#11cbd7"})

    -- подсветка метки для быстрых переходов
    vim.api.nvim_set_hl(0, "MarkSignHL", {ctermbg = 70, fg = "#aef9f5"})
    -- Подсветка парных скобок
    vim.api.nvim_set_hl(0, "MatchParen", {
        ctermbg = 70,
        fg = "yellow",
        bg = '#ba182b',
        bold = true
    })
    -- вертикальная полоса для фолдов
    -- hi FoldColumn guibg=#f44336 guifg=#9fc5e8 ctermfg=White ctermbg=Blue term=none cterm=none gui=none
end

SetColor('gruvbox-material')
