-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set up keybindings for switching windows with CTRL+w + Arrow Keys
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Space + E to show Neotree
keymap('n', '<Space>e', ':Neotree source=filesystem reveal=true position=left toggle<CR>', opts)

-- Space + Q + Q to quit Neovim completely
keymap('n', '<Space>qq', ':qa!<CR>', opts)

-- CTRL+w + Left Arrow to move to the left window
keymap('n', '<leader>w<Left>', '<C-w>h', opts)

-- CTRL+w + Down Arrow to move to the window below
keymap('n', '<leader><Down>', '<C-w>j', opts)

-- CTRL+w + Up Arrow to move to the window above
keymap('n', '<leader><Up>', '<C-w>k', opts)

-- CTRL+w + Right Arrow to move to the right window
keymap('n', '<leader>w<Right>', '<C-w>l', opts)

-- CTRL+s to save file
keymap('n', '<C-s>', ':w<CR>', opts)

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
