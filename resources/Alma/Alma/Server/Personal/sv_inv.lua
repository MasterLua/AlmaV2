Contributor = {
	['WEAPON_COMBATMG_MK2'] = true,
	['WEAPON_MARKSMANRIFLE'] = true,
	['WEAPON_ASSAULTRIFLE'] = true,
	['WEAPON_COMBATPDW'] = true,
	['WEAPON_SPECIALCARBINE'] = true,
	['WEAPON_MACHETE'] = true,
	['WEAPON_BAT'] = true,
	['WEAPON_CARBINERIFLE'] = true,
	['WEAPON_HATCHET'] = true,
	['WEAPON_GUSENBERG'] = true,
	['WEAPON_CROWBAR'] = true,
	['WEAPON_HAMMER'] = true,
	['WEAPON_MARKSMANPISTOL'] = true,
	['WEAPON_NAVYREVOLVER'] = true,
	['WEAPON_DBSHOTGUN'] = true,
	['WEAPON_GADGETPISTOL'] = true,
	['WEAPON_FLAREGUN'] = true,
	['WEAPON_COMPACTRIFLE'] = true,
	['WEAPON_APPISTOL'] = true,
	['WEAPON_COMBATSHOTGUN'] = true,
	['WEAPON_HEAVYSNIPER_MK2'] = true,
	['WEAPON_SNOWBALL'] = true,
	['WEAPON_STONE_HATCHET'] = true
}

RegisterNetEvent('Init:Inventory')
AddEventHandler('Init:Inventory', function(source, xPlayer)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Account = {}
    local Inventory = {}
	local Weapons = {}

    table.insert(Account, {name = "cash", money = xPlayer.getAccount('money').money})
    table.insert(Account, {name = "dirtycash", money = xPlayer.getAccount('black_money').money})
    for k,v in pairs(xPlayer.getInventory()) do
        if v.count > 0 then
            table.insert(Inventory, {name = v.name, count = v.count, weight = v.weight})
        end
    end
	for k,v in pairs(xPlayer.getLoadout()) do
		if Contributor[v.name] then
			table.insert(Weapons, {label = v.name, name = v.name, ammo = v.ammo, component = v.component, tintIndex = v.tintIndex, isContributor = true, isJob = false, isMiniGame = false})
		else
			table.insert(Weapons, {label = v.name, name = v.name, ammo = v.ammo, component = v.component, tintIndex = v.tintIndex, isContributor = false, isJob = false, isMiniGame = false})
		end
	end
	Alma:TriggerClientEvent("Inventory", "onLoaded", xPlayer.source, Inventory, Account, Weapons)
end)

function RefreshPlayer(id)
	if GetPlayerName(id) then
		local xPlayer = ESX.GetPlayerFromId(id)
    	local Account = {}
    	local Inventory = {}
		local Weapons = {}

    	table.insert(Account, {name = "cash", money = xPlayer.getAccount('money').money})
    	table.insert(Account, {name = "dirtycash", money = xPlayer.getAccount('black_money').money})
    	for k,v in pairs(xPlayer.getInventory()) do
    	    if v.count > 0 then
    	        table.insert(Inventory, {name = v.name, count = v.count, weight = v.weight})
    	    end
    	end
		for k,v in pairs(xPlayer.getLoadout()) do
			if Contributor[v.name] then
				table.insert(Weapons, {label = v.name, name = v.name, ammo = v.ammo, component = v.component, tintIndex = v.tintIndex, IsContributor = true, IsJob = false, IsMiniGame = false})
			else
				table.insert(Weapons, {label = v.name, name = v.name, ammo = v.ammo, component = v.component, tintIndex = v.tintIndex, IsContributor = false, IsJob = false, IsMiniGame = false})
			end
		end
		Alma:TriggerClientEvent("Inventory", "onLoaded", xPlayer.source, Inventory, Account, Weapons)
	end
end

Alma:AddEventHandler("Inventory", "Request", function()
	local xPlayer = ESX.GetPlayerFromId(source)
    local Account = {}
    local Inventory = {}
	local Weapons = {}

    table.insert(Account, {name = "cash", money = xPlayer.getAccount('money').money})
    table.insert(Account, {name = "dirtycash", money = xPlayer.getAccount('black_money').money})
    for k,v in pairs(xPlayer.getInventory()) do
        if v.count > 0 then
            table.insert(Inventory, {name = v.name, count = v.count, weight = v.weight})
        end
    end
	for k,v in pairs(xPlayer.getLoadout()) do
		if Contributor[v.name] then
			table.insert(Weapons, {label = v.name, name = v.name, ammo = v.ammo, component = v.component, tintIndex = v.tintIndex, IsContributor = true, IsJob = false, IsMiniGame = false})
		else
			table.insert(Weapons, {label = v.name, name = v.name, ammo = v.ammo, component = v.component, tintIndex = v.tintIndex, IsContributor = false, IsJob = false, IsMiniGame = false})
		end
	end
	Alma:TriggerClientEvent("Inventory", "onLoaded", xPlayer.source, Inventory, Account, Weapons)
end)

Alma:AddEventHandler('Inventory', 'GiveInventoryItem', function(target, type, itemName, itemCount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if type == 'item_standard' then
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		if itemCount > 0 and sourceItem.count >= itemCount then
			if targetXPlayer.canCarryItem(itemName, itemCount) then
				sourceXPlayer.removeInventoryItem(itemName, itemCount)
				targetXPlayer.addInventoryItem(itemName, itemCount)

				sourceXPlayer.showAdvancedNotification("Alma", "~g~Inventaire", "Tu as donné ".. itemCount .."".. ESX.Items[itemName].label.." à "..targetXPlayer.name, 'CHAR_CALIFORNIA', 7)
				targetXPlayer.showAdvancedNotification("Alma", "~g~Inventaire", "Tu as reçus ".. itemCount.. ""..ESX.Items[itemName].label.." de "..sourceXPlayer.name, 'CHAR_CALIFORNIA', 7)
				RefreshPlayer(_source)
				RefreshPlayer(targetXPlayer.source)
			else
				sourceXPlayer.showAdvancedNotification("Alma", "~g~Inventaire", 'Vous ne pouvez pas faire ceci !', 'CHAR_CALIFORNIA', 7)
			end
		else
			sourceXPlayer.showAdvancedNotification("Alma", "~g~Inventaire", 'Quantité invalide, ou non supérieur a votre inventaire', 'CHAR_CALIFORNIA', 7)
		end
	elseif type == 'item_account' then
		if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
			local accountLabel = ESX.GetAccountLabel(itemName)

			sourceXPlayer.removeAccountMoney(itemName, itemCount)
			targetXPlayer.addAccountMoney(itemName, itemCount)

			-- sourceXPlayer.showAdvancedNotification("Alma", "~g~Portefeuille", _U('gave_account_money', ESX.Math.GroupDigits(itemCount), accountLabel, targetXPlayer.name), 'CHAR_CALIFORNIA', 9)
			-- targetXPlayer.showAdvancedNotification("Alma", "~g~Portefeuille", _U('received_account_money', ESX.Math.GroupDigits(itemCount), accountLabel, sourceXPlayer.name), 'CHAR_CALIFORNIA', 9)
			RefreshPlayer(_source)
			RefreshPlayer(targetXPlayer.source)
		else
			-- sourceXPlayer.showAdvancedNotification("Alma", "~g~Portefeuille", _U('imp_invalid_amount'), 'CHAR_CALIFORNIA', 9)
		end
	elseif type == 'item_weapon' then
		itemName = string.upper(itemName)

		if sourceXPlayer.hasWeapon(itemName) then
			local weaponLabel = ESX.GetWeaponLabel(itemName)

			if not targetXPlayer.hasWeapon(itemName) then
				local weaponNum, weapon = sourceXPlayer.getWeapon(itemName)
				itemCount = weapon.ammo

				sourceXPlayer.removeWeapon(itemName)
				targetXPlayer.addWeapon(itemName, itemCount)

				if itemCount > 0 then
					sourceXPlayer.showAdvancedNotification("Alma", "~g~Armes", "Tu as donné ".. weaponLabel.." avec "..itemCount.." munitions à "..targetXPlayer.name, 'CHAR_CALIFORNIA', 7)
					targetXPlayer.showAdvancedNotification("Alma", "~g~Armes", "Tu as reçus ".. weaponLabel.."avec " ..itemCount.." munition à ".. sourceXPlayer.name, 'CHAR_CALIFORNIA', 7)
					RefreshPlayer(_source)
					RefreshPlayer(targetXPlayer.source)
				else
					-- sourceXPlayer.showAdvancedNotification("Alma", "~y~Armes", _U('gave_weapon', weaponLabel, targetXPlayer.name), 'CHAR_CALIFORNIA', 7)
					-- targetXPlayer.showAdvancedNotification("Alma", "~y~Armes", _U('received_weapon', weaponLabel, sourceXPlayer.name), 'CHAR_CALIFORNIA', 7)
				end
			else
				-- sourceXPlayer.showAdvancedNotification("Alma", "~y~Armes", _U('gave_weapon_hasalready', targetXPlayer.name, weaponLabel), 'CHAR_CALIFORNIA', 7)
				-- targetXPlayer.showAdvancedNotification("Alma", "~y~Armes", _U('received_weapon_hasalready', sourceXPlayer.name, weaponLabel), 'CHAR_CALIFORNIA', 7)
			end
		end
	elseif type == 'item_ammo' then
		itemName = string.upper(itemName)

		if sourceXPlayer.hasWeapon(itemName) then
			local weaponNum, weapon = sourceXPlayer.getWeapon(itemName)

			if targetXPlayer.hasWeapon(itemName) then
				if weapon.ammo >= itemCount then
					sourceXPlayer.removeWeaponAmmo(itemName, itemCount)
					targetXPlayer.addWeaponAmmo(itemName, itemCount)
					RefreshPlayer(_source)
					RefreshPlayer(targetXPlayer.source)

					-- sourceXPlayer.showNotification(_U('gave_weapon_ammo', itemCount, weapon.label, targetXPlayer.name))
					-- targetXPlayer.showNotification(_U('received_weapon_ammo', itemCount, weapon.label, sourceXPlayer.name))
				end
			else
				-- sourceXPlayer.showNotification(_U('gave_weapon_noweapon', targetXPlayer.name))
				-- targetXPlayer.showNotification(_U('received_weapon_noweapon', sourceXPlayer.name, weapon.label))
			end
		end
	end
end)

Alma:AddEventHandler('Inventory', 'DropInventoryItem', function(type, itemName, itemCount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if type == 'item_standard' then
		if itemCount == nil or itemCount < 1 then
			xPlayer.showAdvancedNotification("Alma", "~y~Inventaire", _U('imp_invalid_quantity'), 'CHAR_CALIFORNIA', 7)
		else
			local xItem = xPlayer.getInventoryItem(itemName)

			if (itemCount > xItem.count or xItem.count < 1) then
				xPlayer.showAdvancedNotification("Alma", "~y~Inventaire", _U('imp_invalid_quantity'), 'CHAR_CALIFORNIA', 7)
			else
				xPlayer.removeInventoryItem(itemName, itemCount)

				local pickupLabel = ('~y~%s~s~ [~b~%s~s~]'):format(ESX.Items[itemName].label, itemCount)
				ESX.CreatePickup('item_standard', itemName, itemCount, pickupLabel, _source)
				xPlayer.showAdvancedNotification("Alma", "~y~Inventaire", _U('threw_standard', itemCount, ESX.Items[itemName].label), 'CHAR_CALIFORNIA', 7)
			end
		end
	elseif type == 'item_account' then
		if itemCount == nil or itemCount < 1 then
			xPlayer.showAdvancedNotification("Alma", "~y~Portefeuille", _U('imp_invalid_amount'), 'CHAR_CALIFORNIA', 9)
		else
			local account = xPlayer.getAccount(itemName)
			local accountLabel = ESX.GetAccountLabel(itemName)

			if (itemCount > account.money or account.money < 1) then
				xPlayer.showAdvancedNotification("Alma", "~y~Portefeuille", _U('imp_invalid_amount'), 'CHAR_CALIFORNIA', 9)
			else
				xPlayer.removeAccountMoney(itemName, itemCount)

				local pickupLabel = ('~y~%s~s~ [~g~%s~s~]'):format(accountLabel, _U('locale_currency', ESX.Math.GroupDigits(itemCount)))
				ESX.CreatePickup('item_account', itemName, itemCount, pickupLabel, _source)
				xPlayer.showAdvancedNotification("Alma", "~y~Portefeuille", _U('threw_account', ESX.Math.GroupDigits(itemCount), string.lower(accountLabel)), 'CHAR_CALIFORNIA', 9)
			end
		end
	elseif type == 'item_weapon' then
		itemName = string.upper(itemName)

		if xPlayer.hasWeapon(itemName) then
			local weaponNum, weapon = xPlayer.getWeapon(itemName)
			xPlayer.removeWeapon(itemName)

			local pickupLabel = ('~y~%s~s~ [~g~%s~s~]'):format(weapon.label, weapon.ammo)
			ESX.CreatePickup('item_weapon', itemName, weapon.ammo, pickupLabel, _source, weapon.components)

			if weapon.ammo > 0 then
				xPlayer.showAdvancedNotification("Alma", "~y~Armes", _U('threw_weapon_ammo', weapon.label, weapon.ammo), 'CHAR_CALIFORNIA', 7)
			else
				xPlayer.showAdvancedNotification("Alma", "~y~Armes", _U('threw_weapon', weapon.label), 'CHAR_CALIFORNIA', 7)
			end
		end
	end
end)

Alma:AddEventHandler("Inventory", "UseItem", function(itemName)
    local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)

	if xItem then
		if xItem.count > 0 then
			ESX.UseItem(xPlayer.source, itemName)
		else
			Helper:showAdvancedNotification(xPlayer.source, "Alma", "~g~Inventaire", "Vous avez utiliser x1 de "..itemName, 'CHAR_CALIFORNIA', 7)
		end
	else
        return
	end
end)