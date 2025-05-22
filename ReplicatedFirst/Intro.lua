-- @ScriptType: LocalScript
local GUI = script:WaitForChild("main")
local plr = game.Players.LocalPlayer

GUI.Parent = plr.PlayerGui
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
script.Parent:RemoveDefaultLoadingScreen()
