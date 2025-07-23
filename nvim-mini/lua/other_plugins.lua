local add, later = MiniDeps.add, MiniDeps.later

-- Flash nvim for s mode
add({
    source="folke/flash.nvim",
})
later(function() require('flash').setup() end)

-- smart-splits for working with tmux
add({
    source = "mrjones2014/smart-splits.nvim",
})

