local keymap = vim.keymap.set

local split_sensibly = function()
    if vim.api.nvim_win_get_width(0) > math.floor(vim.api.nvim_win_get_height(0) * 2.3) then
        vim.cmd("vs")
    else
        vim.cmd("split")
    end
end

keymap("n", "<leader>q", "<cmd>wq<cr>", { desc = 'Quit' })

keymap("n", "<leader>ff", function() require('mini.pick').builtin.files() end,
{ desc = 'Find File' })
keymap("n", "<leader>fr", function() require('mini.pick').builtin.resume() end,
{ desc = 'Find File' })
keymap("n", "<leader>e", function()
    local buffer_name = vim.api.nvim_buf_get_name(0)
    if buffer_name == "" or string.match(buffer_name, "Starter") then
        require('mini.files').open(vim.loop.cwd())
    else
        require('mini.files').open(vim.api.nvim_buf_get_name(0))
    end
end,
{ desc = 'File explorer' })
keymap("n", "<leader><space>", function() require('mini.pick').builtin.buffers() end,
{ desc = 'Find Buffer' })
keymap("n", "<leader>fg", function() require('mini.pick').builtin.grep_live() end,
{ desc = 'Find String' })
keymap("n", "<leader>fh", function() require('mini.pick').builtin.help() end,
{ desc = 'Find Help' })

-- Better yanking and disable highlight
keymap("n", "YY", "<cmd>%y<cr>", { desc = 'Yank Buffer' })
keymap("n", "<Esc>", "<cmd>noh<cr>", { desc = 'Clear Search' })

-- Replace
keymap("n", "<leader>re", function() vim.api.nvim_feedkeys(":%s/", "n", false) end , { desc = 'Start Replace' })
keymap("n", "<leader>rs", '<cmd>%s/\\n/\r/g<cr>', { desc = 'Replace \n with Newline' })
keymap("n", "<leader>rw", function()
    local word = vim.fn.expand("<cword>")
    local cmd = ":%s/" .. word .. "/"
    vim.api.nvim_feedkeys(cmd, "n", false) end , { desc = 'Start Replace' })

    -- ╔══════════════════════╗
    -- ║    Buffer Keymaps    ║
    -- ╚══════════════════════╝
    keymap("n", "<leader>bd", "<cmd>bd<cr>", { desc = 'Close Buffer' })
    keymap("n", "<leader>bq", "<cmd>%bd|e#<cr>", { desc = 'Close other Buffers' })
    keymap("n", "<S-l>", "<cmd>bnext<cr>", { desc = 'Next Buffer' })
    keymap("n", "<S-h>", "<cmd>bprevious<cr>", { desc = 'Previous Buffer' })
    keymap("n", "<TAB>", "<C-^>", { desc = "Alternate buffers" })
    -- Format Buffer
    -- With and without LSP
    if vim.tbl_isempty(vim.lsp.get_clients()) then
        keymap("n", "<leader>bf", function() vim.lsp.buf.format() end,
        { desc = 'Format Buffer' })
    else
        keymap("n", "<leader>bf", "gg=G<C-o>", { desc = 'Format Buffer' })
    end

    keymap("n", "<leader>gl", function()
        split_sensibly()
        vim.cmd('terminal lazygit')
    end, { desc = 'Lazygit' })

    keymap("n", "<leader>wq", "<cmd>wincmd q<cr>", { desc = 'Close Window' })
    keymap("n", "<leader>n", "<cmd>noh<cr>", { desc = 'Clear Search Highlight' })


keymap("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
keymap("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
keymap("v", "<", "<gv", { desc = "Indent left and reselect" })
keymap("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Krack
keymap("n", "K", 'i<CR><Esc>', { noremap = true })
keymap("n", "<C-/>", 'gcc', { noremap = true })

-- Flash.nvim
vim.keymap.set({"n","x","o"}, "s", function() require("flash").jump() end, {desc = "Flash Jump"})

--LSP
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
