local LuckyWheelTable = {
    ["currentvehicle"] = nil,
    ["vehicle"] = {
        [1] = "adder",
        [2] = "locust",
        [3] = "lynx",
        [4] = "t20",
        [5] = "reaper",
        [6] = "rapidgt",
        [7] = "neon"
    },
    ["gain"] = {
        [1] = "bank",
        [2] = "vehicle",
        [3] = nil,
        [4] = nil,
        [5] = nil,
        [6] = "bank",
        [7] = nil,
        [7] = nil,
        [8] = "bank",
        [9] = nil,
        [10] = nil
    }
}

local characters = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" }

function GetRandomString()
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

Citizen.CreateThread(function()
    Wait(100)
    LuckyWheelTable["currentvehicle"] = LuckyWheelTable["vehicle"][1]
    Wait(100)
    print("[^1Authentic-LuckyWheel^7] Véhicule du jour : ^1"..LuckyWheelTable["currentvehicle"].."^7 !")
end)

AddEventHandler("esx:playerLoaded", function(source, xPlayer)
    while LuckyWheelTable["currentvehicle"] == nil do
        Citizen.Wait(1)
    end
    Alma:TriggerClientEvent("Luckywheel", "man_veh", source, LuckyWheelTable["currentvehicle"])
    MySQL.Async.fetchAll("SELECT time FROM alma_luckywheel WHERE identifier = @a", { ["@a"] = xPlayer.identifier }, function(result)
        if result[1] then
            if result[1].time <= os.time() then
                Alma:TriggerClientEvent("Luckywheel", "man_day", source, true)
            else
                Alma:TriggerClientEvent("Luckywheel", "man_day", source, false)
                Alma:TriggerClientEvent("Luckywheel", "man_time", source, os.date("%H:%M:%S", result[1].time))
            end
        else
            Alma:TriggerClientEvent("Luckywheel", "man_day", source, true)
        end
    end)
end)

local function ResetTimer(xPlayer, boob)
    if boob then
        MySQL.Async.fetchAll("SELECT time FROM alma_luckywheel WHERE identifier = '"..xPlayer.identifier.."'", {}, function(rs)
            if rs[1] then
                MySQL.Async.execute("UPDATE alma_luckywheel SET time = "..os.time() + 86400 .." WHERE identifier = '"..xPlayer.identifier.."'", {})
            else
                local time = os.time() + 86400
                MySQL.Async.execute("INSERT INTO alma_luckywheel (identifier, time) VALUES ('"..xPlayer.identifier.."', "..time..")", {})
            end
        end)
    else
        local time = os.time() - 1000
        MySQL.Async.execute("UPDATE alma_luckywheel SET time = "..time.." WHERE identifier = '"..xPlayer.identifier.."'", {})
    end
end

Alma:AddEventHandler("Luckywheel", "onPlayerInit", function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT time FROM alma_luckywheel WHERE identifier = @a", { ["@a"] = xPlayer.identifier }, function(result)
        if result[1] then
            if result[1].time <= os.time() then
                Alma:TriggerClientEvent("Luckywheel", "man_day", source, true)
            else
                Alma:TriggerClientEvent("Luckywheel", "man_day", source, false)
                Alma:TriggerClientEvent("Luckywheel", "man_time", source, os.date("%H:%M:%S", result[1].time))
            end
        else
            Alma:TriggerClientEvent("Luckywheel", "man_day", source, true)
        end
    end)
end)

Alma:AddEventHandler("Luckywheel", "PayTicket", function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 75000

    if xPlayer.getAccount('bank').money >= price then
        Alma:TriggerClientEvent("Luckywheel", "man_roll", source, false)
        Alma:TriggerClientEvent("Luckywheel", "man_day", source, true)
        ResetTimer(xPlayer, false)
        xPlayer.showNotification("Vous venez de recevoir un ticket de roue pour ~h~~g~75 000.0 $~s~")
    else
        xPlayer.showNotification("Tu n'as pas asser d'argent pour payer un ticket payant, il te manque ~h~~r~"..ESX.Math.GroupDigits(price-xPlayer.getAccount('bank').money)..".0 $~s~")
    end
end)

Alma:AddEventHandler("Luckywheel", "RequestTicket", function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT time FROM alma_luckywheel WHERE identifier = '"..xPlayer.identifier.."'", {}, function(result)
        if result[1] then
            if result[1].time <= os.time() then
                Alma:TriggerClientEvent("Luckywheel", "man_roll", source, true)
                Alma:TriggerClientEvent("Luckywheel", "man_day", source, false)
                local time = os.time() + 86400
                Alma:TriggerClientEvent("Luckywheel", "man_time", source, os.date("%H:%M:%S", time))
                Helper:showAdvancedNotification(source, "Roue de la fortune", "~b~Information", "Vous avez recus votre ticket, bonne chance !", "CHAR_CASINO", 1)
            else
                Alma:TriggerClientEvent("Luckywheel", "man_day", source, false)
                Alma:TriggerClientEvent("Luckywheel", "man_time", source, os.date("%H:%M:%S", result[1].time))
            end
        else
            local time = os.time() - 1000
            MySQL.Async.execute("INSERT INTO alma_luckywheel (identifier, time) VALUES('"..xPlayer.identifier.."', "..time..")")
            Alma:TriggerClientEvent("Luckywheel", "man_day", source, true)
        end
    end)
end)

Alma:AddEventHandler("Luckywheel", "RequestPrice", function()
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);
    local random = math.random(0, #LuckyWheelTable["gain"])
        MySQL.Async.fetchAll("SELECT time FROM alma_luckywheel WHERE identifier = '"..xPlayer.identifier.."'", {}, function(result)
        if result[1] then
            if result[1].time <= os.time() then
                if LuckyWheelTable["gain"][random] == nil then
                    Helper:showAdvancedNotification(source, "Roue de la fortune", "~b~Récompense", "~r~Désolé~s~, mais vous n'avez rien gagné aujourd'hui !", "CHAR_CASINO", 1)
                    Alma:TriggerClientEvent("Luckywheel", "man_roll", source, false)
                    Alma:TriggerClientEvent("Luckywheel", "man_day", source, false)
                    ResetTimer(xPlayer, true)
                elseif LuckyWheelTable["gain"][random] == "bank" then
                    local random_price_bank = math.random(0, math.random(1000, 35470))
                    xPlayer.addAccountMoney('bank', random_price_bank)
                    Helper:showAdvancedNotification(source, "Roue de la fortune", "~b~Récompense", "~g~Félicitation~s~, vous avez gagné ~g~"..ESX.Math.GroupDigits(random_price_bank).." $~s~, disponible sur votre compte en banque !", "CHAR_CASINO", 1)
                    Alma:TriggerClientEvent("Luckywheel", "man_roll", source, false)
                    Alma:TriggerClientEvent("Luckywheel", "man_day", source, false)
                    ResetTimer(xPlayer, true)
                elseif LuckyWheelTable["gain"][random] == "vehicle" then
                    local veh = {model = GetHashKey(LuckyWheelTable["currentvehicle"]), plate = GetRandomString()}
                    MySQL.Async.execute("INSERT INTO owned_vehicles (owner, plate, vehicle, type, state, label) VALUES('"..xPlayer.identifier.."', '"..veh.plate.."', '"..json.encode(veh).."', 'car', 1, 'Véhicule de la Roue')", {})
                    Helper:showAdvancedNotification(source, "Roue de la fortune", "~b~Récompense", "~g~Félicitation~s~, vous avez gagné ~g~la voiture du jour~s~, disponible dans votre garage !", "CHAR_CASINO", 1)
                    Alma:TriggerClientEvent("Luckywheel", "man_roll", source, false)
                    Alma:TriggerClientEvent("Luckywheel", "man_day", source, false)
                    ResetTimer(xPlayer, true)
                end
            else
                xPlayer.showNotification("Vous devez attendre !")
            end
        end
    end)
end)