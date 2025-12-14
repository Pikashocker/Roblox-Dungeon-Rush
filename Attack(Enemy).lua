local npc = script.Parent
local humanoid = npc:WaitForChild("Humanoid")
local hrp = npc:WaitForChild("HumanoidRootPart")
local stats = npc.Stats
local debounce = false
local maxRoamingRange = stats.RoamingRange.Value
local maxRange = stats.Range.Value
local animator = humanoid:WaitForChild("Animator")

local walk = Instance.new("Animation")
walk.AnimationId = "rbxassetid://119204078498138"

local attack = Instance.new("Animation")
attack.AnimationId = "rbxassetid://92428203636581"


local walkAnimTrack = animator:LoadAnimation(walk)
local attackAnimTrack = animator:LoadAnimation(attack)

hrp.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and not debounce and not hit.Parent:FindFirstChild("Mob") then
		debounce = true
		attackAnimTrack:Play()
		hit.Parent.Humanoid.Health -= stats.Damage.Value
		task.wait(1)
		debounce = false
	end
end)

function walk(destination)
	if not walkAnimTrack.IsPlaying then
		walkAnimTrack:Play()
	end
	humanoid:MoveTo(destination)
end

function walkRandom()
	if not walkAnimTrack.IsPlaying then
		walkAnimTrack:Play()
	end

	local randomDirection = Vector3.new(
		math.random(-maxRoamingRange, maxRoamingRange),
		0,
		math.random(-maxRoamingRange, maxRoamingRange)
	)
	local destination = hrp.Position + randomDirection
	humanoid:MoveTo(destination)
end

local function findclosestplayer()
	local closest = nil
	local closestDistance = maxRange

	for _, player in ipairs(game.Players:GetPlayers()) do
		if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then

			local hrpTarget = player.Character:FindFirstChild("HumanoidRootPart")
			if hrpTarget then
				local distance = (hrp.Position - hrpTarget.Position).Magnitude

				if distance < closestDistance then
					closestDistance = distance
					closest = hrpTarget
				end
			end
		end
	end

	return closest
end

while humanoid.Health > 0 do
	local target = findclosestplayer()
	if target then
		walk(target.Position)
	else
		walkRandom()
	end
	task.wait(0.3)
end
