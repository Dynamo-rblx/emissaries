-- @ScriptType: LocalScript
local player = game:GetService("Players").LocalPlayer
local Mouse = player:GetMouse()
local PlayerGui = player:WaitForChild("PlayerGui")

function onButton1()
	local guis = PlayerGui:GetGuiObjectsAtPosition(Mouse.X,Mouse.Y)
	local isThere = false

	for i, v in pairs(guis) do
		if v:IsA("TextButton") or v:IsA("ImageButton") then
			
			
			if v:FindFirstChild("UI_Open") then
				script:WaitForChild("UI_Open"):Play()
			else
			
			-- script:WaitForChild("UI Click / Interact SFX"):WaitForChild("PitchShiftSoundEffect").Octave = Random.new():NextNumber(0.7,1)
				script:WaitForChild("UI Click / Interact SFX"):Play()
			end
		end
	end



end

game:GetService("UserInputService").InputBegan:Connect(function(input: InputObject, gameProcessedEvent: boolean) 
	if input.UserInputType == Enum.UserInputType.MouseButton1 or Enum.UserInputType.Touch then
		if gameProcessedEvent then
			onButton1()
		end
	end
end)