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
vim.o.relativenumber = true
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
    "echasnovski/mini.nvim",
    version = "stable",
    lazy = false,
    config = function()
      require("mini.cursorword").setup()
      vim.api.nvim_set_hl(0, "MiniCursorword", { underline = true })
      require("mini.files").setup({
        mappings = { close = '<Esc>' },
        windows = {
          preview = true,
          border = "rounded",
          width_preview = 80,
        },
      })
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          fixme     = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack      = { pattern = "%f[%w]()HACK()%f[%W]",  group = "MiniHipatternsHack"  },
          todo      = { pattern = "%f[%w]()TODO()%f[%W]",  group = "MiniHipatternsTodo"  },
          note      = { pattern = "%f[%w]()NOTE()%f[%W]",  group = "MiniHipatternsNote"  },
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
      require("mini.indentscope").setup({
        draw   = { animation = function() return 0 end },
        symbol = "│",
      })
      require("mini.keymap").setup()
      local map_combo = require('mini.keymap').map_combo
      local mode = { 'i', 'c', 'x', 's' }
      map_combo(mode, 'jk', '<BS><BS><Esc>')
      map_combo(mode, 'kj', '<BS><BS><Esc>')
      local map_multistep = require('mini.keymap').map_multistep
      map_multistep('i', '<Tab>',   { 'pmenu_next' })
      map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
      map_multistep('i', '<CR>',    { 'pmenu_accept', 'minipairs_cr' })
      map_multistep('i', '<BS>',    { 'minipairs_bs' })
      require("mini.move").setup({
        mappings = {
          left       = '<M-S-h>',
          right      = '<M-S-l>',
          down       = '<M-S-j>',
          up         = '<M-S-k>',
          line_left  = '<M-S-h>',
          line_right = '<M-S-l>',
          line_down  = '<M-S-j>',
          line_up    = '<M-S-k>',
        },
      })
      local filterout_lua_diagnosing = function(notif_arr)
        local not_diagnosing = function(notif)
          return not vim.startswith(notif.msg, "lua_ls: Diagnosing")
        end
        notif_arr = vim.tbl_filter(not_diagnosing, notif_arr)
        return MiniNotify.default_sort(notif_arr)
      end
      require("mini.notify").setup({
        content = { sort = filterout_lua_diagnosing },
        window  = { config = { border = "solid" } },
      })
      vim.notify = MiniNotify.make_notify()
      require("mini.align").setup()
      require("mini.bracketed").setup()
      require("mini.bufremove").setup()
      require("mini.comment").setup()
      require("mini.doc").setup()
      require("mini.extra").setup()
      require("mini.fuzzy").setup()
      require("mini.icons").setup()
      require("mini.map").setup()
      require("mini.misc").setup()
      require("mini.operators").setup()
      require("mini.pairs").setup()
      require("mini.splitjoin").setup()
      require("mini.surround").setup()
      require("mini.tabline").setup()
      require("mini.visits").setup()
    end,
  },
  { import = "lsp" },
  { import = "other_plugins" },
  { import = "treesitter" },
})

require("keybinds")

