local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function()
    print("Lsp Started")
end

local pid = vim.fn.getpid()
local omnisharp_bin = "/home/figge/.local/omnisharp/OmniSharp"
require'lspconfig'.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
    capabilities = capabilities,
    on_attach = on_attach,
}

local servers = { 'tsserver', 'rust_analyzer', 'clangd', 'gopls' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
