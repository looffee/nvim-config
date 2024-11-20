-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
local M = {}
return {

  require 'custom/plugins/telescope',
  require 'custom/plugins/which-keys',
  require 'custom/plugins/eslint',
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
  }, -- search/replace in multiple files
  {
    'MagicDuck/grug-far.nvim',
    opts = { headerMaxWidth = 80 },
    cmd = 'GrugFar',
    keys = {
      {
        '<leader>sr',
        function()
          local grug = require 'grug-far'
          local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
          grug.open {
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
            },
          }
        end,
        mode = { 'n', 'v' },
        desc = 'Search and Replace',
      },
    },
  }, -- better diagnostics list and others
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble' },
    opts = {
      modes = {
        lsp = {
          win = { position = 'right' },
        },
      },
    },
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>cs', '<cmd>Trouble symbols toggle<cr>', desc = 'Symbols (Trouble)' },
      { '<leader>cS', '<cmd>Trouble lsp toggle<cr>', desc = 'LSP references/definitions/... (Trouble)' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
      {
        '[q',
        function()
          if require('trouble').is_open() then
            require('trouble').prev { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = 'Previous Trouble/Quickfix Item',
      },
      {
        ']q',
        function()
          if require('trouble').is_open() then
            require('trouble').next { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = 'Next Trouble/Quickfix Item',
      },
    },
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
  --   {
  --     'echasnovski/mini.hipatterns',
  --     recommended = true,
  --     desc = 'Highlight colors in your code. Also includes Tailwind CSS support.',
  --     event = 'VeryLazy',
  --     -- opts = function()
  --     --   local hi = require 'mini.hipatterns'
  --     --   return {
  --     --     -- custom LazyVim option to enable the tailwind integration
  --     --     tailwind = {
  --     --       enabled = true,
  --     --       ft = {
  --     --         'astro',
  --     --         'css',
  --     --         'heex',
  --     --         'html',
  --     --         'html-eex',
  --     --         'javascript',
  --     --         'javascriptreact',
  --     --         'rust',
  --     --         'svelte',
  --     --         'typescript',
  --     --         'typescriptreact',
  --     --         'vue',
  --     --       },
  --     --       -- full: the whole css class will be highlighted
  --     --       -- compact: only the color will be highlighted
  --     --       style = 'full',
  --     --     },
  --     --     highlighters = {
  --     --       hex_color = hi.gen_highlighter.hex_color { priority = 2000 },
  --     --       shorthand = {
  --     --         pattern = '()#%x%x%x()%f[^%x%w]',
  --     --         group = function(_, _, data)
  --     --           ---@type string
  --     --           local match = data.full_match
  --     --           local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
  --     --           local hex_color = '#' .. r .. r .. g .. g .. b .. b

  --     --           return MiniHipatterns.compute_hex_color_group(hex_color, 'bg')
  --     --         end,
  --     --         extmark_opts = { priority = 2000 },
  --     --       },
  --     --     },
  --     --   }
  --     -- end,
  --     -- config = function(_, opts)
  --     --   if type(opts.tailwind) == 'table' and opts.tailwind.enabled then
  --     --     -- reset hl groups when colorscheme changes
  --     --     vim.api.nvim_create_autocmd('ColorScheme', {
  --     --       callback = function()
  --     --         M.hl = {}
  --     --       end,
  --     --     })
  --     --     opts.highlighters.tailwind = {
  --     --       pattern = function()
  --     --         if not vim.tbl_contains(opts.tailwind.ft, vim.bo.filetype) then
  --     --           return
  --     --         end
  --     --         if opts.tailwind.style == 'full' then
  --     --           return '%f[%w:-]()[%w:-]+%-[a-z%-]+%-%d+()%f[^%w:-]'
  --     --         elseif opts.tailwind.style == 'compact' then
  --     --           return '%f[%w:-][%w:-]+%-()[a-z%-]+%-%d+()%f[^%w:-]'
  --     --         end
  --     --       end,
  --     --       group = function(_, _, m)
  --     --         ---@type string
  --     --         local match = m.full_match
  --     --         ---@type string, number
  --     --         local color, shade = match:match '[%w-]+%-([a-z%-]+)%-(%d+)'
  --     --         shade = tonumber(shade)
  --     --         local bg = vim.tbl_get(M.colors, color, shade)
  --     --         if bg then
  --     --           local hl = 'MiniHipatternsTailwind' .. color .. shade
  --     --           if not M.hl[hl] then
  --     --             M.hl[hl] = true
  --     --             local bg_shade = shade == 500 and 950 or shade < 500 and 900 or 100
  --     --             local fg = vim.tbl_get(M.colors, color, bg_shade)
  --     --             vim.api.nvim_set_hl(0, hl, { bg = '#' .. bg, fg = '#' .. fg })
  --     --           end
  --     --           return hl
  --     --         end
  --     --       end,
  --     --       extmark_opts = { priority = 2000 },
  --     --     }
  --     --   end
  --     --   require('mini.hipatterns').setup(opts)
  --     -- end,
  --   },
}
