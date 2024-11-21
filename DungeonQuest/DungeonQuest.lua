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

-- Function: Move to Target Without Physics (Smooth Movement)
local function MoveToTarget(targetPosition)
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then
        return
    end

    local rootPart = Character.HumanoidRootPart
    local distance = (rootPart.Position - targetPosition).Magnitude
    local travelTime = distance / Speed
    local startTime = os.clock()

    -- Define the constant orientation
    local targetRotation = CFrame.Angles(math.rad(-90), 0, math.rad(90))

    -- Move smoothly while updating the CFrame
    while os.clock() - startTime < travelTime and _G.Enabled do
        local elapsed = os.clock() - startTime
        local alpha = math.clamp(elapsed / travelTime, 0, 1)
        local newPosition = rootPart.Position:Lerp(targetPosition, alpha)

        -- Update position with constant orientation
        rootPart.CFrame = CFrame.new(newPosition) * targetRotation
        task.wait(0.01)  -- Fine-tune to control frame rate if needed
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
    TargetPosition = CURRENT_OBJECT:GetPivot().Position + Vector3.new(0, CURRENT_OBJECT.HumanoidRootPart.Size.Y + 7, 0)

    -- Move to target
    MoveToTarget(TargetPosition)
end

-- Farming Loop
task.spawn(function()
    while true do
        if not _G.Enabled then break end
        AutoFarming()
        task.wait(0.1)
    end
end)

-- Attack Loop
task.spawn(function()
    while true do
        if not _G.Enabled then break end
        game:GetService("ReplicatedStorage").dataRemoteEvent:FireServer(unpack(KILLAURA_ARGS))
        task.wait()
    end
end)

-- Prevent Falling and Bounce (By Disabling Collisions and Gravity)
local function setupCharacter()
    if not Character then
        return
    end

    local rootPart = Character:WaitForChild("HumanoidRootPart")

    -- Disable collisions for the HumanoidRootPart and all parts
    for _, part in pairs(Character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end

    -- Disable gravity and velocity to stop unwanted movement
    Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    Character.Humanoid.PlatformStand = true
end

-- Handling Respawn
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    setupCharacter() -- Re-setup when character respawns
end)

-- RunService to continuously disable collisions and gravity during movement
RunService.RenderStepped:Connect(function()
    if Character and Character:FindFirstChild("Humanoid") then
        if _G.Enabled then
            -- If no target is found, keep the character floating and prevent gravity
            if not CURRENT_OBJECT then
                -- Ensure character stays in place by setting velocity to zero
                Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            else
                -- Prevent physics effects by disabling collisions while moving
                Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
                Character.Humanoid.PlatformStand = true
            end

            -- Disable collisions for all parts
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