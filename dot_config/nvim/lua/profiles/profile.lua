local M = {}

local path_config_file = vim.fn.stdpath("config") .. "\\lua\\profiles\\paths.json"
_G.USER_PATHS = {} -- global for access anywhere

-- ✨ Utility: Validate if a directory path exists
local function is_valid_path(path)
	return vim.fn.isdirectory(path) == 1
end

-- ✨ Prompt user for a directory path

local function prompt_for_path(labels, callback)
	local telescope = require("telescope.builtin")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local label = labels[1]
	labels[1] = nil

	telescope.find_files({
		prompt_title = "Select folder for " .. label,
		cwd = vim.fn.expand("~"),
		find_command = { "fd", "--type", "d", "--hidden", "--exclude", ".git" },
		attach_mappings = function(bufnr, map)
			map("i", "<CR>", function()
				local entry = action_state.get_selected_entry()
				local folder_path = entry and entry[1]
				if folder_path and is_valid_path(folder_path) then
					if #labels > 0 then
						prompt_for_path(labels)
					elseif #labels == 0 then
						callback()
					end
					USER_PATHS[label] = folder_path
					vim.notify("Path for " .. label .. " set to:\n" .. folder_path,
						vim.log.levels.INFO)
				else
					vim.notify("Invalid folder selected for " .. label, vim.log.levels.ERROR)
				end
				actions.close(bufnr)
			end)
			return true
		end,
	})
end

-- 🚀 Setup function for user initialization or reconfiguration
function M.setup()
	local paths_exist = vim.fn.filereadable(path_config_file) == 1
	local decoded = {}

	if paths_exist then
		local raw = table.concat(vim.fn.readfile(path_config_file), "\n")
		decoded = vim.fn.json_decode(raw)

		local needs_reset = false
		for key, path in pairs(decoded) do
			if not is_valid_path(path) then
				vim.notify("⚠️ Saved path '" .. key .. "' is no longer valid: " .. path,
					vim.log.levels.WARN)
				needs_reset = true
				break
			end
		end

		if not needs_reset then
			USER_PATHS = decoded
			vim.notify("✅ Paths loaded successfully.")
			return
		else
			vim.notify("🔄 Some paths are broken. Starting setup again.")
		end
	else
		vim.notify("🆕 First-time setup initiated: profile paths")
	end
	-- Save once all inputs have landed
	local function save_the_files()
		vim.defer_fn(function()
			local encoded = vim.fn.json_encode(USER_PATHS)
			vim.fn.writefile({ encoded }, path_config_file)
			vim.notify("💾 Saved paths.json successfully.")
		end, 300) -- delay ensures input completes
	end
	-- Prompt for fresh paths

	local no_of_paths = { "projects", "downloads" }
	prompt_for_path(no_of_paths, save_the_files)
	-- prompt_for_path("dotfiles") -- optional but useful
	-- prompt_for_path("workspace") -- another general fallback
end

return M
