-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
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
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    config = true,
    priority = 1000,
    config = function()
      vim.o.background = 'dark'
      vim.cmd 'colorscheme gruvbox'
    end,
  },
  {
    'jbyuki/nabla.nvim',
    ft = 'markdown',
    config = function()
      vim.keymap.set('n', '<leader>p', require('nabla').popup, { desc = '[P]review Math Equation' })
      vim.keymap.set('n', '<leader>te', function()
        if vim.bo.eqrender == nil then
          vim.bo['eqrender'] = 0
        end
        if vim.bo.eqrender == 0 then
          vim.bo.eqrender = 1
          require('nabla').enable_virt()
        else
          vim.bo.eqrender = 0
          require('nabla').disable_virt()
        end
      end, { desc = '[T]oggle [E]quation Render' })
    end,
  },
}
