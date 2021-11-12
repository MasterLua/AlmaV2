MySQL.ready(function()
	MySQL.Async.execute('DELETE FROM open_car WHERE NB = @NB', {
		['@NB'] = 2
	})
end)

ESX.RegisterServerCallback('esx_vehiclelock:getVehiclesnokey', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM open_car WHERE owner = @owner', {
		['@owner'] = xPlayer.identifier
	}, function(result2)
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {
			['@owner'] = xPlayer.identifier
		}, function(result)
			local vehicles = {}

			for i = 1, #result, 1 do
				local found
				local vehicleData = json.decode(result[i].vehicle)

				for j = 1, #result2, 1 do
					if result2[j].plate == vehicleData.plate then
						found = true
					end
				end

				if not found then
					table.insert(vehicles, vehicleData)
				end
			end

			cb(vehicles)
		end)
	end)
end)

ESX.RegisterServerCallback('esx_vehiclelock:mykey', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM open_car WHERE owner = @owner AND plate = @plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	}, function(result)
		local found = false

		if result[1] then
			found = true
		end

		cb(found)
	end)
end)

ESX.RegisterServerCallback('Modern:GetAllMyKey', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM open_car WHERE owner = @owner', {
		['@owner'] = xPlayer.identifier
	}, function(result)
		local keys = {}

		for i = 1, #result, 1 do
			table.insert(keys, {
				plate = result[i].plate,
				NB = result[i].NB
			})
		end

		cb(keys)
	end)
end)

Alma.netRegisterAndHandle('Modern:RegisterNewKey', function(plate, target)
	local _source = source
	local xPlayer

	if target ~= 'no' then
		xPlayer = ESX.GetPlayerFromId(target)
	else
		xPlayer = ESX.GetPlayerFromId(_source)
	end

	MySQL.Async.execute('INSERT INTO open_car (owner, plate, NB) VALUES (@owner, @plate, @NB)', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate,
		['@NB'] = 1
	}, function()
		TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, GetConvar("servername", "~r~Boutique"), '~y~Clés', 'Vous avez une nouvelle pair de clés ! ', 'CHAR_CALIFORNIA', 7)
	end)
end)
Alma.netRegisterAndHandle('ewen:changevehicleowner', function(target, vehicle)
	if target == -1 then
		DropPlayer(source,'Désynchronisation avec le serveur ou détection de Cheat')
		return
	end
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayerTarget = ESX.GetPlayerFromId(target)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = vehicle.plate
	}, function(result)
		if result[1] then
			if not result[1].boutique then
				MySQL.Async.execute('UPDATE owned_vehicles SET owner = @target WHERE owner = @owner AND plate = @plate', {
					['@owner'] = xPlayer.identifier,
					['@target'] = xPlayerTarget.identifier,
					['@plate'] = vehicle.plate
				}, function()
					xPlayer.showNotification('~r~Alma ~w~~n~Vous avez donner les clés du véhicule (~r~'..vehicle.plate..'~w~)')
					xPlayerTarget.showNotification('~r~Alma ~w~~n~Vous avez reçu les clés du véhicule (~r~'..vehicle.plate..'~w~)')
				end)
			else
				DropPlayer(source,'Désynchronisation avec le serveur ou détection de Cheat')
			end
		else
			xPlayer.showNotification('~r~Alma ~w~~n~Le véhicule ne vous appartient pas')
		end
	end)
end)

Alma.netRegisterAndHandle('Modern:ChangeVehicleAndKeyOwner', function(target, plate, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayerTarget = ESX.GetPlayerFromId(target)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			local vehicle = json.decode(result[1].vehicle)

			if vehicle.model == vehicleProps.model and vehicle.plate == plate then
				MySQL.Async.execute('UPDATE owned_vehicles SET owner = @target WHERE owner = @owner AND plate = @plate', {
					['@owner'] = xPlayer.identifier,
					['@target'] = xPlayerTarget.identifier,
					['@plate'] = plate
				}, function()
					MySQL.Async.execute('DELETE FROM open_car WHERE owner = @owner AND plate = @plate', {
						['@owner'] = xPlayer.identifier,
						['@plate'] = plate
					}, function()
						MySQL.Async.execute('INSERT INTO open_car (owner, plate, NB) VALUES (@owner, @plate, @NB)', {
							['@owner'] = xPlayerTarget.identifier,
							['@plate'] = plate,
							['@NB'] = 1
						}, function()
							TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, GetConvar("servername", "~r~Boutique"), '~y~Clés', 'Vous avez donné votre clé, vous ne les avez plus !', 'CHAR_CALIFORNIA', 7)
							TriggerClientEvent('esx:showAdvancedNotification', xPlayerTarget.source, GetConvar("servername", "~r~Boutique"), '~y~Clés', 'Vous avez reçu de nouvelle clé ', 'CHAR_CALIFORNIA', 7)
						end)
					end)
				end)
			end
		else
			TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, GetConvar("servername", "~r~Boutique"), '~y~Clés', 'Le véhicule le plus proche ne vous appartient pas !', 'CHAR_CALIFORNIA', 7)
		end
	end)
end)

Alma.netRegisterAndHandle('Modern:DeleteKey', function(plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('DELETE FROM open_car WHERE owner = @owner AND plate = @plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	})
end)

Alma.netRegisterAndHandle('Modern:GiveTemporyKey', function(target, plate)
	local _source = source
	local xPlayerTarget = ESX.GetPlayerFromId(target)

	MySQL.Async.execute('INSERT INTO open_car (owner, plate, NB) VALUES (@owner, @plate, @NB)', {
		['@owner'] = xPlayerTarget.identifier,
		['@plate'] = plate,
		['@NB'] = 2
	}, function()
		TriggerClientEvent('esx:showAdvancedNotification', _source, GetConvar("servername", "~r~Boutique"), '~y~Clés', 'Vous avez prété votre clé', 'CHAR_CALIFORNIA', 7)
		TriggerClientEvent('esx:showAdvancedNotification', xPlayerTarget.source, GetConvar("servername", "~r~Boutique"), '~y~Clés', 'Vous avez reçu un double de clé ', 'CHAR_CALIFORNIA', 7)
	end)
end)

--VehicleLock
ESX.RegisterServerCallback('Core:requestPlayerCars', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local vehplate = plate:match('^%s*(.-)%s*$')
	MySQL.Async.fetchAll(
		'SELECT owned_vehicles.owner FROM owned_vehicles WHERE plate = @plate', 
		{
			['@plate'] = vehplate
		},
	function(result)
		if #result >= 1 then 
			if result[1].owner == xPlayer.identifier or result[1].owner == xPlayer.job.name or result[1].owner == xPlayer.job2.name then
				cb(true)
			end
		else
			cb(false)
		end
	end)
end)