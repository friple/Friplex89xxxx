-- Create AI Panel
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local AutoGrabButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")

-- Auto Grab state variable
local autoGrabEnabled = false
local autoGrabConnection = nil

-- Panel styling
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "AIPanelUI"

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundTransparency = 0.1

-- Add rounded corners to Frame
local FrameCorner = Instance.new("UICorner")
FrameCorner.Parent = Frame
FrameCorner.CornerRadius = UDim.new(0, 12)

-- Add gradient to Frame
local FrameGradient = Instance.new("UIGradient")
FrameGradient.Parent = Frame
FrameGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 35)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
}
FrameGradient.Rotation = 45

-- Auto Grab toggle button
AutoGrabButton.Parent = Frame
AutoGrabButton.BackgroundColor3 = Color3.fromRGB(45, 140, 200)
AutoGrabButton.Size = UDim2.new(0, 250, 0, 50)
AutoGrabButton.Position = UDim2.new(0.5, 0, 0.3, 0)
AutoGrabButton.AnchorPoint = Vector2.new(0.5, 0.5)
AutoGrabButton.Font = Enum.Font.SourceSansBold
AutoGrabButton.Text = "Auto Grab: OFF"
AutoGrabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoGrabButton.TextSize = 18
AutoGrabButton.BorderSizePixel = 0

-- Add rounded corners to Auto Grab button
local AutoGrabCorner = Instance.new("UICorner")
AutoGrabCorner.Parent = AutoGrabButton
AutoGrabCorner.CornerRadius = UDim.new(0, 8)

-- Status label
StatusLabel.Parent = Frame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 0.1, 0)
StatusLabel.Font = Enum.Font.SourceSansBold
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Text = "AI Panel Functions"
StatusLabel.TextSize = 22

-- Close panel button
CloseButton.Parent = Frame
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Size = UDim2.new(0, 100, 0, 30)
CloseButton.Position = UDim2.new(0.5, 0, 0.8, 0)
CloseButton.AnchorPoint = Vector2.new(0.5, 0.5)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "Close"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.BorderSizePixel = 0

-- Add rounded corners to Close button
local CloseButtonCorner = Instance.new("UICorner")
CloseButtonCorner.Parent = CloseButton
CloseButtonCorner.CornerRadius = UDim.new(0, 8)

-- Auto Grab logic
AutoGrabButton.MouseButton1Click:Connect(function()
	autoGrabEnabled = not autoGrabEnabled
	if autoGrabEnabled then
		AutoGrabButton.Text = "Auto Grab: ON"
		AutoGrabButton.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
		
		-- Disconnect existing connection to prevent duplicates
		if autoGrabConnection then
			autoGrabConnection:Disconnect()
		end
		
		-- Auto Grab logic (with fail-safe)
		autoGrabConnection = game:GetService("RunService").RenderStepped:Connect(function()
			if autoGrabEnabled then
				local character = game.Players.LocalPlayer.Character
				if character and character:FindFirstChild("HumanoidRootPart") then
					local rootPart = character.HumanoidRootPart
					
					for _, item in pairs(workspace:GetChildren()) do
						if item:IsA("BasePart") and (item.Position - rootPart.Position).Magnitude < 5 then
							-- Use pcall for fail-safe execution
							pcall(function()
								firetouchinterest(rootPart, item, 0) -- Touch start
								firetouchinterest(rootPart, item, 1) -- Touch end
							end)
						end
					end
				end
			end
		end)
	else
		AutoGrabButton.Text = "Auto Grab: OFF"
		AutoGrabButton.BackgroundColor3 = Color3.fromRGB(45, 140, 200)
		
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
end)
