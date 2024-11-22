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

-- Local Variables
local LocalPlayer = PlayerService.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local DungeonFolder = workspace.dungeon

-- Script Settings
local Speed = 25 -- Movement speed
local CURRENT_OBJECT = nil
local LAST_UPDATE = os.clock()
local TargetPosition = nil

-- Function: Get Closest Monster
local function getClosestMonster()
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

-- Function: Smooth Movement Without Physics
local function MoveToTarget(targetPosition)
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then
        return
    end

    -- Interpolate smoothly to the target position
    local rootPart = Character.HumanoidRootPart
    local distance = (rootPart.Position - targetPosition).Magnitude
    local travelTime = distance / Speed
    local startTime = os.clock()

    -- Define the target orientation
    local targetRotation = CFrame.Angles(math.rad(-90), 0, math.rad(90))

    -- Update position and orientation frame-by-frame
    while os.clock() - startTime < travelTime and _G.Enabled do
        local elapsed = os.clock() - startTime
        local alpha = math.clamp(elapsed / travelTime, 0, 1)
        local newPosition = rootPart.Position:Lerp(targetPosition, alpha)

        -- Update position with constant orientation
        rootPart.CFrame = CFrame.new(newPosition) * targetRotation
        task.wait(0.01)
    end

    -- Snap to the final position and orientation
    if _G.Enabled then
        rootPart.CFrame = CFrame.new(targetPosition) * targetRotation
    end
end

-- Function: AutoFarming Logic
local function AutoFarming()
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

    -- Calculate destination
    local targetPosition = CURRENT_OBJECT:GetPivot().Position + Vector3.new(0, CURRENT_OBJECT.HumanoidRootPart.Size.Y + 8, 0)

    -- Move to target
    MoveToTarget(targetPosition)
end

-- Start Dungeon
game:GetService("ReplicatedStorage").remotes.changeStartValue:FireServer()

-- Farming Loop
task.spawn(function()
    while true do
        if not _G.Enabled then break end
        AutoFarming()
        task.wait(0.1) -- Adjust as needed
    end
end)

-- Attack Loop
task.spawn(function()
    while true do
        if not _G.Enabled then break end
        game:GetService("ReplicatedStorage").dataRemoteEvent:FireServer(unpack(KILLAURA_ARGS))
        task.wait() -- Adjust attack delay as needed
    end
end)

-- Prevent Falling and Bounce (By Disabling Collisions)
local function setupCharacter()
    if not Character then
        return
    end

    local rootPart = Character:WaitForChild("HumanoidRootPart")
    
    -- Disable collisions for the HumanoidRootPart
    rootPart.CanCollide = false

    -- Disable collisions for all other parts
    for _, part in pairs(Character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end

    -- Set up body position for floating
    local bodyPosition = Instance.new("BodyPosition")
    bodyPosition.Position = rootPart.Position + Vector3.new(0, 8, 0) -- Float 10 studs above the current position
    bodyPosition.MaxForce = Vector3.new(0, math.huge, 0) -- Allow only upward force
    bodyPosition.P = 3000 -- Adjust responsiveness
    bodyPosition.D = 100 -- Damping for smooth movement
    bodyPosition.Parent = rootPart

    -- Set PlatformStand to avoid physics interaction
    Character.Humanoid.PlatformStand = true
end

-- Handling Respawn
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    setupCharacter() -- Re-setup when character respawns
end)

-- Prevent Falling and Bounce (By Disabling Collisions)
RunService.RenderStepped:Connect(function()
    if Character and Character:FindFirstChild("Humanoid") then
        if _G.Enabled then
            -- Prevent physics effects by disabling collisions
            Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            Character.Humanoid.PlatformStand = true

            -- Disable collisions for the HumanoidRootPart
            local rootPart = Character.HumanoidRootPart
            rootPart.CanCollide = false

            -- Disable collisions for all other parts
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        else
            -- Enable collisions when not moving
            Character.Humanoid.PlatformStand = false
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end)

-- Initial setup when the script starts
setupCharacter()