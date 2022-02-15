local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function()
    print("Lsp Started")
end

require'lspconfig'.tsserver.setup{ 
    capabilities = capabilities,
    on_attach=on_attach 
}

require'lspconfig'.gopls.setup{
    capabilities = capabilities,
    on_attach = on_attach, 
}
require'lspconfig'.clangd.setup{
    capabilities = capabilities,
    on_attach=on_attach
}
-- who even uses this?
require'lspconfig'.rust_analyzer.setup{ 
    capabilities = capabilities, 
    on_attach=on_attach 
}

local opts = {
    -- whether to highlight the currently hovered symbol
    -- disable if your cpu usage is higher than you want it
    -- or you just hate the highlight
    -- default: true
    highlight_hovered_item = true,

    -- whether to show outline guides
    -- default: true
    show_guides = true,
}
