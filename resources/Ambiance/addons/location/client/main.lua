---@author Pablo Z.
---@version 1.0
--[[
  This file is part of Astra RolePlay.
  
  File [main] created at [21/04/2021 14:59]

  Copyright (c) Astra RolePlay - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local cat, desc = "locationvehicle", "~y~Location - Alma RolePlay"
local isWaitingServerResponse = false
local antiCanceller = false
local spawnHeading = 245.0
local availableSpawns = {
    vector3(-255.80024719238,-337.8264465332,29.828227996826),
    vector3(-255.62243652344,-342.91592407227,29.876005172729),
    vector3(-254.56460571289,-348.78945922852,29.889610290527),
    vector3(-253.23239135742,-355.55438232422,29.918474197388),
    vector3(-251.41107177734,-359.96875,29.890316009521),
}
local sub = function(str)
    return cat .. "_" .. str
end

Astra.netRegisterAndHandle("locationCb", function(model)
    if model then
        AstraClientUtils.toServer("setOnPublicBucket")
        Astra.newWaitingThread(500, function()
            model = GetHashKey(model)
            local vehicle = CreateVehicle(model, availableSpawns[math.random(1,#availableSpawns)], spawnHeading, true, false)
            SetVehicleEngineOn(vehicle, 1, 1, 0)
            SetVehicleCustomPrimaryColour(vehicle, 33,33,33)
            SetVehicleCustomSecondaryColour(vehicle, 33,33,33)
            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        end)
    end
    isWaitingServerResponse = false
end)

Astra.netRegisterAndHandle("locationOpenMenu", function(available, accounts)
    if menuIsOpened then
        return
    end

    if isWaitingServerResponse then
        ESX.ShowNotification("~r~Une transaction est encore en cours avec le serveur...")
        return
    end

    if antiCanceller then
        return
    end

    local isLocationLoaded = false
    local selectedCarId = nil
    FreezeEntityPosition(PlayerPedId(), true)
    menuIsOpened = true
    AstraClientUtils.toServer("genPlayerBucket")

    RMenu.Add(cat, sub("main"), RageUI.CreateMenu("Location", desc, nil, nil, "commonmenu", "interaction_bgd"))
    RMenu:Get(cat, sub("main")).Closable = false
    RMenu:Get(cat, sub("main")).Closed = function()
    end

    RMenu.Add(cat, sub("pay"), RageUI.CreateSubMenu(RMenu:Get(cat, sub("main")), "Location", desc, nil, nil, "commonmenu", "interaction_bgd"))
    RMenu:Get(cat, sub("pay")).Closed = function()
    end

    RageUI.Visible(RMenu:Get(cat, sub("main")), true)
    local cam, previewVeh
    Astra.newThread(function()
        for k,v in pairs(available) do
            local model = GetHashKey(v.model)
            RequestModel(model)
            while not HasModelLoaded(model) do Wait(1) end
        end
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
        SetCamCoord(cam, -254.05429077148,-343.04272460938,29.792343139648)
        PointCamAtCoord(cam, -254.05429077148,-343.04272460938,29.792343139648)
        SetCamActive(cam, true)
        RenderScriptCams(1, 1500, 1500, 1)
        PointCamAtCoord(cam, -254.05429077148,-343.04272460938,29.792343139648)
        Astra.newWaitingThread(1500, function()
            previewVeh = CreateVehicle(available[1].model, -255.80024719238,-337.8264465332,29.828227996826, 90.0, false, false)
            SetVehicleCustomPrimaryColour(previewVeh, 33,33,33)
            SetVehicleCustomSecondaryColour(previewVeh, 33,33,33)
            SetVehicleEngineOn(previewVeh, 1, 1, 0)
            SetEntityAlpha(previewVeh,200)
            SetVehicleUndriveable(previewVeh, true)
            FreezeEntityPosition(previewVeh, true)
            isLocationLoaded = true
            RMenu:Get(cat, sub("main")).Closable = true
        end)
    end)
    Astra.newThread(function()
        while menuIsOpened do
            if isLocationLoaded and previewVeh ~= nil then
                SetEntityHeading(previewVeh, GetEntityHeading(previewVeh)+0.5)
            end
            Wait(1)
        end
    end)

    Astra.newThread(function()
        while menuIsOpened do
            local shouldStayOpened = false
            local function tick()
                shouldStayOpened = true
            end
            RageUI.IsVisible(RMenu:Get(cat, sub("main")), true, true, true, function()
                tick()
                if isLocationLoaded then
                    RageUI.Separator("↓ ~y~Véhicules disponibles ~s~↓")
                    for id, v in pairs(available) do
                        RageUI.ButtonWithStyle(("→ ~b~%s"):format(v.label), "Appuyez pour louer ce véhicule", { RightLabel = ("~g~%s$ ~s~→→"):format(ESX.Math.GroupDigits(v.price)) }, accounts[1] >= v.price or accounts[2] >= v.price, function(_, a, s)
                            if a then
                                if GetEntityModel(previewVeh) ~= GetHashKey(v.model) then
                                    DeleteEntity(previewVeh)
                                    previewVeh = CreateVehicle(GetHashKey(v.model), -255.80024719238,-337.8264465332,29.828227996826, 90.0, false, false)
                                    SetVehicleCustomPrimaryColour(previewVeh, 33,33,33)
                                    SetVehicleCustomSecondaryColour(previewVeh, 33,33,33)
                                    SetVehicleEngineOn(previewVeh, 1, 1, 0)
                                    SetEntityAlpha(previewVeh,200)
                                    SetVehicleUndriveable(previewVeh, true)
                                    FreezeEntityPosition(previewVeh, true)
                                end
                            end
                            if s then
                                selectedCarId = id
                            end
                        end, RMenu:Get(cat, sub("pay")))
                    end
                else
                    RageUI.Separator("")
                    RageUI.Separator(("%sChargement..."):format(AstraGameUtils.warnVariator))
                    RageUI.Separator("")
                end
            end, function()
            end)

            RageUI.IsVisible(RMenu:Get(cat, sub("pay")), true, true, true, function()
                tick()
                RageUI.Separator("↓ ~y~Sélectionnez un moyen de paiement ~s~↓")
                RageUI.ButtonWithStyle("→ Payer en ~b~liquide", nil, {}, accounts[1] >= available[selectedCarId].price and not isWaitingServerResponse, function(_, _, s)
                    if s then
                        shouldStayOpened = false
                        isWaitingServerResponse = true
                        AstraClientUtils.toServer("locationPayCar", selectedCarId, 1)
                    end
                end)
                RageUI.ButtonWithStyle("→ Payer en ~y~banque", nil, {}, accounts[2] >= available[selectedCarId].price and not isWaitingServerResponse, function(_, _, s)
                    if s then
                        shouldStayOpened = false
                        isWaitingServerResponse = true
                        AstraClientUtils.toServer("locationPayCar", selectedCarId, 2)
                    end
                end)

            end, function()
            end)

            if not shouldStayOpened and menuIsOpened then
                menuIsOpened = false
            end
            Wait(0)
        end
        RMenu:Delete(cat, sub("main"))
        RMenu:Delete(cat, sub("pay"))
        antiCanceller = true
        RenderScriptCams(0, 1500,1500,0)
        Astra.newWaitingThread(1500, function()
            AstraClientUtils.toServer("setOnPublicBucket")
            FreezeEntityPosition(PlayerPedId(), false)
            antiCanceller = false
        end)
        if previewVeh ~= nil then
            DeleteEntity(previewVeh)
        end
        SetCamActive(cam, false)
    end)
end)