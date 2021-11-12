MySQL.ready(function()
	MySQL.Async.execute('DELETE FROM `alma_isdead`', {}, function()
	end)
end)

local PlayerIsDead = {}
local IsInServiceEMS = {}
Alma.netRegisterAndHandle('EMS:UpdateTableIsDead', function(value)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if value then
        if not PlayerIsDead[xPlayer.source] then
            PlayerIsDead[xPlayer.source] = {}
            PlayerIsDead[xPlayer.source].isDead = 1 
        else
            PlayerIsDead[xPlayer.source] = {}
            PlayerIsDead[xPlayer.source].isDead = 1 
        end
    else
        if not PlayerIsDead[xPlayer.source] then
            PlayerIsDead[xPlayer.source] = {}
            PlayerIsDead[xPlayer.source].isDead = 0
        else
            PlayerIsDead[xPlayer.source] = nil
        end
    end
end)

Alma.netRegisterAndHandle('EMS:RevivePlayer', function(target)
    if target == -1 then
        DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
        return
    else
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.job.name == 'ambulance' then
            if xPlayer.getInventoryItem('medikit').count >= 1 then
                xPlayer.removeInventoryItem('medikit', 1)
                AlmaServerUtils.toClient('EMS:ReviveClientPlayer', target)
                if PlayerIsDead[target] then
                    PlayerIsDead[target] = nil
                end
                xPlayer.showNotification('~w~Vous avez réanimer un joueurs')
                local TargetPlayer = ESX.GetPlayerFromId(target)
                TargetPlayer.showNotification('~w~Vous avez été réanimer par un medecin.')
            else
                xPlayer.showNotification('~w~~p~Vous n\'avez pas les outils nécéssaire.')
            end
        else
            DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
            return
        end
    end
end)

Alma.netRegisterAndHandle('EMS:HealPlayer', function(target)
    if target == -1 then
        DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
        return
    else
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.job.name == 'ambulance' then
            if xPlayer.getInventoryItem('bandage').count >= 2 then
                xPlayer.removeInventoryItem('bandage', 2)
                AlmaServerUtils.toClient('EMS:HealClientPlayer', target)
                xPlayer.showNotification('~w~Vous avez soigner un joueurs')
                local TargetPlayer = ESX.GetPlayerFromId(target)
                TargetPlayer.showNotification('~w~Vous avez été soigner par un medecin.')
            else
                xPlayer.showNotification('~w~~p~Vous n\'avez pas les outils nécéssaire.')
            end
        else
            DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
            return
        end
    end
end)

Alma.netRegisterAndHandle('EMS:annonce', function(value)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == 'ambulance' then
        if value == 'open' then
            TriggerClientEvent('esx:showAdvancedNotification', -1, 'Informations AlmaRP', '~p~Ambulance', 'Les ~p~EMS  ~w~sont ~g~disponible ~w~en ville !', 'CHAR_CALIFORNIA', 7)
        elseif value == 'close' then
            TriggerClientEvent('esx:showAdvancedNotification', -1, 'Informations AlmaRP', '~p~Ambulance', 'Les ~p~EMS  ~w~sont ~r~indisponible ~w~en ville !', 'CHAR_CALIFORNIA', 7)
        else
            DropPlayer(source, 'Désynchonisation avec le serveur ou detection de Cheat')
        end
    else
        DropPlayer(source, 'Désynchonisation avec le serveur ou detection de Cheat')
    end
end)

Alma.netRegisterAndHandle('EMS:GetItemSoins', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    eUtils.GetDistance(xPlayer.source, vector3(306.7531, -601.819, 43.284), 15, 'EMS:GetItemSoins', false, function() 
        if xPlayer.job.name == 'ambulance' then
            if item == 'medikit' then
                if xPlayer.getInventoryItem('medikit').count <= 10 then
                    xPlayer.addInventoryItem('medikit', 1)
                else
                    xPlayer.showNotification('~w~Vous avez trop de trousses de soins sur vous.')
                end
            elseif item == 'bandage' then
                if xPlayer.getInventoryItem('bandage').count <= 25 then
                    xPlayer.addInventoryItem('bandage', 1)
                else
                    xPlayer.showNotification('~w~Vous avez trop de bandages.')
                end
            end
        end
    end, function()
    end)
end)

Alma.netRegisterAndHandle('ewen:RetreiveIsDead', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM `alma_isdead` WHERE `license` = @license', {
        ['@license'] = xPlayer.identifier
    }, function(result)
        if result[1] then
            if not PlayerIsDead[xPlayer.source] then
                PlayerIsDead[xPlayer.source] = {}
                PlayerIsDead[xPlayer.source].isDead = 1
            end
            AlmaServerUtils.toClient('ewen:PlayerIsDead', xPlayer.source)
            xPlayer.showNotification('~w~Vous avez déconnecter en étant mort, Veuillez appelez les EMS.')
        end
    end)
    if xPlayer.job.name == 'ambulance' then
        IsInServiceEMS[xPlayer.source] = {}
        IsInServiceEMS[xPlayer.source].inService = false
    end
end)

local AppelsEMSList = {}
local CountAppel = 0
Alma.netRegisterAndHandle('ewen:CreateEmsSignal', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if AppelsEMSList[xPlayer.source] then
        xPlayer.showNotification(' ~w~~s~Vous avez déjà un appel en cours')
    else
        AppelsEMSList[xPlayer.source] = {}
        AppelsEMSList[xPlayer.source].position = GetEntityCoords(GetPlayerPed(source))
        local date = os.date('*t')
        AppelsEMSList[xPlayer.source].status = 0
        CountAppel = CountAppel+1
        AppelsEMSList[xPlayer.source].numbers = CountAppel
        AppelsEMSList[xPlayer.source].heures = math.floor(date.hour+2)
        AppelsEMSList[xPlayer.source].minutes = date.min
        AppelsEMSList[xPlayer.source].secondes = date.sec
        AppelsEMSList[xPlayer.source].src = xPlayer.source
        AppelsEMSList[xPlayer.source].raison = 'Une personne est inconsciente'
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local Players = ESX.GetPlayerFromId(xPlayers[i])

            if Players.job.name == 'ambulance' then
                if IsInServiceEMS[Players.source].inService then
                    Players.showNotification(' ~w~Un nouvelle appel à été reçu.')
                    AlmaServerUtils.toClient('ewen:UpdateTableSignalEms', -1, AppelsEMSList)
                end
            end
        end
        
    end
end)

Alma.netRegisterAndHandle('EMS:UpdateReport', function(AppelsEms, value)
    local xPlayer = ESX.GetPlayerFromId(source)
    if value then
        AppelsEMSList[AppelsEms].status = 1
        AppelsEMSList[AppelsEms].EMS = xPlayer.identifier
        AppelsEMSList[AppelsEms].EMSName = xPlayer.getName()
        AppelsEMSList[AppelsEms].EMS_SRC = xPlayer.source
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local Players = ESX.GetPlayerFromId(xPlayers[i])

            if Players.job.name == 'ambulance' then 
                if IsInServiceEMS[Players.source].inService then
                    AlmaServerUtils.toClient('ewen:UpdateTableSignalEms', -1, AppelsEMSList)
                end
            end
        end
    else
        AppelsEMSList[AppelsEms] = nil
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local Players = ESX.GetPlayerFromId(xPlayers[i])

            if Players.job.name == 'ambulance' then 
                if IsInServiceEMS[Players.source].inService then
                    AlmaServerUtils.toClient('ewen:UpdateTableSignalEms', -1, AppelsEMSList)
                end
            end
        end
    end
end)

Alma.netRegisterAndHandle('EMS:InformPatient', function(target)
    if target == -1 then
        DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
        return
    else
        local xPlayer = ESX.GetPlayerFromId(target)
        distance = #(GetEntityCoords(GetPlayerPed(source)) - AppelsEMSList[xPlayer.source].position)
        xPlayer.showNotification(' ~w~Un medecin est en route (~p~'..math.floor(distance)..'m~w~)')
    end
end)

Alma.netRegisterAndHandle('ewen:RespawnHopital', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    AppelsEMSList[source] = nil
    SetEntityCoords(GetPlayerPed(source), vector3(316.452, -583.742, 43.284))
    SetEntityHeading(GetPlayerPed(source), 341.667)
    AlmaServerUtils.toClient('EMS:ReviveClientPlayer', source)
    --PlayerIsDead[xPlayer.source].isDead = 0
    xPlayer.showNotification(' ~w~Vous avez été réanimer à l\'hôpital.')
end)

Alma.netRegisterAndHandle('ewen:RespawnVIP', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    AppelsEMSList[source] = nil
    SetEntityCoords(GetPlayerPed(source), vector3(316.452, -583.742, 43.284))
    SetEntityHeading(GetPlayerPed(source), 341.667)
    AlmaServerUtils.toClient('EMS:ReviveClientPlayer', source)
    --PlayerIsDead[xPlayer.source].isDead = 0
    xPlayer.showNotification(' ~w~Vous avez été réanimer à l\'hôpital. Merci de votre soutien !(~p~VIP~s~)')
end)

AddEventHandler('playerDropped', function (reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    if PlayerIsDead[xPlayer.source] then
        if PlayerIsDead[xPlayer.source].isDead == 1 then
            MySQL.Async.fetchAll('SELECT * FROM `alma_isdead` WHERE `license` = @license', {
                ['@license'] = xPlayer.identifier
            }, function(result)
                if result[1] then
                else
                    MySQL.Async.execute('INSERT INTO `alma_isdead` (license) VALUES (@license)', {
                        ['@license'] = xPlayer.identifier,
                    }, function()
                    end)
                end
            end)
        end
    else
        MySQL.Async.fetchAll('SELECT * FROM `alma_isdead` WHERE `license` = @license', {
            ['@license'] = xPlayer.identifier
        }, function(result)
            if result[1] then
                MySQL.Async.execute('DELETE FROM `alma_isdead` WHERE `license` = @license', {
                    ['@license'] = xPlayer.identifier
                })
            end
        end)
    end
    if AppelsEMSList[xPlayer.source] then
        if AppelsEMSList[xPlayer.source].status == 1 then 
            local EMSPlayer = ESX.GetPlayerFromId(AppelsEMSList[xPlayer.source].EMS_SRC)
            EMSPlayer.showNotification(' ~w~Le joueur à déconnecter, l\'appel à été annuler')
            AlmaServerUtils.toClient('EMS:ForceStopAppel', EMSPlayer.source)
            AppelsEMSList[xPlayer.source] = nil
            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local Players = ESX.GetPlayerFromId(xPlayers[i])
    
                if Players.job.name == 'ambulance' then
                    if IsInServiceEMS[Players.source].inService then
                        AlmaServerUtils.toClient('ewen:UpdateTableSignalEms', -1, AppelsEMSList)
                    end
                end
            end
        else
            AppelsEMSList[xPlayer.source] = nil
            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local Players = ESX.GetPlayerFromId(xPlayers[i])
    
                if Players.job.name == 'ambulance' then 
                    if IsInServiceEMS[Players.source].inService then
                        AlmaServerUtils.toClient('ewen:UpdateTableSignalEms', -1, AppelsEMSList)
                    end
                end
            end
        end
    end
end)

Alma.netRegisterAndHandle('EMS:Service', function(value)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == 'ambulance' then
        if value then
            if not IsInServiceEMS[xPlayer.source] then
                IsInServiceEMS[xPlayer.source] = {}
                IsInServiceEMS[xPlayer.source].inService = true
            else
                IsInServiceEMS[xPlayer.source].inService = true
            end
        else
            if not IsInServiceEMS[xPlayer.source] then
                IsInServiceEMS[xPlayer.source] = {}
                IsInServiceEMS[xPlayer.source].inService = false
            else
                IsInServiceEMS[xPlayer.source].inService = false
            end
        end
    end
end)


RegisterCommand('revive-radius', function(source,args)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= 'user' then 
        if args[1] and tonumber(args[1]) ~= nil then
            local coordsStaff = GetEntityCoords(GetPlayerPed(source))
            for k,v in pairs(GetPlayers()) do
                local coordsSpecial = #(coordsStaff - GetEntityCoords(GetPlayerPed(v)))
                if coordsSpecial <= tonumber(args[1]) then
                    AlmaServerUtils.toClient('EMS:ReviveClientPlayer', v)
                    xPlayer.showNotification("Vous avez revive tout les joueurs dans une zone de ~y~"..args[1].."~s~ mètres !")
                end
            end
        end
    end
end)

RegisterCommand('revive', function(source,args)
    local source = source;
    if source == 0 then 
        if args[1] then 
            local PlayerRevive = ESX.GetPlayerFromId(args[1])
            if PlayerRevive then 
                if AppelsEMSList[args[1]] then
                    if AppelsEMSList[args[1]].status == 1 then
                        local EMS_Players = ESX.GetPlayerFromId(AppelsEMSList[args[1]].EMS_SRC)

                        EMS_Players.showNotification('~w~Le joueurs qui avait fais l\'appel que vous avez pris à été réanimer par un Staff')
                        AppelsEMSList[args[1]] = nil
                        local xPlayers = ESX.GetPlayers()
                        for i=1, #xPlayers, 1 do
                            local Players = ESX.GetPlayerFromId(xPlayers[i])
                
                            if Players.job.name == 'ambulance' then 
                                if IsInServiceEMS[Players.source].inService then
                                    AlmaServerUtils.toClient('ewen:UpdateTableSignalEms', -1, AppelsEMSList)
                                end
                            end
                        end
                    else
                        AppelsEMSList[args[1]] = nil
                        local xPlayers = ESX.GetPlayers()
                        for i=1, #xPlayers, 1 do
                            local Players = ESX.GetPlayerFromId(xPlayers[i])
                
                            if Players.job.name == 'ambulance' then 
                                if IsInServiceEMS[Players.source].inService then
                                    AlmaServerUtils.toClient('ewen:UpdateTableSignalEms', -1, AppelsEMSList)
                                end
                            end
                        end
                    end
                end

                AlmaServerUtils.toClient('EMS:ReviveClientPlayer', args[1])
                if PlayerIsDead[args[1]] then
                    PlayerIsDead[args[1]] = nil
                end
                PlayerRevive.showNotification('~w~Vous avez été réanimer par un staff')
            end
        end
    else
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getGroup() ~= 'user' then 
            if args[1] then 
                local PlayerRevive = ESX.GetPlayerFromId(args[1])
                if PlayerRevive then 
                    if AppelsEMSList[args[1]] then
                        if AppelsEMSList[args[1]].status == 1 then
                            local EMS_Players = ESX.GetPlayerFromId(AppelsEMSList[args[1]].EMS_SRC)
    
                            EMS_Players.showNotification('~w~Le joueurs qui avait fais l\'appel que vous avez pris à été réanimer par un Staff')
                            AppelsEMSList[args[1]] = nil
                            local xPlayers = ESX.GetPlayers()
                            for i=1, #xPlayers, 1 do
                                local Players = ESX.GetPlayerFromId(xPlayers[i])
                    
                                if Players.job.name == 'ambulance' then 
                                    if IsInServiceEMS[Players.source].inService then
                                        AlmaServerUtils.toClient('ewen:UpdateTableSignalEms', -1, AppelsEMSList)
                                    end
                                end
                            end
                        else
                            AppelsEMSList[args[1]] = nil
                            local xPlayers = ESX.GetPlayers()
                            for i=1, #xPlayers, 1 do
                                local Players = ESX.GetPlayerFromId(xPlayers[i])
                    
                                if Players.job.name == 'ambulance' then 
                                    if IsInServiceEMS[Players.source].inService then
                                        AlmaServerUtils.toClient('ewen:UpdateTableSignalEms', -1, AppelsEMSList)
                                    end
                                end
                            end
                        end
                    end
    
                    AlmaServerUtils.toClient('EMS:ReviveClientPlayer', args[1])
                    if PlayerIsDead[args[1]] then
                        PlayerIsDead[args[1]] = nil
                    end
                    PlayerRevive.showNotification('~w~Vous avez été réanimer par un staff')
                else
                    xPlayer.showNotification(' ~w~Aucun Joueur est connecter avec cette ID')
                end
            else
                if AppelsEMSList[xPlayer.source] then
                    if AppelsEMSList[xPlayer.source].status == 1 then
                        local EMS_Players = ESX.GetPlayerFromId(AppelsEMSList[xPlayer.source].EMS_SRC)

                        EMS_Players.showNotification('~w~Le joueurs qui avait fais l\'appel que vous avez pris à été réanimer par un Staff')
                        AppelsEMSList[xPlayer.source] = nil
                        local xPlayers = ESX.GetPlayers()
                        for i=1, #xPlayers, 1 do
                            local Players = ESX.GetPlayerFromId(xPlayers[i])
                
                            if Players.job.name == 'ambulance' then 
                                if IsInServiceEMS[Players.source].inService then
                                    AlmaServerUtils.toClient('ewen:UpdateTableSignalEms', -1, AppelsEMSList)
                                end
                            end
                        end
                    else
                        AppelsEMSList[xPlayer.source] = nil
                        local xPlayers = ESX.GetPlayers()
                        for i=1, #xPlayers, 1 do
                            local Players = ESX.GetPlayerFromId(xPlayers[i])
                
                            if Players.job.name == 'ambulance' then 
                                if IsInServiceEMS[Players.source].inService then
                                    AlmaServerUtils.toClient('ewen:UpdateTableSignalEms', -1, AppelsEMSList)
                                end
                            end
                        end
                    end
                end

                AlmaServerUtils.toClient('EMS:ReviveClientPlayer', xPlayer.source)
                if PlayerIsDead[xPlayer.source] then
                    PlayerIsDead[xPlayer.source] = nil
                end
                xPlayer.showNotification('~w~Vous vous êtes réanimer')
            end
        end
    end
end)