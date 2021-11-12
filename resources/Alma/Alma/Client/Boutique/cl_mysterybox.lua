local index = {
    list = 1
}

local Button = 1

local Action = {
   'Visualiser',
   'Acheter'
}

function OpenMysteryBoxBoutique(ModernCoins)
    local BoutiqueSub = RageUI.CreateMenu('Boutique Alma', "Bienvenue sur notre boutique")
    RageUI.Visible(BoutiqueSub, not RageUI.Visible(BoutiqueSub))
    while BoutiqueSub do
        Citizen.Wait(0)
        RageUI.IsVisible(BoutiqueSub, function()
            if BoutiqueMysteryBox == nil or json.encode(BoutiqueMysteryBox) == '[]' then
                RageUI.Separator('')
                RageUI.Separator('Aucun articles')
                RageUI.Separator('')
            else
                for k,v in pairs(BoutiqueMysteryBox) do
                    RageUI.List(v.label, Action, index.list, v.description, {RightLabel = v.price}, true, {
                        onActive = function()
                            RageUI.RenderBox(k)
                        end,
                        onListChange = function(Index, Item)
                            index.list = Index;
                            Button = Index;
                        end,
                        onSelected = function()
                            if Button == 1 then
                                OpenMenuPreviewCaisse(v.model)
                            elseif Button == 2 then
                                variable = KeyboardInput('Veuillez confirmer l\'achat (~g~Oui~s~/~r~Non~s~)', ('Veuillez confirmer l\'achat (~g~Oui~s~/~r~Non~s~)'), '', 30)
                                if variable == 'OUI' or variable == 'oui' or variable:lower() == "oui" or variable:upper() == "OUI" then
                                    RageUI.CloseAll()
                                    AlmaUtils.toServer('Modern:process_checkout_case', v.model)
                                else
                                    ESX.ShowNotification('~r~Vous avez annulez l\'achat')
                                end
                            end
                        end
                    })
                end
            end
        end, function()
        end)

        if not RageUI.Visible(BoutiqueSub) then
            BoutiqueSub = RMenu:DeleteType('BoutiqueSub', true)
            TriggerEvent("Boutique:Open")
        end
    end
end

function OpenMenuPreviewCaisse(model)
    local CaissePreview = RageUI.CreateMenu('Boutique Alma', "Bienvenue sur notre boutique")
    RageUI.Visible(CaissePreview, not RageUI.Visible(CaissePreview))
    while CaissePreview do
        Citizen.Wait(0)
        RageUI.IsVisible(CaissePreview, function()
            if model == 3 then 
                caisselabel = '~y~Gold'
            elseif model == 2 then
                caisselabel = '~b~Diamond'
            elseif model == 1 then
                caisselabel = '~r~Ruby'
            else
                caisselabel = 'Caisse Temporaire'
            end
            RageUI.Separator('Prévisualisation de la caisse : '..caisselabel)
            for k,v in pairs(VisualitionCaisse[model]) do
                if v.rarity == 3 then
                    RageUI.Button(v.label, nil, {RightLabel = '~r~Mythique'}, true, {
                        onActive = function()
                            RageUI.RenderCaissePreview('vehicles', v.model)
                        end,
                        onSelected = function()
        
                        end
                    })
                end
            end
            for k,v in pairs(VisualitionCaisse[model]) do
                if v.rarity == 2 then
                    RageUI.Button(v.label, nil, {RightLabel = '~y~Rare'}, true, {
                        onActive = function()
                            RageUI.RenderCaissePreview('vehicles', v.model)
                        end,
                        onSelected = function()
        
                        end
                    })
                end
            end
            for k,v in pairs(VisualitionCaisse[model]) do
                if v.rarity == 1 then
                    RageUI.Button(v.label, nil, {RightLabel = '~w~Commun'}, true, {
                        onActive = function()
                            RageUI.RenderCaissePreview('vehicles', v.model)
                        end,
                        onSelected = function()
        
                        end
                    })
                end
            end
        end, function()
        end)

        if not RageUI.Visible(CaissePreview) then
            OpenMysteryBoxBoutique()
            CaissePreview = RMenu:DeleteType('BoutiqueSub', true)
        end
    end
end

-- OPENING CASE

local picture;

local mysterybox = RageUI.CreateMenu("Caisse Mystère", "Bonne chance !")

Alma.netRegisterAndHandle('ewen:caisseopenclientside', function(animations, name, message)
    RageUI.Visible(mysterybox, not RageUI.Visible(mysterybox))
    Alma.newThread(function()
        Citizen.Wait(250)
        for k, v in pairs(animations) do
            picture = v.name
            RageUI.PlaySound("HUD_FREEMODE_SOUNDSET", "NAV_UP_DOWN")
            if v.time == 5000 then
                RageUI.PlaySound("HUD_AWARDS", "FLIGHT_SCHOOL_LESSON_PASSED")
                ESX.ShowAdvancedNotification('Boutique', 'Informations', message, 'CHAR_CALIFORNIA', 6, 2)
                Wait(4000)
            end
            Citizen.Wait(v.time)
        end
    end)
end)

Alma.newThread(function()
    while (true) do
        Citizen.Wait(1.0)

        RageUI.IsVisible(mysterybox, function()

        end, function()
            if (picture) then
                RageUI.CaissePreviewOpen("vehicles", picture)
            end
        end)


    end
end)