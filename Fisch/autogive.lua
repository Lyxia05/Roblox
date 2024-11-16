_G.Username = "Ayuuuchi1"

task.spawn(function()
    while task.wait() do
        if game.Players.LocalPlayer.Character:FindFirstChild("Enchant Relic") then
            workspace.KeongRacun1351["Enchant Relic"].offer:FireServer(game:GetService("Players")[_G.Username])
        end
    end
end)