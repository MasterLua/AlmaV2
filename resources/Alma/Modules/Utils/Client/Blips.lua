---@class Blips
---@field id number Blips ID https://docs.fivem.net/docs/game-references/blips/#blips
---@field color number Blips colors ID https://docs.fivem.net/docs/game-references/blips/#blip-colors
---@field size number Size of blips
---@field shortRange boolean Blips if visible on the minimap when player are closet
---@field position any Blips position
---@field name string Blips name
---@field world number 0 = Los Santos 1 = Cayo Perico
Blips = {};
Blips.__index = Blips

---@type Blips[]
local BLIPS = {};

---@type table<number, number>
local BLIPS_WORLD = {};

setmetatable(Blips, {
    __call = function(_, id, color, size, shortRange, position, name, world)
        local self = setmetatable({}, Blips);

        self.id = id;
        self.color = color;
        self.size = size;
        self.shortRange = shortRange;
        self.position = position;
        self.name = name;
        self.world = world or 0;

        BLIPS[#BLIPS + 1] = self;

        if not (BLIPS_WORLD[self.world]) then
            BLIPS_WORLD[self.world] = {}
            if not (BLIPS_WORLD[self.world][self.position]) then
                BLIPS_WORLD[self.world][self.position] = {}
            end
        end

        local blip = AddBlipForCoord(self.position)
        SetBlipSprite(blip, self.id)
        SetBlipColour(blip, self.color)
        SetBlipAsShortRange(blip, self.shortRange);
        SetBlipScale(blip, self.size);
       -- SetBlipDisplay(blip, 0)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(self.name)
        EndTextCommandSetBlipName(blip)

        if (self.world == 1) then
            SetBlipDisplay(blip, 2)
        end

        BLIPS_WORLD[self.world][self.position] = blip

        return self;
    end
})

function Blips:New(id, color, size, shortRange, position, name, world)
    Blips(id, color, size, shortRange, position, name, world)
end

---SetBulkBlipsDisplay
---
--- Bulk set world blip display ID
---
---@param world string
---@param displayId number
function Blips:SetBulkBlipsDisplay(world, displayId)
    if (BLIPS_WORLD[world]) then
        for _, blip in pairs(BLIPS_WORLD[world]) do
            SetBlipDisplay(blip, displayId)
        end
    else
        return false;
    end
end

function Blips:Loading(world)
    self:SetBulkBlipsDisplay(world, 2)
end

function Blips:Unloading(world)
    self:SetBulkBlipsDisplay(world, 0)
end
