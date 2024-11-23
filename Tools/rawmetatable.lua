---- INDEX ----
local mt = getrawmetatable(game)

-- Save what the __index function does normally
local old = mt.__index

-- let us edit the game's metatable
setreadonly(mt, false)

-- Rewrite the __index function
mt.__index = function(instance, index)
    if instance == "Humanoid" then
        print(instance, index)
    end

    return old(instance, index)
end


local A = Instance.new("Animation")
A.AnimationId = "rbxassetid://91994339000643"
A.Parent = game.Players.LocalPlayer.Character

local Anims = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(A)
Anims:Play()



----- NAMECALL -----
local mt = getrawmetatable(game)

-- Save what the __namecall function does normally
local old = mt.__namecall

-- let us edit the game's metatable
setreadonly(mt, false)

-- Rewrite the __index function
mt.__namecall = function(self, ...)
    local method = getnamecallmethod()

    if self.Name == "Animation" and method == "Play" then
        print(self.Animation.AnimationId)
    end

    return old(self, ...)
end