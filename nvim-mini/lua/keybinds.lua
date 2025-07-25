local keymap = vim.keymap.set

-- less disorienting navigation
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
-- same can be done with {, }
--
keymap("n", "<leader>ff", function() require('mini.pick').builtin.files() end,
{ desc = 'Find File' })
keymap("n", "<leader>fr", function() require('mini.pick').builtin.resume() end,
{ desc = 'Find File' })


keymap("n", "<S-l>", "<cmd>bnext<cr>", { desc = 'Next Buffer' })
keymap("n", "<S-h>", "<cmd>bprevious<cr>", { desc = 'Previous Buffer' })
keymap("n", "<leader>t", "<cmd>enew<cr>", { desc = 'New Buffer' })
keymap("n", "<leader>q", "<cmd>bdelete<cr>", { desc = 'Close Buffer' })

-- Open mini files (or close if already open)
keymap("n", "<leader>e", function()
    local MiniFiles = require("mini.files")

    -- Check if mini.files is already open
    local is_open = false
    for _, win in pairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == "minifiles" then
            is_open = true
            break
        end
    end

    if is_open then
        MiniFiles.close()
    else
        local buffer_name = vim.api.nvim_buf_get_name(0)
        if buffer_name == "" or string.match(buffer_name, "Starter") then
            MiniFiles.open(vim.loop.cwd())
        else
            MiniFiles.open(buffer_name)
        end
    end
end, { desc = "Toggle MiniFiles" })
keymap("n", "<leader>fg", function() require('mini.pick').builtin.grep_live() end,
{ desc = 'Find String' })
keymap("n", "<leader>fh", function() require('mini.pick').builtin.help() end,
{ desc = 'Find Help' })

-- Better yanking and disable highlight
keymap("n", "YY", "<cmd>%y<cr>", { desc = 'Yank Buffer' })
keymap("n", "<Esc>", "<cmd>noh<cr>", { desc = 'Clear Search' })


-- Better indenting in visual mode
keymap("v", "<", "<gv", { desc = "Indent left and reselect" })
keymap("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Krack
keymap("n", "K", 'i<CR><Esc>', { noremap = true })

-- Comment out
keymap('n', '<C-/>', 'gcc', { noremap = false, silent = true })
keymap('v', '<C-/>', 'gc',  { noremap = false, silent = true })

keymap('n', '<C-_>', 'gcc', { remap = true, desc = "Toggle line comment" })
keymap('v', '<C-_>', 'gc', { remap = true, desc = "Toggle line comment" })

-- Flash.nvim
keymap({"n","x","o"}, "s", function() require("flash").jump() end, {desc = "Flash Jump"})

-- Smart Splits
local ss = require('smart-splits')
keymap("n", "<C-h>", ss.move_cursor_left)
keymap("n", "<C-j>", ss.move_cursor_down)
keymap("n", "<C-k>", ss.move_cursor_up)
keymap("n", "<C-l>", ss.move_cursor_right)

keymap("n", "<M-h>", ss.resize_left)
keymap("n", "<M-l>", ss.resize_right)
keymap("n", "<M-k>", ss.resize_up)
keymap("n", "<M-j>", ss.resize_down)

-- LSP

local opts = { silent = true, noremap = true }

-- Navigation
keymap("n", "gd", vim.lsp.buf.definition, opts)
keymap("n", "gD", vim.lsp.buf.declaration, opts)
keymap("n", "gi", vim.lsp.buf.implementation, opts)
keymap("n", "gt", vim.lsp.buf.type_definition, opts)
keymap("n", "gr", vim.lsp.buf.references, opts)

-- Information (g prefix)
keymap("n", "gH", vim.lsp.buf.hover, opts)
keymap("n", "gK", vim.lsp.buf.signature_help, opts)

-- Code actions
keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
keymap("v", "<leader>ca", vim.lsp.buf.code_action, opts)
keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
keymap("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, opts)

-- Diagnostics
keymap("n", "<leader>dd", vim.diagnostic.open_float, opts)
keymap("n", "<leader>dp", vim.diagnostic.goto_prev, opts)
keymap("n", "<leader>dn", vim.diagnostic.goto_next, opts)
keymap("n", "<leader>dl", vim.diagnostic.setloclist, opts)

keymap('i', '<PageUp>', '<Nop>', { silent = true })
keymap('i', '<PageDown>', '<Nop>', { silent = true })
