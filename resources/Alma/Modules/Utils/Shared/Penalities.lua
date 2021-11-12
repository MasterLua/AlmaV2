--@class Penalties
---@field id number
---@field name string
---@field description string
---@field type PenaltiesType
---@field seconds number
Penalties = {}
Penalties.__index = Penalties

---@type Penalties[]
PENALTIES = {};

---@class PenaltiesType;
PENALTIES_TYPE = {
	BAN = 1,
	JAIL = 2
}

PENALTIES_TYPE_NAME = {
	[1] = "Ban",
	[2] = "Prison"
}

setmetatable(Penalties, {
	__call = function(_, id, name, description, type, seconds)
		local self = setmetatable({}, Penalties);

		self.id = id;
		self.name = name;
		self.description = description;
		self.type = type;
		self.seconds = seconds;

		if (PENALTIES[self.id]) then
			error("Penalities already exist with this id [" .. self.id .. "]")
		end

		PENALTIES[self.id] = self;

		return self;
	end
})

---GetByType
---@param type PenaltiesType
function Penalties:GetByType(type)
	local lists = {};
	for i, v in pairs(PENALTIES) do
		if (v.type == type) then
			table.insert(lists, v)
		end
	end
	return lists;
end


---GetByType
---@param type Penalties:GetByID
function Penalties:GetByID(id)
	return PENALTIES[id];
end

---New
---@public
---@return void
function Penalties:New(id, name, description, type, seconds)
	Penalties(id, name, description, type, seconds);
end

Penalties:New(1, "Conduite HRP", "Une conduite inapproprié au rp", PENALTIES_TYPE.JAIL, 1200)
Penalties:New(2, "Tir en ville", "Tirer en ville pour aucune raison rp", PENALTIES_TYPE.JAIL, 1800)
Penalties:New(3, "HRP Vocal", "Le HRP Vocal consiste à parler avec un langage sortant du contexte RP:Vous ne devez pas dire des choses qui sorte du Cadre RP.", PENALTIES_TYPE.JAIL, 1200)
Penalties:New(4, "No fear RP", " Il est impératif que vous agissiez comme vous le feriez IRL. Votre personnage a peur de la mort. Ne faites pas d’actions héroïques.", PENALTIES_TYPE.JAIL, 1800)
Penalties:New(5, "No Pain RP", "Le Pain RP correspond à la simulation de la douleur. En outre, il s'agit d'accepter les effets d'une balle ou d'un coup que notre personnage reçoit.Galoper comme un chevreuil après s’être fait tiré dessus n’a rien de cohérent.", PENALTIES_TYPE.JAIL, 1800)
Penalties:New(6, "Car Kill", "Le fait d’écraser quelqu’un avec une voiture excepté si cela est justifié par l’action de la scène.", PENALTIES_TYPE.JAIL, 3000)
Penalties:New(7, "Use Bug", "L'utilisation d'un bug à des fins personnelles afin d'en tirer profit est considéré comme bug using", PENALTIES_TYPE.JAIL, 4800)
Penalties:New(8, "Free Punch", "Taper une personne pour aucune raison RP", PENALTIES_TYPE.JAIL, 2100)
Penalties:New(9, "Free kill", "Le fait de tuer quelqu’un sans aucune raison.", PENALTIES_TYPE.JAIL, 3600)
Penalties:New(10, "MassRP", "Le Mass RP est le fait de prendre en compte des lieux qui sont publics comme :  Quartiers | Hôpitaux | Commissariats | Poste de Sheriff | Autoroutes... ,  qui sont donc peuplés de milliers d'habitants comme dans la réalité.", PENALTIES_TYPE.JAIL, 3600)
Penalties:New(11, "Power Gaming", "Le powergaming consiste à faire quelque chose qui serait impossible à réaliser dans la vie réelle.Cela consiste également à s'octroyer une sorte d'avantage et donc forcer les choses en sa faveur sans donner aucune chance à la partie adverse.", PENALTIES_TYPE.JAIL, 1800)
Penalties:New(12, "Méta Gaming", "Toute utilisation d’informations obtenues de façon Hors-RP (Stream, Discord, Teamspeak, etc…).", PENALTIES_TYPE.JAIL, 4800)
Penalties:New(13, "Troll", "Troll", PENALTIES_TYPE.JAIL, 7200)
Penalties:New(14, "NLR", "-Le NLR: le New Life Rule veut qu'on ne se souvienne pas de sa vie passée, donc on fonce pas la où on a été tué pour se venger", PENALTIES_TYPE.JAIL, 7200)
Penalties:New(15, "ALT F4", "ALT F4", PENALTIES_TYPE.JAIL, 2800)
Penalties:New(16, "Insulte Staff", "Insulter un staff", PENALTIES_TYPE.JAIL, 4800)
Penalties:New(17, "Decente sans dossier", "Decente sans dossier", PENALTIES_TYPE.JAIL, 10000)
Penalties:New(18, "Autre", "Autre", PENALTIES_TYPE.JAIL, 6000)