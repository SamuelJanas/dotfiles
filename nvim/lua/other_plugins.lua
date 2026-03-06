local add, later = MiniDeps.add, MiniDeps.later


-- smart-splits for working with tmux
add({
    source = "mrjones2014/smart-splits.nvim",
})


add({
    source='nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim', },
})
later(
  function() require('telescope').setup{
    defaults = {
      file_ignore_patterns = { ".git", "node_modules", ".venv", "requirements.txt", ".lock" }
    },
  }
  end
)
