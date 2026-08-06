buffer = require("../utils.buffer")
local file_runner = require("core/fileRunner")

local function transform()
        local home_buffer = vim.api.nvim_win_get_buf(0) -- get the home buffer
        local selection, start_line, end_line = buffer.get_visual_selection()

        local function make_template(selection)
                return string.format(
                        [[
# ===== Input =====

text = r"""\
%s
"""

lines = text.splitlines()

# ===== Your Code =====

def transform(text, lines):
    return text

# ===== Output =====

print(transform(text, lines))
        ]],
                        selection
                )
        end

        local function write_template(path, contents)
                local file = assert(io.open(path, "w"))

                file:write(contents)
                file:close()
        end

        local template = make_template(selection)
        local path = vim.fn.stdpath("cache") .. "/transform.py"
        write_template(path, template)

        vim.cmd("vsplit " .. path)

        local output = nil
        vim.keymap.set("n", "<leader>rU", function()
                output = file_runner.python_runner("output")
                local content = vim.split(output, "\n", { plain = true })
                vim.api.nvim_buf_set_lines(home_buffer, start_line, end_line, false, content)
        end, { buffer = true })
end

vim.keymap.set("x", "<leader>tt", transform, { desc = "Transform Selection" })
