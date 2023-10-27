require("luba")

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- configuring pencil to startup for markdown and text files
vim.cmd("filetype plugin on")

vim.cmd([[
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END
]])

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local cfg = {
	bind = true,
	floating_window_off_x = 1, -- adjust float windows x position.
	floating_window_off_y = function() -- adjust float windows y position. e.g. set to -2 can make floating window move up 2 lines
		local linenr = vim.api.nvim_win_get_cursor(0)[1] -- buf line number
		local pumheight = vim.o.pumheight
		local winline = vim.fn.winline() -- line number in the window
		local winheight = vim.fn.winheight(0)

		-- window top
		if winline - 1 < pumheight then
			return pumheight
		end

		-- window bottom
		if winheight - winline < pumheight then
			return -pumheight
		end
		return 0
	end,
} -- add your config here
require("lsp_signature").setup(cfg)
