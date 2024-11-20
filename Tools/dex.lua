loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()


loadstring(game:HttpGet("https://raw.githubusercontent.com/Lyxia05/Roblox/refs/heads/main/DungeonQuest/DungeonQuest.lua?token=GHSAT0AAAAAAC2RUUA6L7BYD3HJZPAAMIRQZZ6HJSQ"))()

local bodyPosition = Instance.new("BodyPosition")
bodyPosition.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 10, 0)
bodyPosition.MaxForce = Vector3.new(0, math.huge, 0)
bodyPosition.P = 3000
bodyPosition.D = 100 
bodyPosition.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart