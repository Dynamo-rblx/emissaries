-- @ScriptType: LocalScript
local cam = workspace.CurrentCamera

while task.wait() do
	cam.CameraType = Enum.CameraType.Scriptable
end