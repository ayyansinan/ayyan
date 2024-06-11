local ReplicatedStorage = game:GetService("ReplicatedStorage")

local players = game:GetService("Players")

local warn = ReplicatedStorage:WaitForChild("warn")

-- a variable referencing to the laser model in the workspace
local laser = game.Workspace.laser

local endpart = game.Workspace.endpart

local raycastparams = Raycastparams.new()
-- filters the descendants of the Instance the raycast has hit if the Instance the raycast has hit is the Instance in this table
raycastparams.FilterDescendadentsInstance = {laser}

-- this is the direction of the ray
local direction = (laser.Position - endpart.Position).Unit * 40

-- making a raycasting giving 2 arguments the position where the ray should start and the position where the ray should end then the last argument is the params
local result = game.Workspace:Raycast(laser.Part.Position, raycastparams)

local debounce = true

-- if statement checking if the raycast that I made has hit or meet any part or Instance in the workspace
if result then
  local target = result.Instance
  if target.Parent:FindFirstChild("Humanoid") and debounce == true then
    -- this will get the player from the character
    local player = players:GetPlayerFromCharacter(target.Parent)

    warn:FireClient(player)
    
    debounce = false
    target.Parent.Humanoid.Health -= 10
    wait(1)
    debounce = true
end


