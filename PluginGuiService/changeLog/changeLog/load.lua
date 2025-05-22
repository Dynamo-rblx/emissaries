-- @ScriptType: LocalScript
local root = if script.Parent.Parent:IsA("Folder") then script.Parent.Parent else nil
repeat
	task.wait(0.5)
until not script.Parent.Parent:IsA('Folder')
local insert = game:GetService('InsertService')
local tags = {
	a='[<font color="rgb(50,255,125)">Added</font>]',
	f='[<font color="rgb(178,158,255)">Fixed</font>]',
	r='[<font color="rgb(255,125,125)">Removed</font>]',
	n='[<font color="rgb(125,200,255)">Note</font>]',
	m='[<font color="rgb(255,255,125)">Modified</font>]',
	d='(<font color="rgb(150,150,150)">',
	de='</font>) <i>D|M|Y</i>',
	yl='<font color="rgb(255,100,100)"><u>',
	yle='</u></font>'
}

script.Parent.Parent.Changed:connect(function(val)
	if not root then return end
	if val=='Enabled' then
		if script.Parent.Parent.Enabled then
			script.Parent.log.holder.label.Text="<i>Fetching data...</i>"
			-- Load data
			local module = true
			local outdated = false
			pcall(function()
				--module = insert:LoadAsset(9706099298).MainModule
				outdated = root.Main:WaitForChild('version').Value~=require(game:GetObjects("rbxassetid://9706099298")[1])
				--print(require(9706099298),script:WaitForChild('version').Value)
			end)
			local data = if module then require(game:GetObjects("rbxassetid://10533431765")[1]) else 'No data found :('
			for i,v in pairs(tags) do
				data=string.gsub(data,"t:"..i,v)
			end
			script.Parent.log.holder.label.Text=data
		end
	end
end)