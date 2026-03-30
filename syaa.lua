-- [[ SYAAA HUB V7.6 - PURPLE THEME + AI CHAT ASSISTANT (FIXED TEXT & TYPING) ]] --

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService") -- Buat AI

-- FIX 1: Nungguin LocalPlayer beneran ke-load biar nggak error 'attempt to index nil'
local localPlayer = Players.LocalPlayer
while not localPlayer do
    task.wait(0.1)
    localPlayer = Players.LocalPlayer
end

local Camera = workspace.CurrentCamera
while not Camera do
    task.wait(0.1)
    Camera = workspace.CurrentCamera
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SyaaaHub_V7_Final"
screenGui.ResetOnSpawn = false

-- FIX 2: Panggil gethui() pakai pcall biar aman dari error executor
local coreGui
pcall(function() coreGui = gethui and gethui() end)
screenGui.Parent = coreGui or game:GetService("CoreGui")

-- ASSETS REQUESTED BY SYAA
local ICON_SIDEBAR_AI = "rbxassetid://116237838142641" -- ICON AI BARU
local ICON_SEND_MESSAGE = "rbxassetid://138977642527887"

-- AVATARS FETCHING
local devAvaUrl = "rbxthumb://type=AvatarHeadShot&id=0&w=150&h=150" -- Default
local playerAvaUrl = "rbxthumb://type=AvatarHeadShot&id="..localPlayer.UserId.."&w=150&h=150"

-- FIX 3: Asynchronous Fetch pake task.spawn biar nggak nge-block loading GUI lu (Non-Blocking)
task.spawn(function()
    pcall(function()
        -- Ambil UserId Syaa 'tepresakkriminal'
        local userIdSyaa = Players:GetUserIdFromNameAsync("tepresakkriminal")
        devAvaUrl = "rbxthumb://type=AvatarHeadShot&id="..userIdSyaa.."&w=150&h=150"
    end)
end)

-- ==========================================
-- LOADING
-- ==========================================
local function startLoading(callback)
    local loadBG = Instance.new("Frame")
    loadBG.Size = UDim2.new(0,280,0,140); loadBG.Position = UDim2.new(0.5,-140,0.5,-70)
    loadBG.BackgroundColor3 = Color3.fromRGB(10,5,15); loadBG.BackgroundTransparency = 0.15; loadBG.Parent = screenGui
    Instance.new("UICorner",loadBG).CornerRadius = UDim.new(0,15)
    local strokeL = Instance.new("UIStroke",loadBG); strokeL.Color = Color3.fromRGB(130,40,255); strokeL.Thickness = 2
    
    local titleL = Instance.new("TextLabel"); titleL.Text = "SYAA"; titleL.Size = UDim2.new(1,0,0,40); titleL.Position = UDim2.new(0,0,0,15); titleL.TextColor3 = Color3.fromRGB(255,255,255); titleL.Font = Enum.Font.GothamBold; titleL.TextSize = 32; titleL.BackgroundTransparency = 1; titleL.Parent = loadBG
    local percentLabel = Instance.new("TextLabel"); percentLabel.Text = "0%"; percentLabel.Size = UDim2.new(1,0,0,20); percentLabel.Position = UDim2.new(0,0,0,60); percentLabel.TextColor3 = Color3.fromRGB(180,100,255); percentLabel.Font = Enum.Font.Code; percentLabel.TextSize = 13; percentLabel.BackgroundTransparency = 1; percentLabel.Parent = loadBG
    local barOutline = Instance.new("Frame"); barOutline.Size = UDim2.new(0.7,0,0,4); barOutline.Position = UDim2.new(0.15,0,0,85); barOutline.BackgroundColor3 = Color3.fromRGB(20,20,20); barOutline.Parent = loadBG; Instance.new("UICorner",barOutline)
    local barFill = Instance.new("Frame"); barFill.Size = UDim2.new(0,0,1,0); barFill.BackgroundColor3 = Color3.fromRGB(150,50,255); barFill.BorderSizePixel = 0; barFill.Parent = barOutline; Instance.new("UICorner",barFill)
    local pLabel = Instance.new("TextLabel"); pLabel.Text = "Menyiapkan UI Syaa..."; pLabel.Size = UDim2.new(1,0,0,25); pLabel.Position = UDim2.new(0,0,0,100); pLabel.TextColor3 = Color3.fromRGB(255,255,255); pLabel.Font = Enum.Font.GothamBold; pLabel.TextSize = 10; pLabel.BackgroundTransparency = 1; pLabel.Parent = loadBG
    
    task.spawn(function()
        local progress = 0
        while progress < 100 do
            local step = math.random(2,6); progress = math.min(progress+step,100)
            TweenService:Create(barFill,TweenInfo.new(0.3),{Size=UDim2.new(progress/100,0,1,0)}):Play(); percentLabel.Text = progress.."%"
            task.wait(math.random(1,3)/10)
        end
        pLabel.Text = "Selesai 🗿"; task.wait(0.5)
        local closeTween = TweenService:Create(loadBG,TweenInfo.new(0.6,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut),{BackgroundTransparency=1,Size=UDim2.new(0,100,0,50),Position=UDim2.new(0.5,-50,0.5,-25)})
        TweenService:Create(strokeL,TweenInfo.new(0.5),{Transparency=1}):Play()
        TweenService:Create(titleL,TweenInfo.new(0.3),{TextTransparency=1}):Play()
        TweenService:Create(percentLabel,TweenInfo.new(0.3),{TextTransparency=1}):Play()
        TweenService:Create(pLabel,TweenInfo.new(0.3),{TextTransparency=1}):Play()
        TweenService:Create(barFill,TweenInfo.new(0.3),{BackgroundTransparency=1}):Play()
        TweenService:Create(barOutline,TweenInfo.new(0.3),{BackgroundTransparency=1}):Play()
        closeTween:Play(); closeTween.Completed:Wait(); loadBG:Destroy(); callback()
    end)
end

-- ==========================================
-- MAIN HUB
-- ==========================================
local function runSyaaHub()
    local openIcon = Instance.new("ImageButton")
    openIcon.Size = UDim2.new(0, 65, 0, 65) 
    openIcon.Position = UDim2.new(0, 30, 0.5, -32.5)
    openIcon.BackgroundTransparency = 1
    openIcon.Image = "rbxassetid://87411882585742"
    openIcon.ImageColor3 = Color3.fromRGB(0, 150, 255)
    openIcon.Visible = false 
    openIcon.Parent = screenGui

    local rainbowColor = Color3.fromRGB(150,40,255)
    task.spawn(function()
        while true do 
            local hue=tick()%5/5; rainbowColor=Color3.fromHSV(hue,0.8,1)
            openIcon.ImageColor3 = rainbowColor
            task.wait() 
        end
    end)

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

    -- UPDATE INFO GUI
    local updateFrame = Instance.new("Frame")
    updateFrame.Size = UDim2.new(0, 320, 0, 180)
    updateFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
    updateFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 20)
    updateFrame.BackgroundTransparency = 0.15
    updateFrame.Parent = screenGui
    Instance.new("UICorner", updateFrame).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", updateFrame).Color = Color3.fromRGB(150, 40, 255)

    local upTitle = Instance.new("TextLabel")
    upTitle.Text = "🚀 INFO UPDATE V7.6"
    upTitle.Size = UDim2.new(1, 0, 0, 40)
    upTitle.Position = UDim2.new(0, 0, 0, 5)
    upTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    upTitle.Font = Enum.Font.GothamBold
    upTitle.TextSize = 16
    upTitle.BackgroundTransparency = 1
    upTitle.Parent = updateFrame

    local upDesc = Instance.new("TextLabel")
    upDesc.Text = "• Merombak gui yang lebih minimalis\n• Menambahakan fitur fitur baru di mode freecam\n• Menghilangkan fitur fitur tertentu"
    upDesc.Size = UDim2.new(1, -30, 1, -95)
    upDesc.Position = UDim2.new(0, 15, 0, 45)
    upDesc.TextColor3 = Color3.fromRGB(220, 220, 220)
    upDesc.Font = Enum.Font.Gotham
    upDesc.TextSize = 12
    upDesc.TextXAlignment = Enum.TextXAlignment.Left
    upDesc.TextYAlignment = Enum.TextYAlignment.Top
    upDesc.BackgroundTransparency = 1
    upDesc.Parent = updateFrame

    local upBtn = Instance.new("TextButton")
    upBtn.Text = "GAS LANJUT 🗿"
    upBtn.Size = UDim2.new(0, 140, 0, 35)
    upBtn.Position = UDim2.new(0.5, -70, 1, -45)
    upBtn.BackgroundColor3 = Color3.fromRGB(130, 40, 255)
    upBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    upBtn.Font = Enum.Font.GothamBold
    upBtn.TextSize = 12
    upBtn.Parent = updateFrame
    Instance.new("UICorner", upBtn).CornerRadius = UDim.new(0, 8)

    local isInfoClosed = false
    local function closeInfoGui()
        if isInfoClosed then return end
        isInfoClosed = true

        local twOutInfo = TweenService:Create(updateFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
        twOutInfo:Play()
        twOutInfo.Completed:Wait()
        updateFrame:Destroy()

        openIcon.Visible = true
        openIcon.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(openIcon, TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {Size = UDim2.new(0, 65, 0, 65)}):Play()

        -- NOTIFICATION SYSTEM 
        task.spawn(function()
            local notifFrame = Instance.new("Frame")
            notifFrame.Size = UDim2.new(0, 280, 0, 75)
            notifFrame.Position = UDim2.new(1, 20, 1, -90) 
            notifFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 20)
            notifFrame.BackgroundTransparency = 0.15
            notifFrame.Parent = screenGui
            Instance.new("UICorner", notifFrame).CornerRadius = UDim.new(0, 10)
            Instance.new("UIStroke", notifFrame).Color = Color3.fromRGB(150, 40, 255)

            local ava = Instance.new("ImageLabel")
            ava.Size = UDim2.new(0, 55, 0, 55)
            ava.Position = UDim2.new(0, 10, 0, 10)
            ava.BackgroundTransparency = 1
            ava.Parent = notifFrame
            Instance.new("UICorner", ava).CornerRadius = UDim.new(1, 0)
            ava.Image = devAvaUrl

            local nameLbl = Instance.new("TextLabel")
            nameLbl.Text = "Syaa"
            nameLbl.Size = UDim2.new(0, 100, 0, 20)
            nameLbl.Position = UDim2.new(0, 75, 0, 10)
            nameLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameLbl.Font = Enum.Font.GothamBold
            nameLbl.TextSize = 14
            nameLbl.BackgroundTransparency = 1
            nameLbl.TextXAlignment = Enum.TextXAlignment.Left
            nameLbl.Parent = notifFrame

            local titleLbl = Instance.new("TextLabel")
            titleLbl.Text = "Developer"
            titleLbl.Size = UDim2.new(0, 100, 0, 15)
            titleLbl.Position = UDim2.new(0, 75, 0, 30)
            titleLbl.TextColor3 = Color3.fromRGB(150, 40, 255)
            titleLbl.Font = Enum.Font.GothamBold
            titleLbl.TextSize = 11
            titleLbl.BackgroundTransparency = 1
            titleLbl.TextXAlignment = Enum.TextXAlignment.Left
            titleLbl.Parent = notifFrame

            local descLbl = Instance.new("TextLabel")
            descLbl.Text = "Hallo " .. localPlayer.DisplayName .. ", selamat datang di syaa hub"
            descLbl.Size = UDim2.new(1, -85, 0, 20)
            descLbl.Position = UDim2.new(0, 75, 0, 48)
            descLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
            descLbl.Font = Enum.Font.Gotham
            descLbl.TextSize = 10
            descLbl.BackgroundTransparency = 1
            descLbl.TextXAlignment = Enum.TextXAlignment.Left
            descLbl.Parent = notifFrame

            local twIn = TweenService:Create(notifFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(1, -300, 1, -90)})
            twIn:Play()
            task.wait(5) 
            local twOut = TweenService:Create(notifFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(1, 20, 1, -90)})
            twOut:Play()
            twOut.Completed:Wait()
            notifFrame:Destroy()
        end)
    end

    upBtn.MouseButton1Click:Connect(closeInfoGui)
    task.delay(4, closeInfoGui)

    -- VARIABLES & ENGINE
    local isFreecamActive = false
    local lockTarget = nil
    local isLockOn = false
    local moveSpeed = 15
    local targetFov = 70
    local targetYaw, targetPitch = 0, 0
    local displayYaw, displayPitch = 0, 0
    local moveInputs = {F=0,B=0,L=0,R=0,U=0,D=0}
    local zoomInputs = {In=0,Out=0}
    local smoothValue = 50
    local autoWalkActive = false
    local autoWalkDirection = 0
    local autoWalkSpeed = 10
    local cinematicActive = false
    local blurAmount = 20
    local focusedPlayers = {}
    local blurEffect = nil
    local depthOfField = nil
    local cinematicConn = nil

    local PlayerModule = require(localPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()

    -- ==========================================
    -- SHIFTLOCK (ICON & LOGIC)
    -- ==========================================
    local shiftlockBtn = Instance.new("ImageButton")
    shiftlockBtn.Size = UDim2.new(0, 85, 0, 85) 
    shiftlockBtn.AnchorPoint = Vector2.new(0.5, 0.5) -- Biar slider X/Y posisinya presisi di tengah
    shiftlockBtn.Position = UDim2.new(0.9, 0, 0.5, 0)
    shiftlockBtn.BackgroundTransparency = 1
    shiftlockBtn.Image = "rbxassetid://117791842859124"
    shiftlockBtn.ImageColor3 = Color3.fromRGB(255,255,255)
    shiftlockBtn.ScaleType = Enum.ScaleType.Fit
    shiftlockBtn.Visible = false -- Default mati, dinyalain dari Tab Freecam
    shiftlockBtn.Parent = screenGui
    Instance.new("UICorner", shiftlockBtn).CornerRadius = UDim.new(1, 0)

    local isShiftlockActive = false
    local shiftlockConn = nil

    local function applyShiftlock()
        local char = localPlayer.Character
        if not char then return end
        local humanoid = char:FindFirstChild("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        if humanoid then humanoid.AutoRotate = false end
        
        if shiftlockConn then shiftlockConn:Disconnect() end
        shiftlockConn = RunService.RenderStepped:Connect(function()
            if isShiftlockActive and root then
                local camLook = Camera.CFrame.LookVector
                local direction = Vector3.new(camLook.X, 0, camLook.Z)
                if direction.Magnitude > 0 then
                    root.CFrame = CFrame.new(root.Position, root.Position + direction)
                end
            end
        end)
    end

    local function disableShiftlock()
        local char = localPlayer.Character
        if not char then return end
        local humanoid = char:FindFirstChild("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        
        if humanoid then humanoid.AutoRotate = true end
        if shiftlockConn then shiftlockConn:Disconnect(); shiftlockConn = nil end
        if root then
            local look = Camera.CFrame.LookVector
            root.CFrame = CFrame.new(root.Position, root.Position + Vector3.new(look.X,0,look.Z))
        end
    end

    shiftlockBtn.MouseButton1Click:Connect(function()
        isShiftlockActive = not isShiftlockActive
        if isShiftlockActive then
            shiftlockBtn.ImageColor3 = Color3.fromRGB(0,170,255)
            applyShiftlock()
        else
            shiftlockBtn.ImageColor3 = Color3.fromRGB(255,255,255)
            disableShiftlock()
        end
    end)

    localPlayer.CharacterAdded:Connect(function(char)
        if isShiftlockActive then
            char:WaitForChild("Humanoid")
            char:WaitForChild("HumanoidRootPart")
            task.wait(0.2)
            applyShiftlock()
        end
    end)

    -- ==========================================
    -- MAIN FRAME
    -- ==========================================
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0,360,0,240) 
    mainFrame.Position = UDim2.new(0.5,-180,0.5,-120)
    mainFrame.BackgroundColor3 = Color3.fromRGB(10,5,15)
    mainFrame.BackgroundTransparency = 0.15
    mainFrame.Visible = false
    mainFrame.Parent = screenGui
    mainFrame.ClipsDescendants = false 
    Instance.new("UICorner",mainFrame).CornerRadius = UDim.new(0,12)
    
    local mainStroke = Instance.new("UIStroke",mainFrame); mainStroke.Thickness = 2.5
    local themeColors = {Color3.fromRGB(150,40,255), Color3.fromRGB(0,0,0), Color3.fromRGB(255,255,255)}
    task.spawn(function()
        local cIdx = 1
        mainStroke.Color = themeColors[1]
        while true do
            cIdx = cIdx % 3 + 1
            local tw = TweenService:Create(mainStroke, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {Color = themeColors[cIdx]})
            tw:Play(); tw.Completed:Wait()
        end
    end)

    local playerIconTop = Instance.new("ImageLabel")
    playerIconTop.Size = UDim2.new(0, 24, 0, 24)
    playerIconTop.Position = UDim2.new(0, 15, 0, 8)
    playerIconTop.BackgroundTransparency = 1
    playerIconTop.Image = playerAvaUrl
    playerIconTop.Parent = mainFrame
    Instance.new("UICorner", playerIconTop).CornerRadius = UDim.new(1, 0)

    local title = Instance.new("TextLabel")
    title.Text = localPlayer.DisplayName .. " - Syaa Hub" 
    title.Size = UDim2.new(1, -60, 0, 30)
    title.Position = UDim2.new(0, 48, 0, 5)
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 13 
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.BackgroundTransparency = 1
    title.Parent = mainFrame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0,26,0,26)
    closeBtn.Position = UDim2.new(1,-34,0,8)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255,50,50)
    closeBtn.BackgroundColor3 = Color3.fromRGB(30,15,40)
    closeBtn.BackgroundTransparency = 0.4
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 12
    closeBtn.Parent = mainFrame
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,6)
    closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0,26,0,26)
    minBtn.Position = UDim2.new(1,-66,0,8)
    minBtn.Text = "−"
    minBtn.TextColor3 = Color3.fromRGB(255,255,255)
    minBtn.BackgroundColor3 = Color3.fromRGB(30,15,40)
    minBtn.BackgroundTransparency = 0.4
    minBtn.Font = Enum.Font.GothamBold
    minBtn.TextSize = 16
    minBtn.Parent = mainFrame
    Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0,6)

    local tabPanels = {}; local activeTab = nil
    local function setTab(name)
        activeTab = name
        for n, panel in pairs(tabPanels) do panel.Visible = (n == name) end
    end

    local function toggleMainFrame(state)
        if state then
            local tweenOutIcon = TweenService:Create(openIcon, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
            tweenOutIcon:Play()
            tweenOutIcon.Completed:Wait()
            openIcon.Visible = false
            
            mainFrame.Visible = true
            mainFrame.Size = UDim2.new(0, 180, 0, 120)
            TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 360, 0, 240)}):Play()
            if activeTab==nil then setTab("Freecam") end
        else
            local tw = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 90, 0, 50)})
            tw:Play()
            tw.Completed:Connect(function()
                mainFrame.Visible = false
                openIcon.Visible = true
                openIcon.Size = UDim2.new(0, 0, 0, 0)
                TweenService:Create(openIcon, TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {Size = UDim2.new(0, 65, 0, 65)}):Play()
            end)
        end
    end

    minBtn.MouseButton1Click:Connect(function() toggleMainFrame(false) end)
    openIcon.MouseButton1Click:Connect(function() toggleMainFrame(true) end)

    -- ==========================================
    -- SIDEBAR 
    -- ==========================================
    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 42, 0, 180) 
    sidebar.Position = UDim2.new(0, -52, 0.5, -90)
    sidebar.BackgroundColor3 = Color3.fromRGB(10,5,15)
    sidebar.BackgroundTransparency = 0.2
    sidebar.Parent = mainFrame
    Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", sidebar).Color = Color3.fromRGB(130,40,255)

    local function makeSidebarIcon(assetId, yPos, tabName, customSize)
        local btn = Instance.new("ImageButton")
        btn.Size = customSize
        btn.Position = UDim2.new(0.5, -(btn.Size.X.Offset/2), 0, yPos)
        btn.BackgroundTransparency = 1
        btn.Image = assetId
        btn.ImageColor3 = Color3.fromRGB(150, 40, 255)
        btn.Parent = sidebar
        
        task.spawn(function()
            while true do
                TweenService:Create(btn, TweenInfo.new(1.5), {ImageColor3 = Color3.fromRGB(255,255,255)}):Play()
                task.wait(1.5)
                TweenService:Create(btn, TweenInfo.new(1.5), {ImageColor3 = Color3.fromRGB(150,40,255)}):Play()
                task.wait(1.5)
            end
        end)
        btn.MouseButton1Click:Connect(function() setTab(tabName) end)
    end
    
    makeSidebarIcon("rbxassetid://76171785807172", 12, "Freecam", UDim2.new(0, 26, 0, 26))
    makeSidebarIcon("rbxassetid://116019702436521", 52, "Orientation", UDim2.new(0, 34, 0, 34))
    makeSidebarIcon("rbxassetid://112703342701931", 96, "Tools", UDim2.new(0, 30, 0, 30))
    makeSidebarIcon(ICON_SIDEBAR_AI, 138, "AI", UDim2.new(0, 30, 0, 30)) 

    -- ==========================================
    -- PANELS CREATION
    -- ==========================================
    local function createPanel(name)
        local panel = Instance.new("ScrollingFrame")
        panel.Name = "Panel_"..name
        panel.Size = UDim2.new(1,-20,1,-45)
        panel.Position = UDim2.new(0,10,0,40)
        panel.BackgroundTransparency = 1
        panel.ScrollBarThickness = 3
        panel.ScrollBarImageColor3 = Color3.fromRGB(150,40,255)
        panel.ScrollBarImageTransparency = 0.2
        panel.AutomaticCanvasSize = Enum.AutomaticSize.Y
        panel.CanvasSize = UDim2.new(0,0,0,0)
        panel.ScrollingDirection = Enum.ScrollingDirection.Y
        panel.Visible = false
        panel.Parent = mainFrame
        tabPanels[name] = panel
        return panel
    end

    local pFC = createPanel("Freecam")
    local pOR = createPanel("Orientation")
    local pTools = createPanel("Tools")
    local pAI = createPanel("AI") 
    
    pAI.Size = UDim2.new(1, -20, 1, -85)

    -- HELPERS
    local function makeIosRow(labelTxt, yOff, parent)
        local onColor = Color3.fromRGB(150,40,255)
        local row = Instance.new("TextButton"); row.Size = UDim2.new(1,-8,0,30); row.Position = UDim2.new(0,4,0,yOff); row.BackgroundColor3 = Color3.fromRGB(130,40,255); row.BackgroundTransparency = 0.6; row.Text = ""; row.AutoButtonColor = false; row.Parent = parent
        Instance.new("UICorner",row).CornerRadius = UDim.new(0,8)
        local lbl = Instance.new("TextLabel"); lbl.Text = labelTxt; lbl.Size = UDim2.new(1,-50,1,0); lbl.Position = UDim2.new(0,10,0,0); lbl.BackgroundTransparency = 1; lbl.TextColor3 = Color3.fromRGB(255,255,255); lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 10; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.Parent = row
        local track = Instance.new("Frame"); track.Size = UDim2.new(0,36,0,18); track.Position = UDim2.new(1,-42,0.5,-9); track.BackgroundColor3 = Color3.fromRGB(10,5,10); track.Parent = row; Instance.new("UICorner",track).CornerRadius = UDim.new(1,0); Instance.new("UIStroke",track).Color = Color3.fromRGB(80,20,120)
        local knob = Instance.new("Frame"); knob.Size = UDim2.new(0,14,0,14); knob.Position = UDim2.new(0,2,0.5,-7); knob.BackgroundColor3 = Color3.fromRGB(255,255,255); knob.Parent = track; Instance.new("UICorner",knob).CornerRadius = UDim.new(1,0)
        local isOn = false
        local function setState(v)
            isOn = v
            if v then TweenService:Create(track,TweenInfo.new(0.2,Enum.EasingStyle.Quad),{BackgroundColor3=onColor}):Play(); TweenService:Create(knob,TweenInfo.new(0.18,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(1,-16,0.5,-7)}):Play()
            else TweenService:Create(track,TweenInfo.new(0.2,Enum.EasingStyle.Quad),{BackgroundColor3=Color3.fromRGB(10,5,10)}):Play(); TweenService:Create(knob,TweenInfo.new(0.18,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(0,2,0.5,-7)}):Play() end
        end
        return row, setState, function() return isOn end
    end
    local function makeLbl(txt,yOff,parent,sz,col)
        local l = Instance.new("TextLabel"); l.Text = txt; l.Size = UDim2.new(1,0,0,sz or 14); l.Position = UDim2.new(0,6,0,yOff); l.TextColor3 = col or Color3.fromRGB(220,220,220); l.BackgroundTransparency = 1; l.Font = Enum.Font.GothamBold; l.TextSize = 10; l.TextXAlignment = Enum.TextXAlignment.Left; l.Parent = parent; return l
    end
    local function makeSepHdr(txt,yOff,parent)
        local sep = Instance.new("Frame"); sep.Size = UDim2.new(0.92,0,0,1); sep.Position = UDim2.new(0.04,0,0,yOff-2); sep.BackgroundColor3 = Color3.fromRGB(80,30,120); sep.BorderSizePixel = 0; sep.Parent = parent
        return makeLbl(txt,yOff+2,parent,12,Color3.fromRGB(180,100,255))
    end
    local function makeBtn2(tA,tB,yOff,parent)
        local function b(txt,xS)
            local btn = Instance.new("TextButton"); btn.Text = txt; btn.Size = UDim2.new(0.44,0,0,26); btn.Position = UDim2.new(xS,0,0,yOff); btn.BackgroundColor3 = Color3.fromRGB(130,40,255); btn.BackgroundTransparency = 0.5; btn.TextColor3 = Color3.fromRGB(255,255,255); btn.Font = Enum.Font.GothamBold; btn.TextSize = 10; btn.Parent = parent; Instance.new("UICorner",btn).CornerRadius = UDim.new(0,6); return btn
        end
        return b(tA,0.04), b(tB,0.52)
    end
    local function makeBtn3(tA,tB,tC,yOff,parent)
        local function b(txt,xS)
            local btn = Instance.new("TextButton"); btn.Text = txt; btn.Size = UDim2.new(0.29,0,0,26); btn.Position = UDim2.new(xS,0,0,yOff); btn.BackgroundColor3 = Color3.fromRGB(130,40,255); btn.BackgroundTransparency = 0.5; btn.TextColor3 = Color3.fromRGB(255,255,255); btn.Font = Enum.Font.GothamBold; btn.TextSize = 10; btn.Parent = parent; Instance.new("UICorner",btn).CornerRadius = UDim.new(0,6); return btn
        end
        return b(tA,0.04), b(tB,0.355), b(tC,0.67)
    end

    -- ==========================================
    -- PANEL TOOLS 
    -- ==========================================
    local tY = 2
    makeSepHdr("PLAYER MODS", tY, pTools); tY = tY+22
    
    -- TOMBOL LOAD FLY (SIMPLE)
    local flyBtn = Instance.new("TextButton")
    flyBtn.Text = "🚀 Load Fly"
    flyBtn.Size = UDim2.new(0.92,0,0,30)
    flyBtn.Position = UDim2.new(0.04,0,0,tY)
    flyBtn.BackgroundColor3 = Color3.fromRGB(130,40,255)
    flyBtn.BackgroundTransparency = 0.5
    flyBtn.TextColor3 = Color3.fromRGB(255,255,255)
    flyBtn.Font = Enum.Font.GothamBold
    flyBtn.TextSize = 10
    flyBtn.Parent = pTools
    Instance.new("UICorner", flyBtn).CornerRadius = UDim.new(0,6)
    tY = tY + 36

    flyBtn.MouseButton1Click:Connect(function()
        pcall(function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Brookhaven-RP-Fly-v1-27423"))()
        end)
    end)
    
    local infJumpRow, setInfJump = makeIosRow("Unlimited Jump", tY, pTools); tY = tY+36
    local isInfJump = false
    infJumpRow.MouseButton1Click:Connect(function() isInfJump = not isInfJump; setInfJump(isInfJump) end)
    UserInputService.JumpRequest:Connect(function() if isInfJump and localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid") then localPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping) end end)

    local wsRow, setWsState = makeIosRow("Enable WalkSpeed", tY, pTools); tY = tY+36
    local wsVal = 16
    local wsLab = makeLbl("Speed: 16", tY, pTools, 14); tY = tY+16
    local wsBg = Instance.new("Frame"); wsBg.Size = UDim2.new(0.88,0,0,4); wsBg.Position = UDim2.new(0.06,0,0,tY); wsBg.BackgroundColor3 = Color3.fromRGB(30,20,40); wsBg.Parent = pTools; Instance.new("UICorner",wsBg)
    local wsFill = Instance.new("Frame"); wsFill.Size = UDim2.new((16/200),0,1,0); wsFill.BackgroundColor3 = Color3.fromRGB(150,40,255); wsFill.BorderSizePixel = 0; wsFill.Parent = wsBg; Instance.new("UICorner",wsFill)
    local wsKnob = Instance.new("TextButton"); wsKnob.Size = UDim2.new(0,14,0,14); wsKnob.Position = UDim2.new((16/200),-7,0.5,-7); wsKnob.Text = ""; wsKnob.BackgroundColor3 = Color3.fromRGB(255,255,255); wsKnob.Parent = wsBg; Instance.new("UICorner",wsKnob).CornerRadius = UDim.new(1,0)
    tY = tY+18
    local wsSld = false
    wsKnob.MouseButton1Down:Connect(function() wsSld=true end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then wsSld=false end end)
    UserInputService.InputChanged:Connect(function(i) if wsSld and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local pos = math.clamp((i.Position.X-wsBg.AbsolutePosition.X)/wsBg.AbsoluteSize.X,0,1); wsFill.Size = UDim2.new(pos,0,1,0); wsKnob.Position = UDim2.new(pos,-7,0.5,-7); wsVal = math.floor(pos*200); if wsVal < 16 then wsVal = 16 end wsLab.Text = "Speed: "..wsVal end end)
    local isWsEnabled = false
    wsRow.MouseButton1Click:Connect(function() isWsEnabled = not isWsEnabled; setWsState(isWsEnabled) end)
    RunService.Heartbeat:Connect(function() if isWsEnabled and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then localPlayer.Character.Humanoid.WalkSpeed = wsVal end end)

    makeSepHdr("TELEPORT PLAYER", tY, pTools); tY = tY+22
    local tpRefresh = Instance.new("TextButton"); tpRefresh.Text = "↺ Refresh List"; tpRefresh.Size = UDim2.new(0.92,0,0,26); tpRefresh.Position = UDim2.new(0.04,0,0,tY); tpRefresh.BackgroundColor3 = Color3.fromRGB(130,40,255); tpRefresh.BackgroundTransparency = 0.5; tpRefresh.TextColor3 = Color3.fromRGB(255,255,255); tpRefresh.Font = Enum.Font.GothamBold; tpRefresh.TextSize = 10; tpRefresh.Parent = pTools; Instance.new("UICorner",tpRefresh).CornerRadius = UDim.new(0,6)
    tY = tY+32
    local tpFrame = Instance.new("ScrollingFrame"); tpFrame.Size = UDim2.new(0.92,0,0,80); tpFrame.Position = UDim2.new(0.04,0,0,tY); tpFrame.BackgroundColor3 = Color3.fromRGB(10,5,15); tpFrame.BackgroundTransparency = 0.5; tpFrame.Parent = pTools; tpFrame.ScrollBarThickness = 2; tpFrame.ScrollBarImageColor3 = Color3.fromRGB(150,40,255); tpFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y; tpFrame.ScrollingDirection = Enum.ScrollingDirection.Y; Instance.new("UICorner",tpFrame); Instance.new("UIStroke",tpFrame).Color = Color3.fromRGB(80,30,120)
    local tpLayout = Instance.new("UIListLayout",tpFrame); tpLayout.Padding = UDim.new(0,2); tpLayout.SortOrder = Enum.SortOrder.Name
    tY = tY+90
    local tpRows = {}
    local function refreshTpList() for _,r in pairs(tpRows) do pcall(function() r:Destroy() end) end; tpRows = {}; local list = Players:GetPlayers(); if #list <= 1 then local el = Instance.new("TextLabel"); el.Size = UDim2.new(1,0,0,24); el.BackgroundTransparency = 1; el.Text = "Cuma lu doang 🗿"; el.TextColor3 = Color3.fromRGB(100,100,100); el.Font = Enum.Font.Gotham; el.TextSize = 10; el.Parent = tpFrame; table.insert(tpRows,el); return end
        for _,p in ipairs(list) do if p ~= localPlayer then local row = Instance.new("TextButton"); row.Size = UDim2.new(1,0,0,30); row.BackgroundColor3 = Color3.fromRGB(130,40,255); row.BackgroundTransparency = 0.6; row.Text = ""; row.AutoButtonColor = false; row.Parent = tpFrame; Instance.new("UICorner",row); local ava = Instance.new("ImageLabel"); ava.Size = UDim2.new(0, 24, 0, 24); ava.Position = UDim2.new(0, 4, 0.5, -12); ava.BackgroundTransparency = 1; ava.Parent = row; Instance.new("UICorner",ava).CornerRadius = UDim.new(1,0); task.spawn(function() pcall(function() ava.Image = Players:GetUserThumbnailAsync(p.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48) end) end)
                local nl = Instance.new("TextLabel"); nl.Size = UDim2.new(1,-36,1,0); nl.Position = UDim2.new(0,32,0,0); nl.BackgroundTransparency = 1; nl.Text = p.DisplayName.." (@"..p.Name..")"; nl.TextColor3 = Color3.fromRGB(220,220,220); nl.Font = Enum.Font.GothamBold; nl.TextSize = 10; nl.TextXAlignment = Enum.TextXAlignment.Left; nl.Parent = row
                row.MouseButton1Click:Connect(function() if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then localPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame end end); table.insert(tpRows,row) end end end
    tpRefresh.MouseButton1Click:Connect(refreshTpList); task.spawn(function() task.wait(1) refreshTpList() end)

    makeSepHdr("3D IMAGE SPAWNER", tY, pTools); tY = tY+22
    local imgInput = Instance.new("TextBox"); imgInput.Size = UDim2.new(0.92, 0, 0, 30); imgInput.Position = UDim2.new(0.04, 0, 0, tY); imgInput.BackgroundColor3 = Color3.fromRGB(20, 10, 30); imgInput.TextColor3 = Color3.fromRGB(255, 255, 255); imgInput.PlaceholderText = "Masukkan ID Gambar..."; imgInput.Font = Enum.Font.GothamBold; imgInput.TextSize = 11; imgInput.Parent = pTools; Instance.new("UICorner", imgInput); Instance.new("UIStroke", imgInput).Color = Color3.fromRGB(130,40,255)
    tY = tY + 36
    local spwBtn, saveBtn = makeBtn2("Spawn 3D", "Save (Unselect)", tY, pTools); tY = tY + 32
    makeLbl("Daftar Gambar (Klik buat ngedit):", tY, pTools, 12); tY = tY+16
    local imgListFrame = Instance.new("ScrollingFrame"); imgListFrame.Size = UDim2.new(0.92,0,0,70); imgListFrame.Position = UDim2.new(0.04,0,0,tY); imgListFrame.BackgroundColor3 = Color3.fromRGB(10,5,15); imgListFrame.BackgroundTransparency = 0.5; imgListFrame.Parent = pTools; imgListFrame.ScrollBarThickness = 2; imgListFrame.ScrollBarImageColor3 = Color3.fromRGB(150,40,255); imgListFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y; imgListFrame.ScrollingDirection = Enum.ScrollingDirection.Y; Instance.new("UICorner",imgListFrame); Instance.new("UIStroke",imgListFrame).Color = Color3.fromRGB(80,30,120)
    local ilLayout = Instance.new("UIListLayout",imgListFrame); ilLayout.Padding = UDim.new(0,2)
    tY = tY + 80
    local btnScaleUp, btnScaleDown, clrBtn = makeBtn3("Besarin (+)", "Kecilin (-)", "Hapus", tY, pTools); tY = tY + 32
    makeLbl("🕹️ Kontrol Posisi & Rotasi", tY, pTools, 14); tY = tY+16
    local btnLeft, btnUp, btnRight = makeBtn3("Kiri", "Atas", "Kanan", tY, pTools); tY = tY + 32
    local btnBack, btnDown, btnFwd = makeBtn3("Mundur", "Bawah", "Maju", tY, pTools); tY = tY + 32
    local btnRotL, btnRotUp, btnRotR = makeBtn3("Putar Kiri", "Putar Atas", "Putar Kanan", tY, pTools); tY = tY + 32
    local btnTiltL, btnRotDown, btnTiltR = makeBtn3("Miring Kiri", "Putar Bawah", "Miring Kanan", tY, pTools); tY = tY + 32
    local spawnedImages, activeImage, imgCount, listRows = {}, nil, 0, {}
    local function refreshImgList() for _,r in pairs(listRows) do pcall(function() r:Destroy() end) end; listRows = {}
        for i, data in ipairs(spawnedImages) do local isAct = (activeImage == data.part); local row = Instance.new("TextButton"); row.Size = UDim2.new(1,0,0,24); row.BackgroundColor3 = isAct and Color3.fromRGB(200,80,255) or Color3.fromRGB(80,30,120); row.BackgroundTransparency = 0.5; row.Text = (isAct and "◉ " or "○ ")..data.name; row.TextColor3 = Color3.fromRGB(255,255,255); row.Font = Enum.Font.GothamBold; row.TextSize = 10; row.Parent = imgListFrame; Instance.new("UICorner",row); row.MouseButton1Click:Connect(function() activeImage = data.part; refreshImgList() end); table.insert(listRows, row) end end
    spwBtn.MouseButton1Click:Connect(function() local idText = imgInput.Text:gsub("%D", ""); if idText == "" then return end; local char = localPlayer.Character; if not char or not char:FindFirstChild("HumanoidRootPart") then return end; local hrp = char.HumanoidRootPart; imgCount = imgCount + 1; local p = Instance.new("Part"); p.Name = "Syaa3DImage_"..imgCount; p.Size = Vector3.new(6, 6, 0.1); p.Anchored, p.CanCollide, p.Massless = true, false, true; p.Color, p.Transparency = Color3.fromRGB(0,0,0), 1; local frontCFrame = hrp.CFrame * CFrame.new(0, 0, -5); p.CFrame = CFrame.lookAt(frontCFrame.Position, hrp.Position); local realUrl = "rbxthumb://type=Asset&id="..idText.."&w=420&h=420"; local d1 = Instance.new("Decal"); d1.Face, d1.Texture = Enum.NormalId.Front, realUrl; d1.Parent = p; local d2 = Instance.new("Decal"); d2.Face, d2.Texture = Enum.NormalId.Back, realUrl; d2.Parent = p; p.Parent = workspace; table.insert(spawnedImages, {id = idText, part = p, name = "Gambar ID: "..string.sub(idText, 1, 5)..".."}); activeImage = p; refreshImgList() end)
    saveBtn.MouseButton1Click:Connect(function() activeImage = nil; refreshImgList() end)
    clrBtn.MouseButton1Click:Connect(function() if activeImage then activeImage:Destroy(); for i, data in ipairs(spawnedImages) do if data.part == activeImage then table.remove(spawnedImages, i); break end end; activeImage = nil; refreshImgList() end end)
    btnScaleUp.MouseButton1Click:Connect(function() if activeImage then activeImage.Size = activeImage.Size + Vector3.new(0.5, 0.5, 0) end end)
    btnScaleDown.MouseButton1Click:Connect(function() if activeImage then activeImage.Size = Vector3.new(math.max(0.5, activeImage.Size.X - 0.5), math.max(0.5, activeImage.Size.Y - 0.5), 0.1) end end)
    local function mod3D(cf) if activeImage then activeImage.CFrame = activeImage.CFrame * cf end end
    btnLeft.MouseButton1Click:Connect(function() mod3D(CFrame.new(0.5, 0, 0)) end); btnRight.MouseButton1Click:Connect(function() mod3D(CFrame.new(-0.5, 0, 0)) end); btnUp.MouseButton1Click:Connect(function() mod3D(CFrame.new(0, 0.5, 0)) end); btnDown.MouseButton1Click:Connect(function() mod3D(CFrame.new(0, -0.5, 0)) end); btnFwd.MouseButton1Click:Connect(function() mod3D(CFrame.new(0, 0, 0.5)) end); btnBack.MouseButton1Click:Connect(function() mod3D(CFrame.new(0, 0, -0.5)) end); btnRotL.MouseButton1Click:Connect(function() mod3D(CFrame.Angles(0, math.rad(15), 0)) end); btnRotR.MouseButton1Click:Connect(function() mod3D(CFrame.Angles(0, math.rad(-15), 0)) end); btnTiltL.MouseButton1Click:Connect(function() mod3D(CFrame.Angles(0, 0, math.rad(15))) end); btnTiltR.MouseButton1Click:Connect(function() mod3D(CFrame.Angles(0, 0, math.rad(-15))) end); btnRotUp.MouseButton1Click:Connect(function() mod3D(CFrame.Angles(math.rad(15), 0, 0)) end); btnRotDown.MouseButton1Click:Connect(function() mod3D(CFrame.Angles(math.rad(-15), 0, 0)) end)
    local tPad = Instance.new("Frame"); tPad.Size = UDim2.new(1,0,0,40); tPad.Position = UDim2.new(0,0,0,tY); tPad.BackgroundTransparency = 1; tPad.Parent = pTools

    -- ==========================================
    -- PANEL FREECAM
    -- ==========================================
    local Y = 2
    local camRow, setCamState, getCamState = makeIosRow("Camera", Y, pFC); Y = Y+36
    local hudRow, setHudState, getHudState = makeIosRow("Show HUD", Y, pFC); Y = Y+36
    local lockRow, setLockState, getLockState = makeIosRow("Lock Target", Y, pFC); Y = Y+36
    local sLbl = makeLbl("Smoothness: 50", Y, pFC); Y = Y+16
    local sBg = Instance.new("Frame"); sBg.Size = UDim2.new(0.88,0,0,4); sBg.Position = UDim2.new(0.06,0,0,Y); sBg.BackgroundColor3 = Color3.fromRGB(30,20,40); sBg.Parent = pFC; Instance.new("UICorner",sBg)
    local sFill = Instance.new("Frame"); sFill.Size = UDim2.new(0.5,0,1,0); sFill.BackgroundColor3 = Color3.fromRGB(150,40,255); sFill.BorderSizePixel = 0; sFill.Parent = sBg; Instance.new("UICorner",sFill)
    local sBtn = Instance.new("TextButton"); sBtn.Size = UDim2.new(0,14,0,14); sBtn.Position = UDim2.new(0.5,-7,0.5,-7); sBtn.Text = ""; sBtn.BackgroundColor3 = Color3.fromRGB(255,255,255); sBtn.Parent = sBg; Instance.new("UICorner",sBtn).CornerRadius = UDim.new(1,0)
    Y = Y+18
    local sSliding = false
    sBtn.MouseButton1Down:Connect(function() sSliding=true end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then sSliding=false end end)
    UserInputService.InputChanged:Connect(function(i) if sSliding and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local pos = math.clamp((i.Position.X-sBg.AbsolutePosition.X)/sBg.AbsoluteSize.X,0,1); sFill.Size = UDim2.new(pos,0,1,0); sBtn.Position = UDim2.new(pos,-7,0.5,-7); smoothValue = math.floor(pos*100); sLbl.Text = "Smoothness: "..smoothValue end end)
    local spLbl = makeLbl("Speed: 15", Y, pFC); Y = Y+16
    local spMinus, spPlus = makeBtn2("−","+",Y,pFC); Y = Y+32
    spMinus.MouseButton1Click:Connect(function() moveSpeed=math.clamp(moveSpeed-5,1,500); spLbl.Text="Speed: "..moveSpeed end)
    spPlus.MouseButton1Click:Connect(function() moveSpeed=math.clamp(moveSpeed+5,1,500); spLbl.Text="Speed: "..moveSpeed end)
    makeSepHdr("Auto-Walk", Y, pFC); Y = Y+18
    local awSpdLab = makeLbl("AW Speed: 10", Y, pFC, 14); Y = Y+16
    local awFwd, awStop, awBack = makeBtn3("Maju","Stop","Mundur",Y,pFC); Y = Y+32
    local awSpdD, _awMid, awSpdU = makeBtn3("−","","＋",Y,pFC); Y = Y+32
    _awMid.BackgroundTransparency = 1
    local cOff, cOn = Color3.fromRGB(130,40,255), Color3.fromRGB(200,100,255)
    awFwd.MouseButton1Click:Connect(function() autoWalkActive, autoWalkDirection = true, 1; awFwd.BackgroundColor3, awStop.BackgroundColor3, awBack.BackgroundColor3 = cOn, cOff, cOff end)
    awStop.MouseButton1Click:Connect(function() autoWalkActive, autoWalkDirection = false, 0; moveInputs.F, moveInputs.B = 0, 0; awFwd.BackgroundColor3, awStop.BackgroundColor3, awBack.BackgroundColor3 = cOff, Color3.fromRGB(50,50,50), cOff end)
    awBack.MouseButton1Click:Connect(function() autoWalkActive, autoWalkDirection = true, -1; awFwd.BackgroundColor3, awStop.BackgroundColor3, awBack.BackgroundColor3 = cOff, cOff, cOn end)
    awSpdD.MouseButton1Click:Connect(function() autoWalkSpeed=math.max(autoWalkSpeed-5,1); awSpdLab.Text="AW Speed: "..autoWalkSpeed end)
    awSpdU.MouseButton1Click:Connect(function() autoWalkSpeed=math.min(autoWalkSpeed+5,200); awSpdLab.Text="AW Speed: "..autoWalkSpeed end)
    RunService.Heartbeat:Connect(function() if autoWalkActive and autoWalkDirection~=0 then moveInputs.F, moveInputs.B = math.max(0,autoWalkDirection), math.max(0,-autoWalkDirection) end end)
    makeSepHdr("CINEMATIC MODE", Y, pFC); Y = Y+18
    local cinRow, setCinState, getCinState = makeIosRow("Cinematic ON/OFF", Y, pFC); Y = Y+36
    local blurLab = makeLbl("Blur Intensity: 20", Y, pFC, 14); Y = Y+16
    local blBg = Instance.new("Frame"); blBg.Size = UDim2.new(0.88,0,0,4); blBg.Position = UDim2.new(0.06,0,0,Y); blBg.BackgroundColor3 = Color3.fromRGB(30,20,40); blBg.Parent = pFC; Instance.new("UICorner",blBg)
    local blFill = Instance.new("Frame"); blFill.Size = UDim2.new(blurAmount/56,0,1,0); blFill.BackgroundColor3 = Color3.fromRGB(150,40,255); blFill.BorderSizePixel = 0; blFill.Parent = blBg; Instance.new("UICorner",blFill)
    local blKnob = Instance.new("TextButton"); blKnob.Size = UDim2.new(0,14,0,14); blKnob.Position = UDim2.new(blurAmount/56,-7,0.5,-7); blKnob.Text = ""; blKnob.BackgroundColor3 = Color3.fromRGB(255,255,255); blKnob.Parent = blBg; Instance.new("UICorner",blKnob)
    Y = Y+18
    local blurSld = false
    blKnob.MouseButton1Down:Connect(function() blurSld=true end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then blurSld=false end end)
    UserInputService.InputChanged:Connect(function(i) if blurSld and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local pos = math.clamp((i.Position.X-blBg.AbsolutePosition.X)/blBg.AbsoluteSize.X,0,1); blFill.Size = UDim2.new(pos,0,1,0); blKnob.Position = UDim2.new(pos,-7,0.5,-7); blurAmount = math.floor(pos*56); blurLab.Text = "Blur Intensity: "..blurAmount; if cinematicActive and blurEffect then blurEffect.Size = blurAmount end end end)
    local refreshBtn, clearBtn = makeBtn2("↺ Refresh","✕ Clear All",Y,pFC); Y = Y+32
    makeLbl("🎯 Pilih siapa yang di-focus", Y, pFC, 14); Y = Y+16
    local plFrame = Instance.new("ScrollingFrame"); plFrame.Size = UDim2.new(0.92,0,0,80); plFrame.Position = UDim2.new(0.04,0,0,Y); plFrame.BackgroundColor3, plFrame.BackgroundTransparency = Color3.fromRGB(10,5,15), 0.5; plFrame.Parent = pFC; plFrame.ScrollBarThickness, plFrame.ScrollBarImageColor3 = 2, Color3.fromRGB(150,40,255); plFrame.AutomaticCanvasSize, plFrame.ScrollingDirection = Enum.AutomaticSize.Y, Enum.ScrollingDirection.Y; Instance.new("UICorner",plFrame); Instance.new("UIStroke",plFrame).Color = Color3.fromRGB(80,30,120)
    local plLayout = Instance.new("UIListLayout",plFrame); plLayout.Padding = UDim.new(0,2); plLayout.SortOrder = Enum.SortOrder.Name
    Y = Y+90
    local bPad = Instance.new("Frame"); bPad.Size = UDim2.new(1,0,0,20); bPad.Position = UDim2.new(0,0,0,Y); bPad.BackgroundTransparency, bPad.Parent = 1, pFC
    local playerRows = {}
    local function refreshPlayerList() for _,r in pairs(playerRows) do pcall(function() r:Destroy() end) end; playerRows = {}; local list = Players:GetPlayers(); if #list==0 then local el = Instance.new("TextLabel"); el.Size = UDim2.new(1,0,0,24); el.BackgroundTransparency, el.Text, el.TextColor3, el.Font, el.TextSize, el.Parent = 1, "Tidak ada player lain", Color3.fromRGB(100,100,100), Enum.Font.Gotham, 10, plFrame; table.insert(playerRows,el); return end
        for _,p in ipairs(list) do local focused = focusedPlayers[p.Name]==true; local row = Instance.new("TextButton"); row.Size, row.BackgroundColor3, row.BackgroundTransparency, row.Text, row.AutoButtonColor, row.Parent = UDim2.new(1,0,0,26), (focused and Color3.fromRGB(180,60,255) or Color3.fromRGB(130,40,255)), 0.6, "", false, plFrame; Instance.new("UICorner",row); local nl = Instance.new("TextLabel"); nl.Size, nl.Position, nl.BackgroundTransparency, nl.Text, nl.TextColor3, nl.Font, nl.TextSize, nl.TextXAlignment, nl.Parent = UDim2.new(1,-10,1,0), UDim2.new(0,10,0,0), 1, ((focused and "◉ " or "○ ")..p.DisplayName.."  @"..p.Name), (focused and Color3.fromRGB(255,255,255) or Color3.fromRGB(180,180,180)), Enum.Font.GothamBold, 10, Enum.TextXAlignment.Left, row; row.MouseButton1Click:Connect(function() focusedPlayers[p.Name] = not focusedPlayers[p.Name]; refreshPlayerList() end); table.insert(playerRows,row) end end
    refreshBtn.MouseButton1Click:Connect(refreshPlayerList); clearBtn.MouseButton1Click:Connect(function() focusedPlayers={}; refreshPlayerList() end); task.spawn(function() task.wait(0.6); refreshPlayerList() end)
    local function hasFocused() for _,v in pairs(focusedPlayers) do if v then return true end end return false end
    local function startCinematicLoop() if cinematicConn then return end; cinematicConn = RunService.RenderStepped:Connect(function() if not cinematicActive then return end; if hasFocused() then local targetChar, targetDist = nil, math.huge; for pName, isFocused in pairs(focusedPlayers) do if isFocused then local p=Players:FindFirstChild(pName); if p and p.Character then local hrp=p.Character:FindFirstChild("HumanoidRootPart"); if hrp then local dist=(hrp.Position-Camera.CFrame.Position).Magnitude; if dist<targetDist then targetDist, targetChar = dist, p.Character end end end end end; if targetChar and depthOfField then local hrp=targetChar:FindFirstChild("HumanoidRootPart"); if hrp then depthOfField.FocusDistance, depthOfField.InFocusRadius, depthOfField.FarIntensity, depthOfField.NearIntensity = (hrp.Position-Camera.CFrame.Position).Magnitude, 4, 1, 1 end end; if blurEffect then blurEffect.Size=0 end else if blurEffect then blurEffect.Size=blurAmount end; if depthOfField then depthOfField.FarIntensity, depthOfField.NearIntensity, depthOfField.InFocusRadius = 0, 0, 999 end end end) end
    cinRow.MouseButton1Click:Connect(function() cinematicActive = not cinematicActive; setCinState(cinematicActive); if cinematicActive then if blurEffect then blurEffect:Destroy() end; if depthOfField then depthOfField:Destroy() end; blurEffect, depthOfField = Instance.new("BlurEffect"), Instance.new("DepthOfFieldEffect"); blurEffect.Size, blurEffect.Parent = blurAmount, Lighting; depthOfField.FarIntensity, depthOfField.NearIntensity, depthOfField.InFocusRadius, depthOfField.FocusDistance, depthOfField.Parent = 1, 1, 5, 50, Lighting; startCinematicLoop() else if cinematicConn then cinematicConn:Disconnect(); cinematicConn=nil end; if blurEffect then blurEffect:Destroy(); blurEffect=nil end; if depthOfField then depthOfField:Destroy(); depthOfField=nil end end end)

    -- INJECT SHIFTLOCK SETTINGS KE PANEL FREECAM
    makeSepHdr("SHIFTLOCK SETTINGS", Y, pFC); Y = Y+22
    local slRow, setSlState, getSlState = makeIosRow("Show Shiftlock", Y, pFC); Y = Y+36
    slRow.MouseButton1Click:Connect(function() local s = not getSlState(); setSlState(s); shiftlockBtn.Visible = s end)
    
    local slSzLab = makeLbl("Icon Size: 85", Y, pFC, 14); Y = Y+16
    local slSzBg = Instance.new("Frame"); slSzBg.Size = UDim2.new(0.88,0,0,4); slSzBg.Position = UDim2.new(0.06,0,0,Y); slSzBg.BackgroundColor3 = Color3.fromRGB(30,20,40); slSzBg.Parent = pFC; Instance.new("UICorner",slSzBg)
    local slSzFill = Instance.new("Frame"); slSzFill.Size = UDim2.new((85-30)/120,0,1,0); slSzFill.BackgroundColor3 = Color3.fromRGB(150,40,255); slSzFill.BorderSizePixel = 0; slSzFill.Parent = slSzBg; Instance.new("UICorner",slSzFill)
    local slSzBtn = Instance.new("TextButton"); slSzBtn.Size = UDim2.new(0,14,0,14); slSzBtn.Position = UDim2.new((85-30)/120,-7,0.5,-7); slSzBtn.Text = ""; slSzBtn.BackgroundColor3 = Color3.fromRGB(255,255,255); slSzBtn.Parent = slSzBg; Instance.new("UICorner",slSzBtn).CornerRadius = UDim.new(1,0)
    Y = Y+18; local slSzSld = false
    slSzBtn.MouseButton1Down:Connect(function() slSzSld=true end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then slSzSld=false end end)
    UserInputService.InputChanged:Connect(function(i) if slSzSld and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local pos = math.clamp((i.Position.X-slSzBg.AbsolutePosition.X)/slSzBg.AbsoluteSize.X,0,1); slSzFill.Size = UDim2.new(pos,0,1,0); slSzBtn.Position = UDim2.new(pos,-7,0.5,-7); local s = math.floor(30+(pos*120)); slSzLab.Text = "Icon Size: "..s; shiftlockBtn.Size = UDim2.new(0,s,0,s) end end)

    local slXLab = makeLbl("Posisi X: 0.90", Y, pFC, 14); Y = Y+16
    local slXBg = Instance.new("Frame"); slXBg.Size = UDim2.new(0.88,0,0,4); slXBg.Position = UDim2.new(0.06,0,0,Y); slXBg.BackgroundColor3 = Color3.fromRGB(30,20,40); slXBg.Parent = pFC; Instance.new("UICorner",slXBg)
    local slXFill = Instance.new("Frame"); slXFill.Size = UDim2.new(0.9,0,1,0); slXFill.BackgroundColor3 = Color3.fromRGB(150,40,255); slXFill.BorderSizePixel = 0; slXFill.Parent = slXBg; Instance.new("UICorner",slXFill)
    local slXBtn = Instance.new("TextButton"); slXBtn.Size = UDim2.new(0,14,0,14); slXBtn.Position = UDim2.new(0.9,-7,0.5,-7); slXBtn.Text = ""; slXBtn.BackgroundColor3 = Color3.fromRGB(255,255,255); slXBtn.Parent = slXBg; Instance.new("UICorner",slXBtn).CornerRadius = UDim.new(1,0)
    Y = Y+18; local slXSld = false
    slXBtn.MouseButton1Down:Connect(function() slXSld=true end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then slXSld=false end end)
    UserInputService.InputChanged:Connect(function(i) if slXSld and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local pos = math.clamp((i.Position.X-slXBg.AbsolutePosition.X)/slXBg.AbsoluteSize.X,0,1); slXFill.Size = UDim2.new(pos,0,1,0); slXBtn.Position = UDim2.new(pos,-7,0.5,-7); slXLab.Text = string.format("Posisi X: %.2f",pos); shiftlockBtn.Position = UDim2.new(pos,0,shiftlockBtn.Position.Y.Scale,0) end end)

    local slYLab = makeLbl("Posisi Y: 0.50", Y, pFC, 14); Y = Y+16
    local slYBg = Instance.new("Frame"); slYBg.Size = UDim2.new(0.88,0,0,4); slYBg.Position = UDim2.new(0.06,0,0,Y); slYBg.BackgroundColor3 = Color3.fromRGB(30,20,40); slYBg.Parent = pFC; Instance.new("UICorner",slYBg)
    local slYFill = Instance.new("Frame"); slYFill.Size = UDim2.new(0.5,0,1,0); slYFill.BackgroundColor3 = Color3.fromRGB(150,40,255); slYFill.BorderSizePixel = 0; slYFill.Parent = slYBg; Instance.new("UICorner",slYFill)
    local slYBtn = Instance.new("TextButton"); slYBtn.Size = UDim2.new(0,14,0,14); slYBtn.Position = UDim2.new(0.5,-7,0.5,-7); slYBtn.Text = ""; slYBtn.BackgroundColor3 = Color3.fromRGB(255,255,255); slYBtn.Parent = slYBg; Instance.new("UICorner",slYBtn).CornerRadius = UDim.new(1,0)
    Y = Y+18; local slYSld = false
    slYBtn.MouseButton1Down:Connect(function() slYSld=true end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then slYSld=false end end)
    UserInputService.InputChanged:Connect(function(i) if slYSld and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local pos = math.clamp((i.Position.X-slYBg.AbsolutePosition.X)/slYBg.AbsoluteSize.X,0,1); slYFill.Size = UDim2.new(pos,0,1,0); slYBtn.Position = UDim2.new(pos,-7,0.5,-7); slYLab.Text = string.format("Posisi Y: %.2f",pos); shiftlockBtn.Position = UDim2.new(shiftlockBtn.Position.X.Scale,0,pos,0) end end)

    local bPadFC = Instance.new("Frame"); bPadFC.Size = UDim2.new(1,0,0,20); bPadFC.Position = UDim2.new(0,0,0,Y); bPadFC.BackgroundTransparency = 1; bPadFC.Parent = pFC


    -- ==========================================
    -- PANEL ORIENTATION
    -- ==========================================
    local oY = 2
    makeSepHdr("SCREEN ORIENTATION", oY, pOR); oY = oY+22
    local portRow, setPort = makeIosRow("Portrait", oY, pOR); oY = oY+36
    local landLRow, setLandL = makeIosRow("Landscape Left", oY, pOR); oY = oY+36
    local landRRow, setLandR = makeIosRow("Landscape Right", oY, pOR); oY = oY+36
    portRow.MouseButton1Click:Connect(function() setPort(true); setLandL(false); setLandR(false); localPlayer.PlayerGui.ScreenOrientation = Enum.ScreenOrientation.Portrait end)
    landLRow.MouseButton1Click:Connect(function() setPort(false); setLandL(true); setLandR(false); localPlayer.PlayerGui.ScreenOrientation = Enum.ScreenOrientation.LandscapeLeft end)
    landRRow.MouseButton1Click:Connect(function() setPort(false); setLandL(false); setLandR(true); localPlayer.PlayerGui.ScreenOrientation = Enum.ScreenOrientation.LandscapeRight end)
    makeSepHdr("DISPLAY SETTINGS", oY, pOR); oY = oY+22
    local briLab = makeLbl("Brightness: 1.0",oY,pOR,14); oY = oY+16
    local brBg = Instance.new("Frame"); brBg.Size, brBg.Position, brBg.BackgroundColor3, brBg.Parent = UDim2.new(0.88,0,0,4), UDim2.new(0.06,0,0,oY), Color3.fromRGB(30,20,40), pOR; Instance.new("UICorner",brBg)
    local brFill = Instance.new("Frame"); brFill.Size, brFill.BackgroundColor3, brFill.BorderSizePixel, brFill.Parent = UDim2.new(0.5,0,1,0), Color3.fromRGB(150,40,255), 0, brBg; Instance.new("UICorner",brFill)
    local brBtn = Instance.new("TextButton"); brBtn.Size, brBtn.Position, brBtn.Text, brBtn.BackgroundColor3, brBtn.Parent = UDim2.new(0,14,0,14), UDim2.new(0.5,-7,0.5,-7), "", Color3.fromRGB(255,255,255), brBg; Instance.new("UICorner",brBtn)
    oY, briSld = oY+18, false
    brBtn.MouseButton1Down:Connect(function() briSld=true end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then briSld=false end end)
    UserInputService.InputChanged:Connect(function(i) if briSld and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local pos = math.clamp((i.Position.X-brBg.AbsolutePosition.X)/brBg.AbsoluteSize.X,0,1); brFill.Size = UDim2.new(pos,0,1,0); brBtn.Position = UDim2.new(pos,-7,0.5,-7); Lighting.Brightness=pos*3; briLab.Text="Brightness: "..string.format("%.1f",pos*3) end end)
    local timeRow, setTime = makeIosRow("Night Mode", oY, pOR); oY = oY+36
    timeRow.MouseButton1Click:Connect(function() local isNight = not (Lighting.ClockTime == 0); setTime(isNight); if isNight then Lighting.ClockTime=0 else Lighting.ClockTime=14 end end)
    local oPad = Instance.new("Frame"); oPad.Size, oPad.Position, oPad.BackgroundTransparency, oPad.Parent = UDim2.new(1,0,0,20), UDim2.new(0,0,0,oY), 1, pOR

    -- HUD MOBILE
    local hud = Instance.new("Frame"); hud.Size, hud.BackgroundTransparency, hud.Visible, hud.Parent = UDim2.new(1,0,1,0), 1, false, screenGui
    local function bHUD(t,p,k,type) local b = Instance.new("TextButton"); b.Text, b.Size, b.Position, b.BackgroundColor3, b.BackgroundTransparency, b.TextColor3, b.Font, b.Parent = t, UDim2.new(0,50,0,50), p, Color3.fromRGB(20,10,30), 0.3, Color3.fromRGB(180,100,255), Enum.Font.GothamBold, hud; Instance.new("UICorner",b).CornerRadius = UDim.new(1,0)
        b.InputBegan:Connect(function() if type=="m" then moveInputs[k]=1 else zoomInputs[k]=1 end end); b.InputEnded:Connect(function() if type=="m" then moveInputs[k]=0 else zoomInputs[k]=0 end end) end
    bHUD("W",UDim2.new(0,80,1,-150),"F","m"); bHUD("S",UDim2.new(0,80,1,-80),"B","m"); bHUD("A",UDim2.new(0,15,1,-80),"L","m"); bHUD("D",UDim2.new(0,145,1,-80),"R","m"); bHUD("UP",UDim2.new(1,-140,1,-150),"U","m"); bHUD("DN",UDim2.new(1,-140,1,-80),"D","m"); bHUD("+",UDim2.new(1,-70,1,-150),"In","z"); bHUD("-",UDim2.new(1,-70,1,-80),"Out","z")

    camRow.MouseButton1Click:Connect(function() isFreecamActive = not isFreecamActive; setCamState(isFreecamActive); hud.Visible = (isFreecamActive and getHudState())
        if isFreecamActive then PlayerModule:Disable(); Camera.CameraType = Enum.CameraType.Scriptable
        else PlayerModule:Enable(); Camera.CameraType = Enum.CameraType.Custom; lockTarget, isLockOn, autoWalkActive, autoWalkDirection = nil, false, false, 0; setLockState(false); moveInputs.F, moveInputs.B = 0, 0; awFwd.BackgroundColor3, awStop.BackgroundColor3, awBack.BackgroundColor3, hud.Visible = cOff, Color3.fromRGB(50,50,50), cOff, false end end)
    setHudState(true); hudRow.MouseButton1Click:Connect(function() local newState = not getHudState(); setHudState(newState); if isFreecamActive then hud.Visible=newState end end); lockRow.MouseButton1Click:Connect(function() isLockOn = not isLockOn; setLockState(isLockOn); if not isLockOn then lockTarget=nil end end)

    -- RENDER ENGINE
    RunService:BindToRenderStep("SyaaaEngine", Enum.RenderPriority.Camera.Value+1, function(dt) if not isFreecamActive then return end; local rotAlpha = math.clamp(dt*((101-smoothValue)/10),0.01,1); local rawMove = Vector3.new(moveInputs.R-moveInputs.L, moveInputs.U-moveInputs.D, moveInputs.B-moveInputs.F)
        if zoomInputs.In == 1 then if targetFov > 1 then targetFov = math.clamp(targetFov - 1.5, 1, 170) else rawMove = rawMove + Vector3.new(0, 0, -1.5) end end
        if zoomInputs.Out == 1 then if targetFov < 170 then targetFov = math.clamp(targetFov + 1.5, 1, 170) else rawMove = rawMove + Vector3.new(0, 0, 1.5) end end
        Camera.FieldOfView = Camera.FieldOfView + (targetFov-Camera.FieldOfView)*rotAlpha; local mVec = rawMove; if mVec.Magnitude > 0 then mVec = mVec.Unit end
        if lockTarget then local tPos = (lockTarget:IsA("BasePart") and lockTarget.Position) or (lockTarget:IsA("Model") and lockTarget:GetPivot().Position) or lockTarget; local nextPos = Camera.CFrame.Position + Camera.CFrame:VectorToWorldSpace(mVec*moveSpeed*dt); Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(nextPos,tPos),rotAlpha)
        else displayYaw, displayPitch = displayYaw+(targetYaw-displayYaw)*rotAlpha, displayPitch+(targetPitch-displayPitch)*rotAlpha; local newCamRot = CFrame.Angles(0, math.rad(displayYaw), 0) * CFrame.Angles(math.rad(displayPitch), 0, 0); local nextPos = Camera.CFrame.Position + newCamRot:VectorToWorldSpace(mVec*moveSpeed*dt); Camera.CFrame = CFrame.new(nextPos) * newCamRot end end)
    UserInputService.InputBegan:Connect(function(input,gpe) if not gpe and isFreecamActive and isLockOn and (input.UserInputType==Enum.UserInputType.Touch or input.UserInputType==Enum.UserInputType.MouseButton1) then local unitRay = Camera:ScreenPointToRay(input.Position.X,input.Position.Y); local result = workspace:Raycast(unitRay.Origin,unitRay.Direction*2000); if result and result.Instance then lockTarget=result.Instance end end end)
    UserInputService.InputChanged:Connect(function(input) if isFreecamActive and not lockTarget and (input.UserInputType==Enum.UserInputType.Touch or input.UserInputType==Enum.UserInputType.MouseMovement) then targetYaw = targetYaw-(input.Delta.X*0.3); targetPitch = math.clamp(targetPitch-(input.Delta.Y*0.3),-88,88) end end)

    -- ==========================================
    -- TAB AI: CHAT ASSISTANT (WA STYLE & FIXED TEXT)
    -- ==========================================
    local aiChatList = Instance.new("UIListLayout", pAI)
    aiChatList.Padding = UDim.new(0, 8)
    aiChatList.SortOrder = Enum.SortOrder.LayoutOrder

    local function createMessageBubble(senderType, text)
        local isUser = (senderType == "User")
        
        local container = Instance.new("Frame")
        container.Size = UDim2.new(1, 0, 0, 0)
        container.AutomaticSize = Enum.AutomaticSize.Y
        container.BackgroundTransparency = 1
        container.Parent = pAI
        
        local ava = Instance.new("ImageLabel")
        ava.Size = UDim2.new(0, 30, 0, 30)
        ava.Position = isUser and UDim2.new(1, -30, 0, 0) or UDim2.new(0, 0, 0, 0)
        ava.BackgroundTransparency = 1
        ava.Image = isUser and playerAvaUrl or devAvaUrl
        ava.Parent = container
        Instance.new("UICorner", ava).CornerRadius = UDim.new(1, 0)
        
        local bubble = Instance.new("Frame")
        bubble.Size = UDim2.new(0.7, 0, 0, 0)
        bubble.AutomaticSize = Enum.AutomaticSize.Y
        bubble.Position = isUser and UDim2.new(0.3, -38, 0, 0) or UDim2.new(0, 38, 0, 0)
        bubble.BackgroundColor3 = isUser and Color3.fromRGB(25, 20, 35) or Color3.fromRGB(40, 15, 70)
        bubble.Parent = container
        Instance.new("UICorner", bubble).CornerRadius = UDim.new(0, 8)
        
        -- FIX TEXT KEPOTONG: Pake Padding dalem bubble
        local padB = Instance.new("UIPadding", bubble)
        padB.PaddingTop = UDim.new(0, 4)
        padB.PaddingBottom = UDim.new(0, 8)
        padB.PaddingLeft = UDim.new(0, 8)
        padB.PaddingRight = UDim.new(0, 8)
        
        local nameLbl = Instance.new("TextLabel")
        nameLbl.Text = isUser and localPlayer.DisplayName or "Syaa"
        nameLbl.Size = UDim2.new(1, 0, 0, 15)
        nameLbl.TextColor3 = isUser and Color3.fromRGB(200, 200, 200) or Color3.fromRGB(180, 100, 255)
        nameLbl.Font = Enum.Font.GothamBold
        nameLbl.TextSize = 10
        nameLbl.BackgroundTransparency = 1
        nameLbl.TextXAlignment = isUser and Enum.TextXAlignment.Right or Enum.TextXAlignment.Left
        nameLbl.Parent = bubble
        
        local txt = Instance.new("TextLabel")
        txt.Text = text
        txt.Size = UDim2.new(1, 0, 0, 0)
        txt.AutomaticSize = Enum.AutomaticSize.Y
        txt.Position = UDim2.new(0, 0, 0, 15) -- Turunin dikit dari nama
        txt.TextColor3 = Color3.fromRGB(255, 255, 255)
        txt.Font = Enum.Font.Gotham
        txt.TextSize = 11
        txt.TextWrapped = true
        txt.RichText = true -- FIX TEXT KEPOTONG: Bikin render teks panjang lebih stabil
        txt.BackgroundTransparency = 1
        txt.TextXAlignment = Enum.TextXAlignment.Left
        txt.Parent = bubble
        
        task.defer(function()
            pAI.CanvasPosition = Vector2.new(0, pAI.AbsoluteCanvasSize.Y)
        end)
        
        return txt -- Return text nya biar bisa diedit buat typing indicator
    end

    -- INPUT CHAT BAR
    local aiInputFrame = Instance.new("Frame")
    aiInputFrame.Size = UDim2.new(1, -20, 0, 35)
    aiInputFrame.Position = UDim2.new(0, 10, 1, -45)
    aiInputFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 20)
    aiInputFrame.Visible = false
    aiInputFrame.Parent = mainFrame
    Instance.new("UICorner", aiInputFrame).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", aiInputFrame).Color = Color3.fromRGB(130, 40, 255)
    tabPanels["AI_Input"] = aiInputFrame 

    local chatInput = Instance.new("TextBox")
    chatInput.Size = UDim2.new(1, -45, 1, -10)
    chatInput.Position = UDim2.new(0, 8, 0, 5)
    chatInput.BackgroundTransparency = 1
    chatInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    chatInput.PlaceholderText = "Tanya Syaa bro..."
    chatInput.Text = ""
    chatInput.Font = Enum.Font.Gotham
    chatInput.TextSize = 11
    chatInput.TextXAlignment = Enum.TextXAlignment.Left
    chatInput.Parent = aiInputFrame

    local sendBtn = Instance.new("ImageButton")
    sendBtn.Size = UDim2.new(0, 24, 0, 24)
    sendBtn.Position = UDim2.new(1, -32, 0.5, -12)
    sendBtn.BackgroundTransparency = 1
    sendBtn.Image = ICON_SEND_MESSAGE
    sendBtn.ImageColor3 = Color3.fromRGB(150, 40, 255)
    sendBtn.Parent = aiInputFrame

    local oldSetTab = setTab
    setTab = function(name)
        oldSetTab(name)
        aiInputFrame.Visible = (name == "AI")
    end

    -- LOGIKA KIRIM & API (Danzzy) DENGAN TYPING INDICATOR
    local isFetching = false
    local function formatAndSend()
        local msg = chatInput.Text
        if msg == "" or isFetching then return end
        chatInput.Text = ""
        isFetching = true
        
        createMessageBubble("User", msg)
        
        -- TYPING INDICATOR
        local typingObj = createMessageBubble("Syaa", "<i>Syaa lagi ngetik... ✍️🗿</i>")
        
        task.spawn(function()
            local systemContext = "Kamu adalah asisten AI dari script Roblox bernama 'Syaa Hub' buatan 'Syaa' (tepresakkriminal). Syaa Hub punya fitur: 1. Freecam & Cinematic Mode, 2. Pengaturan Layar (Orientation & Night Mode), 3. Unlimited Jump & Walkspeed Slider, 4. Teleport Player otomatis pake UI List & Avatar, 5. 3D Image Spawner (bisa atur scale, posisi, rotasi lengkap X, Y, Z). Jawab pertanyaan berikut dengan asik, santai, agak gaul, bahasa Indonesia, dan selalu panggil 'bro'. Pertanyaan User: "
            local fullQuery = systemContext .. msg
            local encodedQuery = HttpService:UrlEncode(fullQuery)
            local apiUrl = "https://api.danzy.web.id/api/ai/gemini-lite?q=" .. encodedQuery
            
            local response = request({ Url = apiUrl, Method = "GET" })
            
            if response.StatusCode == 200 then
                local data = HttpService:JSONDecode(response.Body)
                if data.status and data.result and data.result.parts and data.result.parts[1] then
                    -- REPLACE TYPING TEXT DENGAN HASIL ASLI
                    typingObj.Text = data.result.parts[1].text
                else
                    typingObj.Text = "Waduh bro, API-nya lagi pusing kyknya error nih."
                end
            else
                typingObj.Text = "Gagal konek ke server AI bro! Status: " .. response.StatusCode
            end
            
            isFetching = false
            
            -- Auto scroll lagi abis update teks
            task.defer(function()
                pAI.CanvasPosition = Vector2.new(0, pAI.AbsoluteCanvasSize.Y)
            end)
        end)
    end

    sendBtn.MouseButton1Click:Connect(formatAndSend)
    chatInput.FocusLost:Connect(function(enter) if enter then formatAndSend() end end)

    createMessageBubble("Syaa", "Yo bro " .. localPlayer.DisplayName .. "! Ada yang bisa gw bantu soal fitur Syaa Hub? Tanyain aja santai 🗿")

    setTab("Freecam") 
end

startLoading(runSyaaHub)
