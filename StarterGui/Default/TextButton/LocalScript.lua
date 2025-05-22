-- @ScriptType: LocalScript


script.Parent.MouseEnter:Connect(function()
	script.Parent.Text = "<u>Menu</u>"
	script.Parent:WaitForChild("UIStroke").Enabled = true
end)

script.Parent.MouseLeave:Connect(function()
	script.Parent.Text = "Menu"
	script.Parent:WaitForChild("UIStroke").Enabled = false
end)

script.Parent.MouseButton1Click:Connect(function()
	script.Parent.Active = false
	script.Parent.Parent.Parent:WaitForChild("Default"):WaitForChild("TextButton").Active = true
	script.Parent.Parent.Parent:WaitForChild("Menu").Enabled = false
	
	script.Parent.Parent.Parent:WaitForChild("cam"):WaitForChild("Parallax").Value = false
	
	local cam = workspace.CurrentCamera
	local camPart = workspace:WaitForChild("CamPart")
	
	local tween = game:GetService("TweenService"):Create(cam, TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {["CFrame"]=camPart.CFrame})
	tween:Play()
	tween.Completed:Wait()
	task.wait(0.05)
	
	script.Parent.Parent.Parent:WaitForChild("Battlepass").Enabled = true
	script.Parent.Parent.Enabled = false
	script.Parent.Parent.Parent:WaitForChild("Menu").Enabled = true
	script.Parent.Parent.Parent:WaitForChild("cam"):WaitForChild("parallaxOBJ").Value = script.Parent.Parent.Adornee
	script.Parent.Parent.Parent:WaitForChild("cam"):WaitForChild("Parallax").Value = true
end)