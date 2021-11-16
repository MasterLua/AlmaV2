AlmaUtils = {};
Helper = {};

local characters = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" }

STAFF_group_MENU = {
	{ Name = "Aucun", Value = nil },
	{ Name = "Ami(e)", Value = "friend" },
	{ Name = "Novice", Value = "novice" },
	{ Name = "Helper", Value = "helper" },
	{ Name = "Moderateur", Value = "moderator" },
	{ Name = "Administrateur", Value = "admin" },
	{ Name = "Gérant Legal", Value = "gl" },
	{ Name = "Gérant Ilegal", Value = "gi" },
	{ Name = "Gérant staff", Value = "gf" },
}

STAFF_group = {
	["user"] = "Joueur",
	["novice"] = "Novice",
	["helper"] = "Helper",
	["moderator"] = "Moderateur",
	["admin"] = "Administrateur",
	["friend"] = "Ami(e)",
	["gl"] = "Gérant Legal",
	["gi"] = "Gérant Ilegal",
	["gf"] = "Gérant staff",
	["fondateur"] = "Fondateur",
}

STAFF_group_color = {
    ["fondateur"] = "~HUD_COLOUR_PANEL_LIGHT~Fondateur~s~",
    ["gf"] = "~HUD_COLOUR_DEGEN_RED~Gérant staff~s~",
    ["gi"] = "~HUD_COLOUR_TECH_RED~Gérant Ilegal~s~",
    ["gl"] = "~HUD_COLOUR_TECH_RED~Gérant Legal~s~",
    ["admin"] = "~HUD_COLOUR_CHOP~Administrateur~s~",
    ["moderator"] = "~HUD_COLOUR_NET_PLAYER25~Moderateur~s~",
    ["helper"] = "~HUD_COLOUR_NET_PLAYER24~Helpe~s~r",
    ["novice"] = "~HUD_COLOUR_PINK~Novice~s~",
    ["friend"] = "~HUD_COLOUR_PURPLE~Ami(e)~s~",
    ["user"] = "~HUD_COLOUR_GREEN~Joueur~s~",
}

PLAYER_DATA = nil;
CAMERA_NOCLIP = nil;
PERMISSIONS = nil;

function Alma:AddEventHandler(type, name, callback)
    RegisterNetEvent('Alma:' .. type .. ':' .. name .. '')
    AddEventHandler('Alma:' .. type .. ':' .. name .. '', callback)
end

function Alma.toServer(eventName, ...)
    TriggerServerEvent("Alma:" .. Alma.hash(eventName), ...)
end

function Alma:TriggerServerEvent(type, name, ...)
    TriggerServerEvent('Alma:' .. type .. ':' .. name .. '', ...)
end

function Alma:HasPermissions(permId)
    return PERMISSIONS ~= nil and (PERMISSIONS & (1 << permId) > 0) or false
end

function Alma:GetGroupLabel(group)
    return STAFF_group[group]
end

function Alma:GetRandomString()
    local plate = ""
    math.randomseed(GetGameTimer())
    for i = 1, 4 do
        plate = plate .. characters[math.random(1, #characters)]
    end
    plate = plate .. ""
    for i = 1, 3 do
        plate = plate .. math.random(1, 9)
    end
    return plate
end

function Alma:GetLabelRankWithColor(group)
    return STAFF_group_color[group]
end

function AlmaUtils.toServer(eventName, ...)
    TriggerServerEvent("Alma:" .. GetHashKey(eventName), ...)
end

function Alma:GetPedVehicleSeat(ped)
    local vehicle = GetVehiclePedIsIn(ped, false)
    for i = -1, GetVehicleMaxNumberOfPassengers(vehicle) do
        if (GetPedInVehicleSeat(vehicle, i) == ped) then
            return i
        end
    end
    return nil
end

Citizen.CreateThread(function()
	Citizen.Wait(500)
	Alma:TriggerServerEvent("Permissions", "GetPlayers")
end)

function Helper:Switch(condition, args, is_fn)
	if type(args) == "table" then
		if is_fn == nil or is_fn then
			local fn = args[condition] or args["default"]
			if fn and type(fn) == "function" then
				fn()
			end
		elseif is_fn ~= nil and not is_fn then
			return (args[condition] or nil)
		end
	end
end

function Helper:Contains(table, value)
	for k, v in pairs(table) do
		if (value == v) then
			return true
		end
	end
	return false
end


function Helper:DrawText3D(x, y, z, text, r, g, b, scalling)
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
    local px, py, pz = table.unpack(GetFinalRenderedCamCoord())
    local dist = #(vector3(px, py, pz) - vector3(x, y, z))

    local scale = (1 / dist) * scalling or 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        BeginTextCommandDisplayText("STRING")
        SetTextCentre(1)
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayText(_x, _y)
    end
end

function Helper:CreateCamera(name)
    local camera = CreateCam(name or "DEFAULT_SCRIPTED_CAMERA")
    while (camera == -1) do
        camera = CreateCam(name or "DEFAULT_SCRIPTED_CAMERA");
        Citizen.Wait(1.0)
    end
    return camera
end

function Helper:IsManipulableWeapon(weapon, IsManipulable, IsNotManipulable)
	if ESX.IsContribWeapon(weapon.name) then
		IsNotManipulable();
	else
		IsManipulable();
	end
end

function Helper:OnAskQuantity(onSuccess)
    local amount = self:KeyboardInput("Combien ?", 1, 300, true);
    if (amount ~= nil) and (amount >= 1) then
        if (onSuccess ~= nil) and (type(onSuccess) == "function") then
            onSuccess(assmount)
        end
    else
        ESX.ShowNotification("Vous ne pouvez pas faire cela.")
    end
end

function Helper:KeyboardInput(TextEntry, ExampleText, MaxStringLength, OnlyNumber)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", 500)
    local blocking = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blocking = false
        if (OnlyNumber) then
            local number = tonumber(result)
            if (number ~= nil) then
                return number
            end
            return nil
        else
            return result
        end
    else
        Citizen.Wait(500)
        blocking = false
        return nil
    end
end

function Helper:DistanceToEntity(Entity)
	return #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(Entity))
end

function Helper:SpawnLocalVehicle(model, position, cb)
    ESX.Streaming.RequestModel(model)
    RequestCollisionAtCoord(vector3(position.x, position.y, position.z))
    local vehicle = CreateVehicle(model, vector3(position.x, position.y, position.z), position.w, false, false)

    SetEntityAsMissionEntity(vehicle, false, false)
    SetModelAsNoLongerNeeded(model)

    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetVehicleOnGroundProperly(vehicle)
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetVehRadioStation(vehicle, 'OFF')
    FreezeEntityPosition(vehicle, true)
    SetVehicleEngineCanDegrade(vehicle, true)
    SetVehicleEngineOn(vehicle, true, true, false)
    SetEntityInvincible(vehicle, true)
    SetVehicleFixed(vehicle)
    SetVehicleCanEngineOperateOnFire(vehicle, true)
    SetVehicleBrakeLights(vehicle, true)
    SetVehicleLights(vehicle, 3)

    if cb then
        cb(vehicle)
    end
end

Thread = {
    Register = {};
};

---@class Markers
Markers = {
    Active = {},
    Lists = {},
};

function Markers:Register(markers)
    table.insert(self.Lists, markers)
end

local InteriorId = GetInteriorFromEntity;

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local isSniper = false;

        local currentWeaponHash = GetSelectedPedWeapon(ped)

        if currentWeaponHash == 100416529 then
            isSniper = true
        elseif currentWeaponHash == 205991906 then
            isSniper = true
        elseif currentWeaponHash == -952879014 then
            isSniper = true
        elseif currentWeaponHash == GetHashKey('WEAPON_HEAVYSNIPER_MK2') or currentWeaponHash == GetHashKey("WEAPON_SNIPERRIFLE") or currentWeaponHash == GetHashKey("WEAPON_HEAVYSNIPER") then
            isSniper = true
        else
            isSniper = false
        end

        if not isSniper then
            HideHudComponentThisFrame(14)
        end
        Markers.Active = {};
        local coords = GetEntityCoords(PlayerPedId())
        for _, v in pairs(Markers.Lists) do
            local dist = #(coords - v.vector3)
            if (v.interiorID == nil) then
                if dist <= 60.0 then
                    table.insert(Markers.Active, v)
                end
            else
                if dist <= 30.0 then
                    table.insert(Markers.Active, v)
                end
            end
        end
        for _, data in pairs(Markers.Active) do
            if not (data.hidden) then
                DrawMarker(1, (data.vector3 - vector3(0.0, 0.0, 0.90)), 0.0, 0.0, 0.0, 0, 0.0, 0.0, data.size, data.size, 0.5, 255, 255, 255, 255, false, true, 2, 1.0, false, false, false)
            end
            if #(data.vector3 - GetEntityCoords(PlayerPedId())) < data.size - 1.0 then
                if (data.onArea ~= nil) and (type(data.onArea) == "function") then
                    data.onArea(data.onAreaKey);
                end
            end
        end
    end
end)