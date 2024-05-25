return {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",

    dependencies = { "rafamadriz/friendly-snippets" },

    config = function()
        local ls = require("luasnip")
        ls.filetype_extend("javascript", { "jsdoc" })

        vim.keymap.set({"i", "s"}, "<C-k>", function() ls.jump( 1) end, {silent = true})
        vim.keymap.set({"i", "s"}, "<C-j>", function() ls.jump(-1) end, {silent = true})
    end,
}
