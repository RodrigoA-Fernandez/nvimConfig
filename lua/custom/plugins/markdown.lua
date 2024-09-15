return {
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = 'cd app && npm-install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    config = function()
      vim.g['mkdp_preview_options'].katex = {
        macros = {
          ['\\R'] = '\\mathbb{R}',
        },
      }
      vim.g['mkdp_auto_start'] = 1
      vim.g['mkdp_auto_close'] = 0
    end,
  },
  {
    'MeanderingProgrammer/markdown.nvim',
    main = 'render-markdown',
    opts = {},
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
}
