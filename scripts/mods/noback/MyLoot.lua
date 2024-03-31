MyLoot = class(MyLoot)

MyLoot.init = function (self, backend_mirror)
	self._last_id = 0
	self._loot_requests = {}
	self._reward_poll_id = false
end

MyLoot.ready = function (self)
	return true
end

MyLoot.update = function (self, dt)
	return
end

MyLoot._new_id = function (self)
	self._last_id = self._last_id + 1

	return self._last_id
end

MyLoot.open_loot_chest = function (self, hero_name, backend_id, game_mode_key, num_chests)
	local id = self:_new_id()
	return id
end

MyLoot.loot_chest_rewards_request_cb = function (self, data, result)

end

MyLoot.generate_end_of_level_loot = function (self, game_won, quick_play_bonus, difficulty, level_key, hero_name, start_experience, end_experience, loot_profile_name, deed_item_name, deed_backend_id, game_mode_key, game_time, end_of_level_rewards_arguments)
	local id = self:_new_id()
	return id
end

MyLoot.end_of_level_loot_request_cb = function (self, data, result)

end

MyLoot._get_remote_player_network_ids_and_characters = function (self)
	local ids_and_characters = {}
	return ids_and_characters
end

MyLoot.get_achievement_rewards = function (self, achievement_id)
    return {}
end

MyLoot.achievement_rewards_claimed = function (self, achievement_id)
    return {}
end

MyLoot.can_claim_achievement_rewards = function (self, achievement_id)
	return false
end

MyLoot.claim_achievement_rewards = function (self, achievement_id, poll_id)

end

MyLoot.achievement_rewards_request_cb = function (self, data, result)

end

MyLoot.can_claim_all_achievement_rewards = function (self, achievement_ids)

end

local ACH_CHUNK_LIMIT = 150

MyLoot.claim_multiple_achievement_rewards = function (self, achievement_ids, poll_id, start_index, end_index)

end

MyLoot.claim_multiple_achievement_rewards_request_cb = function (self, data, id, start_index, end_index, achievement_ids, result)

end

MyLoot.polling_reward = function (self)
	return self._reward_poll_id
end

MyLoot.is_loot_generated = function (self, id)
	return false
end

MyLoot.get_loot = function (self, id)
    return {}
end

MyLoot.generate_reward_loot_id = function (self)
	return self:_new_id()
end
