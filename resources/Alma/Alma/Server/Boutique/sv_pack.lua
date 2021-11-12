Alma.netRegisterAndHandle('aBoutique:Entreprise', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local license, fivem = GetAllSourceIdentifiers(xPlayer.source)
    OnProcessCheckout(source, 5000, string.format("Achat de Pack Entreprise"), function()
        xPlayer.showNotification('Vous avez acquis le Pack Entreprise pour 5000 ~y~AlmaCoins\nFaites un ticket sur Discord')
        MomoLogs('https://discord.com/api/webhooks/898900766197182544/gMQaKqbUyLPC_0_Uln-xLJRgA-Nlft2PTjaqDqgiWinZqCC8n197PyibCcGMCObHXY9m', "Boutique - Achat","**"..GetPlayerName(xPlayer.source).."** vient d'acheter un ***Pack Entreprise***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : [5000] ModernCoins', 56108)       
    end, function()
        return
    end)
end)

Alma.netRegisterAndHandle('aBoutique:Illegal', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local license, fivem = GetAllSourceIdentifiers(xPlayer.source)
    OnProcessCheckout(source, 5000, string.format("Achat de Pack Illégal"), function()
        xPlayer.showNotification('Vous avez acquis le Pack Illégal pour 5000 ~y~AlmaCoins\nFaites un ticket sur Discord')
        MomoLogs('https://discord.com/api/webhooks/898900827392069642/huHn5z6tObvKh8Z0i557aQKfBMOSNu_ipuXy-tlPSlHML_Pwm4UQdBfOSeaa0QUS3D3Z', "Boutique - Achat","**"..GetPlayerName(xPlayer.source).."** vient d'acheter un ***Pack Illégal***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : [5000] ModernCoins', 56108)       
    end, function()
        return
    end)
end)

Alma.netRegisterAndHandle('aBoutique:buyInvestisseur', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local license, fivem = GetAllSourceIdentifiers(xPlayer.source)
    OnProcessCheckout(source, 5000, string.format("Achat de Pack Investisseur"), function()
        MySQL.Async.execute('UPDATE alma_accounts SET `investisseur` = @investisseur WHERE steam = @steam', {
            ['@steam'] = license,
            ['@investisseur'] = 1,
        })
        xPlayer.showNotification('Vous avez acquis le Pack Investissement pour 5000 ~y~AlmaCoins')
        MomoLogs('https://discord.com/api/webhooks/898901001778634803/_0VbCGHR5UI2wnoOad5GBwsubnH8S3rGZ6ycF2SmaggXurvDlvAVRfrfYtFKC81Ekcem', "Boutique - Achat","**"..GetPlayerName(xPlayer.source).."** vient d'acheter un ***Pack Investisseur***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : [5000] ModernCoins', 56108)       
    end, function()
        return
    end)
end)

Alma.netRegisterAndHandle('aBoutique:BuyCustomMax', function(vehicle)
    local xPlayer = ESX.GetPlayerFromId(source)
    local license, fivem = GetAllSourceIdentifiers(xPlayer.source)
    OnProcessCheckout(source, 1000, string.format("Achat de Pack Customisation"), function()
        AlmaServerUtils.toClient('aBoutique:BuyCustomMaxClient', xPlayer.source, vehicle)
        xPlayer.showNotification('Vous avez acquis le Pack Customisation pour 1000 ~y~AlmaCoins')
        MomoLogs('https://discord.com/api/webhooks/898900893427195914/QSEtRo8QBg-gawmcyva_Cgt9ERrVP4gqCyUNmYuHb1--I-T0vMzNnOFXRrsWzkXu__d5', "Boutique - Achat","**"..GetPlayerName(xPlayer.source).."** vient d'acheter un ***Pack Customisation***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : [1000] ModernCoins', 56108)    
    end, function()
        return
    end)
end)

Alma.netRegisterAndHandle('Boutique:BuyCustomMax', function(vehicle)
    local xPlayer = ESX.GetPlayerFromId(source)
    local license, fivem = GetAllSourceIdentifiers(xPlayer.source)
    if xPlayer.getGroup() == "fondateur" then
        AlmaServerUtils.toClient('aBoutique:BuyCustomMaxClient', xPlayer.source, vehicle)
        xPlayer.showNotification('Vous avez acquis le Pack Customisation pour 1000 ~y~AlmaCoins')
        MomoLogs('https://discord.com/api/webhooks/898900893427195914/QSEtRo8QBg-gawmcyva_Cgt9ERrVP4gqCyUNmYuHb1--I-T0vMzNnOFXRrsWzkXu__d5', "Boutique - Achat","**"..GetPlayerName(xPlayer.source).."** vient d'acheter un ***Pack Customisation***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : [1000] ModernCoins', 56108)    
    end
end)