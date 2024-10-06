-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local M = {}

---@param buf number?
function M.bufremove(buf)
  buf = buf or 0
  buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

  if vim.bo.modified then
    local choice = vim.fn.confirm(('Save changes to %q?'):format(vim.fn.bufname()), '&Yes\n&No\n&Cancel')
    if choice == 0 or choice == 3 then -- 0 for <Esc>/<C-c> and 3 for Cancel
      return
    end
    if choice == 1 then -- Yes
      vim.cmd.write()
    end
  end

  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    vim.api.nvim_win_call(win, function()
      if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
        return
      end
      -- Try using alternate buffer
      local alt = vim.fn.bufnr '#'
      if alt ~= buf and vim.fn.buflisted(alt) == 1 then
        vim.api.nvim_win_set_buf(win, alt)
        return
      end

      -- Try using previous buffer
      local has_previous = pcall(vim.cmd, 'bprevious')
      if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
        return
      end

      -- Create new listed buffer
      local new_buf = vim.api.nvim_create_buf(true, false)
      vim.api.nvim_win_set_buf(win, new_buf)
    end)
  end
  if vim.api.nvim_buf_is_valid(buf) then
    pcall(vim.cmd, 'bdelete! ' .. buf)
  end
end

-- Set up keybindings for switching windows with CTRL+w + Arrow Keys
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- better up/down
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
keymap('n', '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
keymap('n', '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

keymap('x', 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
keymap('x', '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
keymap('x', 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
keymap('x', '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
-- buffers
keymap('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
keymap('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
keymap('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
keymap('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
keymap('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
keymap('n', '<leader>`', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
keymap('n', '<leader>bd', '', { desc = 'Delete Buffer', callback = M.bufremove })
keymap('n', '<leader>bD', '<cmd>:bd<cr>', { desc = 'Delete Buffer and Window' })

keymap('n', '<Space>e', ':Neotree source=filesystem reveal=true position=left toggle<CR>', { desc = 'Explorer', silent = true })
keymap('n', '<Space>be', ':Neotree source=buffers reveal=true position=left toggle<CR>', { desc = 'Explore', silent = true })

-- Space + Q + Q to quit Neovim completely
keymap('n', '<Space>qq', ':qa!<CR>', { silent = true, noremap = true })

-- Change window focus
keymap('n', '<leader>w<Left>', '<C-w>h', { silent = true, noremap = true, desc = 'Focus Left' })
keymap('n', '<leader>w<Down>', '<C-w>j', { silent = true, noremap = true, desc = 'Focus Down' })
keymap('n', '<leader>w<Up>', '<C-w>k', { silent = true, noremap = true, desc = 'Focus Up' })
keymap('n', '<leader>w<Right>', '<C-w>l', { silent = true, noremap = true, desc = 'Focus Right' })

-- Split window keymaps
keymap('n', '<leader>wv', '<C-w>v', { desc = 'Vertical Split', silent = true, noremap = true })
keymap('n', '<leader>wh', '<C-w>s', { desc = 'Horizontal Split', silent = true, noremap = true })
keymap('n', '<leader>wq', '<C-w>q', { desc = 'Quit', silent = true, noremap = true })

-- CTRL+s to save file
keymap('n', '<C-s>', ':w<CR>', { desc = 'Save File', silent = true, noremap = true })
keymap('x', '<C-s>', ':w<CR>', { desc = 'Save File', silent = true, noremap = true })
keymap('i', '<C-s>', '<Esc>:w<CR>', { desc = 'Save File', silent = true, noremap = true })
keymap('s', '<C-s>', ':w<CR>', { desc = 'Save File', silent = true, noremap = true })

keymap('n', '<leader>cl', ':LspInfo<CR>', vim.tbl_extend('force', opts, { desc = 'Show LSP Info' }))

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
