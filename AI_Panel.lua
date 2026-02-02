-- AI Panel Script
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local CloseButton = Instance.new("TextButton")
local AutoGrabButton = Instance.new("TextButton")
local AdminSpamButton = Instance.new("TextButton")

-- Настройка GUI
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "AIPanelUI"

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Position = UDim2.new(0.5, -150, 0.5, -150)
Frame.Size = UDim2.new(0, 300, 0, 300)

-- Кнопка закрытия
CloseButton.Parent = Frame
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Size = UDim2.new(0, 60, 0, 30)
CloseButton.Position = UDim2.new(1, -70, 0, 10)
CloseButton.Text = "Закрыть"
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Кнопки "Auto Grab" и "Admin Spam"
AutoGrabButton.Parent = Frame
AutoGrabButton.Text = "Auto Grab"
AutoGrabButton.Size = UDim2.new(0, 200, 0, 50)
AutoGrabButton.Position = UDim2.new(0.5, 0, 0.4, 0)

AdminSpamButton.Parent = Frame
AdminSpamButton.Text = "Admin Spam"
AdminSpamButton.Size = UDim2.new(0, 200, 0, 50)
AdminSpamButton.Position = UDim2.new(0.5, 0, 0.7, 0)
