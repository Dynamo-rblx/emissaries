-- @ScriptType: LocalScript
script.Parent.ImageTransparency = 1

while task.wait() do
		repeat task.wait(0.05)
			script.Parent.ImageTransparency -= 0.01
		until script.Parent.ImageTransparency <= 0
		task.wait(3)
		
		repeat task.wait(0.05)
			script.Parent.ImageTransparency += 0.01
		until script.Parent.ImageTransparency >= 0.8
		task.wait(3)
		
end