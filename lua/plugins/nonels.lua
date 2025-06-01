local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")
local methods = require("null-ls.methods")

-- local flake8 = {
--     name = "flake8",
--     method = methods.internal.DIAGNOSTICS,
--     -- method = DIAGNOSTICS_ON_SAVE,
--
--     filetypes = {"python"},
--     generator = null_ls.generator({
--         command = "flake8",
--         to_stdin = true,
--         args = {
--             "--config", vim.fn.stdpath("config") .. "/plugin_configs/.flake8",
--             "--stdin-display-name=$FILENAME", "-"
--         },
--         format = "line",
--         check_exit_code = function(code, stderr)
--             local success = code <= 1
--             if not success then
--                 print("Error", stderr)
--             end
--             return success
--         end,
--         on_output = helpers.diagnostics.from_patterns({
--             {
--                 pattern = [[(%g+):(%d+):(%d+): ([%w%d]+) (.*)]],
--                 groups = {"filename", "row", "col", "code", "message"}
--             }
--         })
--     })
-- }

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
local ruff_lint = {
    name = "ruff",
    meta = {url = "https://docs.astral.sh/ruff/tutorial/"},
    method = methods.internal.DIAGNOSTICS,
    filetypes = {"python"},
    generator = null_ls.generator({
        command = "ruff",
        to_stdin = true,
        args = {
            "check", "--config",
            vim.fn.stdpath("config") .. "/plugin_configs/ruff.toml",
            "--stdin-filename", "$FILENAME", "--quiet", "-"
        },
        format = "raw",
        check_exit_code = function(code, stderr)
            local success = code <= 1
            if not success then
                print(stderr)
            end
            return success
        end,

        on_output = function(params, done)
            local output = params.output
            if not output then
                return done()
            end

            local diagnostics = {}
            local severity = {error = 1, warning = 2, info = 3, hint = 4}

            for _, line in ipairs(vim.split(output, "\n")) do
                if line ~= "" then
                    local filename, row, col, code, message = line:match(
                                                                  "(%g+):(%d+):(%d+): ([%w%d]+) (.*)")
                    if message ~= nil then
                        table.insert(diagnostics, {
                            filename = filename,
                            row = row,
                            col = col,
                            code = code,
                            source = "ruff",
                            message = message,
                            severity = severity.warning
                        })
                    end
                end
            end
            done(diagnostics)
        end
    })
}

local ruff_format = {
    name = "ruff",
    meta = {url = "https://docs.astral.sh/ruff/formatter/#sorting-imports"},
    method = methods.internal.FORMATTING,
    filetypes = {"python"},
    generator = null_ls.generator({
        command = "ruff",
        to_stdin = true,
        args = {
            "format", "--config",
            vim.fn.stdpath("config") .. "/plugin_configs/ruff.toml",
            "--stdin-filename", "$FILENAME", "--quiet", "-"
        },
        format = "raw",
        check_exit_code = function(code, stderr)
            local success = code <= 1
            if not success then
                print("ruff_format_exit_code", stderr)
            end
            return success
        end,

        on_output = function(params, done)
            local output = params.output
            -- print("on_output_error", params.err)
            -- print(output)
            return done({{text = output}})
        end
    })
}

local ruff_format_sort_imports = {
    name = "ruff",
    meta = {url = "https://docs.astral.sh/ruff/formatter/#sorting-imports"},
    method = methods.internal.FORMATTING,
    filetypes = {"python"},
    generator = null_ls.generator({
        command = "ruff",
        to_stdin = true,
        args = {
            "check", "--select", "I", "--fix", "--stdin-filename", "$FILENAME",
            "--quiet", "-"
        },
        format = "raw",
        check_exit_code = function(code, stderr)
            local success = code <= 1
            if not success then
                print("ruff_format_exit_code", stderr)
            end
            return success
        end,

        on_output = function(params, done)
            local output = params.output
            -- print("on_output_sort_imports_error", params.err)
            -- print(output)
            return done({{text = output}})
        end
    })
}
--[[
:NullLsInfo
:NullLsLog
--]]
-- null_ls.register(flake8)
null_ls.register(lua_format)

null_ls.register(ruff_lint)
null_ls.register(ruff_format)
null_ls.register(ruff_format_sort_imports)
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
        }),
        -- null_ls.builtins.formatting.black.with({filetypes = {"python"}}),
        -- null_ls.builtins.formatting.isort.with({
        --     filetypes = {"python"},
        --     extra_args = {
        --         string.format("--settings-path=%s", vim.fn.stdpath("config") ..
        --                           "/plugin_configs/.isort.cfg")
        --     }
        -- }),
        -- null_ls.builtins.diagnostics.pylint.with({
        --     extra_args = {
        --
        --         string.format("--rcfile=%s", vim.fn.stdpath("config") ..
        --                           "/plugin_configs/.pylintrc")
        --     }
        --
        -- }),
        null_ls.builtins.formatting.shfmt.with({
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
