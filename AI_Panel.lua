-- Создание AI панели
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local AutoGrabButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")

-- Переменная состояния Auto Grab
local autoGrabEnabled = false

-- Стилизация панели
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "AIPanelUI"

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundTransparency = 0.1

-- Кнопка включения/выключения Auto Grab
AutoGrabButton.Parent = Frame
AutoGrabButton.BackgroundColor3 = Color3.fromRGB(45, 140, 200)
AutoGrabButton.Size = UDim2.new(0, 250, 0, 50)
AutoGrabButton.Position = UDim2.new(0.5, 0, 0.3, 0)
AutoGrabButton.AnchorPoint = Vector2.new(0.5, 0.5)
AutoGrabButton.Font = Enum.Font.SourceSansBold
AutoGrabButton.Text = "Auto Grab: Выключено"
AutoGrabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoGrabButton.TextSize = 18

-- Метка статуса
StatusLabel.Parent = Frame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 0.1, 0)
StatusLabel.Font = Enum.Font.SourceSansBold
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Text = "Функции панели"
StatusLabel.TextSize = 22

-- Кнопка закрытия панели
CloseButton.Parent = Frame
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Size = UDim2.new(0, 100, 0, 30)
CloseButton.Position = UDim2.new(0.5, 0, 0.8, 0)
CloseButton.AnchorPoint = Vector2.new(0.5, 0.5)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "Закрыть"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18

-- Логика для Auto Grab
AutoGrabButton.MouseButton1Click:Connect(function()
    autoGrabEnabled = not autoGrabEnabled
    if autoGrabEnabled then
        AutoGrabButton.Text = "Auto Grab: Включено"
        AutoGrabButton.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
        -- Логика Auto Grab (брейнрота)
        game:GetService("RunService").RenderStepped:Connect(function()
            if autoGrabEnabled then
                for _, item in pairs(workspace:GetChildren()) do
                    if item:IsA("Part") and (item.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude < 5 then
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, item, 0) -- Подход
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, item, 1) -- Отход
                    end
                end
            end
        end)
    else
        AutoGrabButton.Text = "Auto Grab: Выключено"
        AutoGrabButton.BackgroundColor3 = Color3.fromRGB(45, 140, 200)
    end
end)

-- Закрытие панели
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
