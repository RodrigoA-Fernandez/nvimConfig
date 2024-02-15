local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "stevearc/conform.nvim",
        --  for users those who want auto-save conform + lazyloading!
        event = "BufWritePre",
        config = function()
          require "custom.configs.conform"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return require "custom.configs.nvim-cmp"(require "plugins.configs.cmp")
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = {
      overrides.mason,
      ensure_installed = {
        "rust-analyzer",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
    config = function()
      require "plugins.configs.treesitter"
      require "custom.configs.treesitter"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = function(_, opts)
      local crates = require "crates"
      crates.setup(opts)
      crates.show()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "plugins.configs.cmp"
      table.insert(M.sources, { name = "crates" })
      return M
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
  },
  {
    "barrett-ruth/live-server.nvim",
    build = "npm i live-server",
    config = true,
    ft = { "html", "php", "js" },
  },
  {
    "epwalsh/obsidian.nvim",
    ft = { "md", "markdown" },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    config = function()
      require "custom.configs.obsidian"
    end,
  },
  --Formatter--

  {
    "preservim/vim-markdown",
    ft = { "md", "markdown" },
    config = function()
      require "custom.configs.markdown"
    end,
  },
  {
    "epwalsh/pomo.nvim",
    version = "*", -- Recommended, use latest release instead of latest commit
    lazy = true,
    cmd = { "TimerStart", "TimerRepeat" },
    dependencies = {
      -- Optional, but highly recommended if you want to use the "Default" timer
      "rcarriga/nvim-notify",
      config = function()
        require("notify").setup {
          background_colour = "#000000",
        }
        vim.notify = require "notify"
      end,
    },
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    lazy = false,
    config = function()
      require "custom.configs.surround"
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },
  {
    "benfowler/telescope-luasnip.nvim",
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },
  {
    "icewind/ltex-client.nvim",
    ft = { "md", "markdown", "latex", "txt" },
    config = function()
      require("ltex-client").setup {
        user_dictionaries_path = (vim.fn.stdpath "config") .. "/lua/custom/ltex/dictionaries",
      }
    end,
  },
  -- {
  --   "enderh5/logseq-nvim",
  --   dir = "~/Documents/logseq-nvim",
  --   lazy = false,
  --   dependencies = {
  --     "hrsh7th/nvim-cmp",
  --   },
  --   config = function()
  --     require("logseq-nvim").setup {
  --       graphs = { "~/PruebaLogseq/", "~/Documents/Scouts/" },
  --       autopairs = true,
  --     }
  --   end,
  -- },
  {
    "vimwiki/vimwiki",
    ft = { "md", "markdown" },
    config = function()
      vim.keymap.set("n", "<leader>nl", "<Plug>VimwikiNextLink", { silent = true }) -- For Tab
      vim.keymap.set("n", "<leader>pl", "<Plug>VimwikiPrevLink", { silent = true }) -- For STab
    end,
  },
  -- To make a plugin not be loaded
  {
    "NvChad/nvim-colorizer.lua",
    enabled = false,
  },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
