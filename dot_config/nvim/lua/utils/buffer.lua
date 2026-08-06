---@class Buf
M = M or {}

local uv = vim.uv
local fn = vim.fn

local markers = {
        ".git",
        "pyproject.toml",
        "package.json",
        "go.mod",
        "Makefile",
}

-- buffer name only (no path, no extension)
function M.name(buf)
        buf = buf or 0
        local full = vim.api.nvim_buf_get_name(buf)
        if full == "" then
                return ""
        end
        return vim.fn.fnamemodify(full, ":t:r")
end

--- checks if bufnr exists or not
---@param buf number -- bufnr to check
---@return boolean
function M.buf_exist(buf)
        if vim.api.nvim_buf_is_valid(buf) then
                return true
        end

        return false
end

--- use for checking fileTypes
---@param buf? integer -- Optional Buf no (0 = current Buffer)
---@return string --- ex "python", "lua"
function M.ft(buf)
        buf = buf or 0
        return vim.bo[buf].filetype or ""
end
function M.filename(buf)
        buf = buf or 0
        local full = vim.api.nvim_buf_get_name(buf)
        return full ~= "" and vim.fn.fnamemodify(full, ":t") or ""
end

function M.get_buf_parent_dir(buf, rec)
        buf = buf or 0 -- default to current buffer

        local name = vim.api.nvim_buf_get_name(buf)
        if name == "" then
                return nil -- unnamed buffer (No Name, help, terminal, etc.)
        end

        -- Normalize path and get parent
        local dir = vim.fn.fnamemodify(name, ":p:h")
        return dir
end

function M.is_root_dir(buf)
        buf = buf or 0

        local dir = vim.fn.expand("%:p:h")
        if dir == "" then
                return nil
        end

        while dir do
                for _, marker in ipairs(markers) do
                        local path = dir .. "/" .. marker

                        if vim.fn.isdirectory(path) == 1 or vim.fn.filereadable(path) == 1 then
                                return true
                        end
                end
        end

        return false
end

local function flash_selection(start_line, start_col, end_line, end_col)
        local ns = vim.api.nvim_create_namespace("transform_flash")

        vim.highlight.range(
                0, -- current buffer
                ns,
                "IncSearch", -- or "Visual", "Search", etc.
                { start_line - 1, start_col - 1 },
                { end_line - 1, end_col },
                {}
        )

        vim.defer_fn(function()
                vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
        end, 2000)
end

function M.get_visual_selection()
        local mode = vim.fn.visualmode()

        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)

        vim.wait(0)
        -- Line-wise Visual (V)
        if mode == "V" then
                print()
                local _, start_line = unpack(vim.fn.getpos("'<"))
                local _, end_line = unpack(vim.fn.getpos("'>"))
                flash_selection(start_line, 1, end_line, #vim.fn.getline(end_line))
                local lines = vim.fn.getline(start_line, end_line)
                return table.concat(lines, "\n"), start_line, end_line
        end

        -- Character-wise Visual (v)
        local _, start_line, start_col = unpack(vim.fn.getpos("'<"))
        local _, end_line, end_col = unpack(vim.fn.getpos("'>"))
        flash_selection(start_line, start_col, end_line, end_col)
        local lines = vim.fn.getline(start_line, end_line)

        if #lines == 0 then
                return ""
        end

        lines[1] = string.sub(lines[1], start_col)
        lines[#lines] = string.sub(lines[#lines], 1, end_col)

        return table.concat(lines, "\n")
end
function M.copy(text)
        vim.fn.setreg("+", text)
end

function M.ensure_dir(path)
        if not uv.fs_stat(path) then
                uv.fs_mkdir(path, 493) -- 755
        end
end

function M.read_file(path)
        local fd = uv.fs_open(path, "r", 438)
        if not fd then
                return nil
        end
        local stat = uv.fs_fstat(fd)
        local data = uv.fs_read(fd, stat.size, 0)
        uv.fs_close(fd)
        return data
end

function M.write_file(path, content)
        local fd = uv.fs_open(path, "w", 438)
        if not fd then
                return false
        end

        uv.fs_write(fd, content, 0)
        uv.fs_close(fd)
        return true
end

--- closes the current float, return the buf inside the win
---@return number
function M.hide_float()
        local win = vim.api.nvim_get_current_win()
        local cfg = vim.api.nvim_win_get_config(win)

        if cfg.relative == "" then
                return -- not a float
        end

        local buf = vim.api.nvim_win_get_buf(win)

        -- mark buffer as hidden but alive
        vim.bo[buf].bufhidden = "hide"

        -- close only the window
        vim.api.nvim_win_close(win, true)

        return buf
end

function M.project_root()
        -- Start from directory of current file
        local dir = vim.fn.expand("%:p:h")
        if dir == "" then
                return nil
        end

        while dir do
                for _, marker in ipairs(markers) do
                        local path = dir .. "/" .. marker
                        if vim.fn.isdirectory(path) == 1 or vim.fn.filereadable(path) == 1 then
                                return dir
                        end
                end

                local parent = vim.fn.fnamemodify(dir, ":h")
                if parent == dir then
                        break
                end
                dir = parent
        end

        return nil
end

function M.root_path(sub_path)
        local root = M.project_root()

        if root == nil then
                print("warning it's nil")
                return
        end
        return vim.fs.joinpath(root, sub_path or "")
end
function M.buf_abspath(bufnr)
        bufnr = bufnr or 0
        return vim.api.nvim_buf_get_name(bufnr)
end

function M.time_str()
        return os.date("%H:%M:%S")
end

function M.date_str()
        return os.date("%Y-%m-%d")
end

local function read_lines(path)
        return vim.fn.readfile(path)
end

function M.find_in_root(name, opts)
        opts = opts or {}
        local root = M.project_root()
        if not root then
                return nil
        end

        local results = vim.fs.find(name, {
                path = root,
                limit = opts.limit or 1,
                type = opts.type or "file", -- "file" | "directory"
        })

        return results[1]
end

return M
