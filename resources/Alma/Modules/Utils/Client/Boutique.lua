local revenir = false;

function SpawnVehicleLocally(modelName, coords, heading, cb)
    local model = GetHashKey(modelName)
    local ped       = GetPlayerPed(-1)
    Citizen.CreateThread(function()
        if model ~= last_vvv then
            SetEntityVisible(ped, false, 0)
            SetEntityCoords(ped, coords)
            DeleteVehicle(vehicle)
            ClearAreaOfVehicles(coords, 8.5, false, false, false, false, false) 
            if not HasModelLoaded(model) and IsModelInCdimage(model) then
                RequestModel(model)
                while not HasModelLoaded(model) do Citizen.Wait(1) end
            end
            local timeout = 0
            last_vvv = model
            vehicle = CreateVehicle(model, coords, heading, false, false)
            need_vehi = vehicle
            in_prev = true
            SetEntityAsMissionEntity(vehicle, true, false)
            SetVehicleHasBeenOwnedByPlayer(vehicle, true)
            SetVehicleNeedsToBeHotwired(vehicle, false)
            SetVehRadioStation(vehicle, 'OFF')
            SetModelAsNoLongerNeeded(last_vvv)
            TaskWarpPedIntoVehicle(ped, vehicle, -1)
            FreezeEntityPosition(vehicle, true)
            RequestCollisionAtCoord(coords.x, coords.y, coords.z)
            Wait(1000)

            while not HasCollisionLoadedAroundEntity(vehicle) do
                Citizen.Wait(0)
            end
        end
    end)
end

RegisterNetEvent("Spawn:VehicleBoutique")
AddEventHandler("Spawn:VehicleBoutique", function(car)
    local pos = GetEntityCoords(PlayerPedId(), false)
    local rot = 1.0
    SetEntityCoords(PlayerPedId(), -1815.3588867188, -724.98974609375, 8.6897211074829)
    veh = SpawnVehicleLocally(car, vector3(-1815.3588867188, -724.98974609375, 8.6897211074829), 122.0)
    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
    NetworkOverrideClockTime(16, 0, 0)
    while true do
        rot = rot - 0.15
        print(rot)
        print(veh)
        SetEntityRotation(veh, GetEntityPitch(veh), GetEntityRoll(veh), rot, 3, 1)
		SetEntityHeading(veh, rot)
        SetFollowPedCamViewMode(1)
        SetPedDesiredHeading(PlayerPedId(), 122.0)
        Wait(0)
        Visual.FloatingHelpText("Appuyer sur ~INPUT_CONTEXT~ pour stopper le shooting photo.", false)
        NetworkOverrideClockTime(16, 0, 0)
        SetEntityVisible(PlayerPedId(), false);
    end
end)

local HudTimer = 0