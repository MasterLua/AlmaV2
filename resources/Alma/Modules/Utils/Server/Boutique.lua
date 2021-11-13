RegisterCommand("boutiqueveh", function(source, args, rawCommand)
    local car = args[1];

    if car ~= nil then
        local source = source;
        local xPlayer = ESX.GetPlayerFromId(source);

        if xPlayer.getGroup() == "fondateur" then
            TriggerClientEvent("Spawn:VehicleBoutique", source, car)
        else
            xPlayer.showNotification("~r~Vous n'avez pas les droits pour cette action !");
        end
    end
end, false)