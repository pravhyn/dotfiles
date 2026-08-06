local function dynamic_file_transfer()
  local dest_dir = vim.fn.expand("%:p:h")
  dest_dir = vim.trim(dest_dir)
  vim.notify("Our destination is " .. dest_dir)
  if dest_dir == "" then
    vim.notify("Could not determine destination path", vim.log.levels.ERROR)
    return
  end

  local function copy_files(paths, target_dir)
    local loop = vim.loop
    loop.fs_mkdir(target_dir, 493) -- 0755

    for _, src in ipairs(paths) do
      local filename = vim.fn.fnamemodify(src, ":t")
      local dest = target_dir .. "/" .. filename

      local src_fd = loop.fs_open(src, "r", 438)
      if src_fd then
        local stat = loop.fs_fstat(src_fd)
        local data = loop.fs_read(src_fd, stat.size, 0)
        loop.fs_close(src_fd)

        local dest_fd = loop.fs_open(dest, "w", 438)
        loop.fs_write(dest_fd, data, 0)
        loop.fs_close(dest_fd)

        print("✅ Copied to:", dest)
      else
        print("⚠️ Failed to open:", src)
      end
    end
  end

  local scan = require("plenary.scandir")
  local fzf = require("fzf-lua")

  fzf.files({
    prompt = "Find a file",
    cwd = "C:/Users/prave/Projects",
    winopts = {
      height = 0.75,
      width = 0.5,
      preview = {
        layout = "vertical",
        vertical = "up:50%",
      },
    },
    actions = {
      ["default"] = function(selected)
        local selected_file_path = selected[1]
        local parent_dir = vim.fn.fnamemodify(selected_file_path, ":h")
        local total_files = scan.scan_dir(parent_dir, { depth = 3 })

        fzf.fzf_exec(total_files, {
          prompt = "Files Under that Folder > ",
          winopts = {
            height = 0.75,
            width = 0.5,
            preview = {
              layout = "vertical",
              vertical = "up:50%",
            },
          },
          actions = {
            ["default"] = function(selected_files)
              vim.notify("Selected files: " .. table.concat(selected_files, ", "))
              copy_files(selected_files, dest_dir)
            end,
          },
        })
      end,
    },
  })
end

vim.keymap.set("n", "<leader>tt", dynamic_file_transfer, { desc = "dynamic file transfer" })
