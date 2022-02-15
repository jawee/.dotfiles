local function on_attach()
end

require'lspconfig'.tsserver.setup{ on_attach=on_attach }

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.gopls.setup{
    capabilities = capabilities,
    on_attach = function()
        print("attached")
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
    end,
}
require'lspconfig'.clangd.setup{}
-- who even uses this?
require'lspconfig'.rust_analyzer.setup{ on_attach=on_attach }

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
