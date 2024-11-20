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

for index, value in pairs(workspace.world.chests:GetDescendants()) do
    if value:IsA("ProximityPrompt") then
        fireproximityprompt(value, 1, true)
    end
end

task.spawn(function()
    while task.wait(3) do
        for index, value in pairs(workspace.active:GetDescendants()) do
            if value:IsA("ProximityPrompt") then
                fireproximityprompt(value, 1, true)
            end
        end
        task.wait()
    end
end)

task.spawn(function()
    while task.wait() do
        if game.Players.LocalPlayer.Character:FindFirstChild("Crab Cage") then
            workspace.DuoSerigala1354["Crab Cage"].Deploy:FireServer({["CFrame"] = CFrame.new(-1638.27991, -240, -2904.13745, 0.372501403, -8.45894288e-09, 0.928031623, 1.0400508e-08, 1, 4.94028285e-09, -0.928031623, 7.81173792e-09, 0.372501403)})
        end
    end
end)

workspace.DA0ZA["Crab Cage"].Deploy:FireServer({["CFrame"] = CFrame.new(-1638.27991, -240, -2904.13745, 0.372501403, -8.45894288e-09, 0.928031623, 1.0400508e-08, 1, 4.94028285e-09, -0.928031623, 7.81173792e-09, 0.372501403)})
