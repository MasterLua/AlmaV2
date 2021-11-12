Citizen.CreateThread(function()
	while true do
		local _, _, _, hour, minute = GetUtcTime()
		NetworkOverrideClockTime(hour, minute, 0)
		Citizen.Wait(60000)
	end
end)

safeZones = {
	vector3(-821.2, -127.65, 28.18),
	vector3(218.76, -802.87, 30.09),
	vector3(429.54, -981.86, 30.71),
	vector3(-38.22, -1100.84, 26.42),
	vector3(295.68, -586.45, 43.14),
	vector3(-64.75, 71.94, 71.73),
	vector3(253.8, -743.53, 30.82),
	vector3(-211.34, -1322.06, 30.89),
	vector3(396.25, -355.27, 46.82),
	vector3(482.998, 4812.112, -58.384),
	vector3(1643.2, 2570.42, 45.56),
}

local disabledSafeZonesKeys = {
	{group = 2, key = 37, message = 'Vous ne pouvez pas sortir d\'arme en SafeZone'},
	{group = 0, key = 24, message = 'Vous ne pouvez pas faire ceci en SafeZone'},
	{group = 0, key = 69, message = 'Vous ne pouvez pas faire ceci en SafeZone'},
	{group = 0, key = 92, message = 'Vous ne pouvez pas faire ceci en SafeZone'},
	{group = 0, key = 106, message = 'Vous ne pouvez pas faire ceci en SafeZone'},
	{group = 0, key = 168, message = 'Vous ne pouvez pas faire ceci en SafeZone'},
	{group = 0, key = 160, message = 'Vous ne pouvez pas faire ceci en SafeZone'},
	{group = 0, key = 160, message = 'Vous ne pouvez pas faire ceci en SafeZone'}
}

local notifIn, notifOut = false, false
local closestZone = 1

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end

	while true do
		local plyPed = PlayerPedId()
		local plyCoords = GetEntityCoords(plyPed, false)
		local minDistance = 100000

		for i = 1, #safeZones, 1 do
			local dist = #(safeZones[i] - plyCoords)

			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end

		Citizen.Wait(15000)
	end
end)

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function Alma.EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end

	while true do
		local plyPed = PlayerPedId()
		local plyCoords = GetEntityCoords(plyPed, false)
		local dist = #(safeZones[closestZone] - plyCoords)

		if dist <= 50 then
			Wait(0)
		else
			Wait(750)
		end

		if dist <= 50 then
			if not notifIn then
				NetworkSetFriendlyFireOption(false)
				SetCurrentPedWeapon(plyPed, `WEAPON_UNARMED`, true)
				ESX.ShowAdvancedNotification('Alma', '~g~Informations', "Vous venez de d'entrer dans une zone safe.", "CHAR_CALIFORNIA")

				notifIn = true
				notifOut = false
			end
		else
			if not notifOut then
				NetworkSetFriendlyFireOption(true)
				ESX.ShowAdvancedNotification('Alma', '~g~Informations', "Vous venez de sortir d'une zone safe.", "CHAR_CALIFORNIA")

				notifOut = true
				notifIn = false
			end
		end

		if notifIn then
			for vehicle in Alma.EnumerateVehicles() do
				if not IsVehicleSeatFree(vehicle, -1) then
					SetEntityNoCollisionEntity(plyPed, vehicle, true)
					SetEntityNoCollisionEntity(vehicle, plyPed, true)
				end
			end

			DisablePlayerFiring(player, true)

			for i = 1, #disabledSafeZonesKeys, 1 do
				DisableControlAction(disabledSafeZonesKeys[i].group, disabledSafeZonesKeys[i].key, true)

				if IsDisabledControlJustPressed(disabledSafeZonesKeys[i].group, disabledSafeZonesKeys[i].key) then
					SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)

					if disabledSafeZonesKeys[i].message then
						ESX.ShowAdvancedNotification('Alma', '~g~Information', disabledSafeZonesKeys[i].message, 'CHAR_CALIFORNIA')
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        for _,player in ipairs(GetActivePlayers()) do
            local ped = GetPlayerPed(-1)
            local everyone = GetPlayerPed(player)
            local everyoneveh = GetVehiclePedIsUsing(everyone)
            if IsPedInAnyVehicle(everyone, false) then
                SetEntityNoCollisionEntity(ped, everyoneveh, false)
                SetEntityNoCollisionEntity(everyoneveh, ped, false)
            else
                SetEntityNoCollisionEntity(ped, everyone, false)
            end
        end
    end
end)

function GetSafeZone()
	return notifIn
end