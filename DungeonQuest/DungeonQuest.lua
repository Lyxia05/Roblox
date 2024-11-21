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
local Speed = 50 -- Movement speed
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
        CURRENT_OBJECT = getClosestMonster()
        return
    end

    -- Calculate destination
    TargetPosition = CURRENT_OBJECT:GetPivot().Position + Vector3.new(0, CURRENT_OBJECT.HumanoidRootPart.Size.Y + 8, 0)

    -- Move to target
    MoveToTarget(TargetPosition)
end

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

    -- Set up BodyVelocity for controlled movement
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(5000, 5000, 5000) -- Allows enough force to move the character
    bodyVelocity.Velocity = Vector3.new(0, 0, 0) -- Initially set the velocity to zero
    bodyVelocity.Parent = rootPart

    -- Set up a gentle upward force to prevent falling through the ground
    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000) -- Keep the rotation stable
    bodyGyro.CFrame = rootPart.CFrame -- Lock rotation to the current CFrame
    bodyGyro.Parent = rootPart

    -- Use RunService to apply velocity continuously for smoother control
    local lastPosition = rootPart.Position
    RunService.RenderStepped:Connect(function(_, dt)
        if not Character then return end

        local currentPosition = rootPart.Position
        local distanceTraveled = (currentPosition - lastPosition).Magnitude
        lastPosition = currentPosition

        -- Apply a light upward velocity only if falling (Y component of velocity)
        if currentPosition.Y < 5 then  -- If the character is close to the ground
            bodyVelocity.Velocity = Vector3.new(0, 10, 0)  -- Apply light upward force
        else
            bodyVelocity.Velocity = Vector3.new(0, bodyVelocity.Velocity.Y, 0) -- Keep current Y velocity
        end

        -- Apply horizontal velocity based on the target position
        if TargetPosition then
            local direction = (TargetPosition - currentPosition).Unit
            local horizontalVelocity = direction * Speed
            bodyVelocity.Velocity = horizontalVelocity + Vector3.new(0, bodyVelocity.Velocity.Y, 0)
        end
    end)

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