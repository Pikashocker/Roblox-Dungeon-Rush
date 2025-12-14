local mob = script.Parent
local humanoid = mob:WaitForChild("Humanoid")

local rp = game:GetService("ReplicatedStorage")
local drops = rp:WaitForChild("MobDrops")

local coin = drops:WaitForChild("Coin")
local xp = drops:WaitForChild("Exp")

humanoid.Died:Connect(function()
	local chanceCoin = math.random(1,100)
	local chanceExp = math.random(1,100)

	if chanceCoin <= 60 then
		local newCoin = coin:Clone()
		newCoin.Parent = workspace
		newCoin.Position = mob.HumanoidRootPart.Position + Vector3.new(0, 3, 0)

	end

	if chanceExp <= 30 then
		local newExp = xp:Clone()
		newExp.Parent = workspace
		newExp.Position = mob.HumanoidRootPart.Position + Vector3.new(0, 3, 0)
	end

	mob:Destroy()
end)
