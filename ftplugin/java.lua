local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local status, jdtls = pcall(require, 'jdtls')
if not status then
  return
end

local cmd
if vim.loop.os_uname().sysname == 'windows_nt' then
  cmd = {
    '',
    '-declipse.application=org.eclipse.jdt.ls.core.id1',
    '-dosgi.bundles.defaultstartlevel=4',
    '-declipse.product=org.eclipse.jdt.ls.core.product',
    '-dlog.protocol=true',
    '-dlog.level=all',
    '-xmx1g',
    '--add-modules=all-system',
    '--add-opens',
    'java.base/java.util=all-unnamed',
    '--add-opens',
    'java.base/java.lang=all-unnamed',
    '-javaagent:' .. vim.fn.glob(vim.fn.expand(vim.fn.stdpath 'data' .. '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar')),
    '-jar',
    vim.fn.glob(vim.fn.expand(vim.fn.stdpath 'data' .. '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar')),
    '-configuration',
    vim.fn.glob(vim.fn.expand(vim.fn.stdpath 'data' .. '/mason/packages/jdtls/config_linux')),
    '-data',
    vim.fn.glob(vim.fn.expand(vim.fn.stdpath 'data' .. '/jdtls-workspace/' .. project_name)),
  }
else
  local home = vim.fn.expand '$HOME'
  local workspace_path = home .. '/.local/share/nvim/jdtls-workspace/'
  local workspace_dir = workspace_path .. project_name

  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultstartlevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. home .. '/.local/share/nvim/mason/packages/jdtls/lombok.jar',
    '-jar',
    vim.fn.glob(vim.fn.expand(vim.fn.stdpath 'data' .. '/mason/share/jdtls/plugins/org.eclipse.equinox.launcher_*.jar')),
    '-configuration',
    home .. '/.local/share/nvim/mason/packages/jdtls/config_linux',
    '-data',
    workspace_dir,
  }
end

local extendedClientCapabilities = jdtls.extendedclientcapabilities
local config = {
  cmd = cmd,
  root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew' },

  capabilities = {
    workspace = {
      configuration = true,
    },
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
        },
      },
    },
  },

  settings = {
    java = {
      signatureHelp = { enabled = true },
      extendedClientCapabilities = extendedClientCapabilities,
      maven = {
        enabled = true,
        downloadSources = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = 'all', -- literals, all, none
        },
      },
      format = {
        enabled = true,
      },
    },
  },

  init_options = {
    bundles = {
      vim.fn.glob(vim.fn.expand(vim.fn.stdpath 'data' .. '/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar')),
    },
  },
}
require('jdtls').start_or_attach(config)

vim.keymap.set('n', '<leader>co', "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = 'Organize Imports' })
vim.keymap.set('n', '<leader>crv', "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = 'Extract Variable' })
vim.keymap.set('v', '<leader>crv', "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", { desc = 'Extract Variable' })
vim.keymap.set('n', '<leader>crc', "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = 'Extract Constant' })
vim.keymap.set('v', '<leader>crc', "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", { desc = 'Extract Constant' })
vim.keymap.set('v', '<leader>crm', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { desc = 'Extract Method' })

vim.keymap.set('n', '<leader>d', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { desc = 'Extract Method' })
