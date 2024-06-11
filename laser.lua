local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- a variable referencing to the laser model in the workspace
local laser = game.Workspace.laser


local raycastparms = Raycastparams.new()
-- filters the descendants of the Instance the raycast has hit if the Instance the raycast has hit is the Instance in this table
raycastparams.FilterDescendadentsInstance = {laser}

-- making a raycasting giving 2 arguments the position where the ray should start and the position where the ray should end then the last argument is the params
local result = game.Workspace:Raycast(laser.Part.Position, laser.Part.Position + Vector3.new(40, 0, 0), raycastparams)

local debounce = true

-- if statement checking if the raycast that I made has hit or meet any part or Instance in the workspace
if result then
  local target = result.Instance
  if target.Parent:FindFirstChild("Humanoid") and debounce == true then
    debounce = false
    target.Parent.Humanoid.Health -= 10
    wait(1)
    debounce = true
end
