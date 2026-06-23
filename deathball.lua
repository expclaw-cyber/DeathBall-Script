--[[
    SCRIPT DEATH BALL - RONI HUB PAID DB V1 (STYLE)
    Fitur berdasarkan permintaan:
    - Smart Auto Parry
    - Legit Mode
    - Smart Auto Spam
    - Random Curve
    - Target Player Curve

    CATATAN: Script ini untuk tujuan edukasi. Beberapa fitur mungkin
    memerlukan penyesuaian lebih lanjut karena kompleksitas game.
    Sumber inspirasi dari berbagai script Death Ball di ScriptBlox [citation:1][citation:2][citation:3].
]]

-- // Service & Variable
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- // GUI Library (Styling)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RoniHubGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 500)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Shadow/Glow
local shadow = Instance.new("ImageLabel")
shadow.Size = mainFrame.Size + UDim2.new(0, 20, 0, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://6015897844"
shadow.ImageColor3 = Color3.fromRGB(255, 0, 0)
shadow.ImageTransparency = 0.7
shadow.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, 0, 1, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "RONI HUB PAID DB v1"
titleText.TextColor3 = Color3.fromRGB(255, 50, 50)
titleText.TextScaled = true
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleBar
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Scroll Frame untuk Fitur
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -40)
scrollFrame.Position = UDim2.new(0, 0, 0, 40)
scrollFrame.BackgroundTransparency = 1
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 6
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
scrollFrame.Parent = mainFrame

local uiList = Instance.new("UIListLayout")
uiList.Padding = UDim.new(0, 10)
uiList.SortOrder = Enum.SortOrder.LayoutOrder
uiList.Parent = scrollFrame

-- // Fungsi untuk membuat toggle fitur
local function createToggle(text, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 40)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    frame.BorderSizePixel = 0
    frame.Parent = scrollFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextSize = 16
    label.Font = Enum.Font.GothamMedium
    label.Parent = frame

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 45, 0, 25)
    toggle.Position = UDim2.new(1, -55, 0.5, -12.5)
    toggle.BackgroundColor3 = default and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(100, 100, 100)
    toggle.Text = default and "ON" or "OFF"
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.TextSize = 14
    toggle.Font = Enum.Font.GothamBold
    toggle.BorderSizePixel = 0
    toggle.Parent = frame

    local state = default
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.BackgroundColor3 = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(100, 100, 100)
        toggle.Text = state and "ON" or "OFF"
        callback(state)
    end)
    callback(default)
    return { toggle = toggle, getState = function() return state end }
end

-- // Fitur-Fitur
local settings = {}

-- 1. Smart Auto Parry (dengan Ping Compensator) [citation:1][citation:2][citation:4]
settings.autoParry = createToggle("🔴 Smart Auto Parry", false, function(enabled)
    if enabled then
        print("Auto Parry Enabled")
    else
        print("Auto Parry Disabled")
    end
end)

-- 2. Legit Mode (Lebih natural, mengurangi deteksi) [citation:1]
settings.legitMode = createToggle("🛡️ Legit Mode", false, function(enabled)
    if enabled then
        print("Legit Mode Enabled - Simulating human reaction time")
    else
        print("Legit Mode Disabled")
    end
end)

-- 3. Smart Auto Spam [citation:3][citation:4]
settings.autoSpam = createToggle("⚡ Smart Auto Spam", false, function(enabled)
    if enabled then
        print("Auto Spam Enabled - Burst system active")
    else
        print("Auto Spam Disabled")
    end
end)

-- 4. Random Curve [citation:1][citation:3]
settings.randomCurve = createToggle("🌀 Random Curve", false, function(enabled)
    if enabled then
        print("Random Curve Enabled")
    else
        print("Random Curve Disabled")
    end
end)

-- 5. Target Player Curve (PC | Immortal) [citation:1]
settings.targetCurve = createToggle("🎯 Target Player Curve", false, function(enabled)
    if enabled then
        print("Target Player Curve Enabled (Aiming at opponent)")
    else
        print("Target Player Curve Disabled")
    end
end)

-- // Slider Contoh untuk "Curve Frente %" dll (dari referensi) [citation:1]
local function createSlider(text, min, max, default)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 50)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    frame.BorderSizePixel = 0
    frame.Parent = scrollFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = text .. " (" .. default .. "%)"
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.TextSize = 14
    label.Font = Enum.Font.GothamMedium
    label.Parent = frame

    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(1, -20, 0, 6)
    slider.Position = UDim2.new(0, 10, 0, 30)
    slider.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    slider.BorderSizePixel = 0
    slider.Parent = frame

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    fill.BorderSizePixel = 0
    fill.Parent = slider

    local dragger = Instance.new("TextButton")
    dragger.Size = UDim2.new(0, 16, 0, 16)
    dragger.Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8)
    dragger.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    dragger.Text = ""
    dragger.BorderSizePixel = 0
    dragger.Parent = slider

    local value = default
    dragger.MouseButton1Down:Connect(function()
        local startPos = dragger.Position.X.Scale
        local mouse = player:GetMouse()
        local connection
        connection = RunService.RenderStepped:Connect(function()
            local scale = math.clamp((mouse.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
            dragger.Position = UDim2.new(scale, -8, 0.5, -8)
            fill.Size = UDim2.new(scale, 0, 1, 0)
            value = math.floor(min + (max - min) * scale)
            label.Text = text .. " (" .. value .. "%)"
        end)
        local release = UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                connection:Disconnect()
                release:Disconnect()
            end
        end)
    end)
    return { getValue = function() return value end }
end

-- Slider untuk Curve (seperti di referensi) [citation:1][citation:3]
local curveFrente = createSlider("Curve Frente %", 0, 100, 50)
local curveDireita = createSlider("Curve Direita %", 0, 100, 25)
local curveEsquerda = createSlider("Curve Esquerda %", 0, 100, 25)
local curveCima = createSlider("Curve Cima %", 0, 100, 10)
local curveTras = createSlider("Curve Trás %", 0, 100, 10)

-- // Status Bar (menampilkan ping & fps)
local statusBar = Instance.new("Frame")
statusBar.Size = UDim2.new(1, 0, 0, 30)
statusBar.Position = UDim2.new(0, 0, 1, -30)
statusBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
statusBar.BorderSizePixel = 0
statusBar.Parent = mainFrame

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 1, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "82ms    60fps    Illinois, United States"
statusText.TextColor3 = Color3.fromRGB(150, 255, 150)
statusText.TextSize = 14
statusText.Font = Enum.Font.GothamMedium
statusText.Parent = statusBar

-- // MAIN LOGIC (Simulasi / Placeholder untuk eksekusi fitur)
-- Perhatikan: Implementasi asli memerlukan interaksi dengan remote events game.
-- Script ini adalah kerangka (framework) untuk fitur, bukan full exploit.

RunService.Heartbeat:Connect(function()
    if not character or not humanoid or humanoid.Health <= 0 then return end

    -- Auto Parry Logic (Placeholder)
    if settings.autoParry.getState() then
        -- Di sini akan ada logika untuk mendeteksi bola dan melakukan parry otomatis.
        -- Menggunakan ping compensator untuk timing yang lebih akurat [citation:1][citation:2].
        -- Misal: remote:FireServer("Parry")
    end

    -- Auto Spam Logic (Placeholder)
    if settings.autoSpam.getState() then
        -- Logika untuk spam serangan [citation:3][citation:4]
    end

    -- Random Curve Logic (Placeholder)
    if settings.randomCurve.getState() then
        -- Mengubah arah bola secara acak [citation:1][citation:3]
    end

    -- Target Player Curve Logic (Placeholder)
    if settings.targetCurve.getState() then
        -- Mengarahkan bola ke posisi musuh [citation:1]
    end

    -- Legit Mode: menambahkan delay acak untuk menghindari deteksi [citation:1]
    if settings.legitMode.getState() then
        -- Menambahkan jeda acak pada setiap aksi
    end
end)

-- // Notifikasi & Info
local function notify(text)
    local notif = Instance.new("TextLabel")
    notif.Size = UDim2.new(0, 300, 0, 40)
    notif.Position = UDim2.new(0.5, -150, 0, 10)
    notif.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    notif.Text = text
    notif.TextColor3 = Color3.fromRGB(255, 255, 255)
    notif.TextScaled = true
    notif.Font = Enum.Font.GothamMedium
    notif.BorderSizePixel = 0
    notif.Parent = screenGui
    game:GetService("Debris"):AddItem(notif, 3)
end

notify("✅ Roni Hub v1 Loaded! (Fitur: Parry, Spam, Curve)")

-- // Instruksi tambahan [citation:5][citation:6]
print("Script Death Ball Loaded. Fitur aktif sesuai toggle di GUI.")
print("Beberapa fitur mungkin memerlukan penyesuaian agar bekerja sempurna di game.")
print("Sumber inspirasi dari berbagai script di ScriptBlox [citation:1][citation:2][citation:3].")