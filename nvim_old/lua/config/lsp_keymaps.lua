local map = vim.keymap.set
local opts = { silent = true, noremap = true }

-- Navigation
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "gD", vim.lsp.buf.declaration, opts)
map("n", "gi", vim.lsp.buf.implementation, opts)
map("n", "gt", vim.lsp.buf.type_definition, opts)
map("n", "gr", vim.lsp.buf.references, opts)

-- Telescope navigation
map("n", "<leader>gd", function()
  pcall(function() vim.cmd("Telescope lsp_definitions") end)
end, opts)

map("n", "<leader>gD", function()
  pcall(function() vim.cmd("Telescope lsp_declarations") end)
end, opts)

map("n", "<leader>gi", function()
  pcall(function() vim.cmd("Telescope lsp_implementations") end)
end, opts)

map("n", "<leader>gt", function()
  pcall(function() vim.cmd("Telescope lsp_type_definitions") end)
end, opts)

map("n", "<leader>gr", function()
  pcall(function() vim.cmd("Telescope lsp_references") end)
end, opts)

-- Information (g prefix)
map("n", "gH", vim.lsp.buf.hover, opts)
map("n", "gK", vim.lsp.buf.signature_help, opts)

-- Code actions
map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
map("v", "<leader>ca", vim.lsp.buf.code_action, opts)
map("n", "<leader>rn", vim.lsp.buf.rename, opts)
map("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, opts)

-- Diagnostics
map("n", "<leader>dd", vim.diagnostic.open_float, opts)
map("n", "<leader>dp", vim.diagnostic.goto_prev, opts)
map("n", "<leader>dn", vim.diagnostic.goto_next, opts)
map("n", "<leader>dl", vim.diagnostic.setloclist, opts)

-- Additional Telescope LSP features
map("n", "<leader>ds", function()
  pcall(function() vim.cmd("Telescope lsp_document_symbols") end)
end, opts)

map("n", "<leader>ws", function()
  pcall(function() vim.cmd("Telescope lsp_workspace_symbols") end)
end, opts)

map("n", "<leader>dD", function()
  pcall(function() vim.cmd("Telescope diagnostics") end)
end, opts)
