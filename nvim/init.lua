-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

-- Neovim Options
vim.o.background = "dark"
vim.o.cmdheight = 0
vim.o.number = true
vim.o.relativenumber = false
vim.o.laststatus = 2
vim.o.list = true
vim.opt.termguicolors = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.swapfile = false
vim.o.autoread = true
vim.o.listchars = table.concat({ "extends:…", "nbsp:␣", "precedes:…", "tab:> " }, ",")
vim.o.autoindent = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.scrolloff = 10
vim.o.updatetime = 1000
vim.opt.iskeyword:append("-")
vim.o.spelllang = "en,pl"
vim.o.spelloptions = "camel"
vim.opt.complete:append("kspell")
vim.o.path = vim.o.path .. ",**"
vim.opt.sessionoptions:remove('blank')

require("lazy").setup({
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme gruvbox]])
        end,
    },
    {
      'nvim-mini/mini.files',
       version = '*',
       opts = {
         mappings = { close = '<Esc>' },
         windows = {
           preview = true,
           border = "rounded",
           width_preview = 80,
         }
       }
    },
    -- autopairs
    { 'nvim-mini/mini.pairs', version = '*', opts={} },
    -- Tabs on top to track open buffers, 
    { 'nvim-mini/mini.tabline', version = '*', opts={} },
    {
        "mrjones2014/smart-splits.nvim",
        lazy = false,
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function(_, opts)
            local ok, parsers = pcall(require, "nvim-treesitter.parsers")
            if ok and not parsers.ft_to_lang then
                parsers.ft_to_lang = function(ft)
                    return vim.treesitter.language.get_lang(ft) or ft
                end
            end
            require("telescope").setup(opts)
        end,
        opts = {
            defaults = {
                file_ignore_patterns = { ".git", "node_modules", ".venv", "requirements.txt", ".lock" },
                preview = {
                    treesitter = false,
                },
            },
        },
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
    },

    { import = "lsp" },
    { import = "treesitter" },
})

require("keybinds")
