local M = {}

function get_opts(custom_opts)
    local opts = {noremap = true, silent = true}
    if custom_opts then
        for k, v in pairs(custom_opts) do
            opts[k] = v
        end
    end
    return opts
end

M.on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>",
                   get_opts(
                       {
            desc = "Jumps to the declaration of the symbol under the cursor"
        }))
    -- Переход к определению слова (функции, переменной...) под курсором
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", get_opts(
                       {
            desc = "Jumps to the definition of the symbol under the cursor"
        }))
    buf_set_keymap("n", "<leader>ga", "<Cmd>lua vim.lsp.buf.code_action()<CR>",
                   get_opts())
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", get_opts({
        desc = "Displays hover information about the symbol under the cursor"
    }))
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>",
                   get_opts({
        desc = "Lists all the implementations for the symbol under the cursor in the quickfix window"
    }))
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>",
                   get_opts(
                       {
            desc = "Displays signature about the symbol under the cursor"
        }))
    buf_set_keymap("n", "<leader>wa",
                   "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", get_opts())
    buf_set_keymap("n", "<leader>wr",
                   "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
                   get_opts())
    buf_set_keymap("n", "<leader>wl",
                   "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
                   get_opts())
    buf_set_keymap("n", "<leader>D",
                   "<cmd>lua vim.lsp.buf.type_definition()<CR>", get_opts())
    -- Переименование указанной сущности
    buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>",
                   get_opts({desc = "rename symbol"}))
    -- Выводим в quickfix все упоминания искомого слова
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>",
                   get_opts({
        desc = "Lists all the references to the symbol under the cursor in the quickfix window"
    }))
    buf_set_keymap("n", "<leader>n",
                   '<cmd>lua vim.diagnostic.open_float(0, {scope="line"})<CR>',
                   get_opts(
                       {
            desc = "Displays diagnostic information in a float window"
        }))
    buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>",
                   get_opts())
    buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>",
                   get_opts())
    buf_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", -- setloclist setqflist
                   get_opts(
                       {desc = "Lists all diagnostics to the quickfix window"}))

    -- Set some keybinds conditional on server capabilities
    -- :lua vim.lsp.get_active_clients()[1].server_capabilities
    if client.server_capabilities.documentFormattingProvider then
        buf_set_keymap("n", "<leader>fo", "<cmd>lua vim.lsp.buf.format()<CR>",
                       get_opts())
    elseif client.server_capabilities.rangeFormatting then
        buf_set_keymap("n", "<leader>fr",
                       "<cmd>lua vim.lsp.buf.range_formatting()<CR>", get_opts())
    end

end

return M
