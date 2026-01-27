-- oil.nvim configuration for Neovim 0.11
-- A vim-vinegar like file explorer that lets you edit your filesystem like a buffer

require("oil").setup({
    -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
    default_file_explorer = true,

    -- Id is automatically added at the beginning, and name at the end
    columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
    },

    -- Buffer-local options to use for oil buffers
    buf_options = {
        buflisted = false,
        bufhidden = "hide",
    },

    -- Window-local options to use for oil buffers
    win_options = {
        wrap = true,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
    },

    -- Send deleted files to the trash instead of permanently deleting them
    delete_to_trash = true,

    -- Skip the confirmation popup for simple operations
    skip_confirm_for_simple_edits = false,

    -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
    prompt_save_on_select_new_entry = true,

    -- Oil will automatically delete hidden buffers after this delay
    cleanup_delay_ms = 2000,

    -- Set to true to watch the filesystem for changes and reload oil
    watch_for_changes = true,

    -- Keymaps in oil buffer
    keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
    },

    -- Set to false to disable all of the above keymaps
    use_default_keymaps = true,

    view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,

        -- This function defines what is considered a "hidden" file
        is_hidden_file = function(name, bufnr)
            return vim.startswith(name, ".")
        end,

        -- This function defines what will never be shown, even when `show_hidden` is set
        is_always_hidden = function(name, bufnr)
            return false
        end,

        -- Sort file names in a more intuitive order for humans
        natural_order = true,

        sort = {
            -- sort order can be "asc" or "desc"
            { "type", "asc" },
            { "name", "asc" },
        },
    },

    -- Configuration for the floating window in oil.open_float
    float = {
        -- Padding around the floating window
        padding = 2,
        max_width = 90,
        max_height = 30,
        border = "rounded",
        win_options = {
            winblend = 0,
        },
        -- This is the config that will be passed to nvim_open_win.
        override = function(conf)
            return conf
        end,
    },

    -- Configuration for the actions floating preview window
    preview = {
        -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        max_width = 0.9,
        -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
        min_width = { 40, 0.4 },
        -- optionally define an integer/float for the exact width of the preview window
        width = nil,
        -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        max_height = 0.9,
        min_height = { 5, 0.1 },
        height = nil,
        border = "rounded",
        win_options = {
            winblend = 0,
        },
        -- Whether the preview window is automatically updated when the cursor is moved
        update_on_cursor_moved = true,
    },

    -- Configuration for the floating progress window
    progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = "rounded",
        minimized_border = "none",
        win_options = {
            winblend = 0,
        },
    },

    -- Configuration for the floating SSH window
    ssh = {
        border = "rounded",
    },
})
-- Quick access - keep this for vim-vinegar style workflow
vim.keymap.set("n", "-", function()
    require("oil").open()
end, { desc = "Open parent directory in oil" })

-- Set up autocommand to configure oil buffers
vim.api.nvim_create_autocmd("FileType", {
    pattern = "oil",
    callback = function()
        vim.opt_local.colorcolumn = ""
    end,
})

-- Optional: Set tab settings for better alignment in oil buffers
vim.api.nvim_create_autocmd("FileType", {
    pattern = "oil",
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.expandtab = true
    end,
})
