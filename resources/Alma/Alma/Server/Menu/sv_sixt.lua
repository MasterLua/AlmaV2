Sixt = {}
Sixt.__index = Sixt

setmetatable(Sixt, {
	__call = function(_, id, name, description, model, picture, price)
		local self = setmetatable({}, Sixt);

        self.id = id
		self.name = name
		self.description = description
		self.model = model
        self.picture = picture
        self.price = price

        if (Sixt[self.id]) then
            print("Sixt meta-id : "..self.id.." are already used !")
        end

		Sixt[self.id] = self;

		return self
	end
})

function Sixt:New(id, name, description, model, picture, price)
	Sixt(id, name, description, model, picture, price)
end

Sixt:New(1, "Golf Mk7", nil, "rmodmk7", "rmodmk7", 2500000)
Sixt:New(2, "Toyota Supra", nil, "rmodsuprapandem", "rmodsuprapandem", 3500000)
Sixt:New(3, "Rolls Dawnonyx", nil, "dawnonyx", "dawnonyx", 3000000)
Sixt:New(4, "Porsche 918", nil, "rmodporsche918", "rmodporsche918", 2500000)
Sixt:New(5, "Porsche 911 Turbo", nil, "911turbos", "911turbos", 5000000)
Sixt:New(6, "Nissan Skyline", nil, "rmodskyline34", "rmodskyline34", 4000000)
Sixt:New(7, "Nissan GTR", nil, "rmodgtr50", "rmodgtr50", 3000000)
Sixt:New(8, "Nissan Fairlady", nil, "rmodz350pandem", "rmodz350pandem", 3500000)
Sixt:New(9, "Nissan 240SX", nil, "rmod240sx", "rmod240sx", 2500000)
Sixt:New(10, "Mercedes G65 AMG", nil, "rmodg65", "rmodg65", 3000000)
Sixt:New(11, "Mercedes E63S", nil, "rmode63s", "rmode63s", 2500000)
Sixt:New(12, "Mercedes C63 AMG", nil, "rmodc63amg", "rmodc63amg", 2000000)
Sixt:New(13, "Mercedes A45", nil, "a45", "a45", 2500000)

ESX.RegisterServerCallback("Sixt:GetLocation", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local LocationSixt = {}

    MySQL.Async.fetchAll("SELECT * FROM alma_sixt WHERE identifier = @a", {
        ["@a"] = xPlayer.identifier
    }, function(result)
        if result[1] then
            local time = os.time()
            if result[1].expiration <= time then
                MySQL.Async.execute("UPDATE alma_sixt SET expired = 1 WHERE id = @a", { ['a'] = result[1].id })
                MySQL.Async.execute("DELETE FROM open_car WHERE plate = @a", { ['a'] = 'SIXT'..result[1].id })
                MySQL.Async.fetchAll("SELECT * FROM alma_sixt WHERE identifier = @a", {
                    ["@a"] = xPlayer.identifier
                }, function(result)
                    for i = 1, #result do
                        LocationSixt[i] = {}
                        LocationSixt[i].id = result[i].id
                        LocationSixt[i].name = result[i].name
                        LocationSixt[i].model = result[i].model
                        LocationSixt[i].plate = result[i].plate
                        LocationSixt[i].expiration = os.date("%d/%m/%Y à %H:%M", result[i].expiration)
                        LocationSixt[i].expired = result[i].expired
                    end
                    cb(LocationSixt)
                end)
            else
                for i = 1, #result do
                    LocationSixt[i] = {}
                    LocationSixt[i].id = result[i].id
                    LocationSixt[i].name = result[i].name
                    LocationSixt[i].model = result[i].model
                    LocationSixt[i].plate = result[i].plate
                    LocationSixt[i].expiration = os.date("%d/%m/%Y à %H:%M", result[i].expiration)
                    LocationSixt[i].expired = result[i].expired
                end
                cb(LocationSixt)
            end
        end
    end)
end)

RegisterServerEvent("Sixt:LocationRename")
AddEventHandler("Sixt:LocationRename", function(id, name)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT identifier FROM alma_sixt WHERE id = @a", {
        ["@a"] = id
    }, function(result)
        if result then
            MySQL.Async.execute("UPDATE alma_sixt SET name = @a WHERE id = @b", {
                ["@a"] = name,
                ["@b"] = id
            }, function(changed)
                if changed then
                    xPlayer.showNotification("Vous avez changer le nom de votre ~g~véhicule~s~ !")
                else
                    xPlayer.showNotification("Nous n'arrivons pas à subvenir a votre demande !")
                end
            end)
        end
    end)
end)

RegisterServerEvent("Sixt:RenewSubscription")
AddEventHandler("Sixt:RenewSubscription", function(id, tableid, multiplication)
    local xPlayer = ESX.GetPlayerFromId(source)
    local time = os.time()
    local price = tonumber(Sixt[tableid].price) * tonumber(multiplication)

    if xPlayer.getAccount("cash").money >= tonumber(price) then
        xPlayer.removeAccountMoney("cash", price)
        MySQL.Async.execute("UPDATE alma_sixt SET expiration = @a WHERE id = @b", {
            ["@a"] = time + ((60 * 60) * (multiplication == 1 and 24 or multiplication == 2 and 72 or multiplication == 3 and 168)),
            ["@b"] = id
        })
        MySQL.Async.execute("UPDATE alma_sixt SET expired = @b WHERE id = @a", { 
            ["@a"] = id,
            ["@b"] = false
        })
        Helper:showAdvancedNotification(xPlayer.source, "Sixt", "~y~Renouvellement", "~g~Félicitation~s~, vous avez renouveler ~g~"..Sixt[tableid].name.."~s~ pour ~g~"..ESX.Math.GroupDigits(tonumber(price)).."$~s~ pendant ~g~"..(multiplication == 1 and "24 heures" or multiplication == 2 and "3 jours" or multiplication == 3 and "1 semaine"), "CHAR_JOSEF", 2)
    else
        xPlayer.showNotification("~r~Vous n'avez pas assez d'Argent !")
    end
end)

RegisterServerEvent("Sixt:StopRent")
AddEventHandler("Sixt:StopRent", function(id, tableid)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT id FROM alma_sixt WHERE identifier = @a", {
        ["@a"] = xPlayer.identifier
    }, function(result)
        if result then
            MySQL.Async.execute("DELETE FROM alma_sixt WHERE id = @a", {
                ["@a"] = id
            }, function(succes)
                if succes then
                    Helper:showAdvancedNotification(source, "Sixt", "~r~Renouvellement", "Nous somme ~r~désolé~s~, d'apprendre que vous arrêter déjà la subscription de votre ~r~"..Sixt[tableid].name, "CHAR_JOSEF", 2)
                else
                    xPlayer.showNotification("Nous ne parvenons pas à stoper votre location !")
                end
            end)
        else
            DropPlayer(soruce, "Vous ne pouvez pas arrêter la location d'un véhicule qui ne vous appartient pas !")
        end
    end)
end)

RegisterServerEvent("Sixt:LocationVehicle")
AddEventHandler("Sixt:LocationVehicle", function(id, multiplication)
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = tonumber(Sixt[id].price) * tonumber(multiplication)
    local tag = math.random(100, 10000)
    local time = os.time()

    if xPlayer.getAccount("money").money >= tonumber(price) then
        xPlayer.removeAccountMoney("money", price)
        MySQL.Async.execute("INSERT INTO alma_sixt (id, identifier, name, model, plate, expiration) VALUES (@id, @identifier, @name, @model, @plate, @expiration)", {
            ["@id"] = tag,
            ["@identifier"] = xPlayer.identifier,
            ["@name"] = Sixt[id].name,
            ["@model"] = Sixt[id].model,
            ["@plate"] = "SIXT"..tag,
            ["@expiration"] = time + ((60 * 60) * (multiplication == 1 and 24 or multiplication == 2 and 72 or multiplication == 3 and 168))
        })
        MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, label, vehicle, type, state, boutique) VALUES (@owner, @plate, @label, @vehicle, "car", 1, @boutique)', {
            ['@owner'] = xPlayer.identifier,
            ['@plate'] = "SIXT"..tag,
            ['@label'] = "SIXT",
            ["@vehicle"] = json.encode({ model = GetHashKey(Sixt[id].model), plate = "SIXT"..tag }),
            ["@boutique"] = 0
        })
        MySQL.Async.execute('INSERT INTO open_car (owner, plate, NB) VALUES (@owner, @plate, @NB)', {
            ['@owner'] = xPlayer.identifier,
            ['@plate'] = "SIXT"..tag,
            ['@NB'] = 2
        })
        Helper:showAdvancedNotification(xPlayer.source, "Sixt", "~y~Achat", "~g~Merci~s~, d'avoir louer ~g~"..Sixt[id].name.."~s~ pour ~g~"..ESX.Math.GroupDigits(tonumber(price)).."$~s~ pendant ~g~"..(multiplication == 1 and "24 heures" or multiplication == 2 and "3 jours" or multiplication == 3 and "1 semaine"), "CHAR_JOSEF", 2)
    else
        if xPlayer.getAccount("bank").money >= tonumber(price) then
            xPlayer.removeAccountMoney("bank", price)
            MySQL.Async.execute("INSERT INTO alma_sixt (id, identifier, name, model, plate, expiration) VALUES (@id, @identifier, @name, @model, @plate, @expiration)", {
                ["@id"] = tag,
                ["@identifier"] = xPlayer.identifier,
                ["@name"] = Sixt[id].name,
                ["@model"] = Sixt[id].model,
                ["@plate"] = "SIXT"..tag,
                ["@expiration"] = time + ((60 * 60) * (multiplication == 1 and 24 or multiplication == 2 and 72 or multiplication == 3 and 168))
            })
            MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, label, vehicle, type, state, boutique) VALUES (@owner, @plate, @label, @vehicle, "car", 1, @boutique)', {
                ['@owner'] = xPlayer.identifier,
                ['@plate'] = "SIXT"..tag,
                ['@label'] = "SIXT",
                ["@vehicle"] = json.encode({ model = GetHashKey(Sixt[id].model), plate = "SIXT"..tag }),
                ["@boutique"] = 0
            })
            MySQL.Async.execute('INSERT INTO open_car (owner, plate, NB) VALUES (@owner, @plate, @NB)', {
                ['@owner'] = xPlayer.identifier,
                ['@plate'] = "SIXT"..tag,
                ['@NB'] = 2
            })
            Helper:showAdvancedNotification(xPlayer.source, "Sixt", "~y~Achat", "~g~Merci~s~, d'avoir louer ~g~"..Sixt[id].name.."~s~ pour ~g~"..ESX.Math.GroupDigits(tonumber(price)).."$~s~ pendant ~g~"..(multiplication == 1 and "24 heures" or multiplication == 2 and "3 jours" or multiplication == 3 and "1 semaine"), "CHAR_JOSEF", 2)
        else
            xPlayer.showNotification("~r~Vous n'avez pas assez d'Argent !")
        end
    end
end)