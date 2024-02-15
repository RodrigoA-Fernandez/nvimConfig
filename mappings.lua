---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["md"] = {
      '<Cmd>lua vim.diagnostic.open_float{ border = "rounded"} <CR>',
      "Expandir Diagnóstico",
      opts = { nowait = true },
    },
    ["<leader>sl"] = { "<Cmd> LTeXSetLanguage <CR>", "Establecer Idioma LTeX-lsp" },
    ["<leader>la"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "Ejecutar acciones de código del lsp",
    },
    ["<leader>ln"] = {
      vim.diagnostic.goto_next,
      "Siguiente diagnóstico",
    },
    ["<leader>lp"] = {
      vim.diagnostic.goto_prev,
      "Siguiente diagnóstico",
    },
  },
}

-- more keybinds!
M.dap = {
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Toggle breakpoint",
    },
    ["<leader>dus"] = {
      function()
        local widgets = require "dap.ui.widgets"
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "open debugging sidebar",
    },
  },
}

M.crates = {
  n = {
    ["<leader>rcu"] = {
      function()
        require("crates").upgrade_all_crates()
      end,
      "update crates",
    },
  },
}

M.telescope = {
  plugin = true,
  n = {
    ["<leader>fs"] = {
      function()
        require("telescope").load_extension "luasnip"
        vim.cmd "Telescope luasnip"
      end,
      "Buscar Snippets",
    },
  },
}

return M
