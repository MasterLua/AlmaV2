RegisterKeyMapping("asso", "Ouvrir le menu d'action", "keyboard", "F6")

RegisterCommand("asso", function(source, args, rawCommand)
    AssoMenu()
end, false)


PermissionJob = {
    ["police"] = {
        handcuff = true,
        billing = true,
        porter = true,
        fouiller = true,
        pound = true,
        taskwarp_vehicle = true
    }
}

ConfigJob = {
    ["police"] = {
        service = false,
        name = "Police",
        job = "police",
        skin = ""
    }
}

local PlayerData = {}

AddEventHandler("esx:playerLoaded", function(player)
    PlayerData = player
end)


function AssoMenu()
    local assoMenu = RageUI.CreateMenu("Association", "Menu d'action")
    local IndexAsso = 1;

    RageUI.Visible(assoMenu, not RageUI.Visible(assoMenu))

    while assoMenu do
        Citizen.Wait(0)
        RageUI.IsVisible(assoMenu, function()
            RageUI.List("Que voulez-vous gérer ?", {
                { Name = "Organisation", Value = 1 },
                { Name = "Entreprise (Job)", Value = 2 }
            }, IndexAsso, nil, {}, true, {
                onListChange = function(Index, Item)
                    IndexAsso = Index
                end,
                onSelected = function()

                end
            })
            Helper:Switch(IndexAsso, {
                [1] = function()
                    RageUI.Separator("")
                end,
                [2] = function()
                    RageUI.Checkbox("Prendre son service", nil, ConfigJob[PlayerData.job.name].service, {}, {
                        onChecked = function()
                            ConfigJob[PlayerData.job.name].service = true
                            Alma:TriggerServerEvent("Jobs", "Join", PlayerData.job.name)
                        end,
                        onUnChecked = function()
                            ConfigJob[PlayerData.job.name].service = false
                            Alma:TriggerServerEvent("Jobs", "Leave", PlayerData.job.name)
                        end,
                        onSelected = function(Index)
                            ConfigJob[PlayerData.job.name].service = Index
                        end
                    })
                    
                    if ConfigJob[PlayerData.job.name].service then
                        if PermissionJob[PlayerData.job.name].handcuff ~= nil then
                            RageUI.Button("Menotter", nil, {}, true, {
                                onSelected = function()
                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                                        Alma:TriggerServerEvent("Jobs", "Handcuff", PlayerData.job.name, GetPlayerServerId(closestPlayer))
                                    else
                                        ESX.ShowNotification("Aucun joueur à proximité")
                                    end
                                end
                            })
                        end
                        if PermissionJob[PlayerData.job.name].billing ~= nil then
                            RageUI.Button("Facturer", nil, {}, true, {
                                onSelected = function()
                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                                        Alma:TriggerServerEvent("Jobs", "Billing", PlayerData.job.name, GetPlayerServerId(closestPlayer))
                                    else
                                        ESX.ShowNotification("Aucun joueur à proximité")
                                    end
                                end
                            })
                        end
                    -- if ze.porter ~= nil then
                    --     RageUI.Button(ze.porter == true and "Escorter" or "Dé-escorter", nil, {}, true, {
                    --         onSelected = function()
                    --             ze.porter = not ze.porter
                    --             local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    --             if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    --                 Alma:TriggerServerEvent("Jobs", "Porter", ConfigJob[PlayerData.job.name].job, GetPlayerServerId(closestPlayer))
                    --             else
                    --                 ESX.ShowNotification("Aucun joueur à proximité")
                    --             end
                    --         end
                    --     })
                    -- end
                    if PermissionJob[PlayerData.job.name].annonce ~= nil then
                        RageUI.Button("Faire une annonce", nil, {}, true, {
                            onSelected = function()
                                local input = KeyboardInput("Announce", "", 100, false)
                                ExecuteCommand("askannonce "..input)
                            end
                        })
                    end
                    if PermissionJob[PlayerData.job.name].fouiller ~= nil then
                        RageUI.Button("Fouiller", nil, {}, true, {
                            onSelected = function()
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                                    Alma:TriggerServerEvent("Jobs", "Fouiller", PlayerData.job.name, GetPlayerServerId(closestPlayer))
                                else
                                    ESX.ShowNotification("Aucun joueur à proximité")
                                end
                            end
                        })
                    end
                    if PermissionJob[PlayerData.job.name].pound ~= nil then
                        RageUI.Button("Mettre en fourière", nil, {}, true, {
                            onSelected = function()
                                local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 5.0, 0, 70)
                                if vehicle ~= -1 then
                                    Alma:TriggerServerEvent("Jobs", "Pound", PlayerData.job.name, vehicle)
                                else
                                    ESX.ShowNotification("Aucun véhicule à proximité")
                                end
                            end
                        })
                        end
                    end
                end
            })
        end)
        if not RageUI.Visible(assoMenu) then
            assoMenu = RMenu:DeleteType("assoMenu", true)
        end
    end
end

Alma:AddEventHandler("Jobs", "Fouiller", function(data)
    local menu = RageUI.CreateMenu("Fouiller", "Fouiller")
    RageUI.Visible(menu, not RageUI.Visible(menu))
    while menu do
        Citizen.Wait(0)
        RageUI.IsVisible(menu, function()
            for k,v in pairs(data) do
                RageUI.Button(ze.label, nil, {RightLabel = ze.count}, true, {
                    onSelected = function()
                        
                    end
                })
            end
        end)
        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType("menu", true)
        end
    end
end)

Alma:AddEventHandler("Jobs", "Handcuff", function()
    Alma.isCuffed = not Alma.isCuffed
end)

Alma:AddEventHandler("Jobs", "TaskWarpPedIntoVehicle", function()
    local plyPed = PlayerPedId()
	local coords = GetEntityCoords(plyPed, false)

	if IsPedSittingInAnyVehicle(plyPed) then
        Alma.isCuffed = false
        DetachEntity(plyPed, true, false)
        local vehicle = GetVehiclePedIsIn(plyPed, false)
        TaskLeaveVehicle(plyPed, vehicle, 16)
	end

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
			local freeSeat = nil

			for i = maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat ~= nil then
				Alma.isCuffed = false
				DetachEntity(plyPed, true, false)
				TaskWarpPedIntoVehicle(plyPed, vehicle, freeSeat)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local plyPed = PlayerPedId()

		if Alma.isCuffed then
			local target = GetPlayerFromServerId(Alma.isCuffed)

			if target ~= PlayerId() and target > 0 then
				local targetPed = GetPlayerPed(target)

				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(plyPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					Alma.isCuffed = false
					DetachEntity(plyPed, true, false)
				end
			else
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end
end)