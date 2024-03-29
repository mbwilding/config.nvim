return {
    "mbwilding/lsp_lines.nvim",
    config = function()
        local lsp_lines = require("lsp_lines")
        lsp_lines.setup()

        vim.diagnostic.config({
            virtual_text = false, -- Disables in-built
            virtual_lines = {
                only_current_line = false,
                highlight_whole_line = false
            }
        })

        vim.keymap.set(
            "n",
            "<leader>ll",
            lsp_lines.toggle,
            { desc = "LSP Lines: Toggle" }
        )
    end,
}
