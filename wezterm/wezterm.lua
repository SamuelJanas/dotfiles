local wezterm = require 'wezterm'
local config = {}


config.color_scheme = 'Gruvbox Dark (Gogh)'
config.default_prog = { 'pwsh.exe' }
config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.max_fps = 144
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = true
config.tab_max_width = 32
config.tab_and_split_indices_are_zero_based = true
config.colors = {
  tab_bar = {
    active_tab = {
      fg_color = '#bcd1c2',
      bg_color = '#36593f'
      }
    }
}
config.initial_cols = 200
config.initial_rows = 55
config.window_background_opacity = 0.95
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.55,
}
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 2000 }

local function find_or_create_lazygit_tab(window, pane)
  local tabs = window:mux_window():tabs()
  local current_tab = window:active_tab()
  local current_tab_title = current_tab:get_title()
  
  if string.lower(current_tab_title):find("lazygit") then
    window:perform_action(wezterm.action.ActivateLastTab, pane)
    return
  end
  
  for _, tab in ipairs(tabs) do
    local tab_title = tab:get_title()
    if string.lower(tab_title):find("lazygit") then
      tab:activate()
      return
    end
  end

  local new_tab = window:perform_action(
    wezterm.action.SpawnCommandInNewTab {
      args = { 'lazygit' },
    },
    pane,
    window:active_tab():set_title('lazygit')
  )

  if new_tab then
    new_tab:set_title("lazygit")
  end
end

local function is_vim(pane)
    return pane:get_user_vars().IS_NVIM == 'true'
end

local direction_keys = {
    Left = 'h',
    Down = 'j',
    Up = 'k',
    Right = 'l',

    h = 'Left',
    j = 'Down',
    k = 'Up',
    l = 'Right',
}

-- === PLUGINS === 
local sessions = wezterm.plugin.require("https://github.com/abidibo/wezterm-sessions")
 sessions.apply_to_config(config)


local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == 'resize' and 'META' or 'CTRL',
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == 'resize' and 'META' or 'CTRL' },
        }, pane)
      else
        if resize_or_move == 'resize' then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end

config.keys = {
  {
    key = '"',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = '%',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'c',
    mods = 'LEADER',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = 'x',
    mods = 'LEADER',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    key = '[',
    mods = 'LEADER',
    action = wezterm.action.ActivateCopyMode,
  },
  {
    key = 'a',
    mods = 'LEADER|CTRL',
    action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
  },
  {
    key = "g",
    mods = "LEADER",
    action = wezterm.action.EmitEvent("lazygit_signal")
  },
  {
    key = ',',
    mods = 'LEADER',
    action = wezterm.action.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(
        function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end
      ),
    },
  },
  {
    key = '$',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.PromptInputLine {
      description = 'Enter new name for session',
      action = wezterm.action_callback(
        function(window, pane, line)
          if line then
            wezterm.mux.rename_workspace(
              wezterm.mux.get_active_workspace(),  
              line
            )
          end
        end
      ),
    },
  },
  {
    key = 's',
    mods = 'LEADER',
    action = wezterm.action.ShowLauncherArgs { flags = 'WORKSPACES' },
  },
  {
    key = 'z',
    mods = 'LEADER',
    action = wezterm.action.TogglePaneZoomState,
  },
  {
    key = 'g',
    mods = 'LEADER',
    action = wezterm.action_callback(find_or_create_lazygit_tab),
  },
  split_nav('move', 'h'),
  split_nav('move', 'j'),
  split_nav('move', 'k'),
  split_nav('move', 'l'),
  split_nav('resize', 'h'),
  split_nav('resize', 'j'),
  split_nav('resize', 'k'),
  split_nav('resize', 'l'),
  {
    mods = "LEADER",
    key = "Space",
    action = wezterm.action.RotatePanes "Clockwise"
  },
  {
    mods = "LEADER",
    key = "Backspace",
    action = wezterm.action.RotatePanes "CounterClockwise"
  },
  {
    key = 'S',
    mods = 'LEADER',
    action = wezterm.action({ EmitEvent = "save_session" }),
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = wezterm.action({ EmitEvent = "load_session" }),
  },
  {
    key = 'r',
    mods = 'LEADER',
    action = wezterm.action({ EmitEvent = "restore_session" }),
  },
  {
    key = 'd',
    mods = 'CTRL|SHIFT',
    action = wezterm.action({ EmitEvent = "delete_session" }),
  },
  {
    key = 'e',
    mods = 'CTRL|SHIFT',
    action = wezterm.action({ EmitEvent = "edit_session" }),
  },
}

for i = 0, 9 do
    table.insert(config.keys, {
        key = tostring(i), 
        mods = "LEADER",
        action = wezterm.action.ActivateTab(i),
    })
end

return config
