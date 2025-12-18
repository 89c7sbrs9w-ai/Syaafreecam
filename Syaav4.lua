-- [[ SYAAA HUB V4 - RESTORED PREMIUM EDITION ]] --
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

-- Variabel Freecam (Logika Smooth Original)
local isFreecamActive = false
local moveSpeed = 10
local targetFov = 70
local zoomSpeed = 30
local currentMoveVelocity = Vector3.new(0, 0, 0)
local targetYaw, targetPitch, displayYaw, displayPitch = 0, 0, 0, 0
local moveInputs = { F = 0, B = 0, L = 0, R = 0, U = 0, D = 0 }
local zoomInputs = { In = 0, Out = 0 }
local mouseSensitivity = 0.15
local moveSmoothness, lookSmoothness = 10, 3

local PlayerModule = require(localPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()

-- ==========================================
-- 1. UI SETUP (ICON & FRAME POSITION)
-- ==========================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SyaaaHub_Restored"
screenGui.ResetOnSpawn = false
screenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")

-- Icon Bulat Panah (Posisi Pas 0.45)
local arrowIcon = Instance.new("TextButton")
arrowIcon.Size = UDim2.new(0, 40, 0, 40)
arrowIcon.Position = UDim2.new(0, 20, 0.45, -20) 
arrowIcon.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
arrowIcon.Text = ">"
arrowIcon.TextColor3 = Color3.new(1, 1, 1)
arrowIcon.Font = Enum.Font.GothamBold
arrowIcon.TextSize = 20
arrowIcon.Parent = screenGui
Instance.new("UICorner", arrowIcon).CornerRadius = UDim.new(0.5, 0)
local iconStroke = Instance.new("UIStroke", arrowIcon)
iconStroke.Color = Color3.fromRGB(0, 150, 255)
iconStroke.Thickness = 1.5

-- Main Frame (Compact tapi Lengkap)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 280)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -140)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
mainFrame.ClipsDescendants = true
mainFrame.Visible = false
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = Color3.fromRGB(0, 80, 200)

-- Title
local titleBar = Instance.new("TextLabel")
titleBar.Text = "SYAAA HUB V4"
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
titleBar.TextColor3 = Color3.fromRGB(0, 150, 255)
titleBar.Font = Enum.Font.GothamBold
titleBar.TextSize = 14
titleBar.Parent = mainFrame

-- Container
local container = Instance.new("Frame")
container.Size = UDim2.new(1, -20, 1, -50); container.Position = UDim2.new(0, 10, 0, 45); container.BackgroundTransparency = 1; container.Parent = mainFrame
local layout = Instance.new("UIListLayout", container)
layout.FillDirection = Enum.FillDirection.Horizontal; layout.Padding = UDim.new(0, 10); layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function makePanel(name)
    local p = Instance.new("Frame")
    p.Size = UDim2.new(0.31, 0, 1, 0); p.BackgroundColor3 = Color3.fromRGB(18, 18, 30); p.Parent = container
    Instance.new("UICorner", p).CornerRadius = UDim.new(0, 10)
    local l = Instance.new("TextLabel")
    l.Text = name; l.Size = UDim2.new(1, 0, 0, 25); l.BackgroundTransparency = 1; l.TextColor3 = Color3.fromRGB(0, 180, 255); l.Font = Enum.Font.GothamBold; l.TextSize = 10; l.Parent = p
    return p
end

local pFreecam = makePanel("Freecam")
local pMusic = makePanel("Music Player")
local pRotasi = makePanel("Orientation")

-- ==========================================
-- 2. ANIMASI (POP UP -> SLIDE TO ICON)
-- ==========================================
local isOpen = false
arrowIcon.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    if isOpen then
        arrowIcon.Text = "<"
        mainFrame.Visible = true
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        mainFrame:TweenSizeAndPosition(UDim2.new(0, 450, 0, 280), UDim2.new(0.5, -225, 0.5, -140), "Out", "Back", 0.5, true)
    else
        arrowIcon.Text = ">"
        mainFrame:TweenSizeAndPosition(UDim2.new(0, 0, 0, 0), arrowIcon.Position, "In", "Quad", 0.4, true, function()
            mainFrame.Visible = false
        end)
    end
end)

-- ==========================================
-- 3. FITUR MUSIC & ROTASI (RESTORED)
-- ==========================================
-- Music Player
local currentSound = nil
local musicInp = Instance.new("TextBox")
musicInp.PlaceholderText = "ID Music"; musicInp.Size = UDim2.new(0.85, 0, 0, 30); musicInp.Position = UDim2.new(0.075, 0, 0, 40)
musicInp.BackgroundColor3 = Color3.fromRGB(25, 25, 45); musicInp.TextColor3 = Color3.new(1,1,1); musicInp.Parent = pMusic; Instance.new("UICorner", musicInp)

local playBtn = Instance.new("TextButton")
playBtn.Text = "PLAY/STOP"; playBtn.Size = UDim2.new(0.85, 0, 0, 30); playBtn.Position = UDim2.new(0.075, 0, 0, 75)
playBtn.BackgroundColor3 = Color3.fromRGB(0, 90, 180); playBtn.TextColor3 = Color3.new(1,1,1); playBtn.Parent = pMusic; Instance.new("UICorner", playBtn)

playBtn.MouseButton1Click:Connect(function()
    if currentSound and currentSound.IsPlaying then currentSound:Stop(); currentSound:Destroy(); currentSound = nil
    else
        local id = musicInp.Text:gsub("%D", "")
        if id ~= "" then currentSound = Instance.new("Sound", workspace); currentSound.SoundId = "rbxassetid://"..id; currentSound:Play() end
    end
end)

-- Orientation
local function createRotBtn(text, yPos, orient)
    local b = Instance.new("TextButton")
    b.Text = text; b.Size = UDim2.new(0.85, 0, 0, 30); b.Position = UDim2.new(0.075, 0, 0, yPos)
    b.BackgroundColor3 = Color3.fromRGB(35, 35, 45); b.TextColor3 = Color3.new(1,1,1); b.Parent = pRotasi
    Instance.new("UICorner", b); b.MouseButton1Click:Connect(function() playerGui.ScreenOrientation = orient end)
end
createRotBtn("PORTRAIT", 40, Enum.ScreenOrientation.Portrait)
createRotBtn("LANDSCAPE L", 75, Enum.ScreenOrientation.LandscapeLeft)
createRotBtn("LANDSCAPE R", 110, Enum.ScreenOrientation.LandscapeRight)

-- ==========================================
-- 4. FREECAM ORIGINAL (SMOOTH & COMPLETE)
-- ==========================================
local speedLabel = Instance.new("TextLabel")
speedLabel.Text = "Spd: 10"; speedLabel.Size = UDim2.new(1, 0, 0, 20); speedLabel.Position = UDim2.new(0, 0, 0, 65); speedLabel.BackgroundTransparency = 1; speedLabel.TextColor3 = Color3.new(1,1,1); speedLabel.TextSize = 10; speedLabel.Parent = pFreecam

local function createSpeedBtn(txt, xPos, delta)
    local b = Instance.new("TextButton")
    b.Text = txt; b.Size = UDim2.new(0, 30, 0, 25); b.Position = UDim2.new(xPos, -15, 0, 85); b.BackgroundColor3 = Color3.fromRGB(40,40,50); b.TextColor3 = Color3.new(1,1,1); b.Parent = pFreecam; Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() moveSpeed = math.clamp(moveSpeed + delta, 1, 300); speedLabel.Text = "Spd: "..moveSpeed end)
end
createSpeedBtn("-", 0.3, -5); createSpeedBtn("+", 0.7, 5)

local fcToggle = Instance.new("TextButton")
fcToggle.Text = "CAM: OFF"; fcToggle.Size = UDim2.new(0.85, 0, 0, 30); fcToggle.Position = UDim2.new(0.075, 0, 0, 35); fcToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 50); fcToggle.TextColor3 = Color3.new(1,1,1); fcToggle.Parent = pFreecam; Instance.new("UICorner", fcToggle)

local fcHUD = Instance.new("Frame")
fcHUD.Size = UDim2.new(1, 0, 1, 0); fcHUD.BackgroundTransparency = 1; fcHUD.Visible = false; fcHUD.Parent = screenGui

local function createFCBtn(text, pos, key, isZoom)
    local b = Instance.new("TextButton"); b.Text = text; b.Size = UDim2.new(0, 45, 0, 45); b.Position = pos; b.BackgroundColor3 = Color3.fromRGB(15, 15, 30); b.TextColor3 = Color3.fromRGB(0, 150, 255); b.Parent = fcHUD; Instance.new("UICorner", b)
    b.InputBegan:Connect(function() if isZoom then zoomInputs[key] = 1 else moveInputs[key] = 1 end end)
    b.InputEnded:Connect(function() if isZoom then zoomInputs[key] = 0 else moveInputs[key] = 0 end end)
end

createFCBtn("W", UDim2.new(0, 75, 1, -120), "F"); createFCBtn("S", UDim2.new(0, 75, 1, -65), "B")
createFCBtn("A", UDim2.new(0, 20, 1, -65), "L"); createFCBtn("D", UDim2.new(0, 130, 1, -65), "R")
createFCBtn("UP", UDim2.new(1, -115, 1, -120), "U"); createFCBtn("DN", UDim2.new(1, -115, 1, -65), "D")
createFCBtn("+", UDim2.new(1, -60, 1, -120), "In", true); createFCBtn("-", UDim2.new(1, -60, 1, -65), "Out", true)

fcToggle.MouseButton1Click:Connect(function()
    isFreecamActive = not isFreecamActive
    fcToggle.Text = isFreecamActive and "CAM: ON" or "CAM: OFF"
    fcToggle.BackgroundColor3 = isFreecamActive and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(40, 40, 50)
    fcHUD.Visible = isFreecamActive
    if isFreecamActive then
        PlayerModule:Disable(); Camera.CameraType = Enum.CameraType.Scriptable
        RunService:BindToRenderStep("FCLoop", 201, function(dt)
            local mAlpha, lAlpha = 1 - math.exp(-moveSmoothness * dt), 1 - math.exp(-lookSmoothness * dt)
            displayYaw, displayPitch = displayYaw + (targetYaw - displayYaw) * lAlpha, displayPitch + (targetPitch - displayPitch) * lAlpha
            local rot = CFrame.Angles(0, math.rad(displayYaw), 0) * CFrame.Angles(math.rad(displayPitch), 0, 0)
            local moveVec = Vector3.new(moveInputs.R - moveInputs.L, moveInputs.U - moveInputs.D, moveInputs.B - moveInputs.F)
            if moveVec.Magnitude > 0 then moveVec = moveVec.Unit end
            currentMoveVelocity = currentMoveVelocity:Lerp(moveVec * moveSpeed, mAlpha)
            Camera.CFrame = rot + (Camera.CFrame.Position + rot:VectorToWorldSpace(currentMoveVelocity * dt))
            targetFov = targetFov + (zoomInputs.Out - zoomInputs.In) * zoomSpeed * dt
            Camera.FieldOfView = Camera.FieldOfView + (targetFov - Camera.FieldOfView) * mAlpha
        end)
    else
        PlayerModule:Enable(); Camera.CameraType = Enum.CameraType.Custom; RunService:UnbindFromRenderStep("FCLoop")
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isFreecamActive and input.UserInputType == Enum.UserInputType.Touch then
        targetYaw = targetYaw - (input.Delta.X * mouseSensitivity)
        targetPitch = math.clamp(targetPitch - (input.Delta.Y * mouseSensitivity), -89, 89)
    end
end)
