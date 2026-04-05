return {
	-- You can easily change to a different colorscheme.
	{
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("tokyonight").setup({
				styles = {
					comments = { italic = false }, -- Disable italics in comments
				},
			})

			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		---@module 'todo-comments'
		---@type TodoOptions
		---@diagnostic disable-next-line: missing-fields
		opts = { signs = false },
	},

	-- Show vertical lines for tabs that were replaced by spaces
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			-- 1. Add this exclude block
			exclude = {
				filetypes = {
					"dashboard", -- Ignores dashboard-nvim
					"help", -- Ignores :help pages
					"lazy", -- Ignores Lazy plugin manager UI
					"mason", -- Ignores Mason UI
					"terminal", -- Ignores built-in terminal buffers
				},
			},
			-- Your existing settings below
			indent = {
				char = "│",
			},
			scope = {
				enabled = true,
				show_start = false,
				show_end = false,
			},
		},
	},
}
