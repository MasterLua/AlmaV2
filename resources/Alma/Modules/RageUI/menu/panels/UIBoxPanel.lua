local BoxSettings = {
    itemPerLine = 5,
    width = 215,
    height = 120,
    space = 5
}

function RageUI.RenderBox(Items)
    local lastLine = 0;
    for k, v in ipairs(VisualitionCaisse[Items]) do
        local x = 442 + (((k -1) - (BoxSettings.itemPerLine * lastLine)) * (BoxSettings.width + BoxSettings.space))
        local y = (lastLine * (BoxSettings.height + BoxSettings.space))
        RenderSprite("vehicles", v.model, x, y, BoxSettings.width, BoxSettings.height, 0, 255, 255, 255, 255)
        if math.tointeger(k / BoxSettings.itemPerLine) ~= nil then
            lastLine = math.tointeger(k / BoxSettings.itemPerLine)
        end
    end
end