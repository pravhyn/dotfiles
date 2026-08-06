local M = {}

---@param source string
---@param regex string   -- Lua pattern
---@param replace string
---@return string result
---@return integer count
function M.replace_text(source, regex, replace)
        if type(source) ~= "string" then
                error("source must be a string")
        end
        if type(regex) ~= "string" then
                error("regex must be a string")
        end
        if type(replace) ~= "string" then
                error("replace must be a string")
        end

        if regex == "" then
                return source, 0
        end

        local ok, result, count = pcall(function()
                return source:gsub(regex, replace)
        end)

        if not ok then
                error("Invalid Lua regex: " .. regex)
        end

        return result, count
end

return M
