local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function()
    print("Lsp Started")
end

-- omnisharp
local pid = vim.fn.getpid()
local omnisharp_bin = "/Users/figge/.local/omnisharp/omnisharp"
require'lspconfig'.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
    on_attach = on_attach,
    capabilities = capabilities,
}

-- rest
local servers = { 'tsserver', 'rust_analyzer', 'clangd', 'gopls', 'bashls'}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
