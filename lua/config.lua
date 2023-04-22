-- OPTIONS
vim.g.mapleader = ","

local options = {
  -- clipboard      = "unnamed,unnamedplus",   --- Copy-paste between vim and everything else
  -- cmdheight      = 1,                       --- Give more space for displaying messages
  -- completeopt    = "menu,menuone,noselect", --- Better autocompletion
  -- cursorline     = true,                    --- Highlight of current line
  -- emoji          = false,                   --- Fix emoji display
  expandtab      = true,                    --- Use spaces instead of tabs
  -- foldcolumn     = "0",
  -- foldnestmax    = 0,
  -- foldlevel      = 99,                      --- Using ufo provider need a large value
  -- foldlevelstart = 99,                      --- Expand all folds by default
  -- ignorecase     = true,                    --- Needed for smartcase
  -- laststatus     = 3,                       --- Have a global statusline at the bottom instead of one for each window
  -- lazyredraw     = true,                    --- Makes macros faster & prevent errors in complicated mappings
  number     = true, --- Shows current line number
  -- pumheight      = 10,                      --- Max num of items in completion menu
  relativenumber = true,                    --- Enables relative number
  scrolloff      = 4,                       --- Always keep space when scrolling to bottom/top edge
  shiftwidth     = 2,                       --- Change a number of space characeters inseted for indentation
  showtabline    = 2,                       --- Always show tabs
  ignorecase = true,
  smartcase  = true, --- Uses case in search
  smartindent    = true,                    --- Makes indenting smart
  smarttab       = true,                    --- Makes tabbing smarter will realize you have 2 vs 4
  softtabstop    = 2,                       --- Insert 2 spaces for a tab
  splitright     = true,                    --- Vertical splits will automatically be to the right
  swapfile       = false,                   --- Swap not needed
  tabstop        = 2,                       --- Insert 2 spaces for a tab
  -- timeoutlen     = 200,                     --- Faster completion (cannot be lower than 200 because then commenting doesn't work)
  undofile   = true, --- Sets undo to file
  -- updatetime     = 100,                     --- Faster completion
  -- viminfo        = "'1000",                 --- Increase the size of file history
  -- wildignore     = "*node_modules/**",      --- Don't search inside Node.js modules (works for gutentag)
  -- wrap           = true,                   --- Display long lines as just one line
  -- writebackup    = false,                   --- Not needed

  backspace      = "indent,eol,start",      --- Making sure backspace works
  backup         = false,                   --- Recommended by coc
  -- conceallevel   = 0,                       --- Show `` in markdown files
  -- encoding       = "utf-8",                 --- The encoding displayed
  errorbells     = false,                   --- Disables sound effect for errors
  -- fileencoding   = "utf-8",                 --- The encoding written to file
  -- incsearch      = true,                    --- Start searching before pressing enter
  -- showmode       = false,                   --- Don't show things like -- INSERT -- anymore
  termguicolors = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
vim.cmd('colorscheme rose-pine')

vim.keymap.set('n', '<esc><esc>', ":nohlsearch<cr>", {})
vim.keymap.set('n', 'j', "gj", {})
vim.keymap.set('n', 'k', "gk", {})
vim.keymap.set('n', '<leader>tb', ':exec &bg=="light"? "set bg=dark" : "set bg=light"<CR>', {silent=true})

-- TELESCOPE
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- TERMINAL
vim.keymap.set('n', '<leader>ft', ":FloatermToggle<cr>", {silent=true})
vim.keymap.set('t', '<esc><esc>', "<C-\\><C-n>:FloatermToggle<cr>", {silent=true})

-- NVIM TREE
vim.api.nvim_set_keymap("n", "<C-h>", ":NvimTreeToggle<cr>" ,{silent = true, noremap = true})
require("nvim-tree").setup {renderer={icons={show={file=false, folder=false, folder_arrow=false, git=false, modified=false}}},actions={open_file={quit_on_open=true}}}

-- LUALINE
require('lualine').setup {options={theme='nord'}}

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
}

local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
local lsp = require('lspconfig')
lsp.pyright.setup {
  capabilities = capabilities
}
lsp.vala_ls.setup {
  capabilities = capabilities
}

if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  vim.o.guifont = "JetBrains Mono:h13"
  vim.g.neovide_remember_window_size = true

  vim.opt.linespace = 2

  vim.g.neovide_padding_top = 10
  vim.g.neovide_padding_bottom = 10
  vim.g.neovide_padding_right = 10
  vim.g.neovide_padding_left = 10

  vim.g.neovide_hide_mouse_when_typing = false

  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.1

  vim.keymap.set('n', '<C-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<C-c>', '"+y') -- Copy
  vim.keymap.set('n', '<C-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<C-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<C-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<C-v>', '<ESC>l"+Pli') -- Paste insert mode
end
