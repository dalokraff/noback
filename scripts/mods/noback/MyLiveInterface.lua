MyLiveInterface = class(MyLiveInterface)

MyLiveInterface.init = function (self, backend_mirror)
	self.is_local = false
	self._last_id = 0
	self._live_events = {}
	self._completed_live_event_requests = {}

	local backend_manager = Managers.backend
    local live_events = {}

	if is_array(live_events) then
		self._live_events = {
			weekly_events = live_events,
		}
	else
		self._live_events = live_events
	end
end

MyLiveInterface.ready = function (self)
	return true
end

MyLiveInterface.update = function (self, dt)
	return
end

MyLiveInterface._new_id = function (self)
	self._last_id = self._last_id + 1

	return self._last_id
end

MyLiveInterface.request_live_events = function (self)
	local id = self:_new_id()
	return id
end

MyLiveInterface.request_live_events_cb = function (self, id, result)
	local function_result = result.FunctionResult
	local live_events_json = function_result.live_events
	local live_events = {}

	if live_events_json then
		live_events = cjson.decode(live_events_json)
	end

	if is_array(live_events) then
		self._live_events = {
			weekly_events = live_events,
		}
	else
		self._live_events = live_events
	end

	self._completed_live_event_requests[id] = true
end

MyLiveInterface.live_events_request_complete = function (self, id)
	local complete = self._completed_live_event_requests[id]

	return complete
end

MyLiveInterface.get_weekly_events = function (self)
	return self._live_events.weekly_events
end

MyLiveInterface.get_special_events = function (self)
	return self._live_events.special_events
end

MyLiveInterface.get_weekly_events_game_mode_data = function (self)
	local weekly_event_data = self._live_events.weekly_events

	for i = 1, #weekly_event_data do
		local event = weekly_event_data[i]

		if event.game_mode_data then
			return event.game_mode_data
		end
	end
end

MyLiveInterface.request_twitch_app_access_token = function (self, cb)

end

MyLiveInterface._request_twitch_app_access_token_cb = function (self, cb, result)

end
