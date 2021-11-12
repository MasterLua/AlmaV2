---@author Pablo Z.
---@version 1.0
--[[
  This file is part of Astra RolePlay.
  
  File [main] created at [19/04/2021 23:23]

  Copyright (c) Astra RolePlay - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

AstraServerUtils.registerConsoleCommand("giveExp", function(source, args)
    if #args ~= 2 then return end
    -- TODO -> Check si id & ammount nombres
    local id = tonumber(args[1])
    local ammount = tonumber(args[2])
    if not AstraSPlayersManager.exists(id) then
        AstraServerUtils.trace("Ce joueur n'est pas connecté !", AstraPrefixes.err)
        return
    end
    ---@type Player
    local player = AstraSPlayersManager.getPlayer(id)
    player:setAddonCache("exp", (player:getAddonCache("exp")+ammount), true)
    AstraServerUtils.trace("XP ajoutée au joueur !", AstraPrefixes.succes)
end)

---@param player Player
AstraSPlayersManager.registerAddonCache("exp", function(player)
    MySQL.Async.fetchAll("SELECT exp FROM alma_playerlevel WHERE license = @a", {['a'] = player.license}, function(result)
        if result[1] then
            player:setAddonCache("exp", result[1].exp, false)
        else
            player:setAddonCache("exp", 0, false)
            MySQL.Async.insert("INSERT INTO alma_playerlevel (license) VALUES(@a)", {['a'] = player.license})
        end
        AstraServerUtils.toClient("levelInitFirst", player.source, player:getAddonCache("exp"))
        AstraServerUtils.trace(("Niveau envoyé au joueur (^3%s^7)"):format(player:getAddonCache("exp")), AstraPrefixes.dev)
    end)
end, function(player)
    MySQL.Async.execute("UPDATE alma_playerlevel SET exp = @a WHERE license = @b", {['a'] = player:getAddonCache("exp"), ['b'] = player.license})
end, function(player)
    -- TODO -> Bug barre xp
    AstraServerUtils.toClient("levelGain", player.source, player:getAddonCache("exp"))
    MySQL.Async.execute("UPDATE alma_playerlevel SET exp = @a WHERE license = @b", {['a'] = player:getAddonCache("exp"), ['b'] = player.license})
end)

---@param player Player
Astra.netHandle("onPlayerSessionMidElapsed", function(id)
    local player = AstraSPlayersManager.getPlayer(id)
    local initialValue = player:getAddonCache("exp")
    player:setAddonCache("exp", (initialValue+500), true)
end)
