-- @ScriptType: Script
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("spendTokens").OnServerEvent:Connect(function(plr, spent)
	plr:WaitForChild("leaderstats"):WaitForChild("Tokens").Value -= spent
end)

game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("changeStats").OnServerEvent:Connect(function(plr, stat, inc)
	local stat = plr:WaitForChild("Stats"):WaitForChild("Skills"):FindFirstChild(stat.."Level")
	if stat ~= nil then
		if inc == nil then inc = 1 end
		
		if stat.Value < 20 then
			stat.Value += inc
		else
			plr:WaitForChild("leadestats"):WaitForChild("Tokens").Value += (200*plr:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("NumTimesRolled"))/2
		end
		
	end
end)

game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("addNumRolled").OnServerEvent:Connect(function(plr)
	plr:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("NumTimesRolled").Value += 1
end)