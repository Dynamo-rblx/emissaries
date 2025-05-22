-- @ScriptType: LocalScript
local parent = script.Parent.Parent.Parent.Parent

script.Parent.MouseEnter:connect(function()
	parent.info.Visible=true
	parent.info.label.Text=script.Parent:GetAttribute("Description")
	local pos = parent.Parent:GetRelativeMousePosition()
	parent.info.Position=UDim2.new(
		0,
		pos.X,
		0,
		pos.Y
	)
end)

script.Parent.MouseLeave:connect(function()
	parent.info.Visible=false
	
end)