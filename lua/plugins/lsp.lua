local lsp_common = require("plugins.lsp_common")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Sntup language servers.
-- https://github.com/microsoft/pyright/blob/main/docs/settings.md
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {
    capabilities = capabilities,
    on_attach = lsp_common.on_attach,
    --[[ Determines if a server is
    started without a matching root directory. See lspconfig-single-file-support. ]]
    single_file_support = true,
    settings = {
        python = {
            pythonPath = "/home/che/.cache/pypoetry/virtualenvs/poetry-temp-R4LpgGoU-py3.10/bin/python",
            analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly", -- openFilesOnly, workspace
                typeCheckingMode = "basic", -- off, basic, strict
                useLibraryCodeForTypes = true
            }
        }
    }
}

lspconfig.ts_ls.setup {}
lspconfig.prismals.setup {}
lspconfig.cssls.setup {capabilities = capabilities}

-- https://clangd.llvm.org/installation.html
lspconfig.clangd.setup {
    capabilities = capabilities,
    on_attach = lsp_common.on_attach,
    cmd = {"clangd", "--offset-encoding=utf-16"}
}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
-- https://luals.github.io/wiki/formatter/
lspconfig.lua_ls.setup {
    capabilities = capabilities,
    on_attach = lsp_common.on_attach,
    -- enabled = false,
    single_file_support = true,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
            },

            workspace = {checkThirdParty = false},
            completion = {
                enable = true,
                workspaceWord = true,
                callSnippet = "Both"
            },
            misc = {
                parameters = {
                    -- "--log-level=trace",
                }
            },
            hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "All",
                semicolon = "All",
                arrayIndex = "Disable"
            },
            doc = {privateName = {"^_"}},
            type = {castNumberToInteger = true},
            diagnostics = {
                enable = true,
                disable = {"incomplete-signature-doc", "trailing-space"},
                -- enable = false,
                groupSeverity = {strong = "Warning", strict = "Warning"},
                groupFileStatus = {
                    ["ambiguity"] = "Opened",
                    ["await"] = "Opened",
                    ["codestyle"] = "None",
                    ["duplicate"] = "Opened",
                    ["global"] = "Opened",
                    ["luadoc"] = "Opened",
                    ["redefined"] = "Opened",
                    ["strict"] = "Opened",
                    ["strong"] = "Opened",
                    ["type-check"] = "Opened",
                    ["unbalanced"] = "Opened",
                    ["unused"] = "Opened"
                },
                unusedLocalExclude = {"_*"},
                globals = {'vim'}

            },
            format = {
                enable = false,
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "4",
                    continuation_indent_size = "4"
                }
            }
        }
    }

}

lspconfig.gopls.setup {
    cmd = {'gopls'},
    -- for postfix snippets and analyzers
    capabilities = capabilities,
    settings = {
        -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
        -- https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
        -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
        -- https://github.com/golang/tools/blob/master/gopls/doc/inlayHints.md
        gopls = {
            experimentalPostfixCompletions = true,
            gofumpt = true,
            codelenses = {
                gc_details = true,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true
            },

            analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
                shadow = true
                -- simplifyslice = true
            },
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = {
                "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules"
            },
            semanticTokens = true

        }
    },
    on_attach = lsp_common.on_attach
}

-- vim.lsp.set_log_level("debug")
