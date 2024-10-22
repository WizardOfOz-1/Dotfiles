local opts = { noremap = true, silent = true }
vim.keymap.set("n","<leader>pv",'<cmd>lua MiniFiles.open()<CR>')
vim.api.nvim_set_keymap('n', '<leader>n', '<C-^>', opts)
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Pick files<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fc', '<cmd>Pick grep_live<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
