local get_hex = require('cokeline.hlgroups').get_hl_attr

require('cokeline').setup({
  default_hl = {
    fg = function(buffer)
      return
        buffer.is_focused
        and get_hex('DiffAdd', 'bg')
         or get_hex('Normal', 'fg')
    end,
    bg = function(buffer)
      return
        buffer.is_focused
        and get_hex('Special', 'fg')
         or get_hex('ColorColumn', 'bg')
    end,
  },
    components = {
        { text = ' ' }, -- spacer
        { text = function(buffer) return buffer.filename end },
        {
            text = function(buffer) return buffer.is_modified and ' [*]' or '' end,
            fg = function() return get_hex('DiffAdd', 'fg') end,
            bold = true,
        },
        { text = ' ' },
        {
            text = '󰖭',
            fg = function() return get_hex('DiffAdd', 'fg') end,
            on_click = function(_, _, _, _, buffer) buffer:delete() end
        },
        { text = ' ' },
    },
})

-- Keymaps
vim.keymap.set('n', '<S-Tab>', '<Plug>(cokeline-focus-prev)', { silent = true, desc = 'Previous buffer' })
vim.keymap.set('n', '<Tab>', '<Plug>(cokeline-focus-next)', { silent = true, desc = 'Next buffer' })
vim.keymap.set('n', '<A-,>', '<Plug>(cokeline-switch-prev)', { silent = true })
vim.keymap.set('n', '<A-.>', '<Plug>(cokeline-switch-next)', { silent = true })

