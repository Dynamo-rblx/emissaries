-- @ScriptType: LocalScript
local link = script.Parent.Parent.Parent.Parent
script.Parent.Parent.Parent:WaitForChild("linked").Value=true
local par = script.Parent.Parent.Parent
local http = game:GetService("HttpService")
local run = game:GetService("RunService")
local prev = false
local debounce = false

local function updateList()
	for i,v in pairs(script.Parent:GetChildren()) do -- clear the list
		if v:IsA("Frame") then
			v:Destroy()
		end
	end
	local paste = http:GetAsync("https://pastebin.com/raw/Bubfxbmv")
	if not paste then return end
	local data = http:JSONDecode(paste)
	for i,v in pairs(data) do
		local template = script.template:Clone()
		local id = tonumber(
			string.split(v,"/")[1]
		)
		if id then
			template.icon.Image=game.Players:GetUserThumbnailAsync(id,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100)
			template.user.Text=game:GetService("UserService"):GetUserInfosByUserIdsAsync({id})[1].DisplayName.." (@"..game.Players:GetNameFromUserIdAsync(id)..")"
		else
			template.user.Text="Anonymous"
		end
		template.amount.Text=string.split(v,"/")[2].." Robux"
		template.LayoutOrder=-tonumber(string.split(v,"/")[2])
		template.Parent=script.Parent
	end
end

run.Heartbeat:connect(function()
	local par = script.Parent.Parent.Parent.Parent
	if par:IsA("Folder") then return end
	local pr = prev
	prev=par.Enabled
	if par.Enabled~=pr and par.Enabled==true then
		updateList()
	end
end)