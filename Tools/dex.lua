loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()



game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)

loadstring(game:HttpGet("https://raw.githubusercontent.com/Lyxia05/Roblox/refs/heads/main/DungeonQuest/DungeonQuest.lua?token=GHSAT0AAAAAAC2RUUA7N6EWQR5E5QNKHLOWZZYFFQQ"))()


local bodyGyro = Instance.new("BodyGyro")
bodyGyro.MaxTorque = Vector3.new(0, math.huge, 0) -- this ensures your monster only rotates around the Y-axis
bodyGyro.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
bodyGyro.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart