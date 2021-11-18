local lockpicking = false
local lock_won = nil
local lock_go = nil

RegisterNUICallback('callback', function(data, cb)
    openLockpick(false)

    lock_won = data.success
    lock_go = data.go

    cb('ok')
end)

RegisterNUICallback('exit', function()
    openLockpick(false)
end)

RegisterCommand("stop_ui", function(source, args, rawCommand)
	SetNuiFocus(false, false)
	SendNUIMessage({
        action = "ui",
        toggle = false
    })
end)

ProcessKeyStroke = function(callback)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "ui",
        toggle = true,
        typ = action,
    })
    SetCursorLocation(0.5, 0.2)
    lockpicking = true

    while lockpicking do Citizen.Wait(100) end
    callback(lock_won)
end

openLockpick = function(bool, action)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        toggle = bool,
        typ = action,
    })
    SetCursorLocation(0.5, 0.2)
    lockpicking = bool
end

function startWelcomeLogos(lNumber, lBool, lFadeIn, lFadeOut)
    SendNUIMessage({
        type = 'logo',
        show = lBool,
        logoNumber = lNumber,
        logoFadeIn = lFadeIn,
        logoFadeOut = lFadeOut,
    })
end

function startnewLogo(bool)
    SendNUIMessage({
        type = 'permanent',
        show = bool,
    })
end

Citizen.CreateThread(function()
    Wait(250)
    SendNUIMessage({
        type = 'logo_disable_all',
    })
    SendNUIMessage({
        type = 'permanent',
        show = false,
    })
end)

function removeAllWelcomeLogos()
    SendNUIMessage({
        type = 'logo_disable_all',
    })
end

AddEventHandler("KeyStroke:Start", ProcessKeyStroke)