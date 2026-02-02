-- AI Panel Script с красивым оформлением
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local AutoGrabButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local TitleLabel = Instance.new("TextLabel")

-- Переменная для отслеживания состояния Auto Grab
local autoGrabEnabled = false

-- Настройка ScreenGui
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Основной фрейм
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundTransparency = 0.1

-- Скругление углов
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12) -- Радиус скругления
UICorner.Parent = MainFrame

-- Заголовок панели
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = "AI Panel"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 20

-- Скругление для заголовка
local UICornerTitle = Instance.new("UICorner")
UICornerTitle.CornerRadius = UDim.new(0, 12)
UICornerTitle.Parent = TitleLabel

-- Кнопка Auto Grab
AutoGrabButton.Name = "AutoGrabButton"
AutoGrabButton.Parent = MainFrame
AutoGrabButton.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
AutoGrabButton.Position = UDim2.new(0.5, -100, 0.4, 0)
AutoGrabButton.Size = UDim2.new(0, 200, 0, 50)
AutoGrabButton.Font = Enum.Font.SourceSansBold
AutoGrabButton.Text = "Auto Grab: OFF"
AutoGrabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoGrabButton.TextSize = 18

-- Скругление для кнопки Auto Grab
local UICornerButton = Instance.new("UICorner")
UICornerButton.CornerRadius = UDim.new(0, 10)
UICornerButton.Parent = AutoGrabButton

-- Кнопка Закрыть
CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseButton.Position = UDim2.new(0.5, -50, 0.8, 0)
CloseButton.Size = UDim2.new(0, 100, 0, 30)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "Close"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18

-- Скругление для кнопки Закрыть
local UICornerClose = Instance.new("UICorner")
UICornerClose.CornerRadius = UDim.new(0, 10)
UICornerClose.Parent = CloseButton

-- Логика для Auto Grab
AutoGrabButton.MouseButton1Click:Connect(function()
    autoGrabEnabled = not autoGrabEnabled
    if autoGrabEnabled then
        AutoGrabButton.Text = "Auto Grab: ON"
        AutoGrabButton.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
        -- Включение Auto Grab (примерная логика)
        game:GetService("RunService").RenderStepped:Connect(function()
            if autoGrabEnabled then
                for _, item in pairs(workspace:GetChildren()) do
                    if item:IsA("BasePart") and (item.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude < 5 then
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, item, 0)
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, item, 1)
                    end
                end
            end
        end)
    else
        AutoGrabButton.Text = "Auto Grab: OFF"
        AutoGrabButton.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
    end
end)

-- Логика для кнопки Закрыть
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
