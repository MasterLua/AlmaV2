RegisterKeyMapping('+rageui-inv', 'Ouvrir l\'inventaire personnel', 'keyboard', 'i')

RegisterCommand("+rageui-inv", function()
    if not (Alma.IsInJail) then
        if (GetVehiclePedIsIn(PlayerPedId(), false) == 0) then
            if (GetEntityAttachedTo(PlayerPedId()) == 0) then
                Inventory()
            else
                ESX.ShowNotification("~HUD_COLOUR_DEGEN_RED~Vous ne pouvez pas faire cela en etant porté.")
            end
        else
            ESX.ShowNotification("~HUD_COLOUR_DEGEN_RED~Vous ne pouvez pas faire cela en voiture.")
        end
    end
end, false)

local INVENTORY = {};

local ACCOUNTS = {};

local WEAPONS = {};

local INVENTORY_SIZE = 0;

local IS_LOADED = false;

local FILTER_INVENTORY = {
    { Name = "Aucun", Value = nil },
    { Name = "Objets", Value = 'item_standard' },
    { Name = "Armes", Value = 'item_weapon' },
    { Name = "Argent", Value = 'item_account' },
};

local FILTER_INDEX = 2;

local ACCOUNT_LABEL = {
    ["money"] = "Argent",
    ["black_money"] = "Argent sale",
}

local ITEM_ACTION = {
    { Name = "Utiliser" },
    { Name = "Donner" },
    { Name = "Supprimer" },
}

local WEAPON_ACTION = {
    { Name = "Donner" },
    { Name = "Supprimer" },
}

local ACCOUNTS_ACTION = {
    { Name = "Donner" },
    { Name = "Supprimer" },
}

local ITEM_INDEX = {}

local function CalculeInventorySize()
    for i = 1, #INVENTORY, 1 do
        if INVENTORY[i].count > 0 then
            INVENTORY_SIZE = INVENTORY_SIZE + (INVENTORY[i].weight * INVENTORY[i].count)
        end
    end
    inventory:SetInventorySize(INVENTORY_SIZE)
end

Alma:AddEventHandler("Inventory", "UpdateItemCount", function(IsAdd, ItemName, Count)
    for i = 1, #INVENTORY do
        if (INVENTORY[i].name == ItemName) then
            ESX.UI.ShowInventoryItemNotification(IsAdd, INVENTORY[i].label, IsAdd and (Count - INVENTORY[i].count) or (INVENTORY[i].count - Count))
            INVENTORY[i].count = Count;
            if INVENTORY[i].count <= 0 then
                ESX.UI.ShowInventoryItemNotification(false, Item.label, Item.count)
                table.remove(INVENTORY, i);
            end
            return ;
        end
    end
    CalculeInventorySize()
end)

Alma:AddEventHandler("Inventory", "onLoaded", function(Inventory, Accounts, Weapons)
    INVENTORY = Inventory;
    sizeObj = ESX.Table.SizeOf(Inventory)    
    sizeWea = ESX.Table.SizeOf(Weapons)
    for i, v in pairs(Accounts) do
        if (v.name == "money") or (v.name == "black_money") then
            ACCOUNTS[v.name] = ESX.Math.Round(v.money)
        end
    end
    for i, v in pairs(Weapons) do
        if not (WEAPONS[string.upper(v.name)]) then
            WEAPONS[string.upper(v.name)] = { hash = GetHashKey(v.name), label = ESX.GetWeaponLabel(v.name), name = v.name, ammo = v.ammo, IsContributor = v.isContributor or false, IsJobs = v.isJobsWeapon or false, IsMiniGame = v.isMiniGame or false, }
        else
            print('Weapon data duplicated [' .. v.name .. ']')
        end
    end
    for i = 1, #Inventory, 1 do
        if Inventory[i].count > 0 then
            INVENTORY_SIZE = INVENTORY_SIZE + (Inventory[i].weight * Inventory[i].count)
        end
    end
    IS_LOADED = true;
end)

local DISPLAY = {
    [2] = function()
        for i, v in pairs(INVENTORY) do
            if (ITEM_INDEX[v.name] == nil) then
                ITEM_INDEX[v.name] = 1;
            end
            RageUI.List("[" .. v.count .. "] " .. v.label, ITEM_ACTION, ITEM_INDEX[v.name], "Objet : " .. v.label .. "\nQuantité : " .. v.count .. "\nUnité de poids : " .. v.weight .. "\nPoids total : " .. v.count * v.weight .. "", { }, true, {
                onListChange = function(Index, Item)
                    ITEM_INDEX[v.name] = Index;
                end,
                onSelected = function(Index, Item)
                    local player, distance = ESX.Game.GetClosestPlayer()
                    Helper:Switch(Index, {
                        [1] = function()
                            Alma:TriggerServerEvent("Inventory", "UseItem", v.name)
                        end,
                        [2] = function()
                            if (distance ~= -1) and (distance <= 3) then
                                local target = GetPlayerPed(player);
                                if IsPedOnFoot(target) then
                                    Helper:OnAskQuantity(function(amount)
                                        local serverId = GetPlayerServerId(player);
                                        Alma:TriggerServerEvent("Inventory", "GiveInventoryItem", serverId, "item_standard", v.name, amount)
                                    end)
                                else
                                    ESX.ShowNotification("Impossible de donner " .. v.label .. " dans un véhicule")
                                end
                            else
                                ESX.ShowNotification("Aucun joueur à proximité")
                            end
                        end,
                        [3] = function()
                            if (v.canRemove) then
                                if (IsPedOnFoot(PlayerPedId())) then
                                    Helper:OnAskQuantity(function(amount)
                                        Alma:TriggerServerEvent("Inventory", "DropInventoryItem", "item_standard", v.name, amount)
                                    end)
                                else
                                    ESX.ShowNotification("Impossible de jeter " .. v.label .. " dans un véhicule")
                                end
                            else
                                ESX.ShowNotification(v.label .. " n\'est pas jetable")
                            end
                        end
                    })
                end,
            })
        end
    end,
    [3] = function()
        for name, v in pairs(WEAPONS) do
            if not v.IsContributor then
                local ammo = GetAmmoInPedWeapon(PlayerPedId(), v.hash);
                if (ITEM_INDEX[name] == nil) then
                    ITEM_INDEX[name] = 1;
                end
                RageUI.List(v.label, WEAPON_ACTION, ITEM_INDEX[name], "Nombre de munitions : " .. ammo .. "", {}, true, {
                    onListChange = function(Index, Item)
                        ITEM_INDEX[name] = Index;
                    end,
                    onSelected = function(Index, Item)
                        local player, distance = ESX.Game.GetClosestPlayer()
                        if (distance ~= -1) and (distance <= 3) then
                            local target = GetPlayerPed(player)
                            if IsPedOnFoot(target) then
                                Helper:Switch(Index, {
                                    [1] = function()
                                        Alma:TriggerServerEvent("Inventory", "GiveInventoryItem", GetPlayerServerId(player), "item_weapon", v.name, nil)
                                    end,
                                    [2] = function()
                                        Alma:TriggerServerEvent("Inventory", "DropInventoryItem", "item_weapon", v.name)
                                    end,
                                });
                            else
                                ESX.ShowNotification("Impossible de donner " .. v.label .. " dans un véhicule")
                            end
                        else
                            ESX.ShowNotification("Aucun joueur à proximité")
                        end
                    end
                });
            else
                RageUI.Button(v.label, "Nombre de munitions : " .. ammo .. "\n\nCet objet n'est pas récupérable ou transferable, car il est attaché à la fonction de la personne, attaché à un mini-jeu ou est une arme permanente.", { RightBadge = RageUI.BadgeStyle.Lock }, true, {
                    onSelected = function()

                    end
                })
            end
        end
    end,
    [4] = function()
        for name, v in pairs(ACCOUNTS) do
            if (ITEM_INDEX[name] == nil) then
                ITEM_INDEX[name] = 1;
            end
            RageUI.List(ACCOUNT_LABEL[name], ACCOUNTS_ACTION, ITEM_INDEX[name], "Montant actuel: " .. string.format("%s $", v), {}, true, {
                onListChange = function(Index, Item)
                    ITEM_INDEX[name] = Index;
                end,
                onSelected = function(Index, Item)

                    Helper:Switch(Index, {
                        [1] = function()
                            local player, distance = ESX.Game.GetClosestPlayer()
                            if (distance ~= -1) and (distance <= 3) then
                                local target = GetPlayerPed(player)
                                if IsPedOnFoot(target) then
                                    Helper:OnAskQuantity(function(amount)
                                        print(amount)
                                        Alma:TriggerServerEvent("Inventory", "GiveInventoryItem", GetPlayerServerId(player), "item_account", name, amount)
                                    end)
                                else
                                    ESX.ShowNotification("Impossible de donner dans un véhicule")
                                end
                            else
                                ESX.ShowNotification("Aucun joueur à proximité")
                            end
                        end,
                        [2] = function()
                            Helper:OnAskQuantity(function(amount)
                                Alma:TriggerServerEvent("Inventory", "DropInventoryItem", "item_account", name, amount)
                            end)
                        end,
                    });
                end
            })
        end
    end,
}

function Inventory()
    local inventory = RageUI.CreateMenu("Inventaire", "VOTRE INVENTAIRE PERSONNEL.")
    inventory.TitleFont = 2;
    inventory:SetInventorySize(INVENTORY_SIZE)

    Alma:TriggerServerEvent("Inventory", "Request")

    RageUI.Visible(inventory, not RageUI.Visible(inventory))

    while inventory do
        Citizen.Wait(0)
        RageUI.IsVisible(inventory, function()

            RageUI.List('Filtre', FILTER_INVENTORY, FILTER_INDEX, nil, {}, true, {
                onListChange = function(Index, Item)
                    FILTER_INDEX = Index;
                end,
                onSelected = function(Index, Item)

                end,
            })
            RageUI.Separator((FILTER_INDEX == 1 and "Inventaire." or FILTER_INDEX == 2 and "Object." or FILTER_INDEX == 3 and "Armes." or "Argent."))
            if sizeObj == 0 and FILTER_INDEX == 2 then
                RageUI.Separator("");
                RageUI.Separator("~r~Vous n'avez pas d'object.")
                RageUI.Separator("");
            elseif sizeWea == 0 and FILTER_INDEX == 3 then
                RageUI.Separator("");
                RageUI.Separator("~r~Vous n'avez pas d'armes.")
                RageUI.Separator("");
            end
            if (FILTER_INDEX == 1) then
                for i = 2, 4 do
                    if (DISPLAY[i] ~= nil) then
                        DISPLAY[i]()
                    end
                end
            else
                if (DISPLAY[FILTER_INDEX] ~= nil) then
                    DISPLAY[FILTER_INDEX]()
                end
            end
        end)
        if not RageUI.Visible(inventory) then
            inventory = RMenu:DeleteType("inventory", true)
        end
    end
end
