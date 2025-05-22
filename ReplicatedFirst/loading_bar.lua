-- @ScriptType: LocalScript
game.ReplicatedFirst:RemoveDefaultLoadingScreen()
repeat task.wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui")
local ContentProvider = game:GetService("ContentProvider")
local screen = script:WaitForChild("overlay")
local loadingBar = screen.bg.bar.frame
local numberOfAssetsLoaded = screen:WaitForChild("numberOfAssetsLoaded")
local remaining = screen.bg.bar.remaining
screen.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local totalAssets = game.ContentProvider.RequestQueueSize
currentKnownAssets = game.ContentProvider.RequestQueueSize
numberOfAssetsLoaded.Value = game.ContentProvider.RequestQueueSize
while game.ContentProvider.RequestQueueSize > 0 do
		if game.ContentProvider.RequestQueueSize < currentKnownAssets then
			currentKnownAssets = game.ContentProvider.RequestQueueSize
			numberOfAssetsLoaded.Value = game.ContentProvider.RequestQueueSize
			numberOfAssetsLoaded.Changed:connect(function(assetsToLoad)
				local newX = 1 - numberOfAssetsLoaded.Value / totalAssets
				loadingBar:TweenSize(UDim2.new(newX, 0, 1, 0), "Out", "Quad", 0.5, true)
				remaining.Text = numberOfAssetsLoaded.Value .. (" items remaining")
			end)
		end
wait() 
end
remaining.Text = ("0 items remaining")
loadingBar:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quad", 0.5, true)
wait(2)
screen.bg.Visible = false