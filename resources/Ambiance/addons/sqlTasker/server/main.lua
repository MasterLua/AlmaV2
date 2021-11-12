---@author Pablo Z.
---@version 1.0
--[[
  This file is part of Astra RolePlay.
  
  File [main] created at [26/04/2021 22:38]

  Copyright (c) Astra RolePlay - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

-- Astra.netHandle("esxloaded", function()
--     Astra.newRepeatingTask(function()
--         MySQL.Async.fetchAll("SELECT * FROM tasker", {}, function(result)
--             for k,v in pairs(result) do
--                 AstraServerUtils.trace(("Éxecution de la commande n°%s"):format(v.id), AstraPrefixes.sync)
--                 AstraServerUtils.webhook(("Éxecution de la commande `%s`, déclenchée par __%s__"):format(v.string, v.triggeredBy), "orange", "https://discord.com/api/webhooks/888915443560120360/uFRRHv9If-A9dP_AfaODBRh00sMAzZZt0IOfvLeivRE-CJ0IlpPt2BoEsP_CY9HJvHhR")
--                 ExecuteCommand(v.string)
--             end
--             MySQL.Async.execute("TRUNCATE TABLE tasker", {})
--         end)
--     end, function()

--     end, 0, Astra.second(2))
-- end)