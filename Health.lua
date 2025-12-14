local mob = script.Parent
local humanoid = mob:WaitForChild("Humanoid")
local bill = mob.Head.BillboardGui
local ts = game:GetService("TweenService")
local ti = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local ti2 = TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

bill.Health.TextLabel.Text = "HP: " .. humanoid.Health .. "/" .. humanoid.MaxHealth

humanoid.HealthChanged:Connect(function(newhealth)
	if humanoid.Health > 0 then
		local percent = newhealth / humanoid.MaxHealth
		bill.Health.TextLabel.Text = "HP: " .. newhealth .. "/" .. humanoid.MaxHealth
		ts:Create(bill.Health.SecondFill, ti2, {
			Size = UDim2.new(percent, 0, 1, 0)
		}):Play()
		ts:Create(bill.Health.Fill, ti, {
			Size = UDim2.new(percent, 0, 1, 0)
		}):Play()
	end
end)