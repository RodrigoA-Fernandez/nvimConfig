local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

local config_ltex = {
  language = "es",
  markdown = {
    nodes = {
      CodeBlock = "ignore",
      FencedCodeBlock = "ignore",
      AutoLink = "ignore",
      Code = "ignore",
      Image = "ignore",
      Link = "ignore",
      Reference = "ignore",
      GitLabInlineMath = "ignore",
    },
  },
}
-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "pyright", "intelephense", "bashls", "marksman" }

lspconfig.ltex.setup {
  on_attach = function()
    require("ltex-client.server").update_configuration(config_ltex)
    vim.cmd ":ColorizerDetachFromBuffer"
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  filetypes = { "vimwiki", "markdown", "md", "pandoc", "vimwiki.markdown.pandoc" },
  flags = { debounce_text_changes = 300 },
  settings = {
    ltex = config_ltex,
  },
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- lspconfig.rust_analyzer.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = {"rust"},
--   root_dir = util.root_pattern("Cargo.toml"),
--   settings = {
--     ['rust-analyzer'] = {
--       cargo = {
--         allFeatures = true,
--       }
--     }
--   }
-- })
--
-- lspconfig.pyright.setup { blabla}
