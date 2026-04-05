-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Start Dashboard
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local arg = vim.fn.argv(0)
		if type(arg) == "string" and arg ~= "" and vim.fn.isdirectory(arg) == 1 then
			vim.api.nvim_set_current_dir(arg)
			require("dashboard"):instance(false)
		end
	end,
})

-- Force text wrap on buffers
local wrap_group = vim.api.nvim_create_augroup("ForceWrap", { clear = true })

vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter", "TermOpen" }, {
	group = wrap_group,
	callback = function(event)
		-- vim.schedule defers execution until the plugin (Gitsigns) finishes all its internal setups
		vim.schedule(function()
			-- Safety check to ensure the buffer wasn't closed during the micro-delay
			if not vim.api.nvim_buf_is_valid(event.buf) then
				return
			end

			-- Find all windows currently displaying the buffer
			local wins = vim.fn.win_findbuf(event.buf)

			for _, win in ipairs(wins) do
				-- Ensure the window is still valid and skip floating windows
				if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_config(win).relative == "" then
					vim.wo[win].wrap = true
					vim.wo[win].linebreak = true
					vim.wo[win].breakindent = true
				end
			end
		end)
	end,
})

-- Force text wrap and line numbers ONLY for Telescope previews
vim.api.nvim_create_autocmd("User", {
	pattern = "TelescopePreviewerLoaded",
	callback = function()
		-- vim.wo applies these settings exclusively to the active window (the preview)
		vim.wo.wrap = true
		vim.wo.linebreak = true
		vim.wo.number = true
	end,
})

-- Setup custom git diff colors
local custom_highlights = vim.api.nvim_create_augroup("CustomHighlights", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
	group = custom_highlights,
	pattern = "*", -- Applies to any colorscheme you load
	callback = function()
		vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#1c2328", fg = "NONE" })
		vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#291c23", fg = "NONE" })
		vim.api.nvim_set_hl(0, "DiffChange", { bg = "NONE", fg = "NONE" })
		vim.api.nvim_set_hl(0, "DiffText", { bg = "#2c4460", fg = "NONE" })
	end,
})
