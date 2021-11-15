RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source)
    local SelectingPlayer = {};
    MySQL.Async.fetchAll("SELECT firstname, lastname, sex, accounts, dateofbirth FROM users WHERE identifier = @selecting", {
        ["@selecting"] = xPlayer.identifier
    }, function(result)
        if #result > 0 then
            for k,v in pairs(result) do
                local account = json.decode(v.accounts)
                table.insert(SelectingPlayer, ({id = v.id, firstname = v.firstname, lastname = v.lastname, sex = v.sex, dateofbirth = v.dateofbirth, cash = json.encode(account.money), bank = json.encode(account.bank), dirtycash = json.encode(account.black_money)}))
                Alma:TriggerClientEvent("OnPlayerInitialised", "Init", source, SelectingPlayer)        
            end
        else
            Alma:TriggerClientEvent("OnPlayerInitialised", "Init", source, nil)
        end
    end)
end)

Alma:AddEventHandler("Character", "SelectedCharacter", function(boolean)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);
    -- Alma:TriggerClientEvent("Player", "CharacterSelected", source)
    if (boolean) then
        TriggerEvent('esx:playerLoaded', source, xPlayer, false)
        TriggerClientEvent("openCreator", source, true);
        TriggerEvent("Init:Inventory", source, xPlayer)
    else
        TriggerEvent('esx:playerLoaded', source, xPlayer, false)
        Helper:showAdvancedNotification(source, "Informations AlmaRP", "Personnage", "Vous avez été replacé a votre ancienne position !", "CHAR_CALIFORNIA", 3)
        TriggerEvent("Alma:VerifyJail", source)
        TriggerEvent("Init:Inventory", source, xPlayer)
    end
end)