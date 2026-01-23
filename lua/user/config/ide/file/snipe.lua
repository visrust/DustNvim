-- Snipe.nvim - Maxed Out
local snipe = require("snipe")

snipe.setup()

-- Keymaps for buffers outside the menu
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Open Snipe buffer menu
map("n", "<leader>sb", snipe.open_buffer_menu, vim.tbl_extend("force", opts, { desc = "Snipe: Open buffer menu" }))

map("n", "<leader>sd", function()
    snipe.open_buffer_menu()
end, vim.tbl_extend("force", opts, { desc = "Snipe: Open buffer menu to delete" }))
