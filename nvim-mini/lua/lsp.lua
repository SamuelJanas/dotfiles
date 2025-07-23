local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- LSP
add({
  source = 'williamboman/mason.nvim',
  depends = { 'nvim-lua/plenary.nvim' }, -- required dependency
  hooks = {
    post_checkout = function()
      require('mason').setup()
    end,
  },
})

add({
    source = 'neovim/nvim-lspconfig',
})
later(function()
  local lspconfig = require('lspconfig')
  local servers = {
    lua_ls = {},
    pyright = {
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
    },
  }
  for server, config in pairs(servers) do
    lspconfig[server].setup(config)
  end
end)
now(function() require('mason').setup() end)

