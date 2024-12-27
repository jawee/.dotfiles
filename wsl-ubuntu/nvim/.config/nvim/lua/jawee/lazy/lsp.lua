-- solves "buffer newer than edits error
vim.lsp.util.apply_text_document_edit = function(text_document_edit, index, offset_encoding)
    local text_document = text_document_edit.textDocument
    local bufnr = vim.uri_to_bufnr(text_document.uri)
    if offset_encoding == nil then
        vim.notify_once('apply_text_document_edit must be called with valid offset encoding', vim.log.levels.WARN)
    end

    vim.lsp.util.apply_text_edits(text_document_edit.edits, bufnr, offset_encoding)
end

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'j-hui/fidget.nvim',
        'Decodetalkers/csharpls-extended-lsp.nvim',
        'folke/lazydev.nvim',
    },
    config = function()
        require("fidget").setup({})
        require("lazydev").setup({})
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())
        -- rest
        local servers = { 'ts_ls', 'rust_analyzer', 'clangd', 'gopls', 'bashls', 'ocamllsp', 'lua_ls' }
        for _, lsp in pairs(servers) do
            require('lspconfig')[lsp].setup {
                capabilities = capabilities,
            }
        end

        require('lspconfig').csharp_ls.setup({
            capabilities = capabilities,
            handlers = {
                ["textDocument/definition"] = require("csharpls_extended").handler,
                ["textDocument/typeDefinition"] = require("csharpls_extended").handler,
            },
        })

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
                vim.keymap.set("n", "<leader>vn", function() vim.diagnostic.jump({ count = 1 }) end, opts)
                vim.keymap.set("n", "<leader>vp", function() vim.diagnostic.jump({ count = -1 }) end, opts)
                vim.keymap.set("n", "<leader>vfo", function() vim.lsp.buf.format({ async = false }) end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end,
        })
    end

}
