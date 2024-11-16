loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()

local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character

for index, value in pairs(workspace.dungeon:GetDescendants()) do
    if value:IsA("Humanoid") and value.Parent:IsA("Model") and value.Parent:FindFirstChild("HumanoidRootPart") then
        Character:PivotTo(value.Parent:GetPivot())
        break
    end
end

workspace.enemies


-- SETTINGS --
local KILLAURA_ARGS = {
    [1] = {
        [1] = {
            ["animationLength"] = 0,
            ["sentAt"] = 1731710655.385174
        },
        [2] = "\145"
    }
}





-- Services
local TweenService = game:GetService("TweenService")
local PlayerService = game:GetService("Players")

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
        if value:IsA("Humanoid") and value.Parent:IsA("Model") and value.Parent:FindFirstChild("HumanoidRootPart") and string.find(string.lower(value.Parent.Parent.Parent.Name), "room") then
            local _distance = (Character.HumanoidRootPart.Position - value.Parent.HumanoidRootPart.Position).Magnitude
            if _distance < 100 then
                CURRENT_OBJECT = value.Parent
                break
            end
        end
    end
end

local function AutoFarming()
    if CURRENT_OBJECT == nil then
        GetTarget()
    end

    if CURRENT_OBJECT.Humanoid.Health <= 0 then

    end

    Tween(Character.HumanoidRootPart, TweenInfo.new(0.01), {CFrame = CURRENT_OBJECT:GetPivot() * CFrame.new(0, 10, 0)})
end





-- Auto Farm Loops
task.spawn(function()
    while true do
        AutoFarming()
        task.wait()
    end
end)

-- Kill Aura Loops
task.spawn(function()
    while true do
        game:GetService("ReplicatedStorage").dataRemoteEvent:FireServer(unpack(KILLAURA_ARGS))
        task.wait()
    end
end)