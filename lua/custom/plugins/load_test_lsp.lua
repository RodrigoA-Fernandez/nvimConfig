local client = vim.lsp.start_client {
  name = 'natural_language_lsp',
  cmd = { '/home/rodrigo/Proyectos/natural_language_lsp/natural_language_lsp' },
}

if not client then
  vim.notify 'Que coño has hecho'
  return
end
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.lsp.buf_attach_client(0, client)
  end,
})

return {}
