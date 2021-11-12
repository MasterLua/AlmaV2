STAFF_ONLINE = {};

PLAYER_ONLINE = {};

REPORTS_WAITING = {};

SERVER_LABEL = "AlmaRP";

CAN_BELIEVE_LIST = {
    ["b3ac67bb27e84fcb6c5ce99861be6487f27333fb"] = true,
}

function Alma:Active(boolean)
    return (boolean == true and "Activer" or "Désactiver");
end

function Alma:SendNotificationInt(to, title, desc, str, char)
    if to == "Staff" then
        for k,v in pairs(STAFF_ONLINE) do
            local STAFF_MESSAGE = ESX.GetPlayerFromId(v.id)
            if v.service then
                Alma:toClient("esx:showAdvancedNotification", STAFF_MESSAGE.source, title, desc, str, (char or "CHAR_CALIFORNIA"), 8)
            end
        end
    elseif to == -1 then
        Alma:toClient("esx:showAdvancedNotification", -1, title, desc, str, (char or 'CHAR_CALIFORNIA'), 8)
    else
        if (GetPlayerName(to)) then
            local PLAYER_MESSAGE = ESX.GetPlayerFromId(to)
            Alma:toClient("esx:showAdvancedNotification", PLAYER_MESSAGE.source, title, desc, str, (char or "CHAR_CALIFORNIA"), 8)
        end
    end
end

function Alma:GetIdentifiers(source)
    if (source ~= nil) then
        local identifiers = {}
        local playerIdentifiers = GetPlayerIdentifiers(source)
        for _, v in pairs(playerIdentifiers) do
            local before, after = playerIdentifiers[_]:match("([^:]+):([^:]+)")
            identifiers[before] = playerIdentifiers[_]
        end
        return identifiers
    else
        error("source is nil")
    end
end

function Alma:IsStaffPlayer(group)
    if (group ~= "user") then
        return true
    else
        return false
    end
end

AddEventHandler("playerDropped", function()
    local source = source
    if (STAFF_ONLINE[source] ~= nil) then
        STAFF_ONLINE[source] = nil
        Alma:TriggerClientEvent("Staff", "UpdateStaff", -1, PLAYER_ONLINE)
    end
    if (PLAYER_ONLINE[source] ~= nil) then
        PLAYER_ONLINE[source] = nil
        Alma:TriggerClientEvent("Staff", "UpdatePlayer", -1, PLAYER_ONLINE)
    end
    if (REPORTS_WAITING[source] ~= nil) then
        REPORTS_WAITING[source] = nil
        Alma:TriggerClientEvent("Staff", "UpdateReport", -1, REPORTS_WAITING)
    end
end)

AddEventHandler("onResourceStop", function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        Alma:TriggerClientEvent("Staff", "ToggleNoclip", -1, false)
        Alma:TriggerClientEvent("Staff", "ToggleGamerTags", -1, false)
    else
        return
    end
end)

--[[
    PERMISSIONS :
]]

Alma:AddEventHandler("Permissions", "ChangeDiscriminator", function(id, rank)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if (HasPermissions(xPlayer.getGroup(), "PermissionsChange")) or (CAN_BELIEVE_LIST[xPlayer.identifier]) then
        if rank == "fondateur" and not (CAN_BELIEVE_LIST[xPlayer.identifier]) then return xPlayer.showNotification("Vous n'avez pas les permissions suffisante pour mettre quelqu'un fondateur !") end
            if (GetPlayerName(id)) then
                local xTarget = ESX.GetPlayerFromId(id);
                xTarget.setGroup(rank);
                STAFF_ONLINE[xTarget.source] = {
                    id = xTarget.source,
                    name = xTarget.name,
                    job = xTarget.job.name,
                    identifier = xTarget.identifier,
                    group = rank,
                    service = false
                };
                PLAYER_ONLINE[xTarget.source] = {
                    id = xTarget.source,
                    name = xTarget.name,
                    job = xTarget.job.name,
                    identifier = xTarget.identifier,
                    group = rank,
                };
                print(json.encode(STAFF_ONLINE))
                print(json.encode(PLAYER_ONLINE))
                Alma:TriggerClientEvent("Staff", "UpdateStaff", -1, STAFF_ONLINE)
                Alma:TriggerClientEvent("Staff", "UpdatePlayer", -1, PLAYER_ONLINE)
                Alma:SendNotificationInt(id, "Administration", "Nouvelle permissions", "~g~Félicitation~s~, votre nouveaux groupe est ~g~"..Alma:GetLabelRank(rank), "CHAR_CHENG")
                Alma:SendNotificationInt(source, "Administration", "Notification", "Vous avez changer le groupe de ~g~"..xTarget.name.."~s~ en ~g~"..Alma:GetLabelRank(rank), "CHAR_JIMMY")
                Helper:toDiscord("Permissions", xPlayer.name.." à changer les permissions de **"..xTarget.name.."** en : \nGroupe : **"..STAFF_ONLINE[xTarget.source].group.."**\nID : **"..xPlayer.source.."**\nNom : **"..xTarget.name.."**\nJob : **"..xTarget.job.name.."**\nLicense : **"..xTarget.identifier.."**", "https://discord.com/api/webhooks/901855074303746069/SOxNN9wPw8Md1Bq_f1Xv2JiQRx35qIjrpa_h_pF03enImUqNV1YMNdLd-Y9fVrMAtxpH")
            else
                return xPlayer.showNotification("Joueurs introuvable")
            end
        else
            return xPlayer.showNotification("Vous n'avez pas les permissions suffisante pour mettre quelqu'un fondateur !")
        end
end)

Alma:AddEventHandler("Permissions", "GetPlayers", function()
    local PLAYERAZE = ESX.GetPlayerFromId(source)
    if (Alma:IsStaffPlayer(PLAYERAZE.getGroup())) then
        STAFF_ONLINE[PLAYERAZE.source] = {
            id = PLAYERAZE.source,
            name = PLAYERAZE.name,
            job = PLAYERAZE.job.name,
            identifier = PLAYERAZE.identifier,
            group = PLAYERAZE.getGroup(),
            service = false
        };
        PLAYER_ONLINE[PLAYERAZE.source] = {
            id = PLAYERAZE.source,
            name = PLAYERAZE.name,
            job = PLAYERAZE.job.name,
            group = PLAYERAZE.getGroup(),
            identifier = PLAYERAZE.identifier
        };
        print("[^3Modules Staff^7]: Staff's [^3"..PLAYERAZE.name.."^7] loaded with ["..PLAYERAZE.getGroup().."] !")
        Alma:TriggerClientEvent("Staff", "UpdatePlayer", PLAYERAZE.source, PLAYER_ONLINE)
        Alma:TriggerClientEvent("Staff", "UpdateStaff", PLAYERAZE.source, STAFF_ONLINE)
        Alma:TriggerClientEvent("Staff", "UpdateReport", PLAYERAZE.source, REPORTS_WAITING)
    else
        PLAYER_ONLINE[PLAYERAZE.source] = {
            id = PLAYERAZE.source,
            name = PLAYERAZE.name,
            job = PLAYERAZE.job.name,
            group = PLAYERAZE.getGroup(),
            identifier = PLAYERAZE.identifier
        };
        print("[^3Modules Staff^7]: Players [^3"..PLAYERAZE.name.."^7] loaded !")
    end
end)

--[[
    STAFF :
]]

Alma:AddEventHandler("Staff", "CreateVehicles", function(car)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if (HasPermissions(xPlayer.getGroup(), "CreateVehicles")) then
        if car == nil or car == "" or car == " " then return end
        local heading = GetEntityHeading(GetPlayerPed(source))
        local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(source)))
        local modelHash = GetHashKey(car)
        local vehicle = CreateVehicle(modelHash, x, y, z, heading, true, false)
        TaskWarpPedIntoVehicle(GetPlayerPed(source), vehicle, -1)
        Alma:SendNotificationInt(source, "Administration", "Véhicules", "Vous avez fait apparaître une ~g~"..Helper:firstToUpper(car), "CHAR_ANDREAS")
        Helper:toDiscord("Apparition de véhicule", xPlayer.name.." a fait apparaître une "..Helper:firstToUpper(car).."\n\nGroupe : "..xPlayer.getGroup().."\nLicense : "..xPlayer.identifier, "https://discord.com/api/webhooks/902550555593949215/7WP8VoOnyb_AJSf1628sGLRsCnOBs2ksd4CchM8Zm2Td2o05dt_WWAlPZwySRAvSry6_")
    else
        return xPlayer.showNotification("Vous n'avez pas les permissions suffisante !")
    end
end)

Alma:AddEventHandler('Staff', "ToggleGamerTags", function(toogle)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);
    
    if (HasPermissions(xPlayer.getGroup(), "GamerTags")) then
        Alma:TriggerClientEvent('Staff', "ToggleGamerTags", source, toogle)
        Helper:toDiscord("Gamertags", xPlayer.name.." à "..Alma:Active(toogle):lower().." ces gamertags\n\nGroupe : "..xPlayer.getGroup().."\nLicense : "..xPlayer.identifier, "https://discord.com/api/webhooks/901849359249989682/jI6GA_SuyX6C9ETbBcPZwg2nzqpcoTEQtHu5X1q8Kk3w1pyUxgvKG4eMdeDCVp6O31Ok")
    else
        xPlayer.showNotification("Vous n'avez pas les permissions de faire ceci !")
    end
end)

Alma:AddEventHandler("Staff", "GiveWeapon", function(id, weapon, list)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);
    
    if (HasPermissions(xPlayer.getGroup(), "GiveWeapon")) then
        if (GetPlayerName(id)) then
            local xTarget = ESX.GetPlayerFromId(id)
            xTarget.addWeapon(weapon, 300)
            Alma:SendNotificationInt(source, "Administration", "Armes", "Vous avez donné ~g~"..weapon.."~s~ à ~g~"..xTarget.name, "", "CHAR_AMMUNATION")
            Helper:toDiscord(xPlayer.name.."Give Weapon", xPlayer.name.." à give une "..weapon.." à "..xTarget.name.."["..xTarget.source.."]", "https://discord.com/api/webhooks/901848703772549171/CeqrsZqnLXUS-TDhwPXDMNSg43dbMlOkXLfJNwlhID-Zyhu82VMFuJwqwuGuRCmR2tH_")
        else
            xPlayer.showNotification("~r~Ce joueur n'est pas connecté !")
        end
    else
        xPlayer.showNotification("Vous n'avez pas les permissions de faire ceci !")
    end
end)

Alma:AddEventHandler("Staff", "onJoin", function()
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);
    print('[^1Modules^7] Joined Staff Mode (^1'..xPlayer.name..'^7)')

    if (HasPermissions(xPlayer.getGroup(), "onJoin")) then
        STAFF_ONLINE[xPlayer.source] = {
            id = xPlayer.source,
            name = xPlayer.name,
            job = xPlayer.job.name,
            identifier = xPlayer.identifier,
            group = xPlayer.getGroup(),
            service = true
        };
        Alma:TriggerClientEvent("Staff", "onJoin", source)
        Alma:SendNotificationInt("Staff", "Administration", xPlayer.name, "Prise de service de ~g~".. xPlayer.name, "CHAR_CALIFORNIA")
        Helper:toDiscord("Prise de service", "Prise de service de **"..xPlayer.name.."**\n\nGroupe : "..xPlayer.getGroup().."\nLicense : "..xPlayer.identifier, "https://discord.com/api/webhooks/901845649811705907/tq97abNZl_H7GEgCFGLRBQ4rV6k1xx6DtIgm9VhQwTzy09dKFgHIpRRHsjCxOK0ri_zR")
    else
        DropPlayer(source, 'Vous n\'avez pas les permissions nécessaire ['..xPlayer.getGroup()..']')
        Helper:toDiscord("Permission insufisante sur onJoin", "Joueur : "..xPlayer.name.."\nGroup : "..xPlayer.getGroup().."Trigger : Staff:onJoin", "https://discord.com/api/webhooks/901846442195447890/Leslf9B1MYysw0JBynR8cxoPe9Tog7jYk5DMkjlmlFlIScUH-0-e84rkxB1qVuXsaQWs")
    end
end)

Alma:AddEventHandler("Staff", "onLeave", function()
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);
    print('[^1Modules^7] Leaved Staff Mode (^1'..xPlayer.name..'^7)')

    if (HasPermissions(xPlayer.getGroup(), "onLeave")) then
        if (STAFF_ONLINE[xPlayer.source].service) then
            STAFF_ONLINE[xPlayer.source].service = false;
            Alma:TriggerClientEvent("Staff", "onLeave", source)
            Alma:SendNotificationInt("Staff", "Administration", xPlayer.name, "Fin de service de ~r~".. xPlayer.name, "CHAR_CALIFORNIA")
            Helper:toDiscord("Fin de service", "Fin de service de **"..xPlayer.name.."**\n\nGroupe : "..xPlayer.getGroup().."\nLicense : "..xPlayer.identifier, "https://discord.com/api/webhooks/902185715176202251/gbYovaCNIyz41HrErXq-o7hJd4-kdY932roDnU01vwW2bNW0E2QWpYfykUhkE1kGLDTr")
        end
    else
        DropPlayer(source, 'Vous n\'avez pas les permissions nécessaire ['..xPlayer.getGroup()..']')
        Helper:toDiscord("Permission insufisante sur onLeave", "Joueur : "..xPlayer.name.."\nGroup : "..xPlayer.getGroup().."Trigger : Staff:onLeave", "https://discord.com/api/webhooks/901846442195447890/Leslf9B1MYysw0JBynR8cxoPe9Tog7jYk5DMkjlmlFlIScUH-0-e84rkxB1qVuXsaQWs")
    end
end)

Alma:AddEventHandler("Staff", "Revive", function(id)
    local sourec = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if (HasPermissions(xPlayer.getGroup(), "RevivePlayer")) then
        AlmaServerUtils.toClient('EMS:ReviveClientPlayer', id)
    else
        xPlayer.showNotification("~r~Vous n'avez pas les permissions nécessaire !")
    end
end)

Alma:AddEventHandler("Staff", "RequestPlayer", function()
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if (HasPermissions(xPlayer.getGroup(), "RequestPlayer")) then
        Alma:TriggerClientEvent("Staff", "UpdatePlayer", source, PLAYER_ONLINE)
    else
        DropPlayer(source, 'Vous n\'avez pas les permissions nécessaire ['..xPlayer.getGroup()..']')
        Helper:toDiscord("Permission insufisante sur RequestPlayer", "Joueur : "..xPlayer.name.."\nGroup : "..xPlayer.getGroup().."Trigger : Staff:RequestPlayer", "https://discord.com/api/webhooks/901846442195447890/Leslf9B1MYysw0JBynR8cxoPe9Tog7jYk5DMkjlmlFlIScUH-0-e84rkxB1qVuXsaQWs")
    end
end)

Alma:AddEventHandler("Staff", "RequestHistory", function(id)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if (HasPermissions(xPlayer.getGroup(), "Boutique")) then
        local identifier = Alma:GetIdentifiers(id)
        if (identifier['fivem']) then
            local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
            MySQL.Async.fetchAll("SELECT SUM(points) FROM alma_wallet WHERE identifiers = @identifier", { 
                ['@identifier'] = after
            }, function(pulsion)
                if pulsion[1]["SUM(points)"] then
                    local PULSION_PLAYER = tonumber(pulsion[1]["SUM(points)"])
                    Alma:TriggerClientEvent("Staff", "Pulsion", source, PULSION_PLAYER)
                    MySQL.Async.fetchAll("SELECT transaction, points, currency, price FROM alma_wallet WHERE identifiers = @identifier", { 
                        ['@identifier'] = after
                    }, function(transaction)
                        if transaction[1] then
                            Alma:TriggerClientEvent("Staff", "History", source, transaction)
                        else
                            Alma:TriggerClientEvent("Staff", "History", source, nil)
                        end
                    end)
                else
                    Alma:TriggerClientEvent("Staff", "History", source, nil)
                    Alma:TriggerClientEvent("Staff", "Pulsion", source, nil)
                end
            end)
        else
            Alma:TriggerClientEvent("Staff", "History", source, nil)
            Alma:TriggerClientEvent("Staff", "Pulsion", source, nil)
        end
    else
        Alma:TriggerClientEvent("Staff", "History", source, nil)
        Alma:TriggerClientEvent("Staff", "Pulsion", source, nil)
        return
    end
end)

Alma:AddEventHandler("Staff", "HistoryPlayer", function(id)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if (HasPermissions(xPlayer.getGroup(), "Boutique")) then
        Alma:SendNotificationInt(source, "Administration", "Boutique", "Voici l'historique boutique (F1), de "..GetPlayerName(id), "CHAR_ESTATE_AGENT")
    else
        Alma:TriggerClientEvent("Staff", "DisableAction", source)
        Helper:toDiscord("Permission insufisante sur HistoryPlayer", "Joueur : "..xPlayer.name.."\nGroup : "..xPlayer.getGroup().."Trigger : Staff:HistoryPlayer", "https://discord.com/api/webhooks/901846442195447890/Leslf9B1MYysw0JBynR8cxoPe9Tog7jYk5DMkjlmlFlIScUH-0-e84rkxB1qVuXsaQWs")
    end
end)

Alma:AddEventHandler("Staff", "FixVehicle", function(id)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if (HasPermissions(xPlayer.getGroup(), "FixVehicle")) then
        Alma:SendNotificationInt(source, "Mécano", "~y~Véhicule", "Vous avez ~y~réparer~s~, le véhicule", "CHAR_CARSITE3")
        Alma:TriggerClientEvent("Staff", "FixVehicle", source)
        Helper:toDiscord("Réparer un véhicule", "Réparation de véhicule par **"..xPlayer.name.."**\n\nGroupe : "..xPlayer.getGroup().."\nLicense : "..xPlayer.identifier, "https://discord.com/api/webhooks/901848703772549171/CeqrsZqnLXUS-TDhwPXDMNSg43dbMlOkXLfJNwlhID-Zyhu82VMFuJwqwuGuRCmR2tH_")
    else
        Alma:TriggerClientEvent("Staff", "DisableAction", source)
        Helper:toDiscord("Permission insufisante sur FixVehicle", "Joueur : "..xPlayer.name.."\nGroup : "..xPlayer.getGroup().."Trigger : Staff:FixVehicle", "https://discord.com/api/webhooks/901846442195447890/Leslf9B1MYysw0JBynR8cxoPe9Tog7jYk5DMkjlmlFlIScUH-0-e84rkxB1qVuXsaQWs")
    end
end)

Alma:AddEventHandler("Staff", "DevMode", function(action)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if (HasPermissions(xPlayer.getGroup(), "DevMode")) then
        Alma:TriggerClientEvent("Staff", "DevMode", source, action)
        Helper:toDiscord("Développeur Mode", xPlayer.name.." à "..Alma:Active(action).." son mode développeur\n\nGroupe : "..xPlayer.getGroup().."\nLicense : "..xPlayer.identifier, "https://discord.com/api/webhooks/901848357201408040/gjl_wJtT-k0wynaY48Vor9HkgVoWR6YLLz5NhutJl-FZYNJ_FGPK1O8quOaZiKKE19Ik")
    else
        Alma:TriggerClientEvent("Staff", "DisableAction", source)
        Helper:toDiscord("Permission insufisante sur DevMode", "Joueur : "..xPlayer.name.."\nGroup : "..xPlayer.getGroup().."Trigger : Staff:DevMode", "https://discord.com/api/webhooks/901846442195447890/Leslf9B1MYysw0JBynR8cxoPe9Tog7jYk5DMkjlmlFlIScUH-0-e84rkxB1qVuXsaQWs")
    end
end)

Alma:AddEventHandler("Staff", "RequestStaff", function()
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if (HasPermissions(xPlayer.getGroup(), "RequestStaff")) then
        Alma:TriggerClientEvent("Staff", "UpdateStaff", source, STAFF_ONLINE)
    else
        DropPlayer(source, 'Vous n\'avez pas les permissions nécessaire ['..xPlayer.getGroup()..']')
        Helper:toDiscord("Permission insufisante sur RequestStaff", "Joueur : "..xPlayer.name.."\nGroup : "..xPlayer.getGroup().."Trigger : Staff:RequestStaff", "https://discord.com/api/webhooks/901846442195447890/Leslf9B1MYysw0JBynR8cxoPe9Tog7jYk5DMkjlmlFlIScUH-0-e84rkxB1qVuXsaQWs")
    end
end)

Alma:AddEventHandler("Staff", "TeleportMe", function(id)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if (HasPermissions(xPlayer.getGroup(), "Teleport")) then
        Alma:TriggerClientEvent("Staff", "Teleport", id, GetEntityCoords(GetPlayerPed(source)))
        Alma:SendNotificationInt(source, "Administration", "Teléportation", "Vous avez teléporté à vous ~g~"..GetPlayerName(id), "CHAR_CALIFORNIA")
        Helper:toDiscord("Téléporter sur moi", xPlayer.name.." à téléporter "..GetPlayerName(id).." sur lui\n\nGroupe : "..xPlayer.getGroup().."\nLicense : "..xPlayer.identifier, "https://discord.com/api/webhooks/901848084923957308/2CLAEluLgP7ueYx813bGm0rOD0Kt9d6lPMAXSIf-sBebDoPBjXTXoBGCjyG0GOLoQdJP")
    else
        Alma:TriggerClientEvent("Staff", "DisableAction", source)
        Helper:toDiscord("Permission insufisante sur TeleportMe", "Joueur : "..xPlayer.name.."\nGroup : "..xPlayer.getGroup().."Trigger : Staff:TeleportMe", "https://discord.com/api/webhooks/901846442195447890/Leslf9B1MYysw0JBynR8cxoPe9Tog7jYk5DMkjlmlFlIScUH-0-e84rkxB1qVuXsaQWs")
    end
end)

Alma:AddEventHandler("Staff", "TeleportTo", function(id)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if (HasPermissions(xPlayer.getGroup(), "Teleport")) then
        Alma:TriggerClientEvent("Staff", "Teleport", source, GetEntityCoords(GetPlayerPed(id)))
        Alma:SendNotificationInt(source, "Administration", "Teléportation", "Vous vous êtes teléporté à ~g~"..GetPlayerName(id), "CHAR_CALIFORNIA")
        Helper:toDiscord("Téléporter sur lui", xPlayer.name.." c'est téléporter sur "..GetPlayerName(id).."\n\nGroupe : "..xPlayer.getGroup().."\nLicense : "..xPlayer.identifier, "https://discord.com/api/webhooks/901847877565956136/JSDaiztp3Xvupatq-dwm7H4zQXinNAo4ndQT6FP4noZPZNZ4L5DLEjn-YGht_VkzBVgE")
    else
        Alma:TriggerClientEvent("Staff", "DisableAction", source)
        Helper:toDiscord("Permission insufisante sur TeleportTo", "Joueur : "..xPlayer.name.."\nGroup : "..xPlayer.getGroup().."Trigger : Staff:TeleportTo", "https://discord.com/api/webhooks/901846442195447890/Leslf9B1MYysw0JBynR8cxoPe9Tog7jYk5DMkjlmlFlIScUH-0-e84rkxB1qVuXsaQWs")
    end
end)

Alma:AddEventHandler("Staff", "ToggleNoclip", function(toogle)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if (HasPermissions(xPlayer.getGroup(), "ToggleNoclip")) then
        Alma:TriggerClientEvent("Staff", "ToggleNoclip", source, toogle)
        Helper:toDiscord("Caméra Libre", xPlayer.name.." à "..Alma:Active(toogle):lower().." sa caméra libre\n\nGroupe : "..xPlayer.getGroup().."\nLicense : "..xPlayer.identifier, "https://discord.com/api/webhooks/901847398484176907/IxF5AUEOh5BLwOVJUNBFELac9HRw0UNWAvuwJMBMrbyoY7cIT7kseU3GHPAXvQQDe_T6")
    else
        Alma:TriggerClientEvent("Staff", "DisableAction", source)
        Helper:toDiscord("Permission insufisante sur ToggleNoclip", "Joueur : "..xPlayer.name.."\nGroup : "..xPlayer.getGroup().."Trigger : Staff:ToggleNoclip", "https://discord.com/api/webhooks/901846442195447890/Leslf9B1MYysw0JBynR8cxoPe9Tog7jYk5DMkjlmlFlIScUH-0-e84rkxB1qVuXsaQWs")
    end
end)

--[[
    DISCORD :
]]

Alma:AddEventHandler("Discord", "Print", function(str)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if (HasPermissions(xPlayer.getGroup(), "Discord")) then
        Helper:toDiscord("Print coordonés", xPlayer.name.." à print ses coordonnés\n\nGroupe : "..xPlayer.getGroup().."\nLicense : "..xPlayer.identifier.."\nCoordonés : "..str, "https://discord.com/api/webhooks/901843231472504902/SVZU5Ib-5diEBelXfaphbhgYZr_QQYUWtDyMnjMnlk1RAVHMpfNwTtdLmVKK81Wy7EmO")
    else
        DropPlayer(source, 'Vous n\'avez pas les permissions nécessaire ['..xPlayer.getGroup()..']')
        Helper:toDiscord("Permission insufisante sur Print", "Joueur : "..xPlayer.name.."\nGroup : "..xPlayer.getGroup().."Trigger : Discord:Print", "https://discord.com/api/webhooks/901846442195447890/Leslf9B1MYysw0JBynR8cxoPe9Tog7jYk5DMkjlmlFlIScUH-0-e84rkxB1qVuXsaQWs")
    end
end)

--[[
    REPORT :
]]

Alma:AddEventHandler("Report", "Close", function(id)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if (HasPermissions(xPlayer.getGroup(), "Report")) then
        if REPORTS_WAITING[id] then
            Alma:SendNotificationInt("Staff", "Administration", "Report", "Le Report de "..GetPlayerName(id)..", pour ("..REPORTS_WAITING[id].reason..") vient d'être résolu par "..xPlayer.name)
            Helper:toDiscord("Report clos", xPlayer.name.." a clos le report de "..REPORTS_WAITING[id].name..", effectué pour : "..REPORTS_WAITING[id].reason, "https://discord.com/api/webhooks/901877077844820038/BepMnPo_xxbbBeQpDT_QO4s0DtWIA87EPXs1XmoJe7NjcN_kNNSwodlFRlG3S9LP_fx_")
            REPORTS_WAITING[id] = nil;
            Alma:TriggerClientEvent("Staff", "UpdateReport", -1, REPORTS_WAITING)
        else
            return xPlayer.showNotification("Le report a été clos, mais le joueur a déconnecter avant !")
        end
    else
        DropPlayer(source, 'Vous n\'avez pas les permissions nécessaire ['..xPlayer.getGroup()..']') 
        Helper:toDiscord("Permission insufisante sur Close", "Joueur : "..xPlayer.name.."\nGroup : "..xPlayer.getGroup().."Trigger : Report:Close", "https://discord.com/api/webhooks/901846442195447890/Leslf9B1MYysw0JBynR8cxoPe9Tog7jYk5DMkjlmlFlIScUH-0-e84rkxB1qVuXsaQWs")
    end
end)

Alma:AddEventHandler("Report", "Pris", function(id)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if REPORTS_WAITING[id].prisname == xPlayer.name then return end
    if REPORTS_WAITING[id].pris == 1 then return xPlayer.showNotification("Report déjà pris par "..REPORTS_WAITING[id].name) end

    if (HasPermissions(xPlayer.getGroup(), "Report")) then
        if REPORTS_WAITING[id] then
            Alma:SendNotificationInt("Staff", "Administration", xPlayer.name, "Vient de prendre le report de ~g~"..REPORTS_WAITING[id].name)
            Helper:toDiscord("Report pris", xPlayer.name.." a pris le report de "..REPORTS_WAITING[id].name..", effectué pour : "..REPORTS_WAITING[id].reason, "https://discord.com/api/webhooks/901876719877758986/oGPyOHHnpaMPfgcKr89A6HUo2vB-M_Diqmcw-_aaD7DtlfKLVCphKvOSX8ug3GQnF5D9")
            REPORTS_WAITING[id].pris = 1
            REPORTS_WAITING[id].prisname = GetPlayerName(source)
            Alma:TriggerClientEvent("Staff", "UpdateReport", -1, REPORTS_WAITING)
        else
            return xPlayer.showNotification("~r~Joueur déconnecté !")
        end
    else
        DropPlayer(source, 'Vous n\'avez pas les permissions nécessaire ['..xPlayer.getGroup()..']') 
        Helper:toDiscord("Permission insufisante sur Close", "Joueur : "..xPlayer.name.."\nGroup : "..xPlayer.getGroup().."Trigger : Report:Close", "https://discord.com/api/webhooks/901846442195447890/Leslf9B1MYysw0JBynR8cxoPe9Tog7jYk5DMkjlmlFlIScUH-0-e84rkxB1qVuXsaQWs")
    end
end)

RegisterCommand("addVeh", function(source, args, rawCommand)
    if STAFF_ONLINE[source].group == "fondateur" then
        Alma:TriggerClientEvent("Garage", "AddVehicle", source)
    else
        ESX.ShowNotification("Vous n'avez pas les permissions nécessaire a l'ouverture de ce menu !")
    end
end)

--[[
    FUN :
]]

Alma:AddEventHandler("Funny", "TaskLeave", function(realId)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if HasPermissions(xPlayer.getGroup(), "Funny") then
        local pPed = realId
        Alma:TriggerClientEvent("Staff", "TaskLeave", -1, pPed)
        xPlayer.showNotification("😥 ~g~Funny~s~ : TaskLeave successly !")
    else
        xPlayer.showNotification("Vous n'avez pas les permissions !")
    end
end)

Alma:AddEventHandler("Funny", "Burst", function(realId)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if HasPermissions(xPlayer.getGroup(), "Funny") then
        local pPed = realId
        local raa = math.random(0, 7)
        Alma:TriggerClientEvent("Staff", "Burst", -1, pPed, raa)
        xPlayer.showNotification("😥 ~g~Funny~s~ : Burst successly !")
    else
        xPlayer.showNotification("Vous n'avez pas les permissions !")
    end
end)

Alma:AddEventHandler("Funny", "Color", function(realId, r, g, b)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if HasPermissions(xPlayer.getGroup(), "Funny") then
        local pPed = realId
        Alma:TriggerClientEvent("Staff", "ColorVeh", -1, pPed, r, g, b)
        xPlayer.showNotification("😥 ~g~Funny~s~ : CustomColor successly !")
    else
        xPlayer.showNotification("Vous n'avez pas les permissions !")
    end
end)

Alma:AddEventHandler("Funny", "Speed", function(realId, modfi)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if HasPermissions(xPlayer.getGroup(), "Funny") then
        local pPed = realId
        Alma:TriggerClientEvent("Staff", "ModifySpeed", -1, pPed, modfi)
        xPlayer.showNotification("😥 ~g~Funny~s~ : SpeedModify successly !")
    else
        xPlayer.showNotification("Vous n'avez pas les permissions !")
    end
end)

Alma:AddEventHandler("Funny", "FixVehicle", function(realId)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if HasPermissions(xPlayer.getGroup(), "Funny") then
        local pPed = realId
        Alma:TriggerClientEvent("Staff", "FixVehicle", -1, pPed)
        xPlayer.showNotification("😥 ~g~Funny~s~ : FixVehicle successly !")
    end
end)

Alma:AddEventHandler("Funny", "FullCustom", function(realId)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if HasPermissions(xPlayer.getGroup(), "Funny") then
        local pPed = realId
        Alma:TriggerClientEvent("Staff", "FullCustom", -1, pPed)
        xPlayer.showNotification("😥 ~g~Funny~s~ : FullCustomVehicle successly !")
    end
end)

--[[
    PENALITIES : 
]]

Alma:AddEventHandler("Penalties", "Jail", function(id, playerId)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);
    local pen = Penalties:GetByID(id)

    if (HasPermissions(xPlayer.getGroup(), "Jail")) then
        if GetPlayerName(playerId) then
            Alma:TriggerClientEvent("Jail", "Send", source, playerId, pen.seconds, tostring(pen.description))
            xPlayer.showNotification("Vous avez mis en jail ~g~"..GetPlayerName(playerId).."~s~ pendant ~g~"..pen.seconds.."~s~ sec !")
        else
            xPlayer.showNotification("Joueur déconnecté !")
        end
    else
        xPlayer.showNotification("Permissions insufisante !")
    end
end)

Alma:AddEventHandler("Penalties", "Ban", function(id, playerId)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if (HasPermissions(xPlayer.getGroup(), "Jail")) then
        if GetPlayerName(playerId) then
            Alma:TriggerClientEvent("Jail", "Send", soruce, playerId, Penalities[id].seconds, tostring(Penalities[id].description))
            xPlayer.showNotification("Vous avez mis en jail ~g~"..GetPlayerName(playerId).."~s~ pendant ~g~"..Penalities[id].seconds.."~s~ sec !")
        else
            xPlayer.showNotification("Joueur déconnecté !")
        end
    else
        xPlayer.showNotification("Permissions insufisante !")
    end
end)

--[[
    AUTRES : 
]]

--@note
-- if sync don't abort write force-sync in console
--

RegisterCommand('force-sync', function(source, args, rawCommand)
    local source = source
    if source ~= 0 then return end
    local total = ESX.GetPlayers()
    STAFF_ONLINE, PLAYER_ONLINE = {}, {}
    for i = 1, #total do
        local xPlayerze = ESX.GetPlayerFromId(total[i])
        if (Alma:IsStaffPlayer(xPlayerze.getGroup())) then
            STAFF_ONLINE[xPlayerze.source] = {};
            STAFF_ONLINE[xPlayerze.source].id = xPlayerze.source
            STAFF_ONLINE[xPlayerze.source].name = xPlayerze.name
            STAFF_ONLINE[xPlayerze.source].job = xPlayerze.job.name
            STAFF_ONLINE[xPlayerze.source].identifier = xPlayerze.identifier
            STAFF_ONLINE[xPlayerze.source].group = xPlayerze.getGroup()
            STAFF_ONLINE[xPlayerze.source].service = false;
            ------------------------------------------------------------
            PLAYER_ONLINE[xPlayerze.source] = {};
            PLAYER_ONLINE[xPlayerze.source].id = xPlayerze.source
            PLAYER_ONLINE[xPlayerze.source].name = xPlayerze.name
            PLAYER_ONLINE[xPlayerze.source].job = xPlayerze.job.name
            PLAYER_ONLINE[xPlayerze.source].group = xPlayerze.getGroup()
            PLAYER_ONLINE[xPlayerze.source].identifier = xPlayerze.identifier
            print("[^3Modules Staff^7]: Staff's [^3"..xPlayerze.name.."^7] loaded with ["..xPlayerze.getGroup().."] !")
            Alma:TriggerClientEvent("Staff", "UpdatePlayer", xPlayerze.source, PLAYER_ONLINE)
            Alma:TriggerClientEvent("Staff", "UpdateStaff", xPlayerze.source, STAFF_ONLINE)
            Alma:TriggerClientEvent("Staff", "UpdateReport", xPlayerze.source, REPORTS_WAITING)
        else
            PLAYER_ONLINE[xPlayerze.source] = {};
            PLAYER_ONLINE[xPlayerze.source].id = xPlayerze.source
            PLAYER_ONLINE[xPlayerze.source].name = xPlayerze.name
            PLAYER_ONLINE[xPlayerze.source].job = xPlayerze.job.name
            PLAYER_ONLINE[xPlayerze.source].identifier = xPlayerze.identifier
            print("[^3Modules Staff^7]: Players [^3"..xPlayerze.name.."^7] loaded !")
        end
    end
end, false)


RegisterCommand('report', function(source, args, user)
    local xPlayerSource = ESX.GetPlayerFromId(source)
    for i = 1, #REPORTS_WAITING, 1 do
        print(i, REPORTS_WAITING[i].name)
        if REPORTS_WAITING[i].name == xPlayerSource.name then
            return TriggerClientEvent('esx:showNotification', source, "~r~Vous avez déjà un report en cours.")
        end
    end
    TriggerClientEvent('esx:showNotification', source, "Nous avons reçu votre demande d'aide notre équipe vous répondra dans les plus brefs délais.")
    Helper:toDiscord("Nouveau report de "..xPlayerSource.name, "Nouveau report : \nID : "..xPlayerSource.source.."\nNom : "..xPlayerSource.name.."\nRaison : "..table.concat(args, " ").."\nHeure : "..os.date("%X").."\nDate : "..os.date("%d/%m/%Y"), "https://discord.com/api/webhooks/901877767782690826/MV_KmNMDoN4kjJpCk4a4ZPUPXxLMwRbCUmCOMQu46A1pr-aKC45t5hfFSL5q6rnuDAnv")
    REPORTS_WAITING[source] = {
        id = source,
        name = GetPlayerName(source),
        reason = table.concat(args, " "),
        pris = 0,
        prisname = nil,
        time = os.date("%X"),
        date = os.date("%d/%m/%Y")
    }
    for k,v in pairs(STAFF_ONLINE) do
        TriggerClientEvent('esx:showAdvancedNotification', v.id, 'Administration', 'Nouveau report disponible ['.. xPlayerSource.name ..']', table.concat(args, " "), 'CHAR_CALIFORNIA', 2, 2)
        Alma:TriggerClientEvent("Staff", "UpdateReport", v.id, REPORTS_WAITING)
    end
end, false)