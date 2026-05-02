-- [[ SYAAA HUB V8.0 - BLUE THEME + SPY CAM + CUSTOM JUMP + STABILIZER ]] --

if not game:IsLoaded() then 
    game.Loaded:Wait() 
end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local localPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SyaaaHub_V8_Stab"
screenGui.ResetOnSpawn = false

local coreGui
pcall(function() coreGui = gethui and gethui() end)
screenGui.Parent = coreGui or game:GetService("CoreGui")

local devAvaUrl = "rbxthumb://type=AvatarHeadShot&id=0&w=150&h=150"
local playerAvaUrl = "rbxthumb://type=AvatarHeadShot&id="..localPlayer.UserId.."&w=150&h=150"

task.spawn(function()
    pcall(function()
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
    loadBG.BackgroundColor3 = Color3.fromRGB(5,10,25); loadBG.BackgroundTransparency = 0.15; loadBG.Parent = screenGui
    Instance.new("UICorner",loadBG).CornerRadius = UDim.new(0,15)
    local strokeL = Instance.new("UIStroke",loadBG); strokeL.Color = Color3.fromRGB(0,100,230); strokeL.Thickness = 2
    
    local titleL = Instance.new("TextLabel"); titleL.Text = "SYAA"; titleL.Size = UDim2.new(1,0,0,40); titleL.Position = UDim2.new(0,0,0,15); titleL.TextColor3 = Color3.fromRGB(255,255,255); titleL.Font = Enum.Font.GothamBold; titleL.TextSize = 32; titleL.BackgroundTransparency = 1; titleL.Parent = loadBG
    local percentLabel = Instance.new("TextLabel"); percentLabel.Text = "0%"; percentLabel.Size = UDim2.new(1,0,0,20); percentLabel.Position = UDim2.new(0,0,0,60); percentLabel.TextColor3 = Color3.fromRGB(50,150,255); percentLabel.Font = Enum.Font.Code; percentLabel.TextSize = 13; percentLabel.BackgroundTransparency = 1; percentLabel.Parent = loadBG
    local barOutline = Instance.new("Frame"); barOutline.Size = UDim2.new(0.7,0,0,4); barOutline.Position = UDim2.new(0.15,0,0,85); barOutline.BackgroundColor3 = Color3.fromRGB(20,20,20); barOutline.Parent = loadBG; Instance.new("UICorner",barOutline)
    local barFill = Instance.new("Frame"); barFill.Size = UDim2.new(0,0,1,0); barFill.BackgroundColor3 = Color3.fromRGB(0,120,255); barFill.BorderSizePixel = 0; barFill.Parent = barOutline; Instance.new("UICorner",barFill)
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
        closeTween:Play(); closeTween.Completed:Wait(); loadBG:Destroy()

        task.spawn(function()
            local updFrame = Instance.new("Frame")
            updFrame.Size = UDim2.new(0, 280, 0, 70)
            updFrame.Position = UDim2.new(1, 20, 1, -175)
            updFrame.BackgroundColor3 = Color3.fromRGB(5, 10, 25)
            updFrame.BackgroundTransparency = 0.15
            updFrame.Parent = screenGui
            Instance.new("UICorner", updFrame).CornerRadius = UDim.new(0, 10)
            local updStroke = Instance.new("UIStroke", updFrame); updStroke.Color = Color3.fromRGB(0, 120, 255); updStroke.Thickness = 1.5

            local iconLbl = Instance.new("TextLabel")
            iconLbl.Text = "🔔"; iconLbl.Size = UDim2.new(0, 40, 0, 40)
            iconLbl.Position = UDim2.new(0, 10, 0.5, -20)
            iconLbl.BackgroundTransparency = 1; iconLbl.TextSize = 22
            iconLbl.Font = Enum.Font.GothamBold; iconLbl.Parent = updFrame

            local updTitle = Instance.new("TextLabel")
            updTitle.Text = "SYAA HUB V8.0"; updTitle.Size = UDim2.new(1, -55, 0, 22)
            updTitle.Position = UDim2.new(0, 55, 0, 10)
            updTitle.BackgroundTransparency = 1; updTitle.TextColor3 = Color3.fromRGB(0, 180, 255)
            updTitle.Font = Enum.Font.GothamBold; updTitle.TextSize = 13
            updTitle.TextXAlignment = Enum.TextXAlignment.Left; updTitle.Parent = updFrame

            local updDesc = Instance.new("TextLabel")
            updDesc.Text = "Stabilizer Karakter + Kamera Baru 🚀"; updDesc.Size = UDim2.new(1, -60, 0, 28)
            updDesc.Position = UDim2.new(0, 55, 0, 34)
            updDesc.BackgroundTransparency = 1; updDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
            updDesc.Font = Enum.Font.Gotham; updDesc.TextSize = 10
            updDesc.TextWrapped = true; updDesc.TextXAlignment = Enum.TextXAlignment.Left; updDesc.Parent = updFrame

            TweenService:Create(updFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(1, -300, 1, -175)}):Play()
            task.wait(5)
            local twOut = TweenService:Create(updFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(1, 20, 1, -175)})
            twOut:Play(); twOut.Completed:Wait(); updFrame:Destroy()
        end)

        callback()
    end)
end

-- ==========================================
-- MAIN HUB
-- ==========================================
local function runSyaaHub()
    local openIcon = Instance.new("ImageButton")
    openIcon.Size = UDim2.new(0, 0, 0, 0)
    openIcon.Position = UDim2.new(0, 30, 0.5, -32.5)
    openIcon.BackgroundTransparency = 1
    openIcon.Image = "rbxassetid://87411882585742"
    openIcon.ImageColor3 = Color3.fromRGB(0, 150, 255)
    openIcon.Visible = true 
    openIcon.Parent = screenGui

    TweenService:Create(openIcon, TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {Size = UDim2.new(0, 65, 0, 65)}):Play()

    local rainbowColor = Color3.fromRGB(0,120,255)
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

    task.spawn(function()
        local notifFrame = Instance.new("Frame")
        notifFrame.Size = UDim2.new(0, 280, 0, 75)
        notifFrame.Position = UDim2.new(1, 20, 1, -90) 
        notifFrame.BackgroundColor3 = Color3.fromRGB(5, 10, 25)
        notifFrame.BackgroundTransparency = 0.15
        notifFrame.Parent = screenGui
        Instance.new("UICorner", notifFrame).CornerRadius = UDim.new(0, 10)
        Instance.new("UIStroke", notifFrame).Color = Color3.fromRGB(0, 120, 255)

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
        titleLbl.TextColor3 = Color3.fromRGB(0, 120, 255)
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

        local twIn = TweenService:Create(notifFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(1, -300, 1, -90)})
        twIn:Play()
        task.wait(5) 
        local twOut = TweenService:Create(notifFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(1, 20, 1, -90)})
        twOut:Play()
        twOut.Completed:Wait()
        notifFrame:Destroy()
    end)

    -- ENGINE VARIABLES
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
    local PlayerModule = require(localPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()

    -- STABILIZER VARIABLES
    local stabilizerActive = false
    local stabYaw = 0
    local stabPitch = 0
    local lastSwipeTime = 0
    local STAB_RETURN_DELAY = 0.8
    local STAB_STRENGTH = 0.15
    -- Character stabilizer
    local CHAR_STAB_STRENGTH = 0.85   -- seberapa kuat horizontal velocity diredam (0=off, 1=totally frozen)
    local charStabActive = false       -- ngikut stabilizerActive, diset bareng

    -- ==========================================
    -- CHARACTER STABILIZER LOOP
    -- ==========================================
    -- Logika: saat karakter di udara (jumping/falling), redam horizontal velocity
    -- supaya karakter ga kepleset ke kiri/kanan saat lompat di tangga/obstacle
    RunService.Heartbeat:Connect(function(dt)
        if not stabilizerActive then return end
        local char = localPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end

        -- Cek apakah karakter lagi di udara
        local state = hum:GetState()
        local isAirborne = (
            state == Enum.HumanoidStateType.Jumping or
            state == Enum.HumanoidStateType.Freefall
        )

        if isAirborne then
            local vel = hrp.AssemblyLinearVelocity
            -- Pisahkan komponen horizontal dan vertikal
            local horizontalVel = Vector3.new(vel.X, 0, vel.Z)
            local verticalVel = Vector3.new(0, vel.Y, 0)

            -- Redam horizontal velocity berdasarkan CHAR_STAB_STRENGTH
            -- Semakin tinggi strength, makin sedikit horizontal drift
            local dampedHorizontal = horizontalVel * (1 - math.clamp(CHAR_STAB_STRENGTH, 0, 0.97))

            -- Terapkan velocity baru (vertikal tetap utuh supaya lompat normal)
            hrp.AssemblyLinearVelocity = dampedHorizontal + verticalVel
        end
    end)

    -- ==========================================
    -- CUSTOM JUMP BUTTON SYSTEM
    -- ==========================================
    local customJumpActive = false
    local customJumpSize = 80
    local customJumpX = 0.85
    local customJumpY = 0.75

    local function hideOriginalJump(hide)
        pcall(function()
            local playerGui = localPlayer:WaitForChild("PlayerGui")
            local touchGui = playerGui:FindFirstChild("TouchGui")
            if touchGui then
                local touchFrame = touchGui:FindFirstChild("TouchControlFrame")
                if touchFrame then
                    local jumpBtn = touchFrame:FindFirstChild("JumpButton")
                    if jumpBtn then
                        jumpBtn.Visible = not hide
                    end
                end
            end
        end)
        pcall(function()
            local StarterGui = game:GetService("StarterGui")
            if hide then
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
                for _, gui in pairs(localPlayer.PlayerGui:GetDescendants()) do
                    if gui.Name == "JumpButton" then
                        gui.Visible = false
                    end
                end
            else
                for _, gui in pairs(localPlayer.PlayerGui:GetDescendants()) do
                    if gui.Name == "JumpButton" then
                        gui.Visible = true
                    end
                end
            end
        end)
    end

    local jumpContainer = Instance.new("Frame")
    jumpContainer.Name = "SyaaJumpContainer"
    jumpContainer.Size = UDim2.new(0, customJumpSize, 0, customJumpSize)
    jumpContainer.Position = UDim2.new(customJumpX, -customJumpSize/2, customJumpY, -customJumpSize/2)
    jumpContainer.BackgroundTransparency = 1
    jumpContainer.Visible = false
    jumpContainer.ZIndex = 10
    jumpContainer.Parent = screenGui

    local jumpBtn = Instance.new("ImageButton")
    jumpBtn.Name = "SyaaJumpBtn"
    jumpBtn.Size = UDim2.new(1, 0, 1, 0)
    jumpBtn.Position = UDim2.new(0, 0, 0, 0)
    jumpBtn.BackgroundTransparency = 1
    jumpBtn.Image = "rbxassetid://132246991346105"
    jumpBtn.ImageColor3 = Color3.fromRGB(255, 255, 255)
    jumpBtn.ZIndex = 11
    jumpBtn.Parent = jumpContainer

    local function spawnJumpParticles()
        local centerX = jumpContainer.AbsolutePosition.X + jumpContainer.AbsoluteSize.X / 2
        local centerY = jumpContainer.AbsolutePosition.Y + jumpContainer.AbsoluteSize.Y / 2

        for i = 1, 12 do
            local particle = Instance.new("Frame")
            particle.ZIndex = 15
            particle.BackgroundColor3 = Color3.fromHSV(0.6 + math.random(-5,5)*0.01, 0.8 + math.random()*0.2, 1)
            particle.BackgroundTransparency = 0.1
            particle.BorderSizePixel = 0
            local pSize = math.random(5, 14)
            particle.Size = UDim2.new(0, pSize, 0, pSize)
            particle.Position = UDim2.new(0, centerX - pSize/2, 0, centerY - pSize/2)
            particle.Parent = screenGui
            Instance.new("UICorner", particle).CornerRadius = UDim.new(1, 0)

            local angle = math.rad(math.random(0, 360))
            local dist = math.random(40, 90)
            local targetX = centerX + math.cos(angle) * dist - pSize/2
            local targetY = centerY + math.sin(angle) * dist - pSize/2

            local stroke = Instance.new("UIStroke", particle)
            stroke.Color = Color3.fromRGB(0, 180, 255)
            stroke.Thickness = 1.5
            stroke.Transparency = 0

            local moveTween = TweenService:Create(particle, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(0, targetX, 0, targetY),
                BackgroundTransparency = 1,
                Size = UDim2.new(0, pSize * 0.3, 0, pSize * 0.3)
            })
            moveTween:Play()
            TweenService:Create(stroke, TweenInfo.new(0.4), {Transparency = 1}):Play()

            task.delay(0.5, function()
                pcall(function() particle:Destroy() end)
            end)
        end

        local ring = Instance.new("Frame")
        ring.ZIndex = 12
        ring.BackgroundTransparency = 1
        ring.Size = UDim2.new(0, customJumpSize * 0.6, 0, customJumpSize * 0.6)
        ring.Position = UDim2.new(0, centerX - customJumpSize*0.3, 0, centerY - customJumpSize*0.3)
        ring.Parent = screenGui
        Instance.new("UICorner", ring).CornerRadius = UDim.new(1, 0)
        local ringStroke = Instance.new("UIStroke", ring)
        ringStroke.Color = Color3.fromRGB(0, 150, 255)
        ringStroke.Thickness = 3
        ringStroke.Transparency = 0.2

        TweenService:Create(ring, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, customJumpSize * 1.4, 0, customJumpSize * 1.4),
            Position = UDim2.new(0, centerX - customJumpSize*0.7, 0, centerY - customJumpSize*0.7)
        }):Play()
        TweenService:Create(ringStroke, TweenInfo.new(0.4), {Transparency = 1}):Play()
        task.delay(0.45, function() pcall(function() ring:Destroy() end) end)

        TweenService:Create(jumpBtn, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(1.25, 0, 1.25, 0),
            Position = UDim2.new(-0.125, 0, -0.125, 0)
        }):Play()
        task.delay(0.1, function()
            TweenService:Create(jumpBtn, TweenInfo.new(0.15, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                Size = UDim2.new(1, 0, 1, 0),
                Position = UDim2.new(0, 0, 0, 0)
            }):Play()
        end)
    end

    local function updateJumpBtn()
        jumpContainer.Size = UDim2.new(0, customJumpSize, 0, customJumpSize)
        jumpContainer.Position = UDim2.new(customJumpX, -customJumpSize/2, customJumpY, -customJumpSize/2)
    end

    jumpBtn.MouseButton1Down:Connect(function()
        spawnJumpParticles()
        local char = localPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end)

    jumpBtn.TouchLongPress:Connect(function() end)
    jumpBtn.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch then
            spawnJumpParticles()
            local char = localPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end
    end)

    localPlayer.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        if customJumpActive then
            hideOriginalJump(true)
        end
    end)

    -- SHIFTLOCK
    local shiftlockBtn = Instance.new("ImageButton")
    shiftlockBtn.Size = UDim2.new(0, 85, 0, 85) 
    shiftlockBtn.AnchorPoint = Vector2.new(0.5, 0.5)
    shiftlockBtn.Position = UDim2.new(0.9, 0, 0.5, 0)
    shiftlockBtn.BackgroundTransparency = 1
    shiftlockBtn.Image = "rbxassetid://117791842859124"
    shiftlockBtn.ImageColor3 = Color3.fromRGB(255,255,255)
    shiftlockBtn.ScaleType = Enum.ScaleType.Fit
    shiftlockBtn.Visible = false 
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
                if direction.Magnitude > 0 then root.CFrame = CFrame.new(root.Position, root.Position + direction) end
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

    -- MAIN FRAME
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0,360,0,240) 
    mainFrame.Position = UDim2.new(0.5,-180,0.5,-120)
    mainFrame.BackgroundColor3 = Color3.fromRGB(5,10,25)
    mainFrame.BackgroundTransparency = 0.15
    mainFrame.Visible = false
    mainFrame.Parent = screenGui
    mainFrame.ClipsDescendants = false 
    Instance.new("UICorner",mainFrame).CornerRadius = UDim.new(0,12)
    
    local mainStroke = Instance.new("UIStroke",mainFrame); mainStroke.Thickness = 2.5
    local themeColors = {Color3.fromRGB(0,120,255), Color3.fromRGB(0,0,0), Color3.fromRGB(255,255,255)}
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
    closeBtn.BackgroundColor3 = Color3.fromRGB(10,20,45)
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
    minBtn.BackgroundColor3 = Color3.fromRGB(10,20,45)
    minBtn.BackgroundTransparency = 0.4
    minBtn.Font = Enum.Font.GothamBold
    minBtn.TextSize = 16
    minBtn.Parent = mainFrame
    Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0,6)

    local function toggleMainFrame(state)
        if state then
            local tweenOutIcon = TweenService:Create(openIcon, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
            tweenOutIcon:Play(); tweenOutIcon.Completed:Wait(); openIcon.Visible = false
            mainFrame.Visible = true; mainFrame.Size = UDim2.new(0, 180, 0, 120)
            TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 360, 0, 240)}):Play()
            if activeTab==nil then setTab("Home") end
        else
            local tw = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 90, 0, 50)})
            tw:Play()
            tw.Completed:Connect(function()
                mainFrame.Visible = false; openIcon.Visible = true; openIcon.Size = UDim2.new(0, 0, 0, 0)
                TweenService:Create(openIcon, TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {Size = UDim2.new(0, 65, 0, 65)}):Play()
            end)
        end
    end
    minBtn.MouseButton1Click:Connect(function() toggleMainFrame(false) end)
    openIcon.MouseButton1Click:Connect(function() toggleMainFrame(true) end)

    tabPanels = {}
    local activeTab = nil
    local sidebarIconsData = {}

    function setTab(name)
        activeTab = name
        for n, panel in pairs(tabPanels) do 
            if n == name then
                panel.Visible = true
                panel.Position = UDim2.new(0, 10, 0, 60) 
                TweenService:Create(panel, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 10, 0, 40)}):Play()
            else
                panel.Visible = false
            end
        end
        for tName, data in pairs(sidebarIconsData) do
            local btn = data.btn
            local bSize = data.baseSize
            local yPos = data.yPos
            if tName == name then
                local actSize = UDim2.new(0, bSize.X.Offset + 8, 0, bSize.Y.Offset + 8)
                local actPos = UDim2.new(0.5, -(actSize.X.Offset/2), 0, yPos - 4) 
                TweenService:Create(btn, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = actSize, Position = actPos}):Play()
            else
                local normPos = UDim2.new(0.5, -(bSize.X.Offset/2), 0, yPos)
                TweenService:Create(btn, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = bSize, Position = normPos}):Play()
            end
        end
    end

    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 42, 0, 180) 
    sidebar.Position = UDim2.new(0, -52, 0.5, -90)
    sidebar.BackgroundColor3 = Color3.fromRGB(5,10,25)
    sidebar.BackgroundTransparency = 0.2
    sidebar.Parent = mainFrame
    Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", sidebar).Color = Color3.fromRGB(0,100,230)

    local function makeSidebarIcon(assetId, yPos, tabName, customSize)
        local btn = Instance.new("ImageButton")
        btn.Size = customSize; btn.Position = UDim2.new(0.5, -(btn.Size.X.Offset/2), 0, yPos)
        btn.BackgroundTransparency = 1; btn.Image = assetId; btn.ImageColor3 = Color3.fromRGB(0, 120, 255)
        btn.Parent = sidebar
        sidebarIconsData[tabName] = {btn = btn, baseSize = customSize, yPos = yPos}
        task.spawn(function()
            while true do
                TweenService:Create(btn, TweenInfo.new(1.5), {ImageColor3 = Color3.fromRGB(255,255,255)}):Play(); task.wait(1.5)
                TweenService:Create(btn, TweenInfo.new(1.5), {ImageColor3 = Color3.fromRGB(0,120,255)}):Play(); task.wait(1.5)
            end
        end)
        btn.MouseButton1Click:Connect(function() setTab(tabName) end)
    end
    
    makeSidebarIcon("rbxassetid://119774215618572", 18, "Home", UDim2.new(0, 34, 0, 34))
    makeSidebarIcon("rbxassetid://76171785807172", 58, "Freecam", UDim2.new(0, 26, 0, 26))
    makeSidebarIcon("rbxassetid://116019702436521", 98, "Orientation", UDim2.new(0, 40, 0, 40))
    makeSidebarIcon("rbxassetid://112703342701931", 138, "Tools", UDim2.new(0, 30, 0, 30))

    local function createPanel(name)
        local panel = Instance.new("ScrollingFrame")
        panel.Name = "Panel_"..name; panel.Size = UDim2.new(1,-20,1,-45); panel.Position = UDim2.new(0,10,0,40)
        panel.BackgroundTransparency = 1; panel.ScrollBarThickness = 3; panel.ScrollBarImageColor3 = Color3.fromRGB(0,120,255)
        panel.ScrollBarImageTransparency = 0.2; panel.AutomaticCanvasSize = Enum.AutomaticSize.Y
        panel.CanvasSize = UDim2.new(0,0,0,0); panel.ScrollingDirection = Enum.ScrollingDirection.Y
        panel.Visible = false; panel.Parent = mainFrame
        tabPanels[name] = panel
        return panel
    end

    local pHome = createPanel("Home")
    local pFC = createPanel("Freecam")
    local pOR = createPanel("Orientation")
    local pTools = createPanel("Tools")

    -- HELPERS
    local function makeIosRow(labelTxt, yOff, parent)
        local onColor = Color3.fromRGB(0,120,255)
        local row = Instance.new("TextButton"); row.Size = UDim2.new(1,-8,0,30); row.Position = UDim2.new(0,4,0,yOff); row.BackgroundColor3 = Color3.fromRGB(0,100,230); row.BackgroundTransparency = 0.6; row.Text = ""; row.AutoButtonColor = false; row.Parent = parent
        Instance.new("UICorner",row).CornerRadius = UDim.new(0,8)
        local lbl = Instance.new("TextLabel"); lbl.Text = labelTxt; lbl.Size = UDim2.new(1,-50,1,0); lbl.Position = UDim2.new(0,10,0,0); lbl.BackgroundTransparency = 1; lbl.TextColor3 = Color3.fromRGB(255,255,255); lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 10; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.Parent = row
        local track = Instance.new("Frame"); track.Size = UDim2.new(0,36,0,18); track.Position = UDim2.new(1,-42,0.5,-9); track.BackgroundColor3 = Color3.fromRGB(5,10,25); track.Parent = row; Instance.new("UICorner",track).CornerRadius = UDim.new(1,0); Instance.new("UIStroke",track).Color = Color3.fromRGB(20,60,140)
        local knob = Instance.new("Frame"); knob.Size = UDim2.new(0,14,0,14); knob.Position = UDim2.new(0,2,0.5,-7); knob.BackgroundColor3 = Color3.fromRGB(255,255,255); knob.Parent = track; Instance.new("UICorner",knob).CornerRadius = UDim.new(1,0)
        local isOn = false
        local function setState(v)
            isOn = v
            if v then TweenService:Create(track,TweenInfo.new(0.2,Enum.EasingStyle.Quad),{BackgroundColor3=onColor}):Play(); TweenService:Create(knob,TweenInfo.new(0.18,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(1,-16,0.5,-7)}):Play()
            else TweenService:Create(track,TweenInfo.new(0.2,Enum.EasingStyle.Quad),{BackgroundColor3=Color3.fromRGB(5,10,25)}):Play(); TweenService:Create(knob,TweenInfo.new(0.18,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{Position=UDim2.new(0,2,0.5,-7)}):Play() end
        end
        return row, setState, function() return isOn end
    end
    local function makeLbl(txt,yOff,parent,sz,col)
        local l = Instance.new("TextLabel"); l.Text = txt; l.Size = UDim2.new(1,0,0,sz or 14); l.Position = UDim2.new(0,6,0,yOff); l.TextColor3 = col or Color3.fromRGB(220,220,220); l.BackgroundTransparency = 1; l.Font = Enum.Font.GothamBold; l.TextSize = 10; l.TextXAlignment = Enum.TextXAlignment.Left; l.Parent = parent; return l
    end
    local function makeSepHdr(txt,yOff,parent)
        local sep = Instance.new("Frame"); sep.Size = UDim2.new(0.92,0,0,1); sep.Position = UDim2.new(0.04,0,0,yOff-2); sep.BackgroundColor3 = Color3.fromRGB(20,60,140); sep.BorderSizePixel = 0; sep.Parent = parent
        return makeLbl(txt,yOff+2,parent,12,Color3.fromRGB(50,150,255))
    end
    local function makeBtn2(tA,tB,yOff,parent)
        local function b(txt,xS)
            local btn = Instance.new("TextButton"); btn.Text = txt; btn.Size = UDim2.new(0.44,0,0,26); btn.Position = UDim2.new(xS,0,0,yOff); btn.BackgroundColor3 = Color3.fromRGB(0,100,230); btn.BackgroundTransparency = 0.5; btn.TextColor3 = Color3.fromRGB(255,255,255); btn.Font = Enum.Font.GothamBold; btn.TextSize = 10; btn.Parent = parent; Instance.new("UICorner",btn).CornerRadius = UDim.new(0,6); return btn
        end
        return b(tA,0.04), b(tB,0.52)
    end
    local function makeBtn3(tA,tB,tC,yOff,parent)
        local function b(txt,xS)
            local btn = Instance.new("TextButton"); btn.Text = txt; btn.Size = UDim2.new(0.29,0,0,26); btn.Position = UDim2.new(xS,0,0,yOff); btn.BackgroundColor3 = Color3.fromRGB(0,100,230); btn.BackgroundTransparency = 0.5; btn.TextColor3 = Color3.fromRGB(255,255,255); btn.Font = Enum.Font.GothamBold; btn.TextSize = 10; btn.Parent = parent; Instance.new("UICorner",btn).CornerRadius = UDim.new(0,6); return btn
        end
        return b(tA,0.04), b(tB,0.355), b(tC,0.67)
    end

    -- ==========================================
    -- CUSTOM TITLE LOGIC
    -- ==========================================
    local cTitleGui = Instance.new("BillboardGui")
    cTitleGui.Name = "SyaaCustomTitle"
    cTitleGui.ResetOnSpawn = false
    cTitleGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    cTitleGui.AlwaysOnTop = true
    cTitleGui.MaxDistance = 60 
    cTitleGui.Size = UDim2.new(4, 0, 1.2, 0) 
    cTitleGui.ExtentsOffset = Vector3.new(0, 2, 0)
    cTitleGui.Enabled = false
    cTitleGui.Parent = screenGui
    
    local cTitleLbl = Instance.new("TextLabel")
    cTitleLbl.Size = UDim2.new(1,0,1,0)
    cTitleLbl.BackgroundTransparency = 1
    cTitleLbl.TextScaled = true
    cTitleLbl.Text = "SYAA HUB"
    cTitleLbl.Font = Enum.Font.GothamBold
    cTitleLbl.TextColor3 = Color3.fromRGB(255,255,255)
    cTitleLbl.TextStrokeTransparency = 0
    cTitleLbl.TextStrokeColor3 = Color3.fromRGB(0,0,0)
    cTitleLbl.Parent = cTitleGui

    local cTitleGrad = Instance.new("UIGradient")
    cTitleGrad.Parent = cTitleLbl

    local titleMode = 1
    local tColors = {
        {n="Ungu", c=Color3.fromRGB(0,120,255)}, {n="Biru", c=Color3.fromRGB(50,150,255)},
        {n="Pink", c=Color3.fromRGB(255,100,200)}, {n="Merah", c=Color3.fromRGB(255,50,50)},
        {n="Kuning", c=Color3.fromRGB(255,200,50)}, {n="Hijau", c=Color3.fromRGB(50,255,100)},
        {n="Cyan", c=Color3.fromRGB(50,255,255)}, {n="Putih", c=Color3.fromRGB(255,255,255)},
        {n="Hitam", c=Color3.fromRGB(30,30,30)}
    }
    local tFonts = {
        {n="Gotham", f=Enum.Font.GothamBold}, {n="Arcade", f=Enum.Font.Arcade},
        {n="SciFi", f=Enum.Font.SciFi}, {n="Bangers", f=Enum.Font.Bangers},
        {n="Creepster", f=Enum.Font.Creepster}, {n="Oswald", f=Enum.Font.Oswald}
    }
    local curC1, curC2, curC3 = 1, 2, 3
    local curFont = 1

    local function applyTitleGradient()
        if titleMode == 1 then
            cTitleGrad.Color = ColorSequence.new(tColors[curC1].c)
        elseif titleMode == 2 then
            cTitleGrad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, tColors[curC1].c),
                ColorSequenceKeypoint.new(0.5, tColors[curC2].c),
                ColorSequenceKeypoint.new(1, tColors[curC1].c)
            })
        else
            cTitleGrad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, tColors[curC1].c),
                ColorSequenceKeypoint.new(0.33, tColors[curC2].c),
                ColorSequenceKeypoint.new(0.66, tColors[curC3].c),
                ColorSequenceKeypoint.new(1, tColors[curC1].c)
            })
        end
    end
    applyTitleGradient()

    RunService.Heartbeat:Connect(function(dt)
        if cTitleGui.Enabled and titleMode > 1 then
            cTitleGrad.Rotation = (cTitleGrad.Rotation + dt * 100) % 360
        end
    end)

    -- ==========================================
    -- PANEL HOME
    -- ==========================================
    local function buildHomePanel()
        local hY = 2
        makeSepHdr("INFO SCRIPT", hY, pHome); hY = hY + 22
        
        local infoText = makeLbl("Syaa Hub V8.0\nIni adalah Script Multi-Fungsi yang khusus dikembangkan oleh Syaa untuk mempermudah gameplay lu broo 🗿.", hY, pHome, 40, Color3.fromRGB(200, 200, 200))
        infoText.TextWrapped = true; infoText.TextYAlignment = Enum.TextYAlignment.Top
        hY = hY + 46

        makeSepHdr("LOAD SCRIPTS (Auto Minimize)", hY, pHome); hY = hY + 22
        
        local flyBtn = Instance.new("TextButton"); flyBtn.Text = "🚀 Load Fly"; flyBtn.Size = UDim2.new(0.92,0,0,30); flyBtn.Position = UDim2.new(0.04,0,0,hY); flyBtn.BackgroundColor3 = Color3.fromRGB(0,100,230); flyBtn.BackgroundTransparency = 0.5; flyBtn.TextColor3 = Color3.fromRGB(255,255,255); flyBtn.Font = Enum.Font.GothamBold; flyBtn.TextSize = 10; flyBtn.Parent = pHome; Instance.new("UICorner", flyBtn).CornerRadius = UDim.new(0,6); hY = hY + 36
        flyBtn.MouseButton1Click:Connect(function() 
            toggleMainFrame(false)
            pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/89c7sbrs9w-ai/Syaafreecam/main/fly.lua"))() end) 
        end)

        local copyAvaBtn = Instance.new("TextButton"); copyAvaBtn.Text = "👥 Copy Avatar"; copyAvaBtn.Size = UDim2.new(0.92,0,0,30); copyAvaBtn.Position = UDim2.new(0.04,0,0,hY); copyAvaBtn.BackgroundColor3 = Color3.fromRGB(0,100,230); copyAvaBtn.BackgroundTransparency = 0.5; copyAvaBtn.TextColor3 = Color3.fromRGB(255,255,255); copyAvaBtn.Font = Enum.Font.GothamBold; copyAvaBtn.TextSize = 10; copyAvaBtn.Parent = pHome; Instance.new("UICorner", copyAvaBtn).CornerRadius = UDim.new(0,6); hY = hY + 36
        copyAvaBtn.MouseButton1Click:Connect(function() 
            toggleMainFrame(false) 
            pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/89c7sbrs9w-ai/Syaafreecam/main/coppy%20avatar.lua"))() end) 
        end)

        local emoteBtn = Instance.new("TextButton"); emoteBtn.Text = "🕺 Load Emote"; emoteBtn.Size = UDim2.new(0.92,0,0,30); emoteBtn.Position = UDim2.new(0.04,0,0,hY); emoteBtn.BackgroundColor3 = Color3.fromRGB(0,100,230); emoteBtn.BackgroundTransparency = 0.5; emoteBtn.TextColor3 = Color3.fromRGB(255,255,255); emoteBtn.Font = Enum.Font.GothamBold; emoteBtn.TextSize = 10; emoteBtn.Parent = pHome; Instance.new("UICorner", emoteBtn).CornerRadius = UDim.new(0,6); hY = hY + 36
        emoteBtn.MouseButton1Click:Connect(function() 
            toggleMainFrame(false) 
            task.spawn(function() pcall(function() local src = ""; local StarterGui = game:GetService("StarterGui"); pcall(function() src = game:HttpGet("https://yarhm.mhi.im/scr?channel=afemmax", false) end); if src == "" then StarterGui:SetCore("SendNotification", {Title = "YARHM Outage"; Text = "Using YARHM Offline."; Duration = 5;}); src = game:HttpGet("https://raw.githubusercontent.com/Joystickplays/AFEM/refs/heads/main/max/afemmax.lua", false) end; if src ~= "" then loadstring(src)() end end) end) 
        end)

        makeSepHdr("KONTAK DEVELOPER (SYAA)", hY, pHome); hY = hY + 22

        local waNumBtn = Instance.new("TextButton"); waNumBtn.Text = "Salin Nomor WA Syaa"; waNumBtn.Size = UDim2.new(0.92,0,0,30); waNumBtn.Position = UDim2.new(0.04,0,0,hY); waNumBtn.BackgroundColor3 = Color3.fromRGB(30,160,80); waNumBtn.BackgroundTransparency = 0.4; waNumBtn.TextColor3 = Color3.fromRGB(255,255,255); waNumBtn.Font = Enum.Font.GothamBold; waNumBtn.TextSize = 10; waNumBtn.Parent = pHome; Instance.new("UICorner", waNumBtn).CornerRadius = UDim.new(0,6); hY = hY + 36
        waNumBtn.MouseButton1Click:Connect(function()
            pcall(function() setclipboard("087792945563") end)
            waNumBtn.Text = "✅ Berhasil Disalin!"
            task.wait(1.5)
            waNumBtn.Text = "Salin Nomor WA Syaa"
        end)

        local waLinkBtn = Instance.new("TextButton"); waLinkBtn.Text = "Salin Link Saluran WA"; waLinkBtn.Size = UDim2.new(0.92,0,0,30); waLinkBtn.Position = UDim2.new(0.04,0,0,hY); waLinkBtn.BackgroundColor3 = Color3.fromRGB(30,160,80); waLinkBtn.BackgroundTransparency = 0.4; waLinkBtn.TextColor3 = Color3.fromRGB(255,255,255); waLinkBtn.Font = Enum.Font.GothamBold; waLinkBtn.TextSize = 10; waLinkBtn.Parent = pHome; Instance.new("UICorner", waLinkBtn).CornerRadius = UDim.new(0,6); hY = hY + 36
        waLinkBtn.MouseButton1Click:Connect(function()
            pcall(function() setclipboard("https://whatsapp.com/channel/0029Vb7sDCb7oQhgPP18Zh0m") end)
            waLinkBtn.Text = "✅ Berhasil Disalin!"
            task.wait(1.5)
            waLinkBtn.Text = "Salin Link Saluran WA"
        end)

        local hPad = Instance.new("Frame"); hPad.Size = UDim2.new(1,0,0,40); hPad.Position = UDim2.new(0,0,0,hY); hPad.BackgroundTransparency = 1; hPad.Parent = pHome
    end

    -- ==========================================
    -- PANEL TOOLS
    -- ==========================================
    local function buildToolsPanel()
        local tY = 2

        makeSepHdr("CUSTOM TITLE KEPALA", tY, pTools); tY = tY+22

        local titleInput = Instance.new("TextBox"); titleInput.Size = UDim2.new(0.92, 0, 0, 30); titleInput.Position = UDim2.new(0.04, 0, 0, tY); titleInput.BackgroundColor3 = Color3.fromRGB(20, 10, 30); titleInput.TextColor3 = Color3.fromRGB(255, 255, 255); titleInput.PlaceholderText = "Tulis Title di sini..."; titleInput.Text = "SYAA HUB"; titleInput.Font = Enum.Font.GothamBold; titleInput.TextSize = 11; titleInput.Parent = pTools; Instance.new("UICorner", titleInput); Instance.new("UIStroke", titleInput).Color = Color3.fromRGB(0,100,230)
        tY = tY + 36
        titleInput.FocusLost:Connect(function() cTitleLbl.Text = titleInput.Text end)

        local titleRow, setTitleState, getTitleState = makeIosRow("Munculin Title", tY, pTools); tY = tY+36
        titleRow.MouseButton1Click:Connect(function() 
            local s = not getTitleState(); setTitleState(s); cTitleGui.Enabled = s
            if s and localPlayer.Character and localPlayer.Character:FindFirstChild("Head") then
                cTitleGui.Adornee = localPlayer.Character.Head
            end
        end)

        localPlayer.CharacterAdded:Connect(function(char)
            if getTitleState() then
                local head = char:WaitForChild("Head", 5)
                if head then cTitleGui.Adornee = head end
            end
        end)

        local btnMode, btnFont = makeBtn2("Mode: 1 Warna", "Font: Gotham", tY, pTools); tY = tY+32
        local btnC1, btnC2, btnC3 = makeBtn3("C1: Ungu", "C2: Biru", "C3: Pink", tY, pTools); tY = tY+32

        btnMode.MouseButton1Click:Connect(function() 
            titleMode = titleMode % 3 + 1
            local modes = {"1 Warna", "2 Warna", "3 Warna"}
            btnMode.Text = "Mode: "..modes[titleMode]
            applyTitleGradient()
        end)
        btnFont.MouseButton1Click:Connect(function() curFont = curFont % #tFonts + 1; btnFont.Text = "Font: "..tFonts[curFont].n; cTitleLbl.Font = tFonts[curFont].f end)
        btnC1.MouseButton1Click:Connect(function() curC1 = curC1 % #tColors + 1; btnC1.Text = "C1: "..tColors[curC1].n; applyTitleGradient() end)
        btnC2.MouseButton1Click:Connect(function() curC2 = curC2 % #tColors + 1; btnC2.Text = "C2: "..tColors[curC2].n; applyTitleGradient() end)
        btnC3.MouseButton1Click:Connect(function() curC3 = curC3 % #tColors + 1; btnC3.Text = "C3: "..tColors[curC3].n; applyTitleGradient() end)

        local tsLab = makeLbl("Ukuran Title: 4.0", tY, pTools, 14); tY = tY+16
        local tsBg = Instance.new("Frame"); tsBg.Size = UDim2.new(0.88,0,0,4); tsBg.Position = UDim2.new(0.06,0,0,tY); tsBg.BackgroundColor3 = Color3.fromRGB(15,25,50); tsBg.Parent = pTools; Instance.new("UICorner",tsBg)
        local tsFill = Instance.new("Frame"); tsFill.Size = UDim2.new(0.33,0,1,0); tsFill.BackgroundColor3 = Color3.fromRGB(0,120,255); tsFill.BorderSizePixel = 0; tsFill.Parent = tsBg; Instance.new("UICorner",tsFill)
        local tsKnob = Instance.new("TextButton"); tsKnob.Size = UDim2.new(0,14,0,14); tsKnob.Position = UDim2.new(0.33,-7,0.5,-7); tsKnob.Text = ""; tsKnob.BackgroundColor3 = Color3.fromRGB(255,255,255); tsKnob.Parent = tsBg; Instance.new("UICorner",tsKnob).CornerRadius = UDim.new(1,0)
        tY = tY+18; local tsSld = false
        tsKnob.MouseButton1Down:Connect(function() tsSld=true end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then tsSld=false end end)
        UserInputService.InputChanged:Connect(function(i) if tsSld and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local pos = math.clamp((i.Position.X-tsBg.AbsolutePosition.X)/tsBg.AbsoluteSize.X,0,1); tsFill.Size = UDim2.new(pos,0,1,0); tsKnob.Position = UDim2.new(pos,-7,0.5,-7); local val = 1 + (pos * 9); val = math.floor(val*10)/10; tsLab.Text = "Ukuran Title: "..val; cTitleGui.Size = UDim2.new(val, 0, val*0.3, 0) end end)

        local tyLab = makeLbl("Posisi Tinggi: 2.0", tY, pTools, 14); tY = tY+16
        local tyBg = Instance.new("Frame"); tyBg.Size = UDim2.new(0.88,0,0,4); tyBg.Position = UDim2.new(0.06,0,0,tY); tyBg.BackgroundColor3 = Color3.fromRGB(15,25,50); tyBg.Parent = pTools; Instance.new("UICorner",tyBg)
        local tyFill = Instance.new("Frame"); tyFill.Size = UDim2.new(0.2,0,1,0); tyFill.BackgroundColor3 = Color3.fromRGB(0,120,255); tyFill.BorderSizePixel = 0; tyFill.Parent = tyBg; Instance.new("UICorner",tyFill)
        local tyKnob = Instance.new("TextButton"); tyKnob.Size = UDim2.new(0,14,0,14); tyKnob.Position = UDim2.new(0.2,-7,0.5,-7); tyKnob.Text = ""; tyKnob.BackgroundColor3 = Color3.fromRGB(255,255,255); tyKnob.Parent = tyBg; Instance.new("UICorner",tyKnob).CornerRadius = UDim.new(1,0)
        tY = tY+18; local tySld = false
        tyKnob.MouseButton1Down:Connect(function() tySld=true end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then tySld=false end end)
        UserInputService.InputChanged:Connect(function(i) if tySld and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local pos = math.clamp((i.Position.X-tyBg.AbsolutePosition.X)/tyBg.AbsoluteSize.X,0,1); tyFill.Size = UDim2.new(pos,0,1,0); tyKnob.Position = UDim2.new(pos,-7,0.5,-7); local val = math.floor(pos*10*10)/10; tyLab.Text = "Posisi Tinggi: "..val; cTitleGui.ExtentsOffset = Vector3.new(0, val, 0) end end)

        makeSepHdr("PLAYER MODS", tY, pTools); tY = tY+22

        local noclipRow, setNoclipState = makeIosRow("Noclip (Tembus Tembok)", tY, pTools); tY = tY+36
        local noclipInfo = makeLbl("▸ Tembus tembok, tidak tembus tanah", tY, pTools, 14, Color3.fromRGB(50, 150, 255)); tY = tY+20

        local isNoclipOn = false
        RunService.RenderStepped:Connect(function()
            if not isNoclipOn then return end
            local char = localPlayer.Character
            if not char then return end
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") and p.CanCollide then
                    p.CanCollide = false
                end
            end
        end)

        noclipRow.MouseButton1Click:Connect(function()
            isNoclipOn = not isNoclipOn
            setNoclipState(isNoclipOn)
            if isNoclipOn then
                noclipInfo.Text = "▸ AKTIF — bisa tembus tembok 👻"
                noclipInfo.TextColor3 = Color3.fromRGB(0, 200, 100)
            else
                noclipInfo.Text = "▸ Tembus tembok, tidak tembus tanah"
                noclipInfo.TextColor3 = Color3.fromRGB(50, 150, 255)
            end
        end)

        local infJumpRow, setInfJump = makeIosRow("Unlimited Jump", tY, pTools); tY = tY+36
        local isInfJump = false
        infJumpRow.MouseButton1Click:Connect(function() isInfJump = not isInfJump; setInfJump(isInfJump) end)
        UserInputService.JumpRequest:Connect(function() if isInfJump and localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid") then localPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping) end end)

        local wsRow, setWsState = makeIosRow("Enable WalkSpeed", tY, pTools); tY = tY+36
        local wsVal = 16; local wsLab = makeLbl("Speed: 16", tY, pTools, 14); tY = tY+16
        local wsBg = Instance.new("Frame"); wsBg.Size = UDim2.new(0.88,0,0,4); wsBg.Position = UDim2.new(0.06,0,0,tY); wsBg.BackgroundColor3 = Color3.fromRGB(15,25,50); wsBg.Parent = pTools; Instance.new("UICorner",wsBg)
        local wsFill = Instance.new("Frame"); wsFill.Size = UDim2.new((16/200),0,1,0); wsFill.BackgroundColor3 = Color3.fromRGB(0,120,255); wsFill.BorderSizePixel = 0; wsFill.Parent = wsBg; Instance.new("UICorner",wsFill)
        local wsKnob = Instance.new("TextButton"); wsKnob.Size = UDim2.new(0,14,0,14); wsKnob.Position = UDim2.new((16/200),-7,0.5,-7); wsKnob.Text = ""; wsKnob.BackgroundColor3 = Color3.fromRGB(255,255,255); wsKnob.Parent = wsBg; Instance.new("UICorner",wsKnob).CornerRadius = UDim.new(1,0)
        tY = tY+18; local wsSld = false
        wsKnob.MouseButton1Down:Connect(function() wsSld=true end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then wsSld=false end end)
        UserInputService.InputChanged:Connect(function(i) if wsSld and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local pos = math.clamp((i.Position.X-wsBg.AbsolutePosition.X)/wsBg.AbsoluteSize.X,0,1); wsFill.Size = UDim2.new(pos,0,1,0); wsKnob.Position = UDim2.new(pos,-7,0.5,-7); wsVal = math.floor(pos*200); if wsVal < 16 then wsVal = 16 end wsLab.Text = "Speed: "..wsVal end end)
        local isWsEnabled = false
        wsRow.MouseButton1Click:Connect(function() isWsEnabled = not isWsEnabled; setWsState(isWsEnabled) end)
        RunService.Heartbeat:Connect(function() if isWsEnabled and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then localPlayer.Character.Humanoid.WalkSpeed = wsVal end end)

        makeSepHdr("TELEPORT PLAYER", tY, pTools); tY = tY+22
        local tpRefresh = Instance.new("TextButton"); tpRefresh.Text = "↺ Refresh List"; tpRefresh.Size = UDim2.new(0.92,0,0,26); tpRefresh.Position = UDim2.new(0.04,0,0,tY); tpRefresh.BackgroundColor3 = Color3.fromRGB(0,100,230); tpRefresh.BackgroundTransparency = 0.5; tpRefresh.TextColor3 = Color3.fromRGB(255,255,255); tpRefresh.Font = Enum.Font.GothamBold; tpRefresh.TextSize = 10; tpRefresh.Parent = pTools; Instance.new("UICorner",tpRefresh).CornerRadius = UDim.new(0,6)
        tY = tY+32
        local tpFrame = Instance.new("ScrollingFrame"); tpFrame.Size = UDim2.new(0.92,0,0,80); tpFrame.Position = UDim2.new(0.04,0,0,tY); tpFrame.BackgroundColor3 = Color3.fromRGB(5,10,25); tpFrame.BackgroundTransparency = 0.5; tpFrame.Parent = pTools; tpFrame.ScrollBarThickness = 2; tpFrame.ScrollBarImageColor3 = Color3.fromRGB(0,120,255); tpFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y; tpFrame.ScrollingDirection = Enum.ScrollingDirection.Y; Instance.new("UICorner",tpFrame); Instance.new("UIStroke",tpFrame).Color = Color3.fromRGB(20,60,140)
        local tpLayout = Instance.new("UIListLayout",tpFrame); tpLayout.Padding = UDim.new(0,2); tpLayout.SortOrder = Enum.SortOrder.Name
        tY = tY+90
        local tpRows = {}
        local function refreshTpList() for _,r in pairs(tpRows) do pcall(function() r:Destroy() end) end; tpRows = {}; local list = Players:GetPlayers(); if #list <= 1 then local el = Instance.new("TextLabel"); el.Size = UDim2.new(1,0,0,24); el.BackgroundTransparency = 1; el.Text = "Cuma lu doang 🗿"; el.TextColor3 = Color3.fromRGB(100,100,100); el.Font = Enum.Font.Gotham; el.TextSize = 10; el.Parent = tpFrame; table.insert(tpRows,el); return end
            for _,p in ipairs(list) do if p ~= localPlayer then local row = Instance.new("TextButton"); row.Size = UDim2.new(1,0,0,30); row.BackgroundColor3 = Color3.fromRGB(0,100,230); row.BackgroundTransparency = 0.6; row.Text = ""; row.AutoButtonColor = false; row.Parent = tpFrame; Instance.new("UICorner",row); local ava = Instance.new("ImageLabel"); ava.Size = UDim2.new(0, 24, 0, 24); ava.Position = UDim2.new(0, 4, 0.5, -12); ava.BackgroundTransparency = 1; ava.Parent = row; Instance.new("UICorner",ava).CornerRadius = UDim.new(1,0); task.spawn(function() pcall(function() ava.Image = Players:GetUserThumbnailAsync(p.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48) end) end)
                    local nl = Instance.new("TextLabel"); nl.Size = UDim2.new(1,-36,1,0); nl.Position = UDim2.new(0,32,0,0); nl.BackgroundTransparency = 1; nl.Text = p.DisplayName.." (@"..p.Name..")"; nl.TextColor3 = Color3.fromRGB(220,220,220); nl.Font = Enum.Font.GothamBold; nl.TextSize = 10; nl.TextXAlignment = Enum.TextXAlignment.Left; nl.Parent = row
                    row.MouseButton1Click:Connect(function() if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then localPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame end end); table.insert(tpRows,row) end end end
        tpRefresh.MouseButton1Click:Connect(refreshTpList); task.spawn(function() task.wait(1) refreshTpList() end)

        makeSepHdr("3D IMAGE SPAWNER", tY, pTools); tY = tY+22
        local imgInput = Instance.new("TextBox"); imgInput.Size = UDim2.new(0.92, 0, 0, 30); imgInput.Position = UDim2.new(0.04, 0, 0, tY); imgInput.BackgroundColor3 = Color3.fromRGB(20, 10, 30); imgInput.TextColor3 = Color3.fromRGB(255, 255, 255); imgInput.PlaceholderText = "Masukkan ID Gambar..."; imgInput.Font = Enum.Font.GothamBold; imgInput.TextSize = 11; imgInput.Parent = pTools; Instance.new("UICorner", imgInput); Instance.new("UIStroke", imgInput).Color = Color3.fromRGB(0,100,230)
        tY = tY + 36
        local spwBtn, saveBtn = makeBtn2("Spawn 3D", "Save (Unselect)", tY, pTools); tY = tY + 32
        makeLbl("Daftar Gambar (Klik buat ngedit):", tY, pTools, 12); tY = tY+16
        local imgListFrame = Instance.new("ScrollingFrame"); imgListFrame.Size = UDim2.new(0.92,0,0,70); imgListFrame.Position = UDim2.new(0.04,0,0,tY); imgListFrame.BackgroundColor3 = Color3.fromRGB(5,10,25); imgListFrame.BackgroundTransparency = 0.5; imgListFrame.Parent = pTools; imgListFrame.ScrollBarThickness = 2; imgListFrame.ScrollBarImageColor3 = Color3.fromRGB(0,120,255); imgListFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y; imgListFrame.ScrollingDirection = Enum.ScrollingDirection.Y; Instance.new("UICorner",imgListFrame); Instance.new("UIStroke",imgListFrame).Color = Color3.fromRGB(20,60,140)
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
            for i, data in ipairs(spawnedImages) do local isAct = (activeImage == data.part); local row = Instance.new("TextButton"); row.Size = UDim2.new(1,0,0,24); row.BackgroundColor3 = isAct and Color3.fromRGB(30,160,255) or Color3.fromRGB(20,60,140); row.BackgroundTransparency = 0.5; row.Text = (isAct and "◉ " or "○ ")..data.name; row.TextColor3 = Color3.fromRGB(255,255,255); row.Font = Enum.Font.GothamBold; row.TextSize = 10; row.Parent = imgListFrame; Instance.new("UICorner",row); row.MouseButton1Click:Connect(function() activeImage = data.part; refreshImgList() end); table.insert(listRows, row) end end
        spwBtn.MouseButton1Click:Connect(function() local idText = imgInput.Text:gsub("%D", ""); if idText == "" then return end; local char = localPlayer.Character; if not char or not char:FindFirstChild("HumanoidRootPart") then return end; local hrp = char.HumanoidRootPart; imgCount = imgCount + 1; local p = Instance.new("Part"); p.Name = "Syaa3DImage_"..imgCount; p.Size = Vector3.new(6, 6, 0.1); p.Anchored, p.CanCollide, p.Massless = true, false, true; p.Color, p.Transparency = Color3.fromRGB(0,0,0), 1; local frontCFrame = hrp.CFrame * CFrame.new(0, 0, -5); p.CFrame = CFrame.lookAt(frontCFrame.Position, hrp.Position); local realUrl = "rbxthumb://type=Asset&id="..idText.."&w=420&h=420"; local d1 = Instance.new("Decal"); d1.Face, d1.Texture = Enum.NormalId.Front, realUrl; d1.Parent = p; local d2 = Instance.new("Decal"); d2.Face, d2.Texture = Enum.NormalId.Back, realUrl; d2.Parent = p; p.Parent = workspace; table.insert(spawnedImages, {id = idText, part = p, name = "Gambar ID: "..string.sub(idText, 1, 5)..".."}); activeImage = p; refreshImgList() end)
        saveBtn.MouseButton1Click:Connect(function() activeImage = nil; refreshImgList() end)
        clrBtn.MouseButton1Click:Connect(function() if activeImage then activeImage:Destroy(); for i, data in ipairs(spawnedImages) do if data.part == activeImage then table.remove(spawnedImages, i); break end end; activeImage = nil; refreshImgList() end end)
        btnScaleUp.MouseButton1Click:Connect(function() if activeImage then activeImage.Size = activeImage.Size + Vector3.new(0.5, 0.5, 0) end end)
        btnScaleDown.MouseButton1Click:Connect(function() if activeImage then activeImage.Size = Vector3.new(math.max(0.5, activeImage.Size.X - 0.5), math.max(0.5, activeImage.Size.Y - 0.5), 0.1) end end)
        local function mod3D(cf) if activeImage then activeImage.CFrame = activeImage.CFrame * cf end end
        btnLeft.MouseButton1Click:Connect(function() mod3D(CFrame.new(0.5, 0, 0)) end); btnRight.MouseButton1Click:Connect(function() mod3D(CFrame.new(-0.5, 0, 0)) end); btnUp.MouseButton1Click:Connect(function() mod3D(CFrame.new(0, 0.5, 0)) end); btnDown.MouseButton1Click:Connect(function() mod3D(CFrame.new(0, -0.5, 0)) end); btnFwd.MouseButton1Click:Connect(function() mod3D(CFrame.new(0, 0, 0.5)) end); btnBack.MouseButton1Click:Connect(function() mod3D(CFrame.new(0, 0, -0.5)) end); btnRotL.MouseButton1Click:Connect(function() mod3D(CFrame.Angles(0, math.rad(15), 0)) end); btnRotR.MouseButton1Click:Connect(function() mod3D(CFrame.Angles(0, math.rad(-15), 0)) end); btnTiltL.MouseButton1Click:Connect(function() mod3D(CFrame.Angles(0, 0, math.rad(15))) end); btnTiltR.MouseButton1Click:Connect(function() mod3D(CFrame.Angles(0, 0, math.rad(-15))) end); btnRotUp.MouseButton1Click:Connect(function() mod3D(CFrame.Angles(math.rad(15), 0, 0)) end); btnRotDown.MouseButton1Click:Connect(function() mod3D(CFrame.Angles(math.rad(-15), 0, 0)) end)
        
        -- SPY CAM
        local spyActive = false
        local spyTarget = nil
        local spyConn = nil
        local spyCamOffset = Vector3.new(0, 2, 5)

        makeSepHdr("SPY CAM", tY, pTools); tY = tY + 22

        local spyRow, setSpyState, getSpyState = makeIosRow("Aktifkan Spy Cam", tY, pTools); tY = tY + 36
        local infoLbl = makeLbl("▸ Pilih player yang mau dipantau:", tY, pTools, 14, Color3.fromRGB(50, 150, 255)); tY = tY + 18
        local targetLbl = makeLbl("Target: Belum dipilih", tY, pTools, 14, Color3.fromRGB(200, 200, 200)); tY = tY + 16

        local refreshSpyBtn = Instance.new("TextButton")
        refreshSpyBtn.Text = "↺ Refresh Player List"
        refreshSpyBtn.Size = UDim2.new(0.92, 0, 0, 26)
        refreshSpyBtn.Position = UDim2.new(0.04, 0, 0, tY)
        refreshSpyBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 230)
        refreshSpyBtn.BackgroundTransparency = 0.5
        refreshSpyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        refreshSpyBtn.Font = Enum.Font.GothamBold
        refreshSpyBtn.TextSize = 10
        refreshSpyBtn.Parent = pTools
        Instance.new("UICorner", refreshSpyBtn).CornerRadius = UDim.new(0, 6)
        tY = tY + 32

        local spyListFrame = Instance.new("ScrollingFrame")
        spyListFrame.Size = UDim2.new(0.92, 0, 0, 110)
        spyListFrame.Position = UDim2.new(0.04, 0, 0, tY)
        spyListFrame.BackgroundColor3 = Color3.fromRGB(5, 10, 25)
        spyListFrame.BackgroundTransparency = 0.4
        spyListFrame.Parent = pTools
        spyListFrame.ScrollBarThickness = 2
        spyListFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 120, 255)
        spyListFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        spyListFrame.ScrollingDirection = Enum.ScrollingDirection.Y
        Instance.new("UICorner", spyListFrame)
        Instance.new("UIStroke", spyListFrame).Color = Color3.fromRGB(0, 100, 230)
        local spyLayout = Instance.new("UIListLayout", spyListFrame)
        spyLayout.Padding = UDim.new(0, 3)
        spyLayout.SortOrder = Enum.SortOrder.Name
        tY = tY + 120

        makeSepHdr("KAMERA OFFSET", tY, pTools); tY = tY + 22

        local offYLab = makeLbl("Tinggi (Y): 2", tY, pTools, 14); tY = tY + 16
        local offYBg = Instance.new("Frame"); offYBg.Size = UDim2.new(0.88, 0, 0, 4); offYBg.Position = UDim2.new(0.06, 0, 0, tY); offYBg.BackgroundColor3 = Color3.fromRGB(15, 25, 50); offYBg.Parent = pTools; Instance.new("UICorner", offYBg)
        local offYFill = Instance.new("Frame"); offYFill.Size = UDim2.new(2/10, 0, 1, 0); offYFill.BackgroundColor3 = Color3.fromRGB(0, 120, 255); offYFill.BorderSizePixel = 0; offYFill.Parent = offYBg; Instance.new("UICorner", offYFill)
        local offYKnob = Instance.new("TextButton"); offYKnob.Size = UDim2.new(0, 14, 0, 14); offYKnob.Position = UDim2.new(2/10, -7, 0.5, -7); offYKnob.Text = ""; offYKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255); offYKnob.Parent = offYBg; Instance.new("UICorner", offYKnob).CornerRadius = UDim.new(1, 0)
        tY = tY + 18; local offYSld = false
        offYKnob.MouseButton1Down:Connect(function() offYSld = true end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then offYSld = false end end)
        UserInputService.InputChanged:Connect(function(i) if offYSld and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then local pos = math.clamp((i.Position.X - offYBg.AbsolutePosition.X) / offYBg.AbsoluteSize.X, 0, 1); offYFill.Size = UDim2.new(pos, 0, 1, 0); offYKnob.Position = UDim2.new(pos, -7, 0.5, -7); local v = math.floor(pos * 20) - 5; offYLab.Text = "Tinggi (Y): " .. v; spyCamOffset = Vector3.new(spyCamOffset.X, v, spyCamOffset.Z) end end)

        local offZLab = makeLbl("Jarak (Z): 5", tY, pTools, 14); tY = tY + 16
        local offZBg = Instance.new("Frame"); offZBg.Size = UDim2.new(0.88, 0, 0, 4); offZBg.Position = UDim2.new(0.06, 0, 0, tY); offZBg.BackgroundColor3 = Color3.fromRGB(15, 25, 50); offZBg.Parent = pTools; Instance.new("UICorner", offZBg)
        local offZFill = Instance.new("Frame"); offZFill.Size = UDim2.new(5/25, 0, 1, 0); offZFill.BackgroundColor3 = Color3.fromRGB(0, 120, 255); offZFill.BorderSizePixel = 0; offZFill.Parent = offZBg; Instance.new("UICorner", offZFill)
        local offZKnob = Instance.new("TextButton"); offZKnob.Size = UDim2.new(0, 14, 0, 14); offZKnob.Position = UDim2.new(5/25, -7, 0.5, -7); offZKnob.Text = ""; offZKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255); offZKnob.Parent = offZBg; Instance.new("UICorner", offZKnob).CornerRadius = UDim.new(1, 0)
        tY = tY + 18; local offZSld = false
        offZKnob.MouseButton1Down:Connect(function() offZSld = true end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then offZSld = false end end)
        UserInputService.InputChanged:Connect(function(i) if offZSld and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then local pos = math.clamp((i.Position.X - offZBg.AbsolutePosition.X) / offZBg.AbsoluteSize.X, 0, 1); offZFill.Size = UDim2.new(pos, 0, 1, 0); offZKnob.Position = UDim2.new(pos, -7, 0.5, -7); local v = math.floor(pos * 25) + 1; offZLab.Text = "Jarak (Z): " .. v; spyCamOffset = Vector3.new(spyCamOffset.X, spyCamOffset.Y, v) end end)

        local stopSpyBtn = Instance.new("TextButton")
        stopSpyBtn.Text = "■ Stop Spy"
        stopSpyBtn.Size = UDim2.new(0.92, 0, 0, 28)
        stopSpyBtn.Position = UDim2.new(0.04, 0, 0, tY)
        stopSpyBtn.BackgroundColor3 = Color3.fromRGB(200, 30, 50)
        stopSpyBtn.BackgroundTransparency = 0.4
        stopSpyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        stopSpyBtn.Font = Enum.Font.GothamBold
        stopSpyBtn.TextSize = 11
        stopSpyBtn.Parent = pTools
        Instance.new("UICorner", stopSpyBtn).CornerRadius = UDim.new(0, 6)
        tY = tY + 36

        makeSepHdr("ZOOM (Mobile)", tY, pTools); tY = tY + 20
        local zoomInBtn, zoomOutBtn = makeBtn2("🔍 Zoom In", "🔍 Zoom Out", tY, pTools); tY = tY + 32
        local zoomInHeld, zoomOutHeld = false, false
        local spyZoomDist = 7
        zoomInBtn.MouseButton1Down:Connect(function() zoomInHeld = true end)
        zoomInBtn.MouseButton1Up:Connect(function() zoomInHeld = false end)
        zoomInBtn.InputEnded:Connect(function() zoomInHeld = false end)
        zoomOutBtn.MouseButton1Down:Connect(function() zoomOutHeld = true end)
        zoomOutBtn.MouseButton1Up:Connect(function() zoomOutHeld = false end)
        zoomOutBtn.InputEnded:Connect(function() zoomOutHeld = false end)
        RunService.Heartbeat:Connect(function()
            if spyActive then
                if zoomInHeld then spyZoomDist = math.clamp(spyZoomDist - 0.15, 2, 80) end
                if zoomOutHeld then spyZoomDist = math.clamp(spyZoomDist + 0.15, 2, 80) end
            end
        end)

        local spyRows = {}
        local spyOrbitYaw = 180   
        local spyOrbitPitch = 15  
        local spyDragging = false
        local spyLastInput = nil
        local spyInputConn1, spyInputConn2, spyInputConn3

        local function disconnectSpyInput()
            if spyInputConn1 then spyInputConn1:Disconnect(); spyInputConn1 = nil end
            if spyInputConn2 then spyInputConn2:Disconnect(); spyInputConn2 = nil end
            if spyInputConn3 then spyInputConn3:Disconnect(); spyInputConn3 = nil end
            spyDragging = false
        end

        local function stopSpy()
            spyActive = false
            spyTarget = nil
            setSpyState(false)
            targetLbl.Text = "Target: Belum dipilih"
            if spyConn then spyConn:Disconnect(); spyConn = nil end
            disconnectSpyInput()
            
            if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = localPlayer.Character.HumanoidRootPart
                local backPos = hrp.Position + (hrp.CFrame.LookVector * -10) + Vector3.new(0, 5, 0)
                local goalCF = CFrame.lookAt(backPos, hrp.Position)
                local tw = TweenService:Create(Camera, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = goalCF})
                tw:Play(); tw.Completed:Wait()
                Camera.CameraType = Enum.CameraType.Custom
                local hum = localPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum then Camera.CameraSubject = hum end
            else
                Camera.CameraType = Enum.CameraType.Custom
            end
            pcall(function() PlayerModule:Enable() end)
        end

        local function connectSpyInput()
            disconnectSpyInput()
            spyInputConn1 = UserInputService.InputBegan:Connect(function(inp, gpe)
                if gpe then return end
                if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                    spyDragging = true; spyLastInput = inp.Position
                end
            end)
            spyInputConn2 = UserInputService.InputEnded:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                    spyDragging = false
                end
            end)
            spyInputConn3 = UserInputService.InputChanged:Connect(function(inp)
                if spyActive then
                    if spyDragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
                        local delta = inp.Position - (spyLastInput or inp.Position)
                        spyLastInput = inp.Position
                        spyOrbitYaw = spyOrbitYaw - delta.X * 0.4
                        spyOrbitPitch = math.clamp(spyOrbitPitch + delta.Y * 0.3, -60, 75)
                    end
                    if inp.UserInputType == Enum.UserInputType.MouseWheel then
                        spyZoomDist = math.clamp(spyZoomDist - inp.Position.Z * 2, 2, 80)
                    end
                end
            end)
        end

        local function startSpy(player)
            if spyConn then spyConn:Disconnect(); spyConn = nil end
            spyTarget = player
            spyActive = true
            spyOrbitYaw = 180
            spyOrbitPitch = 15
            spyZoomDist = spyCamOffset.Z + 2
            setSpyState(true)
            targetLbl.Text = "Target: " .. player.DisplayName .. " (@" .. player.Name .. ")"
            pcall(function() PlayerModule:Disable() end)
            Camera.CameraType = Enum.CameraType.Scriptable
            connectSpyInput()

            if spyTarget.Character and spyTarget.Character:FindFirstChild("HumanoidRootPart") then
                local tHrp = spyTarget.Character.HumanoidRootPart
                local targetPos = tHrp.Position + Vector3.new(0, spyCamOffset.Y, 0)
                local dist = spyZoomDist
                local yawRad = math.rad(spyOrbitYaw)
                local pitchRad = math.rad(spyOrbitPitch)
                local camOffset = Vector3.new(
                    dist * math.sin(yawRad) * math.cos(pitchRad),
                    dist * math.sin(pitchRad),
                    dist * math.cos(yawRad) * math.cos(pitchRad)
                )
                local goalCF = CFrame.lookAt(targetPos + camOffset, targetPos + Vector3.new(0, 0.5, 0))
                local tw = TweenService:Create(Camera, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = goalCF})
                tw:Play(); tw.Completed:Wait()
            end

            if not spyActive then return end

            spyConn = RunService.RenderStepped:Connect(function()
                if not spyActive then return end
                if not spyTarget or not spyTarget.Parent then stopSpy(); return end
                local char = spyTarget.Character
                if not char then return end
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                local targetPos = hrp.Position + Vector3.new(0, spyCamOffset.Y, 0)
                local yawRad = math.rad(spyOrbitYaw)
                local pitchRad = math.rad(spyOrbitPitch)
                local dist = spyZoomDist
                local camOffset = Vector3.new(
                    dist * math.sin(yawRad) * math.cos(pitchRad),
                    dist * math.sin(pitchRad),
                    dist * math.cos(yawRad) * math.cos(pitchRad)
                )
                local desiredPos = targetPos + camOffset
                local lookAt = targetPos + Vector3.new(0, 0.5, 0)
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(desiredPos, lookAt), 0.12)
            end)
        end

        local function refreshSpyList()
            for _, r in pairs(spyRows) do pcall(function() r:Destroy() end) end
            spyRows = {}
            local list = Players:GetPlayers()
            local others = {}
            for _, p in ipairs(list) do
                if p ~= localPlayer then table.insert(others, p) end
            end
            if #others == 0 then
                local el = Instance.new("TextLabel")
                el.Size = UDim2.new(1, 0, 0, 28)
                el.BackgroundTransparency = 1
                el.Text = "Cuma lu doang di server 🗿"
                el.TextColor3 = Color3.fromRGB(100, 100, 100)
                el.Font = Enum.Font.Gotham
                el.TextSize = 10
                el.Parent = spyListFrame
                table.insert(spyRows, el)
                return
            end
            for _, p in ipairs(others) do
                local isSelected = (spyTarget == p)
                local row = Instance.new("TextButton")
                row.Size = UDim2.new(1, 0, 0, 34)
                row.BackgroundColor3 = isSelected and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(0, 60, 140)
                row.BackgroundTransparency = 0.4
                row.Text = ""
                row.AutoButtonColor = false
                row.Parent = spyListFrame
                Instance.new("UICorner", row)
                local ava = Instance.new("ImageLabel")
                ava.Size = UDim2.new(0, 26, 0, 26)
                ava.Position = UDim2.new(0, 4, 0.5, -13)
                ava.BackgroundTransparency = 1
                ava.Parent = row
                Instance.new("UICorner", ava).CornerRadius = UDim.new(1, 0)
                task.spawn(function()
                    pcall(function()
                        ava.Image = Players:GetUserThumbnailAsync(p.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
                    end)
                end)
                local nl = Instance.new("TextLabel")
                nl.Size = UDim2.new(1, -40, 0, 16)
                nl.Position = UDim2.new(0, 36, 0, 4)
                nl.BackgroundTransparency = 1
                nl.Text = (isSelected and "▶ " or "") .. p.DisplayName
                nl.TextColor3 = isSelected and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
                nl.Font = Enum.Font.GothamBold
                nl.TextSize = 10
                nl.TextXAlignment = Enum.TextXAlignment.Left
                nl.Parent = row
                local un = Instance.new("TextLabel")
                un.Size = UDim2.new(1, -40, 0, 13)
                un.Position = UDim2.new(0, 36, 0, 18)
                un.BackgroundTransparency = 1
                un.Text = "@" .. p.Name
                un.TextColor3 = Color3.fromRGB(100, 160, 255)
                un.Font = Enum.Font.Gotham
                un.TextSize = 9
                un.TextXAlignment = Enum.TextXAlignment.Left
                un.Parent = row
                row.MouseButton1Click:Connect(function()
                    startSpy(p)
                    refreshSpyList()
                end)
                table.insert(spyRows, row)
            end
        end

        refreshSpyBtn.MouseButton1Click:Connect(refreshSpyList)
        stopSpyBtn.MouseButton1Click:Connect(function()
            stopSpy()
            refreshSpyList()
        end)
        spyRow.MouseButton1Click:Connect(function()
            if getSpyState() then
                stopSpy()
                refreshSpyList()
            else
                targetLbl.Text = "Target: Pilih player dulu!"
                setSpyState(false)
            end
        end)

        Players.PlayerAdded:Connect(function() task.wait(0.5); refreshSpyList() end)
        Players.PlayerRemoving:Connect(function(p)
            if spyTarget == p then stopSpy() end
            task.wait(0.1); refreshSpyList()
        end)

        task.spawn(function() task.wait(0.8); refreshSpyList() end)

        local tPad = Instance.new("Frame"); tPad.Size = UDim2.new(1,0,0,40); tPad.Position = UDim2.new(0,0,0,tY); tPad.BackgroundTransparency = 1; tPad.Parent = pTools
    end

    -- ==========================================
    -- PANEL ORIENTATION
    -- ==========================================
    local function buildOrientationPanel()
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
        local brBg = Instance.new("Frame"); brBg.Size, brBg.Position, brBg.BackgroundColor3, brBg.Parent = UDim2.new(0.88,0,0,4), UDim2.new(0.06,0,0,oY), Color3.fromRGB(15,25,50), pOR; Instance.new("UICorner",brBg)
        local brFill = Instance.new("Frame"); brFill.Size, brFill.BackgroundColor3, brFill.BorderSizePixel, brFill.Parent = UDim2.new(0.5,0,1,0), Color3.fromRGB(0,120,255), 0, brBg; Instance.new("UICorner",brFill)
        local brBtn = Instance.new("TextButton"); brBtn.Size, brBtn.Position, brBtn.Text, brBtn.BackgroundColor3, brBtn.Parent = UDim2.new(0,14,0,14), UDim2.new(0.5,-7,0.5,-7), "", Color3.fromRGB(255,255,255), brBg; Instance.new("UICorner",brBtn)
        oY=oY+18; local briSld = false
        brBtn.MouseButton1Down:Connect(function() briSld=true end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then briSld=false end end)
        UserInputService.InputChanged:Connect(function(i) if briSld and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local pos = math.clamp((i.Position.X-brBg.AbsolutePosition.X)/brBg.AbsoluteSize.X,0,1); brFill.Size = UDim2.new(pos,0,1,0); brBtn.Position = UDim2.new(pos,-7,0.5,-7); Lighting.Brightness=pos*3; briLab.Text="Brightness: "..string.format("%.1f",pos*3) end end)
        local timeRow, setTime = makeIosRow("Night Mode", oY, pOR); oY = oY+36
        timeRow.MouseButton1Click:Connect(function() local isNight = not (Lighting.ClockTime == 0); setTime(isNight); if isNight then Lighting.ClockTime=0 else Lighting.ClockTime=14 end end)
        local oPad = Instance.new("Frame"); oPad.Size, oPad.Position, oPad.BackgroundTransparency, oPad.Parent = UDim2.new(1,0,0,20), UDim2.new(0,0,0,oY), 1, pOR
    end

    -- ==========================================
    -- PANEL FREECAM + STABILIZER
    -- ==========================================
    local function buildFreecamPanel()
        local Y = 2
        local camRow, setCamState, getCamState = makeIosRow("Camera", Y, pFC); Y = Y+36
        local hudRow, setHudState, getHudState = makeIosRow("Show HUD", Y, pFC); Y = Y+36
        local lockRow, setLockState, getLockState = makeIosRow("Lock Target", Y, pFC); Y = Y+36
        local sLbl = makeLbl("Smoothness: 50", Y, pFC); Y = Y+16
        local sBg = Instance.new("Frame"); sBg.Size = UDim2.new(0.88,0,0,4); sBg.Position = UDim2.new(0.06,0,0,Y); sBg.BackgroundColor3 = Color3.fromRGB(15,25,50); sBg.Parent = pFC; Instance.new("UICorner",sBg)
        local sFill = Instance.new("Frame"); sFill.Size = UDim2.new(0.5,0,1,0); sFill.BackgroundColor3 = Color3.fromRGB(0,120,255); sFill.BorderSizePixel = 0; sFill.Parent = sBg; Instance.new("UICorner",sFill)
        local sBtn = Instance.new("TextButton"); sBtn.Size = UDim2.new(0,14,0,14); sBtn.Position = UDim2.new(0.5,-7,0.5,-7); sBtn.Text = ""; sBtn.BackgroundColor3 = Color3.fromRGB(255,255,255); sBtn.Parent = sBg; Instance.new("UICorner",sBtn).CornerRadius = UDim.new(1,0)
        Y = Y+18; local sSliding = false
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
        local cOff, cOn = Color3.fromRGB(0,100,230), Color3.fromRGB(50,180,255)
        awFwd.MouseButton1Click:Connect(function() autoWalkActive, autoWalkDirection = true, 1; awFwd.BackgroundColor3, awStop.BackgroundColor3, awBack.BackgroundColor3 = cOn, cOff, cOff end)
        awStop.MouseButton1Click:Connect(function() autoWalkActive, autoWalkDirection = false, 0; moveInputs.F, moveInputs.B = 0, 0; awFwd.BackgroundColor3, awStop.BackgroundColor3, awBack.BackgroundColor3 = cOff, Color3.fromRGB(50,50,50), cOff end)
        awBack.MouseButton1Click:Connect(function() autoWalkActive, autoWalkDirection = true, -1; awFwd.BackgroundColor3, awStop.BackgroundColor3, awBack.BackgroundColor3 = cOff, cOff, cOn end)
        awSpdD.MouseButton1Click:Connect(function() autoWalkSpeed=math.max(autoWalkSpeed-5,1); awSpdLab.Text="AW Speed: "..autoWalkSpeed end)
        awSpdU.MouseButton1Click:Connect(function() autoWalkSpeed=math.min(autoWalkSpeed+5,200); awSpdLab.Text="AW Speed: "..autoWalkSpeed end)
        RunService.Heartbeat:Connect(function() if autoWalkActive and autoWalkDirection~=0 then moveInputs.F, moveInputs.B = math.max(0,autoWalkDirection), math.max(0,-autoWalkDirection) end end)

        makeSepHdr("SHIFTLOCK SETTINGS", Y, pFC); Y = Y+22
        local slRow, setSlState, getSlState = makeIosRow("Show Shiftlock", Y, pFC); Y = Y+36
        slRow.MouseButton1Click:Connect(function() local s = not getSlState(); setSlState(s); shiftlockBtn.Visible = s end)
        
        local slSzLab = makeLbl("Icon Size: 85", Y, pFC, 14); Y = Y+16
        local slSzBg = Instance.new("Frame"); slSzBg.Size = UDim2.new(0.88,0,0,4); slSzBg.Position = UDim2.new(0.06,0,0,Y); slSzBg.BackgroundColor3 = Color3.fromRGB(15,25,50); slSzBg.Parent = pFC; Instance.new("UICorner",slSzBg)
        local slSzFill = Instance.new("Frame"); slSzFill.Size = UDim2.new((85-30)/120,0,1,0); slSzFill.BackgroundColor3 = Color3.fromRGB(0,120,255); slSzFill.BorderSizePixel = 0; slSzFill.Parent = slSzBg; Instance.new("UICorner",slSzFill)
        local slSzBtn = Instance.new("TextButton"); slSzBtn.Size = UDim2.new(0,14,0,14); slSzBtn.Position = UDim2.new((85-30)/120,-7,0.5,-7); slSzBtn.Text = ""; slSzBtn.BackgroundColor3 = Color3.fromRGB(255,255,255); slSzBtn.Parent = slSzBg; Instance.new("UICorner",slSzBtn).CornerRadius = UDim.new(1,0)
        Y = Y+18; local slSzSld = false
        slSzBtn.MouseButton1Down:Connect(function() slSzSld=true end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then slSzSld=false end end)
        UserInputService.InputChanged:Connect(function(i) if slSzSld and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local pos = math.clamp((i.Position.X-slSzBg.AbsolutePosition.X)/slSzBg.AbsoluteSize.X,0,1); slSzFill.Size = UDim2.new(pos,0,1,0); slSzBtn.Position = UDim2.new(pos,-7,0.5,-7); local s = math.floor(30+(pos*120)); slSzLab.Text = "Icon Size: "..s; shiftlockBtn.Size = UDim2.new(0,s,0,s) end end)

        local slXLab = makeLbl("Posisi X: 0.90", Y, pFC, 14); Y = Y+16
        local slXBg = Instance.new("Frame"); slXBg.Size = UDim2.new(0.88,0,0,4); slXBg.Position = UDim2.new(0.06,0,0,Y); slXBg.BackgroundColor3 = Color3.fromRGB(15,25,50); slXBg.Parent = pFC; Instance.new("UICorner",slXBg)
        local slXFill = Instance.new("Frame"); slXFill.Size = UDim2.new(0.9,0,1,0); slXFill.BackgroundColor3 = Color3.fromRGB(0,120,255); slXFill.BorderSizePixel = 0; slXFill.Parent = slXBg; Instance.new("UICorner",slXFill)
        local slXBtn = Instance.new("TextButton"); slXBtn.Size = UDim2.new(0,14,0,14); slXBtn.Position = UDim2.new(0.9,-7,0.5,-7); slXBtn.Text = ""; slXBtn.BackgroundColor3 = Color3.fromRGB(255,255,255); slXBtn.Parent = slXBg; Instance.new("UICorner",slXBtn).CornerRadius = UDim.new(1,0)
        Y = Y+18; local slXSld = false
        slXBtn.MouseButton1Down:Connect(function() slXSld=true end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then slXSld=false end end)
        UserInputService.InputChanged:Connect(function(i) if slXSld and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local pos = math.clamp((i.Position.X-slXBg.AbsolutePosition.X)/slXBg.AbsoluteSize.X,0,1); slXFill.Size = UDim2.new(pos,0,1,0); slXBtn.Position = UDim2.new(pos,-7,0.5,-7); slXLab.Text = string.format("Posisi X: %.2f",pos); shiftlockBtn.Position = UDim2.new(pos,0,shiftlockBtn.Position.Y.Scale,0) end end)

        local slYLab = makeLbl("Posisi Y: 0.50", Y, pFC, 14); Y = Y+16
        local slYBg = Instance.new("Frame"); slYBg.Size = UDim2.new(0.88,0,0,4); slYBg.Position = UDim2.new(0.06,0,0,Y); slYBg.BackgroundColor3 = Color3.fromRGB(15,25,50); slYBg.Parent = pFC; Instance.new("UICorner",slYBg)
        local slYFill = Instance.new("Frame"); slYFill.Size = UDim2.new(0.5,0,1,0); slYFill.BackgroundColor3 = Color3.fromRGB(0,120,255); slYFill.BorderSizePixel = 0; slYFill.Parent = slYBg; Instance.new("UICorner",slYFill)
        local slYBtn = Instance.new("TextButton"); slYBtn.Size = UDim2.new(0,14,0,14); slYBtn.Position = UDim2.new(0.5,-7,0.5,-7); slYBtn.Text = ""; slYBtn.BackgroundColor3 = Color3.fromRGB(255,255,255); slYBtn.Parent = slYBg; Instance.new("UICorner",slYBtn).CornerRadius = UDim.new(1,0)
        Y = Y+18; local slYSld = false
        slYBtn.MouseButton1Down:Connect(function() slYSld=true end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then slYSld=false end end)
        UserInputService.InputChanged:Connect(function(i) if slYSld and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local pos = math.clamp((i.Position.X-slYBg.AbsolutePosition.X)/slYBg.AbsoluteSize.X,0,1); slYFill.Size = UDim2.new(pos,0,1,0); slYBtn.Position = UDim2.new(pos,-7,0.5,-7); slYLab.Text = string.format("Posisi Y: %.2f",pos); shiftlockBtn.Position = UDim2.new(shiftlockBtn.Position.X.Scale,0,pos,0) end end)

        -- ==========================================
        -- CUSTOM JUMP BUTTON SETTINGS
        -- ==========================================
        makeSepHdr("CUSTOM JUMP BUTTON", Y, pFC); Y = Y + 22

        local jumpRow, setJumpState, getJumpState = makeIosRow("Aktifkan Custom Jump", Y, pFC); Y = Y + 36

        jumpRow.MouseButton1Click:Connect(function()
            customJumpActive = not customJumpActive
            setJumpState(customJumpActive)
            jumpContainer.Visible = customJumpActive
            hideOriginalJump(customJumpActive)
            if customJumpActive then
                task.spawn(function()
                    for _ = 1, 10 do
                        task.wait(0.5)
                        hideOriginalJump(true)
                    end
                end)
            end
        end)

        local jSzLab = makeLbl("Ukuran: 80", Y, pFC, 14); Y = Y + 16
        local jSzBg = Instance.new("Frame"); jSzBg.Size = UDim2.new(0.88, 0, 0, 4); jSzBg.Position = UDim2.new(0.06, 0, 0, Y); jSzBg.BackgroundColor3 = Color3.fromRGB(15, 25, 50); jSzBg.Parent = pFC; Instance.new("UICorner", jSzBg)
        local jSzFill = Instance.new("Frame"); jSzFill.Size = UDim2.new((80-40)/160, 0, 1, 0); jSzFill.BackgroundColor3 = Color3.fromRGB(0, 120, 255); jSzFill.BorderSizePixel = 0; jSzFill.Parent = jSzBg; Instance.new("UICorner", jSzFill)
        local jSzKnob = Instance.new("TextButton"); jSzKnob.Size = UDim2.new(0, 14, 0, 14); jSzKnob.Position = UDim2.new((80-40)/160, -7, 0.5, -7); jSzKnob.Text = ""; jSzKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255); jSzKnob.Parent = jSzBg; Instance.new("UICorner", jSzKnob).CornerRadius = UDim.new(1, 0)
        Y = Y + 18; local jSzSld = false
        jSzKnob.MouseButton1Down:Connect(function() jSzSld = true end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then jSzSld = false end end)
        UserInputService.InputChanged:Connect(function(i) if jSzSld and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then local pos = math.clamp((i.Position.X - jSzBg.AbsolutePosition.X) / jSzBg.AbsoluteSize.X, 0, 1); jSzFill.Size = UDim2.new(pos, 0, 1, 0); jSzKnob.Position = UDim2.new(pos, -7, 0.5, -7); customJumpSize = math.floor(40 + pos * 160); jSzLab.Text = "Ukuran: " .. customJumpSize; updateJumpBtn() end end)

        local jXLab = makeLbl("Posisi X: 0.85", Y, pFC, 14); Y = Y + 16
        local jXBg = Instance.new("Frame"); jXBg.Size = UDim2.new(0.88, 0, 0, 4); jXBg.Position = UDim2.new(0.06, 0, 0, Y); jXBg.BackgroundColor3 = Color3.fromRGB(15, 25, 50); jXBg.Parent = pFC; Instance.new("UICorner", jXBg)
        local jXFill = Instance.new("Frame"); jXFill.Size = UDim2.new(0.85, 0, 1, 0); jXFill.BackgroundColor3 = Color3.fromRGB(0, 120, 255); jXFill.BorderSizePixel = 0; jXFill.Parent = jXBg; Instance.new("UICorner", jXFill)
        local jXKnob = Instance.new("TextButton"); jXKnob.Size = UDim2.new(0, 14, 0, 14); jXKnob.Position = UDim2.new(0.85, -7, 0.5, -7); jXKnob.Text = ""; jXKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255); jXKnob.Parent = jXBg; Instance.new("UICorner", jXKnob).CornerRadius = UDim.new(1, 0)
        Y = Y + 18; local jXSld = false
        jXKnob.MouseButton1Down:Connect(function() jXSld = true end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then jXSld = false end end)
        UserInputService.InputChanged:Connect(function(i) if jXSld and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then local pos = math.clamp((i.Position.X - jXBg.AbsolutePosition.X) / jXBg.AbsoluteSize.X, 0, 1); jXFill.Size = UDim2.new(pos, 0, 1, 0); jXKnob.Position = UDim2.new(pos, -7, 0.5, -7); customJumpX = pos; jXLab.Text = string.format("Posisi X: %.2f", pos); updateJumpBtn() end end)

        local jYLab = makeLbl("Posisi Y: 0.75", Y, pFC, 14); Y = Y + 16
        local jYBg = Instance.new("Frame"); jYBg.Size = UDim2.new(0.88, 0, 0, 4); jYBg.Position = UDim2.new(0.06, 0, 0, Y); jYBg.BackgroundColor3 = Color3.fromRGB(15, 25, 50); jYBg.Parent = pFC; Instance.new("UICorner", jYBg)
        local jYFill = Instance.new("Frame"); jYFill.Size = UDim2.new(0.75, 0, 1, 0); jYFill.BackgroundColor3 = Color3.fromRGB(0, 120, 255); jYFill.BorderSizePixel = 0; jYFill.Parent = jYBg; Instance.new("UICorner", jYFill)
        local jYKnob = Instance.new("TextButton"); jYKnob.Size = UDim2.new(0, 14, 0, 14); jYKnob.Position = UDim2.new(0.75, -7, 0.5, -7); jYKnob.Text = ""; jYKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255); jYKnob.Parent = jYBg; Instance.new("UICorner", jYKnob).CornerRadius = UDim.new(1, 0)
        Y = Y + 18; local jYSld = false
        jYKnob.MouseButton1Down:Connect(function() jYSld = true end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then jYSld = false end end)
        UserInputService.InputChanged:Connect(function(i) if jYSld and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then local pos = math.clamp((i.Position.X - jYBg.AbsolutePosition.X) / jYBg.AbsoluteSize.X, 0, 1); jYFill.Size = UDim2.new(pos, 0, 1, 0); jYKnob.Position = UDim2.new(pos, -7, 0.5, -7); customJumpY = pos; jYLab.Text = string.format("Posisi Y: %.2f", pos); updateJumpBtn() end end)

        -- ==========================================
        -- CAMERA + CHARACTER STABILIZER
        -- ==========================================
        makeSepHdr("STABILIZER (Kamera + Karakter)", Y, pFC); Y = Y + 22

        local stabRow, setStabState, getStabState = makeIosRow("Aktifkan Stabilizer", Y, pFC); Y = Y + 36
        local stabInfoLbl = makeLbl("▸ Stabil saat lompat di tangga/obstacle", Y, pFC, 14, Color3.fromRGB(50, 150, 255)); Y = Y + 18

        -- Slider kekuatan redam karakter
        local charStabLab = makeLbl("Redam Karakter: 85%", Y, pFC, 14); Y = Y + 16
        local cStabBg = Instance.new("Frame"); cStabBg.Size = UDim2.new(0.88, 0, 0, 4); cStabBg.Position = UDim2.new(0.06, 0, 0, Y); cStabBg.BackgroundColor3 = Color3.fromRGB(15, 25, 50); cStabBg.Parent = pFC; Instance.new("UICorner", cStabBg)
        local cStabFill = Instance.new("Frame"); cStabFill.Size = UDim2.new(0.85, 0, 1, 0); cStabFill.BackgroundColor3 = Color3.fromRGB(0, 120, 255); cStabFill.BorderSizePixel = 0; cStabFill.Parent = cStabBg; Instance.new("UICorner", cStabFill)
        local cStabKnob = Instance.new("TextButton"); cStabKnob.Size = UDim2.new(0, 14, 0, 14); cStabKnob.Position = UDim2.new(0.85, -7, 0.5, -7); cStabKnob.Text = ""; cStabKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255); cStabKnob.Parent = cStabBg; Instance.new("UICorner", cStabKnob).CornerRadius = UDim.new(1, 0)
        Y = Y + 18; local cStabSld = false
        cStabKnob.MouseButton1Down:Connect(function() cStabSld = true end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then cStabSld = false end end)
        UserInputService.InputChanged:Connect(function(i)
            if cStabSld and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                local pos = math.clamp((i.Position.X - cStabBg.AbsolutePosition.X) / cStabBg.AbsoluteSize.X, 0, 1)
                cStabFill.Size = UDim2.new(pos, 0, 1, 0)
                cStabKnob.Position = UDim2.new(pos, -7, 0.5, -7)
                CHAR_STAB_STRENGTH = pos * 0.97
                charStabLab.Text = "Redam Karakter: " .. math.floor(pos * 97) .. "%"
            end
        end)

        -- Slider kecepatan return kamera
        local stabStrLab = makeLbl("Kecepatan Return Kamera: 15%", Y, pFC, 14); Y = Y + 16
        local stabStrBg = Instance.new("Frame"); stabStrBg.Size = UDim2.new(0.88, 0, 0, 4); stabStrBg.Position = UDim2.new(0.06, 0, 0, Y); stabStrBg.BackgroundColor3 = Color3.fromRGB(15, 25, 50); stabStrBg.Parent = pFC; Instance.new("UICorner", stabStrBg)
        local stabStrFill = Instance.new("Frame"); stabStrFill.Size = UDim2.new(0.15, 0, 1, 0); stabStrFill.BackgroundColor3 = Color3.fromRGB(0, 120, 255); stabStrFill.BorderSizePixel = 0; stabStrFill.Parent = stabStrBg; Instance.new("UICorner", stabStrFill)
        local stabStrKnob = Instance.new("TextButton"); stabStrKnob.Size = UDim2.new(0, 14, 0, 14); stabStrKnob.Position = UDim2.new(0.15, -7, 0.5, -7); stabStrKnob.Text = ""; stabStrKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255); stabStrKnob.Parent = stabStrBg; Instance.new("UICorner", stabStrKnob).CornerRadius = UDim.new(1, 0)
        Y = Y + 18; local stabStrSld = false
        stabStrKnob.MouseButton1Down:Connect(function() stabStrSld = true end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then stabStrSld = false end end)
        UserInputService.InputChanged:Connect(function(i)
            if stabStrSld and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                local pos = math.clamp((i.Position.X - stabStrBg.AbsolutePosition.X) / stabStrBg.AbsoluteSize.X, 0, 1)
                stabStrFill.Size = UDim2.new(pos, 0, 1, 0)
                stabStrKnob.Position = UDim2.new(pos, -7, 0.5, -7)
                STAB_STRENGTH = math.clamp(pos, 0.01, 1)
                stabStrLab.Text = "Kecepatan Return Kamera: " .. math.floor(pos * 100) .. "%"
            end
        end)

        -- Slider delay return
        local stabDelayLab = makeLbl("Delay Return: 0.8s", Y, pFC, 14); Y = Y + 16
        local stabDelayBg = Instance.new("Frame"); stabDelayBg.Size = UDim2.new(0.88, 0, 0, 4); stabDelayBg.Position = UDim2.new(0.06, 0, 0, Y); stabDelayBg.BackgroundColor3 = Color3.fromRGB(15, 25, 50); stabDelayBg.Parent = pFC; Instance.new("UICorner", stabDelayBg)
        local stabDelayFill = Instance.new("Frame"); stabDelayFill.Size = UDim2.new(0.16, 0, 1, 0); stabDelayFill.BackgroundColor3 = Color3.fromRGB(0, 120, 255); stabDelayFill.BorderSizePixel = 0; stabDelayFill.Parent = stabDelayBg; Instance.new("UICorner", stabDelayFill)
        local stabDelayKnob = Instance.new("TextButton"); stabDelayKnob.Size = UDim2.new(0, 14, 0, 14); stabDelayKnob.Position = UDim2.new(0.16, -7, 0.5, -7); stabDelayKnob.Text = ""; stabDelayKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255); stabDelayKnob.Parent = stabDelayBg; Instance.new("UICorner", stabDelayKnob).CornerRadius = UDim.new(1, 0)
        Y = Y + 18; local stabDelaySld = false
        stabDelayKnob.MouseButton1Down:Connect(function() stabDelaySld = true end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then stabDelaySld = false end end)
        UserInputService.InputChanged:Connect(function(i)
            if stabDelaySld and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                local pos = math.clamp((i.Position.X - stabDelayBg.AbsolutePosition.X) / stabDelayBg.AbsoluteSize.X, 0, 1)
                stabDelayFill.Size = UDim2.new(pos, 0, 1, 0)
                stabDelayKnob.Position = UDim2.new(pos, -7, 0.5, -7)
                local val = math.floor(pos * 50) / 10
                stabDelayLab.Text = "Delay Return: " .. val .. "s"
                STAB_RETURN_DELAY = val
            end
        end)

        -- Tombol lock arah sekarang
        local lockDirBtn = Instance.new("TextButton")
        lockDirBtn.Text = "📌 Lock Arah Kamera Sekarang"
        lockDirBtn.Size = UDim2.new(0.92, 0, 0, 28)
        lockDirBtn.Position = UDim2.new(0.04, 0, 0, Y)
        lockDirBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 230)
        lockDirBtn.BackgroundTransparency = 0.4
        lockDirBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        lockDirBtn.Font = Enum.Font.GothamBold
        lockDirBtn.TextSize = 10
        lockDirBtn.Parent = pFC
        Instance.new("UICorner", lockDirBtn).CornerRadius = UDim.new(0, 6)
        Y = Y + 34

        lockDirBtn.MouseButton1Click:Connect(function()
            stabYaw = targetYaw
            stabPitch = targetPitch
            lockDirBtn.Text = "✅ Arah Terkunci!"
            task.wait(1.2)
            lockDirBtn.Text = "📌 Lock Arah Kamera Sekarang"
        end)

        stabRow.MouseButton1Click:Connect(function()
            stabilizerActive = not stabilizerActive
            setStabState(stabilizerActive)
            if stabilizerActive then
                stabYaw = targetYaw
                stabPitch = targetPitch
                lastSwipeTime = tick()
                stabInfoLbl.Text = "▸ AKTIF 🔒 Karakter + Kamera stabil"
                stabInfoLbl.TextColor3 = Color3.fromRGB(0, 200, 100)
            else
                stabInfoLbl.Text = "▸ Stabil saat lompat di tangga/obstacle"
                stabInfoLbl.TextColor3 = Color3.fromRGB(50, 150, 255)
            end
        end)

        local bPadFC = Instance.new("Frame"); bPadFC.Size = UDim2.new(1,0,0,20); bPadFC.Position = UDim2.new(0,0,0,Y); bPadFC.BackgroundTransparency = 1; bPadFC.Parent = pFC

        -- HUD MOBILE
        local hud = Instance.new("Frame"); hud.Size, hud.BackgroundTransparency, hud.Visible, hud.Parent = UDim2.new(1,0,1,0), 1, false, screenGui
        local function bHUD(t,p,k,type) local b = Instance.new("TextButton"); b.Text, b.Size, b.Position, b.BackgroundColor3, b.BackgroundTransparency, b.TextColor3, b.Font, b.Parent = t, UDim2.new(0,50,0,50), p, Color3.fromRGB(10,20,45), 0.3, Color3.fromRGB(50,150,255), Enum.Font.GothamBold, hud; Instance.new("UICorner",b).CornerRadius = UDim.new(1,0)
            b.InputBegan:Connect(function() if type=="m" then moveInputs[k]=1 else zoomInputs[k]=1 end end); b.InputEnded:Connect(function() if type=="m" then moveInputs[k]=0 else zoomInputs[k]=0 end end) end
        bHUD("W",UDim2.new(0,80,1,-150),"F","m"); bHUD("S",UDim2.new(0,80,1,-80),"B","m"); bHUD("A",UDim2.new(0,15,1,-80),"L","m"); bHUD("D",UDim2.new(0,145,1,-80),"R","m"); bHUD("UP",UDim2.new(1,-140,1,-150),"U","m"); bHUD("DN",UDim2.new(1,-140,1,-80),"D","m"); bHUD("+",UDim2.new(1,-70,1,-150),"In","z"); bHUD("-",UDim2.new(1,-70,1,-80),"Out","z")

        camRow.MouseButton1Click:Connect(function() isFreecamActive = not isFreecamActive; setCamState(isFreecamActive); hud.Visible = (isFreecamActive and getHudState())
            if isFreecamActive then PlayerModule:Disable(); Camera.CameraType = Enum.CameraType.Scriptable
            else PlayerModule:Enable(); Camera.CameraType = Enum.CameraType.Custom; lockTarget, isLockOn, autoWalkActive, autoWalkDirection = nil, false, false, 0; setLockState(false); moveInputs.F, moveInputs.B = 0, 0; awFwd.BackgroundColor3, awStop.BackgroundColor3, awBack.BackgroundColor3, hud.Visible = cOff, Color3.fromRGB(50,50,50), cOff, false end end)
        setHudState(true); hudRow.MouseButton1Click:Connect(function() local newState = not getHudState(); setHudState(newState); if isFreecamActive then hud.Visible=newState end end); lockRow.MouseButton1Click:Connect(function() isLockOn = not isLockOn; setLockState(isLockOn); if not isLockOn then lockTarget=nil end end)

        -- RENDER ENGINE
        RunService:BindToRenderStep("SyaaaEngine", Enum.RenderPriority.Camera.Value+1, function(dt)
            if not isFreecamActive then return end
            local rotAlpha = math.clamp(dt*((101-smoothValue)/10),0.01,1)
            local rawMove = Vector3.new(moveInputs.R-moveInputs.L, moveInputs.U-moveInputs.D, moveInputs.B-moveInputs.F)
            if zoomInputs.In == 1 then if targetFov > 1 then targetFov = math.clamp(targetFov - 1.5, 1, 170) else rawMove = rawMove + Vector3.new(0, 0, -1.5) end end
            if zoomInputs.Out == 1 then if targetFov < 170 then targetFov = math.clamp(targetFov + 1.5, 1, 170) else rawMove = rawMove + Vector3.new(0, 0, 1.5) end end
            Camera.FieldOfView = Camera.FieldOfView + (targetFov-Camera.FieldOfView)*rotAlpha
            local mVec = rawMove; if mVec.Magnitude > 0 then mVec = mVec.Unit end
            if lockTarget then
                local tPos = (lockTarget:IsA("BasePart") and lockTarget.Position) or (lockTarget:IsA("Model") and lockTarget:GetPivot().Position) or lockTarget
                local nextPos = Camera.CFrame.Position + Camera.CFrame:VectorToWorldSpace(mVec*moveSpeed*dt)
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(nextPos,tPos),rotAlpha)
            else
                -- STABILIZER KAMERA
                if stabilizerActive then
                    local timeSinceSwipe = tick() - lastSwipeTime
                    if timeSinceSwipe > STAB_RETURN_DELAY then
                        targetYaw = targetYaw + (stabYaw - targetYaw) * math.clamp(STAB_STRENGTH, 0.01, 1)
                        targetPitch = targetPitch + (stabPitch - targetPitch) * math.clamp(STAB_STRENGTH, 0.01, 1)
                    end
                end
                displayYaw = displayYaw + (targetYaw - displayYaw) * rotAlpha
                displayPitch = displayPitch + (targetPitch - displayPitch) * rotAlpha
                local newCamRot = CFrame.Angles(0, math.rad(displayYaw), 0) * CFrame.Angles(math.rad(displayPitch), 0, 0)
                local nextPos = Camera.CFrame.Position + newCamRot:VectorToWorldSpace(mVec*moveSpeed*dt)
                Camera.CFrame = CFrame.new(nextPos) * newCamRot
            end
        end)

        -- INPUT SWIPE (dengan stabilizer update)
        UserInputService.InputBegan:Connect(function(input,gpe)
            if not gpe and isFreecamActive and isLockOn and (input.UserInputType==Enum.UserInputType.Touch or input.UserInputType==Enum.UserInputType.MouseButton1) then
                local unitRay = Camera:ScreenPointToRay(input.Position.X,input.Position.Y)
                local result = workspace:Raycast(unitRay.Origin,unitRay.Direction*2000)
                if result and result.Instance then lockTarget=result.Instance end
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if isFreecamActive and not lockTarget and (input.UserInputType==Enum.UserInputType.Touch or input.UserInputType==Enum.UserInputType.MouseMovement) then
                local dx = input.Delta.X
                local dy = input.Delta.Y
                -- Filter noise minimal supaya gerakan kecil ga ganggu stabilizer
                if math.abs(dx) < 0.5 and math.abs(dy) < 0.5 then return end
                targetYaw = targetYaw - (dx * 0.3)
                targetPitch = math.clamp(targetPitch - (dy * 0.3), -88, 88)
                if stabilizerActive then
                    -- User swipe manual → update titik stabil ke posisi baru + catat waktu
                    lastSwipeTime = tick()
                    stabYaw = targetYaw
                    stabPitch = targetPitch
                end
            end
        end)
    end

    -- EXECUTE PANELS
    buildHomePanel()
    buildToolsPanel()
    buildOrientationPanel()
    buildFreecamPanel()

    setTab("Home") 
end

startLoading(runSyaaHub)
