local open = false

local MakeupMenu = RageUI.CreateMenu("Maquillage", "Catégories")
MakeupMenu.EnableMouse = true

MakeupMenu.Closed = function()   
    RageUI.Visible(MakeupMenu, false)
    open = false
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
    destroycam()
	ClearPedTasks(PlayerPedId())
end 

MakeUpShop = {
    makeup = {
        Index = 1
    },
    makeupercentage = 0,
    makeupcolor = {
        primary = { 1, 1 },
        secondary = { 1, 1 }
    },
    lipstick = {
        Index = 1
    },
    lipstickpercentage = 0,
    lipstickcolor = {
        primary = { 1, 1 },
        secondary = { 1, 1 }
    },
    eyebrow = {
        Index = 1
    },
    eyebrowpercentage = 0,
}

Citizen.CreateThread(function()
    for i=1, 71 do
        table.insert(MakeUpShop.makeup, i)
    end
    for i=1, 9 do
        table.insert(MakeUpShop.lipstick, i)
    end
    for i=1, 34 do
        table.insert(MakeUpShop.eyebrow, i)
    end
end)

function OpenMakeupMenu()
    if open then 
        open = false 
        RageUI.Visible(MakeupMenu,false)
        return
    else
        open = true 
        RageUI.Visible(MakeupMenu, true)

        Citizen.CreateThread(function ()
            while open do 
                RageUI.IsVisible(MakeupMenu, function()
                    RageUI.List("Maquillage", MakeUpShop.makeup, MakeUpShop.makeup.Index, nil, {}, true, {
                        onListChange = function(Index)
                            MakeUpShop.makeup.Index = Index;
                            TriggerEvent("skinchanger:change", "makeup_1", Index)
                        end
                    })
                    RageUI.List("Rouge à lèvre", MakeUpShop.lipstick, MakeUpShop.lipstick.Index, nil, {}, true, {
                        onListChange = function(Index)
                            MakeUpShop.lipstick.Index = Index;
                            TriggerEvent("skinchanger:change", "lipstick_1", Index)
                        end
                    })
                    RageUI.List("Sourcil", MakeUpShop.eyebrow, MakeUpShop.eyebrow.Index, nil, {}, true, {
                        onListChange = function(Index)
                            MakeUpShop.eyebrow.Index = Index;
                            TriggerEvent("skinchanger:change", "eyebrows_1", Index)
                        end
                    })
                    RageUI.Button('Valider et payer', false, { RightLabel = "", Color = { HightLightColor = { 0, 155, 0, 150 }, BackgroundColor = { 38, 85, 150, 160 } }}, true, {
                        onSelected = function()
                            TriggerServerEvent("BarberShop:Buy", open)
                            Wait(180)
                            destroycam()
                            ClearPedTasks(PlayerPedId())
                            MakeupMenu.Closed()
                        end
                    })
                    RageUI.Separator("Prix du Make Up: ~g~75$")
                    RageUI.PercentagePanel(MakeUpShop.makeupercentage, 'Opacité', '0%', '100%', {
                        onProgressChange = function(Percentage)
                            MakeUpShop.makeupercentage = Percentage
                            TriggerEvent('skinchanger:change', 'makeup_2', Percentage*10)
                        end
                    }, 1) 
                    RageUI.ColourPanel("Couleur principale", RageUI.PanelColour.MakeUp, MakeUpShop.makeupcolor.primary[1], MakeUpShop.makeupcolor.primary[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)
                            MakeUpShop.makeupcolor.primary[1] = MinimumIndex
                            MakeUpShop.makeupcolor.primary[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "makeup_3", MakeUpShop.makeupcolor.primary[2] - 1)
                        end
                    }, 1)
                    RageUI.ColourPanel("Couleur secondaire", RageUI.PanelColour.MakeUp, MakeUpShop.makeupcolor.secondary[1], MakeUpShop.makeupcolor.secondary[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)
                            MakeUpShop.makeupcolor.secondary[1] = MinimumIndex
                            MakeUpShop.makeupcolor.secondary[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "makeup_4", MakeUpShop.makeupcolor.secondary[2] - 1)
                        end
                    }, 1)
                    RageUI.PercentagePanel(MakeUpShop.lipstickpercentage, 'Opacité', '0%', '100%', {
                        onProgressChange = function(Percentage)
                            MakeUpShop.lipstickpercentage = Percentage
                            TriggerEvent('skinchanger:change', 'lipstick_2', Percentage*10)
                        end
                    }, 2) 
                    RageUI.ColourPanel("Couleur principale", RageUI.PanelColour.HairCut, MakeUpShop.lipstickcolor.primary[1], MakeUpShop.lipstickcolor.primary[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)
                            MakeUpShop.lipstickcolor.primary[1] = MinimumIndex
                            MakeUpShop.lipstickcolor.primary[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "lipstick_3", MakeUpShop.lipstickcolor.primary[2] - 1)
                        end
                    }, 2)
                    RageUI.ColourPanel("Couleur secondaire", RageUI.PanelColour.HairCut, MakeUpShop.lipstickcolor.secondary[1], MakeUpShop.lipstickcolor.secondary[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)
                            MakeUpShop.lipstickcolor.secondary[1] = MinimumIndex
                            MakeUpShop.lipstickcolor.secondary[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "lipstick_4", MakeUpShop.lipstickcolor.secondary[2] - 1)
                        end
                    }, 2)
                    RageUI.PercentagePanel(MakeUpShop.eyebrowpercentage, 'Opacité', '0%', '100%', {
                        onProgressChange = function(Percentage)
                            MakeUpShop.eyebrowpercentage = Percentage
                            TriggerEvent('skinchanger:change', 'eyebrows_2', Percentage*10)
                        end
                    }, 3)                
                end)
                Wait(0)
            end
        end)
    end
end 