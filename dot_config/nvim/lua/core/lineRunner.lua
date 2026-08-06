local function run_one_liner()
        local line = vim.api.nvim_get_current_line()
        local ok, err = pcall(function()
                vim.cmd("lua " .. line)
        end)
        if not ok then
                vim.notify("Error: " .. err, vim.log.levels.ERROR)
        end
end

vim.keymap.set("n", "<leader>ln", run_one_liner)
