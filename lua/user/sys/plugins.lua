-- Enable Lua module caching
vim.loader.enable(true)
-- =====================
-- (1) Bootstrap lazy.nvim
-- =====================
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- =====================
-- Plugins (lazy.nvim)
-- =====================
require('lazy').setup({
    spec = {
        -- ===========================
        -- Plugin Managers (load early)
        -- ===========================
        -- {
        --     'williamboman/mason.nvim',
        --     cmd = { 'Mason', 'MasonInstall', 'MasonUpdate' },
        --     build = ':MasonUpdate',
        -- },

        -- ===========================
        -- Core Dependencies (lazy loaded)
        -- ===========================
        { 'nvim-lua/plenary.nvim',        lazy = true },
        { 'MunifTanjim/nui.nvim',         lazy = true },
        { 'nvim-tree/nvim-web-devicons',  lazy = true },
        { 'echasnovski/mini.icons',       version = false, lazy = true },
        { 'nvim-neotest/nvim-nio',        lazy = true },

        -- ===========================
        -- Snippets
        -- ===========================
        { 'rafamadriz/friendly-snippets', lazy = true },
        { 'honza/vim-snippets',           lazy = true },
        {
            'L3MON4D3/LuaSnip',
            commit = '5a1e392',
            lazy = true,
            dependencies = {
                'rafamadriz/friendly-snippets',
                'honza/vim-snippets',
            },
        },

        -- ===========================
        -- Completion (load on insert)
        -- ===========================
        {
            'saghen/blink.cmp',
            commit = 'b19413d',
            event = 'InsertEnter',
            dependencies = {
                'rafamadriz/friendly-snippets',
            },
        },

        -- ===========================
        -- LSP (load on file open)
        -- ===========================
        {
            'neovim/nvim-lspconfig',
            commit = '5bfcc89',
            event = { 'BufReadPre', 'BufNewFile' },
        },
        { 'onsails/lspkind-nvim',
            commit = 'c7274c4',
            lazy = true },
        {
            'SmiteshP/nvim-navic',
            commit = 'f5eba19',
            lazy = true,
            dependencies = {
                'neovim/nvim-lspconfig',
                commit = "5bfcc89",
            },
        },
        {
            'rmagatti/goto-preview',
            commit = 'd2d6923',
            event = 'LspAttach',
            dependencies = {
                'rmagatti/logger.nvim',
                commit = '63dd10c',
            },
            config = true,
        },
        {
            'folke/trouble.nvim',
            commit = 'bd67efe',
            opts = {}, -- for default options, refer to the configuration section for custom setup.
            event = 'BufReadPre',
            keys = {
                {
                    '<leader>tt',
                    '<cmd>Trouble diagnostics toggle<cr>',
                    desc = 'Trouble Toggle',
                },
            },
        },

        {
            'saecki/crates.nvim',
            commit = 'afcd1cc',
            event = 'Bufread Cargo.toml',
            tag = 'stable',
            config = function()
                require('crates').setup()
            end,
        },

        -- ===========================
        -- Formatting & Diagnostics
        -- ===========================
        {
            'stevearc/conform.nvim',
            commit = 'c2526f1',
            event = 'BufWritePre',
        },

        -- ===========================
        -- DAP (Debug Adapter Protocol)
        -- ===========================
        {
            'mfussenegger/nvim-dap',
            commit = '6a5bba0',
            cmd = { 'DapContinue', 'DapToggleBreakpoint', 'DapStepOver', 'DapStepInto', 'DapStepOut' },
        },
        {
            'rcarriga/nvim-dap-ui',
            commit = 'cf91d5e',
            dependencies = { 'mfussenegger/nvim-dap',
                'nvim-neotest/nvim-nio'
            },
            cmd = { 'DapContinue', 'DapToggleBreakpoint' },
        },
        {
            'theHamsta/nvim-dap-virtual-text',
            commit = 'fbdb48c',
            dependencies = { 'mfussenegger/nvim-dap' },
            event = 'LspAttach',
        },

        -- ===========================
        -- UI Components
        -- ===========================
        {
            'nvim-lualine/lualine.nvim',
            commit = '47f91c4',
            event = 'VeryLazy',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
        },
        {
            'willothy/nvim-cokeline',
            commit = '9fbed13',
        },
        {
            'lukas-reineke/indent-blankline.nvim',
            main = 'ibl',
            commit = '005b560',
            event = { 'BufReadPost', 'BufNewFile' },
        },
        {
            'goolord/alpha-nvim',
            commit = '3979b01',
            event = 'VimEnter',
            dependencies = {
                'MaximilianLloyd/ascii.nvim',
                commit = '70783fe',
            },
        },
        {
            'stevearc/dressing.nvim',
            commit = '3a45525',
            event = 'VeryLazy',
        },
        {
            'rcarriga/nvim-notify',
            commit = 'a3020c2',
            event = 'VeryLazy',
        },
        {
            'beauwilliams/focus.nvim',
            commit = '4135f97',
            cmd = { 'FocusSplitNicely', 'FocusSplitCycle', 'FocusToggle' },
        },

        -- ===========================
        -- Treesitter (load on file open)
        -- ===========================
        {
            'nvim-treesitter/nvim-treesitter',
            commit = '42fc28b',
            build = ':TSUpdate',
            event = { 'BufReadPost', 'BufNewFile' },
        },

        -- ===========================
        -- File Exploration (lazy load)
        -- ===========================
        {
            'stevearc/oil.nvim',
            commit = '975a77c',
            dependencies = { 'echasnovski/mini.icons' },
        },

        {
            'ibhagwan/fzf-lua',
            commit = '518ab7a',
        },

        {
            'ggandor/leap.nvim',
            commit = 'f19d435',
        },

        {
            'mikavilpas/yazi.nvim',
            commit = '5634692',
            event = 'VeryLazy',
            keys = {
                {
                    '<leader>yod',
                    '<cmd>Yazi<cr>',
                    desc = 'Open cwd',
                },
                {
                    '<leader>yoc',
                    function()
                        require('yazi').yazi(nil, vim.fn.stdpath('config'))
                    end,
                    desc = 'Open runtime',
                },
                {
                    '<leader>you',
                    function()
                        require('yazi').yazi(nil, vim.fn.stdpath('config') .. '/lua/user/')
                    end,
                    desc = 'Open user/',
                },
            },
            opts = {
                open_for_directories = false, -- Keep oil as default
                keymaps = {
                    show_help = '<f1>',
                    '<leader>yoh',
                    open_file_in_vertical_split = '<c-v>',
                    open_file_in_horizontal_split = '<c-x>',
                    open_file_in_tab = '<c-t>',
                    grep_in_directory = '<c-g>',
                    replace_in_directory = '<c-r>',
                    cycle_open_buffers = '<tab>',
                    copy_relative_path_to_selected_files = '<c-y>',
                    send_to_quickfix_list = '<c-q>',
                },
            },
        },

        {
            'kdheepak/lazygit.nvim',
            commit = 'a04ad0d',
            Lazy = false,
            cmd = {
                'LazyGit',
                'LazyGitConfig',
                'LazyGitCurrentFile',
                'LazyGitFilter',
                'LazyGitFilterCurrentFile',
            },
            dependencies = {
                'nvim-lua/plenary.nvim',
            },
        },

        -- ===========================
        -- Editor Enhancements
        -- ===========================
        {
            'kylechui/nvim-surround',
            commit = 'fcfa7e0',
            event = 'VeryLazy',
            config = true,
        },
        {
            'numToStr/Comment.nvim',
            commit = 'e51f2b1',
            keys = {
                { 'gcc', mode = 'n',          desc = 'Comment line' },
                { 'gc',  mode = { 'n', 'v' }, desc = 'Comment' },
            },
        },
        {
            {
                'akinsho/toggleterm.nvim',
                commit = '50ea089',
                lazy = true,
                config = true
            },
        },

        -- ===========================
        -- Navigation & Movement
        -- ===========================

        -- ===========================
        -- Utility Features
        -- ===========================
        {
            'folke/which-key.nvim',
            commit = '3aab214',
            event = 'VeryLazy',
        },
        {
            'mg979/vim-visual-multi',
            commit = 'a6975e7',
            event = 'VeryLazy',
        },
        {
            'mbbill/undotree',
            commit = '178d19e',
            cmd = 'UndotreeToggle',
        },
        {
            'gbprod/yanky.nvim',
            commit = '29f31f7',
            event = 'VeryLazy',
        },
        {
            'nvzone/showkeys',
            commit = 'cb0a502',
            event = 'VeryLazy'
        },
        -- ===========================
        -- AI Completion
        -- ===========================
        -- {
        --     "monkoose/neocodeium",
        --     event = "InsertEnter",
        --     config = function()
        --         local neocodeium = require("neocodeium")
        --         neocodeium.setup()
        --         vim.keymap.set("i", "<A-f>", neocodeium.accept)
        --         vim.keymap.set("i", "<A-w>", neocodeium.accept_word)
        --         vim.keymap.set("i", "<A-l>", neocodeium.accept_line)
        --         vim.keymap.set("i", "<A-n>", neocodeium.cycle_or_complete)
        --         vim.keymap.set("i", "<A-p>", function() neocodeium.cycle_or_complete(-1) end)
        --         vim.keymap.set("i", "<A-c>", neocodeium.clear)
        --     end,
        -- },
        --
        -- ===========================
        -- Session Management
        -- ===========================
        {
            'stevearc/resession.nvim',
            commit = 'cc819b0',
            lazy = true,
        },

        -- ===========================
        -- Mini.nvim Suite
        -- ===========================
        -- {
        --     'nvim-mini/mini.indentscope',
        --     commit = '0308f94',
        --     event = 'BufReadPost',
        -- },
        {
            'nvim-mini/mini.notify',
            commit = '29ec27f',
        },

        {
            'windwp/nvim-autopairs',
            commit = '59bce2e',
            dependencies = {
                'saghen/blink.cmp',
                commit = 'b19413d',
            },
            lazy = true,
        },

        -- ===========================
        -- Colorschemes (all lazy loaded)
        -- ===========================
        {
            'catppuccin/nvim',
            commit = 'beaf41a',
        },
        {
            'EdenEast/nightfox.nvim',
            commit = 'ba47d4b',
        },
        {
            'rose-pine/neovim',
            commit = 'cf2a288',
        },
        {
            'folke/tokyonight.nvim',
            commit = '5da1b76',
        },
    },

    -- ============================
    -- Configuration
    -- ============================
    concurrency = 5,

    git = {
        timeout = 300,
        url_format = 'https://github.com/%s.git',
    },

    install = {
        missing = true,
        colorscheme = { 'catppuccin' }, -- Fallback colorscheme during install
    },

    rocks = {
        enabled = false,   -- unnecessary for now
        hererocks = false, -- use system one
    },

    checker = {
        enabled = false,
        notify = false,
        frequency = 3600,
    },

    change_detection = {
        enabled = false,
        notify = false, -- Less noise
    },

    performance = {
        cache = {
            enabled = true,
        },
        reset_packpath = true,
        rtp = {
            reset = true,
            paths = {},
            disabled_plugins = {
                'gzip',
                'matchit',
                'matchparen',
                'netrwPlugin',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },

    defaults = {
        pin = true,
        -- lazy = true, -- Make all plugins lazy by default
        -- version = false,
    },

    ui = {
        border = 'rounded',
        size = { width = 0.88, height = 0.9 },
        wrap = false,
        title = '   Lazy Plugin Manager ',
        backdrop = 70,
        icons = {
            cmd        = '󰘳 ', -- command / terminal
            config     = '󰒓 ', -- config / settings
            event      = '󰚌 ', -- events / hooks
            ft         = '󰈙 ', -- filetype
            init       = '󰒓 ', -- init / setup
            import     = '󰋺 ', -- import / module
            keys       = '󰌌 ', -- keybindings
            lazy       = '󰒲 ', -- lazy.nvim (kept)
            loaded     = '󰄬 ', -- check / loaded
            not_loaded = '󰄱 ', -- close / disabled
            plugin     = '󰂖 ', -- plugin / package
            runtime    = '󰆦 ', -- runtime / engine
            source     = '󰉋 ', -- source / repo
            start      = '󰐊 ', -- start / play
            task       = '󰆕 ', -- task / todo
            list       = { '󰬪', '󰬜', '󰬐', '󰬅' },
        }
    },
})

-- ===============================
-- 🌈 Theme adaptation
-- ===============================
-- vim.api.nvim_create_autocmd('ColorScheme', {
--     callback = function()
--         local normal_bg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg or '#1e1e2e'
--         local accent = vim.api.nvim_get_hl(0, { name = 'String' }).fg or '#89b4fa'
--         vim.api.nvim_set_hl(0, 'LazyButtonActive', { fg = normal_bg, bg = accent, bold = true })
--         vim.api.nvim_set_hl(0, 'LazyProgressDone', { fg = accent })
--     end,
-- })

-- ============================
-- Batch Control Commands
-- ============================
vim.api.nvim_create_user_command('LazyInstallBatch', function(opts)
    local count = tonumber(opts.args) or 5
    vim.notify('Installing ' .. count .. ' plugins at a time...', vim.log.levels.INFO)
    local lazy_config = require('lazy.core.config')
    local original = lazy_config.options.concurrency
    lazy_config.options.concurrency = count
    require('lazy').install({ wait = true })
    lazy_config.options.concurrency = original
end, { nargs = '?' })

vim.api.nvim_create_user_command('LazyUpdateBatch', function(opts)
    local count = tonumber(opts.args) or 5
    vim.notify('Updating ' .. count .. ' plugins at a time...', vim.log.levels.INFO)
    local lazy_config = require('lazy.core.config')
    local original = lazy_config.options.concurrency
    lazy_config.options.concurrency = count
    require('lazy').update({ wait = true })
    lazy_config.options.concurrency = original
end, { nargs = '?' })

vim.api.nvim_create_user_command('LazySyncBatch', function(opts)
    local count = tonumber(opts.args) or 5
    vim.notify('Syncing ' .. count .. ' plugins at a time...', vim.log.levels.INFO)
    local lazy_config = require('lazy.core.config')
    local original = lazy_config.options.concurrency
    lazy_config.options.concurrency = count
    require('lazy').sync({ wait = true })
    lazy_config.options.concurrency = original
end, { nargs = '?' })

vim.api.nvim_create_user_command('LazySetBatch', function(opts)
    local count = tonumber(opts.args) or 5
    require('lazy.core.config').options.concurrency = count
    vim.notify('Batch size set to: ' .. count, vim.log.levels.INFO)
end, { nargs = 1 })
