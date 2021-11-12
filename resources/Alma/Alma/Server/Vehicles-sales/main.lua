VEHICLES_SALES = {};
LIST = {};

Alma:AddEventHandler("VehicleSales", "RequestVehiclesOwned", function()
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);
    MySQL.Async.fetchAll("SELECT vehicle, plate, type, selling, boutique FROM owned_vehicles WHERE owner = @a", {
        ["@a"] = xPlayer.identifier,
    }, function(result)
        if result[1] then
            for i = 1, #result do
                if result[i].type == "car" and not result[i].selling and not result[i].boutique then
                    LIST[result[i].plate] = {}
                    LIST[result[i].plate].vehicle = json.encode(result[i].vehicle)
                    LIST[result[i].plate].type = result[i].type
                    LIST[result[i].plate].plate = result[i].plate
                end
            end
            Alma:TriggerClientEvent("VehicleSales", "GetVehiclesOwned", source, LIST)
        else
            Alma:TriggerClientEvent("VehicleSales", "GetVehiclesOwned", source, {})
        end
    end)
end)


Citizen.CreateThread(function()
    Wait(100)
    RefreshSalesVehicles()
end)

function RealoadPlayerVeh(xPlayer)
    MySQL.Async.fetchAll("SELECT vehicle, plate, type, selling, boutique FROM owned_vehicles WHERE owner = @a", {
        ["@a"] = xPlayer.identifier,
    }, function(result)
        LIST = {};
        if result[1] then
            for i = 1, #result do
                if result[i].type == "car" and not result[i].selling and not result[i].boutique then
                    LIST[result[i].plate] = {}
                    LIST[result[i].plate].vehicle = json.encode(result[i].vehicle)
                    LIST[result[i].plate].type = result[i].type
                    LIST[result[i].plate].plate = result[i].plate
                end
            end
            Alma:TriggerClientEvent("VehicleSales", "GetVehiclesOwned", xPlayer.source, LIST)
        else
            Alma:TriggerClientEvent("VehicleSales", "GetVehiclesOwned", xPlayer.source, {})
        end
    end)
end

function RefreshSalesVehicles()
    local time = os.time()
    VEHICLES_SALES = {}
    MySQL.Async.fetchAll("SELECT * FROM vehicles_sales", {}, function(result)
        if result then
            for i = 1, #result do
                if result[i].expire_at <= tonumber(time) then
                    MySQL.Async.execute("DELETE FROM vehicles_sales WHERE vehicle = @vehicle", {
                        ["@vehicle"] = result[i].vehicle
                    }, function()
                        MySQL.Async.execute("UPDATE FROM owned_vehicles SET selling = 0 WHERE vehicle = @vehicle AND owner = @owner", {
                            ["@vehicle"] = result[i].vehicle,
                            ["@owner"] = result[i].seller
                        })
                    end)
                else
                    local veh = json.decode(result[i].vehicle)
                    VEHICLES_SALES[veh.plate] = { id = result[i].id, seller = result[i].seller, seller_name = result[i].seller_name, name = result[i].name, description = result[i].description, price = result[i].price, plate = veh.plate, vehicle = json.encode(result[i].vehicle), expire_at = result[i].expire_at, formatted_expire_at = result[i].formatted_expire_at }
                end
            end
            Alma:TriggerClientEvent("VehicleSales", "RetrieveCatalog", -1, VEHICLES_SALES)
        end
    end)
end

function DeleteOfSales(idSell)
    MySQL.Async.execute("DELETE FROM vehicles_sales WHERE id = @id", {
        ["@id"] = idSell
    }, function(result)
        RefreshSalesVehicles()
    end)
end

function AddVehiclesToClient(id, xPlayer)
    local plates = CreateRandomPlateText()
    for k,v in pairs(VEHICLES_SALES) do
        if v.id == id then
            print(v.plate)
            MySQL.Async.execute("DELETE FROM owned_vehicles WHERE vehicle = @a AND owner = @b", {
                ["@a"] = json.decode(v.vehicle),
                ["@b"] = v.seller
            }, function(result)
                
                MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, label, vehicle, type, state, boutique, selling) VALUES (@owner, @plate, @label, @vehicle, @type, 1, 0, 0)', {
                    ["@owner"] = xPlayer.identifier,
                    ["@plate"] = v.plate,
                    ["@label"] = "Véhicule particuliers",
                    ["@type"] = "car",
                    ["@vehicle"] = json.decode(v.vehicle)
                }, function(result)
                    MySQL.Async.execute("DELETE FROM open_car WHERE plate = @p", {
                        ["@p"] = v.plate
                    }, function(result)
                        MySQL.Async.execute("INSERT INTO open_car (owner, plate, NB) VALUES (@owner, @plates, 0)", {
                            ["@owner"] = xPlayer.identifier,
                            ["@plates"] = v.plate
                        })
                        DeleteOfSales(v.id)
                        RealoadPlayerVeh(xPlayer)
                    end)
                end)
            end)
        end
    end
end

function IN_SALE(plate)
    MySQL.Async.execute("UPDATE owned_vehicles SET selling = 1 WHERE plate = @plate", {
        ["@plate"] = plate
    })
end

Alma:AddEventHandler("VehicleSales", "RequestCatalog", function()
    Alma:TriggerClientEvent("VehicleSales", "RetrieveCatalog", source, VEHICLES_SALES)
end)

Alma:AddEventHandler("VehicleSales", "Selling", function(plate, name, description, price, expire_at)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if string.len(tostring(price)) >= 11 then return xPlayer.showNotification("~r~Vous ne pouvez pas mettre un prix aussi gros !") end
    if string.len(name) >= 80 then return xPlayer.showNotification("~r~Vous ne pouvez pas mettre un nom aussi grand !") end
    if string.len(name) >= 110 then return xPlayer.showNotification("~r~Vous ne pouvez pas mettre une description aussi grande !") end

    MySQL.Async.fetchAll("SELECT vehicle FROM owned_vehicles WHERE plate = @p AND owner = @owner AND selling = 0", {
        ["@p"] = plate,
        ["@owner"] = xPlayer.identifier
    }, function(result)
        if result[1] then
            local time = os.time()
            local totalExpire = time + ((60 * 60) * tonumber(expire_at))
            MySQL.Async.execute("INSERT INTO vehicles_sales (seller, seller_name, name, description, price, vehicle, expire_at, formatted_expire_at) VALUES (@s, @sn, @n, @d, @p, @v, @et, @fet)", {
                ["@s"] = xPlayer.identifier,
                ["@sn"] = GetPlayerName(source):gsub("~", ""),
                ["@n"] = name,
                ["@d"] = description,
                ["@p"] = tonumber(price),
                ["@v"] = result[1].vehicle,
                ["@et"] = totalExpire,
                ["@fet"] = tonumber(expire_at)
            }, function(result)
                if result then
                    Helper:showAdvancedNotification(xPlayer.source, "AlmaRP", "Information", "Votre véhicule est désormais disponible, si personne n'a acheté votre véhicule, votre annonce sera supprimé et le véhicule sera à nouveau disponible dans votre garage.", "CHAR_CALIFORNIA", 1)
                    IN_SALE(plate)
                    RefreshSalesVehicles()
                    RealoadPlayerVeh(xPlayer)
                    Alma:TriggerClientEvent("VehicleSales", "BuySuccessfully", source)
                end
            end)
        else
            DropPlayer(source, "Cé véhicule ne vous appartient pas")
        end
    end)
end)

Alma:AddEventHandler("VehicleSales", "Buy", function(id)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);
    local time = os.time()

    for k,v in pairs(VEHICLES_SALES) do
        if id == v.id then
            if v.expire_at <= time then
                RefreshSalesVehicles() 
                return xPlayer.showNotification("La vente de ce véhicule a expiré !") 
            end
            if xPlayer.getAccount("bank").money >= tonumber(v.price) then
                xPlayer.removeAccountMoney("bank", tonumber(v.price))
                Helper:showAdvancedNotification(xPlayer.source, "AlmaRP", "Informations", "Vous avez acheter "..v.name..", pour "..v.price.."$, depuis votre compte en banque", "CHAR_CALIFORNIA", 1)
                AddVehiclesToClient(v.id, xPlayer)
                DeleteOfSales(v.id)
                local xPlayers = ESX.GetPlayers()
                for i = 1, #xPlayers do
                    local xSeller = ESX.GetPlayerFromId(xPlayers[i]);
                    if xSeller.identifier == v.seller then
                        Helper:showAdvancedNotification(xSeller.source, "AlmaRP", "Informations", xPlayer.name.." vient d'acheter votre "..v.name..", vous avez reçus l'argent sur votre compte en banque !", "CHAR_CALIFORNIA", 1)
                    end
                end
            else
                xPlayer.showNotification("~r~Vous n'avez pas assez de Argent en Banque !")
            end
        end
    end
end)