AlmaServerUtils = {}

AlmaServerUtils.toClient = function(eventName, targetId, ...)
    TriggerClientEvent("Alma:" .. Alma.hash(eventName), targetId, ...)
end

AlmaServerUtils.toAll = function(eventName, ...)
    TriggerClientEvent("Alma:" .. Alma.hash(eventName), -1, ...)
end

AlmaServerUtils.registerConsoleCommand = function(command, func)
    RegisterCommand(command, function(source,args)
        if source ~= 0 then return end
        func(source, args)
    end, false)
end

AlmaServerUtils.getLicense = function(source)
    for k, v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            return v
        end
    end
    return ""
end

AlmaServerUtils.trace = function(message, prefix)
    print("[^1Alma^0] (^6" .. prefix .. "^0) ^6" .. message .. "^0")
end

local webhookColors = {
    ["red"] = 16711680,
    ["green"] = 56108,
    ["grey"] = 8421504,
    ["orange"] = 16744192
}

local registredEvents = {}
local function isEventRegistred(eventName)
    for k,v in pairs(registredEvents) do
        if v == eventName then return true end
    end
    return false
end

AlmaServerUtils.getIdentifiers = function(source)
    if (source ~= nil) then
        local identifiers = {}
        local playerIdentifiers = GetPlayerIdentifiers(source)
        for _, v in pairs(playerIdentifiers) do
            local before, after = playerIdentifiers[_]:match("([^:]+):([^:]+)")
            identifiers[before] = playerIdentifiers[_]
        end
        return identifiers
    end
end

Alma.netRegisterAndHandle = function(eventName, handler)
    local event = "Alma:" .. Alma.hash(eventName)
    if not isEventRegistred(event) then
        RegisterNetEvent(event)
        table.insert(registredEvents, event)
    end
    AddEventHandler(event, handler)
end

Alma.hash = function(notHashedModel)
    return GetHashKey(notHashedModel)
end

Alma.toInternal = function(eventName, ...)
    TriggerEvent("Alma:" .. Alma.hash(eventName), ...)
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