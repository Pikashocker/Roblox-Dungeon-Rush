local Camera = {}

function Camera:UpdateCamera(hrp)
	local player = game.Players.LocalPlayer
	if not player then return end

	local camera = workspace.CurrentCamera
	local mouse = player:GetMouse()
	camera.CameraType = Enum.CameraType.Scriptable

	-- Only connect once
	local RunService = game:GetService("RunService")
	RunService:BindToRenderStep("TopDownCamera", Enum.RenderPriority.Camera.Value, function()
		-- Camera follows player
		camera.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 25, 0), hrp.Position)

		-- Player faces mouse
		if mouse.Hit then
			local target = Vector3.new(mouse.Hit.X, hrp.Position.Y, mouse.Hit.Z)
			hrp.CFrame = CFrame.lookAt(hrp.Position, target)
		end
	end)
end

return Camera
