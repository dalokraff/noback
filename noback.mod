return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`noback` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("noback", {
			mod_script       = "scripts/mods/noback/noback",
			mod_data         = "scripts/mods/noback/noback_data",
			mod_localization = "scripts/mods/noback/noback_localization",
		})
	end,
	packages = {
		"resource_packages/noback/noback",
	},
}
