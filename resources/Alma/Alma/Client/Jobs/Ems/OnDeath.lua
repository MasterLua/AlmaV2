local SetEntityRagdoll = false
local IsTimeFinish = nil
local IsTimeDead = nil
AddEventHandler('esx:onPlayerDeath', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed, false)
	Alma.toServer('EMS:UpdateTableIsDead', true)
	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		RespawnPed(playerPed, {coords = coords, heading = 0.0})
		AnimpostfxStop('DeathFailOut')
		DoScreenFadeIn(800)
	end)
	SetEntityRagdoll = true
	Citizen.CreateThread(function()
		local DeathMenu = RageUI.CreateMenu('Coma', "Vous êtes dans le coma")
		DeathMenu.Closable = false
		RageUI.Visible(DeathMenu, not RageUI.Visible(DeathMenu))
		IsTimeFinish = false
		IsTimeDead = 8--*60*1000 -- 15 minutes
		local vip = GetVIP()
		local IsVIP = false
    	if vip == 2 then
        	IsVIP = true
		else
			IsVIP = false
		end
		LunchTimer()
		SetEntityInvincible(PlayerPedId(), true)
		while SetEntityRagdoll do
			Wait(0)
			RageUI.IsVisible(DeathMenu, function()
				RageUI.Separator('')
				RageUI.Separator('~y~Vous êtes inconscient')
				RageUI.Separator('Temps restant ~y~'..IsTimeDead..' ~w~minutes')
				RageUI.Separator('')
				RageUI.Button("Signalez votre situation", 'Permet d\'envoyer un appel d\'urgence au EMS.', {}, true, {
					onSelected = function() 
						Alma.toServer('ewen:CreateEmsSignal')
					end
				})
				RageUI.Button('Réaparaitre', 'Permet de réaparraitre à l\'hopital.',  {RightBadge = RageUI.BadgeStyle.Tick}, IsTimeFinish, {
					onSelected = function()
						Alma.toServer('ewen:RespawnHopital')
						SetEntityRagdoll = false
						SetEntityInvincible(PlayerPedId(), false)
						RageUI.CloseAll()
					end
				})
				RageUI.Button('Réaparaitre rapidement (VIP)', 'Permet de réaparraitre à l\'hopital instant (~b~VIP Diamond~s~)',  {RightLabel = '~b~VIP Diamond~s~'}, IsVIP, {
					onSelected = function()
						Alma.toServer('ewen:RespawnVIP')
						SetEntityRagdoll = false
						SetEntityInvincible(PlayerPedId(), false)
						RageUI.CloseAll()
					end
				})
			end)
			
			if not RageUI.Visible(DeathMenu) then
				DeathMenu = RMenu:DeleteType('DeathMenu', true)
			end

			if SetEntityRagdoll then
				SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
			end
		end
	end)
end)

function LunchTimer()
	Citizen.CreateThread(function()
		while true do 
			Wait(1*60*1000)
			if IsTimeDead >= 1 then
				IsTimeDead = IsTimeDead-8
			else
				IsTimeFinish = true
				break
			end
		end
	end)
end

function RespawnPed(ped, spawn)
	SetEntityCoordsNoOffset(ped, spawn.coords, false, false, false, true)
	NetworkResurrectLocalPlayer(spawn.coords, spawn.heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', spawn)
	ClearPedBloodDamage(ped)
end

Alma.netRegisterAndHandle('EMS:ReviveClientPlayer', function()
	SetEntityRagdoll = false
	Alma.toServer('EMS:UpdateTableIsDead', false)
end)