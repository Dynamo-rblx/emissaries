-- @ScriptType: Script
local DataStore = game:GetService("DataStoreService")
local mds = DataStore:GetDataStore("MissionsCompleted")
local tds = DataStore:GetDataStore("TokensStored")

local staminaDS = DataStore:GetDataStore("StaminaStore")
local healthDS = DataStore:GetDataStore("HealthStore")
local speedDS = DataStore:GetDataStore("SpeedStore")
local damageDS = DataStore:GetDataStore("DamageStore")
local reloadSpeedDS = DataStore:GetDataStore("ReloadSpeedStore")
local enduranceDS = DataStore:GetDataStore("EnduranceStore")

local numTimesRolled = DataStore:GetDataStore("timesRolledDS")

game.Players.PlayerAdded:connect(function(plr)
	plr.Chatted:connect(function(msg)
		if msg == "/reset" and plr.UserId == 1219475555 then
			tds:SetAsync(plr.UserId, 100000)
			local tokens = plr.leaderstats.Tokens
			tokens.Value = tds:GetAsync(plr.UserId)

			speedDS:SetAsync(plr.UserId, 1)
			enduranceDS:SetAsync(plr.UserId, 1)
			healthDS:SetAsync(plr.UserId, 1)
			damageDS:SetAsync(plr.UserId, 1)
			reloadSpeedDS:SetAsync(plr.UserId, 1)
			staminaDS:SetAsync(plr.UserId, 1)
			numTimesRolled:SetAsync(plr.UserId, 0)
			
			plr:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("SpeedLevel").Value = speedDS:GetAsync(plr.UserId) or 1
			plr:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("EnduranceLevel").Value = enduranceDS:GetAsync(plr.UserId) or 1
			plr:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("HealthLevel").Value = healthDS:GetAsync(plr.UserId) or 1
			plr:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("DamageLevel").Value = damageDS:GetAsync(plr.UserId) or 1
			plr:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("ReloadSpeedLevel").Value = reloadSpeedDS:GetAsync(plr.UserId) or 1
			plr:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("StaminaLevel").Value = staminaDS:GetAsync(plr.UserId) or 1
			plr:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("NumTimesRolled").Value = numTimesRolled:GetAsync(plr.UserId) or 0
		end
	end)
end)