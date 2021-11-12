
Citizen.CreateThread(function()
    Wait(1000)
end)

Alma.newThread = Citizen.CreateThread
Alma.newWaitingThread = Citizen.SetTimeout
--Citizen.CreateThread, CreateThread, Citizen.SetTimeout, SetTimeout, InvokeNative = nil, nil, nil, nil, nil

Job = nil
Jobs = {}
Jobs.list = {}

ModernPrefixes = {
    zones = "^1ZONE",
    err = "^1ERREUR",
    blips = "^1BLIPS",
    npcs = "^1NPCS",
    dev = "^6INFOS",
    sync = "^6SYNC",
    jobs = "^6JOBS",
    succes = "^2SUCCÈS"
}

Alma.hash = function(notHashedModel)
    return GetHashKey(notHashedModel)
end

Alma.prefix = function(title, message)
    return ("[^1AlmaRP^0] (%s^0) %s" .. "^0"):format(title, message)
end

local registredEvents = {}
local function isEventRegistred(eventName)
    for k,v in pairs(registredEvents) do
        if v == eventName then return true end
    end
    return false
end

Alma.netRegisterAndHandle = function(eventName, handler)
    local event = "Alma:" .. Alma.hash(eventName)
    if not isEventRegistred(event) then
        RegisterNetEvent(event)
        table.insert(registredEvents, event)
    end
    AddEventHandler(event, handler)
end


Alma.netRegister = function(eventName)
    local event = "Alma:" .. Alma.hash(eventName)
    RegisterNetEvent(event)
end


Alma.netHandle = function(eventName, handler)
    local event = "Alma:" .. Alma.hash(eventName)
    AddEventHandler(event, handler)
end


Alma.netHandleBasic = function(eventName, handler)
    AddEventHandler(eventName, handler)
end

Alma.second = function(from)
    return from*1000
end

Alma.toInternal = function(eventName, ...)
    TriggerEvent("Alma:" .. Alma.hash(eventName), ...)
end