-- AI Panel Script with Extra Features
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local AutoGrabButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local TitleLabel = Instance.new("TextLabel")
local TimerLabel = Instance.new("TextLabel")
local autoGrabEnabled = false
local radius = 10  -- Радиус действия
local unlockTime = 30  -- Таймер до разлока базы, секунд
local timerActive = true

-- Настройка ScreenGui
ScreenGui.Name = "AI_Panel"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Основной фрейм панели
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)

-- Скруглённые углы для панели
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Заголовок панели
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = "AI Panel Functions"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 20

-- Таймер до разлока
TimerLabel.Name = "TimerLabel"
TimerLabel.Parent = MainFrame
TimerLabel.BackgroundTransparency = 1
TimerLabel.Position = UDim2.new(0.5, -100, 0.6, 0)
TimerLabel.Size = UDim2.new(0, 200, 0, 40)
TimerLabel.Font = Enum.Font.SourceSansBold
TimerLabel.Text = "Unlock Base in: " .. unlockTime .. "s"
TimerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TimerLabel.TextSize = 18

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

-- Скруглённые углы для кнопки Auto Grab
local UICornerButton = Instance.new("UICorner")
UICornerButton.CornerRadius = UDim.new(0, 8)
UICornerButton.Parent = AutoGrabButton

-- Кнопка Close
CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
CloseButton.Position = UDim2.new(0.5, -50, 0.8, 0)
CloseButton.Size = UDim2.new(0, 100, 0, 30)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "Close"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18

-- Скруглённые углы для кнопки Close
local UICornerClose = Instance.new("UICorner")
UICornerClose.CornerRadius = UDim.new(0, 8)
UICornerClose.Parent = CloseButton

-- Логика таймера до разлока базы
local function StartUnlockTimer()
    while timerActive and unlockTime > 0 do
        wait(1)
        unlockTime -= 1
        TimerLabel.Text = "Unlock Base in: " .. unlockTime .. "s"
    end
    if unlockTime <= 0 then
        timerActive = false
        TimerLabel.Text = "Base Unlocked!"
    end
end

coroutine.wrap(StartUnlockTimer)()

-- Логика для Auto Grab
local function AutoGrab()
    while autoGrabEnabled do
        wait(0.1)
        for _, item in pairs(workspace:GetChildren()) do
            if item:IsA("BasePart") and (item.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= radius then
                -- Зафиксируем цель (визуально)
                local highlight = Instance.new("Highlight")
                highlight.Adornee = item
                highlight.Parent = item

                -- Симуляция зажатия кнопки E
                local virtualInput = game:GetService("VirtualInputManager")
                virtualInput:SendKeyEvent(true, Enum.KeyCode.E, false, game)

                wait(0.1)

                virtualInput:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                highlight:Destroy()
            end
        end
    end
end

AutoGrabButton.MouseButton1Click:Connect(function()
    autoGrabEnabled = not autoGrabEnabled
    if autoGrabEnabled then
        AutoGrabButton.Text = "Auto Grab: ON"
        AutoGrabButton.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
        coroutine.wrap(AutoGrab)()
    else
        AutoGrabButton.Text = "Auto Grab: OFF"
        AutoGrabButton.BackgroundColor3 = Color3.fromRGB(50, 150, 200)
    end
end)

-- Закрытие панели
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
