-- @ScriptType: LocalScript
local open = true


local TS = game:GetService("TweenService")
local TI = TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)


script.Parent.Event:Connect(function(levelName)
	if levelName and levelName ~= "" then
		if open then
			script.Parent.Parent:TweenSizeAndPosition(UDim2.new(1,0,0,0), UDim2.new(0.5,0,0.5,0),Enum.EasingDirection.In,Enum.EasingStyle.Linear,0.5, true)
			task.wait(0.5)
			script.Parent.Parent.Visible = false
			open = false

			script.Parent.Parent.Parent:WaitForChild("pageTitle"):TweenPosition(UDim2.new(0.379,0,-0.15,0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.15)
			task.wait(0.15)
			script.Parent.Parent.Parent.pageTitle.Text = levelName
			script.Parent.Parent.Parent:WaitForChild("InfoActive").Value = levelName
			script.Parent.Parent.Parent:WaitForChild("pageTitle"):TweenPosition(UDim2.new(0.379,0,0.096,0), Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.15)
			script.Parent.Parent.Parent:FindFirstChild(levelName).Visible = true
			local t = TS:Create(script.Parent.Parent.Parent:WaitForChild("CoverFrame"), TI, {Transparency=1})
			t:Play()


		else
			local t = TS:Create(script.Parent.Parent.Parent:WaitForChild("CoverFrame"), TI, {Transparency=0})
			t:Play()
			t.Completed:Wait()
			script.Parent.Parent.Parent:FindFirstChild(levelName).Visible = false

			script.Parent.Parent.Visible = true
			script.Parent.Parent:TweenSizeAndPosition(UDim2.new(1,0,0.5,0), UDim2.new(0.5,0,0.5,0),Enum.EasingDirection.In,Enum.EasingStyle.Linear,0.5, true)
			task.wait(0.5)
			open = true

			script.Parent.Parent.Parent:WaitForChild("pageTitle"):TweenPosition(UDim2.new(0.379,0,-0.15,0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.1)
			task.wait(0.1)
			script.Parent.Parent.Parent.pageTitle.Text = "Anomalies"
			script.Parent.Parent.Parent:WaitForChild("pageTitle"):TweenPosition(UDim2.new(0.379,0,0.096,0), Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.1)


		end
	end	
end)