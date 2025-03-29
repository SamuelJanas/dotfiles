return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim', 'fannheyward/telescope-coc.nvim' },
    config = function()
        -- Basic Telescope configuration
        require('telescope').setup{
            defaults = {
                file_ignore_patterns = { ".git", "node_modules", ".venv" }
            },
            extensions = {
                coc = {
                    -- theme = 'ivy',             -- Optional: You can use a different theme (like 'ivy')
                    prefer_locations = true,   -- Use Telescope locations for previewing definitions, etc.
                    push_cursor_on_edit = true, -- Remember cursor position for future jumps
                    timeout = 3000,            -- Timeout for coc commands
                }
            }
        }
        
        -- Load the coc extension after setting it up
        require('telescope').load_extension('coc')
    end
}
