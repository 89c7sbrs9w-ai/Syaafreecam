-- [[ SYAAA HUB V7.6 - PURPLE THEME + AUTO PLAYER INFO & NOTIFICATION ]] --

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local localPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SyaaaHub_V7_Final"
screenGui.ResetOnSpawn = false
screenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")

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
    -- ==========================================
    -- ORIGINAL SYAA ICON (FLOATING WIDGET)
    -- ==========================================
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

    -- DRAG LOGIC BUAT ICON
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
    -- UPDATE INFO GUI (AUTO CLOSE DALAM 4 DETIK)
    -- ==========================================
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

    -- LOGIKA KLIK / AUTO CLOSE
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

        -- ==========================================
        -- NOTIFICATION SYSTEM (DEVELOPER SYAA)
        -- ==========================================
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
            
            -- Ava Developer (tepresakkriminal)
            task.spawn(function()
                pcall(function()
                    local userId = Players:GetUserIdFromNameAsync("tepresakkriminal")
                    ava.Image = Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
                end)
            end)

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
            -- NOTIFIKASI BARU: Sapaan Username Player
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

    -- ==========================================
    -- TITLE BAR BARU (AUTO AVA & NAMA PLAYER)
    -- ==========================================
    local playerIcon = Instance.new("ImageLabel")
    playerIcon.Size = UDim2.new(0, 24, 0, 24)
    playerIcon.Position = UDim2.new(0, 15, 0, 8)
    playerIcon.BackgroundTransparency = 1
    playerIcon.Parent = mainFrame
    Instance.new("UICorner", playerIcon).CornerRadius = UDim.new(1, 0)
    
    -- Ambil Foto Profil Player Secara Otomatis
    task.spawn(function()
        pcall(function()
            playerIcon.Image = Players:GetUserThumbnailAsync(localPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
        end)
    end)

    local title = Instance.new("TextLabel")
    title.Text = localPlayer.DisplayName .. " - Syaa Hub" -- Nama Player Otomatis
    title.Size = UDim2.new(1, -60, 0, 30)
    title.Position = UDim2.new(0, 48, 0, 5)
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 13 
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.BackgroundTransparency = 1
    title.Parent = mainFrame

    -- TOMBOL MINIMIZE & CLOSE
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

    -- TABS SYSTEM
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
    sidebar.Size = UDim2.new(0, 42, 0, 100) 
    sidebar.Position = UDim2.new(0, -52, 0.5, -50)
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
        btn.Image = "rbxassetid://" .. assetId
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
    
    makeSidebarIcon("76171785807172", 12, "Freecam", UDim2.new(0, 26, 0, 26))
    makeSidebarIcon("116019702436521", 52, "Orientation", UDim2.new(0, 34, 0, 34))

    -- ==========================================
    -- PANELS 
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
    UserInputService.InputChanged:Connect(function(i)
        if sSliding and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            local pos = math.clamp((i.Position.X-sBg.AbsolutePosition.X)/sBg.AbsoluteSize.X,0,1)
            sFill.Size = UDim2.new(pos,0,1,0); sBtn.Position = UDim2.new(pos,-7,0.5,-7); smoothValue = math.floor(pos*100); sLbl.Text = "Smoothness: "..smoothValue
        end
    end)

    local spLbl = makeLbl("Speed: 15", Y, pFC); Y = Y+16
    local spMinus, spPlus = makeBtn2("−","+",Y,pFC); Y = Y+32

    spMinus.MouseButton1Click:Connect(function() moveSpeed=math.clamp(moveSpeed-5,1,500); spLbl.Text="Speed: "..moveSpeed end)
    spPlus.MouseButton1Click:Connect(function() moveSpeed=math.clamp(moveSpeed+5,1,500); spLbl.Text="Speed: "..moveSpeed end)

    makeSepHdr("Auto-Walk", Y, pFC); Y = Y+18
    local awSpdLab = makeLbl("AW Speed: 10", Y, pFC, 14); Y = Y+16
    local awFwd, awStop, awBack = makeBtn3("Maju","Stop","Mundur",Y,pFC); Y = Y+32
    local awSpdD, _awMid, awSpdU = makeBtn3("−","","＋",Y,pFC); Y = Y+32
    _awMid.BackgroundTransparency = 1
    
    local cOff = Color3.fromRGB(130,40,255)
    local cOn = Color3.fromRGB(200,100,255)
    awFwd.MouseButton1Click:Connect(function() autoWalkActive=true; autoWalkDirection=1; awFwd.BackgroundColor3=cOn; awStop.BackgroundColor3=cOff; awBack.BackgroundColor3=cOff end)
    awStop.MouseButton1Click:Connect(function() autoWalkActive=false; autoWalkDirection=0; moveInputs.F=0; moveInputs.B=0; awFwd.BackgroundColor3=cOff; awStop.BackgroundColor3=Color3.fromRGB(50,50,50); awBack.BackgroundColor3=cOff end)
    awBack.MouseButton1Click:Connect(function() autoWalkActive=true; autoWalkDirection=-1; awFwd.BackgroundColor3=cOff; awStop.BackgroundColor3=cOff; awBack.BackgroundColor3=cOn end)
    awSpdD.MouseButton1Click:Connect(function() autoWalkSpeed=math.max(autoWalkSpeed-5,1); awSpdLab.Text="AW Speed: "..autoWalkSpeed end)
    awSpdU.MouseButton1Click:Connect(function() autoWalkSpeed=math.min(autoWalkSpeed+5,200); awSpdLab.Text="AW Speed: "..autoWalkSpeed end)
    RunService.Heartbeat:Connect(function()
        if autoWalkActive and autoWalkDirection~=0 then moveInputs.F=math.max(0,autoWalkDirection); moveInputs.B=math.max(0,-autoWalkDirection) end
    end)

    makeSepHdr("CINEMATIC MODE", Y, pFC); Y = Y+18
    local cinRow, setCinState, getCinState = makeIosRow("Cinematic ON/OFF", Y, pFC); Y = Y+36
    local blurLab = makeLbl("Blur Intensity: 20", Y, pFC, 14); Y = Y+16
    local blBg = Instance.new("Frame"); blBg.Size = UDim2.new(0.88,0,0,4); blBg.Position = UDim2.new(0.06,0,0,Y); blBg.BackgroundColor3 = Color3.fromRGB(30,20,40); blBg.Parent = pFC; Instance.new("UICorner",blBg)
    local blFill = Instance.new("Frame"); blFill.Size = UDim2.new(blurAmount/56,0,1,0); blFill.BackgroundColor3 = Color3.fromRGB(150,40,255); blFill.BorderSizePixel = 0; blFill.Parent = blBg; Instance.new("UICorner",blFill)
    local blKnob = Instance.new("TextButton"); blKnob.Size = UDim2.new(0,14,0,14); blKnob.Position = UDim2.new(blurAmount/56,-7,0.5,-7); blKnob.Text = ""; blKnob.BackgroundColor3 = Color3.fromRGB(255,255,255); blKnob.Parent = blBg; Instance.new("UICorner",blKnob).CornerRadius = UDim.new(1,0)
    Y = Y+18
    local blurSld = false
    blKnob.MouseButton1Down:Connect(function() blurSld=true end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then blurSld=false end end)
    UserInputService.InputChanged:Connect(function(i)
        if blurSld and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            local pos = math.clamp((i.Position.X-blBg.AbsolutePosition.X)/blBg.AbsoluteSize.X,0,1)
            blFill.Size = UDim2.new(pos,0,1,0); blKnob.Position = UDim2.new(pos,-7,0.5,-7); blurAmount = math.floor(pos*56); blurLab.Text = "Blur Intensity: "..blurAmount
            if cinematicActive and blurEffect then blurEffect.Size = blurAmount end
        end
    end)

    local refreshBtn, clearBtn = makeBtn2("↺ Refresh","✕ Clear All",Y,pFC); Y = Y+32
    makeLbl("🎯 Pilih siapa yang di-focus", Y, pFC, 14); Y = Y+16

    local plFrame = Instance.new("ScrollingFrame")
    plFrame.Size = UDim2.new(0.92,0,0,80); plFrame.Position = UDim2.new(0.04,0,0,Y)
    plFrame.BackgroundColor3 = Color3.fromRGB(10,5,15); plFrame.BackgroundTransparency = 0.5; plFrame.Parent = pFC
    plFrame.ScrollBarThickness = 2; plFrame.ScrollBarImageColor3 = Color3.fromRGB(150,40,255)
    plFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y; plFrame.CanvasSize = UDim2.new(0,0,0,0); plFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    Instance.new("UICorner",plFrame).CornerRadius = UDim.new(0,6)
    Instance.new("UIStroke",plFrame).Color = Color3.fromRGB(80,30,120)
    local plLayout = Instance.new("UIListLayout",plFrame); plLayout.Padding = UDim.new(0,2); plLayout.SortOrder = Enum.SortOrder.Name
    local plPad = Instance.new("UIPadding",plFrame); plPad.PaddingTop = UDim.new(0,2); plPad.PaddingLeft = UDim.new(0,2); plPad.PaddingRight = UDim.new(0,2); plPad.PaddingBottom = UDim.new(0,2)
    Y = Y+90
    local bPad = Instance.new("Frame"); bPad.Size = UDim2.new(1,0,0,20); bPad.Position = UDim2.new(0,0,0,Y); bPad.BackgroundTransparency = 1; bPad.Parent = pFC

    local playerRows = {}
    local function refreshPlayerList()
        for _,r in pairs(playerRows) do pcall(function() r:Destroy() end) end; playerRows = {}
        local list = Players:GetPlayers()
        if #list==0 then
            local el = Instance.new("TextLabel"); el.Size = UDim2.new(1,0,0,24); el.BackgroundTransparency = 1; el.Text = "Tidak ada player lain"; el.TextColor3 = Color3.fromRGB(100,100,100); el.Font = Enum.Font.Gotham; el.TextSize = 10; el.Parent = plFrame; table.insert(playerRows,el); return
        end
        for _,p in ipairs(list) do
            local pName = p.Name; local dName = p.DisplayName; local focused = focusedPlayers[pName]==true
            local row = Instance.new("TextButton"); row.Size = UDim2.new(1,0,0,26); row.Name = "PR_"..pName; row.BackgroundColor3 = focused and Color3.fromRGB(180,60,255) or Color3.fromRGB(130,40,255); row.BackgroundTransparency = 0.6; row.Text = ""; row.AutoButtonColor = false; row.Parent = plFrame
            Instance.new("UICorner",row).CornerRadius = UDim.new(0,4)
            local nl = Instance.new("TextLabel"); nl.Size = UDim2.new(1,-10,1,0); nl.Position = UDim2.new(0,10,0,0); nl.BackgroundTransparency = 1; nl.Text = (focused and "◉ " or "○ ")..dName.."  @"..pName; nl.TextColor3 = focused and Color3.fromRGB(255,255,255) or Color3.fromRGB(180,180,180); nl.Font = Enum.Font.GothamBold; nl.TextSize = 10; nl.TextXAlignment = Enum.TextXAlignment.Left; nl.Parent = row
            row.MouseButton1Click:Connect(function() focusedPlayers[pName] = not focusedPlayers[pName]; refreshPlayerList() end)
            table.insert(playerRows,row)
        end
    end
    refreshBtn.MouseButton1Click:Connect(function() refreshPlayerList() end)
    clearBtn.MouseButton1Click:Connect(function() focusedPlayers={}; refreshPlayerList() end)
    Players.PlayerAdded:Connect(function() task.wait(0.3); refreshPlayerList() end)
    Players.PlayerRemoving:Connect(function() task.wait(0.3); refreshPlayerList() end)
    task.spawn(function() task.wait(0.6); refreshPlayerList() end)

    local function hasFocused() for _,v in pairs(focusedPlayers) do if v then return true end end return false end
    local function setupCinematic()
        if blurEffect then blurEffect:Destroy() end; if depthOfField then depthOfField:Destroy() end
        blurEffect = Instance.new("BlurEffect"); blurEffect.Size = blurAmount; blurEffect.Parent = Lighting
        depthOfField = Instance.new("DepthOfFieldEffect"); depthOfField.FarIntensity=1; depthOfField.NearIntensity=1; depthOfField.InFocusRadius=5; depthOfField.FocusDistance=50; depthOfField.Parent = Lighting
    end
    local function removeCinematic()
        if blurEffect then blurEffect:Destroy(); blurEffect=nil end; if depthOfField then depthOfField:Destroy(); depthOfField=nil end
    end
    local function startCinematicLoop()
        if cinematicConn then return end
        cinematicConn = RunService.RenderStepped:Connect(function()
            if not cinematicActive then return end
            if hasFocused() then
                local targetChar, targetDist = nil, math.huge
                for pName, isFocused in pairs(focusedPlayers) do
                    if isFocused then local p=Players:FindFirstChild(pName); if p and p.Character then local hrp=p.Character:FindFirstChild("HumanoidRootPart"); if hrp then local dist=(hrp.Position-Camera.CFrame.Position).Magnitude; if dist<targetDist then targetDist=dist; targetChar=p.Character end end end end
                end
                if targetChar and depthOfField then local hrp=targetChar:FindFirstChild("HumanoidRootPart"); if hrp then depthOfField.FocusDistance=(hrp.Position-Camera.CFrame.Position).Magnitude; depthOfField.InFocusRadius=4; depthOfField.FarIntensity=1; depthOfField.NearIntensity=1 end end
                if blurEffect then blurEffect.Size=0 end
            else
                if blurEffect then blurEffect.Size=blurAmount end
                if depthOfField then depthOfField.FarIntensity=0; depthOfField.NearIntensity=0; depthOfField.InFocusRadius=999 end
            end
        end)
    end
    local function stopCinematicLoop() if cinematicConn then cinematicConn:Disconnect(); cinematicConn=nil end end
    cinRow.MouseButton1Click:Connect(function()
        cinematicActive = not cinematicActive; setCinState(cinematicActive)
        if cinematicActive then setupCinematic(); startCinematicLoop()
        else stopCinematicLoop(); removeCinematic() end
    end)

    -- ==========================================
    -- PANEL ORIENTATION
    -- ==========================================
    local oY = 2
    makeSepHdr("SCREEN ORIENTATION", oY, pOR); oY = oY+22
    local portRow, setPort = makeIosRow("Portrait", oY, pOR); oY = oY+36
    local landLRow, setLandL = makeIosRow("Landscape Left", oY, pOR); oY = oY+36
    local landRRow, setLandR = makeIosRow("Landscape Right", oY, pOR); oY = oY+36
    
    portRow.MouseButton1Click:Connect(function()
        setPort(true); setLandL(false); setLandR(false)
        localPlayer.PlayerGui.ScreenOrientation = Enum.ScreenOrientation.Portrait
    end)
    landLRow.MouseButton1Click:Connect(function()
        setPort(false); setLandL(true); setLandR(false)
        localPlayer.PlayerGui.ScreenOrientation = Enum.ScreenOrientation.LandscapeLeft
    end)
    landRRow.MouseButton1Click:Connect(function()
        setPort(false); setLandL(false); setLandR(true)
        localPlayer.PlayerGui.ScreenOrientation = Enum.ScreenOrientation.LandscapeRight
    end)

    makeSepHdr("DISPLAY SETTINGS", oY, pOR); oY = oY+22
    local briLab = makeLbl("Brightness: 1.0",oY,pOR,14); oY = oY+16
    local brBg = Instance.new("Frame"); brBg.Size = UDim2.new(0.88,0,0,4); brBg.Position = UDim2.new(0.06,0,0,oY); brBg.BackgroundColor3 = Color3.fromRGB(30,20,40); brBg.Parent = pOR; Instance.new("UICorner",brBg)
    local brFill = Instance.new("Frame"); brFill.Size = UDim2.new(0.5,0,1,0); brFill.BackgroundColor3 = Color3.fromRGB(150,40,255); brFill.BorderSizePixel = 0; brFill.Parent = brBg; Instance.new("UICorner",brFill)
    local brBtn = Instance.new("TextButton"); brBtn.Size = UDim2.new(0,14,0,14); brBtn.Position = UDim2.new(0.5,-7,0.5,-7); brBtn.Text = ""; brBtn.BackgroundColor3 = Color3.fromRGB(255,255,255); brBtn.Parent = brBg; Instance.new("UICorner",brBtn).CornerRadius = UDim.new(1,0)
    oY = oY+18
    local briSld = false
    brBtn.MouseButton1Down:Connect(function() briSld=true end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then briSld=false end end)
    UserInputService.InputChanged:Connect(function(i)
        if briSld and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            local pos = math.clamp((i.Position.X-brBg.AbsolutePosition.X)/brBg.AbsoluteSize.X,0,1)
            brFill.Size = UDim2.new(pos,0,1,0); brBtn.Position = UDim2.new(pos,-7,0.5,-7); Lighting.Brightness=pos*3; briLab.Text="Brightness: "..string.format("%.1f",pos*3)
        end
    end)
    
    local timeRow, setTime = makeIosRow("Night Mode", oY, pOR); oY = oY+36
    timeRow.MouseButton1Click:Connect(function()
        local isNight = not (Lighting.ClockTime == 0)
        setTime(isNight)
        if isNight then Lighting.ClockTime=0 else Lighting.ClockTime=14 end
    end)
    
    local oPad = Instance.new("Frame"); oPad.Size = UDim2.new(1,0,0,20); oPad.Position = UDim2.new(0,0,0,oY); oPad.BackgroundTransparency = 1; oPad.Parent = pOR

    -- HUD MOBILE
    local hud = Instance.new("Frame"); hud.Size = UDim2.new(1,0,1,0); hud.BackgroundTransparency = 1; hud.Visible = false; hud.Parent = screenGui
    local function bHUD(t,p,k,type)
        local b = Instance.new("TextButton"); b.Text = t; b.Size = UDim2.new(0,50,0,50); b.Position = p; b.BackgroundColor3 = Color3.fromRGB(20,10,30); b.BackgroundTransparency = 0.3; b.TextColor3 = Color3.fromRGB(180,100,255); b.Font = Enum.Font.GothamBold; b.Parent = hud; Instance.new("UICorner",b).CornerRadius = UDim.new(1,0)
        b.InputBegan:Connect(function() if type=="m" then moveInputs[k]=1 else zoomInputs[k]=1 end end)
        b.InputEnded:Connect(function() if type=="m" then moveInputs[k]=0 else zoomInputs[k]=0 end end)
    end
    bHUD("W",UDim2.new(0,80,1,-150),"F","m"); bHUD("S",UDim2.new(0,80,1,-80),"B","m")
    bHUD("A",UDim2.new(0,15,1,-80),"L","m"); bHUD("D",UDim2.new(0,145,1,-80),"R","m")
    bHUD("UP",UDim2.new(1,-140,1,-150),"U","m"); bHUD("DN",UDim2.new(1,-140,1,-80),"D","m")
    bHUD("+",UDim2.new(1,-70,1,-150),"In","z"); bHUD("-",UDim2.new(1,-70,1,-80),"Out","z")

    -- FREECAM TOGGLE
    camRow.MouseButton1Click:Connect(function()
        isFreecamActive = not isFreecamActive; setCamState(isFreecamActive)
        hud.Visible = (isFreecamActive and getHudState())
        if isFreecamActive then
            PlayerModule:Disable(); Camera.CameraType = Enum.CameraType.Scriptable
        else
            PlayerModule:Enable(); Camera.CameraType = Enum.CameraType.Custom
            lockTarget=nil; isLockOn=false; setLockState(false)
            autoWalkActive=false; autoWalkDirection=0; moveInputs.F=0; moveInputs.B=0
            awFwd.BackgroundColor3=Color3.fromRGB(130,40,255); awStop.BackgroundColor3=Color3.fromRGB(50,50,50); awBack.BackgroundColor3=Color3.fromRGB(130,40,255)
            hud.Visible=false
        end
    end)
    setHudState(true)
    hudRow.MouseButton1Click:Connect(function()
        local newState = not getHudState(); setHudState(newState)
        if isFreecamActive then hud.Visible=newState end
    end)
    lockRow.MouseButton1Click:Connect(function()
        isLockOn = not isLockOn; setLockState(isLockOn)
        if not isLockOn then lockTarget=nil end
    end)

    -- ==========================================
    -- RENDER ENGINE
    -- ==========================================
    RunService:BindToRenderStep("SyaaaEngine", Enum.RenderPriority.Camera.Value+1, function(dt)
        if not isFreecamActive then return end
        local rotAlpha = math.clamp(dt*((101-smoothValue)/10),0.01,1)
        
        local rawMove = Vector3.new(moveInputs.R-moveInputs.L, moveInputs.U-moveInputs.D, moveInputs.B-moveInputs.F)
        
        if zoomInputs.In == 1 then 
            if targetFov > 1 then
                targetFov = math.clamp(targetFov - 1.5, 1, 170)
            else
                rawMove = rawMove + Vector3.new(0, 0, -1.5)
            end
        end
        if zoomInputs.Out == 1 then 
            if targetFov < 170 then
                targetFov = math.clamp(targetFov + 1.5, 1, 170)
            else
                rawMove = rawMove + Vector3.new(0, 0, 1.5)
            end
        end
        
        Camera.FieldOfView = Camera.FieldOfView + (targetFov-Camera.FieldOfView)*rotAlpha
        
        local mVec = rawMove
        if mVec.Magnitude > 0 then mVec = mVec.Unit end
        
        if lockTarget then
            local tPos = (lockTarget:IsA("BasePart") and lockTarget.Position) or (lockTarget:IsA("Model") and lockTarget:GetPivot().Position) or lockTarget
            local nextPos = Camera.CFrame.Position + Camera.CFrame:VectorToWorldSpace(mVec*moveSpeed*dt)
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(nextPos,tPos),rotAlpha)
        else
            displayYaw = displayYaw+(targetYaw-displayYaw)*rotAlpha
            displayPitch = displayPitch+(targetPitch-displayPitch)*rotAlpha
            
            local newCamRot = CFrame.Angles(0, math.rad(displayYaw), 0) * CFrame.Angles(math.rad(displayPitch), 0, 0)
            local nextPos = Camera.CFrame.Position + newCamRot:VectorToWorldSpace(mVec*moveSpeed*dt)
            Camera.CFrame = CFrame.new(nextPos) * newCamRot
        end
    end)

    UserInputService.InputBegan:Connect(function(input,gpe)
        if not gpe and isFreecamActive and isLockOn and (input.UserInputType==Enum.UserInputType.Touch or input.UserInputType==Enum.UserInputType.MouseButton1) then
            local unitRay = Camera:ScreenPointToRay(input.Position.X,input.Position.Y)
            local result = workspace:Raycast(unitRay.Origin,unitRay.Direction*2000)
            if result and result.Instance then lockTarget=result.Instance end
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if isFreecamActive and not lockTarget and (input.UserInputType==Enum.UserInputType.Touch or input.UserInputType==Enum.UserInputType.MouseMovement) then
            targetYaw = targetYaw-(input.Delta.X*0.3); targetPitch = math.clamp(targetPitch-(input.Delta.Y*0.3),-88,88)
        end
    end)

    setTab("Freecam")
end

startLoading(runSyaaHub)
