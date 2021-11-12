Alma.netRegisterAndHandle('ewen:buyweapon', function(weapon, price, label)
    xPlayer = ESX.GetPlayerFromId(source)
    if SecurityWeapons[weapon] == nil then
        DropPlayer(xPlayer.source, 'Désynchronisation avec le serveur ou detection de Cheat')
        MomoLogs('https://discord.com/api/webhooks/898900704683520102/aqDweXzHiIrXM_YUk1YXB2WfSAQWDttwWYmLFbrrhwTxELsm4iSuZmDsxbmVnS6S4j2P', "Un Cheateur à été detecté","**"..GetPlayerName(xPlayer.source).."** à essayé d'acheter ***"..label.."***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : ['..price..'] ModernCoins', 56108)
        return
    end
    if SecurityWeapons[weapon].name ~= weapon or SecurityWeapons[weapon].price ~= price then
        DropPlayer(xPlayer.source, 'Désynchronisation avec le serveur ou detection de Cheat')
        MomoLogs('https://discord.com/api/webhooks/898900704683520102/aqDweXzHiIrXM_YUk1YXB2WfSAQWDttwWYmLFbrrhwTxELsm4iSuZmDsxbmVnS6S4j2P', "Un Cheateur à été detecté","**"..GetPlayerName(xPlayer.source).."** à essayé d'acheter ***"..label.."***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : ['..price..'] ModernCoins', 56108)
        return
    end
    OnProcessCheckout(xPlayer.source, SecurityWeapons[weapon].price, string.format("Achat object %s", label), function()
        xPlayer.addWeapon(SecurityWeapons[weapon].name, 250)
        MomoLogs('https://discord.com/api/webhooks/898902538009595984/6VS-a3KAYaEEDFmbQyBrfc8V-HMAL9MM-4O416Pj6ZcfZxGjGasA2D8Oxtfc2C7y9nwp', "Boutique - Achat","**"..GetPlayerName(xPlayer.source).."** vient d'acheter une ***"..label.."***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : ['..price..'] ModernCoins', 56108)
        Helper:showAdvancedNotification(xPlayer.source, "AlmaRP", "~y~Boutique", "~g~Félicitation~s~, vous avez acheter " .. SecurityWeapons[weapon].label .. " sur notre boutique !", "CHAR_CALIFORNIA", 9)
    end, function()
        xPlayer.showNotification("~r~Vous n'avez pas assez de Pulsion pour cet achat 😥 Vous avez besoin de "..SecurityWeapons[weapon].price.." Pulsion")
        return
    end)
end)