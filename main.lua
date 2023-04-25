--[[
                                       
,--.                                                
|  |    ,---.,--.  ,--.,---. ,--,--,  ,---.  ,---.  
|  |   | .-. |\  `'  /| .-. :|      \(  .-' | .-. : 
|  '--.' '-' ' \    / \   --.|  ||  |.-'  `)\   --. 
`-----' `---'   `--'   `----'`--''--'`----'  `----' 
                                                    
    Control your Lovense toy with Roblox by Bri

]]

local Lovense = {}

--Options
Lovense.debugmode = false;
Lovense.AutoObtainHost = true;
Lovense.Host = "";

local HttpService = game:GetService("HttpService")

function Lovense.GetHost()
    local Req = HttpService:GetAsync("https://api.lovense.com/api/lan/getToys")
    local Response = HttpService:JSONDecode(Req);

    local domain = Response.domain;
    local port = Response.httpsPort;

    if Lovense.debugmode == true then
        print("[Lovense] Response: " .. Response.Body)
        print("[Lovense] Device ID: " .. Response.deviceId);
        print("[Lovense] Platform: " .. Response.platform);
        print("[Lovense] Domain: " .. Response.domain);
        print("[Lovense] Port: " .. Response.httpsPort);
    end

    if domain == nil then
        error("Error")
    else
        return domain..":".. port
    end
end

if Lovense.AutoObtainHost == true then
    Lovense.Host = Lovense.GetHost();
else
    error("Error")
end

function Lovense.GetToyInfo()
    local Req = HttpService:GetAsync(Lovense.Host .. "/GetToys")
    local Response = HttpService:JSONDecode(Req);
    if Lovense.debugmode == true then
        print(Response.data)
    else
        --
    end
    return Response.data
end

function Lovense.Domain()
    print(Lovense.Host);
end
function Lovense.GetBattery()
    local Req = HttpService:GetAsync(Lovense.Host .. "/Battery");
    local Response = HttpService:JSONDecode(Req);
    print("Battery Output: " .. Response.battery);
    return Response.battery
end

--Functions for handling vibration & rotation requests
function Lovense.Vibrate(speed, length)
    if speed > 20 then -- Max intensity is 20
        print('[Lovense] Intensity is too high! Please use a number between 0 - 20.');
        return 
    else
        -- <3
    end
    
    local Req = HttpService:GetAsync(Lovense.Host .. "/AVibrate?v=" .. speed .. "&sec=" .. length);
    local Response = HttpService:JSONDecode(Req);

    print("[Lovense] Started vibrating at speed " .. speed .. " for " .. length .. " seconds.");

    if Lovense.debugmode == true then
        print(Response.data);
    else
        --
    end
end

return Lovense
