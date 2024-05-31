return {
    "folke/trouble.nvim",
    config = function()
        require("trouble").setup({})

        vim.keymap.set("n", "<leader>t", "<cmd>Trouble diagnostics toggle<cr>")
        vim.keymap.set("n", "[t", "<cmd>Trouble diagnostics next<cr>")
        vim.keymap.set("n", "]t", "<cmd>Trouble diagnostics prev<cr>")
    end
}

