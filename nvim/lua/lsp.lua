return {
  {
    "williamboman/mason.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "v1.9.1",
    opts = {
      keymap = {
        preset = 'super-tab',
        ['<C-i>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },
      signature = { enabled = true },
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      local capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      }
      capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = { "lua_ls", "pyright", "omnisharp" },
        automatic_installation = true,
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end,
          pyright = function()
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
                    },
                  },
                },
              },
            })
          end,
        },
      })
    end,
  },
}

