-- @ScriptType: LocalScript
local changed = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("changePlrList")

changed.OnClientEvent:Connect(function(plr, entering)
	if entering == true then
		local new = script.Parent:WaitForChild("Template"):Clone()
		new.Parent = script.Parent
		new.Visible = true
		while game.Players:FindFirstChild(plr.Name) do
			new.Name = plr.Name
			new:WaitForChild("AddFriend").Active = true
			new:WaitForChild("Name").Text = plr.DisplayName
			new:WaitForChild("Title").Text = plr:WaitForChild("leaderstats"):WaitForChild("Title").Value
			new:WaitForChild("Tokens").Text = tostring(plr:WaitForChild("leaderstats"):WaitForChild("Tokens").Value)
			new:WaitForChild("Missions").Text = tostring(plr:WaitForChild("leaderstats"):WaitForChild("Successful Missions").Value)
			task.wait()
		end
	else
		if script.Parent:FindFirstChild(plr.Name) then
			script.Parent:FindFirstChild(plr.Name):Destroy()
		end
	end
end)