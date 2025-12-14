local rs = game:GetService("ReplicatedStorage")
local workspace = game.Workspace
local enemies = rs:WaitForChild("Enemies")
local spawnPoints = workspace:WaitForChild("SpawnPoints"):GetChildren()
local events = rs:WaitForChild("Events")
local WaveEvent = events:WaitForChild("WaveEvent")
local GameOverEvent = events:WaitForChild("GameOverEvent")
local MobCountEvent = events:WaitForChild("MobEvent")
local enemyFolder = workspace:WaitForChild("Enemy")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local trigger = workspace.Room1.Trigger
local door = workspace.Room1.Door
local spwn = workspace.Room1.Spawn
local started = false

local waves = {
	{
		Wave = 1,
		Normal = {
			count = 5,
			hpscaling = 1,
			speedscaling = 1,
		},
		delay = 0.5
	},
	
	{
		Wave = 2,
		Normal = {
			count = 8,
			hpscaling = 1.2,
			speedscaling = 1.1,
		},
		delay = 0.5
	},
	
	{
		Wave = 3,
		Normal = {
			count = 11,
			hpscaling = 1.4,
			speedscaling = 1.2,
		},
		delay = 0.5
	},
	
	{
		Wave = 4,
		Speedy = {
			count = 6,
			hpscaling = 1,
			speedscaling = 1, 
		},
		delay = 0.5
	},
	
	{
		Wave = 5,
		Speedy = {
			count = 10,
			hpscaling = 1.2,
			speedscaling = 1.1, 
		},
		delay = 0.5
	},
	
	{
		Wave = 6,
		Speedy = {
			count = 18,
			hpscaling = 1.4,
			speedscaling = 1.2, 
		},
		delay = 0.5
	},
	
	{
		Wave = 7,
		Heavy = {
			count = 4,
			hpscaling = 1,
			speedscaling = 1,
		},
		delay = 0.5
	},
	
	{
		Wave = 8,
		Heavy = {
			count = 10,
			hpscaling = 1.2,
			speedscaling = 1.1,
		},
		delay = 0.5
	},
	
	{
		Wave = 9,
		Heavy = {
			count = 10,
			hpscaling = 1.4,
			speedscaling = 1.2,
		},
		
		Speedy = {
			count = 16,
			hpscaling = 1.6,
			speedscaling = 1.3, 
		},
		
		Normal = {
			count = 12,
			hpscaling = 1.6,
			speedscaling = 1.3,
		},
		
		delay = 0.5
	},
	
	{
		Wave = 10,
		Heavy = {
			count = 5,
			hpscaling = 1.6,
			speedscaling = 1.3,
		},

		Tank = {
			count = 1,
			hpscaling = 1,
			speedscaling = 1, 
		},
		
		delay = 0.5
	}
}

local function areAllPlayersDead()
	for _, player in ipairs(Players:GetPlayers()) do
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			if player.Character.Humanoid.Health > 0 then
				return false
			end
		end
	end
	return true
end

local function setupCharacter(character)
	local humanoid = character:WaitForChild("Humanoid")

	humanoid.Died:Connect(function()
		if areAllPlayersDead() then
			print("All players dead")
			GameOverEvent:FireAllClients("You Lost!")
			restartGame()
		end
	end)
end


Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(setupCharacter)
end)

function restartGame()
	task.wait(3) -- small delay for UI
	for _, player in ipairs(Players:GetPlayers()) do
		TeleportService:Teleport(game.PlaceId, player)
	end
end


local function startWave()
	task.wait(1) -- letting UI load
	for waveIndex, wave in ipairs(waves) do
		WaveEvent:FireAllClients(waveIndex)
		for mobName, mobData in pairs(wave) do
			if mobName ~= "Wave" and mobName ~= "delay" then
				if typeof(mobData) == "table" and enemies:FindFirstChild(mobName) then
					for i = 1, mobData.count do
						local spawn = spawnPoints[math.random(1, #spawnPoints)]
						print("Spawning "..mobName.." at", spawn.Position)
						local mob = enemies:FindFirstChild(mobName):Clone()
						mob.Parent = workspace.Enemy
						mob:MoveTo(spawn.Position)
						mob.Humanoid.MaxHealth = mob.Humanoid.MaxHealth * mobData.hpscaling
						mob.Humanoid.Health = mob.Humanoid.MaxHealth
						mob.Humanoid.WalkSpeed = mob.Humanoid.WalkSpeed * mobData.speedscaling
						wait(wave.delay)
					end
				end	
			end	
		end	
		repeat
			task.wait(1)
		until #workspace.Enemy:GetChildren() == 0
		
		if waveIndex == #waves and #workspace.Enemy:GetChildren() == 0 then
			print("Game Won")
			GameOverEvent:FireAllClients("You Won!")
			restartGame()
			return
		elseif areAllPlayersDead() then
			print("Game Over")
			GameOverEvent:FireAllClients("You Lost!")
			restartGame()
			return
		end
	end
end



local function updateMobCount()
	MobCountEvent:FireAllClients(#enemyFolder:GetChildren())
end

-- When mobs spawn
enemyFolder.ChildAdded:Connect(function(child)
	updateMobCount()
end)

-- When mobs die / get removed
enemyFolder.ChildRemoved:Connect(function(child)
	updateMobCount()
end)

-- Initial count
updateMobCount()

trigger.Touched:Connect(function()
	if started then return end
	started = true

	trigger.CanTouch = false
	door.CanCollide = true
	door.Transparency = 0

	WaveEvent:FireAllClients(0)
	startWave()
end)
