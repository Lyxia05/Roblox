local PACKS = {
    args0 = {
        [1] = {
            [1] = {
                ["animationIndex"] = 0,
                ["sentAt"] = 1732331059.475885
            },
            [2] = "\151"
        }
    },

    args1 = {
        [1] = {
            [1] = {
                ["animationIndex"] = 1,
                ["sentAt"] = 1732331059.475885
            },
            [2] = "\151"
        }
    },

    args2 = {
        [1] = {
            [1] = {
                ["animationIndex"] = 2,
                ["sentAt"] = 1732331030.1644
            },
            [2] = "\151"
        }
    },
    
    args3 = {
        [1] = {
            [1] = {
                ["animationIndex"] = 3,
                ["sentAt"] = 1732331050.258777
            },
            [2] = "\151"
        }
    }
}

local A = Instance.new("Animation")
A.AnimationId = "rbxassetid://91994339000643"
A.Parent = game.Players.LocalPlayer.Character
local Anims = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(A)

local Index = 0

while task.wait() do
    Index += 1
    game:GetService("ReplicatedStorage").dataRemoteEvent:FireServer(unpack(PACKS["args" .. Index]))
    Anims:Play()
    Anims:Stop()

    if Index >= 3 then
        Index = 0
    end
end



task.spawn(function()
    while wait(1) do
        for index, value in pairs(game.Players.LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do

            if index == 6 then
                print(value.AnimationId)
            end
            
        end
    end
end)


workspace.kerse.WeaponGear["Royal Crimson Greatsword"].swing:FireServer()