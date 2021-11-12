local IN_JAIL = {};

local ALL_PLAYERS_IN_JAIL = {};

RegisterCommand("jail", function(source, args, rawCommand)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer.getGroup() ~= "user") then
        if (args[1]) and (args[2]) and (args[3]) then
            if not GetPlayerName(args[1]) then 
                return xPlayer.showNotification("Joueur non connécté ou mauvais ID !") 
            end
            local xTarget = ESX.GetPlayerFromId(args[1])
            if IN_JAIL[xTarget.identifier] ~= nil then 
                return xPlayer.showNotification("Ce joueur est déjà en prison pour ~g~"..IN_JAIL[xTarget.identifier].raison.."~s~ pendant ~g~"..IN_JAIL[xTarget.identifier].time.."~s~ sec !") 
            end
            Alma:TriggerClientEvent("Jail", "PutIn", args[1], tonumber(args[2]), tostring(args[3]))
            MySQL.Async.execute('INSERT INTO alma_jail (identifier, time, raison) VALUES (@a, @b, @c)', {
                ["@a"] = xTarget.identifier,
                ["@b"] = tonumber(args[2]),
                ["@c"] = tostring(args[3])
            })
            IN_JAIL[xTarget.identifier] = {
                identifier = xTarget.identifier,
                time = tonumber(args[2]),
                raison = tostring(args[3])
            }
        else
            xPlayer.showNotification("~HUD_COLOUR_DEGEN_RED~Mauvaise formulation !")
        end
    end
end, false)

RegisterCommand("unjail", function(source, args, rawCommand)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer.getGroup() ~= "user") then
        if (args[1]) then
            if not GetPlayerName(args[1]) then 
                return xPlayer.showNotification("Joueur non connécté ou mauvais ID !") 
            end
            local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
            if not IN_JAIL[xTarget.identifier] then
                return xPlayer.showNotification("~r~Ce joueur n'est pas en prison !")
            end
            MySQL.Async.execute('DELETE FROM alma_jail WHERE identifier = @a', {
                ["@a"] = xTarget.identifier,
            })
            TriggerClientEvent("skinchanger:getSkin", args[1], function(skin)
                TriggerClientEvent("skinchanger:loadSkin", args[1], skin)
            end)
            IN_JAIL[xTarget.identifier] = nil;
            Alma:TriggerClientEvent("Jail", "PutOut", args[1])
            xTarget.showNotification("Cette fois, fait plus n'importe quoi, aller bon jeu !")
            SetEntityCoords(GetPlayerPed(args[1]), vector3(1854.3568115234, 2583.4379882813, 45.671989440918))
        else
            xPlayer.showNotification("~HUD_COLOUR_DEGEN_RED~Mauvaise formulation !")
        end
    end
end, false)

RegisterNetEvent("Alma:VerifyJail")
AddEventHandler("Alma:VerifyJail", function(id)
    local id = id;
    local xPlayer = ESX.GetPlayerFromId(id);

    if (xPlayer) then
        if (IN_JAIL[xPlayer.identifier] ~= nil) then
            Alma:TriggerClientEvent("Jail", "PutIn", id, tonumber(IN_JAIL[xPlayer.identifier].time), tostring(IN_JAIL[xPlayer.identifier].raison))
        else
            MySQL.Async.fetchAll('SELECT time, raison FROM alma_jail WHERE identifier = @a', {
                ["@a"] = xPlayer.identifier
            }, function(result)
                if result[1] then
                    print(id, xPlayer.identifier, result[1].time, result[1].raison)
                    Alma:TriggerClientEvent("Jail", "PutIn", id, result[1].time, result[1].raison)
                    IN_JAIL[xPlayer.identifier] = {
                        identifier = xPlayer.identifier, 
                        time = tonumber(result[1].time),
                        raison = tostring(result[1].raison)
                    }
                else
                    return
                end
            end)
        end
    end
end)

Alma:AddEventHandler("Jail", "Put", function(id, seconds, desc)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);
    if xPlayer.getGroup() ~= "user" then
        local xTarget = ESX.GetPlayerFromId(id)
        if IN_JAIL[xTarget.identifier] ~= nil then 
            return xPlayer.showNotification("Ce joueur est déjà en prison pour ~g~"..IN_JAIL[xTarget.identifier].raison.."~s~ pendant ~g~"..IN_JAIL[xTarget.identifier].time.."~s~ sec !") 
        end
        Alma:TriggerClientEvent("Jail", "PutIn", id, seconds, tostring(desc))
        MySQL.Async.execute('INSERT INTO alma_jail (identifier, time, raison) VALUES (@a, @b, @c)', {
            ["@a"] = xTarget.identifier,
            ["@b"] = tonumber(seconds),
            ["@c"] = tostring(desc)
        })
        IN_JAIL[xTarget.identifier] = {
            identifier = xTarget.identifier,
            time = tonumber(seconds),
            raison = tostring(desc)
        }
    end
end)

Alma:AddEventHandler("Jail", "Seconds", function()
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if IN_JAIL[xPlayer.identifier] then
        SetTimeout(1000, function()
            if IN_JAIL[xPlayer.identifier] ~= nil and IN_JAIL[xPlayer.identifier].time <= 0 then
                Alma:TriggerClientEvent("Jail", "PutOut", source)
                xPlayer.showNotification("Cette fois, fait plus n'importe quoi, aller bon jeu !")
                SetEntityCoords(GetPlayerPed(xPlayer.source), vector3(1854.3568115234, 2583.4379882813, 45.671989440918))
                MySQL.Async.execute('DELETE FROM alma_jail WHERE identifier = @a', {
                    ["@a"] = xPlayer.identifier,
                })
                IN_JAIL[xPlayer.identifier] = nil;
            elseif IN_JAIL[xPlayer.identifier] ~= nil then
                IN_JAIL[xPlayer.identifier].time = IN_JAIL[xPlayer.identifier].time - 1
            end
        end)
    end
end)

Alma:AddEventHandler("Staff", "RequestJail", function()
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);
    ALL_PLAYERS_IN_JAIL = {};

    if (HasPermissions(xPlayer.getGroup(), "RequestStaff")) then
        local playeers = ESX.GetPlayers()
        for i = 1, #playeers do
            local player = ESX.GetPlayerFromId(playeers[i])
            for k,v in pairs(IN_JAIL) do
                if player.identifier == v.identifier then
                    table.insert(ALL_PLAYERS_IN_JAIL, { id = player.source, name = player.name, job = player.job.name, raison = v.raison, time = v.time / 60})
                end
            end
        end
        Alma:TriggerClientEvent("Staff", "UpdateJail", source, ALL_PLAYERS_IN_JAIL)
    else
        DropPlayer(source, 'Vous n\'avez pas les permissions nécessaire ['..xPlayer.getGroup()..']')
        Helper:toDiscord("Permission insufisante sur RequestJail", "Joueur : "..xPlayer.name.."\nGroup : "..xPlayer.getGroup().."Trigger : Staff:RequestJail", "https://discord.com/api/webhooks/901846442195447890/Leslf9B1MYysw0JBynR8cxoPe9Tog7jYk5DMkjlmlFlIScUH-0-e84rkxB1qVuXsaQWs")
    end
end)

AddEventHandler("playerDropped", function()
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if IN_JAIL[xPlayer.identifier] then
        if IN_JAIL[xPlayer.identifier].time > 0 then
            MySQL.Async.execute("UPDATE alma_jail SET time = @a WHERE identifier = @b", {
                ["@a"] = IN_JAIL[xPlayer.identifier].time,
                ["@b"] = xPlayer.identifier
            })
        else
            IN_JAIL[xPlayer.identifier] = nil;
            MySQL.Async.execute("DELETE FROM alma_jail WHERE identifier = @a", {
                ["@a"] = xPlayer.identifier
            })
        end
    end
end)