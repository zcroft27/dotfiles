vim.opt.termguicolors = true
require('styling')
require('gopls')
require('plugins') -- your packer file
vim.g.mapleader = " "
-- Setup Telescope (on the main module, not builtin)
require('telescope').setup {
  defaults = {
    preview = {
      hide_on_startup = false, -- always show preview
    }
  }
}

-- Load builtin pickers
local builtin = require('telescope.builtin')

-- Keymaps
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


