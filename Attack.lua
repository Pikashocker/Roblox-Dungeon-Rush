local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local mouse = player:GetMouse()
local rs = game:GetService("ReplicatedStorage")
local events = rs:WaitForChild("Events")
local AttackEvent = events:WaitForChild("AttackEvent")

local attackDamage = 20
local lastAttack = 0
local cooldown = 0.1 -- seconds

mouse.Button1Down:Connect(function(gameProcessed)
	if tick() - lastAttack < cooldown then return end
	if gameProcessed then return end
	lastAttack = tick()
	local target = mouse.Target
	if target and target.Parent:FindFirstChild("Humanoid") then
		print("Attacking", target.Parent.Name)
		AttackEvent:FireServer(target.Parent, attackDamage)
	end
end)