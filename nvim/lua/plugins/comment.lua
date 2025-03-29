return
{
    'numToStr/Comment.nvim',
    opts = {
      -- add any custom configurations here
      padding = true,  -- Add a space b/w comment and the line
      sticky = true,   -- Whether the cursor should stay at its position
    },
    lazy = false,
    config = function()
      require('Comment').setup()
      
      -- Keymaps for commenting
      -- gcc: Toggle line comment
      -- gbc: Toggle block comment
      -- gc: Toggle line comment in visual mode
      -- gb: Toggle block comment in visual mode
      
      -- Additional keymaps for easier commenting (optional)
      vim.keymap.set('n', '<C-/>', 'gcc', { remap = true, desc = "Toggle line comment" })
      vim.keymap.set('v', '<C-/>', 'gc', { remap = true, desc = "Toggle line comment" })
      
      -- Alternative mapping for terminals that might not support <C-/>
      vim.keymap.set('n', '<C-_>', 'gcc', { remap = true, desc = "Toggle line comment" })
      vim.keymap.set('v', '<C-_>', 'gc', { remap = true, desc = "Toggle line comment" })
    end,
  }
