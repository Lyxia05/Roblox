local FISHING_LOCATION = {
    Forsaken = CFrame.new(-2677.74146, 166.230133, 1751.73364, 0.172691628, -0.0184644088, 0.984802723, -0.00562378066, 0.999789417, 0.0197316147, -0.984959722, -0.00894575007, 0.172551438),
    Vertigo1 = CFrame.new(-108.59536, -732.282532, 1213.84302, -0.98443377, 0.00203714357, -0.175743878, 4.63249439e-10, 0.999932766, 0.0115908245, 0.17575568, 0.0114103416, -0.984367669),
    TheDeep = CFrame.new(882.475342, -729.294128, 1413.83472, -0.999941826, -0.00624589343, -0.00878501311, -0.00643274561, 0.999750137, 0.0214039907, 0.00864913687, 0.0214592069, -0.999732316),
    DesolateDeep = CFrame.new(-1506.9646, -233.237518, -2869.48242, 0.656646132, 0.00910964701, -0.754143715, 3.0863287e-08, 0.999926984, 0.0120786615, 0.75419873, -0.00793139171, 0.65659827),
    BrinePool = CFrame.new(-1788.32031, -141.208832, -3365.67188, 0.00191510259, 0.0108346511, -0.999939382, 1.43107526e-09, 0.99994123, 0.0108347302, 0.999998093, -2.07509383e-05, 0.00191499013),
    Snow = CFrame.new(2819, 131.978271, 2691.18872, 0.409354925, 2.59049784e-06, -0.912375212, 4.81721258e-07, 0.99999994, 3.11049507e-06, 0.912375212, -1.68074405e-06, 0.409354925),
}

_G.RodName = "No-Life Rod"
_G.FishingLocation = CFrame.new(1311.47632, -740.062012, 1437.86377, 0.900073349, 0.00408399943, -0.435719192, 5.53390146e-06, 0.999955893, 0.00938408542, 0.435738325, -0.00844872184, 0.900033653)
_G.Enabled = false
_G.WaitTime = 1

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local LastShake = os.clock()
local LastSell = os.clock()

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
    for index, value in pairs(workspace.world.npcs:GetDescendants()) do
        if value.Name == "sellall" and value.Parent.Name == "merchant" then
            value:InvokeServer()
        end
    end
end

task.spawn(function()
    AntiAfk()
    while _G.Enabled == true do
        local shakeui = PlayerGui:FindFirstChild("shakeui")
        local reel = PlayerGui:FindFirstChild("reel")
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait()

        if Character and not Character:FindFirstChild(_G.RodName) then
            Character.Humanoid:EquipTool(LocalPlayer.Backpack[_G.RodName])
        end
    
        if shakeui then
            local Button = shakeui.safezone:FindFirstChild("button")
            for i,v in pairs(getconnections(Button.MouseButton1Down, Button.MouseButton1Click, Button.MouseButton1Up)) do
                v:Fire()
            end
        end

        if os.clock() - LastShake >= 30 then
            game.Players.LocalPlayer.Character:PivotTo(_G.FishingLocation)
        end
        
        if not shakeui and not reel then
            Reset()
            StartFishing()
            task.wait(1)
        end
        
        if reel then
            LastShake = os.clock()
            CatchFish()
        end
        
        task.wait(_G.WaitTime)
    end
end)

task.spawn(function()
    while _G.Enabled == true do
        local distance = (game.Players.LocalPlayer.Character:GetPivot().Position - _G.FishingLocation.Position).Magnitude

        if distance >= 5 then
            game.Players.LocalPlayer.Character:PivotTo(_G.FishingLocation)
        end
        task.wait()
    end
end)