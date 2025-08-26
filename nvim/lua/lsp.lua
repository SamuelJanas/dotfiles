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
  checkout = "v1.6.0",
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
    },
})

later(function()
  local mason_lspconfig = require('mason-lspconfig')
  local lspconfig = require('lspconfig')
  local util = require('lspconfig.util')

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
  mason_lspconfig.setup({
    ensure_installed = { "lua_ls", "pyright", "omnisharp" },
    automatic_installation = true,
  })

  -- Lua and Python servers
  lspconfig.lua_ls.setup{ capabilities = capabilities }
  lspconfig.pyright.setup{
    capabilities = capabilities,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "openFilesOnly",
          useLibraryCodeForTypes = true,
          typeCheckingMode = "off",
        },
      },
    },
  }

  -- Omnisharp (C# for Godot)
  lspconfig.omnisharp.setup{
    capabilities = capabilities,
    root_dir = util.root_pattern("*.sln", "*.csproj"),
  }

  -- GDScript (optional, only for `.gd` files)
  lspconfig.gdscript.setup{
    cmd = { "ncat", "127.0.0.1", "6005" },
    root_dir = util.root_pattern("project.godot"),
    capabilities = capabilities,
  }
end)
