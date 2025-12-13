vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.fileformat = "unix"
opt.fileformats = "unix,dos"

opt.scrolloff = 4

-- disable banner netrw dan add relative number into netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 0
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.wo.number = true
		vim.wo.relativenumber = true
	end,
})

-- tab & indentation
opt.tabstop = 2 -- spaces, for tabs (prettier default)
opt.shiftwidth = 2 -- spaces for indent width
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

-- search setting
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.cursorline = true

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- Persistent Folding
opt.foldmethod = "manual" -- Atur metode fold ke 'manual' atau metode yang kamu gunakan.
opt.foldlevelstart = 0 -- Membuka semua fold saat file dibuka.
opt.foldenable = true -- Mengaktifkan fold saat Neovim dibuka.
opt.foldcolumn = "1" -- Menampilkan kolom fold di sisi kiri.
-- vim.cmd([[
--   augroup remember_folds
--     autocmd!
--     autocmd BufWinLeave *.* mkview
--     autocmd BufWinEnter *.* silent! loadview
--   augroup END
-- ]])
vim.opt.autochdir = false

-- **test save fold**
-- Auto save and restore folds
vim.opt.foldmethod = "manual" -- atau 'indent', 'syntax', dll
vim.opt.viewoptions = "folds,cursor"

-- Create autocmd group
local save_fold = vim.api.nvim_create_augroup("Persistent Folds", { clear = true })

-- Save fold on write
vim.api.nvim_create_autocmd("BufWinLeave", {
	pattern = "*.*",
	group = save_fold,
	command = "mkview",
})

-- Load fold on open
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*.*",
	group = save_fold,
	command = "silent! loadview",
})
-- vim.opt.guicursor = ""
