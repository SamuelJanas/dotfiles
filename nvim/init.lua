if vim.g.vscode then
  require("config.vscode_keymaps")

else
  require("config.lazy")
  require("config.keymaps")
  require("config.lsp_keymaps")
  vim.cmd("set number")
  vim.cmd("set relativenumber")
  vim.cmd("set scrolloff=12")
  vim.cmd("set shiftwidth=4 smarttab")
  -- vim.cmd("set expandtab")
  -- vim.cmd("set laststatus=3")
  vim.opt.ignorecase = true
  vim.opt.smartcase = true
  vim.opt.swapfile = false
  vim.opt.autoread = true
end
