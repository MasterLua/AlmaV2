local LastVeh = nil
local InVehicle = false
local VehicleTestLastTime = 0
local VehicleToTest = nil
local Action = {
    { Name = '~b~Visualiser~s~', Value = 1 },
    { Name = "~g~Acheter~s~", Value = 2 },
    { Name  = "~p~Tester~s~", Value = 3 }
 }
 
function OpenBoutiqueVehicles(ModernCoins)
    local BoutiqueSub = RageUI.CreateMenu('Boutique Alma', "Bienvenue sur notre boutique")
    local lastPos = GetEntityCoords(PlayerPedId())
    local ActionIndex = 2;
    local rot = 1.0
    local stoped = false;
    local actual = nil
    local spw = false
    if VehicleToTest then return ESX.ShowNotification("Vous ne pouvez pas ouvrir le menu en test !") end
    RageUI.Visible(BoutiqueSub, not RageUI.Visible(BoutiqueSub))
    while BoutiqueSub do
        Citizen.Wait(0)
        RageUI.IsVisible(BoutiqueSub, function()
                RageUI.List("Filtre:", Action, ActionIndex, nil, {}, true, {
                   onActive = function()
                       if inveh then
                           if (GetVehiclePedIsIn(PlayerPedId(), false) == 0) then
                               TaskWarpPedIntoVehicle(PlayerPedId(), LastVeh, -1)
                           end
                       end
                   end,
                   onListChange = function(Index, Item)
                       if not GetSafeZone() and Index == 1 then 
                           return ESX.ShowNotification("Pour passer en mode ("..Item.Name..") vous devez être en safezone !") 
                       end
                       if not GetSafeZone() and Index == 3 then 
                        return ESX.ShowNotification("Pour passer en mode ("..Item.Name..") vous devez être en safezone !") 
                    end
                       if ActionIndex == 1 then
                           if not GetSafeZone() then
                               SetEntityCoords(PlayerPedId(), lastPos)
                           end
                       end
                       ActionIndex = Index;
                       if ActionIndex == 2 then
                           SetFollowPedCamViewMode(1)
                       end
                       if LastVeh ~= nil then 
                           DeleteEntity(LastVeh)
                           if not GetSafeZone() then
                               SetEntityCoords(PlayerPedId(), lastPos)
                           end
                       end
                   end, 
                })
                for k,v in pairs(BoutiqueVehicles) do
                   if ActionIndex == 1 then
                      RageUI.Button(v.label, "Nom : " .. v.label .. "\nPrix en pulsion : ~r~"..ESX.Math.GroupDigits(tonumber(v.price)), { }, true, {
                          onActive = function()
                              RageUI.RenderSixt("vehicles", v.model)
                              if inveh then
                                  Visual.Subtitle("~r~Veuillez ne pas sortir du véhicule !", 1)
                                   if (GetVehiclePedIsIn(PlayerPedId(), false) == 0) then
                                       TaskWarpPedIntoVehicle(PlayerPedId(), LastVeh, -1)
                                   end
                               end
                           end,
                           onSelected = function()
                               AlmaUtils.toServer('BoutiqueBucket:SetEntitySourceBucket', true)
                               if not inveh then
                                   SetEntityCoords(PlayerPedId(), 919.4124, -78.3551, 78.1370)
                               end
                               ESX.Game.SpawnVehicle(v.model, vector3(919.4124, -78.3551, 78.1370), 355.858, function(vehicle)
                                   DeleteEntity(LastVeh)
                                   TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                   LastVeh = vehicle
                                   inveh = true
                                   FreezeEntityPosition(vehicle, true)
                                   SetVehicleDoorsLocked(vehicle, 2)
                                   SetEntityInvincible(vehicle, true)
                                   SetVehicleFixed(vehicle)
                                   SetVehicleDirtLevel(vehicle, 0.0)
                                   SetVehicleEngineOn(vehicle, true, true, true)
                                   SetVehicleLights(vehicle, 2)
                                   SetVehicleDoorsLockedForPlayer(vehicle, PlayerPedId(), true)
                                   SetVehicleCustomPrimaryColour(vehicle, 33,33,33)
                                   SetVehicleCustomSecondaryColour(vehicle, 33,33,33)
                                   actual = v.label
                               end)
                           end
                       })
                   elseif ActionIndex == 2 then
                    RageUI.Button(v.label, "Nom : " .. v.label .. "\nPrix en pulsion : ~r~"..ESX.Math.GroupDigits(tonumber(v.price)), {}, true, {
                           onActive = function()
                               RageUI.RenderSixt("vehicles", v.model)
                           end,
                           onSelected = function()
                               variable = KeyboardInput('Veuillez confirmer l\'achat (~g~Oui~s~/~r~Non~s~)', ('Veuillez confirmer l\'achat (~g~Oui~s~/~r~Non~s~)'), '', 30)
                               if variable == 'OUI' or variable == 'oui' or variable:lower() == "oui" or variable:upper() == "OUI" then
                                   AlmaUtils.toServer('aBoutique:BuyVehicle', v.model, v.price, v.label)
                                   RageUI.CloseAll()
                               else
                                   ESX.ShowNotification('~r~Vous avez annulez l\'achat')
                               end
                           end
                       })
                   else
                       RageUI.Button(v.label, "Nom : " .. v.label .. "\nPrix en pulsion : ~r~"..ESX.Math.GroupDigits(tonumber(v.price)), {}, true, {
                           onSelected = function()
                                if not VehicleToTest then
                                    posVeh = GetEntityCoords(PlayerPedId())
                                    if not inveh then
                                        SetEntityCoords(PlayerPedId(), 919.4124, -78.3551, 78.1370)
                                    end
                                    AlmaUtils.toServer('BoutiqueBucket:SetEntitySourceBucket', true)
                                    Wait(400)
                                    ESX.Game.SpawnVehicle(v.model, vector3(919.4124, -78.3551, 78.1370), 355.858, function(vehicle)
                                        inveh = true
                                        VehicleToTest = true
                                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                        SetEntityAlpha(vehicle, 98)
                                        EnableTestVehicle(vehicle);
                                    end)
                                end
                           end
                       })
                   end
               end
        end, function()
        end)
        if not RageUI.Visible(BoutiqueSub) and not VehicleToTest then
           if ActionIndex == 1 then
               if not stoped then
                   DeleteEntity(LastVeh)
                   FreezeEntityPosition(PlayerPedId(), false)
                   SetEntityVisible(PlayerPedId(), true, 0)
                   SetEntityCoords(PlayerPedId(), lastPos)
                   SetFollowPedCamViewMode(1)
                   NetworkOverrideClockTime(16, 0, 0)
                   inveh = false
               end
           end
           if not stoped then
               AlmaUtils.toServer('BoutiqueBucket:SetEntitySourceBucket', false)
               stoped = true
           end
           BoutiqueSub = RMenu:DeleteType('BoutiqueSub', true)
           TriggerEvent("Boutique:Open")
           OpenBoutique()
        end
    end
end
 
function EnableTestVehicle(veh)
    local HasVehicle = true
    local timeInVehicle = 30;
    Citizen.CreateThread(function()
        while HasVehicle do
            Citizen.Wait(1000)
            if DoesEntityExist(veh) and not GetVehiclePedIsIn(PlayerPedId(), false) ~= 0 then
                TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)        
            end
            timeInVehicle = timeInVehicle - 1
            Visual.Subtitle("~h~Il vous reste ~y~".. timeInVehicle.."~s~ secondes d'essaie avec ce véhicule !", 1000)
            if (timeInVehicle <= 0) then
                HasVehicle = false
                DeleteVehicle(entity)
                SetEntityCoords(PlayerPedId(), posVeh)
                ESX.ShowNotification("Votre essaie de véhicule est terminé !")
                AlmaUtils.toServer('BoutiqueBucket:SetEntitySourceBucket', false)
                RageUI.CloseAll();
                VehicleToTest = false
            end
        end
    end)
end