local map = vim.keymap.set
local builtin = require('telescope.builtin')

vim.g.mapleader = " "

map('n', '<Leader>ff', builtin.find_files, {desc = 'Telescope find files'})
map('n', '<Leader>fg', builtin.live_grep, {desc = 'Telescope live grep'})

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

-- COC.NVIM

-- LSP actions with coc.nvim
map("n", "gd", "<Plug>(coc-definition)", { silent = true, desc = "Go to definition" })
map("n", "<leader>gd", ":Telescope coc definitions<CR>", { silent = true, desc = "Go to definition with telescope" })
map("n", "gH", ":call CocActionAsync('doHover')<CR>", { silent = true, desc = "Show hover" })
map("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true, desc = "Rename symbol" })
-- map("n", "<leader>gr", "<Plug>(coc-references)", { silent = true, desc = "Find references" })
map("n", "<leader>gr", ":Telescope coc references<CR>", { silent = true, desc = "Find references" })
map("n", "gi", "<Plug>(coc-implementation)", { silent = true, desc = "Go to implementation" })

-- Diagnostics
map("n", "[d", "<Plug>(coc-diagnostic-prev)", { silent = true, desc = "Previous diagnostic" })
map("n", "]d", "<Plug>(coc-diagnostic-next)", { silent = true, desc = "Next diagnostic" })

-- Format code
map("n", "<leader>for", ":CocCommand editor.action.formatDocument<CR>", { silent = true, desc = "Format document" })

-- Show available actions (like code actions in VS Code)
map("n", "<leader>ca", "<Plug>(coc-codeaction)", { silent = true, desc = "Code actions" })

-- Show function signature while typing
map("i", "<C-Space>", "coc#refresh()", { expr = true, silent = true })

-- accept with tab
map("i", "<Tab>", "coc#pum#visible() ? coc#_select_confirm() : '<Tab>'", { expr = true, silent = true })

-- IRON
iron = require('iron.core')
map('n', '<leader>ip', function() iron.repl_for('python') end, { desc = 'Start IPython REPL' })
map('n', '<leader>x', function() iron.send_line() end, { desc = 'Send current line to IPython' })
map('v', '<leader>x', function() iron.visual_send() end, { desc = 'Send visual selection to IPython' })
