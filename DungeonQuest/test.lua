local bodyPosition = Instance.new("BodyPosition")
bodyPosition.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 1000, 0) -- Float 10 studs above the current position
bodyPosition.MaxForce = Vector3.new(0, math.huge, 0) -- Allow only upward force
bodyPosition.P = 3000 -- Adjust responsiveness
bodyPosition.D = 100 -- Damping for smooth movement
bodyPosition.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart



game.Players.LocalPlayer.Character.HumanoidRootPart.BodyPosition.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position