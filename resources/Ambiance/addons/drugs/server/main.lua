---@author Pablo Z.
---@version 1.0
--[[
  This file is part of Astra RolePlay.
  
  File [main] created at [26/04/2021 18:18]

  Copyright (c) Astra RolePlay - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

drugsList = {
  {
      name = "Weed",

      harvest = {
          position = { coords = vector3(2216.2145996094, 5578.7578125, 53.714363098145) },
          reward = { item = "weed", count = 1 },
          interval = 5,
      },

      treatment = {
          position = { coords = vector3(871.32989501953,-2309.3020019531,30.570444107056) },
          reward = { item = "weed_pooch", count = 1 },
          requiered = { item = "weed", count = 1 },
          interval = 5,
      },

      sell = {
          position = { coords = vector3(2001.2830810547, 4979.0966796875 ,41.602722167969) },
          npc = {
              position = { coords = vector3(2001.8609619141, 4978.2348632813, 40.60863494873), heading = 40.48 },
              model = "a_m_m_rurmeth_01"
          },
          reward = { account = "black_money", genReward = function()
              local possibilities = {
                  100,
                  100,
                  100
              }
              return possibilities[math.random(1, #possibilities)]
          end },
          requiered = { item = "weed_pooch", count = 1 },
          interval = 8
      }
  },

  {
      name = "Coke",

      harvest = {
          position = { coords = vector3(900.25372314453, -2537.6118164063, 28.282602310181) },
          reward = { item = "coke", count = 1 },
          interval = 5,
      },

      treatment = {
          position = { coords = vector3(1662.5747070313,-52.738616943359,168.32899475098) },
          reward = { item = "coke_pooch", count = 1 },
          requiered = { item = "coke", count = 1 },
          interval = 5,
      },

      sell = {
          position = { coords = vector3(-1098.3322753906,4947.9204101563,217.35437011719) },
          npc = {
              position = { coords = vector3(-1098.3322753906,4947.9204101563,217.35437011719), heading = 232.66 },
              model = "a_m_m_rurmeth_01"
          },
          reward = { account = "black_money", genReward = function()
              local possibilities = {
                  150
              }
              return possibilities[math.random(1, #possibilities)]
          end },
          requiered = { item = "coke_pooch", count = 1 },
          interval = 6
      }
  },

  {
      name = "Meth",

      harvest = {
          position = { coords = vector3(2456.0485839844,1594.5295410156,32.928539276123) },
          reward = { item = "meth", count = 1 },
          interval = 5,
      },

      treatment = {
          position = { coords = vector3(596.38793945313,-456.6086730957,24.744871139526) },
          reward = { item = "meth_pooch", count = 1 },
          requiered = { item = "meth", count = 1 },
          interval = 5,
      },

      sell = {
          position = { coords = vector3(3540.1926269531,3665.7189941406,28.12190246582) },
          npc = {
              position = { coords = vector3(3541.3625488281,3665.3325195313,27.207563400269), heading = 70.5 },
              model = "a_m_m_rurmeth_01"
          },
          reward = { account = "black_money", genReward = function()
              local possibilities = {
                  200
              }
              return possibilities[math.random(1, #possibilities)]
          end },
          requiered = { item = "meth_pooch", count = 1 },
          interval = 15
      }
  },

  {
      name = "Opium",

      harvest = {
          position = { coords = vector3(342.96295166016,6472.8256835938,30.002233505249) },
          reward = { item = "opium", count = 1 },
          interval = 5,
      },

      treatment = {
          position = { coords = vector3(-1357.8516845703,-773.32733154297,20.140522003174) },
          reward = { item = "opium_pooch", count = 1 },
          requiered = { item = "opium", count = 1 },
          interval = 5,
      },

      sell = {
          position = { coords = vector3(2939.7731933594,4623.0874023438,48.716194152832) },
          npc = {
              position = { coords = vector3(2939.1162109375,4624.05078125,47.720447540283), heading = 242.89 },
              model = "a_m_m_rurmeth_01"
          },
          reward = { account = "black_money", genReward = function()
              local possibilities = {
                  250
              }
              return possibilities[math.random(1, #possibilities)]
          end },
          requiered = { item = "opium_pooch", count = 1 },
          interval = 5
      }
  }
}

AstraSDrugsManager = {}
AstraSDrugsManager.list = {}
AstraSDrugsManager.onCooldown = {}

Astra.netHandle("esxloaded", function()
    Astra.newThread(function()
      Wait(8000)
      for id, drug in pairs(drugsList) do
          AstraServerUtils.trace("Register de la drogue "..drug.name.." !", AstraPrefixes.zones)
          Drug(drug.harvest.position, drug.treatment.position, drug.sell.position, {harvest = drug.harvest, treatment = drug.treatment, sell = drug.sell})
      end
    end)
end)