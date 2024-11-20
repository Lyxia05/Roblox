print("Loaded 11")
_G.RodName = "Flimsy Rod"
_G.Enabled = true
_G.SavedCF = CFrame.new(-2677.74146, 166.230133, 1751.73364, 0.172691628, -0.0184644088, 0.984802723, -0.00562378066, 0.999789417, 0.0197316147, -0.984959722, -0.00894575007, 0.172551438)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

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

local function GiveAllToolsToUser()
    for index, value in pairs(LocalPlayer.Backpack:GetChildren()) do
        if value:IsA("Tool") and value:FindFirstChild("offer") then
            LocalPlayer.Character.Humanoid:EquipTool(value)
            if Players:FindFirstChild(_G.Username) then
                value.offer:FireServer(Players[_G.Username])
            end
        end

        task.wait(0.1)
    end
end

AntiAfk()

task.spawn(function()
    while _G.Enabled == true do
        local shakeui = PlayerGui:FindFirstChild("shakeui")
        local reel = PlayerGui:FindFirstChild("reel")
        local distance = (game.Players.LocalPlayer.Character:GetPivot().Position - _G.SavedCF.Position).Magnitude
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait()

        if Character and not Character:FindFirstChild(_G.RodName) then
            Character.Humanoid:EquipTool(LocalPlayer.Backpack[_G.RodName])
        end

        if distance >= 5 then
            game.Players.LocalPlayer.Character:PivotTo(_G.SavedCF)
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
end)