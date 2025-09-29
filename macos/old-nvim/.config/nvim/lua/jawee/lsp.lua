local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function()
    print("Lsp Started")
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, { silent = true });
end

-- rest
local servers = { 'tsserver', 'rust_analyzer', 'clangd', 'gopls', 'bashls', 'ocamllsp', 'csharp_ls'}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
