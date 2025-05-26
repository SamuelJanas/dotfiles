local map = vim.keymap.set
local builtin = require('telescope.builtin')

vim.g.mapleader = " "

map('n', '<Leader>ff', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<Leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

-- exit terminal with C-h
map('t', '<C-h>', [[<C-\><C-n>]], { noremap = true, silent = true })

-- K for Krack
map("n", "K", 'i<CR><Esc>', { noremap = true })

--surrounding
map('n', '<Leader>s(', 'bcw()<Esc>P')
map('n', '<Leader>s)', 'bcw()<Esc>P')
map('n', '<Leader>s{', 'bcw{}<Esc>P')
map('n', '<Leader>s}', 'bcw{}<Esc>P')
map('n', '<Leader>s[', 'bcw[]<Esc>P')
map('n', '<Leader>s]', 'bcw[]<Esc>P')

map('v', '<Leader>s(', 'c()<Esc>P')
map('v', '<Leader>s)', 'c()<Esc>P')
map('v', '<Leader>s{', 'c{}<Esc>P')
map('v', '<Leader>s}', 'c{}<Esc>P')
map('v', '<Leader>s[', 'c[]<Esc>P')
map('v', '<Leader>s]', 'c[]<Esc>P')

map('v', '<leader>s*', 'c****<Esc>hPw')
map('n', '<leader>s*', 'ciw****<Esc>hPw')

-- tree
map('n', '<Leader>e', ':Neotree filesystem toggle right<CR>')

-- remove highlight after search
map('n', '<Esc>', ':noh<CR>')


-- LSP
local opts = { silent = true, noremap = true }
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "gH", vim.lsp.buf.hover, opts)
map("n", "<leader>gr", "<cmd>Telescope lsp_references<CR>", opts)
map("n", "K", vim.lsp.buf.hover, opts) -- Alternative to gH

map("n", "<leader>rn", vim.lsp.buf.rename, opts)

map("n", "<leader>gi", function()
  pcall(function() vim.cmd("Telescope lsp_implementations") end)
end, opts)

map("n", "<leader>gt", function()
  pcall(function() vim.cmd("Telescope lsp_type_definitions") end)
end, opts)

map("n", "<leader>gd", function()
  pcall(function() vim.cmd("Telescope lsp_definitions") end)
end, opts)

map("n", "<leader>ca", function()
  pcall(function() vim.cmd("Telescope lsp_code_actions") end)
end, opts)

map("n", "<leader>ds", function()
  pcall(function() vim.cmd("Telescope lsp_document_symbols") end)
end, opts)

map("n", "<leader>ws", function()
  pcall(function() vim.cmd("Telescope lsp_workspace_symbols") end)
end, opts)

-- IRON
iron = require('iron.core')
map('n', '<leader>ip', function() iron.repl_for('python') end, { desc = 'Start IPython REPL' })
map('n', '<leader>x', function() iron.send_line() end, { desc = 'Send current line to IPython' })
map('v', '<leader>x', function() iron.visual_send() end, { desc = 'Send visual selection to IPython' })

-- Colorizer
-- colorizer = require('colorizer')
map('n', '<leader>sc', ':ColorizerToggle<CR>', {desc = "toggle coloring"})
