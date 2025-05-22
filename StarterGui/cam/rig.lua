-- @ScriptType: LocalScript
task.wait(8)
local rig = game.Workspace:WaitForChild("Rig")

if math.random(1, 10) ~= 5 then
	rig:Destroy()
else
	local plr = game.Players.LocalPlayer
	local char = plr.Character


	rig:WaitForChild("Head"):WaitForChild("face").Texture = char:WaitForChild("Head"):FindFirstChildWhichIsA("Decal").Texture

	if char:FindFirstChildWhichIsA("BodyColors") then
		char:FindFirstChildWhichIsA("BodyColors"):Clone().Parent = rig
	else
		local c = char.Head.Color
		rig.Head.Color = c
		c = char["Right Arm"].Color
		rig["Right Arm"].Color = c
		c = char["Left Arm"].Color
		rig["Left Arm"].Color = c
		c = char["Right Leg"].Color
		rig["Right Leg"].Color = c
		c = char["Left Leg"].Color
		rig["Left Leg"].Color = c
	end

	while task.wait() do
		if char:FindFirstChildOfClass("Shirt") then
			char:FindFirstChildOfClass("Shirt"):Clone().Parent = rig
		end
		if char:FindFirstChildOfClass("Pants") then
			char:FindFirstChildOfClass("Pants"):Clone().Parent = rig
		end
		for i, v in pairs(char:GetChildren()) do
			if v:IsA("Accessory") and not(rig:FindFirstChild(v.Name)) then
				v:Clone().Parent = rig
			end
			if v:IsA("Hat") and not(rig:FindFirstChild(v.Name)) then
				v:Clone().Parent = rig
			end

		end
	end

end

