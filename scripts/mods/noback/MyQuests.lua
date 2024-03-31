MyQuests = class(MyQuests)

MyQuests.init = function (self, backend_mirror)
	self._backend_mirror = backend_mirror
	self._quests = {}
	self._last_id = 0
	self._refresh_requests = {}
	self._quest_reward_requests = {}
	self._quests_updating = false
	self._quest_timer = 0
	self._event_quest_update_times = {}

	self:_refresh()
end

MyQuests._refresh = function (self)
    self._weekly_quest_update_time = 10
    self._daily_quest_update_time = 10
end

MyQuests.ready = function (self)
	return true
end

MyQuests._new_id = function (self)
	self._last_id = self._last_id + 1

	return self._last_id
end

MyQuests.make_dirty = function (self)
	self._dirty = true
end

MyQuests.update_quests = function (self, quests_updated_cb)

end

MyQuests.update = function (self, dt)
	self._quest_timer = self._quest_timer + dt
end

MyQuests.get_quests_cb = function (self, result)

end

MyQuests.delete = function (self)
	return
end

MyQuests.get_quests = function (self)
	return self._quests
end

MyQuests.get_daily_quest_update_time = function (self)
	return self._daily_quest_update_time - self._quest_timer
end

MyQuests.get_weekly_quest_update_time = function (self)
	return self._weekly_quest_update_time - self._quest_timer
end

MyQuests.get_time_left_on_event_quest = function (self, key)
    return 10
end

MyQuests.can_refresh_daily_quest = function (self)
    return false
end

MyQuests.refresh_daily_quest = function (self, key)
	local id = self:_new_id()
	return id
end

MyQuests.refresh_quest_cb = function (self, id, key, result)

end

MyQuests.is_quest_refreshed = function (self, id)
	return false
end

MyQuests.can_claim_quest_rewards = function (self, key)
	return false
end

MyQuests.can_claim_multiple_quest_rewards = function (self, keys)
	return false, nil
end

MyQuests.claim_quest_rewards = function (self, key)
	local id = self:_new_id()
	return id
end

MyQuests.quest_rewards_request_cb = function (self, data, result)

end

MyQuests.claim_multiple_quest_rewards = function (self, keys)
	local quest_data = {}
	local id = self:_new_id()
	return id
end

MyQuests.claim_multiple_quest_rewards_request_cb = function (self, data, id, result)

end

MyQuests.get_quest_key = function (self, quest_id)
	return nil
end

MyQuests.get_quest_by_key = function (self, key)
	return nil
end

MyQuests.quest_rewards_generated = function (self, id)
	return false
end

MyQuests.get_quest_rewards = function (self, id)
	return self._quest_reward_requests[id]
end

MyQuests.get_claimed_event_quests = function (self)
	local mirror = self._backend_mirror
	return mirror:get_claimed_event_quests()
end
