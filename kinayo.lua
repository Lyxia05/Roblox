local ANIMATION_TABLE = {
    ["LargeWeapon"] = {
        ["Idle"] = 87776815396170,
        ["Run"] = 132363319545954,
        ["Attacks"] = { "rbxassetid://115725251079211", "rbxassetid://91994339000643", "rbxassetid://74447788907886" }
    },
    ["SmallWeapon"] = {
        ["Idle"] = 76270721636286,
        ["Run"] = 134108776094003,
        ["Attacks"] = { "rbxassetid://115725251079211", "rbxassetid://91994339000643", "rbxassetid://74447788907886" }
    },
    ["DualWeapons"] = {
        ["Idle"] = 133279515020830,
        ["Run"] = 108019923425961,
        ["Attacks"] = { "rbxassetid://13740049334", "rbxassetid://13740049269", "rbxassetid://13740049305" },
        ["TempIgnoreAttackKeyFrame"] = true
    },
    ["SwordAndShield"] = {
        ["Idle"] = 134863424878930,
        ["Run"] = 109165703984291,
        ["Attacks"] = { "rbxassetid://13740049395", "rbxassetid://13740049453" },
        ["TempIgnoreAttackKeyFrame"] = true
    },
    ["Staff"] = {
        ["Idle"] = 87776815396170,
        ["Run"] = 132363319545954,
        ["Attacks"] = { "rbxassetid://110836226084253", "rbxassetid://115030158661285", "rbxassetid://118125784297769" }
    },
    ["Fists"] = {
        ["Idle"] = 14201837624,
        ["Run"] = 14201837715,
        ["Attacks"] = { "rbxassetid://13740049031", "rbxassetid://13740048897" },
        ["TempIgnoreAttackKeyFrame"] = true
    }
  }
  
  getgenv().Enabled = true
  getgenv().WeaponType = "LargeWeapon"
  getgenv().WaitInterval = 0
  
  local Players = game:GetService("Players")
  local LocalPlayer = Players.LocalPlayer
  local AnimationObject = nil
  local Animation = nil
  
  local function GetCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
  end
  
  local function UpdateAnimationByIndex(index)
    AnimationObject.AnimationId = ANIMATION_TABLE[getgenv().WeaponType].Attacks[index]
  end
  
  local function GetKillAuraArgs(index)
    return {[1] = {{ ["animationIndex"] = index, ["sentAt"] = tick() }, "\151"}}
  end
  
  local function CreateAnimation()
    AnimationObject = Instance.new("Animation")
    AnimationObject.Parent = GetCharacter()
    UpdateAnimationByIndex(1)
    return AnimationObject
  end
  
  local function CharacterAdded(character)
    CreateAnimation()
    local Humanoid = character:WaitForChild("Humanoid")
    Animation = Humanoid:LoadAnimation(CreateAnimation())
  end
  
  LocalPlayer.CharacterAdded:Connect(CharacterAdded)
  
  task.spawn(function()
    local CurrentIndex = 0
    CharacterAdded(GetCharacter())
    while getgenv().Enabled do
        if Animation ~= nil and GetCharacter() ~= nil and GetCharacter():FindFirstChild("HumanoidRootPart") then
            CurrentIndex += 1
            for i = 1, 5 do
                for j = 1, 3 do
                    game:GetService("ReplicatedStorage").dataRemoteEvent:FireServer(unpack(GetKillAuraArgs(CurrentIndex)))
                end
                task.spawn(function()
                    game:GetService("ReplicatedStorage").dataRemoteEvent:FireServer(unpack(GetKillAuraArgs(CurrentIndex)))
                end)
            end
            UpdateAnimationByIndex(CurrentIndex)
            Animation:Play()
            Animation:Stop()
            Animation:Destroy()
            if CurrentIndex >= #ANIMATION_TABLE[getgenv().WeaponType].Attacks then
                CurrentIndex = 0
            end
        end
        task.wait(0)
    end
  end)
  
  spawn(function()
    while wait() do
        pcall(function()
            for i = 1, 3 do
                game:GetService("ReplicatedStorage").dataRemoteEvent:FireServer(unpack(GetKillAuraArgs(i)))
            end
        end)
    end
  end)