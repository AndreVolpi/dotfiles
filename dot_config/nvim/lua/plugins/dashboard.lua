return {
	"goolord/alpha-nvim",
	config = function()
		local alpha = require("alpha")
		local d = require("alpha.themes.dashboard")

		d.section.header.val = {
			[[⠀⠀⠀⠀⠀⢀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⠀⣸⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⠀⢠⡟⠘⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⠀⢰⡟⠀⠀⠈⠻⣷⣤⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⠀⣠⡟⠀⠀⠀⠀⠀⠈⢻⡿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⠀⣰⡟⠀⠀⠀⠀⠀⠀⠀⠀⠻⠸⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
			[[⢰⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣇⠀⣠⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⠀⠀⠀⠀⠀⠀⠀]],
			[[⣾⡁⢀⣠⠴⠒⠲⣤⣠⠶⠋⠳⣤⣸⣿⣰⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀]],
			[[⣿⠟⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⣽⠏⣿⡿⢿⣿⣿⣿⣷⣄⠀⠀⠀⠀⢠⣾⣿⣿⣿⠋⢹⡇⠀⠀⠀⠀⠀⠀]],
			[[⢹⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡟⠀⣿⠁⠀⠙⣿⡛⠛⢿⡶⠶⠶⠶⣿⣄⣀⣰⠃⠀⢸⡇⠀⠀⠀⠀⠀⠀]],
			[[⠈⢷⡀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡿⠁⠀⣿⠀⠀⠀⠈⢷⡀⠘⠛⠀⠀⠀⠀⠈⠉⠳⣄⠀⢸⡇⠀⠀⠀⠀⠀⠀]],
			[[⠀⠈⢿⣦⡀⠀⠀⠀⠀⠀⢀⣿⣇⣀⠀⢻⠀⠀⠀⠀⢰⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⣾⠃⠀⣤⣤⣄⠀⠀]],
			[[⠀⠀⠀⠉⠻⢶⣄⣠⣴⠞⠛⠉⠉⠙⠻⢾⣇⠀⢀⣰⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡄⠀⣿⢩⡿⣿⡆]],
			[[⠀⠀⠀⠀⣠⣴⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀⢹⡷⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⣿⣟⣵⡿⠁]],
			[[⠀⢀⣠⡾⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣇⠀⠀⠀⣴⣿⠀⠀⠀⠀⠀⠀⢠⣶⠀⠀⣸⡇⠀⠙⠋⠁⠀⠀]],
			[[⢸⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣄⣈⣀⣙⣁⠀⠀⣶⣾⡶⠀⠻⠿⠀⢠⣿⣁⡀⠀⠀⠀⠀⠀]],
			[[⠈⠛⠻⠿⠶⠶⠶⡤⣤⣤⣤⣄⣀⣤⣀⣠⣤⣀⣀⣹⣿⣿⣿⣿⣤⣽⣿⣴⣶⣶⡦⢼⣿⣿⣿⣿⠇⠀⠀⠀⠀]],
			[[            Welcome, Kurumas             ]],
		}

		d.section.buttons.val = {
			d.button("f", "󰈞  Find File", ":Telescope find_files<CR>"),
			d.button("r", "󰄉  Recent Files", ":Telescope frecency workspace=CWD<CR>"),
			d.button("g", "󰊢  Git Status", ":Telescope git_status<CR>"),
			d.button("n", "  New File", ":ene <BAR> startinsert <CR>"),
			d.button("q", "󰅚  Quit", ":qa<CR>"),
		}

		local function get_git_status()
			local handle = io.popen("git status --short 2>/dev/null")
			if not handle then
				return {}
			end
			local output = handle:read("*a")
			handle:close()

			if output == "" then
				return {
					{ type = "text", val = "󰄬  Git directory clean", opts = { hl = "String", position = "center" } },
				}
			end

			local results = {
				{
					type = "text",
					val = "󰊢  Current Changes:",
					opts = { hl = "SpecialComment", position = "center" },
				},
				{ type = "padding", val = 1 },
			}

			for line in output:gmatch("[^\r\n]+") do
				table.insert(results, {
					type = "text",
					val = line,
					opts = { hl = "Keyword", position = "center" },
				})
			end

			return results
		end

		local git_section = {
			type = "group",
			val = get_git_status,
			opts = {},
		}

		d.config.layout = {
			{ type = "padding", val = 2 },
			d.section.header,
			{ type = "padding", val = 2 },
			d.section.buttons,
			{ type = "padding", val = 2 },
			git_section,
			{ type = "padding", val = 1 },
			d.section.footer,
		}

		alpha.setup(d.config)
	end,
}
