---@type Pnj[]
local PED_REGISTERED = {};

---@class Pnj
---@field ped number
---@field pedType number Entity type https://docs.fivem.net/natives/?_0xD49F9B0955C367DE
---@field model string Entity model
---@field position any Vector4 only
---@field interiorID number InteriorID if ped is in interior
Pnj = {};
Pnj.__index = Pnj

setmetatable(Pnj, {
	__call = function(_, pedType, model, position, interiorID)
		local self = setmetatable({}, Pnj);

		self.model = model;
		self.position = position;
		self.interior = interiorID or nil;

		if not (HasModelLoaded(self.model)) then
			RequestModel(self.model)
			while not HasModelLoaded(self.model) do
				Citizen.Wait(1.0)
			end
		end
		self.ped = CreatePed(pedType, self.model, self.position.x, self.position.y, self.position.z, self.position.w, false, false)
		SetBlockingOfNonTemporaryEvents(self.ped, true)
		SetEntityInvincible(self.ped, true)
		SetPedDefaultComponentVariation(self.ped)
		SetModelAsNoLongerNeeded(self.model);

		if (interiorID) then
			PED_REGISTERED['int_' .. interiorID] = self;
		else
			PED_REGISTERED[#PED_REGISTERED + 1] = self;
		end

		return self;
	end
})

---GetAll
---
--- Return all ped registered
---
---@public
---@return table
function Pnj:GetAll()
	return PED_REGISTERED;
end

---GetInteriorID
---
--- Get entity registered with interiorID
---
---@param id number InteriorID
function Pnj:GetInteriorID(id)
	return PED_REGISTERED['int_' .. id] ~= nil and PED_REGISTERED['int_' .. id] or false;
end

---ExistInteriorID
---
--- Know if entity is registered for this interiorID
---
---@param id number InteriorID
---@public
---@return boolean
function Pnj:ExistInteriorID(id)
	return PED_REGISTERED['int_' .. id] ~= nil and true or false;
end

AddEventHandler('onResourceStop', function(resource)
	if (GetCurrentResourceName() ~= resource) then
		return
	end
	for i, v in pairs(PED_REGISTERED) do
		DeleteEntity(v.ped)
	end
end)
