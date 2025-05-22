-- @ScriptType: Script
-- Global Chat
local MsgService = game:GetService("MessagingService")
MsgService:SubscribeAsync("GlobalChat", function(msg)

	local split = string.split(msg.Data, "sTRirNGgSEoPaRAtEr")

	if not game.Players:FindFirstChild(split[1]) then
		game.ReplicatedStorage:WaitForChild("Events"):WaitForChild("globalChatMsgSystemActivate"):FireAllClients(split[2])
	end

end)

game.Players.PlayerAdded:Connect(function(plr)
	plr.Chatted:Connect(function(msg)
		local filteredMsg = game:GetService("Chat"):FilterStringForBroadcast(msg, plr)
		local finalMsg = "{G} ".."["..plr.Name.."]: "..filteredMsg

		MsgService:PublishAsync("GlobalChat", plr.Name.."sTRirNGgSEoPaRAtEr"..finalMsg)
	end)
end)