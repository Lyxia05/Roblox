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

-- make it to default again
setreadonly(mt, true)



"rbxassetid://132363319545954"
"rbxassetid://74447788907886"


local AnimationObject_1 = Instance.new("Animation")
AnimationObject_1.AnimationId = "rbxassetid://91994339000643"
AnimationObject_1.Parent = game.Players.LocalPlayer.Character

local AnimationObject_2 = Instance.new("Animation")
AnimationObject_2.AnimationId = "rbxassetid://132363319545954"
AnimationObject_2.Parent = game.Players.LocalPlayer.Character

local AnimationObject_3 = Instance.new("Animation")
AnimationObject_3.AnimationId = "rbxassetid://74447788907886"
AnimationObject_3.Parent = game.Players.LocalPlayer.Character


local Animation1 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(AnimationObject_1)
local Animation2 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(AnimationObject_2)
local Animation3 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(AnimationObject_3)



----- NAMECALL -----
local mt = getrawmetatable(game)

-- Save what the __namecall function does normally
local old = mt.__namecall

-- let us edit the game's metatable
setreadonly(mt, false)

-- Rewrite the __index function
mt.__namecall = function(self, ...)
    local method = getnamecallmethod()

    if self.Name == "dataRemoteEvent" then
        Animation:Play()
        Animation:Stop()
    end

    return old(self, ...)
end


setreadonly(mt, true)