-- [[ SYAA MAINTENANCE GUI ONLY ]] --

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local localPlayer = Players.LocalPlayer

-- Container Utama
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SyaaMaintenanceGUI"
screenGui.ResetOnSpawn = false
local coreGui
pcall(function() coreGui = gethui and gethui() end)
screenGui.Parent = coreGui or game:GetService("CoreGui")

-- Setup UI
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 190)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -95)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 10, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 15)

local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color = Color3.fromRGB(255, 60, 60) -- Warna merah maintenance
stroke.Thickness = 2.5
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Tombol Close (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 25
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = mainFrame

closeBtn.MouseButton1Click:Connect(function()
    local twClose = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    })
    twClose:Play()
    twClose.Completed:Wait()
    screenGui:Destroy()
end)

-- Avatar Profile Lu
local avatarImg = Instance.new("ImageLabel")
avatarImg.Size = UDim2.new(0, 75, 0, 75)
avatarImg.Position = UDim2.new(0.5, -37.5, 0, 20)
avatarImg.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
avatarImg.Image = "rbxthumb://type=AvatarHeadShot&id="..localPlayer.UserId.."&w=150&h=150"
avatarImg.Parent = mainFrame
Instance.new("UICorner", avatarImg).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", avatarImg).Color = Color3.fromRGB(255, 255, 255)

-- Nama Display
local nameLabel = Instance.new("TextLabel")
nameLabel.Text = localPlayer.DisplayName
nameLabel.Size = UDim2.new(1, 0, 0, 25)
nameLabel.Position = UDim2.new(0, 0, 0, 105)
nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
nameLabel.Font = Enum.Font.GothamBold
nameLabel.TextSize = 16
nameLabel.BackgroundTransparency = 1
nameLabel.Parent = mainFrame

-- Text Pemberitahuan
local msgLabel = Instance.new("TextLabel")
msgLabel.Text = "ups script sedang maintanance,\ntunggu beberapa saat"
msgLabel.Size = UDim2.new(1, 0, 0, 40)
msgLabel.Position = UDim2.new(0, 0, 0, 130)
msgLabel.TextColor3 = Color3.fromRGB(255, 100, 100) -- Soft Red
msgLabel.Font = Enum.Font.GothamMedium
msgLabel.TextSize = 13
msgLabel.BackgroundTransparency = 1
msgLabel.Parent = mainFrame

-- Animasi Muncul Pas Execute
mainFrame.Size = UDim2.new(0, 0, 0, 0)
mainFrame.ClipsDescendants = true
TweenService:Create(mainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 320, 0, 190)
}):Play()
