Alma:AddEventHandler("BMA", "DropItem", function(value)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source)
    for i = 1, #TABLE_BDA, 1 do
        if value == TABLE_BDA[i].value then
            if xPlayer.getAccount("black_money").money >= TABLE_BDA[i].price then
                xPlayer.addWeapon(value, 300)
                xPlayer.removeAccountMoney("black_money", TABLE_BDA[i].price)
            else
                xPlayer.showNotification("~r~Vous n'avez pas assez d'argent Sale (Requis: "..TABLE_BDA[i].price..") !")
            end
        end
    end
end)

Alma:AddEventHandler("BMA", "SellItem", function(value)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source)
    for i = 1, #TABLE_BDA do
        if value == TABLE_BDA[i].value then
            local item = xPlayer.getWeapon(value)
            if item then
                xPlayer.removeWeapon(value, int)
                xPlayer.addAccountMoney("black_money", TABLE_BDA[i].price / 2)
            else
                xPlayer.showNotification("~r~Vous n'avez pas de "..value)
            end
        end
    end
end)