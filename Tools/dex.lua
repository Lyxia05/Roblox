loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()

loadstring(game:HttpGet("https://raw.githubusercontent.com/Lyxia05/Roblox/refs/heads/main/DungeonQuest/NewDungeonQuest.lua"))()

loadstring(game:HttpGet("https://raw.githubusercontent.com/Lyxia05/Roblox/refs/heads/main/DungeonQuest/NewDungeonQuest.lua?token=GHSAT0AAAAAAC2RUUA7CAWWJX62ME7XYBY4Z2BMGLA"))()

loadstring(game:HttpGet("https://raw.githubusercontent.com/Lyxia05/Roblox/refs/heads/main/DungeonQuest/NewDungeonQuest.lua"))()


workspace.kerse.HumanoidRootPart.BodyPosition:Destroy()


for index, value in pairs(game.Players.LocalPlayer.PlayerGui:GetDescendants()) do
    if value:IsA("TextBox") and value.Text == "7" then
        value.Text = "999999"
    end
end


workspace.dungeonProgress.Value = "bossKilled"