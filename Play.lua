local player = game.Players.LocalPlayer
local Players = game:GetService("Players")
local character = player.Character or player.CharacterAdded:Wait() 
local humanoid = character:WaitForChild("Humanoid")

local gui = player:WaitForChild("PlayerGui")
local menu = gui:WaitForChild("Menu")
local level = player:WaitForChild("leaderstats"):WaitForChild("Level")




humanoid.WalkSpeed = 0

menu.Frame.Play.MouseButton1Click:Connect(function()
	humanoid.WalkSpeed =  math.floor(16 + (level.Value * 0.25))
	menu.Enabled = false
end)