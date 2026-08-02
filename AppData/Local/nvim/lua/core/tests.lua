local M = {}

local function get_visual_selection()
        local _, ls, cs = unpack(vim.fn.getpos("'<"))
        local _, le, ce = unpack(vim.fn.getpos("'>"))

        local lines = vim.fn.getline(ls, le)
        if #lines == 0 then
                return ""
        end

        lines[#lines] = string.sub(lines[#lines], 1, ce)
        lines[1] = string.sub(lines[1], cs)

        return table.concat(lines, "\n")
end

local function get_buf_parent_dir(buf)
        local name = vim.api.nvim_buf_get_name(buf)
        if name == "" then
                return vim.loop.cwd()
        end
        return vim.fs.dirname(vim.fs.normalize(name))
end

function M.bufrun()
        local code = get_visual_selection()
        if code == "" then
                print("No visual selection")
                return
        end

        local dir = get_buf_parent_dir(0)
        local filename = dir .. "/.nvim_bufrun_" .. os.time() .. ".lua"

        -- write file
        local f = io.open(filename, "w")
        f:write(code)
        f:close()

        -- open it
        vim.cmd("vsplit " .. vim.fn.fnameescape(filename))

        -- buffer-local keymap: Y to run
        vim.keymap.set("n", "Y", function()
                vim.cmd("w")
                print("Running " .. filename)
                vim.cmd("luafile " .. vim.fn.fnameescape(filename))

                -- delete file
                os.remove(filename)

                -- close buffer
                vim.cmd("bd!")
        end, { buffer = true })

        print("BufRun ready. Edit, then press Y to run.")
end

local function py_bufrun()
        local function get_visual_selection()
                local _, ls, cs = unpack(vim.fn.getpos("'<"))
                local _, le, ce = unpack(vim.fn.getpos("'>"))

                local lines = vim.fn.getline(ls, le)
                if #lines == 0 then
                        return ""
                end

                lines[#lines] = string.sub(lines[#lines], 1, ce)
                lines[1] = string.sub(lines[1], cs)

                return table.concat(lines, "\n")
        end

        local function get_buf_parent_dir(buf)
                local name = vim.api.nvim_buf_get_name(buf)
                if name == "" then
                        return vim.loop.cwd()
                end
                return vim.fs.dirname(vim.fs.normalize(name))
        end

        local code = get_visual_selection()
        if code == "" then
                print("No visual selection")
                return
        end

        local dir = get_buf_parent_dir(0)
        local filename = dir .. "/.nvim_bufrun_" .. os.time() .. ".py"

        -- write file
        local f = io.open(filename, "w")
        f:write(code)
        f:close()

        -- open scratch file
        vim.cmd("vsplit " .. vim.fn.fnameescape(filename))

        -- output buffer
        local function get_output_buf()
                local name = "__PyBufRun_Output__"
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                        if vim.api.nvim_buf_get_name(buf):match(name) then
                                return buf
                        end
                end

                vim.cmd("botright split")
                local buf = vim.api.nvim_get_current_buf()
                vim.api.nvim_buf_set_name(buf, name)
                vim.bo[buf].buftype = "nofile"
                vim.bo[buf].bufhidden = "wipe"
                vim.bo[buf].swapfile = false
                return buf
        end

        -- buffer-local keymap: Y to run
        vim.keymap.set("n", "Y", function()
                vim.cmd("w")
                print("Running " .. filename)

                local out_buf = get_output_buf()
                vim.api.nvim_buf_set_lines(out_buf, 0, -1, false, {
                        ">>> Running " .. filename,
                        "",
                })

                vim.fn.jobstart({ "python", filename }, {
                        stdout_buffered = true,
                        stderr_buffered = true,

                        on_stdout = function(_, data)
                                if data then
                                        vim.api.nvim_buf_set_lines(out_buf, -1, -1, false, data)
                                end
                        end,

                        on_stderr = function(_, data)
                                if data then
                                        vim.api.nvim_buf_set_lines(out_buf, -1, -1, false, data)
                                end
                        end,

                        on_exit = function()
                                vim.api.nvim_buf_set_lines(out_buf, -1, -1, false, {
                                        "",
                                        ">>> Done.",
                                })
                                os.remove(filename)
                        end,
                })
        end, { buffer = true })

        print("PyBufRun ready. Edit, press Y to run, see output below.")
end

Snacks.keymap.set("v", "<leader>br", function()
        M.bufrun()
end, { ft = "lua", desc = "BufRun: run visual Lua" })

Snacks.keymap.set("v", "<leader>br", function()
        py_bufrun()
end, { ft = "python", desc = "BufRun: run visual python" })
