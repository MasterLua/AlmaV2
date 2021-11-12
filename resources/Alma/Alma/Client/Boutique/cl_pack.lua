function OpenBoutiquePack(ModernCoins)
    local BoutiqueSub = RageUI.CreateMenu('Boutique Alma', "Bienvenue sur notre boutique")
    RageUI.Visible(BoutiqueSub, not RageUI.Visible(BoutiqueSub))
    while BoutiqueSub do
        Citizen.Wait(0)
        RageUI.IsVisible(BoutiqueSub, function()
            RageUI.Button('Pack Entreprise', 'Créer une entreprise de Farm\nGere tes employés\nGénère de l\'argent et deviens le plus riche !', {RightLabel = 5000}, true, {
                onSelected = function()
                    variable = KeyboardInput('Veuillez confirmer l\'achat (~g~Oui~s~/~r~Non~s~)', ('Veuillez confirmer l\'achat (~g~Oui~s~/~r~Non~s~)'), '', 30)
                    if variable == 'OUI' or variable == 'oui' or variable:lower() == "oui" or variable:upper() == "OUI" then
                        AlmaUtils.toServer('aBoutique:Entreprise')
                        RageUI.CloseAll()
                        Wait(150)
                    else
                        ESX.ShowNotification('~r~Vous avez annulez l\'achat')
                    end
                end
            })
            RageUI.Button('Pack Illégal', 'Créer un(e) Gang/Organisation\nGere tes membres\nDeviens le/la plus gros(se) criminel(le) de la ville !', {RightLabel = 5000}, true, {
                onSelected = function()
                    variable = KeyboardInput('Veuillez confirmer l\'achat (~g~Oui~s~/~r~Non~s~)', ('Veuillez confirmer l\'achat (~g~Oui~s~/~r~Non~s~)'), '', 30)
                    if variable == 'OUI' or variable == 'oui' or variable:lower() == "oui" or variable:upper() == "OUI" then
                        AlmaUtils.toServer('aBoutique:Illegal')
                        RageUI.CloseAll()
                        Wait(150)
                    else
                        ESX.ShowNotification('~r~Vous avez annulez l\'achat')
                    end
                end
            })
        end, function()
        end)

        if not RageUI.Visible(BoutiqueSub) then
            TriggerEvent("Boutique:Open")
            OpenBoutique()
            BoutiqueSub = RMenu:DeleteType('BoutiqueSub', true)
        end
    end
end

Alma.netRegisterAndHandle('aBoutique:BuyCustomMaxClient', function(veh)
    FullCustom(veh)
end)

function FullCustom(veh)
	SetVehicleModKit(veh, 0)
	ToggleVehicleMod(veh, 18, true)
	ToggleVehicleMod(veh, 22, true)
	SetVehicleMod(veh, 16, 5, false)
	SetVehicleMod(veh, 12, 2, false)
	SetVehicleMod(veh, 11, 3, false)
	SetVehicleMod(veh, 14, 14, false)
	SetVehicleMod(veh, 15, 3, false)
	SetVehicleMod(veh, 13, 2, false)
	SetVehicleWindowTint(veh, 5)
	SetVehicleWheelType(veh, false)
	SetVehicleMod(veh, 23, 21, true)
	SetVehicleMod(veh, 0, 1, false)
	SetVehicleMod(veh, 1, 1, false)
	SetVehicleMod(veh, 2, 1, false)
	SetVehicleMod(veh, 3, 1, false)
	SetVehicleMod(veh, 4, 1, false)
	SetVehicleMod(veh, 5, 1, false)
	SetVehicleMod(veh, 6, 1, false)
	SetVehicleMod(veh, 7, 1, false)
	SetVehicleMod(veh, 8, 1, false)
	SetVehicleMod(veh, 9, 1, false)
	SetVehicleMod(veh, 10, 1, false)
	SetVehicleModKit(veh, 0)
	ToggleVehicleMod(veh, 20, true)
	SetVehicleModKit(veh, 0)
	SetVehicleNumberPlateTextIndex(veh, true)
    myCar = ESX.Game.GetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), false))
	TriggerServerEvent('esx_lscustom:refreshOwnedVehicle', myCar, token)
end