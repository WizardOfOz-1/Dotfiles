require("mini.deps").setup({ path = { package = path_package } })
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- LSP 
later(function()
    add({ source = "neovim/nvim-lspconfig" })
    local signs = {
        Error = "E",
        Warning = "W",
        Hint = "H",
        Information = "I"
    }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    local _border = "single"
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = _border
    }
    )
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = _border
    }
    )

    vim.diagnostic.config {
        float = { border = "rounded"}
    }

    local on_attach = function(client)
        vim.opt.omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
        vim.keymap.set('n', '<leader>zz', vim.lsp.buf.format, {})
        vim.keymap.set('n', '[d', vim.diagnostic.goto_next, {})
        vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, {})
        vim.keymap.set('n', '<leader>fd', function()
            vim.diagnostic.setqflist()
        end, { noremap = true, silent = true })
        vim.keymap.set('n', '<M-l>', '<cmd>cnext<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<M-h>', '<cmd>cprev<CR>', { noremap = true, silent = true })
    end


    local lspconfig = require("lspconfig")
    lspconfig.gopls.setup({
        on_attach = on_attach,
        -- capabilities = capabilities,
    })

    lspconfig.rust_analyzer.setup({
        on_attach = on_attach,
        -- capabilities = capabilities,
    })

    lspconfig.templ.setup({
        on_attach = on_attach,
        -- capabilities = capabilities,
    })

    lspconfig.ts_ls.setup({
        on_attach = on_attach,
        hostInfo = "neovim",
        -- capabilities = capabilities,
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
        cmd = { "typescript-language-server", "--stdio" }
    })
end)

later(
function() 
    require("mini.completion").setup(
    {
        delay = { completion = 100, info = 100, signature = 50 },

        window = {
            info = { height = 25, width = 80, border = 'single' },
            signature = { height = 25, width = 80, border = 'single' },
        },
        lsp_completion = {
            source_func = 'omnifunc',
            auto_setup = false,
        },
        fallback_action = '<C-x><C-n>',
        mappings = {
            force_twostep = '<C-Space>', -- Force two-step completion
            force_fallback = '<A-Space>', -- Force fallback completion
        },
        set_vim_settings = false,
    }
    )
end
)

later(
function()
    add(
    {
        source = "ThePrimeagen/harpoon",
        checkout = 'harpoon2',
        depends = {'nvim-lua/plenary.nvim'},
    })
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<leader>h", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<leader>j", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<leader>k", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<leader>l", function() harpoon:list():select(4) end)
    vim.keymap.set("n", "<leader>;", function() harpoon:list():select(5) end)

    vim.keymap.set("n", "<M-k>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<M-j>", function() harpoon:list():next() end)
end
)
