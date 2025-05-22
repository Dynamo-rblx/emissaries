-- @ScriptType: LocalScript
local textLabel = script.Parent:WaitForChild("title")


local minGlitchDelay = 1 
local maxGlitchDelay = 4 
local glitchDuration = 0.10 
local glitchMagnitude = 30 
local glitchCharacters = {"#", "!", "@", "$", "%", "&", "*"} 
local originalPosition = textLabel.Position
local originalText = textLabel.Text
local function createGlitchEffect()
	local glitchTime = tick() + glitchDuration
	while tick() < glitchTime do
		local offsetX = math.random(-glitchMagnitude, glitchMagnitude)
		local offsetY = math.random(-glitchMagnitude, glitchMagnitude)
		local glitchText = ""
		for i = 1, #originalText do
			if math.random() > 0.5 then
				glitchText = glitchText .. glitchCharacters[math.random(1, #glitchCharacters)]
			else
				glitchText = glitchText .. originalText:sub(i, i)
			end
		end
		textLabel.Position = UDim2.new(originalPosition.X.Scale, originalPosition.X.Offset + offsetX, originalPosition.Y.Scale, originalPosition.Y.Offset + offsetY)
		textLabel.Text = glitchText
		wait(0.01)
	end

	textLabel.Position = originalPosition
	textLabel.Text = originalText
end

while true do
	createGlitchEffect()
	local randomDelay = math.random() * (maxGlitchDelay - minGlitchDelay) + minGlitchDelay
	wait(randomDelay)
end