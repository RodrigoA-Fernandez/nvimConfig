-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'epwalsh/obsidian.nvim',
    ft = { 'md', 'markdown' },
    dependencies = {
      -- Required.
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local options = {
        workspaces = {
          {
            name = 'Apuntes',
            path = '/home/rodrigo/Apuntes/Uni/',
          },
        },
        new_notes_location = 'current_dir',
        img_folder = 'imagenes',
        disable_frontmatter = true,
        mappings = {
          ['gf'] = {
            action = function()
              return require('obsidian').util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
          },
          -- Toggle check-boxes.
          ['<leader>ch'] = {
            action = function()
              return require('obsidian').util.toggle_checkbox()
            end,
            opts = { buffer = true },
          },
        },
        note_id_func = function(title)
          -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
          -- In this case a note with the title 'My new note' will be given an ID that looks
          -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
          local suffix = ''
          if title ~= nil then
            -- If title is given, transform it into valid file name.
            suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
          else
            -- If title is nil, just add 4 random uppercase letters to the suffix.
            for _ = 1, 4 do
              suffix = suffix .. string.char(math.random(65, 90))
            end
          end
          return suffix
        end,
      }

      require('obsidian').setup(options)
      vim.opt.conceallevel = 2
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    opts = {
      git = {
        enable = true,
      },

      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
      },
      disable_netrw = false,
      hijack_netrw = false,
    },
    config = function()
      require('nvim-tree').setup()
      vim.keymap.set('n', '<leader>tt', '<Cmd>NvimTreeToggle<CR>', { desc = '[T]oggle file[T]ree' })
    end,
  },
  'christoomey/vim-tmux-navigator',
  'nvim-treesitter/nvim-treesitter-context',
  'tpope/vim-fugitive',
  {
    'olexsmir/gopher.nvim',
    ft = 'go',
    config = function(_, opts)
      require('gopher').setup(opts)
      vim.keymap.set('n', '<leader>gsj', '<cmd> GoTagAdd json<CR>', { desc = 'Add [G]o [S]truct tags for [J]son' })
      vim.keymap.set('n', '<leader>gsy', '<cmd> GoTagAdd yaml<CR>', { desc = 'Add [G]o [S]truct tags for [Y]aml' })
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    config = true,
    priority = 1000,
    config = function ()
      vim.o.background = "dark"
      vim.cmd("colorscheme gruvbox")
    end
  }
}
