-- @ScriptType: LocalScript
while task.wait() do
	script.Parent:TweenSize(UDim2.new(0.2,0,0.2,0), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.3)
	task.wait(0.5)
	script.Parent:TweenSize(UDim2.new(0.15,0,0.15,0), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.3)
	task.wait(0.5)
end