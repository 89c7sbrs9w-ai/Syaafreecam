-- [[ SYAAA HUB - SPEED, JUMP & TP (COMPACT + SMOOTH MINIMIZE) ]] --

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local localPlayer = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SyaaaHub_Compact_TP"
screenGui.ResetOnSpawn = false
screenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")

-- ==========================================
-- MAIN FRAME (KECILIN JADI 380x260)
-- ==========================================
local mainFrame = Instance.new("CanvasGroup")
mainFrame.Size = UDim2.new(0, 380, 0, 260)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -130)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 15)

-- Efek Rainbow Stroke
local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Thickness = 3
local rainbowColor = Color3.fromRGB(0, 150, 255)
task.spawn(function()
    while true do
        local hue = tick() % 5 / 5
        rainbowColor = Color3.fromHSV(hue, 0.8, 1)
        mainStroke.Color = rainbowColor
        task.wait()
    end
end)

-- LOGIC DRAG MAIN FRAME
local dragging, dragInput, dragStart, startPos
mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
RunService.Heartbeat:Connect(function()
    if dragging and dragInput then
        local delta = dragInput.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
        dragInput = nil
    end
end)

local title = Instance.new("TextLabel")
title.Text = "SYAA MOVEMENT & TP 🗿"
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 15, 0, 5)
title.TextColor3 = Color3.fromRGB(0, 180, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1
title.Parent = mainFrame

-- TOMBOL CLOSE
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -34, 0, 12)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.BackgroundColor3 = Color3.fromRGB(25, 20, 30)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 12
closeBtn.Parent = mainFrame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- TOMBOL MINIMIZE
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 26, 0, 26)
minBtn.Position = UDim2.new(1, -66, 0, 12)
minBtn.Text = "−"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.BackgroundColor3 = Color3.fromRGB(25, 20, 30)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 16
minBtn.Parent = mainFrame
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

-- ==========================================
-- FLOATING ICON (PADA SAAT MINIMIZE)
-- ==========================================
local openIcon = Instance.new("ImageButton")
openIcon.Size = UDim2.new(0, 50, 0, 50)
openIcon.Position = UDim2.new(0, 30, 0.5, -25)
openIcon.BackgroundTransparency = 1
openIcon.Image = "rbxassetid://87411882585742" -- Icon Syaa Hub sebelumnya
openIcon.ImageColor3 = Color3.fromRGB(0, 150, 255)
openIcon.Visible = false
openIcon.Parent = screenGui

-- Efek Rainbow di Icon
task.spawn(function()
    while true do
        openIcon.ImageColor3 = rainbowColor
        task.wait()
    end
end)

-- Animasi Minimize & Maximize
local isMinimized = false
local function toggleMinimize()
    isMinimized = not isMinimized
    if isMinimized then
        local tweenOut = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), GroupTransparency = 1, Position = UDim2.new(mainFrame.Position.X.Scale, mainFrame.Position.X.Offset, mainFrame.Position.Y.Scale, mainFrame.Position.Y.Offset + 100)})
        tweenOut:Play()
        tweenOut.Completed:Wait()
        mainFrame.Visible = false
        
        openIcon.Visible = true
        openIcon.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(openIcon, TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {Size = UDim2.new(0, 55, 0, 55)}):Play()
    else
        local tweenOutIcon = TweenService:Create(openIcon, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
        tweenOutIcon:Play()
        tweenOutIcon.Completed:Wait()
        openIcon.Visible = false
        
        mainFrame.Visible = true
        TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 380, 0, 260), GroupTransparency = 0, Position = UDim2.new(mainFrame.Position.X.Scale, mainFrame.Position.X.Offset, mainFrame.Position.Y.Scale, mainFrame.Position.Y.Offset - 100)}):Play()
    end
end

minBtn.MouseButton1Click:Connect(toggleMinimize)
openIcon.MouseButton1Click:Connect(toggleMinimize)

-- Drag Logic buat Icon
local dragIcon, dragInputIcon, dragStartIcon, startPosIcon
openIcon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragIcon = true; dragStartIcon = input.Position; startPosIcon = openIcon.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInputIcon = input
    end
end)
RunService.Heartbeat:Connect(function()
    if dragIcon and dragInputIcon then
        local delta = dragInputIcon.Position - dragStartIcon
        openIcon.Position = UDim2.new(startPosIcon.X.Scale, startPosIcon.X.Offset + delta.X, startPosIcon.Y.Scale, startPosIcon.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragIcon = false; dragInputIcon = nil end
end)


-- ==========================================
-- TAB BAR & PANELS
-- ==========================================
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, -20, 0, 28)
tabBar.Position = UDim2.new(0, 10, 0, 44)
tabBar.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
tabBar.Parent = mainFrame
Instance.new("UICorner", tabBar).CornerRadius = UDim.new(0, 8)

local tl = Instance.new("UIListLayout", tabBar)
tl.FillDirection = Enum.FillDirection.Horizontal
tl.HorizontalAlignment = Enum.HorizontalAlignment.Left
tl.VerticalAlignment = Enum.VerticalAlignment.Center
tl.Padding = UDim.new(0, 4)
local tp2 = Instance.new("UIPadding", tabBar)
tp2.PaddingLeft = UDim.new(0, 4)
tp2.PaddingRight = UDim.new(0, 4)

local tabNames = {"Movement", "Teleport"}
local tabBtns = {}
local tabPanels = {}
local activeTab = nil

local function setTab(name)
    activeTab = name
    for _, n in ipairs(tabNames) do
        local btn = tabBtns[n]
        local panel = tabPanels[n]
        if n == name then
            TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 120, 255), TextColor3 = Color3.new(1, 1, 1)}):Play()
            panel.Visible = true
        else
            TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(28, 28, 38), TextColor3 = Color3.fromRGB(140, 140, 180)}):Play()
            panel.Visible = false
        end
    end
end

for _, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Text = name
    btn.Size = UDim2.new(0.5, -2, 1, -6) -- Responsive width
    btn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    btn.TextColor3 = Color3.fromRGB(140, 140, 180)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.AutoButtonColor = false
    btn.Parent = tabBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    tabBtns[name] = btn
    
    local panel = Instance.new("Frame")
    panel.Name = "Panel_" .. name
    panel.Size = UDim2.new(1, -20, 1, -85)
    panel.Position = UDim2.new(0, 10, 0, 78)
    panel.BackgroundTransparency = 1
    panel.Visible = false
    panel.Parent = mainFrame
    tabPanels[name] = panel
    
    btn.MouseButton1Click:Connect(function() setTab(name) end)
end

-- ==========================================
-- LOGIC & UI: MOVEMENT (SPEED & JUMP)
-- ==========================================
local pMove = tabPanels["Movement"]

-- UNLIMITED JUMP
local infJumpEnabled = false
local jumpBtn = Instance.new("TextButton")
jumpBtn.Text = "Unlimited Jump: OFF"
jumpBtn.Size = UDim2.new(1, 0, 0, 35)
jumpBtn.Position = UDim2.new(0, 0, 0, 5)
jumpBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
jumpBtn.TextColor3 = Color3.new(1, 1, 1)
jumpBtn.Font = Enum.Font.GothamBold
jumpBtn.TextSize = 13
jumpBtn.Parent = pMove
Instance.new("UICorner", jumpBtn).CornerRadius = UDim.new(0, 8)

jumpBtn.MouseButton1Click:Connect(function()
    infJumpEnabled = not infJumpEnabled
    if infJumpEnabled then
        jumpBtn.Text = "Unlimited Jump: ON"
        TweenService:Create(jumpBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 150, 255)}):Play()
    else
        jumpBtn.Text = "Unlimited Jump: OFF"
        TweenService:Create(jumpBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(35, 35, 45)}):Play()
    end
end)

UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled then
        local char = localPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end
end)

-- WALK SPEED
local speedEnabled = false
local speedValue = 16

local speedToggleBtn = Instance.new("TextButton")
speedToggleBtn.Text = "Speed Modifier: OFF"
speedToggleBtn.Size = UDim2.new(1, 0, 0, 35)
speedToggleBtn.Position = UDim2.new(0, 0, 0, 48)
speedToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
speedToggleBtn.TextColor3 = Color3.new(1, 1, 1)
speedToggleBtn.Font = Enum.Font.GothamBold
speedToggleBtn.TextSize = 13
speedToggleBtn.Parent = pMove
Instance.new("UICorner", speedToggleBtn).CornerRadius = UDim.new(0, 8)

speedToggleBtn.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    if speedEnabled then
        speedToggleBtn.Text = "Speed Modifier: ON"
        TweenService:Create(speedToggleBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 200, 80)}):Play()
    else
        speedToggleBtn.Text = "Speed Modifier: OFF"
        TweenService:Create(speedToggleBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(35, 35, 45)}):Play()
        local char = localPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = 16 end
        end
    end
end)

local spdLab = Instance.new("TextLabel")
spdLab.Text = "Current Speed: " .. speedValue
spdLab.Size = UDim2.new(1, 0, 0, 20)
spdLab.Position = UDim2.new(0, 0, 0, 92)
spdLab.TextColor3 = Color3.fromRGB(200, 200, 220)
spdLab.BackgroundTransparency = 1
spdLab.Font = Enum.Font.GothamBold
spdLab.TextSize = 11
spdLab.Parent = pMove

local spdMinus = Instance.new("TextButton")
spdMinus.Text = "- 10"
spdMinus.Size = UDim2.new(0.48, 0, 0, 32)
spdMinus.Position = UDim2.new(0, 0, 0, 115)
spdMinus.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
spdMinus.TextColor3 = Color3.new(1, 1, 1)
spdMinus.Font = Enum.Font.GothamBold
spdMinus.TextSize = 12
spdMinus.Parent = pMove
Instance.new("UICorner", spdMinus).CornerRadius = UDim.new(0, 8)

local spdPlus = Instance.new("TextButton")
spdPlus.Text = "+ 10"
spdPlus.Size = UDim2.new(0.48, 0, 0, 32)
spdPlus.Position = UDim2.new(0.52, 0, 0, 115)
spdPlus.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
spdPlus.TextColor3 = Color3.new(1, 1, 1)
spdPlus.Font = Enum.Font.GothamBold
spdPlus.TextSize = 12
spdPlus.Parent = pMove
Instance.new("UICorner", spdPlus).CornerRadius = UDim.new(0, 8)

spdMinus.MouseButton1Click:Connect(function()
    speedValue = math.clamp(speedValue - 10, 16, 500)
    spdLab.Text = "Current Speed: " .. speedValue
end)

spdPlus.MouseButton1Click:Connect(function()
    speedValue = math.clamp(speedValue + 10, 16, 500)
    spdLab.Text = "Current Speed: " .. speedValue
end)

RunService.Heartbeat:Connect(function()
    if speedEnabled then
        local char = localPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = speedValue end
        end
    end
end)

-- ==========================================
-- LOGIC & UI: TELEPORT (PLAYER LIST)
-- ==========================================
local pTP = tabPanels["Teleport"]

local tpTitle = Instance.new("TextLabel")
tpTitle.Text = "Pilih Player buat di Teleport:"
tpTitle.Size = UDim2.new(1, 0, 0, 16)
tpTitle.Position = UDim2.new(0, 0, 0, 0)
tpTitle.TextColor3 = Color3.fromRGB(200, 150, 255)
tpTitle.Font = Enum.Font.GothamBold
tpTitle.TextSize = 11
tpTitle.TextXAlignment = Enum.TextXAlignment.Left
tpTitle.BackgroundTransparency = 1
tpTitle.Parent = pTP

local plFrame = Instance.new("ScrollingFrame")
plFrame.Size = UDim2.new(1, 0, 1, -22)
plFrame.Position = UDim2.new(0, 0, 0, 22)
plFrame.BackgroundColor3 = Color3.fromRGB(14, 10, 24)
plFrame.Parent = pTP
plFrame.ScrollBarThickness = 3
plFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
plFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
plFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
plFrame.ScrollingDirection = Enum.ScrollingDirection.Y
Instance.new("UICorner", plFrame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", plFrame).Color = Color3.fromRGB(40, 40, 50)

local plLayout = Instance.new("UIListLayout", plFrame)
plLayout.Padding = UDim.new(0, 4)
plLayout.SortOrder = Enum.SortOrder.Name
local plPad = Instance.new("UIPadding", plFrame)
plPad.PaddingTop = UDim.new(0, 4)
plPad.PaddingLeft = UDim.new(0, 4)
plPad.PaddingRight = UDim.new(0, 4)
plPad.PaddingBottom = UDim.new(0, 4)

local playerRows = {}

local function teleportToPlayer(targetPlayer)
    if not targetPlayer then return end
    local char = localPlayer.Character
    local targetChar = targetPlayer.Character
    if char and targetChar then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local targetHrp = targetChar:FindFirstChild("HumanoidRootPart")
        if hrp and targetHrp then
            hrp.CFrame = targetHrp.CFrame + Vector3.new(0, 3, 0)
        end
    end
end

local function refreshPlayerList()
    for _, r in pairs(playerRows) do pcall(function() r:Destroy() end) end
    playerRows = {}
    
    local list = Players:GetPlayers()
    local count = 0
    
    for _, p in ipairs(list) do
        if p ~= localPlayer then
            count = count + 1
            local row = Instance.new("TextButton")
            row.Size = UDim2.new(1, 0, 0, 32)
            row.Name = "TP_" .. p.Name
            row.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
            row.Text = ""
            row.AutoButtonColor = true
            row.Parent = plFrame
            Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
            
            local icon = Instance.new("ImageLabel")
            icon.Size = UDim2.new(0, 22, 0, 22)
            icon.Position = UDim2.new(0, 5, 0.5, -11)
            icon.BackgroundTransparency = 1
            icon.Image = Players:GetUserThumbnailAsync(p.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
            icon.Parent = row
            Instance.new("UICorner", icon).CornerRadius = UDim.new(1, 0)

            local nl = Instance.new("TextLabel")
            nl.Size = UDim2.new(1, -45, 1, 0)
            nl.Position = UDim2.new(0, 35, 0, 0)
            nl.BackgroundTransparency = 1
            nl.Text = p.DisplayName .. " (@" .. p.Name .. ")"
            nl.TextColor3 = Color3.fromRGB(220, 220, 230)
            nl.Font = Enum.Font.GothamBold
            nl.TextSize = 10
            nl.TextXAlignment = Enum.TextXAlignment.Left
            nl.Parent = row
            
            local tpBadge = Instance.new("TextLabel")
            tpBadge.Size = UDim2.new(0, 50, 0, 18)
            tpBadge.Position = UDim2.new(1, -55, 0.5, -9)
            tpBadge.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
            tpBadge.Text = "TELEPORT"
            tpBadge.TextColor3 = Color3.new(1, 1, 1)
            tpBadge.Font = Enum.Font.GothamBold
            tpBadge.TextSize = 8
            tpBadge.Parent = row
            Instance.new("UICorner", tpBadge).CornerRadius = UDim.new(0, 4)

            row.MouseButton1Click:Connect(function()
                teleportToPlayer(p)
            end)
            table.insert(playerRows, row)
        end
    end
    
    if count == 0 then
        local el = Instance.new("TextLabel")
        el.Size = UDim2.new(1, 0, 0, 30)
        el.BackgroundTransparency = 1
        el.Text = "Tidak ada player lain di server"
        el.TextColor3 = Color3.fromRGB(100, 100, 120)
        el.Font = Enum.Font.Gotham
        el.TextSize = 10
        el.Parent = plFrame
        table.insert(playerRows, el)
    end
end

Players.PlayerAdded:Connect(function() task.wait(0.5); refreshPlayerList() end)
Players.PlayerRemoving:Connect(function() task.wait(0.5); refreshPlayerList() end)
task.spawn(function() task.wait(0.5); refreshPlayerList() end)

setTab("Movement")
