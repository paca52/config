vim.keymap.set("n", ";", ":", { desc = "Enter command mode" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })

-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previos diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, { desc = "Go to next diagnostic message" })

-- Exiting terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Moving between panes
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left buffer" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower buffer" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper buffer" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right buffer" })

-- Highlight text when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	desc = "Highlight when yanking text",
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Keep the cursor in the middle when moving up/down
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move half a screen up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move half a screen down" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Jump to the next match" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Jump to the previous match" })

-- Move selected blocks of code up/down
vim.keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv", { desc = "Move selected block one line down" })
vim.keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv", { desc = "Move selected block one line up" })
