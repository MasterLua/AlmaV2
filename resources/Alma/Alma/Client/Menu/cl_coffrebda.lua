COFFRE_BDA = function()
    local COFFE_DB = RageUI.CreateMenu("Coffre BDA", "Coffre BDA")
    local INDEX_COFFRE = 1;

    RageUI.Visible(COFFE_DB, not RageUI.Visible(COFFE_DB))

    while COFFE_DB do
        Citizen.Wait(0)
        RageUI.IsVisible(COFFE_DB, function()
            RageUI.Separator("↓ Coffre BMA : ~g~"..ESX.Table.SizeOf(TABLE_BDA).."~s~ ↓")
            RageUI.List("Filtre", {
                { Name = "~r~Acheter~s~", Value = 1 },
                { Name = "~g~Vendre~s~", Value = 2 }
            }, INDEX_COFFRE, nil, {}, true, {
                onListChange = function(Index)
                    INDEX_COFFRE = Index;
                end
            })
            if INDEX_COFFRE == 1 then
                for k,v in pairs(TABLE_BDA) do
                    RageUI.Button(v.name, v.name, {RightLabel = "~r~-"..ESX.Math.GroupDigits(v.price).."$" }, true, {
                        onActive = function()
                            Visual.PromptDuration(1, "Object : "..v.name.." / Prix : "..ESX.Math.GroupDigits(v.price).."$", true)
                        end,
                        onSelected = function()
                            Visual.Subtitle("Sended !")
                            Alma:TriggerServerEvent("BMA", "DropItem", v.value)
                        end
                    })
                end
            else
                for k,v in pairs(TABLE_BDA) do
                    RageUI.Button(v.name, v.name, {RightLabel = "~g~+"..ESX.Math.GroupDigits(v.price / 2).."$" }, true, {
                        onActive = function()
                            Visual.PromptDuration(1, "Object : "..v.name.." / Prix : "..ESX.Math.GroupDigits(v.price/2).."$", true)
                        end,
                        onSelected = function()
                            Alma:TriggerServerEvent("BMA", "SellItem", v.value)
                        end
                    })
                end
            end
        end)
        if not RageUI.Visible(COFFE_DB) then
            COFFE_DB = RMenu:DeleteType("COFFE_DB", true)
        end
    end
end