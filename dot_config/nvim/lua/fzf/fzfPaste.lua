local function paste_from_line_picker()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local entries = {}

  for i, line in ipairs(lines) do
    table.insert(entries, string.format("%4d│ %s", i, line))
  end

  require("fzf-lua").fzf_exec(entries, {
    prompt = "📄 Paste Line from Buffer > ",
    winopts = {
      height = 0.75,
      width = 0.6,
      preview = {
        layout = "vertical",
        vertical = "up:50%",
      },
    },
    actions = {
      ["default"] = function(selected)
        local line_str = selected[1]:match("^(%d+)")
        local line_num = tonumber(line_str)
        if line_num then
          local content = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)
          vim.api.nvim_put(content, "l", true, true)
        else
          vim.notify("Could not parse line number", vim.log.levels.ERROR)
        end
      end,
    },
    preview = function(entry)
      local line_str = entry:match("^(%d+)")
      local line_num = tonumber(line_str)
      if line_num then
        local content = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)
        return content[1] or ""
      end
      return "Invalid line"
    end,
  })
end

vim.keymap.set("n", "<leader>flp", paste_from_line_picker, { desc = "📎 Paste line from fuzzy picker" })