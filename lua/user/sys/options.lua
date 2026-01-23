local o = vim.o
vim.o.number = true
vim.o.relativenumber = false
o.cursorline = true
o.termguicolors = true
o.signcolumn = "yes"
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.smartindent = true
o.textwidth=0
vim.opt.softtabstop = 4
vim.opt.clipboard = "" 
vim.cmd("filetype plugin indent on")
-- Minimal custom tabline: show current file + indicator for more tabs
vim.o.showtabline = 2

vim.opt.timeoutlen = 200
vim.opt.updatetime = 100
vim.opt.ttimeoutlen = 10
vim.opt.lazyredraw = false -- keep off
vim.opt.ttyfast = true

vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.smartindent = true

vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.spell = true
vim.opt.spelllang = "en_us"



vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.g.mapleader = " "
vim.g.maplocalleader = "'"


-- Auto-fix with first suggestion
vim.keymap.set('n', '<leader>fw', function()
    local word = vim.fn.expand('<cword>')
    local suggestions = vim.fn.spellsuggest(word, 1)
    
    if #suggestions > 0 then
        vim.cmd('normal! ciw' .. suggestions[1])
        vim.cmd('stopinsert')
    else
        vim.notify('No spelling suggestions found', vim.log.levels.WARN)
    end
end, { desc = 'Fix spelling (first suggestion)' })

-- Quick spell check keybindings
vim.keymap.set('n', '<C-x>s', 'z=', { desc = 'Spelling suggestions' })

