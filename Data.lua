local rs = game:GetService("ReplicatedStorage")
local dss = game:GetService("DataStoreService")
local datastore = dss:GetDataStore("DungonData")
local events = rs:WaitForChild("Events")
local UpdateDataEvent = events:WaitForChild("UpdateDataEvent")

-- Function to handle adding EXP and leveling
local function addExp(player, amount)
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then return end

	local exp = leaderstats:FindFirstChild("Exp")
	local level = leaderstats:FindFirstChild("Level")
	if not exp or not level then return end

	exp.Value += amount

	while exp.Value >= level.Value * 20 do
		exp.Value -= level.Value * 20
		level.Value += 1
	end
end

-- Player joins the game
game.Players.PlayerAdded:Connect(function(player)
	-- Load data
	local data
	local success, err = pcall(function()
		data = datastore:GetAsync(player.UserId)
	end)

	if not success then
		warn("Data load failed for " .. player.Name .. ": " .. err)
	end

	if not data then
		data = {
			Coins = 0,
			Exp = 0,
			Level = 1
		}
	end

	-- Create leaderstats
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local coins = Instance.new("IntValue")
	coins.Name = "Coins"
	coins.Value = data.Coins
	coins.Parent = leaderstats

	local exp = Instance.new("IntValue")
	exp.Name = "Exp"
	exp.Value = data.Exp
	exp.Parent = leaderstats

	local level = Instance.new("IntValue")
	level.Name = "Level"
	level.Value = data.Level
	level.Parent = leaderstats
end)

-- Player triggers UpdateDataEvent (e.g., wave rewards)
UpdateDataEvent.OnServerEvent:Connect(function(player, amount)
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then return end

	-- Add coins
	local coins = leaderstats:FindFirstChild("Coins")
	if coins then
		coins.Value += amount
	end

	-- Add EXP and handle leveling
	addExp(player, amount + 15)
end)

-- Player leaves the game
game.Players.PlayerRemoving:Connect(function(player)
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then return end

	local data = {
		Coins = leaderstats.Coins.Value,
		Exp = leaderstats.Exp.Value,
		Level = leaderstats.Level.Value
	}

	local success, err = pcall(function()
		datastore:SetAsync(player.UserId, data)
	end)

	if not success then
		warn("Error saving data for " .. player.Name .. ": " .. err)
	end
end)

-- Periodic save every 60 seconds
spawn(function()
	while true do
		task.wait(60)
		for _, player in ipairs(game.Players:GetPlayers()) do
			local leaderstats = player:FindFirstChild("leaderstats")
			if leaderstats then
				local data = {
					Coins = leaderstats.Coins.Value,
					Exp = leaderstats.Exp.Value,
					Level = leaderstats.Level.Value
				}
				pcall(function()
					datastore:SetAsync(player.UserId, data)
				end)
			end
		end
	end
end)
