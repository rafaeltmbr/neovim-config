return {
	-- Custom wellcome screen dashboard (inspired by snack.nvim dashboard).
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		init = function()
			-- Disable netrw so it doesn't open for directories
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
		opts = function()
			local logo = [[
                                       __                
          ___     ___    ___   __  __ /\_\    ___ ___    
         / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  
        /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ 
        \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\
         \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/
    ]]
			logo = string.rep("\n", 8) .. logo .. "\n\n"

			local opts = {
				theme = "doom",
				hide = {
					statusline = false,
				},
				config = {
					header = vim.split(logo, "\n"),
					center = {
						{ action = "ene | startinsert", desc = " New File", icon = " ", key = "n" },
						{ action = "Telescope find_files", desc = " Find File", icon = " ", key = "f" },
						{ action = "Telescope live_grep", desc = " Find Text", icon = " ", key = "g" },
						{
							action = "Telescope oldfiles cwd_only=true",
							desc = " Recent Files",
							icon = " ",
							key = "r",
						},
						{ action = "Yazi", desc = " Yazi File Manager", icon = " ", key = "y" },
						{ action = "Lazy", desc = " Lazy", icon = " ", key = "l" },
						{ action = "e $MYVIMRC", desc = " Config", icon = " ", key = "c" },
						{ action = "qa", desc = " Quit", icon = " ", key = "q" },
					},
					footer = function()
						local stats = require("lazy").stats()
						local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
						return {
							"⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
						}
					end,
				},
			}
			for _, button in ipairs(opts.config.center) do
				button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
			end

			return opts
		end,
	},
}
