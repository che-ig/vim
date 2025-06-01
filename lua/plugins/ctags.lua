-- после записи всего буфера в файл вызываем утилиту ctags
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = {"*.go", "*.py", "*.c", "*.h"},
    callback = function()
        -- vim.fn.system({'ctags', '-R', '--exclude=.git', '*.go'})
        vim.fn.system( -- {
        --     'ctags', '-R', '−f *.c', '−f *.go', '−f *.py',
        --     '--exclude=.git', '--exclude=*.sql'
        -- }
        {
            'ctags',
            '--exclude={.git/*,.env/*,.idea/*,.venv/*,.vscode/*,.mypy_cache/*,.ruff_cache/*}',
            '-R', '--fields=+ne', '--languages=C,C++,Python,Go,Lua,Sh'
        })
    end
})
