return {
  'Vigemus/iron.nvim',
  config = function()
    local iron = require('iron.core')
    local python_formatter = require("iron.fts.common").bracketed_paste_python
      iron.setup {
        config = {
          scratch_repl = true,
          repl_definition = {
            python = {
              command = { "ipython", "--no-autoindent" },
              format = python_formatter,
            }
          },
          repl_open_cmd = require('iron.view').split.vertical.rightbelow("%25"),
        },
        keymaps = {
          toggle_repl = "<space>ir", -- toggles the repl open and closed.
          send_motion = "<space>sc",
          send_code_block = "<space>sb",
          send_code_block_and_move = "<space>sn",
          interrupt = "<space>ic",
          exit = "<space>iq",
        },
    }
  end,
  dependencies = {
      'nvim-lua/plenary.nvim'
  }
}
