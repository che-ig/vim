local diagnostic_severity = vim.diagnostic.severity
local diagnostic_signs = {
    [diagnostic_severity.ERROR] = "",
    [diagnostic_severity.WARN] = "",
    [diagnostic_severity.INFO] = "",
    [diagnostic_severity.HINT] = "󰌵"
}

local shorter_source_names = {
    ["Lua Diagnostics."] = "Lua",
    ["Lua Syntax Check."] = "Lua"
}
local function diagnostic_format(diagnostic)
    return string.format("%s %s (%s): %s",
                         diagnostic_signs[diagnostic.severity],
                         shorter_source_names[diagnostic.source] or
                             diagnostic.source, diagnostic.code,
                         diagnostic.message)
end

vim.diagnostic.config({
    virtual_text = {spacing = 4, prefix = "", format = diagnostic_format},
    signs = {text = diagnostic_signs},
    -- virtual_lines = {
    --   current_line = true,
    --   format = diagnostic_format,
    -- },
    underline = true,
    severity_sort = true
})
