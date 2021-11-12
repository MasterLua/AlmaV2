PedsConfiguration = {
    { name = "", model = "", index = 1 }
}

--
--@type function
--
function RageUI:PedsMenu()
    local PEDS_MENU = RageUI.CreateMenu("Menu Peds", "Menu Peds")
    PEDS_MENU.TitleFont = 2;

    RageUI.Visible(PEDS_MENU, not RageUI.Visible(PEDS_MENU))

    while (PEDS_MENU) do
        Citizen.Wait(0)
        RageUI.IsVisible(PEDS_MENU, function()
            for k,v in pairs(Alma.PedsMenu()) do
                RageUI.List(v.name, {"Mettre", "Enlever"}, v.index, { RightBadge = RageUI.BadgeStyle.Tick }, true, {
                    onListChange = function(Index, Item)
                        v.index = Index;
                    end,
                    onSelected = function()
                        if Index == 1 then
                        else
                            TriggerEvent("skinchanger:getSkin", function(skin)
                                TriggerEvent("skinchanger:loadSkin", skin)
                                ESX.ShowNotification("~g~Vous aver remis votsre personnage de défaut !")
                            end)
                        end
                    end
                })
            end
        end)
        if not RageUI.Visible(PEDS_MENU) then
            PEDS_MENU = RMenu:DeleteType("PEDS_MENU", true) --@stop thread of menu
        end
    end
end


Alma.PedsMenu = function()
    return PedsConfiguration
end