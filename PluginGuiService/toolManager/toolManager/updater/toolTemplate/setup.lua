-- @ScriptType: LocalScript
script.Parent.toggle.MouseButton1Click:connect(function()
	print("button clicked")
	if not script.Parent.window.Value then warn("[Drone's Public Plugins] Widget not found.") return end
	script.Parent.window.Value.Enabled=not script.Parent.window.Value.Enabled
	if script.Parent.window.Value.Enabled then
		script.Parent.toggle.Text="Close"
	else
		script.Parent.toggle.Text="Open"
	end
end)