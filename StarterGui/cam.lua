-- @ScriptType: LocalScript
task.wait(5)
--// Variables
local cam = workspace.CurrentCamera
local camPart = script.parallaxOBJ.Value
local mouse = game:GetService("Players").LocalPlayer:GetMouse()

--// Set cam
repeat
	task.wait()
	cam.CameraType = Enum.CameraType.Scriptable
until
cam.CameraType == Enum.CameraType.Scriptable

--// Move cam
local maxTilt = 10
game:GetService("RunService").RenderStepped:Connect(function()
	if script.Parallax.Value == true then
		camPart = script.parallaxOBJ.Value
		cam.CFrame = camPart.CFrame * CFrame.Angles(
			math.rad((((mouse.Y - mouse.ViewSizeY / 2) / mouse.ViewSizeY)) * -maxTilt),
			math.rad((((mouse.X - mouse.ViewSizeX / 2) / mouse.ViewSizeX)) * -maxTilt),
			0
		)
	end
end)
-----------------------------------------------------------------------------------
game:GetService("StarterGui"):SetCore("ResetButtonCallback", false)