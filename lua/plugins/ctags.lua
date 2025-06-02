-- после записи всего буфера в файл вызываем утилиту ctags
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = {"*.go", "*.py", "*.c", "*.h"},
    callback = function()
        vim.system({
            'ctags', '--exclude=.git', '--exclude=.env', '--exclude=.idea',
            '--exclude=.venv', '--exclude=.vscode', '--exclude=.mypy_cache',
            '--exclude=.ruff_cache', '-R', '--fields=+ne',
            '--languages=C,C++,Python,Go,Lua,Sh'
        })
    end
})
