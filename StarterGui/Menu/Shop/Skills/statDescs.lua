-- @ScriptType: LocalScript
local healthDesc = script.Parent:WaitForChild("healthStat")
local speedDesc = script.Parent:WaitForChild("speedStat")
local damageDesc = script.Parent:WaitForChild("damageStat")
local enduranceDesc = script.Parent:WaitForChild("enduranceStat")
local reloadSpeedDesc = script.Parent:WaitForChild("reloadSpeedStat")
local staminaDesc = script.Parent:WaitForChild("staminaStat")


function colorRatio(val, display, btn)
	if val == 20 then
		display.TextColor3 = Color3.fromRGB(151, 23, 255)
	elseif val >= 15 then
		display.TextColor3 = Color3.fromRGB(255, 64, 64)
	elseif val >= 10 then
		display.TextColor3 = Color3.fromRGB(255, 177, 42)
	elseif val >= 5 then
		display.TextColor3 = Color3.fromRGB(57, 255, 64)
	elseif val < 5 then
		display.TextColor3 = Color3.fromRGB(82, 82, 82)
	end
end

while task.wait() do
	healthDesc.Text = "Health: L"..game.Players.LocalPlayer:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("HealthLevel").Value
	colorRatio(game.Players.LocalPlayer:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("HealthLevel").Value,healthDesc, script.Parent:WaitForChild("Health"))
	speedDesc.Text = "Speed: L"..game.Players.LocalPlayer:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("SpeedLevel").Value
	colorRatio(game.Players.LocalPlayer:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("SpeedLevel").Value,speedDesc, script.Parent:WaitForChild("Speed"))
	damageDesc.Text = "Damage: L"..game.Players.LocalPlayer:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("DamageLevel").Value
	colorRatio(game.Players.LocalPlayer:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("DamageLevel").Value,damageDesc, script.Parent:WaitForChild("Damage"))
	enduranceDesc.Text = "Endurance: L"..game.Players.LocalPlayer:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("EnduranceLevel").Value
	colorRatio(game.Players.LocalPlayer:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("EnduranceLevel").Value,enduranceDesc, script.Parent:WaitForChild("Endurance"))
	reloadSpeedDesc.Text = "Reload: L"..game.Players.LocalPlayer:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("ReloadSpeedLevel").Value
	colorRatio(game.Players.LocalPlayer:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("ReloadSpeedLevel").Value,reloadSpeedDesc, script.Parent:WaitForChild("ReloadSpeed"))
	staminaDesc.Text = "Stamina: L"..game.Players.LocalPlayer:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("StaminaLevel").Value
	colorRatio(game.Players.LocalPlayer:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("StaminaLevel").Value,staminaDesc, script.Parent:WaitForChild("Stamina"))
end

