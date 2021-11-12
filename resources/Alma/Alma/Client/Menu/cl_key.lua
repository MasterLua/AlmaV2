local function OpenCloseVehicleEntreprise()
    local coords = GetEntityCoords(PlayerPedId(), false)
	local VehUse = GetVehiclePedIsIn(PlayerPedId()) ~= 0 and GetVehiclePedIsIn(PlayerPedId()) or GetClosestVehicle(coords, 7.0, 0, 71)
	if VehUse ~= 0 then
    	TaskPlayAnim(playerPed, "anim@mp_player_intmenu@key_fob@", "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
		ESX.TriggerServerCallback('Core:requestPlayerCars', function(isOwnedVehicle)
			if isOwnedVehicle then
				local locked = GetVehicleDoorLockStatus(VehUse)
				if locked == 1 then -- if unlocked
					SetVehicleDoorsLocked(VehUse, 2)	
					ESX.ShowAdvancedNotification("Informations Alma", "Véhicule", "Vous avez ~r~fermé~s~ le véhicule.", "CHAR_CALIFORNIA", 8)
                    ExecuteCommand('me ferme le véhicule')
				elseif locked == 2 then -- if locked
					SetVehicleDoorsLocked(VehUse, 1)
					ESX.ShowAdvancedNotification("Informations Alma", "Véhicule", "Vous avez ~g~ouvert~s~ le véhicule.", "CHAR_CALIFORNIA", 8)
                    ExecuteCommand('me ouvre le véhicule')
				end
				SetVehicleLights(VehUse, 2)
				Wait(200)
				SetVehicleLights(VehUse, 0)
				StartVehicleHorn(VehUse, 100, 1, false)
				Wait(200)
				SetVehicleLights(VehUse, 2)
				Wait(400)
				SetVehicleLights(VehUse, 0)
			else
				ESX.ShowNotification("~r~Vous n'avez pas les clés de ce véhicule.")
			end
		end, GetVehicleNumberPlateText(VehUse))
	end
end

RegisterCommand("vehicule_lock", function()
    OpenCloseVehicleEntreprise()
end, false)
RegisterKeyMapping("vehicule_lock", "Ouvrir/Fermer Véhicule", "keyboard", 'U')