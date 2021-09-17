local function on_attach()
end

require'lspconfig'.tsserver.setup{ on_attach=on_attach }

local home = os.getenv("HOME")
local omnisharp_bin = home .. "/.local/bin/omnisharp/run"
require'lspconfig'.omnisharp.setup {
  cmd = {omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) };
}


require'lspconfig'.gopls.setup{
    on_attach=on_attach,
    cmd = {"gopls", "serve"},
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
}
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

require('symbols-outline').setup(opts)
