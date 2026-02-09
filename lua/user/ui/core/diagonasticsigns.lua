--------------------------------------------------------------------------------
-- DYNAMIC STEALTH ECHO: Smart Wrapping Version
--------------------------------------------------------------------------------

-- Read this before taking any step !
-- This is intentional design to keep buffer minimal + text focused , rather than making it show big pop ups.
-- Use `tt` to see severity of current line below Error's 
-- tt was needed as this configuration will give higher priority to higher diagnostic levels such as Error/Warning. 
-- by default the echo area can at max go to height of a whole 10 lines , which is already a lot to handle massive errors. But make sure if errors and warnings exists on same line then use `tt` to see Warnings and lower severity.

-- Define the icons you want to see in the gutter
local icons = { Error = ' ', Warn = ' ', Hint = '󰌶 ', Info = ' ' }

-- 2. The Logic
local echo_timer = vim.loop.new_timer()

local function dynamic_stealth_echo()
    if not vim.api.nvim_buf_is_valid(0) then return end

    local line = vim.api.nvim_win_get_cursor(0)[1] - 1
    local diags = vim.diagnostic.get(0, { lnum = line })

    if #diags == 0 then
        if vim.o.cmdheight ~= 1 then
            vim.o.cmdheight = 1
            vim.cmd.redraw()
        end
        vim.api.nvim_echo({}, false, {})
        return
    end

    table.sort(diags, function(a, b) return a.severity < b.severity end)
    local d = diags[1]
    local severity_map = { [1] = 'Error', [2] = 'Warn', [3] = 'Info', [4] = 'Hint' }
    local hl = 'Diagnostic' .. severity_map[d.severity]
    local icon = icons[severity_map[d.severity]]

    -- 1. Clean the message
    local raw_msg = d.message
    raw_msg = raw_msg:gsub('\n', ' ')      -- Replace newlines with spaces
    raw_msg = raw_msg:gsub('%s+', ' ')     -- Collapse multiple spaces
    raw_msg = vim.trim(raw_msg)            -- Trim edges

    -- 2. Build the full message with icon
    local full_msg = icon .. ' :' .. raw_msg
    
    -- 3. Calculate required height dynamically
    local screen_width = vim.o.columns
    local msg_len = vim.fn.strdisplaywidth(full_msg)  -- Use display width for proper calculation
    
    -- Account for padding and safety margin (12 chars for safety)
    local usable_width = screen_width - 12
    
    -- Calculate how many lines we need
    local required_height = math.ceil(msg_len / usable_width)
    
    -- Cap at reasonable maximum (e.g., 5 lines)
    local target_height = math.min(required_height, 10) -- increase/decrease
    target_height = math.max(target_height, 1)  -- At least 1 line

    -- 4. Update cmdheight if needed
    if vim.o.cmdheight ~= target_height then
        vim.o.cmdheight = target_height
        vim.cmd.redraw()
    end

    -- 5. Truncate message if it's still too long
    local max_chars = (usable_width * target_height)
    if msg_len > max_chars then
        -- Truncate using display width aware function
        local truncated = ''
        local current_width = 0
        for char in full_msg:gmatch('.') do
            local char_width = vim.fn.strdisplaywidth(char)
            if current_width + char_width > max_chars - 3 then
                truncated = truncated .. '...'
                break
            end
            truncated = truncated .. char
            current_width = current_width + char_width
        end
        full_msg = truncated
    end

    -- 6. Display the message
    vim.api.nvim_echo({ { full_msg, hl } }, false, {})
end

local safe_echo = vim.schedule_wrap(dynamic_stealth_echo)

vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    callback = function()
        echo_timer:stop()
        echo_timer:start(20, 0, safe_echo)
    end,
})

-- 3. The "Silence" Settings
vim.opt.shortmess:append('AFWc')

vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = icons.Error,
            [vim.diagnostic.severity.WARN]  = icons.Warn,
            [vim.diagnostic.severity.INFO]  = icons.Info,
            [vim.diagnostic.severity.HINT]  = icons.Hint,
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticLineError',
            [vim.diagnostic.severity.WARN]  = 'DiagnosticLineWarn',
            [vim.diagnostic.severity.INFO]  = 'DiagnosticLineInfo',
            [vim.diagnostic.severity.HINT]  = 'DiagnosticLineHint',
        },
    },
    severity_sort = true,
    update_in_insert = false,
})

-- Make unnecessary code use Warn color but NO underline
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { link = "DiagnosticWarn" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineUnnecessary", { 
    fg = "NONE",
    bg = "NONE",
    sp = "NONE",
    undercurl = false,
    underline = false,
})

-- Fixed keymaps (you had both mapped to <M-j>)
vim.keymap.set('n', '<M-j>', function() vim.diagnostic.jump({count = 1}) end, {desc = "next diagnostic"})
vim.keymap.set('n', '<M-k>', function() vim.diagnostic.jump({count = -1}) end, {desc = "prev diagnostic"})

vim.keymap.set('n', 'tt', function()
    local line = vim.api.nvim_win_get_cursor(0)[1] - 1
    
    -- Open float with a filter function instead of a temp namespace
    vim.diagnostic.open_float({
        border = 'rounded',
        focusable = true,
        source = 'always',
        severity_sort = true,
        -- This is the key: filter diagnostics on the fly
        filter = function(d)
            return d.severity ~= vim.diagnostic.severity.ERROR
        end,
        -- Check if any non-error diagnostics exist before showing empty box
        check_out_of_range = true,
    })
end, { desc = "Show warnings/hints/info (no errors)" })

