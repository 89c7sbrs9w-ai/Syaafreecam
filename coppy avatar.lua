local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

pcall(function()
    game:GetService("CoreGui"):FindFirstChild("CopyAvatarGUI"):Destroy()
    game:GetService("CoreGui"):FindFirstChild("SyaaNotifGui"):Destroy()
end)

-- Variabel Global
local visualConnection = nil
local backup = { AnimIds = {} }

-- Async Load Gambar Avatar 'tepresakkriminal'
local targetUsername = "tepresakkriminal"
local syaaAvatarUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. LocalPlayer.UserId .. "&width=150&height=150&format=png"

-- =====================
-- BACKUP ANIMASI ORIGINAL
-- =====================
local function saveOriginalData()
    local char = LocalPlayer.Character
    if not char then return end
    local animScript = char:FindFirstChild("Animate")
    if animScript then
        for _, folder in ipairs(animScript:GetChildren()) do
            if folder:IsA("ValueBase") or folder:IsA("Folder") then
                local anim = folder:FindFirstChildOfClass("Animation")
                if anim then
                    backup.AnimIds[folder.Name] = anim.AnimationId
                end
            end
        end
    end
end
saveOriginalData()

-- =====================
-- SISTEM NOTIFIKASI (SUDAH DIKECILIN)
-- =====================
local function showStartupNotification()
    local NotifGui = Instance.new("ScreenGui")
    NotifGui.Name = "SyaaNotifGui"
    NotifGui.ResetOnSpawn = false
    NotifGui.DisplayOrder = 1000
    NotifGui.Parent = game:GetService("CoreGui")

    local NotifFrame = Instance.new("Frame")
    NotifFrame.Size = UDim2.new(0, 270, 0, 68) 
    NotifFrame.Position = UDim2.new(1, 400, 0.85, 0)
    NotifFrame.AnchorPoint = Vector2.new(1, 0.5)
    NotifFrame.BackgroundColor3 = Color3.fromRGB(10, 20, 35)
    NotifFrame.BackgroundTransparency = 0.1
    NotifFrame.BorderSizePixel = 0
    NotifFrame.Parent = NotifGui

    Instance.new("UICorner", NotifFrame).CornerRadius = UDim.new(0, 10)
    
    local NStroke = Instance.new("UIStroke", NotifFrame)
    NStroke.Color = Color3.fromRGB(0, 120, 255)
    NStroke.Thickness = 2
    local NGrad = Instance.new("UIGradient", NStroke)
    NGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 180, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 60, 150))
    })

    local Img = Instance.new("ImageLabel", NotifFrame)
    Img.Size = UDim2.new(0, 48, 0, 48) 
    Img.Position = UDim2.new(0, 10, 0.5, -24)
    Img.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
    Img.Image = syaaAvatarUrl
    Img.Parent = NotifFrame
    Instance.new("UICorner", Img).CornerRadius = UDim.new(1, 0)
    local IStroke = Instance.new("UIStroke", Img)
    IStroke.Color = Color3.fromRGB(70, 130, 255)
    IStroke.Thickness = 1.5

    local DevLabel = Instance.new("TextLabel", NotifFrame)
    DevLabel.Size = UDim2.new(1, -75, 0, 14)
    DevLabel.Position = UDim2.new(0, 70, 0, 8)
    DevLabel.BackgroundTransparency = 1
    DevLabel.Text = "Developer"
    DevLabel.TextColor3 = Color3.fromRGB(100, 180, 255)
    DevLabel.Font = Enum.Font.GothamBold
    DevLabel.TextSize = 10
    DevLabel.TextXAlignment = Enum.TextXAlignment.Left
    DevLabel.Parent = NotifFrame

    local NameLabel = Instance.new("TextLabel", NotifFrame)
    NameLabel.Size = UDim2.new(1, -75, 0, 18)
    NameLabel.Position = UDim2.new(0, 70, 0, 22)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = targetUsername
    NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameLabel.Font = Enum.Font.GothamBlack
    NameLabel.TextSize = 15
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Parent = NotifFrame

    local ValidLabel = Instance.new("TextLabel", NotifFrame)
    ValidLabel.Size = UDim2.new(1, -75, 0, 14)
    ValidLabel.Position = UDim2.new(0, 70, 0, 42)
    ValidLabel.BackgroundTransparency = 1
    ValidLabel.Text = "Copy Avatar Valid By Syaa"
    ValidLabel.TextColor3 = Color3.fromRGB(130, 180, 255)
    ValidLabel.Font = Enum.Font.Gotham
    ValidLabel.TextSize = 10
    ValidLabel.TextXAlignment = Enum.TextXAlignment.Left
    ValidLabel.Parent = NotifFrame

    task.spawn(function()
        pcall(function()
            local id = Players:GetUserIdFromNameAsync(targetUsername)
            local realUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. id .. "&width=150&height=150&format=png"
            Img.Image = realUrl
            _G.SyaaRealAvatarUrl = realUrl
        end)
    end)

    TweenService:Create(NotifFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(1, -20, 0.85, 0)}):Play()
    
    task.delay(3.5, function()
        TweenService:Create(NotifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Position = UDim2.new(1, 400, 0.85, 0)}):Play()
        task.wait(0.6)
        NotifGui:Destroy()
    end)
end

showStartupNotification()

-- =====================
-- GUI UTAMA SCRIPT
-- =====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CopyAvatarGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = game:GetService("CoreGui")

local HEADER_H = 58
local FULL_W = 0.42
local FULL_H = 0.52
local CENTER_POS = UDim2.new(0.5 - FULL_W/2, 0, 0.22, 0)

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(FULL_W, 0, FULL_H, 0)
MainFrame.Position = CENTER_POS
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 20, 35)
MainFrame.BackgroundTransparency = 0.15 
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(255, 255, 255)
MainStroke.Thickness = 2.5 

local StrokeGradient = Instance.new("UIGradient", MainStroke)
StrokeGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 120, 255)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.66, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 120, 255))
})

local strokeRot = 0
RunService.RenderStepped:Connect(function(dt)
    strokeRot = (strokeRot + 150 * dt) % 360
    StrokeGradient.Rotation = strokeRot
end)

local BG = Instance.new("UIGradient", MainFrame)
BG.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 25, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 10, 20))
})
BG.Rotation = 135

local Header = Instance.new("Frame", MainFrame)
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, HEADER_H)
Header.BackgroundTransparency = 1
Header.ZIndex = 4

local MiniAvatar = Instance.new("ImageLabel", Header)
MiniAvatar.Size = UDim2.new(0, 34, 0, 34)
MiniAvatar.Position = UDim2.new(0, 10, 0.5, -17)
MiniAvatar.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
MiniAvatar.BorderSizePixel = 0
MiniAvatar.Image = syaaAvatarUrl
MiniAvatar.ZIndex = 5
MiniAvatar.Visible = false
Instance.new("UICorner", MiniAvatar).CornerRadius = UDim.new(1, 0)
local MiniAvatarStroke = Instance.new("UIStroke", MiniAvatar)
MiniAvatarStroke.Color = Color3.fromRGB(50, 150, 255)
MiniAvatarStroke.Thickness = 1.5

task.spawn(function()
    while not _G.SyaaRealAvatarUrl do task.wait(0.1) end
    if MiniAvatar then MiniAvatar.Image = _G.SyaaRealAvatarUrl end
end)

local TitleIcon = Instance.new("TextLabel", Header)
TitleIcon.Size = UDim2.new(0, 22, 0, 22)
TitleIcon.Position = UDim2.new(0, 10, 0, 10)
TitleIcon.BackgroundTransparency = 1
TitleIcon.Text = "✦"
TitleIcon.TextColor3 = Color3.fromRGB(100, 180, 255)
TitleIcon.TextSize = 16
TitleIcon.Font = Enum.Font.GothamBold
TitleIcon.ZIndex = 5

local TitleLabel = Instance.new("TextLabel", Header)
TitleLabel.Size = UDim2.new(1, -100, 0, 22)
TitleLabel.Position = UDim2.new(0, 32, 0, 9)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Copy Avatar - Syaa"
TitleLabel.TextColor3 = Color3.fromRGB(200, 230, 255)
TitleLabel.TextSize = 15
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 5

local SubLabel = Instance.new("TextLabel", Header)
SubLabel.Size = UDim2.new(1, -100, 0, 14)
SubLabel.Position = UDim2.new(0, 32, 0, 33)
SubLabel.BackgroundTransparency = 1
SubLabel.Text = "Hanya kamu yang bisa lihat (Local Only)"
SubLabel.TextColor3 = Color3.fromRGB(100, 150, 200)
SubLabel.TextSize = 10
SubLabel.Font = Enum.Font.Gotham
SubLabel.TextXAlignment = Enum.TextXAlignment.Left
SubLabel.ZIndex = 5

-- =====================
-- MARQUEE ANIMATION
-- =====================
local MarqueeFrame = Instance.new("Frame", Header)
MarqueeFrame.Size = UDim2.new(1, -115, 0, HEADER_H)
MarqueeFrame.Position = UDim2.new(0, 52, 0, 0)
MarqueeFrame.BackgroundTransparency = 1
MarqueeFrame.ClipsDescendants = true
MarqueeFrame.Visible = false
MarqueeFrame.ZIndex = 5

local rawText = "Copy Avatar - Syaa   ✦   "
local TEXT_WIDTH = 190 

local MText1 = Instance.new("TextLabel", MarqueeFrame)
MText1.Size = UDim2.new(0, TEXT_WIDTH, 1, 0)
MText1.BackgroundTransparency = 1
MText1.Text = rawText
MText1.TextColor3 = Color3.fromRGB(200, 230, 255)
MText1.TextSize = 14
MText1.Font = Enum.Font.GothamBold
MText1.TextXAlignment = Enum.TextXAlignment.Left

local MText2 = MText1:Clone()
MText2.Parent = MarqueeFrame
MText2.Position = UDim2.new(0, TEXT_WIDTH, 0, 0)

local textSpeed = 90 
RunService.RenderStepped:Connect(function(dt)
    if not MarqueeFrame.Visible then return end
    local moveAmt = textSpeed * dt
    MText1.Position = MText1.Position - UDim2.new(0, moveAmt, 0, 0)
    MText2.Position = MText2.Position - UDim2.new(0, moveAmt, 0, 0)

    if MText1.Position.X.Offset <= -TEXT_WIDTH then
        MText1.Position = UDim2.new(0, MText2.Position.X.Offset + TEXT_WIDTH, 0, 0)
    end
    if MText2.Position.X.Offset <= -TEXT_WIDTH then
        MText2.Position = UDim2.new(0, MText1.Position.X.Offset + TEXT_WIDTH, 0, 0)
    end
end)

local MinBtn = Instance.new("TextButton", Header)
MinBtn.Size = UDim2.new(0, 28, 0, 28)
MinBtn.Position = UDim2.new(1, -64, 0.5, -14)
MinBtn.BackgroundColor3 = Color3.fromRGB(20, 40, 70)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(150, 200, 255)
MinBtn.TextSize = 16
MinBtn.Font = Enum.Font.GothamBold
MinBtn.BorderSizePixel = 0
MinBtn.AutoButtonColor = false
MinBtn.ZIndex = 6
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 7)

local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -32, 0.5, -14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(58, 18, 35)
CloseBtn.Text = "x"
CloseBtn.TextColor3 = Color3.fromRGB(255, 90, 120)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.AutoButtonColor = false
CloseBtn.ZIndex = 6
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 7)

-- =====================
-- MAIN SCROLL CONTAINER (SEMUA BISA DI SCROLL)
-- =====================
local Content = Instance.new("ScrollingFrame", MainFrame)
Content.Name = "Content"
Content.Size = UDim2.new(1, 0, 1, -HEADER_H)
Content.Position = UDim2.new(0, 0, 0, HEADER_H)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 2
Content.ScrollBarImageColor3 = Color3.fromRGB(70, 130, 255)
Content.CanvasSize = UDim2.new(0, 0, 0, 0)
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y

-- RONGGA UTAMA
local ContentLayout = Instance.new("UIListLayout", Content)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Padding = UDim.new(0, 12)
ContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local ContentPad = Instance.new("UIPadding", Content)
ContentPad.PaddingTop = UDim.new(0, 5)
ContentPad.PaddingBottom = UDim.new(0, 20)
ContentPad.PaddingLeft = UDim.new(0, 14)
ContentPad.PaddingRight = UDim.new(0, 14)

-- 1. DIVIDER
local Divider = Instance.new("Frame", Content)
Divider.Size = UDim2.new(1, 0, 0, 1)
Divider.BackgroundColor3 = Color3.fromRGB(30, 60, 100)
Divider.BorderSizePixel = 0
Divider.LayoutOrder = 1

-- 2. SEARCH BAR
local SearchBar = Instance.new("TextBox", Content)
SearchBar.Name = "SearchBar"
SearchBar.Size = UDim2.new(1, 0, 0, 34)
SearchBar.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
SearchBar.TextColor3 = Color3.fromRGB(200, 230, 255)
SearchBar.PlaceholderText = "🔍 Cari Username / Display Name..."
SearchBar.PlaceholderColor3 = Color3.fromRGB(100, 150, 200)
SearchBar.Font = Enum.Font.Gotham
SearchBar.TextSize = 12
SearchBar.Text = ""
SearchBar.ClearTextOnFocus = false
SearchBar.LayoutOrder = 2
Instance.new("UICorner", SearchBar).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", SearchBar).Color = Color3.fromRGB(40, 80, 120)
Instance.new("UIPadding", SearchBar).PaddingLeft = UDim.new(0, 12)

-- 3. KOTAKAN KHUSUS DAFTAR PLAYER (INNER SCROLL)
local ListFrame = Instance.new("Frame", Content)
ListFrame.Size = UDim2.new(1, 0, 0, 230) 
ListFrame.BackgroundColor3 = Color3.fromRGB(8, 14, 25) 
ListFrame.BackgroundTransparency = 0.3
ListFrame.LayoutOrder = 3
Instance.new("UICorner", ListFrame).CornerRadius = UDim.new(0, 12)
local ListStroke = Instance.new("UIStroke", ListFrame)
ListStroke.Color = Color3.fromRGB(35, 60, 95)
ListStroke.Thickness = 1

local ScrollFrame = Instance.new("ScrollingFrame", ListFrame)
ScrollFrame.Size = UDim2.new(1, -10, 1, -12)
ScrollFrame.Position = UDim2.new(0, 5, 0, 6)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 3
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(50, 100, 200)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

local ListLayout = Instance.new("UIListLayout", ScrollFrame)
ListLayout.SortOrder = Enum.SortOrder.Name
ListLayout.Padding = UDim.new(0, 8)
Instance.new("UIPadding", ScrollFrame).PaddingTop = UDim.new(0, 5)

-- 4. TOMBOL RESTORE
local RestoreBtn = Instance.new("TextButton", Content)
RestoreBtn.Size = UDim2.new(1, 0, 0, 36)
RestoreBtn.BackgroundColor3 = Color3.fromRGB(20, 40, 80)
RestoreBtn.Text = "↩ Lepas Visual Clone"
RestoreBtn.TextColor3 = Color3.fromRGB(150, 200, 255)
RestoreBtn.TextSize = 12
RestoreBtn.Font = Enum.Font.GothamBold
RestoreBtn.BorderSizePixel = 0
RestoreBtn.AutoButtonColor = false
RestoreBtn.LayoutOrder = 4
Instance.new("UICorner", RestoreBtn).CornerRadius = UDim.new(0, 9)
Instance.new("UIStroke", RestoreBtn).Color = Color3.fromRGB(50, 100, 200)

-- 5. STATUS BAR
local StatusBar = Instance.new("Frame", Content)
StatusBar.Size = UDim2.new(1, 0, 0, 38)
StatusBar.BackgroundColor3 = Color3.fromRGB(12, 22, 40)
StatusBar.BorderSizePixel = 0
StatusBar.LayoutOrder = 5
Instance.new("UICorner", StatusBar).CornerRadius = UDim.new(0, 9)
Instance.new("UIStroke", StatusBar).Color = Color3.fromRGB(40, 80, 150)

local StatusLabel = Instance.new("TextLabel", StatusBar)
StatusLabel.Size = UDim2.new(1, -20, 1, 0)
StatusLabel.Position = UDim2.new(0, 10, 0, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "🔵 Siap — Pilih player untuk diclone"
StatusLabel.TextColor3 = Color3.fromRGB(130, 180, 255)
StatusLabel.TextSize = 10
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

local function setStatus(text, color)
    StatusLabel.Text = text
    StatusLabel.TextColor3 = color or Color3.fromRGB(130, 180, 255)
end

local function tw(obj, props, t)
    TweenService:Create(obj, TweenInfo.new(t or 0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props):Play()
end

-- =====================
-- LOGIKA FILTER SEARCH
-- =====================
local function filterPlayers()
    local searchText = string.lower(SearchBar.Text)
    for _, child in ipairs(ScrollFrame:GetChildren()) do
        if child:IsA("Frame") then
            local pName = string.lower(child.Name)
            local dName = ""
            for _, lbl in ipairs(child:GetChildren()) do
                if lbl:IsA("TextLabel") and lbl.TextSize == 13 then
                    dName = string.lower(lbl.Text)
                end
            end
            
            if searchText == "" or string.find(pName, searchText) or string.find(dName, searchText) then
                child.Visible = true
            else
                child.Visible = false
            end
        end
    end
end
SearchBar:GetPropertyChangedSignal("Text"):Connect(filterPlayers)

-- =====================
-- KUNCI DEWA: ROBLOX API RIG GENERATOR + ANIMASI SYNC + CAMERA DYNAMIC OFFSET
-- =====================
local function createVisualHologram(targetPlayer)
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local tChar = targetPlayer.Character
    local tHum = tChar and tChar:FindFirstChildOfClass("Humanoid")
    
    if not char or not hum or not tChar or not tHum then return false, "Karakter tidak siap" end

    local ok, err = pcall(function()
        if workspace.CurrentCamera:FindFirstChild("SyaaVisualHologram") then
            workspace.CurrentCamera.SyaaVisualHologram:Destroy()
        end
        if visualConnection then 
            visualConnection:Disconnect() 
            visualConnection = nil
        end

        for _, v in ipairs(char:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                if v.Name ~= "HumanoidRootPart" then
                    if not v:GetAttribute("SyaaOriTrans") then
                        v:SetAttribute("SyaaOriTrans", v.Transparency)
                    end
                    v.Transparency = 1 
                end
            end
        end

        local myAnimScript = char:FindFirstChild("Animate")
        local tAnimScript = tChar:FindFirstChild("Animate")
        if myAnimScript and tAnimScript then
            for _, tFolder in ipairs(tAnimScript:GetChildren()) do
                local myFolder = myAnimScript:FindFirstChild(tFolder.Name)
                local tAnim = tFolder:FindFirstChildOfClass("Animation")
                if myFolder and tAnim then
                    local myAnim = myFolder:FindFirstChildOfClass("Animation")
                    if myAnim then myAnim.AnimationId = tAnim.AnimationId end
                end
            end
            myAnimScript.Disabled = true
            task.wait(0.1)
            myAnimScript.Disabled = false
        end

        local desc = tHum:GetAppliedDescription()
        local fakeChar = Players:CreateHumanoidModelFromDescription(desc, hum.RigType)
        fakeChar.Name = "SyaaVisualHologram"

        local fakeHum = fakeChar:FindFirstChildOfClass("Humanoid")
        if fakeHum then
            fakeHum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
            fakeHum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
            fakeHum:ChangeState(Enum.HumanoidStateType.Physics)
        end

        for _, v in ipairs(fakeChar:GetDescendants()) do
            if v:IsA("Script") or v:IsA("LocalScript") then
                v:Destroy()
            elseif v:IsA("BasePart") then
                v.CanCollide = false
                v.Massless = true
                v.CanQuery = false
                v.CanTouch = false
                v.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
                
                if v.Name ~= "HumanoidRootPart" then
                    v.Anchored = false
                end

                for _, realPart in ipairs(char:GetDescendants()) do
                    if realPart:IsA("BasePart") then
                        local ncc = Instance.new("NoCollisionConstraint")
                        ncc.Part0 = v
                        ncc.Part1 = realPart
                        ncc.Parent = v
                    end
                end
            end
        end

        local realRoot = char:FindFirstChild("HumanoidRootPart")
        local fakeRoot = fakeChar:FindFirstChild("HumanoidRootPart")
        if fakeRoot then fakeRoot.Anchored = true end
        
        local yOffset = 0
        if fakeHum and hum then
            yOffset = (fakeHum.HipHeight or 0) - (hum.HipHeight or 0)
        end

        fakeChar.Parent = workspace.CurrentCamera

        visualConnection = RunService.RenderStepped:Connect(function()
            if char and fakeChar and fakeChar.Parent and realRoot and fakeRoot then
                fakeRoot.CFrame = realRoot.CFrame + Vector3.new(0, yOffset, 0)
                
                -- ========================================================
                -- FIX CAMERA DYNAMIC OFFSET: Ngukur Kepala Target ke Kepala Asli
                -- ========================================================
                local rHead = char:FindFirstChild("Head")
                local fHead = fakeChar:FindFirstChild("Head")
                if rHead and fHead and hum then
                    -- Nambahin / kurangin titik fokus kamera biar sesuai kepala Clone lu
                    hum.CameraOffset = Vector3.new(0, fHead.Position.Y - rHead.Position.Y, 0)
                end
                
                for _, v in ipairs(fakeChar:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
                for _, realMotor in ipairs(char:GetDescendants()) do
                    if realMotor:IsA("Motor6D") then
                        local fakeMotor = fakeChar:FindFirstChild(realMotor.Name, true)
                        if fakeMotor and fakeMotor:IsA("Motor6D") then
                            fakeMotor.Transform = realMotor.Transform
                        end
                    end
                end
            else
                if visualConnection then visualConnection:Disconnect() end
            end
        end)
    end)

    return ok, ok and nil or tostring(err)
end

-- =====================
-- FIX BUG RESTORE VISUAL & RESET CAMERA
-- =====================
local function restoreVisualAvatar()
    local char = LocalPlayer.Character
    if not char then return false, "Karakter tidak ditemukan" end

    local ok, err = pcall(function()
        if workspace.CurrentCamera:FindFirstChild("SyaaVisualHologram") then
            workspace.CurrentCamera.SyaaVisualHologram:Destroy()
        end
        if visualConnection then 
            visualConnection:Disconnect() 
            visualConnection = nil
        end

        -- BALIKIN CAMERA KE TINGGI AWAL LU
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.CameraOffset = Vector3.new(0, 0, 0) end

        for _, v in ipairs(char:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                local oriTrans = v:GetAttribute("SyaaOriTrans")
                if oriTrans ~= nil then
                    v.Transparency = oriTrans
                    v:SetAttribute("SyaaOriTrans", nil) 
                end
            end
        end

        local myAnimScript = char:FindFirstChild("Animate")
        if myAnimScript then
            for folderName, id in pairs(backup.AnimIds) do
                local folder = myAnimScript:FindFirstChild(folderName)
                local anim = folder and folder:FindFirstChildOfClass("Animation")
                if anim then anim.AnimationId = id end
            end
            myAnimScript.Disabled = true
            task.wait(0.1)
            myAnimScript.Disabled = false
        end
    end)

    return ok, ok and nil or tostring(err)
end

-- =====================
-- PLAYER CARD BUILDER
-- =====================
local function createPlayerCard(player)
    if player == LocalPlayer then return end
    if ScrollFrame:FindFirstChild(player.Name) then return end

    local Card = Instance.new("Frame", ScrollFrame)
    Card.Name = player.Name
    Card.Size = UDim2.new(1, 0, 0, 52)
    Card.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
    Card.BorderSizePixel = 0
    Card.BackgroundTransparency = 1
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 11)
    local CS = Instance.new("UIStroke", Card)
    CS.Color = Color3.fromRGB(40, 80, 120)
    CS.Thickness = 1

    local Img = Instance.new("ImageLabel", Card)
    Img.Size = UDim2.new(0, 36, 0, 36)
    Img.Position = UDim2.new(0, 10, 0.5, -18)
    Img.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
    Img.BorderSizePixel = 0
    Img.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=48&height=48&format=png"
    Instance.new("UICorner", Img).CornerRadius = UDim.new(1, 0)
    local IS = Instance.new("UIStroke", Img)
    IS.Color = Color3.fromRGB(70, 130, 255)
    IS.Thickness = 1.5

    local NL = Instance.new("TextLabel", Card)
    NL.Size = UDim2.new(1, -125, 0, 20)
    NL.Position = UDim2.new(0, 56, 0, 8)
    NL.BackgroundTransparency = 1
    NL.Text = player.DisplayName
    NL.TextColor3 = Color3.fromRGB(200, 230, 255)
    NL.TextSize = 13
    NL.Font = Enum.Font.GothamBold
    NL.TextXAlignment = Enum.TextXAlignment.Left

    local UL = Instance.new("TextLabel", Card)
    UL.Size = UDim2.new(1, -125, 0, 14)
    UL.Position = UDim2.new(0, 56, 0, 29)
    UL.BackgroundTransparency = 1
    UL.Text = "@" .. player.Name
    UL.TextColor3 = Color3.fromRGB(100, 150, 200)
    UL.TextSize = 10
    UL.Font = Enum.Font.Gotham
    UL.TextXAlignment = Enum.TextXAlignment.Left

    local CopyBtn = Instance.new("TextButton", Card)
    CopyBtn.Size = UDim2.new(0, 60, 0, 28)
    CopyBtn.Position = UDim2.new(1, -70, 0.5, -14)
    CopyBtn.BackgroundColor3 = Color3.fromRGB(30, 100, 200)
    CopyBtn.Text = "Clone"
    CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CopyBtn.TextSize = 12
    CopyBtn.Font = Enum.Font.GothamBold
    CopyBtn.BorderSizePixel = 0
    CopyBtn.AutoButtonColor = false
    Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0, 7)

    Card.MouseEnter:Connect(function()
        tw(Card, {BackgroundColor3 = Color3.fromRGB(25, 40, 70)})
        tw(CS, {Color = Color3.fromRGB(70, 130, 255)})
    end)
    Card.MouseLeave:Connect(function()
        tw(Card, {BackgroundColor3 = Color3.fromRGB(15, 25, 45)})
        tw(CS, {Color = Color3.fromRGB(40, 80, 120)})
    end)
    
    local copying = false
    CopyBtn.MouseButton1Click:Connect(function()
        if copying then return end
        copying = true
        CopyBtn.Text = "..."
        setStatus("⏳ Sedang memuat Visual & Animasi " .. player.DisplayName .. "...", Color3.fromRGB(150, 200, 255))
        
        task.spawn(function()
            local ok, err = createVisualHologram(player)
            task.wait(0.3)
            if ok then
                CopyBtn.Text = "✓"
                setStatus("✅ Berhasil Clone " .. player.DisplayName .. "!", Color3.fromRGB(95, 215, 145))
            else
                CopyBtn.Text = "✗"
                setStatus("❌ Gagal: " .. (err or "Karakter tidak siap"), Color3.fromRGB(255, 95, 115))
            end
            task.wait(1.5)
            CopyBtn.Text = "Clone"
            copying = false
        end)
    end)

    tw(Card, {BackgroundTransparency = 0}, 0.3)
    filterPlayers()
end

local restoring = false
RestoreBtn.MouseButton1Click:Connect(function()
    if restoring then return end
    restoring = true
    RestoreBtn.Text = "⏳ Melepas..."
    task.spawn(function()
        local ok, err = restoreVisualAvatar()
        task.wait(0.3)
        if ok then
            RestoreBtn.Text = "✅ Visual asli kembali!"
            setStatus("✅ Avatar & Animasi asli berhasil dipulihkan!", Color3.fromRGB(95, 215, 145))
        else
            RestoreBtn.Text = "❌ Gagal lepas"
            setStatus("❌ Error: " .. (err or ""), Color3.fromRGB(255, 95, 115))
        end
        task.wait(1.5)
        RestoreBtn.Text = "↩ Lepas Visual Clone"
        restoring = false
    end)
end)

local function refreshPlayers()
    for _, c in ipairs(ScrollFrame:GetChildren()) do
        if c:IsA("Frame") then c:Destroy() end
    end
    for _, p in ipairs(Players:GetPlayers()) do
        createPlayerCard(p)
    end
end

refreshPlayers()
Players.PlayerAdded:Connect(function(p) task.wait(0.5) createPlayerCard(p) end)
Players.PlayerRemoving:Connect(function(p)
    local card = ScrollFrame:FindFirstChild(p.Name)
    if card then card:Destroy() end
end)

local minimized = false
local fullSize = UDim2.new(FULL_W, 0, FULL_H, 0)
local miniSize = UDim2.new(0, 240, 0, HEADER_H)

MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        Content.Visible = false
        TitleIcon.Visible = false
        TitleLabel.Visible = false
        SubLabel.Visible = false
        MiniAvatar.Visible = true
        MarqueeFrame.Visible = true
        MinBtn.Text = "+"
        tw(MainFrame, {Size = miniSize}, 0.3)
    else
        Content.Visible = true
        TitleIcon.Visible = true
        TitleLabel.Visible = true
        SubLabel.Visible = true
        MiniAvatar.Visible = false
        MarqueeFrame.Visible = false
        MinBtn.Text = "-"
        tw(MainFrame, {Size = fullSize, Position = CENTER_POS}, 0.3)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    if visualConnection then visualConnection:Disconnect() end
    restoreVisualAvatar()
end)

local dragging, dragStart, startPos
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
