local rs = game:GetService("ReplicatedStorage")
local events = rs:WaitForChild("Events")
local WaveEvent = events:WaitForChild("WaveEvent")
local GameOverEvent = events:WaitForChild("GameOverEvent")
local ShowDamageEvent = events:WaitForChild("ShowDamageEvent")
local UpdateDataEvent = events:WaitForChild("UpdateDataEvent")
local ts = game:GetService("TweenService")
local MobCountEvent = events:WaitForChild("MobEvent")

local player = game.Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local stats = gui:WaitForChild("Stats")
local coins = player.leaderstats:WaitForChild("Coins")
local level = player.leaderstats:WaitForChild("Level")
local exp = player.leaderstats:WaitForChild("Exp")

local ti = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local ti2 = TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff


-- Initialize UI
local function updateStatsUI()
	local percent = exp.Value / (level.Value * 20)
	stats.Exp.Fill.Size = UDim2.new(percent, 0, 1, 0)
	stats.Exp.SecondFill.Size = UDim2.new(percent, 0, 1, 0)
	stats.Health.TextLabel.Text = "HP: " .. math.floor(humanoid.Health)
	stats.Coins.TextLabel.Text = "Coins: " .. coins.Value
	stats.Level.TextLabel.Text = "Level: " .. level.Value
	stats.Exp.TextLabel.Text = "Exp: " .. exp.Value .. "/" .. (level.Value * 20)
	stats.Wave.TextLabel.Text = "Wave: Not Started"
	stats.MobCount.TextLabel.Text = "Mobs: None"
end

updateStatsUI()


MobCountEvent.OnClientEvent:Connect(function(count)
	stats.MobCount.TextLabel.Text = "Mobs: " .. count
end)

-- Health bar
humanoid.HealthChanged:Connect(function(newHealth)
	local percent = newHealth / humanoid.MaxHealth
	ts:Create(stats.Health.SecondFill, ti2, {Size = UDim2.new(percent, 0, 1, 0)}):Play()
	ts:Create(stats.Health.Fill, ti, {Size = UDim2.new(percent, 0, 1, 0)}):Play()
	stats.Health.TextLabel.Text = "HP: " .. math.floor(newHealth)
end)

-- Coins update
coins.Changed:Connect(function()
	stats.Coins.TextLabel.Text = "Coins: " .. coins.Value
end)

-- EXP and Level update
exp.Changed:Connect(function()
	local threshold = level.Value * 20
	local percent = exp.Value / threshold

	-- Tween the EXP bars
	ts:Create(stats.Exp.SecondFill, ti, {Size = UDim2.new(percent, 0, 1, 0)}):Play()
	ts:Create(stats.Exp.Fill, ti2, {Size = UDim2.new(percent, 0, 1, 0)}):Play()
	stats.Exp.TextLabel.Text = "Exp: ".. exp.Value .. "/" .. threshold

	-- Handle leveling up smoothly
	while exp.Value >= threshold do
		exp.Value -= threshold
		level.Value += 1
		threshold = level.Value * 20

		-- Full bar tween for visual effect
		ts:Create(stats.Exp.Fill, ti, {Size = UDim2.new(1, 0, 1, 0)}):Play()
		wait(0.3)
		stats.Exp.Fill.Size = UDim2.new(0, 0, 1, 0)
	end
end)

level.Changed:Connect(function()
	stats.Level.TextLabel.Text = "Level: " .. level.Value
end)

WaveEvent.OnClientEvent:Connect(function(currentWave)
	stats.Wave.TextLabel.Text = "Wave: " .. currentWave
	UpdateDataEvent:FireServer(5 * currentWave)
end)

ShowDamageEvent.OnClientEvent:Connect(function(enemyPos, damage)
	local popup = rs.Ui.DamagePopUp:Clone()
	popup.Text = tostring(damage)
	popup.Parent = stats

	local cam = workspace.CurrentCamera
	local screenPos, onScreen = cam:WorldToViewportPoint(enemyPos)
	if not onScreen then
		popup:Destroy()
		return
	end

	popup.Position = UDim2.new(0, screenPos.X, 0, screenPos.Y)

	local tweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local goal = {
		Position = popup.Position + UDim2.new(0, 0, 0, -30),
		TextTransparency = 1
	}
	local tween = ts:Create(popup, tweenInfo, goal)
	tween:Play()

	tween.Completed:Connect(function()
		popup:Destroy()
	end)
end)

GameOverEvent.OnClientEvent:Connect(function(title)
	stats.Wave.TextLabel.Text = title
end)