local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function()
    print("Lsp Started")
end


local servers = { 'tsserver', 'rust_analyzer', 'clangd', 'gopls', 'bashls' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
