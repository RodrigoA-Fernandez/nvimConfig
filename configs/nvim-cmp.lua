local utils = require "custom.utils"
return function(opts)
  local cmp_ui = require("core.utils").load_config().ui.cmp
  local cmp_style = cmp_ui.style
  local field_arrangement = {
    atom = { "kind", "abbr", "menu" },
    atom_colored = { "kind", "abbr", "menu" },
  }

  local formatting_style = {
    -- default fields order i.e completion word + item.kind + item.kind icons
    fields = field_arrangement[cmp_style] or { "abbr", "kind", "menu" },

    format = function(origin, item)
      local icons = require "nvchad.icons.lspkind"

      local icons_custom = {
        LogseqTweet = "",
        LogseqVideo = "",
        LogseqTimestamp = "󱫘",
        LogseqLink = "󰠮",
      }

      local icon = (cmp_ui.icons and icons[item.kind]) or ""
      if origin.completion_item.tipo ~= nil then
        icon = icons_custom[origin.completion_item.tipo]
      end

      if cmp_style == "atom" or cmp_style == "atom_colored" then
        icon = " " .. icon .. " "
        item.menu = cmp_ui.lspkind_text and "   (" .. item.kind .. ")" or ""
        item.kind = icon
      else
        icon = cmp_ui.lspkind_text and (" " .. icon .. " ") or icon
        item.kind = string.format("%s %s", icon, cmp_ui.lspkind_text and item.kind or "")
      end

      return item
    end,
  }
  opts.formatting = formatting_style
end
