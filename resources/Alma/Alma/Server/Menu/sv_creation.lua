RegisterNetEvent("alma:identitecrea")
AddEventHandler("alma:identitecrea", function (prenomlabel, nomlabel, datelabel, taillelabel, sexelabel)
    local source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    local token = GetPlayerToken(source, 0)
    SetPlayerRoutingBucket(source, 0)
    MySQL.Async.fetchAll("UPDATE users SET firstname = @firstname, lastname = @lastname, dateofbirth = @dateofbirth, height = @height, sex = @sex WHERE identifier = @identifier", {
        ["@firstname"] = tostring(prenomlabel),
        ["@lastname"] = tostring(nomlabel),
        ["@dateofbirth"] = tostring(datelabel),
        ["@height"] = tostring(taillelabel),
        ["@sex"] = tostring(sexelabel),
        ["@identifier"] = xPlayer.identifier
        
    }, function (after)
        -- LogsRonflex(12745742, "Realistic Logs Identity", "Le joueur **"..xPlayer.getName()..'('..source..")** a  créer son identité : \nPrénom: **"..prenomlabel.."**\nNom: **"..nomlabel.."**\nTaille: **"..taillelabel.."**\nLicense : ||**"..xPlayer.identifier.."**||\nToken : **||"..token.."||**", config.identity)
        TriggerClientEvent('esx:showAdvancedNotification', source, 'Alma Information', 'Création Identité', 'Votre identité est: \nPrénom: '..prenomlabel.."\nNom: "..nomlabel.."\nTaille: "..taillelabel.."", "CHAR_CALIFORNIA", 8)
    end)
end)

RegisterNetEvent("PlayerRoutineBucket")
AddEventHandler("PlayerRoutineBucket", function()
    SetPlayerRoutingBucket(source, (source + 15000))
end)

local characters = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" }

function PlateText()
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

local AlreadyStarter = {}

StarterPack = {
    { name = "Illégal", desc = "Devenez un vrai gangster, en prenant ce pack vous recevrez :\n\n+ 1 ~o~Enduro~s~\n+ 1 ~p~Batte~s~\n+ 25,000$ ~r~Argent Sale~s~\n+ 5,000$ ~g~Liquide~s~\n+ 200 ~b~Exp", value = "illegal"},
    { name = "Légal", desc = "Trouver un vrai métier grâce a ce pack vous recevrez :\n\n+ 1 ~o~Panto~s~\n+ 25,000$ ~g~Liquide~s~\n+ 5,000$ ~y~Banque~s~\n+ 100 ~b~Exp", value = "legal"},
    { name = "Business", desc = "Devenez un vrai business man grâce a ce pack vous recevrez :\n\n+ 1 ~o~BF-400~s~\n+ 30,000$ ~g~Banque~s~\n+ 400 ~b~Exp", value = "business"}
}

function AddStarter(value, xPlayer)
    if value == "legal" then
        local plateText = PlateText()
        MySQL.Async.execute("INSERT INTO owned_vehicles (owner, plate, label, vehicle, type, state, boutique, selling) VALUES(@owner, @plate, 'Starter Legal', @vehicle, 'car', 1, 0, 0)", {
            ["@owner"] = xPlayer.identifier,
            ["@plate"] = plateText,
            ["@vehicle"] = json.encode({ model = GetHashKey('panto'), plate = plateText })
        })
        MySQL.Async.execute("INSERT INTO open_car (owner, plate) VALUES(@owner, @plate)", {
            ["@owner"] = xPlayer.identifier,
            ["@plate"] = plateText,
        })
        MySQL.Async.execute("UPDATE users SET starter = 'legal' WHERE identifier = @owner", {
            ["@owner"] = xPlayer.identifier,
        })
        xPlayer.addAccountMoney('bank', 5000)
        xPlayer.addAccountMoney('money', 25000)
        ExecuteCommand("giveExp "..xPlayer.source.." 100")
        Helper:showAdvancedNotification(xPlayer.source, "Andreas", xPlayer.name, "Vous avez ~g~reçus~s~ votre Starter Pack Légal:\n\n+ 1 ~o~Panto~s~\n+ 25,000$ ~g~Liquide~s~\n+ 5,000$ ~y~Banque~s~\n+ 100 ~b~Exp", "CHAR_ANDREAS")
    elseif value == "illegal" then
        local plateText = PlateText()
        MySQL.Async.execute("INSERT INTO owned_vehicles (owner, plate, label, vehicle, type, state, boutique, selling) VALUES(@owner, @plate, 'Starter Illegal', @vehicle, 'car', 1, 0, 0)", {
            ["@owner"] = xPlayer.identifier,
            ["@plate"] = plateText,
            ["@vehicle"] = json.encode({ model = GetHashKey('enduro'), plate = plateText })
        })
        MySQL.Async.execute("INSERT INTO open_car (owner, plate) VALUES(@owner, @plate)", {
            ["@owner"] = xPlayer.identifier,
            ["@plate"] = plateText,
        })
        MySQL.Async.execute("UPDATE users SET starter = 'illegal' WHERE identifier = @owner", {
            ["@owner"] = xPlayer.identifier,
        })
        xPlayer.addInventoryItem('bat', 1)
        xPlayer.addAccountMoney('black_money', 25000)
        xPlayer.addAccountMoney('money', 5000)
        ExecuteCommand("giveExp "..xPlayer.source.." 200")
        Helper:showAdvancedNotification(xPlayer.source, "Andreas", xPlayer.name, "Vous avez ~g~reçus~s~ votre Starter Pack Illégal:\n\n+ 1 ~o~Enduro~s~\n+ 1 ~p~Batte~s~\n+ 25,000$ ~r~Argent Sale~s~\n+ 5,000$ ~g~Liquide~s~\n+ 200 ~b~Exp", "CHAR_ANDREAS")
    elseif value == "business" then
        local plateText = PlateText()
        MySQL.Async.execute("INSERT INTO owned_vehicles (owner, plate, label, vehicle, type, state, boutique, selling) VALUES(@owner, @plate, 'Starter Business', @vehicle, 'car', 1, 0, 0)", {
            ["@owner"] = xPlayer.identifier,
            ["@plate"] = plateText,
            ["@vehicle"] = json.encode({ model = GetHashKey('bf400'), plate = plateText })
        })
        MySQL.Async.execute("INSERT INTO open_car (owner, plate) VALUES(@owner, @plate)", {
            ["@owner"] = xPlayer.identifier,
            ["@plate"] = plateText,
        })
        MySQL.Async.execute("UPDATE users SET starter = 'business' WHERE identifier = @owner", {
            ["@owner"] = xPlayer.identifier,
        })
        xPlayer.addAccountMoney('bank', 30000)
        ExecuteCommand("giveExp "..xPlayer.source.." 400")
        Helper:showAdvancedNotification(xPlayer.source, "Andreas", xPlayer.name, "Vous avez ~g~reçus~s~ votre Starter Pack Business:\n\n+ 1 ~o~BF-400~s~\n+ 30,000$ ~g~Banque~s~\n+ 400 ~b~Exp", "CHAR_ANDREAS")
    end
end

Alma:AddEventHandler("Starter", "New", function(value)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if AlreadyStarter[xPlayer.identifier] then return xPlayer.showNotification('~r~Vous avez déjà reçus votre starter pack (1 Starter Pack maximum) !') end

    MySQL.Async.fetchAll("SELECT starter FROM users WHERE identifier = @a", {
        ["@a"] = xPlayer.identifier
    }, function(result)
        if result[1].starter == "new" then
            for k,v in pairs(StarterPack) do
                if v.value == value then
                    AddStarter(v.value, xPlayer)
                end
            end
        else
            AlreadyStarter[xPlayer.identifier] = true
            xPlayer.showNotification('~r~Vous avez déjà reçus votre starter pack (1 Starter Pack maximum) !')
        end
    end)
end)