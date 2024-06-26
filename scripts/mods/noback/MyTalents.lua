local mod = get_mod("noback")
MyTalents = class(MyTalents)

MyTalents.init = function (self, talents)
	self._talents = {}

	self:_refresh()
end

MyTalents._refresh = function (self)
	local talents = self._talents

	for career_name, settings in pairs(CareerSettings) do
		local career_key = career_name.."talents"
		if career_key then
			local talent_string = mod:get(career_key)

			if talent_string then
				local career_talents = string.split(talent_string, ",")

				for i = 1, #career_talents do
					career_talents[i] = tonumber(career_talents[i])
				end
				self:_validate_talents(career_name, career_talents, settings.talent_tree_index)

				talents[career_name] = career_talents
			else
				local career_talents = {1,1,1,1,1,1}
				self:_validate_talents(career_name, career_talents, settings.talent_tree_index)
				talents[career_name] = career_talents
			end
		else
			local career_talents = {1,1,1,1,1,1}
			self:_validate_talents(career_name, career_talents, settings.talent_tree_index)
			talents[career_name] = career_talents
		end


	end

	self._dirty = false
end

MyTalents._validate_talents = function (self, career_name, career_talents, talent_tree_index)
	local profile = PROFILES_BY_CAREER_NAMES[career_name]

	if not profile then
		return
	end

	local profile_name = profile.display_name
	local hero_experience = 999999
	local hero_level = ExperienceSettings.get_level(hero_experience)
	local override_talents = PlayerUtils.get_talent_overrides_by_career(career_name)
	local talent_trees = TalentTrees[profile_name]
	local talent_tree = talent_trees and talent_trees[talent_tree_index]
	local changed = false

	for i = 1, #career_talents do
		local selected_talent = career_talents[i]

		if selected_talent > 0 then
			if false then
				career_talents[i] = 0
				changed = true
			elseif override_talents and talent_tree then
				local selected_talent_name = talent_tree[i][selected_talent]

				if override_talents[selected_talent_name] == false then
					career_talents[i] = 0
					changed = true
				end
			end
		end
	end

	if changed then
		self:set_talents(career_name, career_talents)
	end
end

MyTalents.ready = function (self)
	return true
end

MyTalents.update = function (self, dt)
	return
end

MyTalents.make_dirty = function (self)
	self._dirty = true
end

MyTalents.get_talent_ids = function (self, career_name)
	local career_settings = CareerSettings[career_name]
	local profile_name = career_settings.profile_name
	local talent_tree_index = career_settings.talent_tree_index
	local talent_tree = talent_tree_index and TalentTrees[profile_name][talent_tree_index]
	local talent_ids = {}
	local talents = self:get_talents(career_name)

	if talents and talent_tree then
		for i = 1, #talents do
			local column = talents[i]

			if column ~= 0 then
				local talent_name = talent_tree[i][column]
				local talent_lookup = TalentIDLookup[talent_name]

				if talent_lookup and talent_lookup.talent_id then
					talent_ids[#talent_ids + 1] = talent_lookup.talent_id
				end
			end
		end
	end

	return talent_ids
end

MyTalents.get_talent_tree = function (self, career_name)
	local career_settings = CareerSettings[career_name]
	local profile_name = career_settings.profile_name
	local talent_tree_index = career_settings.talent_tree_index
	local talent_tree = talent_tree_index and TalentTrees[profile_name][talent_tree_index]

	return talent_tree
end

MyTalents.set_talents = function (self, career_name, talents)
	local talent_string = ""

	for i = 1, #talents do
		local value = talents[i]

		if i == #talents then
			talent_string = talent_string .. value
		else
			talent_string = talent_string .. value .. ","
		end
	end

	local career_key = career_name.."talents"
	if career_key then
		mod:set(career_key, talent_string)
	end

	self._dirty = true
end

MyTalents.get_talents = function (self, career_name)
	if self._dirty then
		self:_refresh()
	end

	local talents = self._talents[career_name]

	return talents
end
