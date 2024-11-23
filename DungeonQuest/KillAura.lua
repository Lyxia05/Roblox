local PACKS = {
    args0 = {
        [1] = {
            [1] = {
                ["animationIndex"] = 0,
                ["sentAt"] = 1732331059.475885
            },
            [2] = "\162"
        }
    },

    args1 = {
        [1] = {
            [1] = {
                ["animationIndex"] = 1,
                ["sentAt"] = 1732331059.475885
            },
            [2] = "\162"
        }
    },

    args2 = {
        [1] = {
            [1] = {
                ["animationIndex"] = 2,
                ["sentAt"] = 1732331030.1644
            },
            [2] = "\162"
        }
    },
    
    args3 = {
        [1] = {
            [1] = {
                ["animationIndex"] = 3,
                ["sentAt"] = 1732331050.258777
            },
            [2] = "\162"
        }
    }
}

local AnimationObject_1 = Instance.new("Animation")
AnimationObject_1.AnimationId = "rbxassetid://91994339000643"
AnimationObject_1.Parent = game.Players.LocalPlayer.Character

local AnimationObject_2 = Instance.new("Animation")
AnimationObject_2.AnimationId = "rbxassetid://132363319545954"
AnimationObject_2.Parent = game.Players.LocalPlayer.Character

local AnimationObject_3 = Instance.new("Animation")
AnimationObject_3.AnimationId = "rbxassetid://74447788907886"
AnimationObject_3.Parent = game.Players.LocalPlayer.Character

local GreatSword = {
    "rbxassetid://91994339000643",
    "rbxassetid://132363319545954",
    "rbxassetid://74447788907886"
}

local Staff = {
    "rbxassetid://115030158661285",
    "rbxassetid://118125784297768",
    "rbxassetid://110836226084253",
}

local DualSword = {
    "rbxassetid://13740049334",
    "rbxassetid://13740049269",
    "rbxassetid://13740049305",
}


local Animation1 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(AnimationObject_1)
local Animation2 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(AnimationObject_2)
local Animation3 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(AnimationObject_3)

local Index = 0

task.spawn(function()
    while task.wait() do
        Index += 1
        game:GetService("ReplicatedStorage").dataRemoteEvent:FireServer(unpack(PACKS["args" .. Index]))
        Animation1:Play()
        Animation1:Stop()
        if Index >= 3 then
            Index = 0
        end
    end
end)



----- SETTINGS -----
getgenv().Enabled = true
getgenv().WeaponType = "Dual Sword" -- Sword / Staff / Dual Sword
getgenv().WaitInterval = 0.01

--
local KILLAURA_ARGS = {[1] = {{ ["animationIndex"] = 2, ["sentAt"] = os.time() + (os.clock() % 1) }, "\162"}}

--
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--
local Animation = nil

--
local function GetAnimationId()
    if getgenv().WeaponType == "Sword" then
        return "rbxassetid://91994339000643"
    elseif getgenv().WeaponType == "Staff" then
        return "rbxassetid://115030158661285"
    elseif getgenv().WeaponType == "Dual Sword" then
        return "rbxassetid://13740049269"
    end
end

local function GetCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function CreateAnimation()
    local AnimationObject = Instance.new("Animation")
    AnimationObject.AnimationId = GetAnimationId()
    AnimationObject.Parent = GetCharacter()

    return AnimationObject
end

local function CharacterAdded(character)
    CreateAnimation()
    local Humanoid = character:WaitForChild("Humanoid")
    Animation = Humanoid:LoadAnimation(CreateAnimation())
end

--
LocalPlayer.CharacterAdded:Connect(CharacterAdded)
task.spawn(function()
    CharacterAdded(GetCharacter())
    while getgenv().Enabled do
        game:GetService("ReplicatedStorage").dataRemoteEvent:FireServer(unpack(KILLAURA_ARGS))
        if Animation ~= nil and GetCharacter() ~= nil and GetCharacter():FindFirstChild("HumanoidRootPart") then
            Animation:Play()
            Animation:Stop()
            Animation:Destroy()
        end
        task.wait(getgenv().WaitInterval)
    end
end)