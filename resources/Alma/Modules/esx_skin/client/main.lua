local lastSkin, cam, isCameraActive
local firstSpawn, zoomOffset, camOffset, heading, skinLoaded = true, 0.0, 0.0, 90.0, false

function CreateSkinCam()
    if not DoesCamExist(cam) then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    end

    local playerPed = PlayerPedId()

    SetCamActive(cam, true)
    RenderScriptCams(true, true, 500, true, true)

    isCameraActive = true
    SetCamCoord(cam, GetEntityCoords(playerPed))
    SetCamRot(cam, 0.0, 0.0, 270.0, true)
    SetEntityHeading(playerPed, 0.0)
end

function DeleteSkinCam()
    isCameraActive = false
    SetCamActive(cam, false)
    RenderScriptCams(false, true, 500, true, true)
    cam = nil
end

function OpenSaveableMenu(submitCb, cancelCb, restrict)
    TriggerEvent('skinchanger:getSkin', function(skin) lastSkin = skin end)

    OpenMenu(function(data, menu)
        menu.close()
        DeleteSkinCam()

        TriggerEvent('skinchanger:getSkin', function(skin)
            Alma.Serv('esx_skin:save', skin)

            if submitCb ~= nil then
                submitCb(data, menu)
            end
        end)

    end, cancelCb, restrict)
end

AddEventHandler('esx_skin:resetFirstSpawn', function()
    firstSpawn = true
    skinLoaded = false
    ESX.PlayerLoaded = false
end)

AddEventHandler('esx_skin:playerRegistered', function()
    Citizen.CreateThread(function()
        while not ESX.PlayerLoaded do
            Citizen.Wait(100)
        end

        if firstSpawn then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                if skin == nil then
                    TriggerEvent('skinchanger:loadSkin', {sex = 0}, OpenSaveableMenu)
                    Citizen.Wait(100)
                    skinLoaded = true
                else
                    TriggerEvent('skinchanger:loadSkin', skin)
                    Citizen.Wait(100)
                    skinLoaded = true
                end
            end)

            firstSpawn = false
        end
    end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerLoaded = true
end)

AddEventHandler('esx_skin:getLastSkin', function(cb) cb(lastSkin) end)
AddEventHandler('esx_skin:setLastSkin', function(skin) lastSkin = skin end)

RegisterNetEvent('esx_skin:openMenu')
AddEventHandler('esx_skin:openMenu', function(submitCb, cancelCb)
    OpenMenu(submitCb, cancelCb, nil)
end)

RegisterNetEvent('esx_skin:openRestrictedMenu')
AddEventHandler('esx_skin:openRestrictedMenu', function(submitCb, cancelCb, restrict)
    OpenMenu(submitCb, cancelCb, restrict)
end)

RegisterNetEvent('esx_skin:openSaveableMenu')
AddEventHandler('esx_skin:openSaveableMenu', function(submitCb, cancelCb)
    OpenSaveableMenu(submitCb, cancelCb, nil)
end)

RegisterNetEvent('esx_skin:openSaveableRestrictedMenu')
AddEventHandler('esx_skin:openSaveableRestrictedMenu', function(submitCb, cancelCb, restrict)
    OpenSaveableMenu(submitCb, cancelCb, restrict)
end)

RegisterNetEvent('esx_skin:requestSaveSkin')
AddEventHandler('esx_skin:requestSaveSkin', function()
    TriggerEvent('skinchanger:getSkin', function(skin)
        Alma.Serv('esx_skin:responseSaveSkin', skin)
    end)
end)