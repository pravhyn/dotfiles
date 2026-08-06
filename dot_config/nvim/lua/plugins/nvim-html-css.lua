return{
  "Jezda1337/nvim-html-css",
  ft = { "css", "scss", "less" },
  config = function()
    local scan_paths = vim.fn.globpath("./src", "**/*.{html,jsx,tsx}", true, true)
    local public_paths = vim.fn.globpath("./public", "**/*.html", true, true)
    local all_paths = vim.tbl_extend("force", scan_paths, public_paths)

    require("html-css"):setup({
      filetypes = {
        "html", "javascriptreact", "typescriptreact", "svelte", "vue",
      },
      style_sheets = all_paths,
    })
  end,
} 