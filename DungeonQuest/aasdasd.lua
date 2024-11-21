local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

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

-- Function to ensure no duplicate BodyVelocity instances
local function ensureBodyVelocity(rootPart)
    if not rootPart:FindFirstChild("BodyVelocity1") then
        -- Create BodyVelocity and set properties
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Name = "BodyVelocity1"
        bodyVelocity.Parent = rootPart
        bodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
        bodyVelocity.Velocity = Vector3.zero
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