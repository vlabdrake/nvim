return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
     requires = { {'nvim-lua/plenary.nvim'} }
  }

  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-lualine/lualine.nvim'

  use 'neovim/nvim-lspconfig'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
  }

  use({ 'rose-pine/neovim', as = 'rose-pine' })
  use 'habamax/vim-asciidoctor'
  use 'voldikss/vim-floaterm'
end)


