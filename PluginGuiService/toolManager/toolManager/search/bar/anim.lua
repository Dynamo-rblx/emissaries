-- @ScriptType: LocalScript
local t = game:GetService("TweenService")
local tinfo = TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)

script.Parent.Focused:connect(function()
	local p = {
		Thickness=3
	}
	t:Create(script.Parent.UIStroke,tinfo,p):Play()
end)

script.Parent.FocusLost:connect(function()
	local p = {
		Thickness=0
	}
	t:Create(script.Parent.UIStroke,tinfo,p):Play()
end)