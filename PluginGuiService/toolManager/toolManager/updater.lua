-- @ScriptType: LocalScript
local link = script.Parent.Parent
script.Parent:WaitForChild("linked").Value=true
local uis = game:GetService("UserInputService")
local run = game:GetService("RunService")
local t = game:GetService("TweenService")
local tinfo = TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
local connections = {}
local currentInputs = {}
local triggerPattern = {
	Enum.KeyCode.LeftControl,
	Enum.KeyCode.LeftAlt,
	Enum.KeyCode.T
}
local pinToggles = {}
local pinDebounce = {}
local function createWindow(name: string, setts: string, title: string, UIRef: string)
	link.Main.createWidget:FireServer(name,setts,title,UIRef)
	local tool = link.tools:FindFirstChild(title)
	if tool then
		repeat
			wait(0.5) -- Yield thread
		until tool.window.Value~=nil and tool.window.Value.Parent~=nil
		return tool.window.Value
	end
end
local function connectRest(template) -- Creates the rest of the necessary connections after the window has been made.
	table.insert(connections,template.window.Value.Changed:connect(function(pro)
		if pro=="Enabled" then
			if template.window.Value.Enabled then
				template.toggle.Text="Close"
				template.toggle.BackgroundColor3=Color3.fromRGB(255, 55, 55)
			else
				template.toggle.Text="Open"
				template.toggle.BackgroundColor3=Color3.fromRGB(0, 187, 255)
			end
		end
	end))
	if template.window.Value.Enabled then
		template.toggle.Text="Close"
		template.toggle.BackgroundColor3=Color3.fromRGB(255, 55, 55)
	else
		template.toggle.Text="Open"
		template.toggle.BackgroundColor3=Color3.fromRGB(0, 187, 255)
	end
end

local function update(searchTerm: string)
	if link==nil then return end
	for i,v in pairs(connections) do
		v:Disconnect()
	end
	for i,v in pairs(script.Parent.holder:GetChildren()) do
		if v:IsA("Frame") then
			v:Destroy()
		end
	end
	local togglesSaved = plugin:GetSetting("DPPPins") or {}
	for i,v in pairs(link.tools:GetChildren()) do
		if searchTerm==nil or searchTerm=="" or string.match(string.lower(tostring(v)),string.lower(searchTerm)) then
			if pinToggles[v]==nil and table.find(togglesSaved,tostring(v)) then pinToggles[v]=true end
			local template = script.toolTemplate:Clone()
			if settings().Studio.Theme.Name==Enum.UITheme.Light.Name then
				template.icon.Image=v:GetAttribute("IconLight")
			else
				template.icon.Image=v:GetAttribute("Icon")
			end
			template.icon.title.Text=tostring(v)
			template.window.Value=v:WaitForChild("window").Value
			if not v:GetAttribute("Link") then
				template.learn.BackgroundTransparency=0.5
				template.learn.TextTransparency=0.5
			end
			template.Parent=script.Parent.holder
			if template.window.Value then connectRest(template) end
			table.insert(connections,template.toggle.MouseButton1Click:connect(function()
				if not template.window.Value then
					template.window.Value=createWindow(tostring(v),v.windowProperties:GetAttribute("WidgetInfoID"),tostring(v),v.windowProperties:GetAttribute("UIReference"))
					connectRest(template)
				else	
					template.window.Value.Enabled=not template.window.Value.Enabled
				end
			end))
			table.insert(connections,template.learn.MouseButton1Click:connect(function()
				script.Parent.videoLink.Size=UDim2.new(0,64,0,65)
				script.Parent.videoLink.linkBox.MaxVisibleGraphemes=0
				script.Parent.videoLink.linkBox.Text=v:GetAttribute("Link") or "https://youtu.be/GtL1huin9EE"--"No link provided"
				script.Parent.videoLink.Visible=true
				local p = {
					Size=UDim2.new(0.9,0,0,65)
				}
				t:Create(script.Parent.videoLink,tinfo,p):Play()
				local p = {
					MaxVisibleGraphemes=#script.Parent.videoLink.linkBox.Text
				}
				t:Create(script.Parent.videoLink.linkBox,tinfo,p):Play()
			end))
			table.insert(connections,template.MouseEnter:connect(function()
				template.icon.title.Visible=true
				template.icon.ImageTransparency=0.5
			end))
			table.insert(connections,template.MouseLeave:connect(function()
				template.icon.title.Visible=false
				template.icon.ImageTransparency=0
			end))
			if pinToggles[v] then
				template.icon.pin.ImageTransparency=0
			else
				template.icon.pin.ImageTransparency=0.75
			end
			table.insert(connections,template.icon.pin.MouseButton1Click:connect(function()
				pinToggles[v]=not pinToggles[v]
				if pinToggles[v] and not pinDebounce[v] then
					pinDebounce[v]=true
					local bar = _G.dpp.root:WaitForChild("toolbar").Value
					local icon = v:GetAttribute("Icon")
					if settings().Studio.Theme.Name==Enum.UITheme.Light.Name then
						icon=v:GetAttribute("IconLight")
					end
					local button = bar:CreateButton(tostring(v),v:GetAttribute("Description"),icon)
					button.ClickableWhenViewportHidden=true
					table.insert(connections,run.Heartbeat:connect(function()
						if not template.window.Value then return end
						button:SetActive(template.window.Value.Enabled)
					end))
					table.insert(connections,button.Click:connect(function()
						if not template.window.Value then
							template.window.Value=createWindow(tostring(v),v.windowProperties:GetAttribute("WidgetInfoID"),tostring(v),v.windowProperties:GetAttribute("UIReference"))
							connectRest(template)
						else	
							template.window.Value.Enabled=not template.window.Value.Enabled
						end
					end))
				end
				if pinToggles[v] then
					if plugin:GetSetting("DPPPins")==nil then
						plugin:SetSetting("DPPPins",{tostring(v)})
					else
						local current = plugin:GetSetting("DPPPins")
						table.insert(current,tostring(v))
						plugin:SetSetting("DPPPins",current)
					end
					template.icon.pin.ImageTransparency=0
				else
					if plugin:GetSetting("DPPPins")==nil then
						plugin:SetSetting("DPPPins",{tostring(v)})
					else
						local current = plugin:GetSetting("DPPPins")
						for a,b in pairs(current) do
							if tostring(v)==b then
								current[a]=nil
								break
							end
						end
						plugin:SetSetting("DPPPins",current)
					end
					warn("[Drone's Public Plugins] For the button to disappear you will have to reload the plugin.")
					template.icon.pin.ImageTransparency=0.75
				end
				--print(plugin:GetSetting("DPPPins"))
			end))
		end
	end
end

repeat
	wait(0.5)
until link~=nil
repeat
	wait(0.5)
until link:WaitForChild("tools"):GetChildren()[1]:FindFirstChild("window")

script.Parent.Parent.Changed:connect(function(pro)
	if pro=="Enabled" then
		update(script.Parent.search.bar.Text)
	end
end)

script.Parent.search.bar.Changed:connect(function(pro)
	if pro=="Text" then
		update(script.Parent.search.bar.Text)
	end
end)

--uis.InputBegan:connect(function(input,IsTyping)
--	if IsTyping then return end
--	if input.KeyCode==Enum.KeyCode.Unknown then return end
--	table.insert(currentInputs,input.KeyCode)
--	local matching = 0
--	for i,v in ipairs(triggerPattern) do
--		if currentInputs[i]==v then
--			matching+=1
--		end
--	end
--	if matching==#triggerPattern then
--		-- Trigger
--		script.Parent.Parent.Enabled=not script.Parent.Parent.Enabled
--	end
--	print(currentInputs,matching,triggerPattern)
--end)

--uis.InputEnded:connect(function(input)
--	if not table.find(currentInputs,input.KeyCode) then return end
--	currentInputs[table.find(currentInputs,input.KeyCode)]=nil
--end)