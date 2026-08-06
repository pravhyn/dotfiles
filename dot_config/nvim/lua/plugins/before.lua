return {
        "bloznelis/before.nvim",
        config = function()
                local before = require("before")
                before.setup()

                -- Jump to previous entry in the edit history
                vim.keymap.set("n", "<C-k>", before.jump_to_last_edit, {})
                -- Jump to next entry in the edit history
                vim.keymap.set("n", "<C-j>", before.jump_to_next_edit, {})

                -- local api = vim.api
                --
                -- local function jump_to_prev_file_edit()
                --         local current_buf = api.nvim_get_current_buf()
                --         for i = #before.get_jumps(), 1, -1 do
                --                 local entry = before.get_jumps()[i]
                --                 if entry.bufnr ~= current_buf then
                --                         api.nvim_set_current_buf(entry.bufnr)
                --                         api.nvim_win_set_cursor(0, { entry.row, entry.col })
                --                         return
                --                 end
                --         end
                -- end
                --
                -- local function jump_to_next_file_edit()
                --         local current_buf = api.nvim_get_current_buf()
                --         for i, entry in ipairs(before.get_jumps()) do
                --                 if entry.bufnr ~= current_buf then
                --                         api.nvim_set_current_buf(entry.bufnr)
                --                         api.nvim_win_set_cursor(0, { entry.row, entry.col })
                --                         return
                --                 end
                --         end
                -- end
                --
                -- -- New cross-buffer jump mappings
                -- vim.keymap.set("n", "<leader>bh", jump_to_prev_file_edit, { desc = "Jump to previous file edit" })
                -- vim.keymap.set("n", "<leader>bl", jump_to_next_file_edit, { desc = "Jump to next file edit" })

                -- Look for previous edits in quickfix list
                vim.keymap.set("n", "<leader>oq", before.show_edits_in_quickfix, {})
                -- Look for previous edits in telescope (needs telescope, obviously)
                vim.keymap.set("n", "<leader>oe", before.show_edits_in_telescope, {})
        end,
}
