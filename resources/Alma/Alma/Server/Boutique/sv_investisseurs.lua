RegisterServerEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    local xPlayer = ESX.GetPlayerFromId(source)
    local license, fivem = GetAllSourceIdentifiers(xPlayer.source)
    MySQL.Async.fetchAll('SELECT * FROM alma_accounts WHERE steam = @steam',{
        ['@steam'] = license
    }, function(result)
        for k,v in pairs(result) do
            AlmaServerUtils.toClient('aBoutique:InvestisseursReview', xPlayer.source, v.investisseur)
        end
    end)
end)

local CounterInvestissement = {}
RegisterServerEvent('aBoutique:InvestisseurWin')
AddEventHandler('aBoutique:InvestisseurWin', function()
    if not CounterInvestissement[source] then
        CounterInvestissement[source] = {}
        CounterInvestissement[source] = 1
    else
        CounterInvestissement[source] = CounterInvestissement[source] +1
    end
    if CounterInvestissement[source] >= 2 then
        DropPlayer(source, 'Désynchronisation avec le serveur ou Cheat détecté')
        return
    end
    local xPlayer = ESX.GetPlayerFromId(source)
    local vip, investisseur = GetVIP(source)
    if investisseur == 1 then
        local ModernCoins = math.random(3,5)
        local license, fivemid = GetAllSourceIdentifiers(xPlayer.source)
        LiteMySQL:Insert('alma_wallet', {
            identifiers = fivemid,
            transaction = "Gain suite a ton Investissement",
            price = '0',
            currency = 'Points',
            points = ModernCoins,
        });
        TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Alma', "~y~Investissement", 'Félicitation tu as reçu : \n[~y~'..ModernCoins..'~w~] ~r~ModernCoins ~w~~n~Grâce à ton investissement', 'CHAR_CALIFORNIA', 7)
    end
end)

Alma.newThread(function()
    while true do 
        Wait(600000)
        CounterInvestissement = {}
    end
end)