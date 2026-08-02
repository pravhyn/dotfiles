local M = {}

local function is_file(p)
        return p and vim.fn.filereadable(p) == 1
end

local function is_dir(p)
        return p and vim.fn.isdirectory(p) == 1
end

local function expand(p)
        return vim.fn.expand(p)
end

local function scan_dir_for_python(dir)
        local results = {}
        local handle = vim.loop.fs_scandir(dir)
        if not handle then
                return results
        end

        while true do
                local name, t = vim.loop.fs_scandir_next(handle)
                if not name then
                        break
                end

                local full = dir .. "/" .. name
                if t == "directory" then
                        local exe = full .. "/python.exe"
                        if is_file(exe) then
                                table.insert(results, exe)
                        end
                end
        end

        return results
end

local function find_pythons()
        local cwd = vim.fn.getcwd()

        local paths = {
                cwd .. "/.venv/bin/python",
                cwd .. "/venv/bin/python",
                cwd .. "/env/bin/python",

                expand("~/AppData/Local/Programs/Python"),

                vim.fn.exepath("python3"),
                vim.fn.exepath("python"),
                "/usr/bin/python3",
                "/usr/bin/python",
        }

        local found = {}

        for _, p in ipairs(paths) do
                p = expand(p)

                if is_file(p) then
                        table.insert(found, p)
                elseif is_dir(p) then
                        local children = scan_dir_for_python(p)
                        for _, c in ipairs(children) do
                                table.insert(found, c)
                        end
                end
        end

        return found
end

function M.pick()
        local items = find_pythons()

        if #items == 0 then
                vim.notify("No Python interpreters found", vim.log.levels.WARN)
                return
        end

        vim.ui.select(items, {
                prompt = "Select Python interpreter:",
        }, function(choice)
                if not choice then
                        return
                end

                -- set for pyright
                -- require("lspconfig").pyright.setup({
                --         settings = {
                --                 python = {
                --                         pythonPath = choice,
                --                 },
                --         },
                -- })
                vim.lsp.config("basedpyright", {
                        settings = {
                                python = {
                                        pythonPath = choice,
                                },
                        },
                })

                vim.notify("Python LSP set to: " .. choice)
                vim.cmd("LspRestart")
        end)
end

vim.api.nvim_create_user_command("SwitchPythoninterpreter", function()
        M.pick()
end, { desc = "switches python interpreter" })

-- return M
