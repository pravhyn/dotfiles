-- Example: Customize how diagnostics are shown
vim.diagnostic.config({
        virtual_text = {
                spacing = 4,
                severity = vim.diagnostic.severity.ERROR, -- Only show errors inline
                source = "if_many", -- Show source only if multiple
        },
        signs = false,
        underline = true,
        update_in_insert = true, -- Avoid spam during insert mode
        severity_sort = true,
        float = {
                border = "rounded",
                source = true, --always
                header = "",
                prefix = "",
        },
})
