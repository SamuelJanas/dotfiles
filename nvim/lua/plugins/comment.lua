return {
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
    -- Allegedly needed for most terminals
    vim.keymap.set('n', '<C-_>', 'gcc', { remap = true, desc = "Toggle line comment" })
    vim.keymap.set('v', '<C-_>', 'gc', { remap = true, desc = "Toggle line comment" })
  end,
}
