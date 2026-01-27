local get_hex = require('cokeline.hlgroups').get_hl_attr

-- Compatibility across cokeline versions
local function buffer_modified(buffer)
    return buffer.is_modified == true or buffer.modified == true
end

require('cokeline').setup({
    default_hl = {
        fg = function(buffer)
            return buffer.is_focused
              and get_hex('ColorColumn', 'bg')
              or get_hex('Normal', 'fg')
        end,
        bg = function(buffer)
            return buffer.is_focused
              and get_hex('Normal', 'fg')
              or get_hex('ColorColumn', 'bg')
        end,
    },

    components = {
        -- Devicon
        {
            text = function(buffer)
                return ' ' .. (buffer.devicon and buffer.devicon.icon or '')
            end,
            fg = function(buffer)
                return buffer.devicon and buffer.devicon.color or get_hex('Normal', 'fg')
            end,
        },

        -- Unique prefix
        {
            text = function(buffer)
                return buffer.unique_prefix or ''
            end,
            fg = get_hex('Comment', 'fg'),
        },

        -- Filename + ✱ when modified
        {
            text = function(buffer)
                local mark = buffer_modified(buffer) and ' [*]' or ''
                return buffer.filename .. mark .. ' '
            end,
            underline = function(buffer)
                return buffer.is_hovered and not buffer.is_focused
            end,
        },

        -- Close button
        {
            text = '',
            on_click = function(_, _, _, _, buffer)
                if buffer_modified(buffer) then
                    vim.notify(
                        'Buffer has unsaved changes!',
                        vim.log.levels.WARN
                    )
                    return
                end
                buffer:delete()
            end,
        },

        { text = ' ' },
    },
})

vim.keymap.set('n', '<S-Tab>', '<Plug>(cokeline-focus-prev)', { silent = true, desc = 'Previous buffer' })
vim.keymap.set('n', '<Tab>', '<Plug>(cokeline-focus-next)', { silent = true, desc = 'Next buffer' })

-- Move buffer left/right
vim.keymap.set('n', '<A-,>', '<Plug>(cokeline-switch-prev)', { silent = true })
vim.keymap.set('n', '<A-.>', '<Plug>(cokeline-switch-next)', { silent = true })

