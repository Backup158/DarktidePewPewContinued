return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`PewPew` encountered an error loading the Darktide Mod Framework.")

		new_mod("PewPew", {
			mod_script       = "PewPew/scripts/mods/PewPew/PewPew",
			mod_data         = "PewPew/scripts/mods/PewPew/PewPew_data",
			mod_localization = "PewPew/scripts/mods/PewPew/PewPew_localization",
		})
	end,
	version = "1.10.1",
	packages = {},
}
