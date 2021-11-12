ESX.RegisterServerCallback('garage:getOwnedCars', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local ownedCars = {}
	local ownedCarsJobs = {}
	local OwnedCarsOrg = {}

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {
		['@owner'] = xPlayer.identifier,
	}, function(data)
		for k, v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			if not v.selling then
				table.insert(ownedCars, {boutique = v.boutique, owner = v.owner, label = v.label, vehicle = vehicle, type = v.type, state = v.state, plate = v.plate})
			end
		end
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {
			['@owner'] = xPlayer.job.name,
		}, function(data2)
			for k, v in pairs(data2) do
				local vehicle2 = json.decode(v.vehicle)
				if not v.selling then
					table.insert(ownedCarsJobs, {owner = v.owner, label = v.label, vehicle = vehicle2, type = v.type, state = v.state, plate = v.plate})
				end
			end
			cb(ownedCars, ownedCarsJobs, OwnedCarsOrg)
		end)
	end)
end)

RegisterNetEvent('garage:renameVehicle')
AddEventHandler('garage:renameVehicle', function(owner, vehicle, label)
    local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.identifier == owner or xPlayer.job.name == owner then
		MySQL.Async.execute('UPDATE owned_vehicles SET label = @label WHERE plate = @plate', {
			['@label'] = label,
			['@plate'] = vehicle.plate
		}, function()
			webhook("Véhicule : "..vehicle.plate.." a changer le label de son véhicule en : "..label, 15277667)
		end)
	else
		DropPlayer(source, 'Utilisation du trigger pour renommer les véhicules')
	end
end)

RegisterNetEvent('garage:setstatevehicle')
AddEventHandler('garage:setstatevehicle', function(plate, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE owned_vehicles SET state = @state WHERE plate = @plate', {
		['@state'] = state,
		['@plate'] = plate
	}, function(rowsChanged)
		if rowsChanged == 0 then
		end
	end)
end)

ESX.RegisterServerCallback('garage:storevehicle', function(source, cb, vehicleProps)
	local ownedCars = {}
	local vehplate = vehicleProps.plate:match('^%s*(.-)%s*$')
	local vehiclemodel = vehicleProps.model
	local xPlayer = ESX.GetPlayerFromId(source)
	
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = vehicleProps.plate
	}, function(result)
		if result[1] ~= nil then
			local originalvehprops = json.decode(result[1].vehicle)

			if originalvehprops.model == vehiclemodel then
				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE owner = @owner AND plate = @plate', {
					['@owner'] = xPlayer.identifier,
					['@vehicle'] = json.encode(vehicleProps),
					['@plate'] = vehicleProps.plate
				}, function(rowsChanged)
					if rowsChanged == 0 then
					end

					cb(true)
				end)
			else
				cb(false)
			end
		else
			MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
				['@owner'] = xPlayer.job.name,
				['@plate'] = vehicleProps.plate
			}, function(resultat)
				if resultat[1] ~= nil then
					local originalvehprops = json.decode(resultat[1].vehicle)

					if originalvehprops.model == vehiclemodel then
						MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE owner = @owner AND plate = @plate', {
							['@owner'] = xPlayer.identifier,
							['@vehicle'] = json.encode(vehicleProps),
							['@plate'] = vehicleProps.plate
						}, function(rowsChanged)
							if rowsChanged == 0 then
							end
		
							cb(true)
						end)
					else
						cb(false)
					end
				end
			end)
		end
	end)
end)

ESX.RegisterServerCallback('garage:storevehiclewithmoney', function(source, cb, vehicleProps)
	local ownedCars = {}
	local vehplate = vehicleProps.plate:match('^%s*(.-)%s*$')
	local vehiclemodel = vehicleProps.model
	local xPlayer = ESX.GetPlayerFromId(source)
	vehiclePlate = string.gsub(vehicleProps.plate, '%s+', '')
	if xPlayer.getAccount('money').money >= 500 then
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = vehiclePlate
		}, function(result)
			if result[1] ~= nil then
				xPlayer.removeAccountMoney('money', 500)
				local originalvehprops = json.decode(result[1].vehicle)
				if originalvehprops.model == vehiclemodel or GetHashKey(originalvehprops.model) == vehiclemodel then
					MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE owner = @owner AND plate = @plate', {
						['@owner'] = xPlayer.identifier,
						['@vehicle'] = json.encode(vehicleProps),
						['@plate'] = vehiclePlate
					}, function(rowsChanged)
						if rowsChanged == 0 then
						end

						cb(true)
					end)
				else
					cb(false)
				end
			else
				MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
					['@owner'] = xPlayer.job.name,
					['@plate'] = vehiclePlate
				}, function(resultat)
					if resultat[1] ~= nil then
						xPlayer.removeAccountMoney('money', 500)
						local originalvehprops = json.decode(resultat[1].vehicle)

						if originalvehprops.model == vehiclemodel then
							MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE owner = @owner AND plate = @plate', {
								['@owner'] = xPlayer.identifier,
								['@vehicle'] = json.encode(vehicleProps),
								['@plate'] = vehiclePlate
							}, function(rowsChanged)
								if rowsChanged == 0 then
								end
			
								cb(true)
							end)
						else
							cb(false)
						end
					end
				end)
			end
		end)
	else
		xPlayer.showNotification('~r~Vous n\'avez pas l\'argent néccéssaire')
	end
end)

ESX.RegisterServerCallback('garage:storeVehicleFourriere', function(source, cb, vehicleProps)
	local ownedCars = {}
	local vehplate = vehicleProps.plate:match('^%s*(.-)%s*$')
	local vehiclemodel = vehicleProps.model
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer.getAccount('bank').money >= 500 then
		xPlayer.removeAccountMoney('bank', 500)
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = vehicleProps.plate
		}, function(result)
			if result[1] ~= nil then
				local originalvehprops = json.decode(result[1].vehicle)

				if originalvehprops.model == vehiclemodel then
					MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE owner = @owner AND plate = @plate', {
						['@owner'] = xPlayer.identifier,
						['@vehicle'] = json.encode(vehicleProps),
						['@plate'] = vehicleProps.plate
					}, function(rowsChanged)
						if rowsChanged == 0 then
						end

						cb(true)
					end)
				else
					DropPlayer(source, 'problème garage')
					cb(false)
				end
			else
				MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
					['@owner'] = xPlayer.job.name,
					['@plate'] = vehicleProps.plate
				}, function(result)
					if result[1] ~= nil then
						local originalvehprops = json.decode(result[1].vehicle)
		
						if originalvehprops.model == vehiclemodel then
							MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE owner = @owner AND plate = @plate', {
								['@owner'] = xPlayer.job.name,
								['@vehicle'] = json.encode(vehicleProps),
								['@plate'] = vehicleProps.plate
							}, function(rowsChanged)
								if rowsChanged == 0 then
								end
		
								cb(true)
							end)
						else
							DropPlayer(source, 'problème garage')
							cb(false)
						end
					end
				end)
			end
		end)
	else
		xPlayer.showNotification('~r~Vous n\'avez pas l\'argent nécéssaire')
	end
end)

local Garage = {}

RegisterServerEvent('garage:createGarage')
AddEventHandler('garage:createGarage', function(NameGarage, PositionGarage, PositionPointSpawn, PositionDeletePoint, type, Heading, BlipActive)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getGroup() == 'fondateur' then
		local position = json.encode(PositionGarage)
		local PosSpawn = json.encode(PositionPointSpawn)
		local PosDelete = json.encode(PositionDeletePoint)
        MySQL.Async.execute("INSERT INTO `alma_garage` (`name`, `pos`, `SpawnPoint`, `DeletePoint`, `Heading`, `type`, `blip`) VALUES (@name, @pos, @SpawnPoint, @DeletePoint, @Heading, @type, @blip) ", {
            ['@name'] = NameGarage,
            ['@pos'] = position,
			['@SpawnPoint'] = PosSpawn,
			['@DeletePoint'] = PosDelete,
			['@Heading'] = Heading,
			['@type'] = type,
			['@blip'] = BlipActive
        })
		local index = #Garage
		index = index + 1
		Garage[index] = {}
		Garage[index].id = index
		Garage[index].name = NameGarage
		Garage[index].position = json.decode(position)
		Garage[index].SpawnPoint = json.decode(PosSpawn)
		Garage[index].DeletePoint = json.decode(PosDelete)
		Garage[index].Heading = Heading
		Garage[index].BlipActive = 1
		Garage[index].type = type
		TriggerClientEvent('garage:refreshGarage', -1, Garage)
		xPlayer.showNotification('Veuillez patientez votre garage va arriver d\'ici quelque secondes ...')
		webhook("Nouveau Garage crée ! \nGarage-Nom : "..NameGarage.."\nPosition-Garage : "..position, 15277667)
	end
end)

RegisterNetEvent("garage:modify")
AddEventHandler("garage:modify", function(option, id, pos)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source);
	if xPlayer.getGroup() ~= "fondateur" then return end

	if (xPlayer) then
		local pos = json.encode(pos)
		MySQL.Async.execute("UPDATE `alma_garage` SET "..option.." = @a WHERE id = @b", {
			['@a'] = pos,
			['@b'] = id
		})
		xPlayer.showNotification("Position du "..option.." changé, rappuyer sur ~g~E~s~ pour valider !")
		Wait(1000)
		RefreshGarage()
	end
end)

Citizen.CreateThread(function()
	LoadGarage()
end)

function RefreshGarage()
	MySQL.Async.fetchAll('SELECT * FROM alma_garage', {}, function(ElGarage)
        for i=1, #ElGarage, 1 do
			local Pos = json.decode(ElGarage[i].pos)
			local PosSpawn = json.decode(ElGarage[i].SpawnPoint)
			local PosDelete = json.decode(ElGarage[i].DeletePoint)
			Garage[i] = {
				id = ElGarage[i].id,
				name = ElGarage[i].name,
				position = Pos,
				SpawnPoint = PosSpawn,
				DeletePoint = PosDelete,
				Heading = ElGarage[i].Heading,
				blip = ElGarage[i].blip,
				type = ElGarage[i].type
			};
        end
    end)
	TriggerClientEvent('garage:refreshGarage', -1, Garage)
end

function LoadGarage()
    MySQL.Async.fetchAll('SELECT * FROM alma_garage', {}, function(ElGarage)
        for i=1, #ElGarage, 1 do
			local Pos = json.decode(ElGarage[i].pos)
			local PosSpawn = json.decode(ElGarage[i].SpawnPoint)
			local PosDelete = json.decode(ElGarage[i].DeletePoint)
			Garage[i] = {}
			Garage[i].id = ElGarage[i].id
			Garage[i].name = ElGarage[i].name
			Garage[i].position = Pos
			Garage[i].SpawnPoint = PosSpawn
			Garage[i].DeletePoint = PosDelete
			Garage[i].Heading = ElGarage[i].Heading
			Garage[i].blip = ElGarage[i].blip
			Garage[i].type = ElGarage[i].type
        end
		webhook("Cache dynamique chargée nb: "..#Garage, 15277667)
		print('[^1Modules Garage^7]: Télécharger avec succès, prêt à l\'utilisation')
    end)
	TriggerClientEvent('garage:refreshGarage', -1, Garage)
end

RegisterServerEvent('garage:InitGarage')
AddEventHandler('garage:InitGarage', function()
	TriggerClientEvent('garage:refreshGarage', source, Garage)
end)

RegisterServerEvent('garage:AttribuerVehicule')
AddEventHandler('garage:AttribuerVehicule', function(type, vehicle)
	local xPlayer = ESX.GetPlayerFromId(source)
	if type == 'job' then
		print(xPlayer.job.name)
		if xPlayer.job.name ~= 'unemployed' then
			if vehicle.owner == xPlayer.identifier then
				MySQL.Async.execute('UPDATE owned_vehicles SET owner = @owner WHERE plate = @plate', {
					['@owner'] = xPlayer.job.name,
					['@plate'] = vehicle.plate
				}, function()
					
				end)
				xPlayer.showNotification('~w~Le véhicule à été attribué a l\'entreprise : '..xPlayer.job.label)
				webhook("Véhicule attribuer "..vehicle.plate.." à entreprise : "..xPlayer.job.label.." par : "..xPlayer.name, 15277667)
			end
		else
			xPlayer.showNotification('~w~Vous n\'avez pas d\'entreprise pour faire çela')
		end
	end
end)

RegisterCommand('garage:create', function(source,args) 
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'fondateur' then
		TriggerClientEvent('garage:creategarage', source)
	end
end)

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