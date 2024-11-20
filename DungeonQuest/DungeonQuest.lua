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
local ClipEnabled = false
local SAVED_TWEEN = nil
local LAST_UPDATE = os.clock()

--
local bodyPosition = Instance.new("BodyPosition")
bodyPosition.Position = Character.HumanoidRootPart.Position
bodyPosition.MaxForce = Vector3.new(0, math.huge, 0) -- Allow only upward force
bodyPosition.P = 3000 -- Adjust responsiveness
bodyPosition.D = 100 -- Damping for smooth movement
bodyPosition.Parent = Character.HumanoidRootPart

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

    return tween
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

    local closest = {Monster = nil, Magnitude = 0, Size = 0}
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
                            closest["Monster"] = value2
                            closest["Magnitude"] = magnitude
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

    if not Character:FindFirstChild("HumanoidRootPart") then
        return
    end

    if os.clock() - LAST_UPDATE >= 10 then
        LAST_UPDATE = os.clock()
        ClipEnabled = false
        CURRENT_OBJECT = getClosestMonster()
        return
    end

    if CURRENT_OBJECT == nil then
        LAST_UPDATE = os.clock()
        ClipEnabled = false
        CURRENT_OBJECT = getClosestMonster()
        return
    end

    if CURRENT_OBJECT ~= nil and CURRENT_OBJECT:FindFirstChild("Humanoid") and CURRENT_OBJECT.Humanoid.Health <= 0 then
        LAST_UPDATE = os.clock()
        ClipEnabled = false
        CURRENT_OBJECT = getClosestMonster()
        return
    end

    Character.HumanoidRootPart["BodyPosition"].Position = CURRENT_OBJECT:GetPivot().Position + Vector3.new(0, 10, 0)
end

game:GetService("ReplicatedStorage").remotes.changeStartValue:FireServer()

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
    bodyPosition.Position = HumanoidRootPart.Position + Vector3.new(0, 1000, 0) -- Float 10 studs above the current position
    bodyPosition.MaxForce = Vector3.new(0, math.huge, 0) -- Allow only upward force
    bodyPosition.P = 3000 -- Adjust responsiveness
    bodyPosition.D = 100 -- Damping for smooth movement
    bodyPosition.Parent = HumanoidRootPart
end)