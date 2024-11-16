print("Loaded 11")
_G.RodName = "Aurora Rod"
_G.Username = "TempeGoreng1354"

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
    while true do
        local shakeui = PlayerGui:FindFirstChild("shakeui")
        local reel = PlayerGui:FindFirstChild("reel")
        local distance = (game.Players.LocalPlayer.Character:GetPivot().Position - Vector3.new(2819, 131.978271, 2691.18872)).Magnitude
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait()
        local _playerToGive = Players:FindFirstChild(_G.Username)

        if not _playerToGive and Character and not Character:FindFirstChild(_G.RodName) then
            Character.Humanoid:EquipTool(LocalPlayer.Backpack[_G.RodName])
        end

        if distance >= 5 then
            game.Players.LocalPlayer.Character:PivotTo(CFrame.new(2819, 131.978271, 2691.18872, 0.409354925, 2.59049784e-06, -0.912375212, 4.81721258e-07, 0.99999994, 3.11049507e-06, 0.912375212, -1.68074405e-06, 0.409354925))
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

task.spawn(function()
    while true do
        local _playerToGive = Players:FindFirstChild(_G.Username)
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait()
        local reel = PlayerGui:FindFirstChild("reel")

        if _playerToGive and _playerToGive.leaderstats.Level.Value > 0 and _playerToGive.DoneLoading.Value == true and _playerToGive.assetsloaded.Value == true and not reel then

            if Character and Character:FindFirstChild(_G.RodName) then
                Character.Humanoid:UnequipTools(Character[_G.RodName])
            end

            GiveAllToolsToUser()
        end

        task.wait(0.1)
    end
end)