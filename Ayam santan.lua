-- [[ SYAAA HUB - MAINTENANCE MODE ]] --

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local localPlayer = Players.LocalPlayer

-- UI Root
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SyaaaHub_Maintenance"
screenGui.ResetOnSpawn = false
screenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")

-- Sound Effect Notif
local function playNotifSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://4590662766" 
    sound.Volume = 0.5
    sound.Parent = SoundService
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
end

-- System Notifikasi Khusus
local activeNotifs = {}
local function updateNotifPositions()
    for i, frame in ipairs(activeNotifs) do
        local targetY = 15 + ((i - 1) * 58) 
        TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -140, 0, targetY)}):Play()
    end
end

local function showNotify(text, isWarning)
    playNotifSound()
    local notifyFrame = Instance.new("Frame")
    notifyFrame.Size = UDim2.new(0, 280, 0, 52) 
    notifyFrame.Position = UDim2.new(0.5, -140, 0, -60)
    notifyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    notifyFrame.Parent = screenGui
    
    Instance.new("UICorner", notifyFrame).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", notifyFrame)
    stroke.Color = isWarning and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(255, 200, 0)
    stroke.Thickness = 2

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = (isWarning and "⚠️ " or "⏳ ") .. text
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 11
    label.Parent = notifyFrame

    table.insert(activeNotifs, notifyFrame)
    updateNotifPositions()

    task.delay(6, function()
        local out = TweenService:Create(notifyFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1, Position = UDim2.new(0.5, -140, 0, -60)})
        out:Play()
        out.Completed:Connect(function() 
            for i, v in ipairs(activeNotifs) do if v == notifyFrame then table.remove(activeNotifs, i) break end end
            notifyFrame:Destroy()
            updateNotifPositions()
        end)
    end)
end

-- Loading Progress (Biar Keren dikit)
local function startLoading()
    local loadBG = Instance.new("CanvasGroup") 
    loadBG.Size = UDim2.new(0, 320, 0, 180); loadBG.Position = UDim2.new(0.5, -160, 0.5, -90)
    loadBG.BackgroundColor3 = Color3.fromRGB(10, 10, 15); loadBG.Parent = screenGui
    Instance.new("UICorner", loadBG).CornerRadius = UDim.new(0, 20)
    local strokeL = Instance.new("UIStroke", loadBG); strokeL.Color = Color3.fromRGB(0, 150, 255); strokeL.Thickness = 2

    local titleL = Instance.new("TextLabel")
    titleL.Text = "SYAA HUB"; titleL.Size = UDim2.new(1, 0, 0, 40); titleL.Position = UDim2.new(0, 0, 0, 25)
    titleL.TextColor3 = Color3.fromRGB(0, 150, 255); titleL.Font = Enum.Font.GothamBold; titleL.TextSize = 35; titleL.BackgroundTransparency = 1; titleL.Parent = loadBG

    local pLabel = Instance.new("TextLabel")
    pLabel.Text = "Checking Update..."; pLabel.Size = UDim2.new(1, 0, 0, 25); pLabel.Position = UDim2.new(0, 0, 0, 130); pLabel.TextColor3 = Color3.fromRGB(255, 255, 255); pLabel.Font = Enum.Font.Gotham; pLabel.TextSize = 12; pLabel.BackgroundTransparency = 1; pLabel.Parent = loadBG

    task.spawn(function()
        task.wait(2)
        TweenService:Create(loadBG, TweenInfo.new(0.5), {GroupTransparency = 1}):Play()
        task.wait(0.5)
        loadBG:Destroy()
        
        -- MUNCULIN NOTIF SESUAI REQUEST
        showNotify("maaf scrip sedang di update", true)
        task.wait(0.8)
        showNotify("mohon bersabar ya anak anak", false)
    end)
end

startLoading()
