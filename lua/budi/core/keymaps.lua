vim.g.mapleader = " "

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- disable record default keymap and create :Record keymap
keymap.set("n", "q", "<nop>", opts)

keymap.set("n", "gh", "gg", { silent = true, desc = "go to top" })
keymap.set("n", "<leader>as", "o<esc>k", { noremap = true, silent = true, desc = "newline for normal mode" })
keymap.set("i", "<F2>", "<?= ?> <Left><Left><left>", { noremap = true, silent = true })
keymap.set("i", "<F3>", "<?php ?> <Left><Left><left>", { noremap = true, silent = true })

keymap.set("n", "<leader>p", "V$%", { desc = "pindah ke atas" })
keymap.set("v", "<A-j>", ":m .+1<CR>==", { desc = "pindah ke atas" })
keymap.set("v", "<A-k>", ":m .-2<CR>==", { desc = "pindah ke bawah" })

keymap.set("n", "<leader>re", "3:ToggleTerm direction=float<CR>", { noremap = true, silent = true, desc = "Floating" })
keymap.set("n", "<leader>tt", ":ToggleTerm direction=float<CR>", { noremap = true, silent = true, desc = "Floating" })
keymap.set("n", "<leader>tr", ":2ToggleTerm direction=float<CR>", { noremap = true, silent = true, desc = "2Floating" })
keymap.set(
	"n",
	"<leader>th",
	":ToggleTerm size=10 direction=horizontal<CR>",
	{ noremap = true, silent = true, desc = "horizontal" }
)
keymap.set("n", "<C-\\>", "<cmd>ToggleTerm<CR>", { desc = "Toggle Term" })
keymap.set("n", "ZAQ", "<cmd>qa!<CR>", { desc = "quit semuanya" })
keymap.set("i", "jk", "<ESC>", { desc = "Keluar dari insert mode" })
keymap.set("i", "dw", "<C-w>", { desc = "Delete word by double d" })
-- keymap.set("i", "cl", "console.log()<Left>", { desc = "Delete word by double d" })
-- keymap.set("i", "db", "<ESC>ldwi", { desc = "Delete word kedepan" })
keymap.set("i", "<C-s>", "<ESC>:w<CR>", { desc = "Save and go to normal mode" })
-- keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlight" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "split window vertically" }) -- split window vertically window
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "split window horizontal" }) -- split window vertically window
keymap.set("n", "<leader>se", "<C-w>=", { desc = "make splits equal size" }) -- split window vertically window
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "close current split" }) -- close current split window
-- keymap.set("n", "<leader>st", "<C-w>>", { desc = "increase size window" })
-- keymap.set("n", "<leader>sb", "<C-w><", { desc = "increase size window" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) -- go to text tab
keymap.set("n", "<leader>tb", "<cmd>tabp<CR>", { desc = "Go to prev tab" }) -- go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

keymap.set("n", "te", "tabedit", opts)
-- keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- select all
keymap.set("n", "<C-a>", "gg<S-v>G")

keymap.set("v", "//", [[y/\V<C-r>"<CR>]], { noremap = true, silent = true })

-- colorscheme change to solorized osaka
keymap.set("n", "<leader>coo", "<cmd>colorscheme solarized-osaka<CR>", { desc = "change to solorized-osaka" })
keymap.set("n", "<leader>cot", "<cmd>colorscheme tokyonight<CR>", { desc = "change to tokyonight" })
keymap.set("n", "<leader>cok", "<cmd>colorscheme kanagawa<CR>", { desc = "change to kanagawa" })
keymap.set("n", "<leader>cos", "<cmd>colorscheme shine<CR>", { desc = "change to shine" })
keymap.set("n", "<leader>cor", "<cmd>colorscheme rose-pine-moon<CR>", { desc = "change to rose-pine" })
keymap.set("n", "<leader>coc", "<cmd>colorscheme carbonfox<CR>", { desc = "change to carbonfox" })
keymap.set("n", "<leader>col", "<cmd>set bg=light<cr>", { desc = "change to light" })
keymap.set("n", "<leader>cod", "<cmd>set bg=dark<cr>", { desc = "change to dark" })

-- no highlight
keymap.set("n", "<leader>hi", ":nohl<CR>", { desc = "Clear search highlight" })
-- buat remap untuk :![apapun]
-- keymap.set("n", "<leader><leader>", ":! node .<CR>", { desc = "mencoba" })
keymap.set("n", "<leader><leader>", ":! node .<CR>", { desc = "mencoba" })
-- file explorer
keymap.set("n", "<leader>ef", ":Ex<CR>", { desc = "File explorer" })

-- drag visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "drag up" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "drag down" })

-- Format paragraph and restore cursor position
function FormatParagraph()
	local pos = vim.fn.getpos(".")
	vim.cmd("normal! =ap")
	vim.fn.setpos(".", pos)
end

keymap.set("n", "<leader>op", function()
	local view = vim.fn.winsaveview()
	vim.cmd("normal! gg=G")
	vim.fn.winrestview(view)
end, opts)

function FormatParagraph()
	local pos = vim.fn.getpos(".")
	vim.cmd("normal! =ap")
	vim.fn.setpos(".", pos)
end
keymap.set("n", "<leader>ap", ":lua FormatParagraph()<CR>", opts)

local function tambah_window(direction)
	-- NOTE: vim.v.count1 -> variable bawaan vim utk take number input user, jika tidak ada maka defaultnya 1
	local count = vim.v.count1
	if direction == "increase" then
		vim.cmd(tostring(count) .. "wincmd >")
	elseif direction == "decrease" then
		vim.cmd(tostring(count) .. "wincmd <")
	end
end

keymap.set("n", "<leader>st", function()
	tambah_window("increase")
end, { desc = "increase window" })

keymap.set("n", "<leader>sb", function()
	tambah_window("decrease")
end, { desc = "decrease window" })

keymap.set("n", "<leader>,,", function()
	vim.cmd(":%s/\r//g")
end)
-- Di init.lua
vim.keymap.set("n", "<leader>rr", ":source $MYVIMRC<CR>", { desc = "Reload config" })

vim.keymap.set("n", "<leader>cur", function()
	vim.opt.guicursor = ""
	print("Cursor set to block")
end, { desc = "Set cursor to block" })

vim.keymap.set("n", "<leader>za", function()
	if vim.wo.wrap then
		vim.wo.wrap = false
		vim.wo.linebreak = false
		print("Wrap: OFF")
	else
		vim.wo.wrap = true
		vim.wo.linebreak = true
		print("Wrap: ON")
	end
end, { desc = "Toggle wrap linebreak" })
