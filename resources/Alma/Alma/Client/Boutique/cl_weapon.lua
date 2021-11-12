function OpenBoutiqueWeapon(ModernCoins)
    local BoutiqueSub = RageUI.CreateMenu('Boutique Modern', "Bienvenue sur notre boutique")
    RageUI.Visible(BoutiqueSub, not RageUI.Visible(BoutiqueSub))
    while BoutiqueSub do
        Citizen.Wait(0)
        RageUI.IsVisible(BoutiqueSub, function()
            if WeaponBoutique == nil or json.encode(WeaponBoutique) == '[]' then
                RageUI.Separator('')
                RageUI.Separator('Aucun articles')
                RageUI.Separator('')
            else
                for k,v in pairs(WeaponBoutique) do
                   RageUI.Button(v.label, v.description, {RightLabel = v.price, RightBadge = RageUI.BadgeStyle.Coins}, true, {
                       onActive = function()
                           RageUI.RenderWeapons("vehicles", v.name)
                       end,
                       onSelected = function()
                           variable = KeyboardInput('Veuillez confirmer l\'achat (~g~Oui~s~/~r~Non~s~)', ('Veuillez confirmer l\'achat (~g~Oui~s~/~r~Non~s~)'), '', 30)
                           if variable == 'OUI' or variable == 'oui' or variable:lower() == "oui" or variable:upper() == "OUI" then
                               AlmaUtils.toServer('ewen:buyweapon', v.name, v.price, v.label)
                               RageUI.CloseAll()
                               Wait(150)
                           else
                               ESX.ShowNotification('~r~Vous avez annulez l\'achat')
                           end
                       end
                   })
                end
            end
        end, function()
        end)

        if not RageUI.Visible(BoutiqueSub) then
            OpenBoutique()
            BoutiqueSub = RMenu:DeleteType('BoutiqueSub', true)
        end
    end
end