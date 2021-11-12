local limitateurActive = false;

RegisterKeyMapping('limitateur-speed', 'Limitateur de vitesse', 'keyboard', 'H')

RegisterCommand("limitateur-speed", function(source, args, rawCommand)
    if GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 then
        if not limitateurActive then
            local menu_persoVehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
            local menu_persoCruise = GetEntitySpeed(menu_persoVehicle)
            SetEntityMaxSpeed(menu_persoVehicle, menu_persoCruise)
            menu_persoCruise = math.floor(menu_persoCruise * 3.6 + 0.5)
            Visual.Subtitle("~h~AlmaRP : ~y~Limitateur fixé à "..tonumber(menu_persoCruise).."km/h", 3000)
            limitateurActive = true
        else
            local menu_persoVehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
            local menu_persoMaxSpeed = GetVehicleHandlingFloat(menu_persoVehicle, "CHandlingData", "fInitialDriveMaxFlatVel")
            SetEntityMaxSpeed(menu_persoVehicle, menu_persoMaxSpeed)
            limitateurActive = false
            Visual.Subtitle("~h~AlmaRP : ~r~Limitateur désactivé !", 3000)
        end
    else
        Visual.Subtitle("~r~Vous devez être dans un véhicule pour limiter votre vitesse !", 1000)
    end
end, false)