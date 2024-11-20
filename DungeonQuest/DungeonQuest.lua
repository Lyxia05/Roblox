if game.PlaceId == 2414851778 then
    return
end

if not game:IsLoaded() then
    game.Loaded:Wait()
end

_G.Enabled = true

-- SETTINGS --
local KILLAURA_ARGS = {
    [1] = {
        [1] = {
            ["animationLength"] = 0,
            ["sentAt"] = 1731719231.958339
        },
        [2] = "\145"
    }
}

-- Services
local TweenService = game:GetService("TweenService")
local PlayerService = game:GetService("Players")
local RunService = game:GetService("RunService")

--
local LocalPlayer = PlayerService.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

--
local DungeonFolder = workspace.dungeon

--
local Speed = 50
local CURRENT_OBJECT = nil
local DELAY = false
local SAVED_CF = nil

--
local CFrameObject = Instance.new("CFrameValue")
CFrameObject.Value = LocalPlayer.Character:GetPivot()
CFrameObject.Parent = workspace

local bodyPosition = Instance.new("BodyPosition")
bodyPosition.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 10, 0)
bodyPosition.MaxForce = Vector3.new(0, math.huge, 0)
bodyPosition.P = 3000
bodyPosition.D = 100 
bodyPosition.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart

--
local function Tween(object, time, properties)
    local NewTweenInfoTable = TweenInfo.new(
        time, -- Time
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out, 
        0, -- RepeatCount (-1 = Infinite)
        false, -- Reverse tween after finishing
        0 -- DelayTime
    )

    local tween = TweenService:Create(object, NewTweenInfoTable, properties)
    tween:Play()
end

local function Nocl()
    if game.Players.LocalPlayer.Character ~= nil then
        for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
                v.CanCollide = false
            end
        end
    end
    wait(0.21) -- basic optimization
end

local function GetTime(Distance, Speed)
	-- Time = Distance / Speed
	local Time = Distance / Speed
	return Time
end

local function getClosestMonster()
    if Character == nil then
        return nil
    end

    if not Character:FindFirstChild("HumanoidRootPart") then
        return nil
    end

    local closest = {Monster = nil, Magnitude = 0}
    local playerPosition = Character:WaitForChild("HumanoidRootPart").Position

    for index, value in pairs(DungeonFolder:GetChildren()) do
        if value:IsA("Folder") then

            if Status == true then
                break
            end

            if value:FindFirstChild("enemyFolder") then
                for index, value2 in pairs(value.enemyFolder:GetChildren()) do

                    if value2:IsA("Model") and value2:FindFirstChild("HumanoidRootPart") and value2.Humanoid.Health > 0 then
    
                        local targetPosition = value2.HumanoidRootPart.Position
                        local magnitude = (targetPosition - playerPosition).Magnitude
    
                        if magnitude < closest.Magnitude or closest.Magnitude == 0 then
                            --if closer then,
                            closest["Monster"] = value2; closest["Magnitude"] = magnitude
                        end
    
                    end
    
                end
            end

        end
    end

    return closest.Monster
end

local function AutoFarming()
    if Character == nil then
        return
    end

    local Monster = getClosestMonster()
    
    if Monster == nil then
        return
    end

    local _distance = (Monster:GetPivot().Position - Character.HumanoidRootPart.Position).Magnitude
    Tween(CFrameObject, GetTime(_distance, Speed), {Value = Monster:GetPivot()})
end

game:GetService("ReplicatedStorage").remotes.changeStartValue:FireServer()

CFrameObject.Changed:Connect(function()
    bodyPosition.Position = CFrameObject.Value.Position
end)

task.spawn(function()
    while true do
        if _G.Enabled == false then
            break
        end
        AutoFarming()
        task.wait()
    end
end)

task.spawn(function()
    while true do
        if _G.Enabled == false then
            break
        end
        game:GetService("ReplicatedStorage").dataRemoteEvent:FireServer(unpack(KILLAURA_ARGS))
        task.wait()
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    Character = LocalPlayer.Character

    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    bodyPosition = Instance.new("BodyPosition")
    bodyPosition.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 10, 0)
    bodyPosition.MaxForce = Vector3.new(0, math.huge, 0)
    bodyPosition.P = 3000
    bodyPosition.D = 100 
    bodyPosition.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
end)

game:GetService("RunService").RenderStepped:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(10)
end)

for index, value in pairs(workspace:GetDescendants()) do
    if value:IsA("BasePart") then
        value.CanCollide = false
    end
end