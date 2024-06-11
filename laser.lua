local ReplicatedStorage = game:GetService("ReplicatedStorage")

local laser = game.Workspace.laser

local raycastparms = Raycastparams.new()

raycastparams.FilterDescendadentsInstance = {laser}

local result = game.Workspace:Raycast(laser.Part.Position, laser.Part.Position + Vector3.new(40, 0, 0), raycastparams)

local debounce = true

if result then
  local target = result.Instance
  if target.Parent:FindFirstChild("Humanoid") and debounce == true then
    debounce = false
    target.Parent.Humanoid.Health -= 10
    wait(1)
    debounce = true
end
