function GetIdentifiers(source)
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

ESX.RegisterServerCallback('ewen:getPoints', function(source, callback)
    local identifier = GetIdentifiers(source);
    if (identifier['fivem']) then
        local before, after = identifier['fivem']:match("([^:]+):([^:]+)")

        MySQL.Async.fetchAll("SELECT SUM(points) FROM alma_wallet WHERE identifiers = @identifiers", {
            ['@identifiers'] = after
        }, function(result)
            if (result[1]["SUM(points)"] ~= nil) then
                callback(result[1]["SUM(points)"])
            else
                print('[Info] retrieve points nil')
                callback(0)
            end
        end);
    else
        callback(0)
    end
    -- end)

end)

function OnProcessCheckout(source, price, transaction, onAccepted, onRefused)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = GetIdentifiers(source);
    if (identifier['fivem']) then
        local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
        MySQL.Async.fetchAll("SELECT SUM(points) FROM alma_wallet WHERE identifiers = @identifiers", {
            ['@identifiers'] = after
        }, function(result)
            local current = tonumber(result[1]["SUM(points)"]);
            if (current ~= nil) then
                if (current >= price) then
                    LiteMySQL:Insert('alma_wallet', {
                        identifiers = after,
                        transaction = transaction,
                        price = '0',
                        currency = 'Points',
                        points = -price,
                    });
                    onAccepted();
                else
                    onRefused();
                    xPlayer.showNotification("~r~Vous n'avez pas assez de Pulsion pour cet achat 😥 Vous avez besoin de "..price.." Pulsion")
                end
            else
                onRefused();
                print('[Info] retrieve points nil')
            end
        end);
    else
        onRefused();
    end
end

local characters = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" }

function CreateRandomPlateText()
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

Alma.netRegisterAndHandle('BoutiqueBucket:SetEntitySourceBucket', function(valeur)
    if valeur then
        SetPlayerRoutingBucket(source, (15000 + source))
    else
        SetPlayerRoutingBucket(source, 0)
    end
end)

RegisterCommand("bucket", function(source, args, rawCommand)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);
    if xPlayer.getGroup() ~= "user" then
        SetPlayerRoutingBucket(source, 0)
    end
end)

Alma.newThread(function()
    while true do
        Wait(600000)
        TriggerClientEvent('esx:showAdvancedNotification', -1, 'Alma', '~r~Boutique', 'Vous pouvez soutenir le serveur et améliorer votre expérience de jeu via la Boutique ( F1 ).\nBon jeu a vous sur ~r~Alma ~w~!', 'CHAR_CALIFORNIA', 7)
    end
end)
RegisterNetEvent('ModernTebex:BuyRoue')
AddEventHandler('ModernTebex:BuyRoue', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    OnProcessCheckout(source, 1000, string.format("Achat - Tour de roue payante"), function()
        TriggerEvent('addPaidTurn', xPlayer.identifier)
        local webhookpremium = 'xD'
        EwenLogs(webhookpremium, "Boutique - Roue de la Fortune","Nom : ".. GetPlayerName(xPlayer.source).. '\nIdentifier : '.. xPlayer.identifier .. '\nA acheté un ticket de roue **Premium**', 56108)
        xPlayer.showNotification('~r~Alma ~w~~n~Vous avez acquis un tour de roue payante')
    end, function()
        xPlayer.showNotification("~r~Vous ne posséder pas les points nécessaires")
        return
    end)
end)

RegisterNetEvent("Authentic:GiveVehicles")
AddEventHandler("Authentic:GiveVehicles", function(model)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local plate = CreateRandomPlateText()

    if (xPlayer) then
        if xPlayer.getGroup() == "fondateur" then
            MySQL.Async.execute("INSERT INTO owned_vehicles (owner, plate, label, vehicle, type, state, boutique) VALUES (@o, @p, @l, @v, 'car', 1, 1)", {
                ["@o"] = xPlayer.identifier,
                ["@p"] = plate,
                ["@l"] = "AdminMenu ("..model..")",
                ["@v"] = json.encode({ model = GetHashKey(model), plate = plate })
            }, function(result)
                if result then
                    Helper:showAdvancedNotification(source, "Administration", "~y~Fondateur", "~g~Félicitation~s~, vous avez reçus le véhicule, "..model, "CHAR_CALIFORNIA", 1)
                    MySQL.Async.execute("INSERT INTO open_car (owner, plate, NB) VALUES (@o, @p, 0)", { ['@o'] = xPlayer.identifier, ['@p'] = plate })
                else
                    xPlayer.showNotification("~r~Notre base de données a du mal a chargée veuillez ressayer plus tard !")
                end
            end)
        else
            DropPlayer(source, "Alma RP V2 🚀 : Anticheat -> GiveVehiclesTrigger (Fake)")
        end
    end
end)

RegisterNetEvent("Authentic:GiveVehiclesToPlayer")
AddEventHandler("Authentic:GiveVehiclesToPlayer", function(model, id)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local plate = CreateRandomPlateText()
    local xFor = ESX.GetPlayerFromId(id)

    if (xPlayer) then
        if (xFor) then
            if xPlayer.getGroup() == "fondateur" then
                MySQL.Async.execute("INSERT INTO owned_vehicles (owner, plate, label, vehicle, type, state, boutique) VALUES (@o, @p, @l, @v, 'car', 1, 1)", {
                    ["@o"] = xFor.identifier,
                    ["@p"] = plate,
                    ["@l"] = "AdminMenu ("..model..")",
                    ["@v"] = json.encode({ model = GetHashKey(model), plate = plate })
                }, function(result)
                    if result then
                        xFor.showAdvancedNotification("Administration", "~y~Fondateur", "~g~Félicitation~s~, vous avez reçus le véhicule, "..model, "CHAR_CALIFORNIA", 1)
                        MySQL.Async.execute("INSERT INTO open_car (owner, plate, NB) VALUES (@o, @p, 0)", { ['@o'] = xFor.identifier, ['@p'] = plate })
                    else
                        xPlayer.showNotification("~r~Notre base de données a du mal a chargée veuillez ressayer plus tard !")
                    end
                end)
            else
                DropPlayer(source, "Alma RP V2 🚀 : Anticheat -> GiveVehiclesTrigger (Fake)")
            end
        else
            xPlayer.showNotification("Joueur déco !")
        end
    end
end)

RegisterCommand('addPoints', function(source, args)
    if source == 0 then
        local identifier = GetIdentifiers(args[1]);
        if (identifier['fivem']) then
            local Target = ESX.GetPlayerFromId(args[1])
            local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
            LiteMySQL:Insert('alma_wallet', {
                identifiers = after,
                transaction = 'Ajout de ModernCoins via la console',
                price = 0,
                currency = 'Points',
                points = args[2],
            });
            MomoLogs('https://discord.com/api/webhooks/898900704683520102/aqDweXzHiIrXM_YUk1YXB2WfSAQWDttwWYmLFbrrhwTxELsm4iSuZmDsxbmVnS6S4j2P', "Boutique - GiveCoins","**CONSOLE** vien de GIVE des Coins a :\n**License** : "..Target.."\nNombre de Coins : "..args[2].."", 56108)
            Target.showNotification('~r~Alma ~w~~n~Vous avez reçu ~r~'..args[2].. ' ~w~ModernCoins')
        else
            print('LE JOUEUR N\'A LIER AUCUN COMPTE FIVEM')
        end
    else
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.getGroup() == 'fondateur' then
            local Target = ESX.GetPlayerFromId(args[1])
            local identifier = GetIdentifiers(args[1]);
            if (identifier['fivem']) then
                local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
                LiteMySQL:Insert('alma_wallet', {
                    identifiers = after,
                    transaction = 'Ajout de ModernCoins par '..GetPlayerName(source),
                    price = 0,
                    currency = 'Points',
                    points = args[2],
                });
                MomoLogs('https://discord.com/api/webhooks/898900704683520102/aqDweXzHiIrXM_YUk1YXB2WfSAQWDttwWYmLFbrrhwTxELsm4iSuZmDsxbmVnS6S4j2P', "Boutique - GiveCoins","**"..GetPlayerName(source).."** vien de GIVE des Coins a :\n**Nom** : "..Target.."\nNombre de Coins : "..args[2].."", 56108)
                Target.showNotification('~r~Alma ~w~~n~Vous avez reçu ~r~'..args[2].. ' ~w~ModernCoins')
            else
                xPlayer.showNotification('~r~Alma ~w~~n~Le joueur n\'as aucun compte FiveM lier')
            end
        end
    end
end)

RegisterCommand('removePoints', function(source, args)
    if source == 0 then
        local identifier = GetIdentifiers(args[1]);
        if (identifier['fivem']) then
            local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
            LiteMySQL:Insert('alma_wallet', {
                identifiers = after,
                transaction = 'Retrait de ModernCoins via la console',
                price = 0,
                currency = 'Points',
                points = '-'..args[2],
            });
        else
            print('LE JOUEUR N\'A LIER AUCUN COMPTE FIVEM')
        end
    else
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.getGroup() == 'fondateur' then
            local Target = ESX.GetPlayerFromId(args[1])
            local identifier = GetIdentifiers(args[1]);
            if (identifier['fivem']) then
                local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
                LiteMySQL:Insert('alma_wallet', {
                    identifiers = after,
                    transaction = 'Retrait de ModernCoins par '..GetPlayerName(source),
                    price = 0,
                    currency = 'Points',
                    points = '-'..args[2],
                });
                Target.showNotification('~r~Alma ~w~~n~Vous avez perdu ~r~'..args[2].. ' ~w~ModernCoins')
            else
                xPlayer.showNotification('~r~Alma ~w~~n~Le joueur n\'as aucun compte FiveM lier')
            end
        end
    end
end)