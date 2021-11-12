Alma = {};
Helper = {};

PERMISSIONS_GROUP = {
    ["onJoin"] = -1,
    ["onLeave"] = -1,
    ["RequestStaff"] = -1,
    ["RequestPlayer"] = -1,
    ["Teleport"] = -1,
    ["ToggleNoclip"] = -1,
    ["Boutique"] = {
        ["fondateur"] = true,
        ["devlopper"] = true,
        ["gf"] = true
    },
    ["FixVehicle"] = -1,
    ["DevMode"] = {
        ["fondateur"] = true,
        ["devlopper"] = true,
        ["gf"] = true
    },
    ["Funny"] = {
        ["fondateur"] = true,
        ["devlopper"] = true,
        ["gf"] = true
    },
    ["GiveWeapon"] = {
        ["fondateur"] = true,
        ["gl"] = true,
        ["gf"] = true,
        ["gi"] = true,
        ["superadmin"] = true,
    },
    ["GamerTags"] = -1,
    ["Discord"] = -1,
    ["PermissionsChange"] = {
        ["fondateur"] = true,
        ["gf"] = true
    },
    ["CreateVehicles"] = -1,
    ["Report"] = -1,
    ["Jail"] = -1,
    ["RevivePlayer"] = -1
}

LABEL_STAFF_GROUP = {
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

function Alma:AddEventHandler(type, name, callback)
    Citizen.Trace("\n[^3AddEventHandler^7] > Alma:"..type..":"..name..", "..tostring(callback))
    RegisterNetEvent('Alma:' .. type .. ':' .. name .. '')
    AddEventHandler('Alma:' .. type .. ':' .. name .. '', callback)
end

function Alma:TriggerClientEvent(type, name, ...)
    Citizen.Trace("\n[^3ClientEvent^7] > Alma:"..type..":"..name..", ".. ...)
    TriggerClientEvent('Alma:' .. type .. ':' .. name .. '', ...)
end

function Alma:toClient(name, ...)
    Citizen.Trace("\n[^3ClientEvent^7] > "..name..", ".. ...)
    TriggerClientEvent(name, ...)
end

function Alma:GetLabelRank(rank)
    return LABEL_STAFF_GROUP[rank]
end

function HasPermissions(group, permission)
    if (group ~= "user") then
        if (PERMISSIONS_GROUP[permission] == -1) then
            return true
        else
            if (PERMISSIONS_GROUP[permission][group]) then
                return true
            else
                return false
            end
        end
    else
        return false
    end
end

function Helper:showAdvancedNotification(id, title, str, desc, char, icon)
	if icon == nil then 
		TriggerClientEvent("esx:showAdvancedNotification", id, title, str, desc, char)
	else
		TriggerClientEvent("esx:showAdvancedNotification", id, title, str, desc, char, icon)
	end
end

function Helper:firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function Helper:toDiscord(title, str, http)
    local date = os.date('*t')
  
    if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
    if date.min < 10 then date.min = '0' .. tostring(date.min) end
    if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
    
    local time = date.hour.. ':' .. date.min .. ':' .. date.sec
    
    local embeds = {
        {
            ["title"] = title,
            ["type"] = "rich",
            ["description"] = str,
            ["color"] = 15992146,
            ["footer"] = {
                ["text"] = time,
           },
        }
    }
    if title == nil or http == nil then return end
    PerformHttpRequest(http, function(err, text, headers) end, 'POST', json.encode({ username = "Administration by Authentic", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end
