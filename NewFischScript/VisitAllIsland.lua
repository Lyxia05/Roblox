for index, value in pairs(workspace.world.spawns.TpSpots:GetChildren()) do
    game.Players.LocalPlayer.Character:PivotTo(value.CFrame)
    task.wait(2)
end