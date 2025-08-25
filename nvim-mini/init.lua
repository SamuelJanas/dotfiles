-- Thanks for the base config
-- https://gitlab.com/domsch1988/mvim/-/blob/main/

local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    '--branch', 'stable',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require("mini.deps").setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add({
    source="ellisonleao/gruvbox.nvim",
})

-- Neovim Options
now(function()
    vim.o.background="dark"
    vim.g.mapleader = " "
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
    vim.cmd([[colorscheme gruvbox]])
end)

-- -- Neovide Configuration
-- now(function()
--     if vim.g.neovide then
--         vim.g.neovide_scroll_animation_length = 0.1
--         vim.opt.mousescroll = "ver:10,hor:6"
--         vim.g.neovide_theme = "light"
--
--         vim.g.neovide_floating_shadow = true
--         vim.g.neovide_floating_z_height = 2
--         vim.g.neovide_light_angle_degrees = 45
--         vim.g.neovide_light_radius = 15
--
--         vim.g.neovide_floating_blur_amount_x = 10.0
--         vim.g.neovide_floating_blur_amount_y = 10.0
--
--         vim.o.guicursor =
--         "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait100-blinkoff700-blinkon700-Cursor/lCursor,sm:block-blinkwait0-blinkoff300-blinkon300"
--         vim.g.neovide_cursor_animation_length = 0.03
--         vim.g.neovide_cursor_smooth_blink = false
--         vim.g.neovide_cursor_vfx_mode = "pixiedust"
--     end
-- end)

later(function() require("mini.align").setup() end)

later(function() require("mini.bracketed").setup() end)
later(function() require("mini.bufremove").setup() end)
later(function() require("mini.comment").setup() end)
later(function()
    require("mini.completion").setup({
      delay = { completion = 50, info = 50, signature = 25 },

      lsp_completion = {
        source_func = 'completefunc',
        auto_setup = true,
        -- processing priority
        process_items = function(items, base)
          table.sort(items, function(a, b)
            local a_exact = vim.startswith(a.label or "", base)
            local b_exact = vim.startswith(b.label or "", base)
            if a_exact and not b_exact then return true end
            if b_exact and not a_exact then return false end
            local kind_priority = {
              [2] = 1,   -- Method
              [3] = 2,   -- Function
              [5] = 3,   -- Field/Property
              [6] = 4,   -- Variable
              [7] = 5,   -- Class
              [9] = 6,   -- Module
              [10] = 7,  -- Property
              [14] = 8,  -- Keyword
            }
            local a_priority = kind_priority[a.kind] or 99
            local b_priority = kind_priority[b.kind] or 99
            if a_priority ~= b_priority then
              return a_priority < b_priority
            end
          end)
          return items
        end,
      },

      -- VSCode-like mappings
      mappings = {
        force_twostep = '<C-Space>',
        scroll_down = '<PageDown>',
        scroll_up = '<PageUp>',
      },
 })
end)
later(function()
    require("mini.cursorword").setup()
    vim.api.nvim_set_hl(0, "MiniCursorword", { underline = true })
end)
later(function() require("mini.doc").setup() end)
later(function() require("mini.extra").setup() end)
now(function()
    require("mini.files").setup({
        mappings = {
            close = '<Esc>',
        },
        windows = {
            preview = true,
            border = "rounded",
            width_preview = 80,
        },
    })
end)
later(function() require("mini.fuzzy").setup() end)

-- This is for display purposes
later(function()
    local hipatterns = require("mini.hipatterns")
    hipatterns.setup({
        highlighters = {
            -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
            fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
            hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
            todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
            note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

            -- Highlight hex color strings (`#rrggbb`) using that color
            hex_color = hipatterns.gen_highlighter.hex_color(),
        },
    })
end)


later(function() require("mini.icons").setup() end)
later(function()
    require("mini.indentscope").setup({
        draw = {
            animation = function()
                return 0
            end,
        },
        symbol = "│",
    })
end)
later(function()
    require("mini.keymap").setup()
    local map_combo = require('mini.keymap').map_combo

    -- Support most common modes. This can also contain 't', but would
    -- only mean to press `<Esc>` inside terminal.
    local mode = { 'i', 'c', 'x', 's' }
    map_combo(mode, 'jk', '<BS><BS><Esc>')
    map_combo(mode, 'kj', '<BS><BS><Esc>')

    local map_multistep = require('mini.keymap').map_multistep

    map_multistep('i', '<Tab>', { 'pmenu_next' })
    map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
    map_multistep('i', '<CR>', { 'pmenu_accept', 'minipairs_cr' })
    map_multistep('i', '<BS>', { 'minipairs_bs' })
end)

later(function() require("mini.map").setup() end)
later(function() require("mini.misc").setup() end)

later(function()
    require("mini.move").setup({
        mappings = {
            -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
            left = '<M-S-h>',
            right = '<M-S-l>',
            down = '<M-S-j>',
            up = '<M-S-k>',

            -- Move current line in Normal mode
            line_left = '<M-S-h>',
            line_right = '<M-S-l>',
            line_down = '<M-S-j>',
            line_up = '<M-S-k>',
        },
    }
    )
end)
later(function()
    -- We took this from echasnovski's personal configuration
    -- https://github.com/echasnovski/nvim/blob/master/init.lua
    local filterout_lua_diagnosing = function(notif_arr)
        local not_diagnosing = function(notif)
            return not vim.startswith(notif.msg, "lua_ls: Diagnosing")
        end
        notif_arr = vim.tbl_filter(not_diagnosing, notif_arr)
        return MiniNotify.default_sort(notif_arr)
    end
    require("mini.notify").setup({
        content = { sort = filterout_lua_diagnosing },
        window = { config = { border = "solid" } },
    })
    vim.notify = MiniNotify.make_notify()
end)

later(function() require("mini.operators").setup() end)

later(function()require("mini.pairs").setup()end)
later(function()
    local win_config = function()
        local height = math.floor(0.618 * vim.o.lines)
        local width = math.floor(0.4 * vim.o.columns)
        return {
            anchor = "NW",
            height = height,
            width = width,
            border = "solid",
            row = math.floor(0.5 * (vim.o.lines - height)),
            col = math.floor(0.5 * (vim.o.columns - width)),
        }
    end
    require("mini.pick").setup({
        mappings = {
            choose_in_vsplit = "<C-CR>",
            move_down = '<C-j>',
            move_up = '<C-k>',
        },
        options = {
            use_cache = true,
        },
        window = {
            config = win_config,
        },
    })
    vim.ui.select = MiniPick.ui_select
end)

-- Does what you see with gS :-)
later(function() require(
    "mini.splitjoin"
).setup() end)

later(function() require("mini.surround").setup() end)
later(function() require("mini.tabline").setup() end)
-- later(function() require("mini.trailspace").setup() end)
later(function() require("mini.visits").setup() end)

-- imports
require("lsp")
require("other_plugins")
require("highlights")
require("keybinds")

