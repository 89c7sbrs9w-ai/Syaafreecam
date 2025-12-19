-- [[ SYAAA HUB V4 - NOTIF ESTETIK EDITION ]] --
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local localPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- UI Root Utama
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SyaaaHub_Final_UltraCompact"
screenGui.ResetOnSpawn = false
screenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")

-- ==========================================
-- SYSTEM: SOUND ENGINE
-- ==========================================
local function playNotifSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://4590662766" 
    sound.Volume = 0.5
    sound.Parent = SoundService
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
end

local function playCloseSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://6895079853" 
    sound.Volume = 0.4
    sound.Parent = SoundService
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
end

-- ==========================================
-- SYSTEM: LOADING GACOR
-- ==========================================
local function startLoading(callback)
    local loadBG = Instance.new("CanvasGroup") 
    loadBG.Size = UDim2.new(0, 320, 0, 180); loadBG.Position = UDim2.new(0.5, -160, 0.5, -90)
    loadBG.BackgroundColor3 = Color3.fromRGB(10, 10, 15); loadBG.Parent = screenGui
    Instance.new("UICorner", loadBG).CornerRadius = UDim.new(0, 20)
    local strokeL = Instance.new("UIStroke", loadBG); strokeL.Color = Color3.fromRGB(0, 150, 255); strokeL.Thickness = 2

    local titleL = Instance.new("TextLabel")
    titleL.Text = "SYAA"; titleL.Size = UDim2.new(1, 0, 0, 40); titleL.Position = UDim2.new(0, 0, 0, 25)
    titleL.TextColor3 = Color3.fromRGB(0, 150, 255); titleL.Font = Enum.Font.GothamBold; titleL.TextSize = 38; titleL.BackgroundTransparency = 1; titleL.Parent = loadBG

    local percentLabel = Instance.new("TextLabel")
    percentLabel.Text = "0%"; percentLabel.Size = UDim2.new(1, 0, 0, 20); percentLabel.Position = UDim2.new(0, 0, 0, 90)
    percentLabel.TextColor3 = Color3.fromRGB(255, 255, 255); percentLabel.Font = Enum.Font.Code; percentLabel.TextSize = 13; percentLabel.BackgroundTransparency = 1; percentLabel.Parent = loadBG

    local barOutline = Instance.new("Frame")
    barOutline.Size = UDim2.new(0.7, 0, 0, 4); barOutline.Position = UDim2.new(0.15, 0, 0, 115); barOutline.BackgroundColor3 = Color3.fromRGB(30, 30, 40); barOutline.Parent = loadBG
    Instance.new("UICorner", barOutline)

    local barFill = Instance.new("Frame")
    barFill.Size = UDim2.new(0, 0, 1, 0); barFill.BackgroundColor3 = Color3.fromRGB(0, 150, 255); barFill.BorderSizePixel = 0; barFill.Parent = barOutline
    Instance.new("UICorner", barFill)

    local pLabel = Instance.new("TextLabel")
    pLabel.Text = "Menunggu..."; pLabel.Size = UDim2.new(1, 0, 0, 25); pLabel.Position = UDim2.new(0, 0, 0, 130); pLabel.TextColor3 = Color3.fromRGB(0, 180, 255); pLabel.Font = Enum.Font.GothamBold; pLabel.TextSize = 11; pLabel.BackgroundTransparency = 1; pLabel.Parent = loadBG

    task.spawn(function()
        local progress = 0
        while progress < 100 do
            local step = math.random(1, 4)
            progress = math.min(progress + step, 100)
            TweenService:Create(barFill, TweenInfo.new(0.4), {Size = UDim2.new(progress/100, 0, 1, 0)}):Play()
            percentLabel.Text = progress .. "%"
            if progress < 30 then pLabel.Text = "scrip sedang loafing su"
            elseif progress >= 30 and progress < 70 then pLabel.Text = "sabar dikit napa monyet"
            elseif progress >= 70 and progress < 100 then pLabel.Text = "bentar lagi kelar, kalem..." end
            task.wait(math.random(1, 4) / 10)
        end
        percentLabel.Text = "100%"; pLabel.Text = "nah udah selesai nih pake la pakee 🗿"; task.wait(0.8)
        local closeTween = TweenService:Create(loadBG, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {GroupTransparency = 1, Size = UDim2.new(0, 150, 0, 80), Position = UDim2.new(0.5, -75, 0.5, -40)})
        TweenService:Create(strokeL, TweenInfo.new(0.5), {Transparency = 1}):Play(); closeTween:Play(); closeTween.Completed:Wait(); loadBG:Destroy(); callback() 
    end)
end

-- ==========================================
-- SCRIPT INTI
-- ==========================================
local function runSyaaHub()
    local isFreecamActive = false
    local lockTarget = nil
    local moveSpeed = 15
    local targetFov = 70
    local targetYaw, targetPitch = 0, 0
    local displayYaw, displayPitch = 0, 0
    local moveInputs = {F = 0, B = 0, L = 0, R = 0, U = 0, D = 0}
    local zoomInputs = {In = 0, Out = 0}
    local smoothValue = 50 

    local PlayerModule = require(localPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()

    -- NOTIFIKASI
    local activeNotifs = {}
    local function updateNotifPositions()
        for i, frame in ipairs(activeNotifs) do
            local targetY = 15 + ((i - 1) * 58) 
            TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -140, 0, targetY)}):Play()
        end
    end

    local function showNotify(text, status)
        playNotifSound()
        local notifyFrame = Instance.new("Frame")
        notifyFrame.Size = UDim2.new(0, 280, 0, 52) 
        notifyFrame.Position = UDim2.new(0.5, -140, 0, -60)
        notifyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20); notifyFrame.BackgroundTransparency = 1; notifyFrame.Parent = screenGui
        table.insert(activeNotifs, notifyFrame)
        Instance.new("UICorner", notifyFrame).CornerRadius = UDim.new(0, 10)
        local stroke = Instance.new("UIStroke", notifyFrame); stroke.Color = (status == "on") and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(255, 50, 50); stroke.Thickness = 2; stroke.Transparency = 1
        local symbol = (status == "on") and "✅ " or "❌ "
        if status == "wait" then symbol = "⏳ "; stroke.Color = Color3.fromRGB(255, 200, 0) end
        if status == "estetik" then symbol = "✨ "; stroke.Color = Color3.fromRGB(200, 100, 255) end
        
        local label = Instance.new("TextLabel"); label.Size = UDim2.new(1, -20, 1, 0); label.Position = UDim2.new(0, 10, 0, 0); label.BackgroundTransparency = 1; label.TextWrapped = true; label.Text = symbol .. text; label.TextColor3 = Color3.new(1, 1, 1); label.Font = Enum.Font.GothamBold; label.TextSize = 10; label.TextTransparency = 1; label.Parent = notifyFrame
        updateNotifPositions()
        TweenService:Create(notifyFrame, TweenInfo.new(0.3), {BackgroundTransparency = 0.1}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.3), {Transparency = 0}):Play()
        TweenService:Create(label, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        task.delay(5.5, function()
            playCloseSound()
            local out = TweenService:Create(notifyFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1, Position = UDim2.new(0.5, -140, 0, notifyFrame.Position.Y.Offset - 20)}); TweenService:Create(stroke, TweenInfo.new(0.5), {Transparency = 1}):Play(); TweenService:Create(label, TweenInfo.new(0.5), {TextTransparency = 1}):Play(); out:Play()
            out.Completed:Connect(function() for i, v in ipairs(activeNotifs) do if v == notifyFrame then table.remove(activeNotifs, i); break end end; notifyFrame:Destroy(); updateNotifPositions() end)
        end)
    end

    -- VFX MAIN FRAME
    local mainFrame = Instance.new("CanvasGroup")
    mainFrame.Size = UDim2.new(0, 480, 0, 310); mainFrame.Position = UDim2.new(0.5, -240, 0.5, -155)
    mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18); mainFrame.Visible = false; mainFrame.GroupTransparency = 1; mainFrame.Parent = screenGui
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 15)
    local mainStroke = Instance.new("UIStroke", mainFrame); mainStroke.Thickness = 3

    local rainbowColor = Color3.fromRGB(0, 150, 255)
    task.spawn(function()
        while true do
            local hue = tick() % 5 / 5
            rainbowColor = Color3.fromHSV(hue, 0.8, 1)
            mainStroke.Color = rainbowColor
            task.wait()
        end
    end)

    local title = Instance.new("TextLabel"); title.Text = "SYAA AYAM SANTAN🗿👍🏻"; title.Size = UDim2.new(1, 0, 0, 40); title.Position = UDim2.new(0, 0, 0, 5); title.TextColor3 = Color3.fromRGB(0, 180, 255); title.Font = Enum.Font.GothamBold; title.TextSize = 18; title.BackgroundTransparency = 1; title.Parent = mainFrame

    -- TOMBOL UTAMA (100x100 & NORMAL COLOR)
    local arrowIcon = Instance.new("ImageButton")
    arrowIcon.Size = UDim2.new(0, 100, 0, 100) 
    arrowIcon.Position = UDim2.new(0, 20, 0.5, -50)
    arrowIcon.BackgroundTransparency = 1
    arrowIcon.Image = "rbxassetid://87411882585742"
    arrowIcon.ImageColor3 = Color3.new(1, 1, 1)
    arrowIcon.Parent = screenGui

    -- SIDEBAR (MAKIN KECIL & MAKIN MEPET)
    local sidebar = Instance.new("CanvasGroup")
    sidebar.Size = UDim2.new(0, 44, 0, 130) -- Makin ramping
    sidebar.Position = UDim2.new(0, 108, 0.5, -65) -- Digeser mepet (108 offset)
    sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 10); sidebar.Visible = false; sidebar.GroupTransparency = 1; sidebar.Parent = screenGui
    Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 15); Instance.new("UIStroke", sidebar).Color = Color3.fromRGB(50, 50, 50)

    local function toggleMainFrame(state)
        if state then
            mainFrame.Visible = true; mainFrame.Size = UDim2.new(0, 300, 0, 200)
            TweenService:Create(mainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back), {Size = UDim2.new(0, 480, 0, 310), GroupTransparency = 0}):Play()
            -- NOTIFIKASI REQUEST USER
            showNotify("bahan konten mu kawan gunakan se estetik mungkin", "estetik")
            task.wait(0.2)
            showNotify("izinnnnnn😜", "estetik")
        else
            local t = TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 100, 0, 60), GroupTransparency = 1})
            t:Play(); t.Completed:Connect(function() mainFrame.Visible = false end)
        end
    end

    local function toggleSidebar(state)
        if state then
            sidebar.Visible = true; sidebar.Position = UDim2.new(0, 85, 0.5, -65)
            TweenService:Create(sidebar, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Position = UDim2.new(0, 108, 0.5, -65), GroupTransparency = 0}):Play()
        else
            toggleMainFrame(false)
            local t = TweenService:Create(sidebar, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(0, 85, 0.5, -65), GroupTransparency = 1})
            t:Play(); t.Completed:Connect(function() sidebar.Visible = false end)
        end
    end

    -- NAV MAKER (ICON SIDEBAR MAKIN MUNGIL)
    local function makeNav(assetId, pos, type)
        local b = Instance.new("ImageButton")
        b.Size = UDim2.new(0, 30, 0, 30); b.Position = UDim2.new(0.5, -15, 0, pos) 
        b.BackgroundColor3 = Color3.fromRGB(25, 25, 25); b.Image = "rbxassetid://" .. assetId
        b.Parent = sidebar
        Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
        task.spawn(function() while true do b.ImageColor3 = rainbowColor; task.wait() end end)
        b.MouseButton1Click:Connect(function()
            if type == "main" then toggleMainFrame(not mainFrame.Visible)
            else showNotify("fitur masih dikembangkan", "wait") end
        end)
    end

    makeNav("76171785807172", 10, "main")  
    makeNav("71238002381358", 50, "other") 
    makeNav("130750947504299", 90, "other") 

    arrowIcon.MouseButton1Click:Connect(function() toggleSidebar(not sidebar.Visible) end)

    -- DRAG ENGINE (POSISI SIDEBAR PAS DI SAMPING ICON)
    local draggingIcon = false; local dragStartPos, iconStartPos
    arrowIcon.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingIcon = true; dragStartPos = input.Position; iconStartPos = arrowIcon.Position end end)
    UserInputService.InputChanged:Connect(function(input) if draggingIcon and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then local delta = input.Position - dragStartPos; arrowIcon.Position = UDim2.new(iconStartPos.X.Scale, iconStartPos.X.Offset + delta.X, iconStartPos.Y.Scale, iconStartPos.Y.Offset + delta.Y); if sidebar.Visible then sidebar.Position = UDim2.new(0, arrowIcon.AbsolutePosition.X + 88, 0, arrowIcon.AbsolutePosition.Y - 15) end end end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingIcon = false end end)

    -- SISA FITUR (TIDAK DISENTUH)
    local container = Instance.new("Frame"); container.Size = UDim2.new(1, -20, 1, -70); container.Position = UDim2.new(0, 10, 0, 55); container.BackgroundTransparency = 1; container.Parent = mainFrame
    Instance.new("UIListLayout", container).FillDirection = Enum.FillDirection.Horizontal; container.UIListLayout.Padding = UDim.new(0, 10)
    local function makePanel(name)
        local p = Instance.new("Frame"); p.Size = UDim2.new(0.31, 0, 1, 0); p.BackgroundColor3 = Color3.fromRGB(20, 20, 28); p.Parent = container; Instance.new("UICorner", p).CornerRadius = UDim.new(0, 12)
        local l = Instance.new("TextLabel"); l.Text = name; l.Size = UDim2.new(1, 0, 0, 30); l.TextColor3 = Color3.fromRGB(0, 180, 255); l.Font = Enum.Font.GothamBold; l.TextSize = 11; l.BackgroundTransparency = 1; l.Parent = p; return p
    end
    local pFC = makePanel("Freecam"); local pMS = makePanel("Music Player"); local pOR = makePanel("Orientation")
    local fcToggle = Instance.new("TextButton"); fcToggle.Text = "CAM: OFF"; fcToggle.Size = UDim2.new(0.9, 0, 0, 32); fcToggle.Position = UDim2.new(0.05, 0, 0, 35); fcToggle.BackgroundColor3 = Color3.fromRGB(35, 35, 45); fcToggle.TextColor3 = Color3.new(1, 1, 1); fcToggle.Parent = pFC; Instance.new("UICorner", fcToggle)
    local lockBtn = Instance.new("TextButton"); lockBtn.Text = "LOCK: OFF"; lockBtn.Size = UDim2.new(0.9, 0, 0, 32); lockBtn.Position = UDim2.new(0.05, 0, 0, 70); lockBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45); lockBtn.TextColor3 = Color3.new(1, 1, 1); lockBtn.Parent = pFC; Instance.new("UICorner", lockBtn)
    
    local sLab = Instance.new("TextLabel"); sLab.Text = "Smoothness: 50"; sLab.Size = UDim2.new(1, 0, 0, 20); sLab.Position = UDim2.new(0, 0, 0, 105); sLab.TextColor3 = Color3.new(1, 1, 1); sLab.BackgroundTransparency = 1; sLab.Parent = pFC
    local sBg = Instance.new("Frame"); sBg.Size = UDim2.new(0.8, 0, 0, 4); sBg.Position = UDim2.new(0.1, 0, 0, 130); sBg.BackgroundColor3 = Color3.fromRGB(50, 50, 60); sBg.Parent = pFC
    local sFill = Instance.new("Frame"); sFill.Size = UDim2.new(0.5, 0, 1, 0); sFill.BackgroundColor3 = Color3.fromRGB(0, 150, 255); sFill.BorderSizePixel = 0; sFill.Parent = sBg
    local sBtn = Instance.new("TextButton"); sBtn.Size = UDim2.new(0, 16, 0, 16); sBtn.Position = UDim2.new(0.5, -8, 0.5, -8); sBtn.Text = ""; sBtn.Parent = sBg; Instance.new("UICorner", sBtn).CornerRadius = UDim.new(1, 0)
    local sliding = false; sBtn.MouseButton1Down:Connect(function() sliding = true end); UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then sliding = false end end); UserInputService.InputChanged:Connect(function(input) if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then local pos = math.clamp((input.Position.X - sBg.AbsolutePosition.X) / sBg.AbsoluteSize.X, 0, 1); sFill.Size = UDim2.new(pos, 0, 1, 0); sBtn.Position = UDim2.new(pos, -8, 0.5, -8); smoothValue = math.floor(pos * 100); sLab.Text = "Smoothness: " .. smoothValue end end)
    local spdLab = Instance.new("TextLabel"); spdLab.Text = "Speed: 15"; spdLab.Size = UDim2.new(1,0,0,20); spdLab.Position = UDim2.new(0,0,0,150); spdLab.TextColor3 = Color3.new(1,1,1); spdLab.BackgroundTransparency = 1; spdLab.Parent = pFC
    local function spdBtn(t, x, d)
        local b = Instance.new("TextButton"); b.Text = t; b.Size = UDim2.new(0.4, 0, 0, 30); b.Position = UDim2.new(x, 0, 0, 175); b.BackgroundColor3 = Color3.fromRGB(40, 40, 50); b.TextColor3 = Color3.new(1, 1, 1); b.Parent = pFC; Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(function() moveSpeed = math.clamp(moveSpeed + d, 1, 500); spdLab.Text = "Speed: "..moveSpeed end)
    end
    spdBtn("-", 0.05, -5); spdBtn("+", 0.55, 5)
    
    local musicBox = Instance.new("TextBox"); musicBox.Size = UDim2.new(0.9, 0, 0, 35); musicBox.Position = UDim2.new(0.05, 0, 0, 45); musicBox.PlaceholderText = "ID Music..."; musicBox.BackgroundColor3 = Color3.fromRGB(35, 35, 45); musicBox.TextColor3 = Color3.new(1, 1, 1); musicBox.Parent = pMS; Instance.new("UICorner", musicBox)
    local playBtn = Instance.new("TextButton"); playBtn.Text = "PLAY/STOP"; playBtn.Size = UDim2.new(0.9, 0, 0, 35); playBtn.Position = UDim2.new(0.05, 0, 0, 90); playBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255); playBtn.TextColor3 = Color3.new(1, 1, 1); playBtn.Parent = pMS; Instance.new("UICorner", playBtn)
    local bgMusic = Instance.new("Sound", game:GetService("SoundService")); bgMusic.Looped = true; playBtn.MouseButton1Click:Connect(function() if bgMusic.IsPlaying then bgMusic:Stop() else bgMusic.SoundId = "rbxassetid://"..musicBox.Text; bgMusic:Play() end end)
    local function bRot(t, y, orient)
        local b = Instance.new("TextButton"); b.Text = t; b.Size = UDim2.new(0.9, 0, 0, 35); b.Position = UDim2.new(0.05, 0, 0, y); b.BackgroundColor3 = Color3.fromRGB(35, 35, 45); b.TextColor3 = Color3.new(1, 1, 1); b.Parent = pOR; Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(function() localPlayer.PlayerGui.ScreenOrientation = orient; if orient == Enum.ScreenOrientation.Portrait then showNotify("Portrait ON", "on") else showNotify("Landscape ON", "on") end end)
    end
    bRot("PORTRAIT", 40, Enum.ScreenOrientation.Portrait); bRot("LAND L", 85, Enum.ScreenOrientation.LandscapeLeft); bRot("LAND R", 130, Enum.ScreenOrientation.LandscapeRight)

    local hud = Instance.new("Frame"); hud.Size = UDim2.new(1, 0, 1, 0); hud.BackgroundTransparency = 1; hud.Visible = false; hud.Parent = screenGui
    local function bHUD(t, p, k, type)
        local b = Instance.new("TextButton"); b.Text = t; b.Size = UDim2.new(0, 55, 0, 55); b.Position = p; b.BackgroundColor3 = Color3.fromRGB(15, 15, 20); b.TextColor3 = Color3.fromRGB(0, 180, 255); b.Font = Enum.Font.GothamBold; b.Parent = hud; Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
        b.InputBegan:Connect(function() if type == "m" then moveInputs[k] = 1 else zoomInputs[k] = 1 end end); b.InputEnded:Connect(function() if type == "m" then moveInputs[k] = 0 else zoomInputs[k] = 0 end end)
    end
    bHUD("W", UDim2.new(0, 80, 1, -150), "F", "m"); bHUD("S", UDim2.new(0, 80, 1, -80), "B", "m"); bHUD("A", UDim2.new(0, 15, 1, -80), "L", "m"); bHUD("D", UDim2.new(0, 145, 1, -80), "R", "m"); bHUD("UP", UDim2.new(1, -140, 1, -150), "U", "m"); bHUD("DN", UDim2.new(1, -140, 1, -80), "D", "m"); bHUD("+", UDim2.new(1, -70, 1, -150), "In", "z"); bHUD("-", UDim2.new(1, -70, 1, -80), "Out", "z")

    fcToggle.MouseButton1Click:Connect(function()
        isFreecamActive = not isFreecamActive; fcToggle.Text = isFreecamActive and "CAM: ON" or "CAM: OFF"
        fcToggle.BackgroundColor3 = isFreecamActive and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(35, 35, 45); hud.Visible = isFreecamActive
        if isFreecamActive then PlayerModule:Disable(); Camera.CameraType = Enum.CameraType.Scriptable; showNotify("Freecam on. setelah memggunakan freecam (OFF) dan camera jadi bug cukup mancing aja", "on")
        else PlayerModule:Enable(); Camera.CameraType = Enum.CameraType.Custom; lockTarget = nil; showNotify("Freecam Off", "off") end
    end)

    lockBtn.MouseButton1Click:Connect(function()
        if lockBtn.Text == "LOCK: OFF" then lockBtn.Text = "LOCK: ON"; lockBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50); showNotify("Mode Lock Aktif. jika gerakan lambat tambahkan speed", "on")
        else lockTarget = nil; lockBtn.Text = "LOCK: OFF"; lockBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45); showNotify("Lock Off", "off") end
    end)
    
    RunService:BindToRenderStep("SyaaaEngine", Enum.RenderPriority.Camera.Value + 1, function(dt)
        if not isFreecamActive then return end
        local rotAlpha = math.clamp(dt * ((101 - smoothValue) / 10), 0.01, 1)
        local mVec = Vector3.new(moveInputs.R - moveInputs.L, moveInputs.U - moveInputs.D, moveInputs.B - moveInputs.F)
        if mVec.Magnitude > 0 then mVec = mVec.Unit end
        local nextPos = Camera.CFrame.Position + Camera.CFrame:VectorToWorldSpace(mVec * moveSpeed * dt)
        if zoomInputs.In == 1 then targetFov = math.clamp(targetFov - 1.5, 5, 120) end
        if zoomInputs.Out == 1 then targetFov = math.clamp(targetFov + 1.5, 5, 120) end
        Camera.FieldOfView = Camera.FieldOfView + (targetFov - Camera.FieldOfView) * rotAlpha
        if lockTarget then
            local tPos = (lockTarget:IsA("BasePart") and lockTarget.Position) or (lockTarget:IsA("Model") and lockTarget:GetPivot().Position) or lockTarget
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(nextPos, tPos), rotAlpha)
        else
            displayYaw = displayYaw + (targetYaw - displayYaw) * rotAlpha; displayPitch = displayPitch + (targetPitch - displayPitch) * rotAlpha
            Camera.CFrame = CFrame.new(nextPos) * CFrame.Angles(0, math.rad(displayYaw), 0) * CFrame.Angles(math.rad(displayPitch), 0, 0)
        end
    end)

    UserInputService.InputBegan:Connect(function(input, gpe) if not gpe and isFreecamActive and lockBtn.Text == "LOCK: ON" and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then local unitRay = Camera:ScreenPointToRay(input.Position.X, input.Position.Y); local result = workspace:Raycast(unitRay.Origin, unitRay.Direction * 2000); if result and result.Instance then lockTarget = result.Instance; showNotify("Locked!", "on") end end end)
    UserInputService.InputChanged:Connect(function(input) if isFreecamActive and not lockTarget and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then targetYaw = targetYaw - (input.Delta.X * 0.3); targetPitch = math.clamp(targetPitch - (input.Delta.Y * 0.3), -88, 88) end end)

    task.spawn(function()
        task.wait(0.5); showNotify("skrip akan terus di kembangkan secepat mungkin,jadi mohon tunggu✊🏻", "on")
        task.wait(0.4); showNotify("selamat menikmati su😜", "on")
        task.wait(0.4); showNotify("Bug?,hub whatsaap:087792945563", "on")
    end)
end

startLoading(runSyaaHub)
