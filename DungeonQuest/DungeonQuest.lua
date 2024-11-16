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
local Speed = 100
local CURRENT_OBJECT = nil
local DELAY = false
local SAVED_CF = nil

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

local function GetTime(Distance, Speed)
	-- Time = Distance / Speed
	local Time = Distance / Speed
	return Time
end

local function GetTarget()
    local Status = false

    for index, value in pairs(DungeonFolder:GetChildren()) do
        if value:IsA("Folder") then

            if Status == true then
                break
            end

            for index, value2 in pairs(value.enemyFolder:GetChildren()) do

                if value2:IsA("Model") and value2:FindFirstChild("HumanoidRootPart") then
                    Status = true
                    CURRENT_OBJECT = value2
                    break
                end

            end

        end
    end
end

local function AutoFarming()
    if Character == nil then
        return
    end

    if DELAY == true then
        return
    end

    if CURRENT_OBJECT == nil then
        GetTarget()
    end

    if CURRENT_OBJECT ~= nil then
        if not Character:FindFirstChild("HumanoidRootPart") then
            return
        end

        local _distance = (CURRENT_OBJECT:GetPivot().Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        if _distance >= 30 then
            SAVED_CF = CURRENT_OBJECT:GetPivot().Position + Vector3.new(0, CURRENT_OBJECT.attackDistance.Value + 5, 0)
            Tween(Character.HumanoidRootPart, GetTime(_distance, Speed), {CFrame = CURRENT_OBJECT:GetPivot() * CFrame.new(0, CURRENT_OBJECT.attackDistance.Value, 0)})
            task.wait(GetTime(_distance, Speed))
        end

        local _distanceBetweenSaved = (SAVED_CF.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude

        if _distanceBetweenSaved <= 30 then
            Character:PivotTo(CFrame.new(SAVED_CF, CURRENT_OBJECT:GetPivot().Position))
        end

        if CURRENT_OBJECT.Humanoid.Health <= 0 then
            CURRENT_OBJECT = nil
        end
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
    task.wait(2)
    Character = LocalPlayer.Character
end)

game:GetService("RunService").RenderStepped:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(5)
end)