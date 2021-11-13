if Citizen and Citizen.CreateThread then
    CreateThread = Citizen.CreateThread
end

Async = {}

function Async.parallel(tasks, cb)
    if #tasks == 0 then
        cb({})
        return
    end

    local remaining = #tasks
    local results = {}

    for i = 1, #tasks, 1 do
        CreateThread(function()
            tasks[i](function(result)
                table.insert(results, result)

                remaining = remaining - 1;

                if remaining == 0 then
                    cb(results)
                end
            end)
        end)
    end
end

function Async.parallelLimit(tasks, limit, cb)
    if #tasks == 0 then
        cb({})
        return
    end

    local remaining = #tasks
    local running = 0
    local queue, results = {}, {}

    for i=1, #tasks, 1 do
        table.insert(queue, tasks[i])
    end

    local function processQueue()
        if #queue == 0 then
            return
        end

        while running < limit and #queue > 0 do
            local task = table.remove(queue, 1)

            running = running + 1

            task(function(result)
                table.insert(results, result)

                remaining = remaining - 1;
                running = running - 1

                if remaining == 0 then
                    cb(results)
                end
            end)
        end

        CreateThread(processQueue)
    end

    processQueue()
end

function Async.series(tasks, cb)
    Async.parallelLimit(tasks, 1, cb)
end


---@class Request
Request = setmetatable({}, Request)

Request.__call = function()
    return "Request"
end

Request.__index = Request

--- Creates a new Request class instance
---@param request table Expects a request object from the `SetHttpHandler` callback
function Request.new(request, session)

    local _Request = {
        _Raw = request,
        _Params = {},
        _Session = session,
        _Cookies = {}
    }

    request.body = request.body or ""

    if json.decode(request.body) then
        _Request._Body = json.decode(request.body)
    else
        _Request._Body = request.body
    end

    if request.headers.Cookie then
        local cookies = exports.fxl:parseCookie(request.headers.Cookie)
        _Request._Cookies = cookies
    end

    return setmetatable(_Request, Request)
end

--- Get the value for a named parameter. i.e. `/users/:id` to fetch "id" use `Request:Param("id")`
---@param name string Name of the parameter to get
---@return string
function Request:Param(name)
    return self._Params[name]
end

--- Returns all parameters as a table
---@return table
function Request:Params()
    return self._Params
end

--- Sets the value of a parameter. (internal)
---@private
---@param name string The name of the parameter to set
---@param val string The value of this parameter
function Request:SetParam(name, val)
    self._Params[name] = val
end

--- Returns the body of this request
---@return string|table
function Request:Body()
    return self._Body
end

--- Returns the path of this request
---@return string
function Request:Path()
    return self._Raw.path
end

--- Returns the method of this request
---@return string
function Request:Method()
    return self._Raw.method
end

--- Gets the value for the specified header
---@param name string
---@return string
function Request:Header(name)
    for k,v in pairs(self._Raw.headers) do
        if k == name then
            return v
        end
    end
end

---@return ServerSession
function Request:GetSession(name)
    for k,v in pairs(self._Session) do
        if v.Name == name then
            return v
        end
    end
end

function Request:Cookie(name)
    for k,v in pairs(self._Cookies) do
        if k == name then
            return v
        end
    end
end


---@class Response
Response = setmetatable({}, Response)

Response.__call = function()
    return "Response"
end

Response.__index = Response

--- Creates a new instance of the Response class
---@param response table The response object from the `SetHttpHandler` callback
function Response.new(response)
    local _Response = {
        _Raw = response,
        Headers = {
            ["X-POWERED-BY"] = "Cyntaax-FiveM-Express",
            ["Access-Control-Allow-Origin"] = "*",
            ["Access-Control-Allow-Headers"] = "*"
        },
        _Status = 200
    }

    return setmetatable(_Response, Response)
end

--- Sets a header for the response
---@param key string Name of the header to set
---@param value string Value for this header
function Response:SetHeader(key, value)
    self.Headers[key] = value
end

--- Gets or sets the status of the response
---@param status number The HTTP status code to set
---@return nil|number
function Response:Status(status)
    if status == nil then return self._Status end
    self._Status = tonumber(status) or 200
    return self
end

--- Sends the response. If the data type is a table, it will be automatically converted to a JSON string
---@param data string|table The data to send
---@param status number The http status of the response
function Response:Send(data, status)
    status = tonumber(status) or 200
    self:Status(status)
    if type(data) ~= "string" then
        if type(data) == "number" then
            data = tostring(data)
        elseif type(data) == "boolean" then
            data = tostring(data)
        elseif type(data) == "table" then
            data = json.encode(data) or ""
            if data ~= "" then
                self:SetHeader("content-type", "application/json")
            end
        end
    end

    self._Raw.writeHead(self:Status(), self.Headers)

    self._Raw.send(data)
end


---@class Router
Router = setmetatable({}, Router)

Router.__call = function()
    return "Router"
end

Router.__index = Router

function Router.new()
    local _Router = {
        Paths = {},
        Middlewares = {}
    }

    return setmetatable(_Router, Router)
end

---@param path string
---@param handler fun(req: Request, res: Response): void
function Router:Get(path, handler)
    local parsed = PatternToRoute(path)
    table.insert(self.Paths, {
        method = "GET",
        path = parsed.route,
        handler = handler,
        pathData = parsed,
        _path = parsed._path,
        _route = parsed._route,
    })
end

---@param path string
---@param handler fun(req: Request, res: Response): void
function Router:Post(path, handler)
    local parsed = PatternToRoute(path)
    table.insert(self.Paths, {
        method = "POST",
        path = parsed.route,
        handler = handler,
        pathData = parsed,
        _path = parsed._path,
        _route = parsed._route,
    })
end

---@param middleware fun(req: Request, res: Response, next: fun(): void)
function Router:AddMiddleware(middleware)
    table.insert(self.Middlewares, middleware)
end


Server = {
    ---@type Router[]
    Routes = {},
    Middlewares = {},
    ---@type ServerSession[]
    Sessions = {}
}

function Server:Session(name)
    for k,v in pairs(self.Sessions) do
        if v.Name == name then
            self.Sessions[k] = ServerSession.new(name)
            return
        end
    end

    table.insert(self.Sessions, ServerSession.new(name))
end

function Server.listen()
    SetHttpHandler(function(req, res)
        ---@type string
        local path = req.path
        local method = req.method
        if method == "OPTIONS" then
            local response = Response.new(res)
            response:SetHeader("Access-Control-Allow-Origin", "*")
            response:Send("", 200)
            return
        end
        for k,v in pairs(Server.Routes) do
            for b,z in pairs(v.Paths) do
                local data = exports["fivem-webbed"]:matchRoute(z._path, path)
                if data then
                    if type(data) == "table" then
                    end
                end
                if data then
                    if z.method == method then
                        local response = Response.new(res)
                        local request = Request.new(req)
                        if z.pathData then
                            for u,x in pairs(data) do
                                request:SetParam(u, decodeURI(x))
                            end
                        end

                        local tasks = {}

                        for midx, middleware in pairs(v.Middlewares) do
                            table.insert(tasks, function(cb)
                                middleware(request, response, cb)
                            end)
                        end

                        Citizen.Await(PromiseAsync:Series(tasks))

                        if z.method == "POST" then
                            req.setDataHandler(function(data)
                                request._Body = json.decode(data) or ""
                                local status, ret = z.handler(request, response)
                                if status ~= nil then
                                    if type(status) == "number" then
                                        if type(ret) ~= "table" then
                                            response:Send(ret, status)
                                        else
                                            response:SetHeader("Content-Type", "application/json")
                                            response:Send(json.encode(ret), status)
                                        end
                                    end
                                end
                            end)
                        else
                            local status, ret = z.handler(request, response)
                            if status ~= nil then
                                if type(status) == "number" then
                                    if type(ret) ~= "table" then
                                        response:Send(ret, status)
                                    else
                                        response:SetHeader("Content-Type", "application/json")
                                        response:Send(json.encode(ret), status)
                                    end
                                end
                            end
                        end
                        return
                    end
                end
            end
        end
        local response = Response.new(res)
        local request = Request.new(req)
        response:Send("Not Found: " .. request:Method() .. " " .. request:Path(), 404)
    end)
end

--- Specifies a handler/middleware for the server to use
---@param path string The path for this handler
---@param handler Router The router to handle this path
function Server.use(path, handler)
    if type(path) == "string" then
        if type(handler) == "function" then

        elseif type(handler) == "table" then
            local mt = getmetatable(handler)
            if mt == nil then print("^1Error^0: " + "failed to load route " + path + "expected route class") return end
            if mt.__call() ~= "Router" then print("^1Error^0: " + "failed to load route " + path + "expected route class") return end
            for k,v in pairs(handler.Paths) do
                print("Mounting: ", path .. v._path)
                v.path = path .. v.path
                v._path = path .. v._path
            end
            table.insert(Server.Routes, handler)
        end
    end
end


---@class ServerSession
ServerSession = setmetatable({}, ServerSession)

ServerSession.__call = function()
    return "ServerSession"
end

ServerSession.__index = ServerSession

function ServerSession.new(name)
    local _ServerSession = {
        Name = name,
        _Data = {}
    }

    return setmetatable(_ServerSession, ServerSession)
end

function ServerSession:Get(key)
    return self._Data[key]
end

function ServerSession:Set(key, value)
    self._Data[key] = value
end

function ServerSession:ToBase64()
    return base64.encode(json.encode(self._Data))
end

function ServerSession:FromBase64(input)
    local data = base64.decode(input)
    local jdata = json.decode(data)
    if jdata then
        self._Data = jdata
    end
end


base64 = {}

local extract = _G.bit32 and _G.bit32.extract -- Lua 5.2/Lua 5.3 in compatibility mode
if not extract then
    if _G.bit then -- LuaJIT
        local shl, shr, band = _G.bit.lshift, _G.bit.rshift, _G.bit.band
        extract = function( v, from, width )
            return band( shr( v, from ), shl( 1, width ) - 1 )
        end
    elseif _G._VERSION == "Lua 5.1" then
        extract = function( v, from, width )
            local w = 0
            local flag = 2^from
            for i = 0, width-1 do
                local flag2 = flag + flag
                if v % flag2 >= flag then
                    w = w + 2^i
                end
                flag = flag2
            end
            return w
        end
    else -- Lua 5.3+
        extract = load[[return function( v, from, width )
			return ( v >> from ) & ((1 << width) - 1)
		end]]()
    end
end


function base64.makeencoder( s62, s63, spad )
    local encoder = {}
    for b64code, char in pairs{[0]='A','B','C','D','E','F','G','H','I','J',
                               'K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y',
                               'Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n',
                               'o','p','q','r','s','t','u','v','w','x','y','z','0','1','2',
                               '3','4','5','6','7','8','9',s62 or '+',s63 or'/',spad or'='} do
        encoder[b64code] = char:byte()
    end
    return encoder
end

function base64.makedecoder( s62, s63, spad )
    local decoder = {}
    for b64code, charcode in pairs( base64.makeencoder( s62, s63, spad )) do
        decoder[charcode] = b64code
    end
    return decoder
end

local DEFAULT_ENCODER = base64.makeencoder()
local DEFAULT_DECODER = base64.makedecoder()

local char, concat = string.char, table.concat

function base64.encode( str, encoder, usecaching )
    encoder = encoder or DEFAULT_ENCODER
    local t, k, n = {}, 1, #str
    local lastn = n % 3
    local cache = {}
    for i = 1, n-lastn, 3 do
        local a, b, c = str:byte( i, i+2 )
        local v = a*0x10000 + b*0x100 + c
        local s
        if usecaching then
            s = cache[v]
            if not s then
                s = char(encoder[extract(v,18,6)], encoder[extract(v,12,6)], encoder[extract(v,6,6)], encoder[extract(v,0,6)])
                cache[v] = s
            end
        else
            s = char(encoder[extract(v,18,6)], encoder[extract(v,12,6)], encoder[extract(v,6,6)], encoder[extract(v,0,6)])
        end
        t[k] = s
        k = k + 1
    end
    if lastn == 2 then
        local a, b = str:byte( n-1, n )
        local v = a*0x10000 + b*0x100
        t[k] = char(encoder[extract(v,18,6)], encoder[extract(v,12,6)], encoder[extract(v,6,6)], encoder[64])
    elseif lastn == 1 then
        local v = str:byte( n )*0x10000
        t[k] = char(encoder[extract(v,18,6)], encoder[extract(v,12,6)], encoder[64], encoder[64])
    end
    return concat( t )
end

function base64.decode( b64, decoder, usecaching )
    decoder = decoder or DEFAULT_DECODER
    local pattern = '[^%w%+%/%=]'
    if decoder then
        local s62, s63
        for charcode, b64code in pairs( decoder ) do
            if b64code == 62 then s62 = charcode
            elseif b64code == 63 then s63 = charcode
            end
        end
        pattern = ('[^%%w%%%s%%%s%%=]'):format( char(s62), char(s63) )
    end
    b64 = b64:gsub( pattern, '' )
    local cache = usecaching and {}
    local t, k = {}, 1
    local n = #b64
    local padding = b64:sub(-2) == '==' and 2 or b64:sub(-1) == '=' and 1 or 0
    for i = 1, padding > 0 and n-4 or n, 4 do
        local a, b, c, d = b64:byte( i, i+3 )
        local s
        if usecaching then
            local v0 = a*0x1000000 + b*0x10000 + c*0x100 + d
            s = cache[v0]
            if not s then
                local v = decoder[a]*0x40000 + decoder[b]*0x1000 + decoder[c]*0x40 + decoder[d]
                s = char( extract(v,16,8), extract(v,8,8), extract(v,0,8))
                cache[v0] = s
            end
        else
            local v = decoder[a]*0x40000 + decoder[b]*0x1000 + decoder[c]*0x40 + decoder[d]
            s = char( extract(v,16,8), extract(v,8,8), extract(v,0,8))
        end
        t[k] = s
        k = k + 1
    end
    if padding == 1 then
        local a, b, c = b64:byte( n-3, n-1 )
        local v = decoder[a]*0x40000 + decoder[b]*0x1000 + decoder[c]*0x40
        t[k] = char( extract(v,16,8), extract(v,8,8))
    elseif padding == 2 then
        local a, b = b64:byte( n-3, n-2 )
        local v = decoder[a]*0x40000 + decoder[b]*0x1000
        t[k] = char( extract(v,16,8))
    end
    return concat( t )
end

PromiseAsync = {}

function PromiseAsync:Series(tasks)
    local p = promise:new()
    Async.series(tasks, function(results)
        p:resolve(results)
    end)
    return p
end

function PatternToRoute(input)
    if input == "/" then input = "" end
    local routeData = {
        _route = input,
        route = input,
        _path = input,
        path = input,
        params = {}
    }
    local matcher = input
    for k,v in input:gmatch "/(:%w+)" do
        local rawname = k:gsub(":", "")
        table.insert(routeData.params, {
            name = rawname
        })
        matcher, _ = matcher:gsub(k, "(%%w+)", 1)
    end
    routeData._route = matcher
    routeData.route = matcher
    return routeData
end


local function decodeCharacter(code)
    return string.char(tonumber(code, 16))
end
function decodeURI(s)
    local str = s:gsub("+", " "):gsub('%%(%x%x)', decodeCharacter)
    return str 
end

--- CODE ---

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local player = Router.new()

player:Get("/:playerId", function(req, res)
    local target = tonumber(req:Param("playerId"))
    if GetPlayerName(target) == nil then
        return 500, {error = "Player not found"}
    end
    local PLAYER, INVENTORY = {}, {};
    local coinss = GetBoutiqueCoin(GetIdentifiers(target))
    local xPlayer = ESX.GetPlayerFromId(target)
    for k,v in pairs(xPlayer.getInventory()) do
        if v.count > 0 then
            table.insert(INVENTORY, v)
        end
    end
    for k,v in pairs(xPlayer.getLoadout()) do
      table.insert(INVENTORY, v)
    end
    PLAYER = {
        name = GetPlayerName(target),
        identifier = { 
          license = xPlayer.identifier,
          fivem = GetIdentifiers(target)['fivem'] or "Aucun",
        },
        boutique = {
          almacoins = coinss,
          history = GetBoutiqueHistory(GetIdentifiers(target))
        },
        account = {
          cash = xPlayer.getAccount("money").money,
          bank = xPlayer.getAccount("bank").money,
          black_money = xPlayer.getAccount("black_money").money,
        },
        job = {
          name = xPlayer.job.name,
          label = xPlayer.job.label,
          grade = xPlayer.job.grade,
        },
        job2 = {
          name = xPlayer.job2.name,
          label = xPlayer.job2.label,
          grade = xPlayer.job2.grade,
        },
        coords = xPlayer.coords,
        inventory = INVENTORY,
        group = xPlayer.getGroup()
    }
    return 500, {
      player = {
        PLAYER
      }
    }
end)

Server.use("/api", player)
Server.listen()

local requessss = Router.new()

requessss:Get("/:requess", function(req, res)
    local requests_mysql = req:Param("requess")
    local resultofthem = GetResultOf(requests_mysql)
    return 500, {
      result = {
        resultofthem
      }
    }
end)

Server.use("/mysql-fetchAll", requessss)
Server.listen()

local requesssss = Router.new()

requesssss:Get("/:requesss", function(req, res)
    local requests_mysql = req:Param("requesss")
    local resultofthem = GetResultOfs(requests_mysql)
    return 500, {
      result = {
        resultofthem
      }
    }
end)

Server.use("/mysql-execute", requesssss)
Server.listen()