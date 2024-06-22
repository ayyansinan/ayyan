local ReplicatedStorage = game:GetService("ReplicatedStorage")

local punch = ReplicatedStorage:WaitForChild("punch")
-- getting players service
local players = game:GetService("Players")
-- getting local player
local player = players.LocalPlayer
-- getting userinputservice
local UserInputService = game:GetService("UserInputService")

local debounce = false

local equipped = false

script.Parent.Equipped:Connect(function()
	equipped = true
end)

script.Parent.Activated:Connect(function()
	if debounce == false then
		debounce = true
		
		punch:FireServer()
		-- getting the players character
		local character = player.Character
		
		if character then
			local humanoid = character:FindFirstChild("Humanoid")
			-- checking if there is a humanoid
			if humanoid then
          -- getting the animator
				local animator = humanoid.Animator
          -- loading the animation
				local punchanimation = animator:LoadAnimation(script.Parent.Animation)
				-- making the animation type to action4
				punchanimation.Priority = Enum.AnimationPriority.Action4
				-- playing the animation
				punchanimation:Play()
			end
		end
		
		task.wait(0.3)
		
		debounce = false
	end
end)

-- gui

local players = game:GetService("Players")
-- this is getting the local player
local player = players.LocalPlayer
-- this is getting the tweenservice
local TweenService = game:GetService("TweenService")

-- this is checking if the energys value property has changed then it is connecting it to a function
player.energy:GetPropertyChangedSignal("Value"):Connect(function()
	
	local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Sine)
	
	local goal = {Size = UDim2.fromScale(math.clamp(player.energy.Value, 0, 100) / 100, 1)}
	
	local tween = TweenService:Create(script.Parent, tweenInfo, goal)
	
	tween:Play()
	
	script.Parent.Parent.TextLabel.Text = player.energy.Value.."/100"
end)



-- server

local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- this is waiting for the punch remote event
local punch = ReplicatedStorage:WaitForChild("punch")

local players = game:GetService("Players")

players.PlayerAdded:Connect(function(player)
	-- making a new intvalue and setting its value to 100
	local energy = Instance.new("IntValue")
	energy.Name = "energy"
	energy.Value = 100
	energy.Parent = player
end)

local playershealing = {}

table.insert(playershealing, players:WaitForChild("ayyansinan_22"))

punch.OnServerEvent:Connect(function(player)
	local character = player.Character
	-- checking if the character is there
	if character then
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			-- checking if the players energy value greater then or equal to 10
			if player.energy.Value >= 10 then
				player.energy.Value -= 10
				
				local boxcframe = character.HumanoidRootPart.CFrame
				local boxsize = Vector3.new(4, 4, 4)
				
				local params = OverlapParams.new()
				
				-- this is to filter the players character
				params.FilterDescendantsInstances = {character}
				params.FilterType = Enum.RaycastFilterType.Exclude
				params.MaxParts = 50
				
				-- this is the result it returns a table
				local result = workspace:GetPartBoundsInBox(boxcframe, boxsize, params)
				
				for i, v in result do
					local otherhumanoid = v.Parent:FindFirstChild("Humanoid")
					-- checking if the player that got hit has more then 0 health
					if otherhumanoid then
						if otherhumanoid.Health > 0 then
							-- then taking away 10 health from the other player
							otherhumanoid.Health -= 10
						end
					end
					break
				end
			end
		end
	end
end)
