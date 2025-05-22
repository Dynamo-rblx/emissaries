-- @ScriptType: LocalScript
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ChatAnnounce").OnClientEvent:Connect(function(txt)
	task.wait(3)
	game.StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = txt;
		Color = Color3.fromRGB(255, 177, 42);
		Font = Enum.Font.Michroma;
		Size = 14
	})
end)