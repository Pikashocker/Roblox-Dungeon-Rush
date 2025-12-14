local coinDropValue = script.Parent:WaitForChild("CoinDropValue")

script.Parent.Touched:Connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if player and player:FindFirstChild("leaderstats") then
		player.leaderstats.Coins.Value += coinDropValue.Value
		script.Parent:Destroy()
	end
end)
