local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
-- Mason + LSPConfig
add({
  source = 'williamboman/mason.nvim',
  depends = { 'nvim-lua/plenary.nvim' },
  hooks = {
    post_checkout = function()
      require('mason').setup()
    end,
  },
})
add({
  source = "saghen/blink.cmp",
  depends = { "rafamadriz/friendly-snippets" },
  checkout = "v1.9.1",
})
add({
  source = 'williamboman/mason-lspconfig.nvim',
  depends = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
})
add({
  source = 'neovim/nvim-lspconfig',
  depends = { 'saghen/blink.cmp' }
})
require('blink.cmp').setup({
    keymap = {
      preset = 'super-tab',
      ['<C-i'] = { 'show_signature', 'hide_signature', 'fallback' },
    },
    signature = { 
      enabled = true,
    }
})

add({
  source = 'nvim-treesitter/nvim-treesitter',
  hooks = {
    post_checkout = function()
      vim.cmd('TSUpdate')
    end,
  },
})

later(function()
  require('nvim-treesitter.config').setup({
    ensure_installed = { "python", "lua" },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  })
end)

later(function()
  local lspconfig = require('lspconfig')
  local capabilities = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
      }
    }
  }
  capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
  require('mason').setup()
  require('mason-lspconfig').setup({
      ensure_installed = {"lua_ls", "pyright", "omnisharp" },
      automatic_installation=true,
      handlers = {
          function(server_name)
              require("lspconfig").pyright.setup({
                  capabilities = capabilities,
                  settings = {
                      pyright = {
                          analysis = {
                              autoSearchPaths = true,
                              diagnosticMode = "openFilesOnly",
                              useLibraryCodeForTypes = true,
                              typeCheckingMode = "basic",
                              diagnosticSeverityOverrides = {
                                  reportAttributeAccessIssue = "none",
                                  reportAssignmentType = "none",
                              }
                          }
                      }
                  }
              })
          end,
      },

  })
end)

