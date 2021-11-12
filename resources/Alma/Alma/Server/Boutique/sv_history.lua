ESX.RegisterServerCallback('ewen:getHistory', function(source, callback)
    local identifier = GetIdentifiers(source);
    if (identifier['fivem']) then
        local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
        local count, result = LiteMySQL:Select('alma_wallet'):Where('identifiers', '=', after):Get();
        if (result ~= nil) then
            callback(result)
        else
            print('[Exceptions] retrieve category is nil')
            callback({ })
        end
    end
end)

RegisterCommand('history', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'fondateur' then
        if args[1] ~= nil then
            openHistory(source, args[1])
        else
            xPlayer.showNotification('Vous devez mettre une ID')
        end
    end
end)

function openHistory(source, player)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = GetIdentifiers(player);
    local HistoryAT = {}
    if (identifier['fivem']) then
        local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
        local count, result = LiteMySQL:Select('alma_wallet'):Where('identifiers', '=', after):Get();
        if (result ~= nil) then
            for i = 1, #result do
                HistoryAT[i] = {}
                HistoryAT[i].identifers = result[i].identifiers
                HistoryAT[i].transaction = result[i].transaction
                HistoryAT[i].price = result[i].price
                HistoryAT[i].currency = result[i].currency
                HistoryAT[i].points = result[i].points
            end
            AlmaServerUtils.toClient('ewen:retrieveHistoryClient', source, HistoryAT)
        else
            xPlayer.showNotification('Cette personne n\'a pas de FiveM lier')
        end
    end
end