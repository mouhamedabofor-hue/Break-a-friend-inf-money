-- LocalScript (Works perfectly – November 2025)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "RagdollSpam"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 130)
frame.Position = UDim2.new(0.5, -110, 0.5, -65)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 8)
title.BackgroundTransparency = 1
title.Text = "Owner BY Abdullah - Pro"
title.TextColor3 = Color3.fromRGB(255, 255, 0)
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -20, 1, -60)
button.Position = UDim2.new(0, 10, 0, 45)
button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
button.Text = "OFF"
button.TextColor3 = Color3.new(1, 1, 1)
button.TextScaled = true
button.Font = Enum.Font.GothamBold
button.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = button

-- Remote
local remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("FinishedRagdoll")

-- State
local isRunning = false
local loopThread = nil

local function updateButton()
    if isRunning then
        button.Text = "ON"
        button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    else
        button.Text = "OFF"
        button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    end
end

local function startLoop()
    isRunning = true
    updateButton()

    loopThread = task.spawn(function()
        while isRunning do
            pcall(function()
                remote:FireServer(9999999999999999999999999999999999999999999999999999)
            end)
            task.wait(0.03) -- ~33 fires/sec, very fast and safe
        end
    end)
end

local function stopLoop()
    isRunning = false
    if loopThread then
        task.cancel(loopThread)
        loopThread = nil
    end
    updateButton()
end

-- Toggle when clicked
button.MouseButton1Click:Connect(function()
    if isRunning then
        stopLoop()
    else
        startLoop()
    end
end)

-- Start as OFF
updateButton()
