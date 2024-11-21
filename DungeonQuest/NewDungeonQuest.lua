if game.PlaceId == 2414851778 then
    return
end

--
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

--
local LocalPlayer = Players.LocalPlayer
local DungeonFolder = workspace.dungeon

--
local Speed = 80
local CURRENT_OBJECT = nil

----- AUTO FARM SECTION -----
-- Function: Get time from distance and speed
local function GetTime(Distance)
	-- Time = Distance / Speed
	local Time = Distance / Speed
	return Time
end

-- Function: Get Character
local function GetCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function Tween(instance, t, properties)
    local tweenInfo = TweenInfo.new(
        t,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    )

    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
end

-- Function: Get Closest Monster
local function getClosestMonster()
    local Character = GetCharacter()

    if not Character or not Character:FindFirstChild("HumanoidRootPart") then
        return nil
    end

    local closest = {Monster = nil, Magnitude = math.huge}
    local playerPosition = Character.HumanoidRootPart.Position

    for _, folder in ipairs(DungeonFolder:GetChildren()) do
        if folder:IsA("Folder") and folder:FindFirstChild("enemyFolder") then
            for _, enemy in ipairs(folder.enemyFolder:GetChildren()) do
                if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                    local magnitude = (enemy.HumanoidRootPart.Position - playerPosition).Magnitude
                    if magnitude < closest.Magnitude then
                        closest = {Monster = enemy, Magnitude = magnitude}
                    end
                end
            end
        end
    end

    return closest.Monster
end

local function AutoFarming()
    local Character = GetCharacter()

    if not Character or not Character:FindFirstChild("HumanoidRootPart") then
        return
    end

    -- If no valid target or current target is dead, find a new one
    if not CURRENT_OBJECT or not CURRENT_OBJECT:FindFirstChild("Humanoid") or CURRENT_OBJECT.Humanoid.Health <= 0 then
        -- Find the closest valid monster
        CURRENT_OBJECT = getClosestMonster()

        -- If no valid monster found, return
        if not CURRENT_OBJECT then
            return
        end
    end

    local Distance = (CURRENT_OBJECT:GetPivot().Position - Character.HumanoidRootPart.Position).Magnitude
    local MonsterSize = CURRENT_OBJECT.HumanoidRootPart.Size.Y
    local Radius = 7

    if MonsterSize >= 40 then
        Radius = 30
    end

    -- Move to target
    Tween(Character.HumanoidRootPart, GetTime(Distance), {CFrame = CURRENT_OBJECT:GetPivot() * CFrame.new(0, Radius, 0) * CFrame.Angles(math.rad(-90), 0, math.rad(90))})
end

task.spawn(function()
    while true do
        AutoFarming()
        task.wait() -- Adjust attack delay as needed
    end
end)

-- Start Dungeon
game:GetService("ReplicatedStorage").remotes.changeStartValue:FireServer()

-- KILL AURA SECTION --
local KILLAURA_ARGS = {{{["animationLength"] = 0,["sentAt"] = 1731719231.958339},"\145"}}
task.spawn(function()
    while true do
        game:GetService("ReplicatedStorage").dataRemoteEvent:FireServer(unpack(KILLAURA_ARGS))
        task.wait()
    end
end)

-- AUTO SKILL SECTION --
task.spawn(function()
    local args = {{{["\t"] = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rejuvenating Spray")},"J"}}
    while true do
        game:GetService("ReplicatedStorage").dataRemoteEvent:FireServer(unpack(args))
        task.wait(2)
    end
end)

----- NO CLIP SECTION -----
-- Function to ensure no duplicate BodyVelocity instances
local function ensureBodyVelocity(rootPart)
    if not rootPart:FindFirstChild("BodyVelocity1") then
        -- Create BodyVelocity and set properties
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Name = "BodyVelocity1"
        bodyVelocity.Parent = rootPart
        bodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    end
end

-- Function to disable collision for all character parts
local function disableCollisions(character)
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

task.spawn(function()
    while task.wait() do
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid") then
            local rootPart = character.HumanoidRootPart
            local humanoid = character.Humanoid

            -- Set PlatformStand to true for the humanoid
            humanoid.PlatformStand = true

            -- Ensure the humanoid is not sitting
            if humanoid.Sit then
                humanoid.Sit = false
            end

            -- Add BodyVelocity if it doesn't already exist
            ensureBodyVelocity(rootPart)

            -- Disable collisions for all character parts
            disableCollisions(character)
        end
    end
end)