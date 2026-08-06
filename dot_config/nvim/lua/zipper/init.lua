-- zipper/init.lua
local core = require("zipper.core")

-- Create a user command :Zip
vim.api.nvim_create_user_command("Zip", function()
	core.run()
end, {})

return core
