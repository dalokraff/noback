local mod = get_mod("noback")
local SaveWeapon = get_mod("SaveWeapon")
local GiveWeapon = get_mod("GiveWeapon")

-- Your mod code goes here.
-- https://vmf-docs.verminti.de


-- mod:hook(BackendManagerPlayFab, '_post_error', function (func, self, error_data, crashify_override, ignore_crashify)

--     return
-- end)

mod:dofile("scripts/mods/noback/MyHeroAttributes")
mod:dofile("scripts/mods/noback/MyTalents")
mod:dofile("scripts/mods/noback/MyQuests")
mod:dofile("scripts/mods/noback/MyStats")
mod:dofile("scripts/mods/noback/MyLoot")
mod:dofile("scripts/mods/noback/MyItems")
mod:dofile("scripts/mods/noback/MyDLCs")
mod:dofile("scripts/mods/noback/MyNews")
mod:dofile("scripts/mods/noback/MyCommon")
mod:dofile("scripts/mods/noback/MyLiveInterface")

local DEFAULT_LOADOUTS = local_require("scripts/mods/noback/default_loadouts")


local local_hero_attributes = {
    empire_soldier_career = 1,
    empire_soldier_experience = 0
}

local local_save_data = {
    stats = {},
    user_data = {
		has_completed_tutorial = true
	}
}

local local_talents = {
}

local MyHeroAttributes_mod = MyHeroAttributes:new(local_hero_attributes)
local MyQuests_mod = MyQuests:new()
local MyStats_mod = MyStats:new()
local MyLoot_mod = MyLoot:new()
local MyDLCs_mod = MyDLCs:new()
local MyNews_mod = MyNews:new()
local MyCommon_mod = MyCommon:new()
local MyLiveInterface_mod = MyLiveInterface:new()
--default backend items so something can be used for initial load
local init_items = {
	{
		backend_id = 1,
		key = "es_longbow_tutorial",
		power_level = 10,
		rarity = "default",
		data = ItemMasterList.es_longbow_tutorial,
	},
	{
		backend_id = 2,
		key = "es_2h_hammer_tutorial",
		power_level = 10,
		rarity = "default",
		data = ItemMasterList.es_2h_hammer_tutorial,
	},
	{
		backend_id = 3,
		key = "skin_es_knight",
		rarity = "default",
		data = ItemMasterList.skin_es_knight,
	},
	{
		backend_id = 4,
		key = "knight_hat_0000",
		rarity = "default",
		data = ItemMasterList.knight_hat_0000,
	},
	{
		backend_id = 5,
		key = "dr_crossbow",
		power_level = 10,
		rarity = "default",
		data = ItemMasterList.dr_crossbow,
	},
	{
		backend_id = 6,
		key = "dr_1h_axe",
		power_level = 10,
		rarity = "default",
		data = ItemMasterList.dr_1h_axe,
	},
	{
		backend_id = 7,
		key = "skin_dr_ranger",
		rarity = "default",
		data = ItemMasterList.skin_dr_ranger,
	},
	{
		backend_id = 8,
		key = "ranger_hat_0000",
		rarity = "default",
		data = ItemMasterList.ranger_hat_0000,
	},
	{
		backend_id = 9,
		key = "we_longbow",
		power_level = 10,
		rarity = "default",
		data = ItemMasterList.we_longbow,
	},
	{
		backend_id = 10,
		key = "we_dual_wield_daggers",
		power_level = 10,
		rarity = "default",
		data = ItemMasterList.we_dual_wield_daggers,
	},
	{
		backend_id = 11,
		key = "skin_ww_waywatcher",
		rarity = "default",
		data = ItemMasterList.skin_ww_waywatcher,
	},
	{
		backend_id = 12,
		key = "waywatcher_hat_0000",
		rarity = "default",
		data = ItemMasterList.waywatcher_hat_0000,
	},
	{
		backend_id = 13,
		key = "bw_skullstaff_fireball",
		power_level = 10,
		rarity = "default",
		data = ItemMasterList.bw_skullstaff_fireball,
	},
	{
		backend_id = 14,
		key = "bw_1h_mace",
		power_level = 10,
		rarity = "default",
		data = ItemMasterList.bw_1h_mace,
	},
	{
		backend_id = 15,
		key = "skin_bw_adept",
		rarity = "default",
		data = ItemMasterList.skin_bw_adept,
	},
	{
		backend_id = 16,
		key = "adept_hat_0000",
		rarity = "default",
		data = ItemMasterList.adept_hat_0000,
	},
    {
		backend_id = 17,
		key = "ranger_hat_0000",
		rarity = "rare",
		data = ItemMasterList.ranger_hat_0000,
	},
}

MyItems_mod = MyItems:new(init_items)
MyItems_mod._loadouts.empire_soldier_tutorial = {
	slot_hat = 4,
	slot_melee = 2,
	slot_ranged = 1,
	slot_skin = 3,
}

mod.backend_interfaces = {
	hero_attributes = MyHeroAttributes_mod,
	quests = MyQuests_mod,
	stats = MyStats_mod,
    statistics = MyStats_mod,
	loot = MyLoot_mod,
	dlcs = MyDLCs_mod,
	peddler = MyNews_mod,
	common = MyCommon_mod,
	items = MyItems_mod,
    live_events = MyLiveInterface_mod
}


-- bypass career unlock check in CareerSettings
-- and for setting talent stuff
for career_name, setting_data in pairs(CareerSettings) do

    mod:hook(setting_data, 'is_unlocked_function', function(func, ...)
        return true
    end)

	local init_loadout = DEFAULT_LOADOUTS[career_name]
	if init_loadout then
    	MyItems_mod._loadouts[career_name] = table.clone(init_loadout)
	end

end

--fixes crash when opening inventory
mod:hook(GameMechanismManager, 'refresh_mechanism_setting_for_title', function(func, self)
    self._title_settings = Managers.backend:get_title_settings()
    return
end)

--unlocks maps and difficulties
mod:hook(UnlockManager, 'is_dlc_unlocked', function(func, ...)
    return true
end)
mod:hook(LevelUnlockUtils, 'level_unlocked', function(func,...)
    return true
end)
mod:hook(StartGameStateSettingsOverview, 'is_difficulty_approved', function(func,...)
    return true
end)
mod:hook(BulldozerPlayer, "best_aquired_power_level", function(func, ...)
	return 9001
end)
mod:hook(ExtraDifficultyRequirements.kill_all_lords_on_legend, 'requirement_function', function(func, ...)
	return true
end)
-- ExtraDifficultyRequirements.kill_all_lords_on_legend.requirement_function = function(...)
-- 	return true
-- end

--sets level so UI things can be unlocked
mod:hook(ExperienceSettings, 'get_level', function(func, experience)

    return 35.9001, 0, 0
end)

--skip intro video
mod:hook(TitleLoadingUI, 'init', function(func, self, world, params, force_done)
    return func(self, world, params, true)
end)

mod:hook(BackendManagerPlayFab, 'signin', function (func, self, authentication_token)
    GameSettingsDevelopment.use_backend = false
    GameSettingsDevelopment.backend_settings.allow_local = false


    self._save_data = {
        stats = {},
        user_data = {},
        has_completed_tutorial = true

    }

    self._interfaces.hero_attributes = MyHeroAttributes:new(local_hero_attributes)

	self:_create_interfaces(false)

    return func(self, authentication_token)
end)


mod:hook(BackendManagerPlayFab, 'signed_in', function (func, self)
    return true
end)

--fixes crash on title screen
mod:hook(BackendManagerPlayFab, 'get_user_data', function (func, self, key)
    self._save_data = local_save_data

    return self._save_data.user_data[key]
end)

mod:hook(BackendManagerPlayFab, 'get_interface', function(func, self, interface_name, player_id)

	if not self._interfaces[interface_name] then
		self._interfaces[interface_name] = mod.backend_interfaces[interface_name]

        if interface_name == "items" and SaveWeapon then
            SaveWeapon:load_items()
        end

		return mod.backend_interfaces[interface_name]
	end

    return func(self, interface_name, player_id)
end)

mod:hook(BackendManagerPlayFab, 'has_loaded', function (func, self)
    return true
end)

mod:hook(BackendManagerPlayFab, '_are_profiles_loaded', function (func, self)
    return true
end)

mod:hook(BackendManagerPlayFab, 'profiles_loaded', function (func, self)
    return true
end)

--need to revist this hook
mod:hook(BackendManagerPlayFab, 'set_talents_interface_override', function (func, self)
    return true
end)

mod:hook(BackendManagerPlayFab, 'get_talents_interface', function (func, self)
    self._interfaces.talents = MyTalents:new(local_talents)

    return self._interfaces.talents
end)

mod:hook(PlayerManager, 'add_player', function(func, self, input_source, viewport_name, viewport_world_name, local_player_id)
    if script_data.network_debug_connections then
		printf("PlayerManager:add_player %s", tostring(viewport_name))
	end

	local peer_id = Network.peer_id()
	local unique_id = PlayerUtils.unique_player_id(peer_id, local_player_id)
	local ui_id = self:_create_ui_id()
	local backend_id = Managers.backend:player_id()
	local player = BulldozerPlayer:new(self.network_manager, input_source, viewport_name, viewport_world_name, self.is_server, local_player_id, unique_id, ui_id, backend_id)

	self._players[unique_id] = player
	self._num_human_players = self._num_human_players + 1
	self._human_players[unique_id] = player
	self._local_human_player = player

	local player_table = self._players_by_peer

	player_table[peer_id] = player_table[peer_id] or {}
	player_table[peer_id][local_player_id] = player

	-- local stats = Managers.backend:get_interface("statistics"):get_stats()
    local stats = {}

	self._statistics_db:register(player:stats_id(), "player", stats)
	Managers.party:register_player(player, unique_id)

	if self.is_server and player:is_player_controlled() then
		Managers.telemetry_events:player_joined(player, self._num_human_players)
	end

	if IS_WINDOWS then
		Managers.account:update_presence()
	end

	return player
end)

mod:hook(BackendUtils, 'commit_load_time_data', function(func, load_time_data)
	return
end)

mod:hook(BackendUtils, 'has_loot_chest', function()
	return false
end)

mod:hook(BackendManagerPlayFab, 'stop_tutorial', function(func, self)
	self._interfaces.items = {}
	self._script_backend_items_backup = nil
	self._interfaces.hero_attributes = {}
	self._script_backend_hero_attributes_backup = nil
	self._is_tutorial_backend = false
	return
end)

--needed for playing callback at end of match without "waiting" for Playfab backend's response
mod:hook(BackendManagerPlayFab, 'commit', function(func, self, skip_queue, commit_complete_callback)
	mod:echo('BackendManagerPlayFab commiter '..tostring(commit_complete_callback))
    mod:echo(self._backend_mirror)

    if not self._backend_mirror then
        if type(commit_complete_callback) =='function' then
            commit_complete_callback('no error')
        end
        return
    end

    return func(self, skip_queue, commit_complete_callback)
end)

mod:hook(KeepDecorationPaintingExtension, 'get_selected_decoration', function(func, self)
	return DefaultPaintings[1]
end)

mod:hook(KeepDecorationPaintingExtension, '_set_selected_painting', function(func, self, painting)
	return
end)

mod:hook(ItemHelper, 'has_unseen_shop_items', function(func, self)
	return false
end)

mod:hook(StoreWorldMarkerExtension, '_extensions_ready', function(func, self)
	func(self)
	self._backend_store = {
		get_login_rewards = function(self)
			return nil
		end,
	}
end)

mod:hook(StartGameStateSettingsOverview, 'is_weekly_event_active', function(func, self)
	return false
end)


mod:hook(BackendInterfaceDLCsPlayfab, 'update_dlc_ownership', function(func, self)
    mod:echo("update_dlc_ownership")
    return func(self)
end)

mod:hook(PlayerUtils, 'get_talent_overrides_by_career', function(func, career_name)

    return
end)

mod:hook(KeepDecorationSystem, 'rpc_request_painting', function(func, self, channel_id)
    self.network_transmit:send_rpc_server("rpc_send_painting", "hor_none")
    return
end)

script_data.settings.disable_tutorial_at_start = true
script_data.disable_prologue = true