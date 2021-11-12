local active = false

RegisterNetEvent("Billing:AfficheBilling")
AddEventHandler("Billing:AfficheBilling", function(sender, amount, society)
    ESX.ShowNotification("~g~Facture\n~s~Vous avez reçu une facture de ~b~"..amount.."$~s~~s~.")
    ESX.ShowNotification("~g~Y~s~ : Accepter\n~r~N~s~ : Refuser")

    local amount = tonumber(amount)
    local time = 0
    active = true

    while active do 
        time = time + 1
        if IsControlJustPressed(0, 246) then -- Accept
            TriggerServerEvent("Billing:PayeBilling", "paye", sender, amount, society)
            active = false
            break
        end
        if IsControlJustPressed(0, 306) then -- Decline
            TriggerServerEvent("Billing:PayeBilling", "decline", sender, amount, society)
            active = false
            break
        end
        if time == 7000 then -- Time passed
            TriggerServerEvent("Billing:PayeBilling", "passed", sender, amount, society)
            active = false
            break
        end
        Wait(1)
    end
end)

RegisterCommand("billing", function(source, args)
    local Montant = args[1]
    TriggerServerEvent("Billing:AddBilling", 2, tonumber(Montant), ESX.PlayerData.job.name)
end, false)