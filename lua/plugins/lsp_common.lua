local M = {}

M.on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = {noremap = true, silent = true}
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    -- Переход к определению слова (функции, переменной...) под курсором
    buf_set_keymap("n", "<leader>gd", "<Cmd>lua vim.lsp.buf.definition()<CR>",
                   opts)
    buf_set_keymap("n", "<leader>ga", "<Cmd>lua vim.lsp.buf.code_action()<CR>",
                   opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>",
                   opts)
    buf_set_keymap("n", "<leader>wa",
                   "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<leader>wr",
                   "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<leader>wl",
                   "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
                   opts)
    buf_set_keymap("n", "<leader>D",
                   "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    -- Переименование указанной сущности
    buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    -- Выводим в quickfix все упоминания искомого слова
    buf_set_keymap("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>",
                   opts)
    buf_set_keymap("n", "<leader>n",
                   '<cmd>lua vim.diagnostic.open_float(0, {scope="line"})<CR>',
                   opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", -- setloclist setqflist
                   opts)

    -- Set some keybinds conditional on server capabilities
    -- :lua vim.lsp.get_active_clients()[1].server_capabilities
    if client.server_capabilities.documentFormattingProvider then
        buf_set_keymap("n", "<leader>fo", "<cmd>lua vim.lsp.buf.format()<CR>",
                       opts)
    elseif client.server_capabilities.rangeFormatting then
        buf_set_keymap("n", "<leader>fr",
                       "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

end

return M
