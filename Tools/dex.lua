loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()



game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)

loadstring(game:HttpGet("https://raw.githubusercontent.com/Lyxia05/Roblox/refs/heads/main/DungeonQuest/DungeonQuest.lua?token=GHSAT0AAAAAAC2RUUA6D6ISAS7Y6UROLCEKZZYGKWA"))()

_G.Number = 10

game:GetService("RunService").RenderStepped:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(_G.Number)
end)


local bodyGyro = Instance.new("BodyGyro")
bodyGyro.MaxTorque = Vector3.new(0, math.huge, 0) -- this ensures your monster only rotates around the Y-axis
bodyGyro.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 50, 0))
bodyGyro.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)


local HumanoidRootPart =  game.Players.LocalPlayer.Character.HumanoidRootPart
local BodyVelocity = Instance.new("BodyVelocity")
BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
BodyVelocity.Velocity = HumanoidRootPart.CFrame.LookVector
BodyVelocity.Parent = HumanoidRootPart

