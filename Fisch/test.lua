_G.RodName = "Flimsy Rod"
_G.AutoSell = true

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local Debounce = false

local function GetRod()
    return LocalPlayer.Character:FindFirstChild(_G.RodName)
end

local function StartFishing()
    local Rod = GetRod()
    
    if not Rod then
        return
    end

    Rod.events.cast:FireServer(math.random(50, 99))
end

local function CatchFish()
    game:GetService("ReplicatedStorage").events.reelfinished:FireServer(100, true)
end

local function Reset()
    local Rod = GetRod()
    
    if not Rod then
        return
    end

    Rod.events.reset:FireServer()
end

local function SellAllFish()
    game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-937.869812, 132.771591, -1106.7666, -0.90052247, -0.00565089704, 0.434772611, 1.58466342e-08, 0.999915481, 0.0129963569, -0.434809327, 0.0117034651, -0.900446415))
    game.Players.LocalPlayer.Character:PivotTo(workspace.world.npcs["Max Merchant"]:GetPivot())
    workspace.world.npcs["Max Merchant"].merchant.sellall:InvokeServer()
end


while true do
    local shakeui = PlayerGui:FindFirstChild("shakeui")
    local reel = PlayerGui:FindFirstChild("reel")
    local distance = (game.Players.LocalPlayer.Character:GetPivot().Position - Vector3.new(-937.869812, 132.771591, -1106.7666)).Magnitude

    if distance >= 5 then
        game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-937.869812, 132.771591, -1106.7666, -0.90052247, -0.00565089704, 0.434772611, 1.58466342e-08, 0.999915481, 0.0129963569, -0.434809327, 0.0117034651, -0.900446415))
    end

    if shakeui then
        local Button = shakeui.safezone:FindFirstChild("button")
        for i,v in pairs(getconnections(Button.MouseButton1Down, Button.MouseButton1Click, Button.MouseButton1Up)) do
            v:Fire()
        end
    end
    
    if not shakeui and not reel then
        Reset()
        StartFishing()
    end
    
    if reel then
        CatchFish()

        if _G.AutoSell == true then
            SellAllFish()
        end

    end
    
    task.wait(3)
end

task.spawn(function()
    while true do
        game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-951, 150, -1115))
        wait()
    end
end)
game.Players.LocalPlayer.Character.HumanoidRootPart:PivotTo(workspace.world.map.halloween.witch.WitchesPot:GetPivot())

game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-937.869812, 132.771591, -1106.7666, -0.90052247, -0.00565089704, 0.434772611, 1.58466342e-08, 0.999915481, 0.0129963569, -0.434809327, 0.0117034651, -0.900446415))


setclipboard(tostring(game.Players.LocalPlayer.Character:GetPivot()))

setclipboard(tostring(game.JobId))

game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, "0f43b96a-b95a-4faf-b2e3-2b964b3a0e5b", game.Players.LocalPlayer)


0f43b96a-b95a-4faf-b2e3-2b964b3a0e5b

-- Enchant Enterance
game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-19.907938, 137.964539, -1128.47656, 0.925905943, 0.00368727092, -0.377735972, 3.00222851e-08, 0.999952376, 0.00976117048, 0.377753943, -0.00903788023, 0.925861835))

-- Down Enchant
game.Players.LocalPlayer.Character:PivotTo(CFrame.new(1308.83472, -803.820496, -99.0600815, -0.999974251, -7.29177846e-05, 0.00716413045, -6.87956012e-11, 0.999948204, 0.0101777008, -0.00716450112, 0.0101773795, -0.999922514))

local StrangeRoot = workspace.active:FindFirstChild("Strange Root")
game.Players.LocalPlayer.Character.HumanoidRootPart:PivotTo(StrangeRoot:GetPivot())

local StrangeRoot = workspace.active:FindFirstChild("Gaint Mushroom")
game.Players.LocalPlayer.Character.HumanoidRootPart:PivotTo(StrangeRoot:GetPivot())

local StrangeRoot = workspace.active:FindFirstChild("Dark Art Skull")
game.Players.LocalPlayer.Character.HumanoidRootPart:PivotTo(StrangeRoot:GetPivot())

local StrangeRoot = workspace.active:FindFirstChild("Spiders Eye")
game.Players.LocalPlayer.Character.HumanoidRootPart:PivotTo(StrangeRoot:GetPivot())

local ItemList = {
    "Strange Root",
    "Gaint Mushroom",
    "Dark Art Skull",
    "Spiders Eye",
}

for index, value in pairs(workspace.active:GetChildren()) do
    if table.find(ItemList, value.Name) then
        game.Players.LocalPlayer.Character.HumanoidRootPart:PivotTo(value:GetPivot() * CFrame.new(0, 20, 0))
    end
end


local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local Debounce = false
local shakeui = PlayerGui:FindFirstChild("shakeui")

if shakeui then
    local Button = shakeui.safezone:FindFirstChild("button")
    for i,v in pairs(getconnections(Button.MouseButton1Down, Button.MouseButton1Click, Button.MouseButton1Up)) do
        v:Fire()
    end
end


game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-200.831985, 133.982819, 1927.34448, -0.393193007, 0.0119344601, -0.919378519, 0, 0.999915719, 0.0129799144, 0.919456005, 0.00510361139, -0.393159896))
game.Players.LocalPlayer.Character:PivotTo(workspace.DA0ZA:GetPivot())

game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-1509.26648, 143.326874, 761.963318, -0.267143607, 0.00901480205, -0.963614523, 0, 0.99995625, 0.00935478602, 0.963656723, 0.00249907118, -0.267131925))


-- Traveling Merchant
game.Players.LocalPlayer.Character:PivotTo(CFrame.new(, 0.00249907118, -0.267131925))
game.Players.LocalPlayer.Character:PivotTo(workspace.world.npcs["Travelling Merchant"]:GetPivot())



https://www.roblox.com/share?code=86caeb39cf8bed4eb95fb68b6a6e3f66&type=Server

KEY_a1a6729b298f663ecdcb
KeongRacun1351

loadstring(game:HttpGet("https://raw.githubusercontent.com/Turtle-Brand/Turtle-Spy/main/source.lua", true))()

loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()

-- Script generated by TurtleSpy, made by Intrer#0421
game.Players.LocalPlayer.Character

while true do
    local Crate1 = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tools")
    local Crate2 = game.Players.LocalPlayer.Character:FindFirstChild("Peti Umpan Berkualitas")

    if Crate1 then
        Crate1.offer:FireServer(game:GetService("Players").DuoSerigala1354)
    end

    if Crate2 then
        Crate2.offer:FireServer(game:GetService("Players").DuoSerigala1354)
    end

    task.wait()
end

https://www.roblox.com/share?code=9eed0d782c13404fa73413beb303d1f6&type=Server

_G.Username = "TempeGoreng1354"

while true do
    for index, value in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if value:IsA("Tool") and value:FindFirstChild("offer") then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(value)
            value.offer:FireServer(game:GetService("Players")[_G.Username])
        end
    end

    task.wait(0.3)
end



game.Players.LocalPlayer.Character:PivotTo(workspace.world.npcs["Travelling Merchant"]:GetPivot())

local function ASD()
    local BLA = workspace.world.npcs:FindFirstChild("Travelling Merchant")

    if BLA then
        game.Players.LocalPlayer.Character:PivotTo(BLA:GetPivot())
    end
end

game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-1509.26648, 143.326874, 761.963318, -0.267143607, 0.00901480205, -0.963614523, 0, 0.99995625, 0.00935478602, 0.963656723, 0.00249907118, -0.267131925))
task.wait(5)
game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-200.831985, 133.982819, 1927.34448, -0.393193007, 0.0119344601, -0.919378519, 0, 0.999915719, 0.0129799144, 0.919456005, 0.00510361139, -0.393159896))
task.wait(5)
game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-19.907938, 137.964539, -1128.47656, 0.925905943, 0.00368727092, -0.377735972, 3.00222851e-08, 0.999952376, 0.00976117048, 0.377753943, -0.00903788023, 0.925861835))
task.wait(5)
game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-937.869812, 132.771591, -1106.7666, -0.90052247, -0.00565089704, 0.434772611, 1.58466342e-08, 0.999915481, 0.0129963569, -0.434809327, 0.0117034651, -0.900446415))
task.wait(5)
game.Players.LocalPlayer.Character:PivotTo(CFrame.new(2819, 131.978271, 2691.18872, 0.409354925, 2.59049784e-06, -0.912375212, 4.81721258e-07, 0.99999994, 3.11049507e-06, 0.912375212, -1.68074405e-06, 0.409354925))
task.wait(5)
game.Players.LocalPlayer.Character:PivotTo(workspace.world.npcs["Travelling Merchant"]:GetPivot())


https://www.roblox.com/share?code=9eed0d782c13404fa73413beb303d1f6&type=Server
TempeGoreng1354

akemi335763
DuoSerigala1354
KeongRacun1351
KudaKenceng01
MacanTutul003
xdaoz30
PempekPalembang1351
BebekKaleyo1122
BebekCarok1122

KEY_bd0d809766a2ec00c5fb
-- Script generated by TurtleSpy, made by Intrer#0421

workspace.world.npcs.Merlin.Merlin.power:InvokeServer()


_G.Username = "TempeGoreng1354"

while true do
    game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack["Enchant Relic"])
    task.wait(0.1)
    game.Players.LocalPlayer.Character["Enchant Relic"].offer:FireServer(game:GetService("Players")["TempeGoreng1354"])
    task.wait(0.1)
    game.Players.LocalPlayer.Character.Humanoid:UnequipTools(game.Players.LocalPlayer.Character["Enchant Relic"])
    task.wait(0.1)
end

game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-928.36261, 227.213318, -994.740906, 0.946196437, 0.0042249253, -0.323565036, -6.71191458e-08, 0.999914706, 0.0130561702, 0.323592633, -0.0123536251, 0.946115792))
workspace.world.npcs.Merlin.Merlin.power:InvokeServer()

game.Players.LocalPlayer.Character:PivotTo(CFrame.new(1308.83472, -803.820496, -99.0600815, -0.999974251, -7.29177846e-05, 0.00716413045, -6.87956012e-11, 0.999948204, 0.0101777008, -0.00716450112, 0.0101773795, -0.999922514))


game.Players.LocalPlayer.Character:PivotTo(workspace.world.npcs["Travelling Merchant"]:GetPivot())

game:GetService("ReplicatedStorage").events.runcode:FireServer("ThanksFor10Mil")
game:GetService("ReplicatedStorage").events.runcode:FireServer("FischFright2024")
game.Players.LocalPlayer.PlayerGui.hud.safezone.menu.menu_safezone.ChangeSetting:FireServer("showflags", false)

_G.Username = "LaptopLama66"


game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-1509.26648, 143.326874, 761.963318, -0.267143607, 0.00901480205, -0.963614523, 0, 0.99995625, 0.00935478602, 0.963656723, 0.00249907118, -0.267131925))
task.wait(5)
game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-937.869812, 132.771591, -1106.7666, -0.90052247, -0.00565089704, 0.434772611, 1.58466342e-08, 0.999915481, 0.0129963569, -0.434809327, 0.0117034651, -0.900446415))

game.Players.LocalPlayer.Character:PivotTo(workspace.world.npcs["Travelling Merchant"]:GetPivot())



game.Players.LocalPlayer.Character:PivotTo(workspace.world.npcs["Travelling Merchant"]:GetPivot())

game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-1509.26648, 143.326874, 761.963318, -0.267143607, 0.00901480205, -0.963614523, 0, 0.99995625, 0.00935478602, 0.963656723, 0.00249907118, -0.267131925))
task.wait(5)
game.Players.LocalPlayer.Character:PivotTo(workspace.world.npcs["Travelling Merchant"]:GetPivot())

game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-937.869812, 132.771591, -1106.7666, -0.90052247, -0.00565089704, 0.434772611, 1.58466342e-08, 0.999915481, 0.0129963569, -0.434809327, 0.0117034651, -0.900446415))
task.wait(5)
game.Players.LocalPlayer.Character:PivotTo(workspace.world.npcs["Travelling Merchant"]:GetPivot())

game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, "0f43b96a-b95a-4faf-b2e3-2b964b3a0e5b", game.Players.LocalPlayer)

game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-106.854942, 131.664642, 1896.6283, -0.993528545, 0.00134029833, -0.113574483, 4.70010386e-09, 0.999930382, 0.0118002482, 0.11358238, 0.0117238248, -0.993459344))
task.wait(5)
game.Players.LocalPlayer.Character:PivotTo(workspace.world.npcs["Travelling Merchant"]:GetPivot())


loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()
game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-1560.62256, -306.582123, -2825.1333, 0, 0, 1, 0, 1, -0, -1, 0, 0))
game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-1134.88416, -354.773987, -3241.31323, -0.573599219, 0, 0.81913656, 0, 1, 0, -0.81913656, 0, -0.573599219))
game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-959.122559, -287.589539, -2732.68164, 0, 0, 1, 0, 1, -0, -1, 0, 0))

game.Players.LocalPlayer.Character:PivotTo(workspace.world.map["Desolate Deep"].TridentTemple.Interactive.TridentGlyph:GetPivot())

game.Players.LocalPlayer.Character:PivotTo(workspace.world.spawns.DesolateDeep.spawn.CFrame * CFrame.new(0, 10, 0))

game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-1620.61267, -229.597656, -2904.6521, 0.999629378, -0.000293354358, 0.0272190813, -3.31113514e-09, 0.999941826, 0.0107770804, -0.0272206608, -0.0107730264, 0.999571323))


game.Players.LocalPlayer.Character:PivotTo(workspace.active.constant["Aurora Borealis"]:GetPivot())

game.Players.LocalPlayer.Character:PivotTo(workspace.kanamoru:GetPivot())

-- Aurora Rod
game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-143.693161, -513.694397, 1134.36511, 0.991619647, -0.00164267782, 0.1291807, -2.14712337e-08, 0.999919116, 0.012715321, -0.129191145, -0.0126087051, 0.991539478))

-- Aurora Totem
game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-1799.14319, -141.650131, -3300.59033, -0.092818059, 0.0129585043, -0.995598674, 4.85183872e-11, 0.999915242, 0.0130147478, 0.995683014, 0.00120799814, -0.0928101987))

-- Sundial totem
game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-1150, 135, -1075))

-- Down Enchant
game.Players.LocalPlayer.Character:PivotTo(CFrame.new(1308.83472, -803.820496, -99.0600815, -0.999974251, -7.29177846e-05, 0.00716413045, -6.87956012e-11, 0.999948204, 0.0101777008, -0.00716450112, 0.0101773795, -0.999922514))

-- Moosewood
game.Players.LocalPlayer.Character:PivotTo(CFrame.new(379.349854, 135.981995, 252.739365, 0.0654996559, -0.0129965823, 0.997767866, -4.99083885e-09, 0.999915063, 0.0130246123, -0.997852504, -0.000853108766, 0.0654940978))


local function AntiAfk()
    local virtualuser = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
        virtualuser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(5)
        virtualuser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end

AntiAfk()
game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-143.693161, -513.694397, 1134.36511, 0.991619647, -0.00164267782, 0.1291807, -2.14712337e-08, 0.999919116, 0.012715321, -0.129191145, -0.0126087051, 0.991539478))



function fireproximityprompt(ProximityPrompt, Amount, Skip)
    assert(ProximityPrompt, "Argument #1 Missing or nil")
    assert(typeof(ProximityPrompt) == "Instance" and ProximityPrompt:IsA("ProximityPrompt"), "Attempted to fire a Value that is not a ProximityPrompt")

    local HoldDuration = ProximityPrompt.HoldDuration
    if Skip then
        ProximityPrompt.HoldDuration = 0
    end

    for i = 1, Amount or 1 do
        ProximityPrompt:InputHoldBegin()
        if Skip then
            local RunService = game:GetService("RunService")
            local Start = time()
            repeat
                RunService.Heartbeat:Wait(0.1)
            until time() - Start > HoldDuration
        end
        ProximityPrompt:InputHoldEnd()
    end
    ProximityPrompt.HoldDuration = HoldDuration
end

for index, value in pairs(workspace.world.interactables["Crab Cage"]:GetDescendants()) do
	if value:IsA("ProximityPrompt") then
		fireproximityprompt(value, 1, false)
	end
end

-- Script generated by TurtleSpy, made by Intrer#0421

workspace.TempeGoreng1354["Crab Cage"].Deploy:FireServer({["CFrame"] = CFrame.new(352.419861, 126.5, 237.691803, 0.0708025619, 1.26874795e-07, 0.997490346, -9.70334124e-09, 1, -1.26505256e-07, -0.997490346, -7.22093052e-10, 0.0708025619)})


-- Script generated by TurtleSpy, made by Intrer#0421

workspace.TempeGoreng1354["Colossal Squid"].offer:FireServer(game:GetService("Players").LaptopLama11)



task.wait(5)

_G.Username = "LaptopLama11"

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
    while wait(1) do
        if game.Players.LocalPlayer.leaderstats.Level.Value > 0 and game.Players.LocalPlayer.DoneLoading.Value == true and game.Players.LocalPlayer.assetsloaded.Value == true then
            GiveAllToolsToUser()
        end
    end
end)

_G.Active = false


_G.Active = true
_G.Username = "DuoSerigala1354"

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
    while task.wait(1) do
        if _G.Active == true then
            if game.Players.LocalPlayer.leaderstats.Level.Value > 0 and game.Players.LocalPlayer.DoneLoading.Value == true and game.Players.LocalPlayer.assetsloaded.Value == true then
                GiveAllToolsToUser()
            end
        end
    end
end)

workspace.active.boats["DuoSerigala1354"].Jetski:PivotTo(CFrame.new(2819, 131.978271, 2691.18872, 0.409354925, 2.59049784e-06, -0.912375212, 4.81721258e-07, 0.99999994, 3.11049507e-06, 0.912375212, -1.68074405e-06, 0.409354925))

workspace.active.boats["DuoSerigala1354"].Jetski:PivotTo(CFrame.new(-143.693161, -500.694397, 1134.36511, 0.991619647, -0.00164267782, 0.1291807, -2.14712337e-08, 0.999919116, 0.012715321, -0.129191145, -0.0126087051, 0.991539478))

workspace.active.boats["KeongRacun1351"]["Luxury Speedboat"]:PivotTo(CFrame.new(-143.693161, -505.694397, 1134.36511, 0.991619647, -0.00164267782, 0.1291807, -2.14712337e-08, 0.999919116, 0.012715321, -0.129191145, -0.0126087051, 0.991539478))

workspace.active.boats["DuoSerigala1354"].Jetski:PivotTo(workspace.world.map["Desolate Deep"].TridentTemple.Interactive.TridentGlyph:GetPivot())

workspace.active.boats["DuoSerigala1354"].Jetski:PivotTo(CFrame.new(1308.83472, -803.820496, -99.0600815, -0.999974251, -7.29177846e-05, 0.00716413045, -6.87956012e-11, 0.999948204, 0.0101777008, -0.00716450112, 0.0101773795, -0.999922514))

workspace.active.boats["KeongRacun1351"]["Luxury Speedboat"]:PivotTo(workspace.world.map["Desolate Deep"].TridentTemple.Interactive.TridentGlyph:GetPivot())

workspace.active.boats["DuoSerigala1354"].Jetski:PivotTo(CFrame.new(-1799.14319, -141.650131, -3300.59033, -0.092818059, 0.0129585043, -0.995598674, 4.85183872e-11, 0.999915242, 0.0130147478, 0.995683014, 0.00120799814, -0.0928101987))

-- Aurora totem jet ski
workspace.active.boats["DuoSerigala1354"].Jetski:PivotTo(CFrame.new(-1799.14319, -138.650131, -3300.59033, -0.092818059, 0.0129585043, -0.995598674, 4.85183872e-11, 0.999915242, 0.0130147478, 0.995683014, 0.00120799814, -0.0928101987))

--
workspace.active.boats["DuoSerigala1354"].Jetski:PivotTo(CFrame.new(379.349854, 135.981995, 252.739365, 0.0654996559, -0.0129965823, 0.997767866, -4.99083885e-09, 0.999915063, 0.0130246123, -0.997852504, -0.000853108766, 0.0654940978))
