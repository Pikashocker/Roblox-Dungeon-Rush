local Camera = require(game.ReplicatedStorage.ModuleScripts.Camera)
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

Camera:UpdateCamera(hrp)
