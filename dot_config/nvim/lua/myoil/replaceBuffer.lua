local oil = require("oil")

local function smart_oil_open()
  if vim.bo.modified then
    vim.ui.select({ "Yes", "No", "Cancel" }, {
      prompt = "You've got unsaved changes. Save before switching?",
    }, function(choice)
      if choice == "Yes" then
        vim.cmd("write")
      elseif choice == "Cancel" then
        return
      end
      -- Close current buffer
      vim.cmd("bdelete")
      -- Open oil in current window (replacing buffer)
      oil.open()
    end)
  else
    vim.cmd("bdelete")
    oil.open()
  end
end

vim.keymap.set("n", "<leader>E", smart_oil_open, { desc = "Replace Buffer with Oil (with Save Prompt)" })