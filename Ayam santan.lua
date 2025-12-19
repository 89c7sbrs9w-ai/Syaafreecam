-- [[ SYAAA HUB - QUICK NOTIFICATION ONLY ]] --

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

-- UI Root
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SyaaaHub_Notif"
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

-- System Notifikasi
local activeNotifs = {}
local function updateNotifPositions()
    for i, frame in ipairs(activeNotifs) do
        local targetY = 20 + ((i - 1) * 60) 
        TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -140, 0, targetY)}):Play()
    end
end

local function showNotify(text, color)
    playNotifSound()
    local notifyFrame = Instance.new("Frame")
    notifyFrame.Size = UDim2.new(0, 280, 0, 52) 
    notifyFrame.Position = UDim2.new(0.5, -140, 0, -60) -- Mulai dari atas layar
    notifyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    notifyFrame.Parent = screenGui
    
    local corner = Instance.new("UICorner", notifyFrame)
    corner.CornerRadius = UDim.new(0, 10)
    
    local stroke = Instance.new("UIStroke", notifyFrame)
    stroke.Color = color
    stroke.Thickness = 2

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    label.Parent = notifyFrame

    table.insert(activeNotifs, notifyFrame)
    updateNotifPositions()

    -- Durasi tampil 5 detik sebelum hilang
    task.delay(5, function()
        local out = TweenService:Create(notifyFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1, Position = UDim2.new(0.5, -140, 0, -60)})
        TweenService:Create(stroke, TweenInfo.new(0.5), {Transparency = 1}):Play()
        TweenService:Create(label, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
        out:Play()
        out.Completed:Connect(function() 
            for i, v in ipairs(activeNotifs) do if v == notifyFrame then table.remove(activeNotifs, i) break end end
            notifyFrame:Destroy()
            updateNotifPositions()
        end)
    end)
end

-- Langsung Munculin Notif pas di Execute
task.spawn(function()
    showNotify("maaf scrip sedang di update", Color3.fromRGB(255, 50, 50)) -- Merah
    task.wait(1)
    showNotify("mohon bersabar ya anak anak", Color3.fromRGB(0, 150, 255)) -- Biru
end)
