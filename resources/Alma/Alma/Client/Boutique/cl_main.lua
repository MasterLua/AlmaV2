local ModernCoins = 0
local SetEntityRagdoll;

Alma.netRegisterAndHandle('EMS:ReviveClientPlayer', function()
	SetEntityRagdoll = false
	Alma.toServer('EMS:UpdateTableIsDead', false)
end)

function OpenBoutique()
    local BoutiqueMain = RageUI.CreateMenu('Boutique AlmaRP', "Bienvenue sur notre boutique")
    ESX.TriggerServerCallback('ewen:getPoints', function(result)
        ModernCoins = result
    end)
    RageUI.Visible(BoutiqueMain, not RageUI.Visible(BoutiqueMain))
    while BoutiqueMain do
        Citizen.Wait(0)
        RageUI.IsVisible(BoutiqueMain, function()
            RageUI.Button('Vos pulsion', "Les achats sur la boutique vous permet de soutenir le serveur est bien plus encore.", {RightLabel = ESX.Math.GroupDigits(ModernCoins)}, true, {})
            RageUI.Button('Historique', "Historique de vos achats sur la boutique en jeux", {}, true, {
                onSelected = function()
                    OpenHistoryMenu()
                end
            })
            RageUI.Separator('Catalogue')
            RageUI.Button('Armes', 'Equipe toi d\'armes afin de faire peur au autres groupes illégaux.', {RightLabel = ''}, true, {
                onSelected = function()
                    OpenBoutiqueWeapon(ModernCoins)
                end
            })
            RageUI.Button('Véhicules', nil, {RightLabel = ''}, true, {
                onSelected = function()
                    OpenBoutiqueVehicles(ModernCoins)
                end
            })
            RageUI.Button('Packs', nil, { }, true, {
                onSelected = function()
                    OpenBoutiquePack()
                end
            })
            RageUI.Button('Caisse Mystères', nil, {RightLabel = '~y~Nouveautés'}, true, {
                onSelected = function()
                    OpenMysteryBoxBoutique()
                end
            })
            -- RageUI.Button('Personnalisation d\'armes', '', { }, true, {
            --     onSelected = function()
            --         OpenCustomArmes()
            --     end
            -- })
            RageUI.Button("Full custom vehicule", "Cette option customise à 100% les performances de votre vehicule, attention, celui-ci s'applique dans le véhicule dans le quelle vous vous trouvez", { RightLabel = 1000, RightBadge = RageUI.BadgeStyle.Coins }, true, {
                onSelected = function()
                    if IsPedSittingInAnyVehicle(PlayerPedId()) then
                        variable = KeyboardInput('Veuillez confirmer l\'achat (~g~Oui~s~/~r~Non~s~)', ('Veuillez confirmer l\'achat (~g~Oui~s~/~r~Non~s~)'), '', 30)
                        if variable == 'OUI' or variable == 'oui' or variable:lower() == "oui" or variable:upper() == "OUI" then
                            local vehicle = GetVehiclePedIsUsing(PlayerPedId())
                            AlmaUtils.toServer('aBoutique:BuyCustomMax', vehicle)
                            RageUI.CloseAll()
                            Wait(150)
                        else
                            ESX.ShowNotification('~r~Vous avez annulez l\'achat')
                        end
                    else
                        ESX.ShowNotification('~r~Vous devez être a l\'intérieur d\'un véhicule.')
                    end
                end
            })
        end, function()
        end)

        if not RageUI.Visible(BoutiqueMain) then
            BoutiqueMain = RMenu:DeleteType('BoutiqueMain', true)
        end
    end
end

local IS_IN_SELECTING, IS_IN_PERSO = false, false

AddEventHandler('esx:onPlayerDeath', function()
    SetEntityRagdoll = true
end)

AddEventHandler("Alma:OnPlayerInitialised:Init", function()
    IS_IN_SELECTING = not IS_IN_SELECTING;
end)

RegisterCommand("f1", function()
    if not (IS_IN_SELECTING) and not (SetEntityRagdoll) and not (Alma.IsInJail) then
        OpenBoutique()
        TriggerEvent("Boutique:Open")
    end
end, false)
RegisterKeyMapping('f1', 'Menu Boutique', 'keyboard', 'f1')

function DrawMissionText(msg, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(msg)
    DrawSubtitleTimed(time and math.ceil(time) or 0, true)
end