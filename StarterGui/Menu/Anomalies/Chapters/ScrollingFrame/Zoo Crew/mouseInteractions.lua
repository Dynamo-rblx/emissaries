-- @ScriptType: LocalScript
script.Parent.MouseEnter:Connect(function()
	script.Parent:WaitForChild("UIStroke").Enabled = true
	script.Parent:WaitForChild("BG").ImageTransparency = 0.4
	script.Parent:WaitForChild("Vignette").ImageTransparency = 0.4
	script.Parent:TweenSize(UDim2.new(0.1,0,1.1,0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.2, true)
end)

script.Parent.MouseLeave:Connect(function()
	script.Parent:WaitForChild("UIStroke").Enabled = false
	script.Parent:WaitForChild("BG").ImageTransparency = 0.1
	script.Parent:WaitForChild("BG").ImageTransparency = 0.7
	script.Parent:TweenSize(UDim2.new(0.1,0,1,0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.2, true)
end)

script.Parent:WaitForChild("FrameBtn").MouseButton1Click:Connect(function()
	script.Parent.Parent.Parent:WaitForChild("MoveScroller"):Fire("Zoo Crew")
	
end)

