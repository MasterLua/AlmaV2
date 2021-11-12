local limiter = {}

local rateLimit = 10

local event = {
    "Alma:Staff:onJoin",
    "Alma:Staff:onLeave"
}

local function netLog(s)
	print(string.format('^5SafetyEvent^7] - [%s]: %s^7', os.date("%Y-%m-%d %H:%M:%S", os.time()), s))
end

for i = 1, #event do
	local eventName = event[i]

	RegisterNetEvent(eventName)
	AddEventHandler(eventName, function()
		local playerId = tonumber(source)
		if not playerId or playerId == 0 then return end
		local timerNow = GetGameTimer()

		print("[^2Alert-Event^7] > +".. eventName .." | [^2Player^7] > ".. GetPlayerName(playerId) .." [^2Request^7] > ".. timerNow .."/ms")

		if not limiter[playerId] then limiter[playerId] = {} end

		local limit = limiter[playerId][eventName]

		if not limit then
			limiter[playerId][eventName] = { counter = 1, started = timerNow }
			return
		else
			if (timerNow - limit.started) >= 1000 then
                if limit.counter > 1 then
				    limit.counter = limit.counter - 1
                else
                    limit.counter = 0;
                end
				limit.started = timerNow
				return
			else
				limit.counter = limit.counter + 1
			end
		end

		if limit.counter > rateLimit then
			netLog(string.format('User: %s [%s] Event : [%s] Info: [%i/%i]', playerId, GetPlayerName(playerId), eventName, limit.counter, rateLimit))
			PerformHttpRequest('https://discord.com/api/webhooks/903319811902287942/GJ8anLk4XDvYksfz1J4xoFVMsnyPlN9b8Vf9X0WtC8_EHdWL5v7CrU4ybP3RQah8QzDJ', function(err, text, headers) end, 'POST', json.encode({username = "", content = "Le joueur ["..playerId.."] "..GetPlayerName(playerId).." spam des requetes - INFO : "..eventName.." ["..limit.counter.."/"..rateLimit.."]"}), { ['Content-Type'] = 'application/json' })
			DropPlayer(playerId, "Vous n'êtes pas autorisé à faire autant de R/s.")
		end
	end)
end

AddEventHandler('playerDropped', function(reason)
	if limiter[source] then
		limiter[source] = nil
	end
end)