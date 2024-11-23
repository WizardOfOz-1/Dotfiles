local opts = { noremap = true, silent = true }

-- Toggle between the latest buffers
vim.api.nvim_set_keymap('n', '<leader>n', '<C-^>', opts)

-- Markdown stuff:
vim.api.nvim_set_keymap('n', '<leader>ah', ':lua vim.fn.feedkeys(":s/==\\(.*\\)==/<span style=\\\"background-color: #78F7A5;color:#000000;padding:4px;\\\">\\1<\\/span>/g<CR>")<CR>', opts)

-- Mapping for <leader>ab to insert a code block template
vim.api.nvim_set_keymap('n', '<leader>ab', 'i```.```<Esc>F.cl', { noremap = true, silent = true })

