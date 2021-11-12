ESX.RegisterServerCallback("Bank:Account", function(source, cb)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);
    local accountlocal = xPlayer.getAccount("bank").money
    cb(accountlocal)
end)

Alma:AddEventHandler("Bank", "Deposit", function(amount)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);
    local accountlocal = tonumber(xPlayer.getAccount("money").money)
    local amount = tonumber(amount)

    if accountlocal >= amount then
        xPlayer.showNotification("~g~Transaction effectuée, vous avez déposer "..ESX.Math.GroupDigits(amount).." $ sur votre compte bancaire !")
        xPlayer.removeAccountMoney("money", amount)
        xPlayer.addAccountMoney("bank", amount)
    else
        xPlayer.showNotification("~r~Pour effectuer une telle transaction, il vous manque "..ESX.Math.GroupDigits(amount-accountlocal).." $ !")
    end
end)

Alma:AddEventHandler("Bank", "Withdraw", function(amount)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);
    local accountlocal = tonumber(xPlayer.getAccount("bank").money)
    local amount = tonumber(amount)

    if accountlocal >= amount then
        xPlayer.showNotification("~g~Transaction effectuée, vous avez retirer "..ESX.Math.GroupDigits(amount).." $ de votre compte bancaire !")
        xPlayer.removeAccountMoney("bank", amount)
        xPlayer.addAccountMoney("money", amount)
    else
        xPlayer.showNotification("~r~Pour effectuer une telle transaction, il vous manque "..ESX.Math.GroupDigits(amount-accountlocal).." $ !")
    end
end)