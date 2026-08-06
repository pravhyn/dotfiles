-- lua/dashboard/quotes.lua
local M = {}

function M.get_random_quote()
  local quote_path = vim.fn.stdpath("config") .. "/lua/dashboard/quotes.json"
  local ok, raw = pcall(vim.fn.readfile, quote_path)
  if not ok then return "⚠️ Failed to load quotes." end

  local json = vim.fn.json_decode(table.concat(raw, "\n"))
  if type(json) ~= "table" or #json == 0 then
    return "⚠️ No quotes found."
  end

  math.randomseed(os.time())
  return json[math.random(#json)]
end

return M

