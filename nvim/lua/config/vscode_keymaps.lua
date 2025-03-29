local map = vim.keymap.set
local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = " "

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

-- remove highlight after search
map('n', '<Esc>', ':noh<CR>')

local function notify(cmd)
    return string.format("<cmd>call VSCodeNotify('%s')<CR>", cmd)
end

local function v_notify(cmd)
    return string.format("<cmd>call VSCodeNotifyVisual('%s', 1)<CR>", cmd)
end

keymap('n', '<Leader>xr', notify 'references-view.findReferences', { silent = true })
keymap('n', '<Leader>xd', notify 'workbench.actions.view.problems', { silent = true })
keymap('n', 'gr', notify 'editor.action.goToReferences', { silent = true })
keymap('n', '<Leader>rn', notify 'editor.action.rename', { silent = true })
keymap('n', '<Leader>ca', notify 'editor.action.refactor', { silent = true })

keymap('n', '<Leader>fg', notify 'workbench.action.findInFiles', { silent = true }) -- use ripgrep to search files
keymap('n', '<Leader>ts', notify 'workbench.action.toggleSidebarVisibility', { silent = true })
keymap('n', '<Leader>th', notify 'workbench.action.toggleAuxiliaryBar', { silent = true }) -- toggle docview (help page)
keymap('n', '<Leader>tp', notify 'workbench.action.togglePanel', { silent = true })
keymap('n', '<Leader>fc', notify 'workbench.action.showCommands', { silent = true }) -- find commands
keymap('n', '<Leader>ff', notify 'workbench.action.quickOpen', { silent = true }) -- find files

keymap('v', '<Leader>ca', v_notify 'editor.action.refactor', { silent = true })
keymap('v', '<Leader>fm', v_notify 'editor.action.formatSelection', { silent = true })
keymap('v', '<Leader>fc', v_notify 'workbench.action.showCommands', { silent = true })

