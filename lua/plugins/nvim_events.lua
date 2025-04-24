local api = vim.api
local uv = vim.uv or vim.loop

-- Опрашиваем систему на предмет нажатия capslock
local function is_capslock()
    local cmd = "xset q 2> /dev/null | grep 'LED' | awk '{print $NF}'"
    -- 00000000 capslock turns off
    -- 00000001 capslock turns on
    local output = tonumber(vim.trim(vim.fn.system(cmd)))
    -- print(output)
    return output
end

-- Меняем состояние FoldColumn (вертикальная столбец в редакторе, находящийся слева) по нажатию
-- на capslock
local function change_fold_column()
    local bg_capslock = "#d72323"
    local bg_cterm = 70
    local bg_capslock_trim = string.gsub(bg_capslock, '#', '')
    local bg_capslock_int = tonumber(bg_capslock_trim, 16)
    local capslock_hl = {ctermbg = bg_cterm, bg = bg_capslock}
    local default_hl = {ctermbg = bg_cterm, bg = "#5a524c"}
    local timer = uv.new_timer()
    timer:start(0, 1000, vim.schedule_wrap(function()
        local is_caps_on = is_capslock()
        local cur_hl = api.nvim_get_hl(0, {name = 'FoldColumn'})
        -- print(string.format("capslock %s ", is_caps_on))
        if is_caps_on == 1 then
            -- capslock on
            if cur_hl.bg ~= bg_capslock_int then
                -- если цветовая схема не соответствует подсветки для capslock - включаем ее
                api.nvim_set_hl(0, "FoldColumn", capslock_hl)
            end
        else
            -- capslock off
            if cur_hl.bg == bg_capslock_int then
                -- выключаем подсветку для capslock
                -- print("caps off")
                api.nvim_set_hl(0, "FoldColumn", default_hl)
            end
        end

    end))
end

change_fold_column()
