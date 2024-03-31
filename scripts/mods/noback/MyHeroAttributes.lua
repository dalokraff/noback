
MyHeroAttributes = class(MyHeroAttributes)

local DEFAULT_READ_ONLY_ATTRIBUTES = {
	bright_wizard_experience = 0,
	bright_wizard_experience_pool = 0,
	bright_wizard_prestige = 0,
	dwarf_ranger_experience = 0,
	dwarf_ranger_experience_pool = 0,
	dwarf_ranger_prestige = 0,
	empire_soldier_experience = 0,
	empire_soldier_experience_pool = 0,
	empire_soldier_prestige = 0,
	empire_soldier_tutorial_experience = 0,
	empire_soldier_tutorial_experience_pool = 0,
	empire_soldier_tutorial_prestige = 0,
	witch_hunter_experience = 0,
	witch_hunter_experience_pool = 0,
	witch_hunter_prestige = 0,
	wood_elf_experience = 0,
	wood_elf_experience_pool = 0,
	wood_elf_prestige = 0,
}
local DEFAULT_CHARACTER_ATTRIBUTES = {
	bot_career = 1,
	career = 1,
}

MyHeroAttributes.init = function (self, attributes)
	self._attributes = attributes
	self._attributes_to_save = {}
	self:_refresh()
	self._initialized = true
end

MyHeroAttributes.make_dirty = function (self)
	self._dirty = true
end

MyHeroAttributes._refresh = function (self)

end

MyHeroAttributes.ready = function (self)
    return true
end

MyHeroAttributes.update = function (self, dt)
	return
end

MyHeroAttributes.get = function (self, hero, attribute)
	if self._dirty then
		self:_refresh()
	end

	local key = hero .. "_" .. attribute

	return self._attributes[key]
end

MyHeroAttributes.set = function (self, hero, attribute, value)

end
