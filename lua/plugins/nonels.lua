local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")
local methods = require("null-ls.methods")

local flake8 = {
    name = "flake8",
    method = methods.internal.DIAGNOSTICS,
    filetypes = {"python", "py"},
    generator = null_ls.generator({
        command = "flake8",
        args = {
            "--config", vim.fn.stdpath("config") .. "/plugin_configs/.flake8",
            "$FILENAME"
        },
        -- choose an output format (raw, json, or line)
        format = "line",
        check_exit_code = function(code, stderr)
            local success = code <= 1
            if not success then
                -- can be noisy for things that run often (e.g. diagnostics), but can
                -- be useful for things that run on demand (e.g. formatting)
                print(stderr)
            end
            -- print("success", success)
            return success
        end,
        -- use helpers to parse the output from string matchers,
        -- or parse it manually with a function
        on_output = helpers.diagnostics.from_patterns({
            {
                pattern = [[(%g+):(%d+):(%d+): ([%w%d]+) (.*)]],
                groups = {"filename", "row", "col", "code", "message"}
            }
        })
    })
}

local lua_format = {
    name = "lua_format",
    filetypes = {"lua"},
    method = methods.internal.FORMATTING,
    generator = null_ls.generator({
        command = "lua-format",
        to_stdin = false,
        to_temp_file = true, -- чтобы использовать временный файл, в которй сохраняетя буфер, далее этот файл будет подан на вход форматеру(так сделано потому что у lua_format нет параметров для принятия данных по stdin - через stdin обычно передается содержимое буфера)
        args = {
            "--config",
            vim.fn.stdpath("config") .. "/plugin_configs/lua-format.yaml",
            "$FILENAME"
        },
        output = "raw",
        on_output = function(params, done)
            local output = params.output
            -- print(output)
            return done({{text = output}})
        end
    })
}

--[[
:NullLsInfo
:NullLsLog
--]]
null_ls.register(flake8)
null_ls.register(lua_format)

null_ls.setup({
    sources = {
        -- null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.formatting.clang_format.with({
            extra_args = {
                -- https://clang.llvm.org/docs/ClangFormatStyleOptions.html
                string.format("--style=file:%s", vim.fn.stdpath("config") ..
                                  "/plugin_configs/.clang-format")
            }
        }), null_ls.builtins.formatting.black.with({filetypes = {"python"}}),
        null_ls.builtins.formatting.isort.with({
            filetypes = {"python"},
            extra_args = {
                string.format("--settings-path=%s", vim.fn.stdpath("config") ..
                                  "/plugin_configs/.isort.cfg")
            }
        }), null_ls.builtins.diagnostics.pylint.with({
            extra_args = {

                string.format("--rcfile=%s", vim.fn.stdpath("config") ..
                                  "/plugin_configs/.pylintrc")
            }

        }), null_ls.builtins.formatting.shfmt.with({
            extra_args = {"-i", "2", "-ci"},
            filetypes = {"bash", "sh"}
        }), null_ls.builtins.formatting.prettierd.with({
            filetypes = {"html", "json", "yaml", "markdown"}
        })
    },

    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        bufnr = bufnr,
                        filter = function(client)
                            return client.name == "null-ls"
                        end
                    })
                end
            })
        end
    end
})
