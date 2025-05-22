-- @ScriptType: LocalScript
local t = game:GetService("TweenService")
local tinfo = TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)

script.Parent.MouseEnter:connect(function()
	local p = {
		Size=UDim2.new(1,0,0,2)
	}
	t:Create(script.Parent.line,tinfo,p):Play()
end)

script.Parent.MouseLeave:connect(function()
	local p = {
		Size=UDim2.new(0,0,0,2)
	}
	t:Create(script.Parent.line,tinfo,p):Play()
end)