return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  build = function()
    vim.fn['mkdp#util#install']()
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
}
