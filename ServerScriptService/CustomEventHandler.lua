-- @ScriptType: Script
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("EquipOp").OnServerEvent:Connect(function(plr, newOp)
	if plr:WaitForChild("Stats"):WaitForChild("Operatives"):FindFirstChild(newOp) then
		plr:WaitForChild("Stats"):WaitForChild("CurrentOperative").Value = game:GetService("ReplicatedStorage"):WaitForChild("Operatives"):WaitForChild(newOp)
	end
end)

game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("BuyOp").OnServerEvent:Connect(function(plr, newOp, cost)
	if not(plr:WaitForChild("Stats"):WaitForChild("Operatives"):FindFirstChild(newOp)) and plr:WaitForChild("leaderstats"):WaitForChild("Tokens").Value >= cost then
		plr:WaitForChild("leaderstats"):WaitForChild("Tokens").Value -= cost
		game:GetService("ReplicatedStorage"):WaitForChild("Operatives"):WaitForChild(newOp):Clone().Parent = plr:WaitForChild("Stats"):WaitForChild("Operatives")
	end
end)

game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("setTitle").OnServerEvent:Connect(function(plr, title)
	
	if plr:WaitForChild("Stats"):WaitForChild("Titles"):FindFirstChild(title) then
		--print("Title"..plr.Name..title)
		plr:WaitForChild("Stats"):WaitForChild("CurrentTitle").Value = title
		plr:WaitForChild("leaderstats"):WaitForChild("Title").Value = title
	else
		local titles = plr:WaitForChild("Stats"):WaitForChild("Titles"):GetChildren()
		for i = 1, #titles do
			if titles[i].Value == title then
				--print("Title"..plr.Name..title)
				plr:WaitForChild("Stats"):WaitForChild("CurrentTitle").Value = title
				plr:WaitForChild("leaderstats"):WaitForChild("Title").Value = title
			end
		end
	end
end)

game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("DestroyItem").OnServerEvent:Connect(function(plr, item, lifetime)
	game:GetService("Debris"):AddItem(item, lifetime)
end)