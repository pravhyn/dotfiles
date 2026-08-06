local utility = require("utils.buffer")

local pid = vim.loop.getpid()
local path = utility.root_path("/nvim.txt")

if path == nil then
        vim.notify("warning root path is nil")
        return
end
local f = io.open(path, "r")

if not f then
        -- f:close()
        local file = io.open(path, "w")
        file:write("Hello")
        file:close()
end

local function append_line(path, content)
        local f = io.open(path, "a")

        if not f then
                f:close()
                vim.notify("file doens't exist at given path")
                return
        end

        vim.notify("creating the file")

        local file = io.open(path, "a")

        if file == nil then
                vim.notify("file creation failed, file is nil")
                return
        end
        file:write("\n" .. content)
        file:close()
end

-- vim.g.instance_id = vim.loop.getpid() .. "-" .. vim.loop.hrtime()
-- mark the logs for each source

local function mark_log(bufnr)
        local absolute_path = "'" .. utility.buf_abspath(bufnr) .. "'"
        local time_date = utility.time_str() .. "-" .. utility.date_str()
        local prepared_log = "Log by-"
                .. pid
                .. " "
                .. time_date
                .. " "
                .. absolute_path
                .. " "
                .. "sourced By: "
                .. pid

        append_line(path, prepared_log)
end

mark_log(0)

local function parse_pids(line)
        local pids = {}

        -- extract part after "By:"
        local tail = line:match("By:%s*(.+)")
        if not tail then
                return pids
        end

        -- split by comma
        for pid in tail:gmatch("([^,%s]+)") do
                table.insert(pids, pid)
        end

        return pids
end

local function source_files(path)
        local lines = vim.fn.readfile(path)

        local not_sourced_lines = {}

        for line in lines do
                local pids_coll = parse_pids(line)

                if not pids_coll[pid] then
                        table.insert(not_sourced_lines, line)
                end
        end

        local paths = {}

        for line in not_sourced_lines do
                line:match(line, "'(^['])")
        end
end
