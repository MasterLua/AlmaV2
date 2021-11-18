ESX = nil

TriggerEvent("esx:getSharedObject", function(obj)
    ESX = obj
end)

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(ze)
    local pLevel = exports["Ambiance"]:XNL_GetCurrentPlayerLevel()
    local AEE = {}
    for k,v in pairs(ze.accounts) do
        AEE[v.name] = v.money
    end
	Wait(500)
    SendNUIMessage({
        initialise = true,
        money = tonumber(AEE["money"]),
        dirtymoneyinfo = tonumber(AEE["black_money"]),
        bankbalanceinfo = tonumber(AEE["bank"]),
        job = ze.job.label.." | ",
        jobrank = ze.job.grade_label,
        crewrank = ze.job2.grade_label,
        crew = ze.job2.label.." | ",
        rank = tonumber(pLevel),
        name = GetPlayerName(PlayerId()).." | "..pLevel,
    })
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(rslt, g)
	SendNUIMessage({
		jobinfo = ESX.GetPlayerData().job.label,
		jobrank = ESX.GetPlayerData().job.grade_label,
	})
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(rslt, g)
	SendNUIMessage({
		crewinfo = ESX.GetPlayerData().job2.label,
		crewrank = ESX.GetPlayerData().job2.grade_label,
	})
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(rslt)
    for k,v in pairs(ESX.GetPlayerData().accounts) do
        if v.name == "money" then
            SendNUIMessage({
                moneyinfo = ESX.Math.GroupDigits(v.money)
            })
        elseif v.name == "bank" then
            SendNUIMessage({
                bankbalanceinfo = v.money
            })
        elseif v.name == "dirtycash" then
            SendNUIMessage({
                dirtymoneyinfo = v.money
            })
        end
    end
end)

local hud = true
RegisterNetEvent("Alma:HudToogle")
AddEventHandler("Alma:HudToogle", function()
	hud = not hud
	SendNUIMessage({ 
		hud = hud
	})
end)

RegisterNetEvent("Alma:HudToogles")
AddEventHandler("Alma:HudToogles", function(toogl)
	hud = toogl
	SendNUIMessage({ 
		hud = toogl
	})
end)


Citizen.CreateThread(function()
    Wait(500)
    TriggerEvent("Alma:HudToogles", false)
	while true do

		if hud then
			SendNUIMessage({ 
				hud = not IsPauseMenuActive()
			})
		end

		Citizen.Wait(500)
	end
    while true do
        local level = exports["Ambiance"]:XNL_GetCurrentPlayerLevel()
        SendNUIMessage({
            rank = tonumber(level),
        })
        Citizen.Wait(30000)
    end
end)