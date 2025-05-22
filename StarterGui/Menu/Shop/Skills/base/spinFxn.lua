-- @ScriptType: LocalScript
local health = script.Parent.Parent:WaitForChild("Health")
local speed = script.Parent.Parent:WaitForChild("Speed")
local stamina = script.Parent.Parent:WaitForChild("Stamina")
local damage = script.Parent.Parent:WaitForChild("Damage")
local reloadSpeed = script.Parent.Parent:WaitForChild("ReloadSpeed")
local endurance = script.Parent.Parent:WaitForChild("Endurance")
local db = false

function Spin(seconds, seed)
	local secondsLeft = seconds
	local final = health
	local btwnTime = seed:NextNumber(0.1,0.2)
	script:WaitForChild("Graphic Movement Computer Scrolling Beeps 1 (SFX)"):Play()

	while secondsLeft > 0 do

		health.Image = "rbxassetid://76069251581299"
		final = health
		task.wait(btwnTime/4)
		secondsLeft -= btwnTime
		script:WaitForChild("round"):Play()
		if secondsLeft <= 0 then break end
		health.Image = "rbxassetid://135633357879732"
		speed.Image = "rbxassetid://76069251581299"
		final = speed
		task.wait(btwnTime/4)
		secondsLeft -= btwnTime
		script:WaitForChild("round"):Play()
		if secondsLeft <= 0 then break end
		speed.Image = "rbxassetid://135633357879732"
		damage.Image = "rbxassetid://76069251581299"
		final = damage
		task.wait(btwnTime/4)
		secondsLeft -= btwnTime
		script:WaitForChild("round"):Play()
		if secondsLeft <= 0 then break end
		damage.Image = "rbxassetid://135633357879732"
		reloadSpeed.Image = "rbxassetid://76069251581299"
		final = reloadSpeed
		task.wait(btwnTime/4)
		secondsLeft -= btwnTime
		script:WaitForChild("round"):Play()
		if secondsLeft <= 0 then break end
		reloadSpeed.Image = "rbxassetid://135633357879732"
		stamina.Image = "rbxassetid://76069251581299"
		final = stamina
		task.wait(btwnTime/4)
		secondsLeft -= btwnTime
		script:WaitForChild("round"):Play()
		if secondsLeft <= 0 then break end
		stamina.Image = "rbxassetid://135633357879732"
		endurance.Image = "rbxassetid://76069251581299"
		final = endurance
		task.wait(btwnTime/4)
		secondsLeft -= btwnTime
		script:WaitForChild("round"):Play()
		if secondsLeft <= 0 then break end
		endurance.Image = "rbxassetid://135633357879732"
		health.Image = "rbxassetid://76069251581299"
		final = health
	end
	script:WaitForChild("Graphic Movement Computer Scrolling Beeps 1 (SFX)"):Stop()
	return final
end

script.Parent.MouseEnter:Connect(function()
	script.Parent:WaitForChild("HoverBox").Visible = true
	script.Parent.ImageColor3 = Color3.fromRGB(255, 177, 42)
	script.Parent.Parent:WaitForChild("Description"):WaitForChild("Skill").Value = "Center"
end)

script.Parent.MouseLeave:Connect(function()
	script.Parent:WaitForChild("HoverBox").Visible = false
	script.Parent.ImageColor3 = Color3.fromRGB(255, 255, 255)
end)

script.Parent.MouseButton1Click:Connect(function()
	if game.Players.LocalPlayer:WaitForChild("leaderstats"):WaitForChild("Tokens").Value >= 200*game.Players.LocalPlayer:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("NumTimesRolled").Value and db==false then
		db = true
		game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("spendTokens"):FireServer(200*game.Players.LocalPlayer:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("NumTimesRolled").Value)
		script.Parent.Active = false
		local seed = Random.new()
		
		local upgrade = Spin(seed:NextNumber(1, 10), seed)
		game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("addNumRolled"):FireServer()
		local rarityUpgrade = math.random(0, 10)
		local levelsGained = 1
		local before = upgrade.ImageColor3

		if rarityUpgrade == math.random(0, 5) then
			levelsGained += 1
			upgrade.ImageColor3 = Color3.fromRGB(57, 255, 64)

			game.StarterGui:SetCore("SendNotification", {
				Title = "Double Upgrade",
				Text = "Nice! You got a rare double upgrade!",
				Duration = "5"
			})

			--[[rarityUpgrade = math.random(0, 10)
			--if rarityUpgrade == math.random(0, 10) then
			--	levelsGained += 1
			--	upgrade.ImageColor3 = Color3.fromRGB(255, 177, 42)

			--	rarityUpgrade = math.random(0, 100)
			--	if rarityUpgrade == math.random(0, 10) then
			--		levelsGained += 1
			--		upgrade.ImageColor3 = Color3.fromRGB(255, 64, 64)
			--	end

			--	rarityUpgrade = math.random(0, 1000)
			--	if rarityUpgrade == math.random(0, 100) then
			--		levelsGained += 4
			--		upgrade.ImageColor3 = Color3.fromRGB(151, 23, 255)
			--	end
			--end ]]
		end
		script:WaitForChild("pick"):Play()

		if levelsGained == 1 then
			game.StarterGui:SetCore("SendNotification", {
				Title = upgrade.Name,
				Text = "+"..levelsGained.." level gained",
				Duration = "5"
			})
		else
			game.StarterGui:SetCore("SendNotification", {
				Title = upgrade.Name,
				Text = "+"..levelsGained.." levels gained",
				Duration = "5"
			})
		end
		game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("changeStats"):FireServer(upgrade.Name, levelsGained)
		task.wait(0.85)



		upgrade.Image = "rbxassetid://135633357879732"
		upgrade.ImageColor3 = before
		script.Parent.Active = true
		db = false
	else
		script:WaitForChild("error"):Play()
	end

end)