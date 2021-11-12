---@author Pablo Z.
---@version 1.0
--[[
  This file is part of Astra RolePlay.
  
  File [main] created at [21/04/2021 21:01]

  Copyright (c) Astra RolePlay - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local availableRewards = {
    "t20",
    "adder"
}

local vendorNpc, vendorZone
local currentVehicle = availableRewards[math.random(1, #availableRewards)]

local currentlyAwaitingTurnPlayers = {}
local timedPlayers = {}

local paidTurns = {}

function CFXID(source)
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

Astra.netHandle("addPaidTurn", function(license)
    if not paidTurns[license] then
        paidTurns[license] = 0
        MySQL.Async.insert("INSERT INTO alma_paid_wheel (license) VALUES(@a)", {
            ['a'] = license
        })
    else
        paidTurns[license] = paidTurns[license] + 1
        MySQL.Async.execute("UPDATE alma_paid_wheel SET ammount = ammount + 1 WHERE license = @a", {
            ['a'] = license
        })
    end
end)

Astra.netHandle("removePaidTurn", function(license)
    if not paidTurns[license] then
        return
    end
    local final = (paidTurns[license] - 1)
    if final <= 0 then
        paidTurns[license] = nil
        MySQL.Async.execute("DELETE FROM alma_paid_wheel WHERE license = @a", {
            ['a'] = license
        })
    else
        paidTurns[license] = final
        MySQL.Async.execute("UPDATE alma_paid_wheel SET ammount = ammount - 1 WHERE license = @a", {
            ['a'] = license
        })
    end
end)

local function countPaidTurns(license)
    return paidTurns[license] or 0
end

local function recomp(str, source, color)
    AstraServerUtils.webhook(("Le joueur %s a gagné: %s"):format(GetPlayerName(source), str), color, "https://discord.com/api/webhooks/888915243294666812/rUfFqGuKXW_LvKjXyn18vgOcuYZ8xVev2j0d7hkhbvFPRSW8S8bFFXQWnDuGI70PiHh7")
end

AstraServerUtils.registerConsoleCommand("luckywheelSetCar", function(source, args)
    currentVehicle = args[1]
    AstraServerUtils.trace("Véhicule de la roue changée !", AstraPrefixes.succes)
    AstraServerUtils.toAll("luckywheelVehicleChange", args[1])
end)

AstraSPlayersManager.registerEventOverrider(PLAYER_EVENT_TYPE.LEAVING, function(source)
    currentlyAwaitingTurnPlayers[source] = nil
end)

local char = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" }

AstraServerUtils.GeneratePlate = function()
    local plate = ""
    math.randomseed(GetGameTimer())
    for i = 1, 4 do
        plate = plate .. char[math.random(1, #char)]
    end
    plate = plate .. ""
    for i = 1, 3 do
        plate = plate .. math.random(1, 9)
    end
    return plate
end

Astra.netRegisterAndHandle("luckywheelPaidTurn", function()
    local source = source
    local price = 1500
    local license = AstraServerUtils.getLicense(source)
    local identifier = CFXID(source);
    if (identifier['fivem']) then
        local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
        MySQL.Async.fetchAll("SELECT SUM(points) FROM alma_wallet WHERE identifiers = @identifiers", {
            ['@identifiers'] = after
        }, function(result)
            local current = tonumber(result[1]["SUM(points)"]);
            if (current ~= nil) then
                if (current >= price) then
                    MySQL.Async.execute('INSERT INTO alma_wallet (identifiers, transaction, price, currency, points) VALUES (@identifiers, @transaction, @price, @currency, @points)', {
                        ["@identifiers"] = after,
                        ["@transaction"] = "Achat d'un tour de roue de la fortune",
                        ["@price"] = '0',
                        ["@currency"] = 'Points',
                        ["@points"] = -1500,
                    }, function(result)
                        Astra.toInternal("addPaidTurn", license)
                        AstraServerUtils.toClient("luckywheelPaidCbTurn", source)
                    end);
                else
                    AstraServerUtils.toClient("advancedNotif", source, "Roue de la fortune", "~b~Achat", "Vous ne procédez pas les points nécessaires pour un tour de roue de la fortune.", "CHAR_CASINO", 1)
                    AstraServerUtils.toClient("luckywheelPaidNotCbTurn", source)
                end
            else
                AstraServerUtils.toClient("advancedNotif", source, "Roue de la fortune", "~b~Achat",  "~r~Dommage~s~, Vous n'avez pas lié votre compte (~g~forum.cfx.re~s~) à fivem !", "CHAR_CASINO", 1)
                AstraServerUtils.toClient("luckywheelPaidNotCbTurn", source)
            end
        end);
    else
        AstraServerUtils.toClient("advancedNotif", source, "Roue de la fortune", "~b~Achat",  "~r~Dommage~s~, Vous n'avez pas lié votre compte (~g~forum.cfx.re~s~) à fivem !", "CHAR_CASINO", 1)
        AstraServerUtils.toClient("luckywheelPaidNotCbTurn", source)
    end
end)

Astra.netRegisterAndHandle("luckywheelRequestFinalPrice", function(vehicleProps)
    print("Received event")
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    ---@type Player
    local astraPlayer = AstraSPlayersManager.getPlayer(source)
    if currentlyAwaitingTurnPlayers[source] == nil then
        return
    end
    if currentlyAwaitingTurnPlayers[source] == "free" then
        currentlyAwaitingTurnPlayers[source] = nil
        local ran = math.random(1, 30)
        if ran == 5 then
            MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, surname, state) VALUES (@owner, @plate, @vehicle, @type, @surname, 1)', {
                ['@owner'] = xPlayer.identifier,
                ['@plate'] = vehicleProps.plate,
                ['@vehicle'] = json.encode(vehicleProps),
                ['@type'] = "car",
                ['@surname'] = "Véhicule de la Roue"
            })
            MySQL.Async.execute("INSERT INTO open_car (owner, plate) VALUES (@owner, @plate)", {
                ["@owner"] = xPlayer.identifier,
                ["@plate"] = vehicleProps.plate
            })
            AstraServerUtils.toClient("advancedNotif", source, "Roue de la fortune", "~b~Récompense", "~g~Félicitations ~s~! Vous avez gagné la ~r~voiture ~s~!", "CHAR_CASINO", 1)
            recomp("car", source, "red")
            return
        end
        if ran <= 10 then
            local expRandom = math.random(900, 1900)
            astraPlayer:setAddonCache("exp", (astraPlayer:getAddonCache("exp") + expRandom), true)
            AstraServerUtils.toClient("advancedNotif", source, "Roue de la fortune", "~b~Récompense", ("~g~Félicitations ~s~! Vous avez gagné ~b~%s EXP ~s~AlmaRP !"):format(expRandom), "CHAR_CASINO", 1)
            recomp(("%s exp"):format(expRandom), source, "orange")
            return
        end
        if ran <= 20 then
            local moneyRandom = math.random(5000, 13500)
            xPlayer.addAccountMoney(money, moneyRandom)
            AstraServerUtils.toClient("advancedNotif", source, "Roue de la fortune", "~b~Récompense", ("~g~Félicitations ~s~! Vous avez gagné ~g~%s$ ~s~!"):format(moneyRandom), "CHAR_CASINO", 1)
            recomp(("%s$"):format(moneyRandom), source, "green")
            return
        end
        AstraServerUtils.toClient("advancedNotif", source, "Roue de la fortune", "~b~Récompense", "~r~Dommage ~s~! Vous n'avez rien gagné... Revenez une prochaine fois !", "CHAR_CASINO", 1)
        recomp("rien", source, "grey")
        return
    elseif currentlyAwaitingTurnPlayers[source] == "paid" then
        currentlyAwaitingTurnPlayers[source] = nil
        local ran, plate = math.random(1, 30), AstraServerUtils.GeneratePlate()
        if ran == 5 then
            -- INSERT INTO alma_wallet (identifiers, transaction, price, currency, points) VALUES ('{id}', '{transaction}', '{packagePrice}', '{currency}', '1500')
            local identifier = AstraServerUtils.getIdentifiers(source);
            if (identifier['fivem']) then
                local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
                MySQL.Async.execute("INSERT INTO alma_wallet (identifiers, transaction, price, currency, points) VALUES (@a, 'LuckyWheel - Gagnant', '0', 'EUR', '2000')", {
                    ['a'] = after
                })
            end
            AstraServerUtils.toClient("advancedNotif", source, "Roue de la fortune", "~b~Récompense", "~g~Félicitations ~s~! Vous avez gagné la ~r~2000 Pultions~s~!", "CHAR_CASINO", 1)
            return
        end
        if ran <= 10 then
            MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, surname, state) VALUES (@owner, @plate, @vehicle, @type, @surname, 1)', {
                ['@owner'] = xPlayer.identifier,
                ['@plate'] = vehicleProps.plate,
                ['@vehicle'] = "{\"model\":"..Astra.hash("RS6abtp")..",\"plate\":\""..vehicleProps.plate.."\"}",
                ['@type'] = "car",
                ["@surname"] = "Véhicule de la Roue"
            })
            MySQL.Async.execute("INSERT INTO open_car (owner, plate) VALUES (@owner, @plate)", {
                ["@owner"] = xPlayer.identifier,
                ["@plate"] = vehicleProps.plate
            })
            AstraServerUtils.toClient("advancedNotif", source, "Roue de la fortune", "~b~Récompense", "~g~Félicitations ~s~! Vous avez gagné la ~r~RS6 ABT (boutique) ~s~!", "CHAR_CASINO", 1)
            return
        end
        if ran <= 20 then
            local moneyRandom = math.random(2300000,2900000)
            xPlayer.addAccountMoney(money, moneyRandom)
            AstraServerUtils.toClient("advancedNotif", source, "Roue de la fortune", "~b~Récompense", ("~g~Félicitations ~s~! Vous avez gagné ~g~%s$ ~s~!"):format(moneyRandom), "CHAR_CASINO", 1)
            return
        end
        AstraServerUtils.toClient("advancedNotif", source, "Roue de la fortune", "~b~Récompense", "~r~Dommage ~s~! Vous n'avez rien gagné... Revenez une prochaine fois !", "CHAR_CASINO", 1)
        recomp("rien", source, "grey")
        return
    end
    -- @TODO -> Faire une variante pour les payantes
end)

Astra.netRegisterAndHandle("luckywheelRequestFreeTurn", function()
    local source = source
    local license = AstraServerUtils.getLicense(source)
    local time = os.time()
    local cd = time + ((60 * 60) * 24)
    if timedPlayers[license] ~= nil then
        return
    end
    MySQL.Async.fetchAll("INSERT INTO alma_daywheel (license,time) VALUES(@a,@b)", { ['a'] = license, ['b'] = cd })
    currentlyAwaitingTurnPlayers[source] = "free"
    timedPlayers[license] = cd
    AstraServerUtils.toClient("luckywheelCbTurn", source)
end)

Astra.netRegisterAndHandle("luckywheelRequestPaidTurn", function()
    local source = source
    local license = AstraServerUtils.getLicense(source)
    if countPaidTurns(license) <= 0 then
        return
    end
    Astra.toInternal("removePaidTurn", license)
    currentlyAwaitingTurnPlayers[source] = "paid"
    AstraServerUtils.toClient("luckywheelCbTurn", source)
end)

Astra.netRegisterAndHandle("luckywheelRequestCurrentVehicle", function()
    local source = source
    AstraServerUtils.toClient("luckywheelCbCurrentVehicle", source, currentVehicle)
end)

Astra.netHandle("esxloaded", function()
    MySQL.Async.fetchAll("SELECT * FROM alma_paid_wheel", {}, function(result)
        for k,v in pairs(result) do
            paidTurns[v.license] = v.ammount
        end
    end)
    vendorNpc = AstraSNpcsManager.createPublic("a_m_y_soucent_02", false, true, { coords = vector3(225.95338439941, -885.87414550781, 30.492099761963), heading = 331.41 }, "WORLD_HUMAN_AA_SMOKE", nil)
    vendorNpc:setInvincible(true)
    vendorNpc:setFloatingText("Pour tourner la roue de la fortune de ~HUD_COLOUR_DEGEN_RED~AlmaRP~s~, c'est par là mon ami !", 8.5)

    vendorZone = AstraSZonesManager.createPublic(vector3(226.65336608887,-883.89117431641,30.492116928101), 32, { r = 50, g = 0, b = 255, a = 255 }, function(source)
        vendorNpc:playSpeechForPlayer("GENERIC_HI", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR", source)
        local license = AstraServerUtils.getLicense(source)
        if timedPlayers[license] ~= nil then
            local time = os.time()
            if timedPlayers[license] <= time then
                timedPlayers[license] = nil
                MySQL.Async.execute("DELETE FROM alma_daywheel WHERE license = @a", { ['a'] = license })
                AstraServerUtils.toClient("luckywheelOpenMenu", source, true, countPaidTurns(license))
            else
                AstraServerUtils.toClient("luckywheelOpenMenu", source, false, countPaidTurns(license))
            end
        else
            AstraServerUtils.toClient("luckywheelOpenMenu", source, true, countPaidTurns(license))
        end
    end, "Appuyez sur ~INPUT_CONTEXT~ pour parler au vendeur de tickets", 60.0, 1.0)

    AstraSBlipsManager.createPublic(vector3(220.05, -869.4, 30.49), 266, 27, 0.85, "Roue de la chance", true)

    local time = os.time()
    MySQL.Async.fetchAll("SELECT * FROM alma_daywheel", {}, function(result)
        for k, v in pairs(result) do
            if v.time <= time then
                MySQL.Async.execute("DELETE FROM alma_daywheel WHERE license = @a", { ['a'] = v.license })
            else
                timedPlayers[v.license] = v.time
            end
        end
    end)
end)