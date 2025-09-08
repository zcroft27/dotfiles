return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- LSP
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig'
  use 'Mofiqul/dracula.nvim'
  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6', -- or use branch = '0.1.x'
    requires = { {'nvim-lua/plenary.nvim'} }
  }
end)

