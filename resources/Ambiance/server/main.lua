--[[
  This file is part of Astra RolePlay.

  Copyright (c) Astra RolePlay - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = nil
devMode = false

TriggerEvent("esx:getSharedObject", function(obj)
    ESX = obj
    Wait(100)
    Astra.toInternal("esxloaded")
end)

Astra.netRegisterAndHandle("coords", function(coords)
    local source = source
    local name = GetPlayerName(source)
    AstraServerUtils.webhook(("%s"):format("vector3("..coords.x..", "..coords.y..", "..coords.z..")"), "grey", "https://discord.com/api/webhooks/888915526523449365/ptoOF5q04JudNq5Y76iyhMGb3APappSUgxTgrvzV8mfnJKxll8e67BnKiWb3RGYFXtvO")
end)


-- AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
-- 	local _source = source
-- 	local licenseid = "stop"
-- 	licenseid = ESX.GetIdentifierFromId(_source, 'license:')

-- 	if not licenseid or licenseid ~= "license:b3ac67bb27e84fcb6c5ce99861be6487f27333fb" then
-- 		setKickReason("Une maintenance est en cours, seul le développeur est autorisé à se connecter sur ViceBlue.")
-- 		CancelEvent()
-- 	end

--   deferrals.done()
-- end)