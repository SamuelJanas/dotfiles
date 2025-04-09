return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim', 'fannheyward/telescope-coc.nvim' },
    config = function()
        require('telescope').setup{
            defaults = {
                file_ignore_patterns = { ".git", "node_modules", ".venv" }
            },
            extensions = {
                coc = {
                    prefer_locations = true,
                    push_cursor_on_edit = true,
                    timeout = 3000,
                }
            }
        }
        -- Load the coc extension after setting it up
        require('telescope').load_extension('coc')
    end
}
