Alma.netRegisterAndHandle('aBoutique:BuyVehicle', function(model, price, label)
    local source = source;
    if SecurityVehicles[model] == nil then 
        DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
        MomoLogs('https://discord.com/api/webhooks/898900704683520102/aqDweXzHiIrXM_YUk1YXB2WfSAQWDttwWYmLFbrrhwTxELsm4iSuZmDsxbmVnS6S4j2P', "Un Cheateur à été detecté","**"..GetPlayerName(source).."** à essayé d'acheter ***"..label.."***\n**License** : "..xPlayer.identifier.. '\nPrix de l\'achat : ['..price..'] Pulsion', 56108)
        return
    end
    if SecurityVehicles[model].model == model and SecurityVehicles[model].price == price then
        local xPlayer = ESX.GetPlayerFromId(source)
            OnProcessCheckout(source, SecurityVehicles[model].price, string.format("Achat véhicule %s", label), function()
                local plate = CreateRandomPlateText()
                LiteMySQL:Insert('owned_vehicles', {
                    owner = xPlayer.identifier,
                    plate = plate,
                    label = label,
                    vehicle = json.encode({ model = GetHashKey(model), plate = plate }),
                    type = 'car',
                    state = 1,
                    boutique = 1,
                })
                Helper:showAdvancedNotification(source, "Informations AlmaRP", "~y~Boutique", "~g~Félicitation~s~, vous avez acheter " .. label .. " sur notre boutique !", "CHAR_ESTATE_AGENT", 9)
                MomoLogs('https://discord.com/api/webhooks/898901061509718047/Z3Y514_0i9EQk2J-65dN6BAhwRdD6bWy6iaxRBrblAIBmZP-m19OcOb2_VmKs4FD3zet', "Boutique - Véhicules","Nom : ".. GetPlayerName(xPlayer.source).. '\nIdentifier : '.. xPlayer.identifier .. '\nA acheté un véhicule\nVéhicule obtenu : **'..label..'**\nPlaque d\'immatriculation : '.. plate, 56108)
        end, function()
            return
        end)
    else
        DropPlayer(source, 'Désynchronisation avec le serveur ou detection de Cheat')
    end
end)

RegisterCommand('givevehicule', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getGroup() == 'fondateur' then
        local plate = CreateRandomPlateText()
        LiteMySQL:Insert('owned_vehicles', {
            owner = xPlayer.identifier,
            plate = plate,
            label = args[1],
            vehicle = json.encode({ model = GetHashKey(args[1]), plate = plate }),
            type = args[2],
            state = 1,
        })
    end
end)