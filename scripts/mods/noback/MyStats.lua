MyStats = class(MyStats)

MyStats.update = function (self, dt)
	return
end

MyStats.init = function (self, mirror)
	local function success_callback(result)
		print("Player statistics loaded!")

		local stats = result.FunctionResult

		self._mirror:set_stats(stats)

		self._ready = true
	end

	local request = {
		FunctionName = "loadPlayerStatistics",
	}
end

MyStats.ready = function (self)
    return true
end

MyStats.get_stats = function (self)
    return {}
end

local function flatten_stats(stats)
	return {}
end

local function filter_stats(stats)
	return {}
end

MyStats.clear_dirty_flags = function (self, stats)

end

MyStats.save = function (self)
	local player_manager = Managers.player

	print("---------------------- MyStats:save ----------------------")

	if not player_manager then
		print("[MyStats] No player manager, skipping saving statistics...")

		return false
	end

	local player = player_manager:local_player()

	if not player then
		print("[MyStats] No player found, skipping saving statistics...")

		return false
	end

	local player_stats_id = player:stats_id()
	local player_stats = Managers.player:statistics_db():get_all_stats(player_stats_id)
	local stats_to_save = filter_stats(flatten_stats(player_stats))

	self._stats_to_save = stats_to_save
end

MyStats.clear_saved_stats = function (self)

end

MyStats.get_stat_save_request = function (self)
	local stats_to_save = self._stats_to_save

	local request = {
		FunctionName = "savePlayerStatistics3",
		FunctionParameter = {
			stats = stats_to_save,
		},
	}

	return request, stats_to_save
end

MyStats.reset = function (self)

end
