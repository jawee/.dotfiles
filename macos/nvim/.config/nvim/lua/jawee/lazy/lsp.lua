return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'j-hui/fidget.nvim',
    },
    config = function ()
        require("fidget").setup({})
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())
        -- rest
        local servers = { 'tsserver', 'rust_analyzer', 'clangd', 'gopls', 'bashls', 'ocamllsp', 'csharp_ls', 'lua_ls'}
        for _, lsp in pairs(servers) do
            require('lspconfig')[lsp].setup {
                capabilities = capabilities,
            }
        end

        vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(e)
            local opts = { buffer = e.buf }
            vim.keymap.set("n", "<leader>vd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "<leader>vi", function() vim.lsp.buf.implementation() end, opts)
            vim.keymap.set("n", "<leader>vsh", function() vim.lsp.buf.signature_help() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() require('telescope.builtin').lsp_references() end, opts)
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("n", "<leader>vh", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>vsd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "<leader>vn", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "<leader>vp", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>vfo", function() vim.lsp.buf.formatting() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end,
      })
    end

}


