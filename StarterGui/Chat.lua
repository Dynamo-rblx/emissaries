-- @ScriptType: LocalScript
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("globalChatMsgSystemActivate").OnClientEvent:Connect(function(msg)
	
	game.StarterGui:SetCore("ChatMakeSystemMessage", {
		
		Text = msg;
		Font = Enum.Font.SourceSansBold;
		Color = Color3.fromRGB(188, 188, 188);
		FontSize = Enum.FontSize.Size14;
		
	})
	
end)