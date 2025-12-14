local Players = game:GetService("Players")

Players.CharacterAutoLoads = false

for _, player in ipairs(Players:GetPlayers()) do
	player:LoadCharacter()
end

Players.PlayerAdded:Connect(function(player)
	player:LoadCharacter()
end)
