-- @ScriptType: LocalScript
local c = plugin:GetSetting("DPPRemover Script")
if c==true then
	script.Parent.ImageTransparency=0
elseif c==nil or c==false then
	script.Parent.ImageTransparency=1
end

script.Parent.MouseButton1Click:connect(function()
	local current = plugin:GetSetting("DPPRemover Script")
	if current==true then
		plugin:SetSetting("DPPRemover Script",false)
		script.Parent.ImageTransparency=1
	elseif current==nil or current==false then
		plugin:SetSetting("DPPRemover Script",true)
		script.Parent.ImageTransparency=0
	end
end)