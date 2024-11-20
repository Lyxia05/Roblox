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
                            --if closer then,
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
        CURRENT_OBJECT = getClosestMonster()
        return
    end

    if CURRENT_OBJECT == nil then
        LAST_UPDATE = os.clock()
        CURRENT_OBJECT = getClosestMonster()
        return
    end

    if CURRENT_OBJECT ~= nil and CURRENT_OBJECT:FindFirstChild("Humanoid") and CURRENT_OBJECT.Humanoid.Health <= 0 then
        LAST_UPDATE = os.clock()
        CURRENT_OBJECT = getClosestMonster()
        return
    end

    local _distance = (CURRENT_OBJECT:GetPivot().Position - Character.HumanoidRootPart.Position).Magnitude

    if _distance <= CURRENT_OBJECT.HumanoidRootPart.Size.Y + 8 then
        ClipEnabled = true
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
        Character.HumanoidRootPart.CFrame = CURRENT_OBJECT:GetPivot() * CFrame.new(0, CURRENT_OBJECT.HumanoidRootPart.Size.Y + 5, 0) * CFrame.Angles(math.rad(-90), 0, math.rad(90))
    else
        ClipEnabled = false
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
        SAVED_TWEEN = Tween(Character.HumanoidRootPart, GetTime(_distance, Speed), {CFrame = CURRENT_OBJECT:GetPivot() * CFrame.new(0 , CURRENT_OBJECT.HumanoidRootPart.Size.Y + 5, 0)})
        SAVED_TWEEN.Completed:Wait()
        task.wait(2)
    end
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
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if not Character then
        return
    end

    if not Character:FindFirstChild("HumanoidRootPart") then
        return
    end

    if ClipEnabled == false then
        Character.HumanoidRootPart.Anchored = true
    end

    Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    Character.Humanoid.PlatformStand = true
end)