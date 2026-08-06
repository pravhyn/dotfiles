local M = {}
local last_yank_type = ""
vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
                local event = vim.v.event

                if event.operator ~= "y" then
                        return
                end

                if event.regtype == "v" then
                        last_yank_type = "󰆏 Char"
                elseif event.regtype == "V" then
                        last_yank_type = "󰆏 Line"
                else
                        last_yank_type = "󰆏 Block"
                end

                require("lualine").refresh()
        end,
})

local function yank_type()
        return last_yank_type
end

local function macro_recording()
        local reg = vim.fn.reg_recording()
        if reg == "" then
                return ""
        end
        return "● REC @" .. reg
end

local function total_buffers()
        local count = 0
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
                        count = count + 1
                end
        end
        return "Bufs: " .. count
end

local function previous_buffer_name()
        local current = vim.api.nvim_get_current_buf()
        local buffers = vim.fn.getbufinfo({ buflisted = 1 })
        local prev_buf = nil

        for i, bufinfo in ipairs(buffers) do
                if bufinfo.bufnr == current then
                        prev_buf = buffers[i - 1] -- get previous in list
                        break
                end
        end

        if prev_buf and prev_buf.name ~= "" then
                local name = vim.fn.fnamemodify(prev_buf.name, ":t") -- filename only
                return "< " .. name
        else
                return ""
        end
end

local function next_buffer_name()
        local current = vim.api.nvim_get_current_buf()
        local buffers = vim.fn.getbufinfo({ buflisted = 1 })
        local next_buf = nil

        for i, bufinfo in ipairs(buffers) do
                if bufinfo.bufnr == current then
                        next_buf = buffers[i + 1] -- get next in list
                        break
                end
        end

        if next_buf and next_buf.name ~= "" then
                local name = vim.fn.fnamemodify(next_buf.name, ":t") -- filename only
                return name .. " >"
        else
                return ""
        end
end

function M.setup()
        local function lsp_status()
                local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
                if #clients == 0 then
                        return "🛑 No LSP"
                end
                local names = {}
                for _, client in ipairs(clients) do
                        table.insert(names, client.name)
                end
                -- return "🚀 " .. table.concat(names, ", ")
                return table.concat(names, ", ")
        end

        require("lualine").setup({
                options = {
                        theme = "dracula", -- picks theme from current colorscheme
                        section_separators = { left = "", right = "" },
                        component_separators = { left = "", right = "" },
                        globalstatus = true, -- single statusline for all windows
                },
                sections = {
                        lualine_a = { { "mode", icon = "" } },
                        lualine_b = { "branch", "diff" },
                        -- lualine_c = {
                        --         {
                        --                 "filename",
                        --                 path = 1, -- relative path
                        --                 symbols = { modified = "[+]", readonly = "[RO]", unnamed = "[No Name]" },
                        --         },
                        --
                        --         color = function()
                        --                 -- Check diagnostics in current buffer
                        --                 local diagnostics = vim.diagnostic.get(0)
                        --
                        --                 for _, d in ipairs(diagnostics) do
                        --                         if d.severity == vim.diagnostic.severity.ERROR then
                        --                                 return { fg = "#e86671", gui = "bold" }
                        --                         elseif d.severity == vim.diagnostic.severity.WARN then
                        --                                 return { fg = "#d19a66", gui = "bold" }
                        --                         end
                        --                 end
                        --
                        --                 -- Check if buffer is modified
                        --                 if vim.bo.modified then
                        --                         return { fg = "#e5c07b", gui = "bold" } -- 🟡 yellow
                        --                 end
                        --
                        --                 return nil -- default lualine color
                        --         end,
                        -- },

                        lualine_c = {
                                {
                                        "filename",
                                        path = 1, -- relative path
                                        symbols = {
                                                modified = "[+]",
                                                readonly = "[RO]",
                                                unnamed = "[No Name]",
                                        },

                                        color = function()
                                                -- Ignore non-file buffers (optional but recommended)
                                                if vim.bo.buftype ~= "" then
                                                        return { fg = "#8be9fd" } -- Dracula cyan
                                                end

                                                -- Diagnostics first (highest priority)
                                                local diagnostics = vim.diagnostic.get(0)

                                                for _, d in ipairs(diagnostics) do
                                                        if d.severity == vim.diagnostic.severity.ERROR then
                                                                return { fg = "#ff5555", gui = "bold" } -- red
                                                        elseif d.severity == vim.diagnostic.severity.WARN then
                                                                return { fg = "#ffb86c", gui = "bold" } -- orange
                                                        end
                                                end

                                                -- Modified buffer
                                                if vim.bo.modified then
                                                        return { fg = "#f1fa8c", gui = "bold" } -- yellow
                                                end

                                                -- ✅ Default (clean buffer)
                                                return { fg = "#50fa7b" } -- green/cyan-ish (Dracula green)
                                        end,
                                },
                        },
                        lualine_x = {
                                yank_type,
                                previous_buffer_name,
                                total_buffers,
                                next_buffer_name,
                                -- "encoding",
                                -- "fileformat",
                                -- "filetype",
                        },
                        lualine_y = {
                                {
                                        macro_recording,
                                        color = { fg = "#ff5555", gui = "bold" }, -- Dracula red
                                },
                                -- "progress", -- show the progress based on the line number
                                {
                                        lsp_status,
                                        color = { fg = "#e5c07b" },
                                },
                        },
                        lualine_z = {
                                -- { "location", icon = "" },
                                { "location" },
                        },
                },
                inactive_sections = {
                        lualine_a = {},
                        lualine_b = {},
                        lualine_c = { "filename" },
                        lualine_x = { "location" },
                        lualine_y = {},
                        lualine_z = {},
                },
                extensions = { "quickfix", "nvim-tree", "fugitive", "lazy" },
        })
end

return M
