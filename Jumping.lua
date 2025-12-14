local player = game.Players.LocalPlayer
local character = player.Character
local humanoid = character:WaitForChild("Humanoid")
local humanoidrootpart = character:WaitForChild("HumanoidRootPart")
local UserInputService = game:GetService("UserInputService")
local humanoid = script.Parent:WaitForChild("Humanoid")

humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)