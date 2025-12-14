local expDropValue = script.Parent:WaitForChild("ExpDropValue")

script.Parent.Touched:Connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if player and player:FindFirstChild("leaderstats") then
		player.leaderstats.Exp.Value += expDropValue.Value
		script.Parent:Destroy()
	end
end)
