local open = false
local BarberMenu = RageUI.CreateMenu("BarberShop", "Catégories")
BarberMenu.EnableMouse = true
BarberMenu.Closed = function()
    RageUI.Visible(BarberMenu, false)
    open = false
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)  
end

local BarberSettings = {
    Coiffure = 1,
    Barbe = 1,
    OpaPercent = 0,
    ColorCheveux = {
        primary = { 1, 1 },
        secondary = { 1, 1 }
    },
    ColorBarbes = {
        primary = { 1, 1 },
    },
}

RegisterNetEvent('BarberShop:SaveSkin')
AddEventHandler('BarberShop:SaveSkin', function()
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerServerEvent('esx_skin:save', skin)
    end)
end)

function OpenBarberMenu()
    if open then 
        open = false 
        RageUI.Visible(BarberMenu,false)
        return
    else
        open = true 
        RageUI.Visible(BarberMenu, true)
        Citizen.CreateThread(function ()
            while open do 
                RageUI.IsVisible(BarberMenu, function()
                    RageUI.List('Liste des coiffures :', {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74"}, BarberSettings.Coiffure, nil, {}, true, {
                        onListChange = function(Index)
                            BarberSettings.Coiffure = Index
                            TriggerEvent("skinchanger:change", "hair_1", BarberSettings.Coiffure)
                        end
                    })
                    RageUI.List('Liste des barbes :', {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74"}, BarberSettings.Barbe, nil, {}, true, {
                        onListChange = function(Index)
                            BarberSettings.Barbe = Index
                            TriggerEvent("skinchanger:change", "beard_1", BarberSettings.Barbe)
                        end
                    })
                    RageUI.Button("Valider et payer" , false, { Color = { BackgroundColor = { 0, 140, 0, 160 } } }, true, {
                        onSelected = function()
                            TriggerServerEvent("BarberShop:Buy", open)
                            Wait(1800)
                            BarberMenu.Closed()
                        end
                    })
                    RageUI.Separator('Prix du coiffeur : ~g~75$')
                    RageUI.ColourPanel("Couleur principale", RageUI.PanelColour.HairCut, BarberSettings.ColorCheveux.primary[1], BarberSettings.ColorCheveux.primary[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)
                            BarberSettings.ColorCheveux.primary[1] = MinimumIndex
                            BarberSettings.ColorCheveux.primary[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "hair_color_1", BarberSettings.ColorCheveux.primary[2])
                        end
                    }, 1)
                    RageUI.ColourPanel("Couleur secondaire", RageUI.PanelColour.HairCut, BarberSettings.ColorCheveux.secondary[1], BarberSettings.ColorCheveux.secondary[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)
                            BarberSettings.ColorCheveux.secondary[1] = MinimumIndex
                            BarberSettings.ColorCheveux.secondary[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "hair_color_2", BarberSettings.ColorCheveux.secondary[2])
                        end
                    }, 1)
                    RageUI.PercentagePanel(BarberSettings.OpaPercent, 'Opacité', '0%', '100%', {
                        onProgressChange = function(Percentage)
                            BarberSettings.OpaPercent = Percentage
                            TriggerEvent('skinchanger:change', 'beard_2',Percentage*10)
                        end
                    }, 2) 
                    RageUI.ColourPanel("Couleur de barbe", RageUI.PanelColour.HairCut, BarberSettings.ColorBarbes.primary[1], BarberSettings.ColorBarbes.primary[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)
                            BarberSettings.ColorBarbes.primary[1] = MinimumIndex
                            BarberSettings.ColorBarbes.primary[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "beard_3", BarberSettings.ColorBarbes.primary[2])
                        end
                    }, 2)
                end)
                Wait(0)
            end
        end)
    end
end














