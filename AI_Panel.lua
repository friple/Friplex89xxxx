-- Steal a Brainrot - Enhanced AI Panel
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Create main UI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local StatusLabel = Instance.new("TextLabel")
local AutoGrabButton = Instance.new("TextButton")
local ESPButton = Instance.new("TextButton")
local SpeedLabel = Instance.new("TextLabel")
local SpeedSlider = Instance.new("Frame")
local SpeedSliderBar = Instance.new("Frame")
local SpeedSliderButton = Instance.new("TextButton")
local SpeedValueLabel = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")

-- State variables
local autoGrabEnabled = false
local espEnabled = false
local autoGrabConnection = nil
local espConnection = nil
local currentSpeed = 16 -- Default Roblox speed
local espObjects = {}

-- Panel styling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "BrainrotAIPanelUI"
ScreenGui.ResetOnSpawn = false

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.5, -175, 0.5, -175)
Frame.Size = UDim2.new(0, 350, 0, 350)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundTransparency = 0.05

-- Add rounded corners to Frame
local FrameCorner = Instance.new("UICorner")
FrameCorner.Parent = Frame
FrameCorner.CornerRadius = UDim.new(0, 15)

-- Add gradient to Frame
local FrameGradient = Instance.new("UIGradient")
FrameGradient.Parent = Frame
FrameGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 40)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(20, 20, 30)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
}
FrameGradient.Rotation = 135

-- Add glow effect
local FrameStroke = Instance.new("UIStroke")
FrameStroke.Parent = Frame
FrameStroke.Color = Color3.fromRGB(100, 150, 255)
FrameStroke.Thickness = 2
FrameStroke.Transparency = 0.5

-- Status label (Title)
StatusLabel.Parent = Frame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Size = UDim2.new(1, -20, 0, 35)
StatusLabel.Position = UDim2.new(0, 10, 0, 10)
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Text = "🧠 BRAINROT STEALER 🧠"
StatusLabel.TextSize = 20
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
-- Auto Grab toggle button
AutoGrabButton.Parent = Frame
AutoGrabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
AutoGrabButton.Size = UDim2.new(0, 320, 0, 50)
AutoGrabButton.Position = UDim2.new(0.5, 0, 0, 60)
AutoGrabButton.AnchorPoint = Vector2.new(0.5, 0)
AutoGrabButton.Font = Enum.Font.GothamBold
AutoGrabButton.Text = "⚡ Auto Grab: OFF"
AutoGrabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoGrabButton.TextSize = 16
AutoGrabButton.BorderSizePixel = 0

local AutoGrabCorner = Instance.new("UICorner")
AutoGrabCorner.Parent = AutoGrabButton
AutoGrabCorner.CornerRadius = UDim.new(0, 10)

local AutoGrabStroke = Instance.new("UIStroke")
AutoGrabStroke.Parent = AutoGrabButton
AutoGrabStroke.Color = Color3.fromRGB(100, 100, 120)
AutoGrabStroke.Thickness = 1

-- ESP toggle button
ESPButton.Parent = Frame
ESPButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
ESPButton.Size = UDim2.new(0, 320, 0, 50)
ESPButton.Position = UDim2.new(0.5, 0, 0, 120)
ESPButton.AnchorPoint = Vector2.new(0.5, 0)
ESPButton.Font = Enum.Font.GothamBold
ESPButton.Text = "👁️ Base ESP: OFF"
ESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPButton.TextSize = 16
ESPButton.BorderSizePixel = 0

local ESPCorner = Instance.new("UICorner")
ESPCorner.Parent = ESPButton
ESPCorner.CornerRadius = UDim.new(0, 10)

local ESPStroke = Instance.new("UIStroke")
ESPStroke.Parent = ESPButton
ESPStroke.Color = Color3.fromRGB(100, 100, 120)
ESPStroke.Thickness = 1

-- Speed control label
SpeedLabel.Parent = Frame
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Size = UDim2.new(1, -20, 0, 25)
SpeedLabel.Position = UDim2.new(0, 10, 0, 185)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.Text = "🏃 Speed Control"
SpeedLabel.TextSize = 14
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Speed value label
SpeedValueLabel.Parent = Frame
SpeedValueLabel.BackgroundTransparency = 1
SpeedValueLabel.Size = UDim2.new(0, 60, 0, 25)
SpeedValueLabel.Position = UDim2.new(1, -70, 0, 185)
SpeedValueLabel.Font = Enum.Font.GothamBold
SpeedValueLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
SpeedValueLabel.Text = "16"
SpeedValueLabel.TextSize = 14
SpeedValueLabel.TextXAlignment = Enum.TextXAlignment.Right

-- Speed slider background
SpeedSlider.Parent = Frame
SpeedSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
SpeedSlider.Size = UDim2.new(0, 320, 0, 8)
SpeedSlider.Position = UDim2.new(0.5, 0, 0, 220)
SpeedSlider.AnchorPoint = Vector2.new(0.5, 0)
SpeedSlider.BorderSizePixel = 0

local SliderCorner = Instance.new("UICorner")
SliderCorner.Parent = SpeedSlider
SliderCorner.CornerRadius = UDim.new(0, 4)

-- Speed slider bar (filled portion)
SpeedSliderBar.Parent = SpeedSlider
SpeedSliderBar.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
SpeedSliderBar.Size = UDim2.new(0, 0, 1, 0)
SpeedSliderBar.Position = UDim2.new(0, 0, 0, 0)
SpeedSliderBar.BorderSizePixel = 0

local SliderBarCorner = Instance.new("UICorner")
SliderBarCorner.Parent = SpeedSliderBar
SliderBarCorner.CornerRadius = UDim.new(0, 4)

-- Speed slider button (draggable)
SpeedSliderButton.Parent = SpeedSlider
SpeedSliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SpeedSliderButton.Size = UDim2.new(0, 20, 0, 20)
SpeedSliderButton.Position = UDim2.new(0, -10, 0.5, -10)
SpeedSliderButton.AnchorPoint = Vector2.new(0, 0)
SpeedSliderButton.Text = ""
SpeedSliderButton.BorderSizePixel = 0

local SliderButtonCorner = Instance.new("UICorner")
SliderButtonCorner.Parent = SpeedSliderButton
SliderButtonCorner.CornerRadius = UDim.new(1, 0)

local SliderButtonStroke = Instance.new("UIStroke")
SliderButtonStroke.Parent = SpeedSliderButton
SliderButtonStroke.Color = Color3.fromRGB(100, 200, 255)
SliderButtonStroke.Thickness = 2

-- Close panel button
CloseButton.Parent = Frame
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseButton.Size = UDim2.new(0, 320, 0, 40)
CloseButton.Position = UDim2.new(0.5, 0, 1, -50)
CloseButton.AnchorPoint = Vector2.new(0.5, 0)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "❌ Close Panel"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 15
CloseButton.BorderSizePixel = 0

local CloseButtonCorner = Instance.new("UICorner")
CloseButtonCorner.Parent = CloseButton
CloseButtonCorner.CornerRadius = UDim.new(0, 10)

local CloseButtonStroke = Instance.new("UIStroke")
CloseButtonStroke.Parent = CloseButton
CloseButtonStroke.Color = Color3.fromRGB(150, 50, 50)
CloseButtonStroke.Thickness = 1

-- Make frame draggable
local dragging = false
local dragInput, mousePos, framePos

Frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		mousePos = input.Position
		framePos = Frame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

RunService.RenderStepped:Connect(function()
	if dragging and dragInput then
		local delta = dragInput.Position - mousePos
		Frame.Position = UDim2.new(
			framePos.X.Scale,
			framePos.X.Offset + delta.X,
			framePos.Y.Scale,
			framePos.Y.Offset + delta.Y
		)
	end
end)

-- Speed slider functionality
local function updateSpeed(value)
	currentSpeed = math.clamp(value, 16, 30)
	SpeedValueLabel.Text = tostring(math.floor(currentSpeed))
	
	-- Update slider position
	local percentage = (currentSpeed - 16) / (30 - 16)
	SpeedSliderBar.Size = UDim2.new(percentage, 0, 1, 0)
	SpeedSliderButton.Position = UDim2.new(percentage, -10, 0.5, -10)
	
	-- Apply speed to character
	local character = LocalPlayer.Character
	if character and character:FindFirstChild("Humanoid") then
		character.Humanoid.WalkSpeed = currentSpeed
	end
end

local sliderDragging = false

SpeedSliderButton.MouseButton1Down:Connect(function()
	sliderDragging = true
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		sliderDragging = false
	end
end)

RunService.RenderStepped:Connect(function()
	if sliderDragging then
		local mousePos = UserInputService:GetMouseLocation()
		local sliderPos = SpeedSlider.AbsolutePosition.X
		local sliderSize = SpeedSlider.AbsoluteSize.X
		local relative = math.clamp(mousePos.X - sliderPos, 0, sliderSize)
		local percentage = relative / sliderSize
		local newSpeed = 16 + (percentage * (30 - 16))
		updateSpeed(newSpeed)
	end
end)

-- Initialize speed slider
updateSpeed(16)

-- Continuous speed application (works with brainrot in hands)
RunService.Heartbeat:Connect(function()
	local character = LocalPlayer.Character
	if character and character:FindFirstChild("Humanoid") then
		if character.Humanoid.WalkSpeed ~= currentSpeed then
			character.Humanoid.WalkSpeed = currentSpeed
		end
	end
end)

-- ESP Functions
local function clearESP()
	for _, espObj in pairs(espObjects) do
		if espObj and espObj.Parent then
			espObj:Destroy()
		end
	end
	espObjects = {}
end

local function createESPBox(part, text, color)
	-- Create BillboardGui for ESP
	local billboard = Instance.new("BillboardGui")
	billboard.Name = "ESPBillboard"
	billboard.Adornee = part
	billboard.Size = UDim2.new(0, 200, 0, 50)
	billboard.StudsOffset = Vector3.new(0, 3, 0)
	billboard.AlwaysOnTop = true
	billboard.Parent = part
	
	-- Background frame
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundColor3 = color
	frame.BackgroundTransparency = 0.7
	frame.BorderSizePixel = 0
	frame.Parent = billboard
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = frame
	
	-- Text label
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.GothamBold
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextSize = 14
	label.Text = text
	label.TextStrokeTransparency = 0.5
	label.Parent = frame
	
	-- Create highlight box
	local highlight = Instance.new("Highlight")
	highlight.Name = "ESPHighlight"
	highlight.Adornee = part
	highlight.FillColor = color
	highlight.FillTransparency = 0.7
	highlight.OutlineColor = color
	highlight.OutlineTransparency = 0
	highlight.Parent = part
	
	table.insert(espObjects, billboard)
	table.insert(espObjects, highlight)
end

local function updateESP()
	clearESP()
	
	if not espEnabled then return end
	
	-- Search for bases and brainrot items in workspace
	for _, obj in pairs(workspace:GetDescendants()) do
		-- Look for bases (you may need to adjust this based on game structure)
		if obj:IsA("Model") and (obj.Name:lower():find("base") or obj.Name:lower():find("brainrot")) then
			local primaryPart = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
			if primaryPart then
				-- Check if it's a friend's base or enemy's base
				local isOpen = obj:FindFirstChild("Open") and obj.Open.Value or false
				local timer = obj:FindFirstChild("Timer") and obj.Timer.Value or "N/A"
				local baseType = obj:FindFirstChild("Type") and obj.Type.Value or "Unknown"
				
				local statusText = string.format("🏠 %s\n⏱️ %s\n%s", 
					baseType, 
					tostring(timer),
					isOpen and "🟢 Open" or "🔴 Closed"
				)
				
				local color = isOpen and Color3.fromRGB(50, 255, 100) or Color3.fromRGB(255, 100, 50)
				createESPBox(primaryPart, statusText, color)
			end
		end
		
		-- Look for brainrot items specifically
		if obj:IsA("BasePart") and obj.Name:lower():find("brainrot") then
			createESPBox(obj, "🧠 BRAINROT", Color3.fromRGB(255, 200, 0))
		end
	end
end

-- ESP Button Logic
ESPButton.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	if espEnabled then
		ESPButton.Text = "👁️ Base ESP: ON"
		ESPButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
		ESPStroke.Color = Color3.fromRGB(50, 255, 100)
		
		-- Start ESP update loop
		if espConnection then
			espConnection:Disconnect()
		end
		
		espConnection = RunService.Heartbeat:Connect(function()
			if espEnabled then
				-- Update ESP every second (reduce performance impact)
				wait(1)
				updateESP()
			end
		end)
		
		updateESP()
	else
		ESPButton.Text = "👁️ Base ESP: OFF"
		ESPButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
		ESPStroke.Color = Color3.fromRGB(100, 100, 120)
		
		if espConnection then
			espConnection:Disconnect()
			espConnection = nil
		end
		
		clearESP()
	end
end)

-- Enhanced Auto Grab Logic (works on other players' bases and brainrot)
AutoGrabButton.MouseButton1Click:Connect(function()
	autoGrabEnabled = not autoGrabEnabled
	if autoGrabEnabled then
		AutoGrabButton.Text = "⚡ Auto Grab: ON"
		AutoGrabButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
		AutoGrabStroke.Color = Color3.fromRGB(50, 255, 100)
		
		-- Disconnect existing connection to prevent duplicates
		if autoGrabConnection then
			autoGrabConnection:Disconnect()
		end
		
		-- Enhanced Auto Grab logic (simulates E button press)
		autoGrabConnection = RunService.RenderStepped:Connect(function()
			if autoGrabEnabled then
				local character = LocalPlayer.Character
				if character and character:FindFirstChild("HumanoidRootPart") then
					local rootPart = character.HumanoidRootPart
					
					-- Search for brainrot items and interactable objects
					for _, item in pairs(workspace:GetDescendants()) do
						-- Check for brainrot items or collectibles
						if item:IsA("BasePart") or item:IsA("Model") then
							local itemPart = item:IsA("Model") and (item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")) or item
							
							if itemPart then
								local distance = (itemPart.Position - rootPart.Position).Magnitude
								
								-- Auto grab within 10 studs (increased range)
								if distance < 10 then
									-- Try firetouchinterest method
									pcall(function()
										firetouchinterest(rootPart, itemPart, 0)
										firetouchinterest(rootPart, itemPart, 1)
									end)
									
									-- Try finding ProximityPrompt (E button interaction)
									local prompt = item:FindFirstChildWhichIsA("ProximityPrompt", true)
									if prompt then
										pcall(function()
											fireproximityprompt(prompt)
										end)
									end
									
									-- Try ClickDetector
									local clickDetector = item:FindFirstChildWhichIsA("ClickDetector", true)
									if clickDetector then
										pcall(function()
											fireclickdetector(clickDetector)
										end)
									end
								end
							end
						end
					end
				end
			end
		end)
	else
		AutoGrabButton.Text = "⚡ Auto Grab: OFF"
		AutoGrabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
		AutoGrabStroke.Color = Color3.fromRGB(100, 100, 120)
		
		-- Disconnect RenderStepped connection when disabled
		if autoGrabConnection then
			autoGrabConnection:Disconnect()
			autoGrabConnection = nil
		end
	end
end)

-- Close panel (hides instead of destroying)
CloseButton.MouseButton1Click:Connect(function()
	ScreenGui.Enabled = false
	
	-- Cleanup when closing
	if autoGrabEnabled then
		autoGrabEnabled = false
		if autoGrabConnection then
			autoGrabConnection:Disconnect()
			autoGrabConnection = nil
		end
	end
	
	if espEnabled then
		espEnabled = false
		if espConnection then
			espConnection:Disconnect()
			espConnection = nil
		end
		clearESP()
	end
end)

-- Keybind to toggle panel (Insert key)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
		ScreenGui.Enabled = not ScreenGui.Enabled
	end
end)

print("🧠 Brainrot Stealer loaded! Press INSERT to toggle panel.")
