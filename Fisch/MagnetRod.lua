_G.RodName = "Magnet Rod"

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local Debounce = false

local function AntiAfk()
    local virtualuser = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
    virtualuser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(5)
    virtualuser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end

local function GetRod()
    return LocalPlayer.Character:FindFirstChild(_G.RodName)
end

local function StartFishing()
    local Rod = GetRod()
    
    if not Rod then
        return
    end

    Rod.events.cast:FireServer(math.random(95, 99))
end

local function CatchFish()
    game:GetService("ReplicatedStorage").events.reelfinished:FireServer(100, true)
end

local function Reset()
    local Rod = GetRod()
    
    if not Rod then
        return
    end

    Rod.events.reset:FireServer()
end

local function SellAllFish()
    workspace.world.npcs["Marc Merchant"].merchant.sellall:InvokeServer()
end

AntiAfk()

while true do
    local shakeui = PlayerGui:FindFirstChild("shakeui")
    local reel = PlayerGui:FindFirstChild("reel")
    local distance = (game.Players.LocalPlayer.Character:GetPivot().Position - Vector3.new(-937.869812, 132.771591, -1106.7666)).Magnitude

    if distance >= 5 then
        game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-937.869812, 132.771591, -1106.7666, -0.90052247, -0.00565089704, 0.434772611, 1.58466342e-08, 0.999915481, 0.0129963569, -0.434809327, 0.0117034651, -0.900446415))
    end

    if shakeui then
        local Button = shakeui.safezone:FindFirstChild("button")
        for i,v in pairs(getconnections(Button.MouseButton1Down, Button.MouseButton1Click, Button.MouseButton1Up)) do
            v:Fire()
        end
    end
    
    if not shakeui and not reel then
        Reset()
        StartFishing()
    end
    
    if reel then
        CatchFish()
    end
    
    task.wait(3)
end