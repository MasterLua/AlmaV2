RegisterNetEvent("Authentic:AddVehToClient")
AddEventHandler("Authentic:AddVehToClient", function(id, name, type)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xLeJ = ESX.GetPlayerFromId(id)
    local typeByName = {
        ["car"] = "véhicule",
        ["aircraft"] = "avion"
    }
    if xPlayer.getGroup() == "fondateur" then
        local relPlatre = CreateRandomPlateText()
        MySQL.Async.execute("INSERT INTO owned_vehicles (owner, plate, label, vehicle, type, state, boutique) VALUES (@o, @p, @l, @v, @t, 1, 0)", {
            ["@o"] = xLeJ.identifier,
            ["@p"] = relPlatre,
            ["@l"] = "Gain",
            ["@t"] = type,
            ["@v"] = json.encode({ model = GetHashKey(name), plate = relPlatre }),
        }, function(result)
            if result then
                xPlayer.showNotification("Envoyé !")
            end
        end)
    end
end)

RegisterCommand("garage:clearGarage", function(source, args, rawCommand)
    if source == 0 then
        return print("Impossible de faire ceci par le biais de la console !")
    end
    local selectedPlayer = args[1]
    local xPlayer = ESX.GetPlayerFromId(source)
    local xSelected = ESX.GetPlayerFromId(selectedPlayer)
    if (selectedPlayer) then
        if (xSelected) then
            if xPlayer.getGroup() == "fondateur" then
                MySQL.Async.execute([[
		            DELETE FROM open_car WHERE owner = @owner;
		            DELETE FROM owned_vehicles WHERE owner = @owner;	]], {
                    ['@owner'] = xSelected.identifier,
                }, function(result)
                    if (result == 0) then
                        xPlayer.showNotification("Une erreur est ~r~survenue~s~ il semblerait que l'utilisateur seléctionné n'est pas ~r~valide~s~ ou ~r~inexistante")
                    else
                        xPlayer.showNotification("Action réussi, tous les véhicule de ~g~"..xSelected.name.."~s~ on été supprimé !")
                        webhook("[Staff] "..xPlayer.name..": a supprimer tout les véhicules du garage de ("..xSelected.name..") !", 15277667)
                    end
                end)
            else
                xPlayer.showNotification("Vous n'avez pas les permissions nécessaire !")
            end
        else
            xPlayer.showNotification("Une erreur est ~r~survenue~s~ il semblerait que l'utilisateur seléctionné n'est pas ~r~valide~s~ ou ~r~inexistante")
        end
    else
        xPlayer.showNotification("Arguments[1] undefined !")
    end
end, false)

RegisterCommand("garage:deleteVehicle", function(source, args, rawCommand)
    if source == 0 then
        return print("Impossible de faire ceci par le biais de la console !")
    end
    local selectedPlate = args[1]
    local xPlayer = ESX.GetPlayerFromId(source)
    if (selectedPlate) then
            if xPlayer.getGroup() == "fondateur" then
                    MySQL.Async.execute([[
		                    DELETE FROM open_car WHERE plate = @plate;
		                    DELETE FROM owned_vehicles WHERE plate = @plate;	]], {
                        ['@plate'] = selectedPlate,
                    }, function(result)
                        if (result == 0) then
                            xPlayer.showNotification("Une erreur est ~r~survenue~s~ il semblerait que l'utilisateur seléctionné n'est pas ~r~valide~s~ ou ~r~inexistante")
                        else
                            xPlayer.showNotification("Action réussi, tous le véhicule sous la plaque ~g~"..selectedPlate.."~s~ a été supprimé de l'utilisateur détenteur !")
                            webhook("[Staff] "..xPlayer.name..": a supprimer le véhicule avec la plaque ("..selectedPlate..") du garage de ("..xSelected.name..") !", 15277667)
                        end
                    end)
             else
                 xPlayer.showNotification("Vous n'avez pas les permissions nécessaire !")
            end
    else
        xPlayer.showNotification("Arguments[1] undefined !")
    end
end, false)

function webhook(message, color)
	date_local1 = os.date('%H', os.time())
	local date_local = date_local1 + 2
    local date_lolo = os.date('%M', os.time())
	local DiscordWebHook = "https://discord.com/api/webhooks/901205378560319548/z6egOVAODUUBxqaMPNp4wxlkblaSuTrGobyUQeFQ0dujR3pK42ukcRBgAxFFgRqa8B2F"
    local embeds = {
	    {
          ["title"] = "Garage - by Authentic",
		  ["description"] = "```"..message.."```",
		  ["type"] = "rich",
		  ["color"] = color,
          ["thumbnail"] = {
            ["url"] = "https://cdn.discordapp.com/attachments/895271411432714282/895271528151801856/2d892f8e6d26f5b4c58ab30fb103f715.png",
          },
		  ["footer"] =  {
			  ["text"] = date_local..":"..date_lolo,
		  },
	    }
    }

	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = "Garage - by Authentic",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end 