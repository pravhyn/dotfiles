local M = {}

local is_termux = _G.is_termux

M.options = {
        obsidian_workSpace = is_termux and "~/Projects/obsidianVaults/Wisdom" or "~/Projects/obsidianVaults/Wisdom",
        blink_implementation = is_termux and "lua" or "prefer_rust",
}
