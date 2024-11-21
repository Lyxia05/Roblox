_G.Username = "kanamoru"
_G.Enabled = false

local function GiveAllToolsToUser()
    for index, value in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if value:IsA("Tool") and value:FindFirstChild("offer") then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(value)
            if game.Players:FindFirstChild(_G.Username) then
                value.offer:FireServer(game.Players[_G.Username])
            end
        end
    end
end

task.spawn(function()
    while _G.Enabled do
        if game.Players.LocalPlayer.leaderstats.Level.Value > 0 and game.Players.LocalPlayer.DoneLoading.Value == true and game.Players.LocalPlayer.assetsloaded.Value == true then
            GiveAllToolsToUser()
        end
        task.wait(1)
    end
end)