vim.defer_fn(function()
    require('user.other.autopairs.autopairs')
    -- require('autopairs.autopair_rule') -- already required in autopairs
end, 300)

vim.defer_fn(function()
    require('user.other.keymaps.general')
end, 300)

vim.defer_fn(function()
    require('user.other.autocmds.diagnostic')
end, 300)
