IsAllowedToChangeProximity = true;

---@class CZones
CZones = {
    Active = {},
    Lists = {},
};

CPlayer = {
    Ped = nil,
    CurrentZone = { id = 0 },
    LastZone = { id = 0 },
    Position = nil,
}

local RESTRICTED_ZONE = {
    { x = 452.2344, y = -983.9187, z = 30.69},
    { x = 299.1860, y = -584.5434, z = 43.2608},
    { x = -920.1403, y = -2035.2117, z = 9.4017},
    { x = 1754.7060, y = 2482.7475, z = 103.7156},
    { x = -451.7622, y = 6013.7514, z =  31.7133},
}

local function AddLongString(txt)
    for i = 100, string.len(txt), 99 do
        local sub = string.sub(txt, i, i + 99)
        AddTextComponentSubstringPlayerName(sub)
    end
end

function Notification(args)
    local notificationID;
    if (not args.dict) and (args.name) then
        args.dict = args.name
    end
    if not HasStreamedTextureDictLoaded(args.dict) then
        RequestStreamedTextureDict(args.dict, false)
        while not HasStreamedTextureDictLoaded(args.dict) do
            Wait(0)
        end
    end
    if (args.backId) then
        ThefeedNextPostBackgroundColor(args.backId)
    end
    BeginTextCommandThefeedPost("jamyfafi")
    if (args.message) then
        AddTextComponentSubstringPlayerName(args.message)
        if string.len(args.message) > 99 then
            AddLongString(args.message)
        end
    end
    if (args.title) and (args.subtitle) and (args.name) then
        notificationID = EndTextCommandThefeedPostMessagetext(args.dict or "CHAR_DEFAULT", args.name or "CHAR_DEFAULT", true, args.icon or 0, args.title or "", args.subtitle or "")
        SetStreamedTextureDictAsNoLongerNeeded(args.dict)
    end
    EndTextCommandThefeedPostTicker(false, true)

end

local function HandleZone(zone)
    if (zone.condition == nil) then
        zone.condition = function()
            return true
        end
    end
    if zone.marker == nil then
        local coords = zone.vector3
        zone.marker = {
            isShown = not zone.hidden,
            type = 1,
            position = { x = coords.x, y = coords.y, z = coords.z - 0.90 },
            scale = { x = zone.size, y = zone.size, z = 0.5 },
            color = { r = 255, g = 255, b = 255, a = 255 },
            rotate = true,
            bobUpAndDown = false,
        }
    end
    return zone
end

function CZones:Register(zone)
    table.insert(self.Lists, HandleZone(zone))
end

local function RestrictionNotification(message)
    Notification({
        title = "Informations",
        subtitle = "Zone de restriction de voix",
        message = message,
        dict = "DIA_TANNOY",
        name = "DIA_TANNOY",
        icon = 7,
        backId = nil,
    })
end

local function onExitArea()
    RestrictionNotification("Vous êtes sortie d'une zone de restriction vocale.")
    IsAllowedToChangeProximity = true
end

local function onEnterInArea()
    RestrictionNotification("Vous êtes entré dans une zone de restriction vocale, ce qui signifie que vous ne pouvez pas modifier la porter de votre voix.")
    IsAllowedToChangeProximity = false
    ForceMinimalVoiceProximity()
end

for i, v in pairs(RESTRICTED_ZONE) do
    CZones:Register({
        id = 1,
        vector3 = vector3(v.x, v.y, v.z),
        distance = 100.0,
        size = 60.0,
        hidden = true,
        onExitArea = onExitArea,
        onEnterInArea = onEnterInArea,

    })
end

AddEventHandler('onClientResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then
        return
    end
    print('Starting script initialization')


    -- Some people modify pma-voice and mess up the resource Kvp, which means that if someone
    -- joins another server that has pma-voice, it will error out, this will catch and fix the kvp.
    local success = pcall(function()
        local micClicksKvp = GetResourceKvpString('pma-voice_enableMicClicks')
        if not micClicksKvp then
            SetResourceKvp('pma-voice_enableMicClicks', tostring(true))
        else
            if micClicksKvp ~= 'true' and micClicksKvp ~= 'false' then
                error('Invalid Kvp, throwing error for automatic cleaning')
            end
            micClicks = micClicksKvp
        end
    end)

    if not success then
        logger.warn('Failed to load resource Kvp, likely was inappropriately modified by another server, resetting the Kvp.')
        SetResourceKvp('pma-voice_enableMicClicks', tostring(true))
        micClicks = 'true'
    end
    Wait(1000)
    if GetConvarInt('voice_enableUi', 1) == 1 then
        SendNUIMessage({
            voiceModes = json.encode(Cfg.voiceModes),
            voiceMode = mode - 1
        })
    end
    print('Script initialization finished.')

    IsInitialized = true;
end)

local Timer = 0;

Citizen.CreateThread(function()


    while true do
        Citizen.Wait(1)
        local cGameTimer = GetGameTimer()

        if (Timer + 2000 < cGameTimer) then
            CPlayer.Ped = PlayerPedId();
            CPlayer.Position = GetEntityCoords(CPlayer.Ped)
            Timer = cGameTimer
        end

        CZones.Active = {}

        for _, v in pairs(CZones.Lists) do
            local dist = #(CPlayer.Position - v.vector3)
            if (v.interiorID == nil) then
                if dist <= 200.0 then
                    table.insert(CZones.Active, v)
                end
            else
                if (GetInteriorFromEntity(CPlayer.Ped) == v.interiorID) then
                    if dist <= 30.0 then
                        table.insert(CZones.Active, v)
                    end
                end
            end
        end

        CPlayer.CurrentZone = { id = 0 };

        for _, data in pairs(CZones.Active) do
            if data.condition() then
                if #(data.vector3 - CPlayer.Position) < data.size - 1.0 then
                    if (data.onEnterInArea) then
                        CPlayer.CurrentZone = data;
                    end
                    if (data.onArea ~= nil) and (type(data.onArea) == "function") then
                        data.onArea(data.onAreaKey);
                    end
                end
            end
        end
        if (CPlayer.CurrentZone.id ~= CPlayer.LastZone.id) then
            if (CPlayer.CurrentZone.id == 0) then
                if (CPlayer.LastZone.onExitArea) then
                    CPlayer.LastZone.onExitArea(CPlayer.CurrentZone.id)
                end
            else
                if (CPlayer.CurrentZone.onEnterInArea) then
                    CPlayer.CurrentZone.onEnterInArea(CPlayer.CurrentZone.id)
                end
            end
            CPlayer.LastZone = CPlayer.CurrentZone
        end

    end
end)

