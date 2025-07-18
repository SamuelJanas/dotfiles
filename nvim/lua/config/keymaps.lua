local map = vim.keymap.set
local builtin = require('telescope.builtin')
vim.g.mapleader = " "

-- Telescope
map('n', '<Leader>ff', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<Leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

-- Terminal
-- exit terminal with C-h
map('t', '<C-h>', [[<C-\><C-n>]], { noremap = true, silent = true })

-- Editing
-- K for Krack
map("n", "K", 'i<CR><Esc>', { noremap = true })

-- Surrounding
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

-- File tree
map('n', '<Leader>e', ':Neotree filesystem toggle right<CR>')

-- Search
-- remove highlight after search
map('n', '<Esc>', ':noh<CR>')

-- Colorizer
map('n', '<leader>sc', ':ColorizerToggle<CR>', {desc = "toggle coloring"})

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })
