return{
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  dependencies = { "rafamadriz/friendly-snippets" },
	build = "make install_jsregexp",
  opts = {
    history = true,
    update_events = "TextChanged,TextChangedI",
    enable_autosnippets = true,
  },
  config = function(_, opts)
    local luasnip = require("luasnip")
    luasnip.config.set_config(opts)
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
} 