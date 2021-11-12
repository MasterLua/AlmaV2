local Timer = 0
local HudTimer = 0

HUD = {
    Speedometer = false
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local cGameTimer = GetGameTimer()

        if (HudTimer + 200 < cGameTimer) then
            HudTimer = cGameTimer
            if (GetVehiclePedIsIn(PlayerPedId(), false) ~= 0) and (Alma:GetPedVehicleSeat(PlayerPedId()) == -1) then
                if not (HUD.Speedometer) then
                    SendNUIMessage({
                        speedometer = 1,
                    })
                    HUD.Speedometer = true
                end
                if (HUD.Speedometer) then
                    local speed = math.ceil((GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * 3.6));
                    local fuel = GetVehicleFuelLevel(GetVehiclePedIsIn(PlayerPedId(), false))
                    local max = GetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(), false), 'CHandlingData', 'fPetrolTankVolume')
                    local current = math.round(fuel * 100 / max, 1);
                    SendNUIMessage({
                        speed = speed,
                        fuel = current
                    })
                end
            end
            if (GetVehiclePedIsIn(PlayerPedId(), false) == 0) then
                if (HUD.Speedometer) then
                    SendNUIMessage({
                        speedometer = 2,
                    })
                    HUD.Speedometer = false
                end
            end
        else
            Citizen.Wait(100)
        end
    end
end)