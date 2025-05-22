-- @ScriptType: Script
local createLobby = game.ReplicatedStorage:WaitForChild("Events"):WaitForChild("CreateLobby")
local joinLobby = game.ReplicatedStorage:WaitForChild("Events"):WaitForChild("JoinLobby")
local deliverLobby = game.ReplicatedStorage:WaitForChild("Events"):WaitForChild("DeliverLobby")
local trainingLobby = game.ReplicatedStorage:WaitForChild("Events"):WaitForChild("TrainingCamp")
local destroyLobby = game.ReplicatedStorage:WaitForChild("Events"):WaitForChild("DestroyLobby")
local lobbies = game.ReplicatedStorage:WaitForChild("Lobbies")
local temp = lobbies:WaitForChild("Template")
local x = ""
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local function newLobby(mission, p1)
	local new = temp:Clone()

	new:WaitForChild("Mission").Value = mission

	local alphabet = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}

	local letter1, letter2, letter3 = alphabet[math.random(1, #alphabet)], alphabet[math.random(1, #alphabet)], alphabet[math.random(1, #alphabet)]
	local number1, number2, number3 = tostring(math.random(0, 9)), tostring(math.random(0,9)), tostring(math.random(0,9))

	new.Name = ""..letter1..number1..letter2..number2..letter3..number3

	if lobbies:FindFirstChild(new.Name) then
		repeat
			local letter1, letter2, letter3 = alphabet[math.random(1, #alphabet)], alphabet[math.random(1, #alphabet)], alphabet[math.random(1, #alphabet)]
			local number1, number2, number3 = tostring(math.random(0, 9)), tostring(math.random(0,9)), tostring(math.random(0,9))

			new.Name = letter1..number1..letter2..number2..letter3..number3
		until not(lobbies:FindFirstChild(new.Name))
	end

	new:WaitForChild("P1").Value = p1.Name
	new:WaitForChild("Players").Value = 1

	new.Parent = lobbies

	p1:WaitForChild("Stats"):WaitForChild("CurrentLobby").Value = new
	p1:WaitForChild("Stats"):WaitForChild("InLobby").Value = true
	game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("UpdateLobbyUI"):FireAllClients(true, new.Name, new:WaitForChild("Mission").Value, new:WaitForChild("Players").Value)
end

createLobby.OnServerEvent:Connect(function(plr, mission)
	newLobby(mission, plr)
end)

destroyLobby.OnServerEvent:Connect(function(plr, lobbyName)
	local lobby = lobbies:FindFirstChild(lobbyName)

	lobby:WaitForChild("P1")
	lobby:WaitForChild("P2")
	lobby:WaitForChild("P3")
	lobby:WaitForChild("P4")
	lobby:WaitForChild("Players")

	if lobby.P1.Value == plr.Name then
		lobby.P1.Value = lobby.P2.Value
		lobby.P2.Value = lobby.P3.Value
		lobby.P3.Value = lobby.P4.Value
		lobby.P4.Value = x
		lobby.Players.Value -= 1

	elseif lobby.P2.Value == plr.Name then
		lobby.P2.Value = lobby.P3.Value
		lobby.P3.Value = lobby.P4.Value
		lobby.P4.Value = x
		lobby.Players.Value -= 1

	elseif lobby.P3.Value == plr.Name then
		lobby.P3.Value = lobby.P4.Value
		lobby.P4.Value = x
		lobby.Players.Value -= 1

	elseif lobby.P4.Value == plr.Name then
		lobby.P4.Value = x
		lobby.Players.Value -= 1

	end

	if lobby.Players.Value == 0 then
		lobby:Destroy()
		game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("UpdateLobbyUI"):FireAllClients(false, lobby.Name)
	else
		game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("UpdateLobbyUI"):FireAllClients(true, lobby.Name, lobby:WaitForChild("Mission").Value, lobby:WaitForChild("Players").Value)
	end

	plr:WaitForChild("Stats"):WaitForChild("CurrentLobby").Value = game.Workspace
	plr:WaitForChild("Stats"):WaitForChild("InLobby").Value	= false

end)

joinLobby.OnServerEvent:Connect(function(plr, lobbyName)
	local lobby = lobbies:FindFirstChild(lobbyName)

	local p1 = lobby:WaitForChild("P1")
	local p2 = lobby:WaitForChild("P2")
	local p3 = lobby:WaitForChild("P3")
	local p4 = lobby:WaitForChild("P4")
	--print("done")
	lobby:WaitForChild("Players")

	if plr:WaitForChild("Stats"):WaitForChild("CurrentLobby").Value == game.Workspace then
		if lobby.Players.Value == 1 then
			lobby.P2.Value = plr.Name

			lobby.Players.Value = 2

		elseif lobby.Players.Value == 2 then
			lobby.P3.Value = plr.Name

			lobby.Players.Value = 3

		elseif lobby.Players.Value == 3 then
			lobby.P4.Value = plr.Name

			lobby.Players.Value = 4
		end

		plr:WaitForChild("Stats"):WaitForChild("InLobby").Value = true
		plr:WaitForChild("Stats"):WaitForChild("CurrentLobby").Value = lobby

		game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("UpdateLobbyUI"):FireAllClients(true, lobby.Name, lobby:WaitForChild("Mission").Value, lobby:WaitForChild("Players").Value)
	else
		local msg = Instance.new("Message")
		msg.Text = "You're already in a lobby!"
		msg.Parent = plr.PlayerGui
		task.wait(1.5)
		msg:Destroy()
	end
end)

deliverLobby.OnServerEvent:Connect(function(plr, lobby)
	local id = game.ReplicatedStorage:WaitForChild("PlaceIds"):WaitForChild(lobby.Mission.Value).Value

	if lobby:WaitForChild("Mission").Value == "Zoo Crew" then
		id = 18306429915
	elseif lobby:WaitForChild("Mission").Value == "" then

	end

	local player = {}
	local teleportData = {}

	if lobby:WaitForChild("Players").Value == 1 then
		local P1 = game.Players:FindFirstChild(lobby:WaitForChild("P1").Value)
		table.insert(player, P1)

		local P1Data = {
			["Name"] = P1.Name,
			["Shirt"] = P1.Character:FindFirstChildOfClass("Shirt").ShirtTemplate,
			["Pants"] = P1.Character:FindFirstChildOfClass("Pants").PantsTemplate,
			["Head"] = P1.Character:FindFirstChildOfClass("BodyColors").HeadColor.Name,
			["Torso"] = P1.Character:FindFirstChildOfClass("BodyColors").TorsoColor.Name,
			["LArm"] = P1.Character:FindFirstChildOfClass("BodyColors").LeftArmColor.Name,
			["RArm"] = P1.Character:FindFirstChildOfClass("BodyColors").RightArmColor.Name,
			["LLeg"] = P1.Character:FindFirstChildOfClass("BodyColors").LeftLegColor.Name,
			["RLeg"] = P1.Character:FindFirstChildOfClass("BodyColors").RightLegColor.Name,
			["Face"] = P1.Character:WaitForChild("Head"):FindFirstChildOfClass("Decal").Texture,
			["HealthLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("HealthLevel").Value,
			["StaminaLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("StaminaLevel").Value,
			["SpeedLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("SpeedLevel").Value,
			["EnduranceLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("EnduranceLevel").Value,
			["ReloadSpeedLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("ReloadSpeedLevel").Value,
			["DamageLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("DamageLevel").Value,
			["Operative"] = P1:WaitForChild("Stats"):WaitForChild("CurrentOperative"),
		}

		teleportData = {P1Data}

	elseif lobby:WaitForChild("Players").Value == 2 then
		local P1 = game.Players:FindFirstChild(lobby:WaitForChild("P1").Value)
		local P2 = game.Players:FindFirstChild(lobby:WaitForChild("P2").Value)
		table.insert(player, P1)
		table.insert(player, P2)

		local P1Data = {
			["Name"] = P1.Name,
			["Shirt"] = P1.Character:FindFirstChildOfClass("Shirt").ShirtTemplate,
			["Pants"] = P1.Character:FindFirstChildOfClass("Pants").PantsTemplate,
			["Head"] = P1.Character:FindFirstChildOfClass("BodyColors").HeadColor.Name,
			["Torso"] = P1.Character:FindFirstChildOfClass("BodyColors").TorsoColor.Name,
			["LArm"] = P1.Character:FindFirstChildOfClass("BodyColors").LeftArmColor.Name,
			["RArm"] = P1.Character:FindFirstChildOfClass("BodyColors").RightArmColor.Name,
			["LLeg"] = P1.Character:FindFirstChildOfClass("BodyColors").LeftLegColor.Name,
			["RLeg"] = P1.Character:FindFirstChildOfClass("BodyColors").RightLegColor.Name,
			["Face"] = P1.Character:WaitForChild("Head"):FindFirstChildOfClass("Decal").Texture,
			["HealthLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("HealthLevel").Value,
			["StaminaLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("StaminaLevel").Value,
			["SpeedLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("SpeedLevel").Value,
			["EnduranceLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("EnduranceLevel").Value,
			["ReloadSpeedLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("ReloadSpeedLevel").Value,
			["DamageLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("DamageLevel").Value,
			["Operative"] = P1:WaitForChild("Stats"):WaitForChild("CurrentOperative"),
		}

		local P2Data = {
			["Name"] = P2.Name,
			["Shirt"] = P2.Character:FindFirstChildOfClass("Shirt").ShirtTemplate,
			["Pants"] = P2.Character:FindFirstChildOfClass("Pants").PantsTemplate,
			["Head"] = P2.Character:FindFirstChildOfClass("BodyColors").HeadColor.Name,
			["Torso"] = P2.Character:FindFirstChildOfClass("BodyColors").TorsoColor.Name,
			["LArm"] = P2.Character:FindFirstChildOfClass("BodyColors").LeftArmColor.Name,
			["RArm"] = P2.Character:FindFirstChildOfClass("BodyColors").RightArmColor.Name,
			["LLeg"] = P2.Character:FindFirstChildOfClass("BodyColors").LeftLegColor.Name,
			["RLeg"] = P2.Character:FindFirstChildOfClass("BodyColors").RightLegColor.Name,
			["Face"] = P2.Character:WaitForChild("Head"):FindFirstChildOfClass("Decal").Texture,
			["HealthLevel"] = P2:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("HealthLevel").Value,
			["StaminaLevel"] = P2:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("StaminaLevel").Value,
			["SpeedLevel"] = P2:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("SpeedLevel").Value,
			["EnduranceLevel"] = P2:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("EnduranceLevel").Value,
			["ReloadSpeedLevel"] = P2:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("ReloadSpeedLevel").Value,
			["DamageLevel"] = P2:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("DamageLevel").Value,
			["Operative"] = P2:WaitForChild("Stats"):WaitForChild("CurrentOperative"),
		}

		teleportData = {P1Data, P2Data}

	elseif lobby:WaitForChild("Players").Value == 3 then
		local P1 = game.Players:FindFirstChild(lobby:WaitForChild("P1").Value)
		local P2 = game.Players:FindFirstChild(lobby:WaitForChild("P2").Value)
		local P3 = game.Players:FindFirstChild(lobby:WaitForChild("P3").Value)
		table.insert(player, P1)
		table.insert(player, P2)
		table.insert(player, P3)

		local P1Data = {
			["Name"] = P1.Name,
			["Shirt"] = P1.Character:FindFirstChildOfClass("Shirt").ShirtTemplate,
			["Pants"] = P1.Character:FindFirstChildOfClass("Pants").PantsTemplate,
			["Head"] = P1.Character:FindFirstChildOfClass("BodyColors").HeadColor.Name,
			["Torso"] = P1.Character:FindFirstChildOfClass("BodyColors").TorsoColor.Name,
			["LArm"] = P1.Character:FindFirstChildOfClass("BodyColors").LeftArmColor.Name,
			["RArm"] = P1.Character:FindFirstChildOfClass("BodyColors").RightArmColor.Name,
			["LLeg"] = P1.Character:FindFirstChildOfClass("BodyColors").LeftLegColor.Name,
			["RLeg"] = P1.Character:FindFirstChildOfClass("BodyColors").RightLegColor.Name,
			["Face"] = P1.Character:WaitForChild("Head"):FindFirstChildOfClass("Decal").Texture,
			["HealthLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("HealthLevel").Value,
			["StaminaLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("StaminaLevel").Value,
			["SpeedLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("SpeedLevel").Value,
			["EnduranceLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("EnduranceLevel").Value,
			["ReloadSpeedLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("ReloadSpeedLevel").Value,
			["DamageLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("DamageLevel").Value,
			["Operative"] = P1:WaitForChild("Stats"):WaitForChild("CurrentOperative"),
		}

		local P2Data = {
			["Name"] = P2.Name,
			["Shirt"] = P2.Character:FindFirstChildOfClass("Shirt").ShirtTemplate,
			["Pants"] = P2.Character:FindFirstChildOfClass("Pants").PantsTemplate,
			["Head"] = P2.Character:FindFirstChildOfClass("BodyColors").HeadColor.Name,
			["Torso"] = P2.Character:FindFirstChildOfClass("BodyColors").TorsoColor.Name,
			["LArm"] = P2.Character:FindFirstChildOfClass("BodyColors").LeftArmColor.Name,
			["RArm"] = P2.Character:FindFirstChildOfClass("BodyColors").RightArmColor.Name,
			["LLeg"] = P2.Character:FindFirstChildOfClass("BodyColors").LeftLegColor.Name,
			["RLeg"] = P2.Character:FindFirstChildOfClass("BodyColors").RightLegColor.Name,
			["Face"] = P2.Character:WaitForChild("Head"):FindFirstChildOfClass("Decal").Texture,
			["HealthLevel"] = P2:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("HealthLevel").Value,
			["StaminaLevel"] = P2:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("StaminaLevel").Value,
			["SpeedLevel"] = P2:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("SpeedLevel").Value,
			["EnduranceLevel"] = P2:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("EnduranceLevel").Value,
			["ReloadSpeedLevel"] = P2:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("ReloadSpeedLevel").Value,
			["DamageLevel"] = P2:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("DamageLevel").Value,
			["Operative"] = P2:WaitForChild("Stats"):WaitForChild("CurrentOperative"),
		}

		local P3Data = {
			["Name"] = P3.Name,
			["Shirt"] = P3.Character:FindFirstChildOfClass("Shirt").ShirtTemplate,
			["Pants"] = P3.Character:FindFirstChildOfClass("Pants").PantsTemplate,
			["Head"] = P3.Character:FindFirstChildOfClass("BodyColors").HeadColor.Name,
			["Torso"] = P3.Character:FindFirstChildOfClass("BodyColors").TorsoColor.Name,
			["LArm"] = P3.Character:FindFirstChildOfClass("BodyColors").LeftArmColor.Name,
			["RArm"] = P3.Character:FindFirstChildOfClass("BodyColors").RightArmColor.Name,
			["LLeg"] = P3.Character:FindFirstChildOfClass("BodyColors").LeftLegColor.Name,
			["RLeg"] = P3.Character:FindFirstChildOfClass("BodyColors").RightLegColor.Name,
			["Face"] = P3.Character:WaitForChild("Head"):FindFirstChildOfClass("Decal").Texture,
			["HealthLevel"] = P3:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("HealthLevel").Value,
			["StaminaLevel"] = P3:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("StaminaLevel").Value,
			["SpeedLevel"] = P3:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("SpeedLevel").Value,
			["EnduranceLevel"] = P3:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("EnduranceLevel").Value,
			["ReloadSpeedLevel"] = P3:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("ReloadSpeedLevel").Value,
			["DamageLevel"] = P3:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("DamageLevel").Value,
			["Operative"] = P3:WaitForChild("Stats"):WaitForChild("CurrentOperative"),
		}

		teleportData = {P1Data, P2Data, P3Data}

	elseif lobby:WaitForChild("Players").Value == 4 then
		local P1 = game.Players:FindFirstChild(lobby:WaitForChild("P1").Value)
		local P2 = game.Players:FindFirstChild(lobby:WaitForChild("P2").Value)
		local P3 = game.Players:FindFirstChild(lobby:WaitForChild("P3").Value)
		local P4 = game.Players:FindFirstChild(lobby:WaitForChild("P4").Value)
		table.insert(player, P1)
		table.insert(player, P2)
		table.insert(player, P3)
		table.insert(player, P4)

		local P1Data = {
			["Name"] = P1.Name,
			["Shirt"] = P1.Character:FindFirstChildOfClass("Shirt").ShirtTemplate,
			["Pants"] = P1.Character:FindFirstChildOfClass("Pants").PantsTemplate,
			["Head"] = P1.Character:FindFirstChildOfClass("BodyColors").HeadColor.Name,
			["Torso"] = P1.Character:FindFirstChildOfClass("BodyColors").TorsoColor.Name,
			["LArm"] = P1.Character:FindFirstChildOfClass("BodyColors").LeftArmColor.Name,
			["RArm"] = P1.Character:FindFirstChildOfClass("BodyColors").RightArmColor.Name,
			["LLeg"] = P1.Character:FindFirstChildOfClass("BodyColors").LeftLegColor.Name,
			["RLeg"] = P1.Character:FindFirstChildOfClass("BodyColors").RightLegColor.Name,
			["Face"] = P1.Character:WaitForChild("Head"):FindFirstChildOfClass("Decal").Texture,
			["HealthLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("HealthLevel").Value,
			["StaminaLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("StaminaLevel").Value,
			["SpeedLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("SpeedLevel").Value,
			["EnduranceLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("EnduranceLevel").Value,
			["ReloadSpeedLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("ReloadSpeedLevel").Value,
			["DamageLevel"] = P1:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("DamageLevel").Value,
			["Operative"] = P1:WaitForChild("Stats"):WaitForChild("CurrentOperative"),
		}

		local P2Data = {
			["Name"] = P2.Name,
			["Shirt"] = P2.Character:FindFirstChildOfClass("Shirt").ShirtTemplate,
			["Pants"] = P2.Character:FindFirstChildOfClass("Pants").PantsTemplate,
			["Head"] = P2.Character:FindFirstChildOfClass("BodyColors").HeadColor.Name,
			["Torso"] = P2.Character:FindFirstChildOfClass("BodyColors").TorsoColor.Name,
			["LArm"] = P2.Character:FindFirstChildOfClass("BodyColors").LeftArmColor.Name,
			["RArm"] = P2.Character:FindFirstChildOfClass("BodyColors").RightArmColor.Name,
			["LLeg"] = P2.Character:FindFirstChildOfClass("BodyColors").LeftLegColor.Name,
			["RLeg"] = P2.Character:FindFirstChildOfClass("BodyColors").RightLegColor.Name,
			["Face"] = P2.Character:WaitForChild("Head"):FindFirstChildOfClass("Decal").Texture,
			["HealthLevel"] = P2:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("HealthLevel").Value,
			["StaminaLevel"] = P2:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("StaminaLevel").Value,
			["SpeedLevel"] = P2:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("SpeedLevel").Value,
			["EnduranceLevel"] = P2:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("EnduranceLevel").Value,
			["ReloadSpeedLevel"] = P2:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("ReloadSpeedLevel").Value,
			["DamageLevel"] = P2:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("DamageLevel").Value,
			["Operative"] = P2:WaitForChild("Stats"):WaitForChild("CurrentOperative"),
		}

		local P3Data = {
			["Name"] = P3.Name,
			["Shirt"] = P3.Character:FindFirstChildOfClass("Shirt").ShirtTemplate,
			["Pants"] = P3.Character:FindFirstChildOfClass("Pants").PantsTemplate,
			["Head"] = P3.Character:FindFirstChildOfClass("BodyColors").HeadColor.Name,
			["Torso"] = P3.Character:FindFirstChildOfClass("BodyColors").TorsoColor.Name,
			["LArm"] = P3.Character:FindFirstChildOfClass("BodyColors").LeftArmColor.Name,
			["RArm"] = P3.Character:FindFirstChildOfClass("BodyColors").RightArmColor.Name,
			["LLeg"] = P3.Character:FindFirstChildOfClass("BodyColors").LeftLegColor.Name,
			["RLeg"] = P3.Character:FindFirstChildOfClass("BodyColors").RightLegColor.Name,
			["Face"] = P3.Character:WaitForChild("Head"):FindFirstChildOfClass("Decal").Texture,
			["HealthLevel"] = P3:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("HealthLevel").Value,
			["StaminaLevel"] = P3:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("StaminaLevel").Value,
			["SpeedLevel"] = P3:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("SpeedLevel").Value,
			["EnduranceLevel"] = P3:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("EnduranceLevel").Value,
			["ReloadSpeedLevel"] = P3:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("ReloadSpeedLevel").Value,
			["DamageLevel"] = P3:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("DamageLevel").Value,
			["Operative"] = P3:WaitForChild("Stats"):WaitForChild("CurrentOperative"),
		}

		local P4Data = {
			["Name"] = P4.Name,
			["Shirt"] = P4.Character:FindFirstChildOfClass("Shirt").ShirtTemplate,
			["Pants"] = P4.Character:FindFirstChildOfClass("Pants").PantsTemplate,
			["Head"] = P4.Character:FindFirstChildOfClass("BodyColors").HeadColor.Name,
			["Torso"] = P4.Character:FindFirstChildOfClass("BodyColors").TorsoColor.Name,
			["LArm"] = P4.Character:FindFirstChildOfClass("BodyColors").LeftArmColor.Name,
			["RArm"] = P4.Character:FindFirstChildOfClass("BodyColors").RightArmColor.Name,
			["LLeg"] = P4.Character:FindFirstChildOfClass("BodyColors").LeftLegColor.Name,
			["RLeg"] = P4.Character:FindFirstChildOfClass("BodyColors").RightLegColor.Name,
			["Face"] = P4.Character:WaitForChild("Head"):FindFirstChildOfClass("Decal").Texture,
			["HealthLevel"] = P4:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("HealthLevel").Value,
			["StaminaLevel"] = P4:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("StaminaLevel").Value,
			["SpeedLevel"] = P4:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("SpeedLevel").Value,
			["EnduranceLevel"] = P4:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("EnduranceLevel").Value,
			["ReloadSpeedLevel"] = P4:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("ReloadSpeedLevel").Value,
			["DamageLevel"] = P4:WaitForChild("Stats"):WaitForChild("Skills"):WaitForChild("DamageLevel").Value,
			["Operative"] = P4:WaitForChild("Stats"):WaitForChild("CurrentOperative"),
		}

		teleportData = {P1Data, P2Data, P3Data, P4Data}
	end

	local loading = script:WaitForChild(lobby.Mission.Value)

	for i, v in pairs(player) do
		loading:Clone().Parent = v.PlayerGui
	end

	local code = TeleportService:ReserveServer(id)

	local tpo = Instance.new("TeleportOptions")
	-- tpo.ShouldReserveServer = true
	tpo.ReservedServerAccessCode = code
	tpo:SetTeleportData(teleportData)

	TeleportService:TeleportAsync(id, player, tpo)

	game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("UpdateLobbyUI"):FireAllClients(false, lobby.Name)
	lobby:Destroy()


	--TeleportService:TeleportToPrivateServer(id, code, player, "StartSpot", teleportData, script:WaitForChild("main"))



end)

trainingLobby.OnServerEvent:Connect(function(plr)
	script:WaitForChild("training"):Clone().Parent = plr.PlayerGui

	local id = game.ReplicatedStorage:WaitForChild("PlaceIds"):WaitForChild("Training").Value
	local code = TeleportService:ReserveServer(id)
	local player = {}

	game.Workspace:WaitForChild(plr.Name)
	task.wait(1.3)

	local teleportData = {
		P1Data = {
			
		["Shirt"] = plr.Character:FindFirstChildOfClass("Shirt").ShirtTemplate,
		["Pants"] = plr.Character:FindFirstChildOfClass("Pants").PantsTemplate,
		["Head"] = plr.Character:FindFirstChildOfClass("BodyColors").HeadColor.Name,
		["Torso"] = plr.Character:FindFirstChildOfClass("BodyColors").TorsoColor.Name,
		["LArm"] = plr.Character:FindFirstChildOfClass("BodyColors").LeftArmColor.Name,
		["RArm"] = plr.Character:FindFirstChildOfClass("BodyColors").RightArmColor.Name,
		["LLeg"] = plr.Character:FindFirstChildOfClass("BodyColors").LeftLegColor.Name,
		["RLeg"] = plr.Character:FindFirstChildOfClass("BodyColors").RightLegColor.Name,
		["Face"] = plr.Character:WaitForChild("Head"):FindFirstChildOfClass("Decal").Texture,
		["Operative"] = plr:WaitForChild("Stats"):WaitForChild("CurrentOperative")
			
		}
	}

	table.insert(player, plr)



	local tpo = Instance.new("TeleportOptions")
	-- tpo.ShouldReserveServer = true
	tpo.ReservedServerAccessCode = code
	tpo:SetTeleportData(teleportData)

	TeleportService:TeleportAsync(id, player, tpo)

	-- TeleportService:TeleportToPrivateServer(id, code, player, "SpawnLocation", teleportData, script:WaitForChild("training"))
end)