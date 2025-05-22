-- @ScriptType: Script
script.Parent.MouseClick:Connect(function()
	script.Parent.Parent:WaitForChild("SurfaceGui").Enabled = not(script.Parent.Parent:WaitForChild("SurfaceGui").Enabled)
end)