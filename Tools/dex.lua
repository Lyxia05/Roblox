loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()

loadstring(game:HttpGet("https://raw.githubusercontent.com/Lyxia05/Roblox/refs/heads/main/DungeonQuest/NewDungeonQuest.lua"))()

loadstring(game:HttpGet("https://raw.githubusercontent.com/Lyxia05/Roblox/refs/heads/main/DungeonQuest/NewDungeonQuest.lua?token=GHSAT0AAAAAAC2RUUA6PBPOII4DVYDGHL5KZ2BMEYQ"))()


workspace.kerse.HumanoidRootPart.BodyPosition:Destroy()


for index, value in pairs(game.Players.LocalPlayer.PlayerGui:GetDescendants()) do
    if value:IsA("TextBox") and value.Text == "7" then
        value.Text = "999999"
    end
end