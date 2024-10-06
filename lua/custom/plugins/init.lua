-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {

  require 'custom/plugins/telescope',
  require 'custom/plugins/which-keys',
  {
    'rmagatti/auto-session',
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      -- log_level = 'debug',
    },
  },
  -- { 'nvim-treesitter/nvim-treesitter-angular' },
  {
    'github/copilot.vim',
    config = function() end,
  },
  -- { 'neoclide/coc.nvim', opts = { branch = 'release' } },
  -- { 'neoclide/coc-tsserver' },
  -- { 'neoclide/coc-json' },
  -- { 'neoclide/coc-html' },
  -- { 'neoclide/coc-css' },
  -- { 'neoclide/coc-emmet' },
  -- { 'neoclide/coc-yaml' },
  -- { 'neoclide/coc-python' },
  -- { 'neoclide/coc-rls' },
  -- { 'neoclide/coc-snippets' },
  -- { 'iamcco/coc-angular' },
  -- { 'neoclide/coc-tailwindcss' },
  -- { 'neoclide/coc-vetur' },
  {
    'olrtg/nvim-emmet',
    config = function()
      -- vim.keymap.set({ 'n', 'v' }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
    end,
  },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
}
