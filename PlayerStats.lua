local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid")
		local level = player:WaitForChild("leaderstats"):WaitForChild("Level")

		local function updateStats()
			local healthPercent = humanoid.Health / humanoid.MaxHealth
			humanoid.WalkSpeed = 16 + (level.Value * 0.10)
			humanoid.MaxHealth = math.floor(100 + (level.Value * 3.5))
			humanoid.Health = math.max(1, humanoid.MaxHealth * healthPercent)
		end
		updateStats()
		level.Changed:Connect(updateStats)
	end)
end)
