local rs = game:GetService("ReplicatedStorage")
local events = rs:WaitForChild("Events")
local AttackEvent = events:WaitForChild("AttackEvent")
local ShowDamageEvent = events:WaitForChild("ShowDamageEvent")

local function addExp(player, amount)
	local exp = player.leaderstats.Exp
	local level = player.leaderstats.Level
	local threshold = level.Value * 20

	exp.Value += amount

	while exp.Value >= threshold do
		exp.Value -= threshold
		level.Value += 1
		threshold = level.Value * 20
	end
end

AttackEvent.OnServerEvent:Connect(function(player, enemy, attackdamage)
	local humanoid = enemy:FindFirstChild("Humanoid")
	if humanoid then
		humanoid:TakeDamage(attackdamage)

		local hrp = enemy:FindFirstChild("HumanoidRootPart")
		if hrp then
			ShowDamageEvent:FireClient(player, hrp.Position, attackdamage)
		end
	end

	if humanoid and humanoid.Health <= 0 then
		player.leaderstats.Coins.Value += enemy:FindFirstChild("Stats").Coins.Value
		addExp(player, enemy:FindFirstChild("Stats").Xp.Value)
	end
end)
