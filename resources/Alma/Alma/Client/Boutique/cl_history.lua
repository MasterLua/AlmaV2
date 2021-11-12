local History = {}

function OpenHistoryMenu()
    local BoutiqueSub = RageUI.CreateMenu('Boutique Alma', "Bienvenue sur notre boutique")
    ESX.TriggerServerCallback('ewen:getHistory', function(result)
        History = result;
    end)
    RageUI.Visible(BoutiqueSub, not RageUI.Visible(BoutiqueSub))
    while BoutiqueSub do
        Citizen.Wait(0)
        RageUI.IsVisible(BoutiqueSub, function()
            if #History > 0 then
                for k,v in pairs(History) do
                    local description;
                    if (tonumber(v.price) == 0) then
                        description = string.format("%s\n\nNombre de points : %s", v.transaction, v.points)
                    else
                        description = string.format("%s\n\n%s (%s %s)", v.transaction, v.points, v.price, v.currency);
                    end
                    RageUI.Button(tonumber(v.price) == 0 and "Gain / Achat" or "Transaction N°".. v.id, description, { }, true, {
                        onSelected = function()

                        end,
                    });
                end
            else
                RageUI.Separator("Aucun transaction effectues.")
            end
        end, function()
        end)

        if not RageUI.Visible(BoutiqueSub) then
            TriggerEvent("Boutique:Open")
            OpenBoutique()
            BoutiqueSub = RMenu:DeleteType('BoutiqueSub', true)
        end
    end
end

local HistoryLoaded = false

Alma.netRegisterAndHandle('ewen:retrieveHistoryClient', function(Table)
    history = Table
    HistoryLoaded = true
    oepnHistoryTebex()
end)

function oepnHistoryTebex()
    local menu = RageUI.CreateMenu('Historique du joueur', "Voici son historique")
    menu:SetSizeWidth(99)
    RageUI.Visible(menu, not RageUI.Visible(menu))
    while menu do
        Citizen.Wait(0)
        RageUI.IsVisible(menu, function()
            for k,v in pairs(history) do
                
                if tonumber(v.price) ~= 0 then
                    RageUI.Button(v.transaction .. ' ['..v.points..'] -> AlmaCoins', 'Date d\'achat : ~b~'..v.expiration, {RightLabel = v.price..'€'}, true, {
                        onSelected = function()
                        end
                    })
                else
                    RageUI.Button(v.transaction, 'Date d\'achat : ~b~'..v.expiration, {RightLabel = v.points..' AlmaCoins'}, true, {
                        onSelected = function()
                        end
                    })
                end
            end
        end, function()
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end