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
local CURRENT_OBJECT = nil
local DELAY = false

--
local function Tween(object, tweenInfo, properties)
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
end

local function GetTarget()
    for index, value in pairs(DungeonFolder:GetDescendants()) do
        if value:IsA("Humanoid") and value.Parent:IsA("Model") and value.Parent:FindFirstChild("HumanoidRootPart") and value.Parent.Parent.Name == "enemyFolder" and string.find(string.lower(value.Parent.Parent.Parent.Name), "room") then
            local _distance = (Character.HumanoidRootPart.Position - value.Parent.HumanoidRootPart.Position).Magnitude
            if _distance < 500 then
                CURRENT_OBJECT = value.Parent
                break
            end
        end
    end
end

local function AutoFarming()
    if DELAY == true then
        return
    end

    if CURRENT_OBJECT == nil then
        GetTarget()
    end

    if CURRENT_OBJECT ~= nil then
        Tween(Character.HumanoidRootPart, TweenInfo.new(0.01), {CFrame = CFrame.new(CURRENT_OBJECT:GetPivot().Position + Vector3.new(0, 7, 0), CURRENT_OBJECT:GetPivot().Position)})
    end
end

task.spawn(function()
    while true do
        if _G.Enabled == false then
            break
        end
        game:GetService("ReplicatedStorage").dataRemoteEvent:FireServer(unpack(KILLAURA_ARGS))
        task.wait()
    end
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