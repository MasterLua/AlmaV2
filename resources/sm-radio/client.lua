---@diagnostic disable: undefined-global
local pma = exports["pma-voice"]
local currentChannel = 0
local hasRadio = true

local ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('::{korioz#0110}::esx:getSharedObject', function(obj) ESX = obj end)
        Wait(10)
    end
end)

function SetDisplay(s) 
    SetNuiFocus(s, s)
    SendNUIMessage({type="display", status=s})
end

function displayradio()
    if not hasRadio then
        ESX.ShowNotification("Vous n'avez pas de ~r~radio~s~ sur vous.")
        return 
    end
    SetDisplay(true)
end

--@class Keys
Keys = {};

---Register
---@param Controls string
---@param ControlName string
---@param Description string
---@param Action function
---@return Keys
---@public
function Keys.Register(Controls, ControlName, Description, Action)
    local _Keys = {
        CONTROLS = Controls
    }
    RegisterKeyMapping(string.format('rageui-%s', ControlName), Description, "keyboard", Controls)
    RegisterCommand(string.format('rageui-%s', ControlName), function(source, args)
        if (Action ~= nil) then
            Action();
        end
    end, false)
    return setmetatable(_Keys, Keys)
end

---Exists
---@param Controls string
---@return boolean
function Keys:Exists(Controls)
    return self.CONTROLS == Controls and true or false
end

Keys.Register('F2','Openradio', 'Sortir / Ranger la radio', function()
    if not IsPedSwimming(PlayerPedId()) and not IsPedSwimmingUnderWater(PlayerPedId()) then
        displayradio()
    end
end)

RegisterNUICallback('close', function()
    SetDisplay(false)
end)

RegisterNUICallback('joinChannel', function(data)
    local channel = tonumber(data.channel)
	local PlayerData = ESX.GetPlayerData(_source)
    local restricted = {}
	
	if channel > 200 then
		return
	end
	
    for i,v in pairs(Config.jobChannels) do
        if channel >= v.min and channel <= v.max then
            table.insert(restricted, v)
        end
    end

    if #restricted > 0 then
        for i,v in pairs(restricted) do
            if PlayerData.job.name == v.job and channel >= v.min and channel <= v.max then
                pma:setRadioChannel(channel)
                ESX.ShowNotification('~g~Radio ~w~Connexion a la fréquence ' ..channel.. ' effectuer.')
                currentChannel = channel
                break
            elseif i == #restricted then
                ESX.ShowNotification('~g~Radio ~w~Echec de la connexion a la fréquence')
                break
            end
        end
    else
        pma:setRadioChannel(channel)
        ESX.ShowNotification('~g~Radio ~w~Connexion a la fréquence ~r~' ..channel.. ' ~w~effectuer.')
        currentChannel = channel
    end
end)

RegisterNUICallback('leaveChannel', function()
    pma:setRadioChannel(0)
    currentChannel = 0

    ESX.ShowNotification('~g~Radio ~w~Déconnexion a la fréquence ~r~' ..channel.. ' ~w~effectuer.')
end)

RegisterNUICallback('setVolume', function(data)
    for i,v in pairs(GetActivePlayers()) do
        pma:setRadioVolume(data.volume)
    end
end)

pma:setRadioVolume(0.99)
pma:setVoiceProperty("radioEnabled", true)
pma:setRadioChannel(currentChannel)