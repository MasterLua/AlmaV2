local Type = {
    { Name = "Voiture", Value = "car"},
    { Name = "Avion", Value = "aircraft" }
}

Alma:AddEventHandler("Garage", "AddVehicle", function()
    PatronMenu()
end)

function defineorNot(str)
    if str ~= nil then
        return "Défini"
    else
        return 'Non Défini'
    end
end

function PatronMenu()
    local patronicMenu = RageUI.CreateMenu("Ajout", "DE VEHICULES SUR JOUEURS")
    local put, put2, string1, string2, INDEXFDP = true, true, nil, nil, 1
    patronicMenu.TitleFont = 2;

    RageUI.Visible(patronicMenu, not RageUI.Visible(patronicMenu))
    
    while patronicMenu do
        Citizen.Wait(0)
        RageUI.IsVisible(patronicMenu, function()
            RageUI.Button("Joueur seléctionné", "Votre réponse doit être un ~HUD_COLOUR_NET_PLAYER22~ID", { RightLabel = defineorNot(string1) }, put, {
                onSelected = function()
                    string1 = KeyboardInput('Réponse', ('Réponse (ex: 1, 2)'), '', 999)
                    put = false
                    --print(string1)
                end
            })
            RageUI.Button("~r~Redéfinir", nil, {}, true, {
                onSelected = function()
                    put = true
                end
            })
            RageUI.Button("Voiture seléctionné", "Votre réponse doit être un ~HUD_COLOUR_NET_PLAYER22~Model de voiture telle que rmodrs6, adder", { RightLabel = defineorNot(string2) }, put2, {
                onSelected = function()
                    string2 = KeyboardInput('Réponse', ('Réponse (ex: rmodrs6, adder)'), '', 999)
                    if string2 ~= nil then
                        put2 = false
                    else
                        ESX.ShowHelpNotification("Votre réponse est ~r~incorrect")
                    end
                end
            })
            RageUI.Button("~r~Redéfinir", nil, {}, true, {
                onSelected = function()
                    put2 = true
                end
            })
            if not put and not put2 then
                RageUI.List("Type de véhicule", {
                { Name = "Voiture", Value = "car" },
                { Name = "Avions", Value = "aircraft"},
                }, INDEXFDP, nil, {}, true, {
                    onListChange = function(Index, Item)
                        INDEXFDP = Index;
                        if Item.Value == "car" then
                            select_type = "car"
                            ESX.ShowNotification("Voiture ~g~seléctionné !")
                        elseif Item.Value == "aircraft" then
                            select_type = "aircraft"
                            ESX.ShowNotification("Avion ~g~seléctionné !")
                        end
                    end,
                    onSelected = function()

                    end
                })
            end
            if not put and not put2 and select_type then
                RageUI.Button("~g~Confirmer", nil, {}, true, {
                    onSelected = function()
                        put = true
                        put2 = true
                        TriggerServerEvent("Authentic:AddVehToClient", string1, string2, select_type)
                        RageUI.CloseAll()
                        string1 = nil
                        string2 = nil
                    end
                })
            end
        end)
        if not RageUI.Visible(patronicMenu) then
            patronicMenu = RMenu:DeleteType('patronicMenu', true)
        end
    end
end