return
{
    'numToStr/Comment.nvim',
    opts = {
      padding = true,
      sticky = true,
    },
    lazy = false,
    config = function()
      require('Comment').setup()
      vim.keymap.set('n', '<C-/>', 'gcc', { remap = true, desc = "Toggle line comment" })
      vim.keymap.set('v', '<C-/>', 'gc', { remap = true, desc = "Toggle line comment" })
    end,
  }
