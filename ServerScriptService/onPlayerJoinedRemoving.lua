-- @ScriptType: Script
local DataStore = game:GetService("DataStoreService")
local mds = DataStore:GetDataStore("MissionsCompleted")
local tds = DataStore:GetDataStore("TokensStored")
local titleds = DataStore:GetDataStore("TitleStore")
local CA = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ChatAnnounce")
-- leaderstats is visible, Stats is not
local staminaDS = DataStore:GetDataStore("StaminaStore")
local healthDS = DataStore:GetDataStore("HealthStore")
local speedDS = DataStore:GetDataStore("SpeedStore")
local damageDS = DataStore:GetDataStore("DamageStore")
local reloadSpeedDS = DataStore:GetDataStore("ReloadSpeedStore")
local enduranceDS = DataStore:GetDataStore("EnduranceStore")
local unlockedOperativesDS = DataStore:GetDataStore("unlockedOpsStore")
local currentOpDS = DataStore:GetDataStore("currentOperativeStore")
local numTimesRolled = DataStore:GetDataStore("timesRolledDS")
local ownedTitlesDS = DataStore:GetDataStore("ownTitleStore")

-- Each mission
local tutorial = false
local zoocrew = false

local allTitlesList = {
	"🦖",
	"Newbie",
	"Tester",
	"Trainee",
	"Rookie",
	"Cookie",
	"Zookeeper",
	"Hacker",
	"Invader",
}

game:GetService('Players').PlayerAdded:Connect(function(plr)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = plr

	local missions = Instance.new("IntValue", leaderstats)
	missions.Name = "Successful Missions"
	missions.Value = mds:GetAsync(plr.UserId) or 0
	
	local tokens = Instance.new("IntValue", leaderstats)
	tokens.Name = "Tokens"
	tokens.Value = tds:GetAsync(plr.UserId) or 0
	
	

	script:WaitForChild("Stats"):Clone().Parent = plr
	levelDatastores(plr)
	repeat task.wait() until plr.Character
	if not(plr.Character:FindFirstChildOfClass("Shirt")) then
		local shirt = Instance.new("Shirt", plr.Character)
	end

	if not(plr:FindFirstChildOfClass("Pants")) then
		local pants = Instance.new("Pants", plr.Character)
	end
	
	local title = Instance.new("StringValue", leaderstats)
	title.Name = "Title"
	title.Value = titleds:GetAsync(plr.UserId) or "Newbie"
	
	local joinData = plr:GetJoinData()
	if joinData then
		local capturedData = joinData.TeleportData
		if capturedData then
			if capturedData.Complete == true then
				CA:FireAllClients(plr.Name.." just completed the level ["..capturedData.Name.."]!")
				plr:WaitForChild("Stats"):WaitForChild(capturedData.Name).Value = true
				--print(plr.Name.." just completed "..capturedData.Name)
				saveAllAsyncs(plr)
				if not(game:GetService("BadgeService"):UserHasBadgeAsync(plr.UserId, plr.Stats[capturedData.Name]:WaitForChild("Badge").Value)) then
					CA:FireAllClients(plr.Name.." just completed the level ["..capturedData.Name.."] for the first time!")
					CA:FireAllClients(plr.." just earned the badge ["..game:GetService("BadgeService"):GetBadgeInfoAsync(plr.Stats[capturedData.Name]:WaitForChild("Badge").Value).Name.."]!")
					game:GetService("BadgeService"):AwardBadge(plr.UserId, plr.Stats[capturedData.Name]:WaitForChild("Badge").Value)
					plr.leaderstats.Tokens.Value += plr.Stats[capturedData.Name]:WaitForChild("Reward").Value
				end
				if plr.Stats[capturedData.Name]:FindFirstChild("Reward") then
					plr.leaderstats["Successful Missions"].Value += 1
					plr.leaderstats.Tokens.Value += plr.Stats[capturedData.Name]:WaitForChild("Reward").Value
					
				end
				
			end
		end
	end
	
	if game:GetService("BadgeService"):UserHasBadgeAsync(plr.UserId, plr:WaitForChild("Stats")["Training"]:WaitForChild("Badge").Value) and not(plr:WaitForChild("Stats"):WaitForChild("Titles"):FindFirstChild("Trainee")) then
		local rewardTitle = Instance.new("StringValue")
		rewardTitle.Value = "Trainee"
		rewardTitle.Name = "Trainee"
		rewardTitle.Parent = plr:WaitForChild("Stats"):WaitForChild("Titles")
		
	elseif game:GetService("BadgeService"):UserHasBadgeAsync(plr.UserId, plr:WaitForChild("Stats")["Zoo Crew"]:WaitForChild("Badge").Value) and not(plr:WaitForChild("Stats"):WaitForChild("Titles"):FindFirstChild("Zookeeper")) then
		local rewardTitle = Instance.new("StringValue")
		rewardTitle.Value = "Zookeeper"
		rewardTitle.Name = "Zookeeper"
		rewardTitle.Parent = plr:WaitForChild("Stats"):WaitForChild("Titles")
	end
	
	saveAllAsyncs(plr)
	game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("changePlrList"):FireAllClients(plr, true)
end)

game.Players.PlayerRemoving:Connect(function(plr)
	saveAllAsyncs(plr)
	--print("Saved")
	game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("changePlrList"):FireAllClients(plr, false)
	--print("list changed")
	if plr:WaitForChild("Stats"):WaitForChild("CurrentLobby").Value ~= workspace then
		local destroyLobby = game.ReplicatedStorage:WaitForChild("Events"):WaitForChild("DestroyLobby")
		--print("defined")
		destroyLobby:FireClient(plr)
		--print("fired")
	end
	--print("completed")
end)

function levelDatastores(plr)
	-- SKILLS
	plr:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("SpeedLevel").Value = speedDS:GetAsync(plr.UserId) or 1
	plr:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("EnduranceLevel").Value = enduranceDS:GetAsync(plr.UserId) or 1
	plr:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("HealthLevel").Value = healthDS:GetAsync(plr.UserId) or 1
	plr:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("DamageLevel").Value = damageDS:GetAsync(plr.UserId) or 1
	plr:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("ReloadSpeedLevel").Value = reloadSpeedDS:GetAsync(plr.UserId) or 1
	plr:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("StaminaLevel").Value = staminaDS:GetAsync(plr.UserId) or 1
	plr:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("NumTimesRolled").Value = numTimesRolled:GetAsync(plr.UserId) or 0
	
	if currentOpDS:GetAsync(plr.UserId) then
		plr:WaitForChild("Stats"):WaitForChild("CurrentOperative").Value = game:GetService("ReplicatedStorage"):WaitForChild("Operatives"):WaitForChild(currentOpDS:GetAsync(plr.UserId))
	else
		plr:WaitForChild("Stats"):WaitForChild("CurrentOperative").Value = game:GetService("ReplicatedStorage"):WaitForChild("Operatives"):WaitForChild("Trainee")
	end
	
	if plr.UserId == 1219475555 or plr.UserId == 1 then
		local rewardTitle = Instance.new("StringValue")
		rewardTitle.Value = "🦖"
		rewardTitle.Name = "🦖"
		rewardTitle.Parent = plr:WaitForChild("Stats"):WaitForChild("Titles")
		
		local rewardTitle = Instance.new("StringValue")
		rewardTitle.Value = '<font color="#9717ff">Admin</font>'
		rewardTitle.Name = "Admin"
		rewardTitle.Parent = plr:WaitForChild("Stats"):WaitForChild("Titles")
		
		CA:FireAllClients("A dino has joined the lobby!")
	end
	
	
	for i, v in pairs(game:GetService("ReplicatedStorage"):WaitForChild("Operatives"):GetChildren()) do
		if unlockedOperativesDS:GetAsync(plr.UserId) and #unlockedOperativesDS:GetAsync(plr.UserId) > 0 then
			-- print(unlockedOperativesDS:GetAsync(plr.UserId))
			for i, w in pairs(unlockedOperativesDS:GetAsync(plr.UserId)) do
				
				if w == v.Name then
					v:Clone().Parent = plr:WaitForChild("Stats"):WaitForChild("Operatives")
				end
			end
		else
			if v.Name == "Trainee" then
				v:Clone().Parent = plr:WaitForChild("Stats"):WaitForChild("Operatives")
			end
		end
	end
	
	for i, v in pairs(allTitlesList) do
		if ownedTitlesDS:GetAsync(plr.UserId) and #ownedTitlesDS:GetAsync(plr.UserId) > 0 then
			-- print(ownedTitlesDS:GetAsync(plr.UserId))
			for i, t in pairs(ownedTitlesDS:GetAsync(plr.UserId)) do

				if t == v and not(plr:WaitForChild("Stats"):WaitForChild("Titles"):FindFirstChild(v)) then
					local temp = Instance.new("StringValue")
					temp.Value = t or v
					temp.Name = v
					temp.Parent = plr:WaitForChild("Stats"):WaitForChild("Titles")
				end
			end
		else
			if v == "Newbie" then
				local temp = Instance.new("StringValue")
				temp.Value = v
				temp.Name = v
				temp.Parent = plr:WaitForChild("Stats"):WaitForChild("Titles")
			end
		end
		
		local tempTable = {}
		for i, title in pairs(plr:WaitForChild("Stats"):WaitForChild("Titles"):GetChildren()) do
			if not(table.find(tempTable, title.Name)) then
				table.insert(tempTable, title.Name)
			else
				title:Destroy()
			end
		end
		-- print(tempTable)
	end
	

	
	-- LEVELS
	tutorialDS = DataStore:GetDataStore("tutorialCompleted")
	tutorial = tutorialDS:GetAsync(plr.UserId) or false
	plr:WaitForChild("Stats"):WaitForChild("Training").Value = tutorial

	zoocrewDS = DataStore:GetDataStore("zoocrewCompleted")
	zoocrew = zoocrewDS:GetAsync(plr.UserId) or false
	plr:WaitForChild("Stats"):WaitForChild("Zoo Crew").Value = zoocrew
end


function saveAllAsyncs(plr)
	-- ESSENTIALS
	mds:SetAsync(plr.UserId, plr.leaderstats["Successful Missions"].Value)
	tds:SetAsync(plr.UserId, plr.leaderstats["Tokens"].Value)
	titleds:SetAsync(plr.UserId, plr.leaderstats["Title"].Value)
	currentOpDS:SetAsync(plr.UserId, plr.Stats.CurrentOperative.Value.Name)
	
	local UnlockedOps = {}
	local OwnedTitles = {}
	
	for i, v in pairs(plr.Stats.Operatives:GetChildren()) do
		table.insert(UnlockedOps, v.Name)
	end
	
	for i, v in pairs(plr.Stats.Titles:GetChildren()) do
		table.insert(OwnedTitles, v.Value)
	end
	
	unlockedOperativesDS:SetAsync(plr.UserId, UnlockedOps)
	ownedTitlesDS:SetAsync(plr.UserId, OwnedTitles)
	
	-- LEVELS
	tutorialDS:SetAsync(plr.UserId, plr.Stats.Training.Value)
	zoocrewDS:SetAsync(plr.UserId, plr.Stats["Zoo Crew"].Value)
	
	
	-- SKILLS
	speedDS:SetAsync(plr.UserId, plr.Stats.Skills.SpeedLevel.Value)
	enduranceDS:SetAsync(plr.UserId, plr.Stats.Skills.EnduranceLevel.Value)
	healthDS:SetAsync(plr.UserId, plr.Stats.Skills.HealthLevel.Value)
	damageDS:SetAsync(plr.UserId, plr.Stats.Skills.DamageLevel.Value)
	reloadSpeedDS:SetAsync(plr.UserId, plr.Stats.Skills.ReloadSpeedLevel.Value)
	staminaDS:SetAsync(plr.UserId, plr.Stats.Skills.StaminaLevel.Value)
	numTimesRolled:SetAsync(plr.UserId, plr.Stats.Skills.NumTimesRolled.Value)
end