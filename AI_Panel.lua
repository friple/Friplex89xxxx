-- [[ Скрипт от Vulcan, автор: friple ]]
-- [[ Сайт: https://friple-your-site.com ]]

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local radius = 10 -- Радиус действий
local autoGrabSpeed = 0.1 -- Скорость автоматического захвата объектов
local brainrotTag = "Украсть" -- Текст действия для взаимодействия

-- Функция для симуляции нажатия клавиши E
local function simulateKeyPress()
    local virtualInput = game:GetService("VirtualInputManager")
    virtualInput:SendKeyEvent(true, Enum.KeyCode.E, false, game) -- Нажатие клавиши
    wait(0.05)
    virtualInput:SendKeyEvent(false, Enum.KeyCode.E, false, game) -- Отпускание клавиши
end

-- WH: подсвечивание объектов
local function highlightObject(object)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = object
    highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Красный цвет подсветки
    highlight.OutlineColor = Color3.fromRGB(0, 0, 0) -- Чёрный контур
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = object
    return highlight
end

-- Основная функция автоматического захвата объектов
local function autoGrab()
    while true do
        wait(autoGrabSpeed)
        for _, object in pairs(workspace:GetChildren()) do
            if object:IsA("Model") and object:FindFirstChildWhichIsA("ProximityPrompt") then
                local proximityPrompt = object:FindFirstChildWhichIsA("ProximityPrompt")
                if proximityPrompt.ActionText == brainrotTag and (object.PrimaryPart.Position - humanoidRootPart.Position).Magnitude <= radius then
                    -- Подсвечиваем объект (WH)
                    local highlight = highlightObject(object)

                    -- Автоматическое взаимодействие
                    simulateKeyPress()

                    wait(0.5) -- Небольшая задержка между взаимодействиями
                    highlight:Destroy() -- Убираем подсветку после взаимодействия
                end
            end
        end
    end
end

-- Запуск автоматического захвата
coroutine.wrap(autoGrab)()
