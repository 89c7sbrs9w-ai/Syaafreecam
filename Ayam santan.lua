-- [[ SYAAA HUB V5 - V4 SIZE + TRUE UNLIMITED ZOOM ANTI-JITTER ]] --

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local localPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SyaaaHub_V5_Final"
screenGui.ResetOnSpawn = false
screenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")

-- ==========================================
-- LOADING
-- ==========================================
local function startLoading(callback)
    local loadBG = Instance.new("CanvasGroup")
    loadBG.Size = UDim2.new(0,320,0,180); loadBG.Position = UDim2.new(0.5,-160,0.5,-90)
    loadBG.BackgroundColor3 = Color3.fromRGB(10,10,15); loadBG.Parent = screenGui
    Instance.new("UICorner",loadBG).CornerRadius = UDim.new(0,20)
    local strokeL = Instance.new("UIStroke",loadBG); strokeL.Color = Color3.fromRGB(0,150,255); strokeL.Thickness = 2
    local titleL = Instance.new("TextLabel"); titleL.Text = "SYAA"; titleL.Size = UDim2.new(1,0,0,40); titleL.Position = UDim2.new(0,0,0,25); titleL.TextColor3 = Color3.fromRGB(0,150,255); titleL.Font = Enum.Font.GothamBold; titleL.TextSize = 38; titleL.BackgroundTransparency = 1; titleL.Parent = loadBG
    local percentLabel = Instance.new("TextLabel"); percentLabel.Text = "0%"; percentLabel.Size = UDim2.new(1,0,0,20); percentLabel.Position = UDim2.new(0,0,0,90); percentLabel.TextColor3 = Color3.fromRGB(255,255,255); percentLabel.Font = Enum.Font.Code; percentLabel.TextSize = 13; percentLabel.BackgroundTransparency = 1; percentLabel.Parent = loadBG
    local barOutline = Instance.new("Frame"); barOutline.Size = UDim2.new(0.7,0,0,4); barOutline.Position = UDim2.new(0.15,0,0,115); barOutline.BackgroundColor3 = Color3.fromRGB(30,30,40); barOutline.Parent = loadBG; Instance.new("UICorner",barOutline)
    local barFill = Instance.new("Frame"); barFill.Size = UDim2.new(0,0,1,0); barFill.BackgroundColor3 = Color3.fromRGB(0,150,255); barFill.BorderSizePixel = 0; barFill.Parent = barOutline; Instance.new("UICorner",barFill)
    local pLabel = Instance.new("TextLabel"); pLabel.Text = "Menunggu..."; pLabel.Size = UDim2.new(1,0,0,25); pLabel.Position = UDim2.new(0,0,0,130); pLabel.TextColor3 = Color3.fromRGB(0,180,255); pLabel.Font = Enum.Font.GothamBold; pLabel.TextSize = 11; pLabel.BackgroundTransparency = 1; pLabel.Parent = loadBG
    task.spawn(function()
        local progress = 0
        while progress < 100 do
            local step = math.random(1,4); progress = math.min(progress+step,100)
            TweenService:Create(barFill,TweenInfo.new(0.4),{Size=UDim2.new(progress/100,0,1,0)}):Play(); percentLabel.Text = progress.."%"
            if progress < 30 then pLabel.Text = "scrip sedang loafing su"
            elseif progress < 70 then pLabel.Text = "sabar dikit napa monyet"
            elseif progress < 100 then pLabel.Text = "bentar lagi kelar, kalem..." end
            task.wait(math.random(1,4)/10)
        end
        percentLabel.Text = "100%"; pLabel.Text = "nah udah selesai nih pake la pakee 🗿"; task.wait(0.8)
        local closeTween = TweenService:Create(loadBG,TweenInfo.new(0.8,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut),{GroupTransparency=1,Size=UDim2.new(0,150,0,80),Position=UDim2.new(0.5,-75,0.5,-40)})
        TweenService:Create(strokeL,TweenInfo.new(0.5),{Transparency=1}):Play(); closeTween:Play(); closeTween.Completed:Wait(); loadBG:Destroy(); callback()
    end)
end

-- ==========================================
-- MAIN HUB
-- ==========================================
local function runSyaaHub()
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
    local mainFrame = Instance.new("CanvasGroup")
    mainFrame.Size = UDim2.new(0,480,0,310); mainFrame.Position = UDim2.new(0.5,-240,0.5,-155)
    mainFrame.BackgroundColor3 = Color3.fromRGB(12,12,18); mainFrame.Visible = false; mainFrame.GroupTransparency = 1; mainFrame.Parent = screenGui
    Instance.new("UICorner",mainFrame).CornerRadius = UDim.new(0,15)
    local mainStroke = Instance.new("UIStroke",mainFrame); mainStroke.Thickness = 3
    local rainbowColor = Color3.fromRGB(0,150,255)
    task.spawn(function() while true do local hue=tick()%5/5; rainbowColor=Color3.fromHSV(hue,0.8,1); mainStroke.Color=rainbowColor; task.wait() end end)
    local title = Instance.new("TextLabel"); title.Text = "SYAA AYAM SANTAN🗿👍🏻"; title.Size = UDim2.new(1,0,0,40); title.Position = UDim2.new(0,0,0,5); title.TextColor3 = Color3.fromRGB(0,180,255); title.Font = Enum.Font.GothamBold; title.TextSize = 18; title.BackgroundTransparency = 1; title.Parent = mainFrame

    -- TAB BAR
    local tabBar = Instance.new("Frame"); tabBar.Size = UDim2.new(1,-20,0,28); tabBar.Position = UDim2.new(0,10,0,44); tabBar.BackgroundColor3 = Color3.fromRGB(18,18,26); tabBar.Parent = mainFrame
    Instance.new("UICorner",tabBar).CornerRadius = UDim.new(0,8)
    local tl = Instance.new("UIListLayout",tabBar); tl.FillDirection = Enum.FillDirection.Horizontal; tl.HorizontalAlignment = Enum.HorizontalAlignment.Left; tl.VerticalAlignment = Enum.VerticalAlignment.Center; tl.Padding = UDim.new(0,2)
    local tp2 = Instance.new("UIPadding",tabBar); tp2.PaddingLeft = UDim.new(0,4); tp2.PaddingRight = UDim.new(0,4)
    local tabNames = {"Freecam","Music","Orientation"}
    local tabBtns = {}; local tabPanels = {}; local activeTab = nil
    local function setTab(name)
        activeTab = name
        for _,n in ipairs(tabNames) do
            local btn = tabBtns[n]; local panel = tabPanels[n]
            if n==name then btn.BackgroundColor3=Color3.fromRGB(0,120,255); btn.TextColor3=Color3.new(1,1,1); panel.Visible=true
            else btn.BackgroundColor3=Color3.fromRGB(28,28,38); btn.TextColor3=Color3.fromRGB(140,140,180); panel.Visible=false end
        end
    end
    for _,name in ipairs(tabNames) do
        local btn = Instance.new("TextButton"); btn.Text = name; btn.Size = UDim2.new(0,140,1,-4); btn.BackgroundColor3 = Color3.fromRGB(28,28,38); btn.TextColor3 = Color3.fromRGB(140,140,180); btn.Font = Enum.Font.GothamBold; btn.TextSize = 11; btn.AutoButtonColor = false; btn.Parent = tabBar
        Instance.new("UICorner",btn).CornerRadius = UDim.new(0,6); tabBtns[name] = btn
        local panel
        if name=="Freecam" then
            panel = Instance.new("ScrollingFrame"); panel.ScrollBarThickness = 3; panel.ScrollBarImageColor3 = Color3.fromRGB(0,120,255); panel.ScrollBarImageTransparency = 0.4
            panel.AutomaticCanvasSize = Enum.AutomaticSize.Y; panel.CanvasSize = UDim2.new(0,0,0,0); panel.ScrollingDirection = Enum.ScrollingDirection.Y; panel.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
        else panel = Instance.new("Frame") end
        panel.Name = "Panel_"..name; panel.Size = UDim2.new(1,-20,1,-80); panel.Position = UDim2.new(0,10,0,78); panel.BackgroundTransparency = 1; panel.Visible = false; panel.Parent = mainFrame
        tabPanels[name] = panel
        btn.MouseButton1Click:Connect(function() setTab(name) end)
    end

    -- HELPERS
    local function makeIosRow(labelTxt, yOff, parent, onColor)
        onColor = onColor or Color3.fromRGB(0,140,255)
        local row = Instance.new("TextButton"); row.Size = UDim2.new(1,-8,0,34); row.Position = UDim2.new(0,4,0,yOff); row.BackgroundColor3 = Color3.fromRGB(28,28,38); row.Text = ""; row.AutoButtonColor = false; row.Parent = parent
        Instance.new("UICorner",row).CornerRadius = UDim.new(0,8)
        local lbl = Instance.new("TextLabel"); lbl.Text = labelTxt; lbl.Size = UDim2.new(1,-58,1,0); lbl.Position = UDim2.new(0,10,0,0); lbl.BackgroundTransparency = 1; lbl.TextColor3 = Color3.fromRGB(220,220,230); lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 11; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.Parent = row
        local track = Instance.new("Frame"); track.Size = UDim2.new(0,46,0,26); track.Position = UDim2.new(1,-52,0.5,-13); track.BackgroundColor3 = Color3.fromRGB(50,50,65); track.Parent = row; Instance.new("UICorner",track).CornerRadius = UDim.new(1,0)
        local knob = Instance.new("Frame"); knob.Size = UDim2.new(0,20,0,20); knob.Position = UDim2.new(0,3,0.5,-10); knob.BackgroundColor3 = Color3.fromRGB(255,255,255); knob.Parent = track; Instance.new("UICorner",knob).CornerRadius = UDim.new(1,0)
        local ks = Instance.new("UIStroke",knob); ks.Color = Color3.fromRGB(0,0,0); ks.Thickness = 1; ks.Transparency = 0.85
        local isOn = false
        local function setState(v)
            isOn = v
            if v then TweenService:Create(track,TweenInfo.new(0.2,Enum.EasingStyle.Quad),{BackgroundColor3=onColor}):Play(); TweenService:Create(knob,TweenInfo.new(0.18,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(1,-23,0.5,-10)}):Play()
            else TweenService:Create(track,TweenInfo.new(0.2,Enum.EasingStyle.Quad),{BackgroundColor3=Color3.fromRGB(50,50,65)}):Play(); TweenService:Create(knob,TweenInfo.new(0.18,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(0,3,0.5,-10)}):Play() end
        end
        return row, setState, function() return isOn end
    end
    local function makeLbl(txt,yOff,parent,sz,col)
        local l = Instance.new("TextLabel"); l.Text = txt; l.Size = UDim2.new(1,0,0,sz or 18); l.Position = UDim2.new(0,4,0,yOff); l.TextColor3 = col or Color3.fromRGB(180,180,200); l.BackgroundTransparency = 1; l.Font = Enum.Font.GothamBold; l.TextSize = 10; l.TextXAlignment = Enum.TextXAlignment.Left; l.Parent = parent; return l
    end
    local function makeSepHdr(txt,yOff,parent,col)
        local sep = Instance.new("Frame"); sep.Size = UDim2.new(0.92,0,0,1); sep.Position = UDim2.new(0.04,0,0,yOff-4); sep.BackgroundColor3 = Color3.fromRGB(35,35,50); sep.BorderSizePixel = 0; sep.Parent = parent
        return makeLbl(txt,yOff+2,parent,14,col or Color3.fromRGB(100,160,255))
    end
    local function makeBtn2(tA,tB,yOff,parent)
        local function b(txt,xS)
            local btn = Instance.new("TextButton"); btn.Text = txt; btn.Size = UDim2.new(0.44,0,0,30); btn.Position = UDim2.new(xS,0,0,yOff); btn.BackgroundColor3 = Color3.fromRGB(35,35,48); btn.TextColor3 = Color3.fromRGB(200,200,220); btn.Font = Enum.Font.GothamBold; btn.TextSize = 13; btn.Parent = parent; Instance.new("UICorner",btn).CornerRadius = UDim.new(0,6); return btn
        end
        return b(tA,0.04), b(tB,0.52)
    end
    local function makeBtn3(tA,tB,tC,yOff,parent)
        local function b(txt,xS)
            local btn = Instance.new("TextButton"); btn.Text = txt; btn.Size = UDim2.new(0.29,0,0,28); btn.Position = UDim2.new(xS,0,0,yOff); btn.BackgroundColor3 = Color3.fromRGB(30,30,42); btn.TextColor3 = Color3.fromRGB(200,200,220); btn.Font = Enum.Font.GothamBold; btn.TextSize = 10; btn.Parent = parent; Instance.new("UICorner",btn).CornerRadius = UDim.new(0,6); return btn
        end
        return b(tA,0.04), b(tB,0.355), b(tC,0.67)
    end

    -- PANEL FREECAM
    local pFC = tabPanels["Freecam"]
    local Y = 6
    local camRow, setCamState, getCamState = makeIosRow("Camera", Y, pFC, Color3.fromRGB(0,130,255)); Y = Y+38
    local hudRow, setHudState, getHudState = makeIosRow("Show HUD", Y, pFC, Color3.fromRGB(80,200,80)); Y = Y+38
    local lockRow, setLockState, getLockState = makeIosRow("Lock Target", Y, pFC, Color3.fromRGB(210,50,50)); Y = Y+38

    local sLbl = makeLbl("Smoothness: 50", Y, pFC); Y = Y+16
    local sBg = Instance.new("Frame"); sBg.Size = UDim2.new(0.88,0,0,5); sBg.Position = UDim2.new(0.06,0,0,Y); sBg.BackgroundColor3 = Color3.fromRGB(45,45,58); sBg.Parent = pFC; Instance.new("UICorner",sBg)
    local sFill = Instance.new("Frame"); sFill.Size = UDim2.new(0.5,0,1,0); sFill.BackgroundColor3 = Color3.fromRGB(0,150,255); sFill.BorderSizePixel = 0; sFill.Parent = sBg; Instance.new("UICorner",sFill)
    local sBtn = Instance.new("TextButton"); sBtn.Size = UDim2.new(0,18,0,18); sBtn.Position = UDim2.new(0.5,-9,0.5,-9); sBtn.Text = ""; sBtn.BackgroundColor3 = Color3.fromRGB(200,220,255); sBtn.Parent = sBg; Instance.new("UICorner",sBtn).CornerRadius = UDim.new(1,0)
    Y = Y+18
    local sSliding = false
    sBtn.MouseButton1Down:Connect(function() sSliding=true end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then sSliding=false end end)
    UserInputService.InputChanged:Connect(function(i)
        if sSliding and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            local pos = math.clamp((i.Position.X-sBg.AbsolutePosition.X)/sBg.AbsoluteSize.X,0,1)
            sFill.Size = UDim2.new(pos,0,1,0); sBtn.Position = UDim2.new(pos,-9,0.5,-9); smoothValue = math.floor(pos*100); sLbl.Text = "Smoothness: "..smoothValue
        end
    end)

    local spLbl = makeLbl("Speed: 15", Y, pFC); Y = Y+16
    local spMinus, spPlus = makeBtn2("−","+",Y,pFC); Y = Y+34
    spMinus.MouseButton1Click:Connect(function() moveSpeed=math.clamp(moveSpeed-5,1,500); spLbl.Text="Speed: "..moveSpeed end)
    spPlus.MouseButton1Click:Connect(function() moveSpeed=math.clamp(moveSpeed+5,1,500); spLbl.Text="Speed: "..moveSpeed end)

    makeSepHdr("Auto-Walk", Y, pFC, Color3.fromRGB(100,200,255)); Y = Y+20
    local awSpdLab = makeLbl("AW Speed: 10", Y, pFC, 14, Color3.fromRGB(150,150,180)); Y = Y+18
    local awFwd, awStop, awBack = makeBtn3("Maju","Stop","Mundur",Y,pFC); Y = Y+32
    local awSpdD, _awMid, awSpdU = makeBtn3("−","","＋",Y,pFC); Y = Y+32
    _awMid.BackgroundTransparency = 1; awSpdU.BackgroundColor3 = Color3.fromRGB(0,70,150)
    awFwd.MouseButton1Click:Connect(function() autoWalkActive=true; autoWalkDirection=1; awFwd.BackgroundColor3=Color3.fromRGB(0,100,0); awStop.BackgroundColor3=Color3.fromRGB(30,30,42); awBack.BackgroundColor3=Color3.fromRGB(30,30,42) end)
    awStop.MouseButton1Click:Connect(function() autoWalkActive=false; autoWalkDirection=0; moveInputs.F=0; moveInputs.B=0; awFwd.BackgroundColor3=Color3.fromRGB(30,30,42); awStop.BackgroundColor3=Color3.fromRGB(80,60,0); awBack.BackgroundColor3=Color3.fromRGB(30,30,42) end)
    awBack.MouseButton1Click:Connect(function() autoWalkActive=true; autoWalkDirection=-1; awFwd.BackgroundColor3=Color3.fromRGB(30,30,42); awStop.BackgroundColor3=Color3.fromRGB(30,30,42); awBack.BackgroundColor3=Color3.fromRGB(100,0,0) end)
    awSpdD.MouseButton1Click:Connect(function() autoWalkSpeed=math.max(autoWalkSpeed-5,1); awSpdLab.Text="AW Speed: "..autoWalkSpeed end)
    awSpdU.MouseButton1Click:Connect(function() autoWalkSpeed=math.min(autoWalkSpeed+5,200); awSpdLab.Text="AW Speed: "..autoWalkSpeed end)
    RunService.Heartbeat:Connect(function()
        if autoWalkActive and autoWalkDirection~=0 then moveInputs.F=math.max(0,autoWalkDirection); moveInputs.B=math.max(0,-autoWalkDirection) end
    end)

    makeSepHdr("CINEMATIC MODE", Y, pFC, Color3.fromRGB(180,100,255)); Y = Y+20
    local cinRow, setCinState, getCinState = makeIosRow("Cinematic ON/OFF", Y, pFC, Color3.fromRGB(120,40,220)); Y = Y+38
    local blurLab = makeLbl("Blur Intensity: 20", Y, pFC, 14, Color3.fromRGB(200,160,255)); Y = Y+16
    local blBg = Instance.new("Frame"); blBg.Size = UDim2.new(0.88,0,0,5); blBg.Position = UDim2.new(0.06,0,0,Y); blBg.BackgroundColor3 = Color3.fromRGB(45,35,65); blBg.Parent = pFC; Instance.new("UICorner",blBg)
    local blFill = Instance.new("Frame"); blFill.Size = UDim2.new(blurAmount/56,0,1,0); blFill.BackgroundColor3 = Color3.fromRGB(140,60,255); blFill.BorderSizePixel = 0; blFill.Parent = blBg; Instance.new("UICorner",blFill)
    local blKnob = Instance.new("TextButton"); blKnob.Size = UDim2.new(0,18,0,18); blKnob.Position = UDim2.new(blurAmount/56,-9,0.5,-9); blKnob.Text = ""; blKnob.BackgroundColor3 = Color3.fromRGB(190,140,255); blKnob.Parent = blBg; Instance.new("UICorner",blKnob).CornerRadius = UDim.new(1,0)
    Y = Y+18
    local blurSld = false
    blKnob.MouseButton1Down:Connect(function() blurSld=true end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then blurSld=false end end)
    UserInputService.InputChanged:Connect(function(i)
        if blurSld and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            local pos = math.clamp((i.Position.X-blBg.AbsolutePosition.X)/blBg.AbsoluteSize.X,0,1)
            blFill.Size = UDim2.new(pos,0,1,0); blKnob.Position = UDim2.new(pos,-9,0.5,-9); blurAmount = math.floor(pos*56); blurLab.Text = "Blur Intensity: "..blurAmount
            if cinematicActive and blurEffect then blurEffect.Size = blurAmount end
        end
    end)

    makeLbl("🎯 Pilih siapa yang di-focus", Y, pFC, 14, Color3.fromRGB(200,150,255)); Y = Y+18
    local refreshBtn, clearBtn = makeBtn2("↺ Refresh","✕ Clear All",Y,pFC); Y = Y+34

    local plFrame = Instance.new("ScrollingFrame")
    plFrame.Size = UDim2.new(0.92,0,0,100); plFrame.Position = UDim2.new(0.04,0,0,Y)
    plFrame.BackgroundColor3 = Color3.fromRGB(14,10,24); plFrame.Parent = pFC
    plFrame.ScrollBarThickness = 3; plFrame.ScrollBarImageColor3 = Color3.fromRGB(140,60,255)
    plFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y; plFrame.CanvasSize = UDim2.new(0,0,0,0); plFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    Instance.new("UICorner",plFrame).CornerRadius = UDim.new(0,8)
    Instance.new("UIStroke",plFrame).Color = Color3.fromRGB(60,28,100)
    local plLayout = Instance.new("UIListLayout",plFrame); plLayout.Padding = UDim.new(0,4); plLayout.SortOrder = Enum.SortOrder.Name
    local plPad = Instance.new("UIPadding",plFrame); plPad.PaddingTop = UDim.new(0,4); plPad.PaddingLeft = UDim.new(0,4); plPad.PaddingRight = UDim.new(0,4); plPad.PaddingBottom = UDim.new(0,4)
    Y = Y+110
    local bPad = Instance.new("Frame"); bPad.Size = UDim2.new(1,0,0,12); bPad.Position = UDim2.new(0,0,0,Y); bPad.BackgroundTransparency = 1; bPad.Parent = pFC

    local playerRows = {}
    local function refreshPlayerList()
        for _,r in pairs(playerRows) do pcall(function() r:Destroy() end) end; playerRows = {}
        local list = Players:GetPlayers()
        if #list==0 then
            local el = Instance.new("TextLabel"); el.Size = UDim2.new(1,0,0,28); el.BackgroundTransparency = 1; el.Text = "Tidak ada player lain"; el.TextColor3 = Color3.fromRGB(80,70,100); el.Font = Enum.Font.Gotham; el.TextSize = 10; el.Parent = plFrame; table.insert(playerRows,el); return
        end
        for _,p in ipairs(list) do
            local pName = p.Name; local dName = p.DisplayName; local focused = focusedPlayers[pName]==true
            local row = Instance.new("TextButton"); row.Size = UDim2.new(1,0,0,30); row.Name = "PR_"..pName; row.BackgroundColor3 = focused and Color3.fromRGB(50,18,100) or Color3.fromRGB(20,15,35); row.Text = ""; row.AutoButtonColor = false; row.Parent = plFrame
            Instance.new("UICorner",row).CornerRadius = UDim.new(0,6)
            if focused then local rs = Instance.new("UIStroke",row); rs.Color = Color3.fromRGB(130,55,255); rs.Thickness = 1 end
            local dot = Instance.new("Frame"); dot.Size = UDim2.new(0,6,0,6); dot.Position = UDim2.new(0,7,0.5,-3); dot.BackgroundColor3 = focused and Color3.fromRGB(155,75,255) or Color3.fromRGB(50,45,70); dot.Parent = row; Instance.new("UICorner",dot).CornerRadius = UDim.new(1,0)
            local nl = Instance.new("TextLabel"); nl.Size = UDim2.new(1,-48,1,0); nl.Position = UDim2.new(0,18,0,0); nl.BackgroundTransparency = 1; nl.Text = (focused and "◉ " or "○ ")..dName.."  @"..pName; nl.TextColor3 = focused and Color3.fromRGB(200,150,255) or Color3.fromRGB(150,145,175); nl.Font = Enum.Font.GothamBold; nl.TextSize = 10; nl.TextXAlignment = Enum.TextXAlignment.Left; nl.Parent = row
            if focused then local badge = Instance.new("TextLabel"); badge.Size = UDim2.new(0,42,0,16); badge.Position = UDim2.new(1,-46,0.5,-8); badge.BackgroundColor3 = Color3.fromRGB(90,35,190); badge.Text = "FOCUS"; badge.TextColor3 = Color3.fromRGB(220,180,255); badge.Font = Enum.Font.GothamBold; badge.TextSize = 7; badge.Parent = row; Instance.new("UICorner",badge).CornerRadius = UDim.new(0,4) end
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

    -- MUSIC PANEL
    local pMS = tabPanels["Music"]
    local musicBox = Instance.new("TextBox"); musicBox.Size = UDim2.new(0.9,0,0,36); musicBox.Position = UDim2.new(0.05,0,0,40); musicBox.PlaceholderText = "ID Music..."; musicBox.BackgroundColor3 = Color3.fromRGB(35,35,45); musicBox.TextColor3 = Color3.new(1,1,1); musicBox.Font = Enum.Font.Gotham; musicBox.TextSize = 11; musicBox.Parent = pMS; Instance.new("UICorner",musicBox)
    local playBtn = Instance.new("TextButton"); playBtn.Text = "PLAY/STOP"; playBtn.Size = UDim2.new(0.9,0,0,36); playBtn.Position = UDim2.new(0.05,0,0,84); playBtn.BackgroundColor3 = Color3.fromRGB(0,120,255); playBtn.TextColor3 = Color3.new(1,1,1); playBtn.Font = Enum.Font.GothamBold; playBtn.TextSize = 11; playBtn.Parent = pMS; Instance.new("UICorner",playBtn)
    local bgMusic = Instance.new("Sound",game:GetService("SoundService")); bgMusic.Looped = true
    playBtn.MouseButton1Click:Connect(function()
        if bgMusic.IsPlaying then bgMusic:Stop(); playBtn.BackgroundColor3=Color3.fromRGB(0,120,255)
        else bgMusic.SoundId="rbxassetid://"..musicBox.Text; bgMusic:Play(); playBtn.BackgroundColor3=Color3.fromRGB(0,200,80) end
    end)
    local volLab = makeLbl("Volume: 50", 128, pMS, 14, Color3.fromRGB(160,200,255))
    local vBg = Instance.new("Frame"); vBg.Size = UDim2.new(0.88,0,0,5); vBg.Position = UDim2.new(0.06,0,0,145); vBg.BackgroundColor3 = Color3.fromRGB(45,45,58); vBg.Parent = pMS; Instance.new("UICorner",vBg)
    local vFill = Instance.new("Frame"); vFill.Size = UDim2.new(0.5,0,1,0); vFill.BackgroundColor3 = Color3.fromRGB(0,200,80); vFill.BorderSizePixel = 0; vFill.Parent = vBg; Instance.new("UICorner",vFill)
    local vBtn = Instance.new("TextButton"); vBtn.Size = UDim2.new(0,18,0,18); vBtn.Position = UDim2.new(0.5,-9,0.5,-9); vBtn.Text = ""; vBtn.BackgroundColor3 = Color3.fromRGB(180,255,200); vBtn.Parent = vBg; Instance.new("UICorner",vBtn).CornerRadius = UDim.new(1,0)
    bgMusic.Volume = 0.5; local volSld = false
    vBtn.MouseButton1Down:Connect(function() volSld=true end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then volSld=false end end)
    UserInputService.InputChanged:Connect(function(i)
        if volSld and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            local pos = math.clamp((i.Position.X-vBg.AbsolutePosition.X)/vBg.AbsoluteSize.X,0,1)
            vFill.Size = UDim2.new(pos,0,1,0); vBtn.Position = UDim2.new(pos,-9,0.5,-9); bgMusic.Volume = pos; volLab.Text = "Volume: "..math.floor(pos*100)
        end
    end)

    -- ORIENTATION PANEL
    local pOR = tabPanels["Orientation"]
    local function bRot(t,y,orient)
        local b = Instance.new("TextButton"); b.Text = t; b.Size = UDim2.new(0.9,0,0,36); b.Position = UDim2.new(0.05,0,0,y); b.BackgroundColor3 = Color3.fromRGB(35,35,45); b.TextColor3 = Color3.new(1,1,1); b.Font = Enum.Font.GothamBold; b.TextSize = 10; b.Parent = pOR; Instance.new("UICorner",b)
        b.MouseButton1Click:Connect(function() localPlayer.PlayerGui.ScreenOrientation=orient end)
    end
    bRot("PORTRAIT",40,Enum.ScreenOrientation.Portrait); bRot("LAND LEFT",82,Enum.ScreenOrientation.LandscapeLeft); bRot("LAND RIGHT",124,Enum.ScreenOrientation.LandscapeRight)
    local briLab = makeLbl("Brightness: 1.0",170,pOR,14,Color3.fromRGB(200,200,200))
    local brBg = Instance.new("Frame"); brBg.Size = UDim2.new(0.88,0,0,5); brBg.Position = UDim2.new(0.06,0,0,186); brBg.BackgroundColor3 = Color3.fromRGB(45,45,58); brBg.Parent = pOR; Instance.new("UICorner",brBg)
    local brFill = Instance.new("Frame"); brFill.Size = UDim2.new(0.5,0,1,0); brFill.BackgroundColor3 = Color3.fromRGB(255,220,80); brFill.BorderSizePixel = 0; brFill.Parent = brBg; Instance.new("UICorner",brFill)
    local brBtn = Instance.new("TextButton"); brBtn.Size = UDim2.new(0,18,0,18); brBtn.Position = UDim2.new(0.5,-9,0.5,-9); brBtn.Text = ""; brBtn.BackgroundColor3 = Color3.fromRGB(255,240,180); brBtn.Parent = brBg; Instance.new("UICorner",brBtn).CornerRadius = UDim.new(1,0)
    local briSld = false
    brBtn.MouseButton1Down:Connect(function() briSld=true end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then briSld=false end end)
    UserInputService.InputChanged:Connect(function(i)
        if briSld and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            local pos = math.clamp((i.Position.X-brBg.AbsolutePosition.X)/brBg.AbsoluteSize.X,0,1)
            brFill.Size = UDim2.new(pos,0,1,0); brBtn.Position = UDim2.new(pos,-9,0.5,-9); Lighting.Brightness=pos*3; briLab.Text="Brightness: "..string.format("%.1f",pos*3)
        end
    end)
    local timeBtn = Instance.new("TextButton"); timeBtn.Text = "Time: Siang"; timeBtn.Size = UDim2.new(0.9,0,0,30); timeBtn.Position = UDim2.new(0.05,0,0,208); timeBtn.BackgroundColor3 = Color3.fromRGB(30,30,42); timeBtn.TextColor3 = Color3.new(1,1,1); timeBtn.Font = Enum.Font.GothamBold; timeBtn.TextSize = 10; timeBtn.Parent = pOR; Instance.new("UICorner",timeBtn)
    local isNight = false
    timeBtn.MouseButton1Click:Connect(function()
        isNight = not isNight
        if isNight then Lighting.ClockTime=0; timeBtn.Text="Time: Malam"; timeBtn.BackgroundColor3=Color3.fromRGB(20,20,80)
        else Lighting.ClockTime=14; timeBtn.Text="Time: Siang"; timeBtn.BackgroundColor3=Color3.fromRGB(30,30,42) end
    end)

    -- SIDEBAR & ARROW
    local arrowIcon = Instance.new("ImageButton"); arrowIcon.Size = UDim2.new(0,100,0,100); arrowIcon.Position = UDim2.new(0,20,0.5,-50); arrowIcon.BackgroundTransparency = 1; arrowIcon.Image = "rbxassetid://87411882585742"; arrowIcon.ImageColor3 = Color3.new(1,1,1); arrowIcon.Parent = screenGui
    local sidebar = Instance.new("CanvasGroup"); sidebar.Size = UDim2.new(0,44,0,130); sidebar.Position = UDim2.new(0,108,0.5,-65); sidebar.BackgroundColor3 = Color3.fromRGB(10,10,10); sidebar.Visible = false; sidebar.GroupTransparency = 1; sidebar.Parent = screenGui
    Instance.new("UICorner",sidebar).CornerRadius = UDim.new(0,15); Instance.new("UIStroke",sidebar).Color = Color3.fromRGB(50,50,50)
    local function toggleMainFrame(state)
        if state then
            mainFrame.Visible = true; mainFrame.Size = UDim2.new(0,300,0,200)
            TweenService:Create(mainFrame,TweenInfo.new(0.6,Enum.EasingStyle.Back),{Size=UDim2.new(0,480,0,310),GroupTransparency=0}):Play()
            if activeTab==nil then setTab("Freecam") end
        else
            local t = TweenService:Create(mainFrame,TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Size=UDim2.new(0,100,0,60),GroupTransparency=1})
            t:Play(); t.Completed:Connect(function() mainFrame.Visible=false end)
        end
    end
    local function toggleSidebar(state)
        if state then
            sidebar.Visible = true; sidebar.Position = UDim2.new(0,85,0.5,-65)
            TweenService:Create(sidebar,TweenInfo.new(0.4,Enum.EasingStyle.Back),{Position=UDim2.new(0,108,0.5,-65),GroupTransparency=0}):Play()
        else
            toggleMainFrame(false)
            local t = TweenService:Create(sidebar,TweenInfo.new(0.3,Enum.EasingStyle.Quart,Enum.EasingDirection.In),{Position=UDim2.new(0,85,0.5,-65),GroupTransparency=1})
            t:Play(); t.Completed:Connect(function() sidebar.Visible=false end)
        end
    end
    local function makeNav(assetId, pos, ntype)
        local b = Instance.new("ImageButton"); b.Size = UDim2.new(0,30,0,30); b.Position = UDim2.new(0.5,-15,0,pos); b.BackgroundColor3 = Color3.fromRGB(25,25,25); b.Image = "rbxassetid://"..assetId; b.Parent = sidebar; Instance.new("UICorner",b).CornerRadius = UDim.new(1,0)
        task.spawn(function() while true do b.ImageColor3=rainbowColor; task.wait() end end)
        b.MouseButton1Click:Connect(function() if ntype=="main" then toggleMainFrame(not mainFrame.Visible) end end)
    end
    makeNav("76171785807172",10,"main"); makeNav("71238002381358",50,"other"); makeNav("130750947504299",90,"other")
    arrowIcon.MouseButton1Click:Connect(function() toggleSidebar(not sidebar.Visible) end)
    local draggingIcon = false; local dragStartPos, iconStartPos
    arrowIcon.InputBegan:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then draggingIcon=true; dragStartPos=input.Position; iconStartPos=arrowIcon.Position end end)
    UserInputService.InputChanged:Connect(function(input) if draggingIcon and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then local delta=input.Position-dragStartPos; arrowIcon.Position=UDim2.new(iconStartPos.X.Scale,iconStartPos.X.Offset+delta.X,iconStartPos.Y.Scale,iconStartPos.Y.Offset+delta.Y); if sidebar.Visible then sidebar.Position=UDim2.new(0,arrowIcon.AbsolutePosition.X+88,0,arrowIcon.AbsolutePosition.Y-15) end end end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then draggingIcon=false end end)

    -- HUD MOBILE
    local hud = Instance.new("Frame"); hud.Size = UDim2.new(1,0,1,0); hud.BackgroundTransparency = 1; hud.Visible = false; hud.Parent = screenGui
    local function bHUD(t,p,k,type)
        local b = Instance.new("TextButton"); b.Text = t; b.Size = UDim2.new(0,55,0,55); b.Position = p; b.BackgroundColor3 = Color3.fromRGB(15,15,20); b.TextColor3 = Color3.fromRGB(0,180,255); b.Font = Enum.Font.GothamBold; b.Parent = hud; Instance.new("UICorner",b).CornerRadius = UDim.new(1,0)
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
            awFwd.BackgroundColor3=Color3.fromRGB(30,30,42); awStop.BackgroundColor3=Color3.fromRGB(30,30,42); awBack.BackgroundColor3=Color3.fromRGB(30,30,42)
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
    -- RENDER ENGINE - HYBRID UNLIMITED ZOOM FIX (Anti-Jitter)
    -- ==========================================
    RunService:BindToRenderStep("SyaaaEngine", Enum.RenderPriority.Camera.Value+1, function(dt)
        if not isFreecamActive then return end
        local rotAlpha = math.clamp(dt*((101-smoothValue)/10),0.01,1)
        
        -- Input arah pergerakan dasar
        local rawMove = Vector3.new(moveInputs.R-moveInputs.L, moveInputs.U-moveInputs.D, moveInputs.B-moveInputs.F)
        
        -- HYBRID ZOOM LOGIC
        -- FOV maksimal aman = 170, minimal = 1
        if zoomInputs.In == 1 then 
            if targetFov > 1 then
                targetFov = math.clamp(targetFov - 1.5, 1, 170)
            else
                -- Kalo FOV udah mentok sempit, otomatis MAJU fisik kameranya
                rawMove = rawMove + Vector3.new(0, 0, -1.5)
            end
        end
        if zoomInputs.Out == 1 then 
            if targetFov < 170 then
                targetFov = math.clamp(targetFov + 1.5, 1, 170)
            else
                -- Kalo FOV udah mentok luas, otomatis MUNDUR fisik kameranya (True Unli Zoom)
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
            -- Fix Jitter: Orientasi duluan baru Posisi
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
