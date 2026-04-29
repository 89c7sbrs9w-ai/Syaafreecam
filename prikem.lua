-- // Layanan Roblox //
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- // Modul Kontrol Analog / PC //
local PlayerModule = require(player:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"))
local Controls = PlayerModule:GetControls()

-- // Variabel State //
local isFlying = false
local flySpeedLevel = 1
local baseFlySpeed = 40
local upPressed = false
local downPressed = false
local flyBodyVelocity, flyBodyGyro

-- // Proteksi GUI //
local guiParent = pcall(function() return CoreGui end) and CoreGui or player:WaitForChild("PlayerGui")

if guiParent:FindFirstChild("SyaaFlyV4_Final") then
    guiParent.SyaaFlyV4_Final:Destroy()
end

-- // Pengaturan Tema //
local theme = {
    bg = Color3.fromRGB(20, 20, 20),
    border = Color3.fromRGB(0, 100, 255),
    text = Color3.fromRGB(255, 255, 255)
}

-- // Fungsi Notifikasi Slide ke Kiri //
local function showNotify(msg)
    local notifyGui = Instance.new("ScreenGui")
    notifyGui.Name = "SyaaNotify_" .. tostring(tick())
    notifyGui.ResetOnSpawn = false
    notifyGui.Parent = guiParent

    local notifyFrame = Instance.new("Frame")
    notifyFrame.Size = UDim2.new(0, 160, 0, 44)
    notifyFrame.Position = UDim2.new(1, 10, 0.08, 0)
    notifyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    notifyFrame.BorderSizePixel = 0
    notifyFrame.Parent = notifyGui

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 100, 255)
    stroke.Thickness = 1.2
    stroke.Parent = notifyFrame

    Instance.new("UICorner", notifyFrame).CornerRadius = UDim.new(0, 6)

    -- Ambil avatar tepresakkriminal
    local userId
    local ok, result = pcall(function()
        return Players:GetUserIdFromNameAsync("tepresakkriminal")
    end)
    if ok then userId = result else userId = player.UserId end

    local av = Instance.new("ImageLabel")
    av.Size = UDim2.new(0, 30, 0, 30)
    av.Position = UDim2.new(0, 7, 0.5, -15)
    av.BackgroundTransparency = 1
    av.Image = Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    av.Parent = notifyFrame
    Instance.new("UICorner", av).CornerRadius = UDim.new(1, 0)

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -45, 0, 14)
    titleLbl.Position = UDim2.new(0, 43, 0, 7)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = "Developer  •  syaaa"
    titleLbl.TextColor3 = Color3.fromRGB(0, 120, 255)
    titleLbl.TextSize = 9
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = notifyFrame

    local descLbl = Instance.new("TextLabel")
    descLbl.Size = UDim2.new(1, -45, 0, 14)
    descLbl.Position = UDim2.new(0, 43, 0, 22)
    descLbl.BackgroundTransparency = 1
    descLbl.Text = msg
    descLbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    descLbl.TextSize = 9
    descLbl.Font = Enum.Font.Gotham
    descLbl.TextXAlignment = Enum.TextXAlignment.Left
    descLbl.Parent = notifyFrame

    -- Slide IN dari kanan ke kiri
    notifyFrame:TweenPosition(UDim2.new(1, -170, 0.08, 0), "Out", "Quad", 0.4, true)
    task.wait(2.8)
    -- Slide OUT balik ke kanan
    notifyFrame:TweenPosition(UDim2.new(1, 10, 0.08, 0), "In", "Quad", 0.35, true, function()
        notifyGui:Destroy()
    end)
end

-- // Muncul sekali otomatis pas execute //
task.spawn(function()
    task.wait(0.5)
    showNotify("gui fly loaded")
end)

-- // Membuat GUI //
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SyaaFlyV4_Final"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = guiParent

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 190, 0, 110)
MainFrame.Position = UDim2.new(0, 50, 0.3, 0)
MainFrame.BackgroundTransparency = 1
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true

local function createCell(name, size, pos, parent)
    local cell = Instance.new("Frame")
    cell.Name = name
    cell.Size = size
    cell.Position = pos
    cell.BackgroundColor3 = theme.bg
    cell.BorderSizePixel = 0
    cell.Parent = parent
    local stroke = Instance.new("UIStroke")
    stroke.Color = theme.border
    stroke.Thickness = 1.2
    stroke.Parent = cell
    Instance.new("UICorner", cell).CornerRadius = UDim.new(0, 4)
    return cell
end

-- Grid Layout
local btnClose = createCell("BtnX", UDim2.new(0, 42, 0, 34), UDim2.new(0, 0, 0, 0), MainFrame)
local txtClose = Instance.new("TextButton")
txtClose.Size = UDim2.new(1, 0, 1, 0); txtClose.BackgroundTransparency = 1; txtClose.Text = "x"; txtClose.TextColor3 = theme.text; txtClose.TextSize = 16; txtClose.Font = Enum.Font.GothamBold; txtClose.Parent = btnClose

local cellAvTop = createCell("AvTop", UDim2.new(0, 42, 0, 34), UDim2.new(0, 44, 0, 0), MainFrame)
local imgT = Instance.new("ImageLabel")
imgT.Size = UDim2.new(0, 24, 0, 24); imgT.Position = UDim2.new(0.5, -12, 0.5, -12); imgT.BackgroundTransparency = 1; imgT.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420); imgT.Parent = cellAvTop; Instance.new("UICorner", imgT).CornerRadius = UDim.new(1, 0)

local btnUp = createCell("BtnUp", UDim2.new(0, 42, 0, 34), UDim2.new(0, 0, 0, 36), MainFrame)
local txtUp = txtClose:Clone(); txtUp.Parent = btnUp; txtUp.Text = "up"; txtUp.TextSize = 12

local btnPlus = createCell("BtnPlus", UDim2.new(0, 42, 0, 34), UDim2.new(0, 44, 0, 36), MainFrame)
local txtPlus = txtClose:Clone(); txtPlus.Parent = btnPlus; txtPlus.Text = "+"; txtPlus.TextSize = 18

local cellProf = createCell("Prof", UDim2.new(0, 100, 0, 34), UDim2.new(0, 88, 0, 36), MainFrame)
local imgS = imgT:Clone(); imgS.Position = UDim2.new(0, 5, 0.5, -12); imgS.Parent = cellProf
local txtN = Instance.new("TextLabel")
txtN.Size = UDim2.new(1, -35, 1, 0); txtN.Position = UDim2.new(0, 32, 0, 0); txtN.BackgroundTransparency = 1; txtN.Text = player.DisplayName; txtN.TextColor3 = theme.text; txtN.TextSize = 9; txtN.Font = Enum.Font.GothamSemibold; txtN.TextXAlignment = Enum.TextXAlignment.Left; txtN.Parent = cellProf

local btnDown = createCell("BtnDown", UDim2.new(0, 42, 0, 34), UDim2.new(0, 0, 0, 72), MainFrame)
local txtDown = txtUp:Clone(); txtDown.Parent = btnDown; txtDown.Text = "down"

local btnMinus = createCell("BtnMinus", UDim2.new(0, 42, 0, 34), UDim2.new(0, 44, 0, 72), MainFrame)
local txtMinus = txtPlus:Clone(); txtMinus.Parent = btnMinus; txtMinus.Text = "-"

local cellSpd = createCell("Spd", UDim2.new(0, 36, 0, 34), UDim2.new(0, 88, 0, 72), MainFrame)
local txtSpd = txtClose:Clone(); txtSpd.Parent = cellSpd; txtSpd.Text = tostring(flySpeedLevel); txtSpd.TextSize = 14

local cellTog = createCell("Tog", UDim2.new(0, 62, 0, 34), UDim2.new(0, 126, 0, 72), MainFrame)
local btnTogArea = Instance.new("TextButton")
btnTogArea.Size = UDim2.new(1, 0, 1, 0); btnTogArea.BackgroundTransparency = 1; btnTogArea.Text = ""; btnTogArea.Parent = cellTog

local tBg = Instance.new("Frame")
tBg.Size = UDim2.new(0, 36, 0, 16); tBg.Position = UDim2.new(0.5, -18, 0.5, -8); tBg.BackgroundColor3 = Color3.fromRGB(150, 150, 150); tBg.Parent = btnTogArea; Instance.new("UICorner", tBg).CornerRadius = UDim.new(1, 0)

local tC = Instance.new("Frame")
tC.Size = UDim2.new(0, 12, 0, 12); tC.Position = UDim2.new(0, 2, 0.5, -6); tC.BackgroundColor3 = Color3.fromRGB(255, 255, 255); tC.Parent = tBg; Instance.new("UICorner", tC).CornerRadius = UDim.new(1, 0)

-- // Engine Fly //
local function getP()
    local c = player.Character
    return c and c:FindFirstChildOfClass("Humanoid"), c and c:FindFirstChild("HumanoidRootPart")
end

local function stop()
    isFlying = false
    if flyBodyVelocity then flyBodyVelocity:Destroy() end
    if flyBodyGyro then flyBodyGyro:Destroy() end
    local h = getP()
    if h then h.PlatformStand = false end
    TweenService:Create(tC, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -6)}):Play()
    TweenService:Create(tBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(150, 150, 150)}):Play()
end

local function start()
    local h, r = getP()
    if not r then return end
    isFlying = true
    h.PlatformStand = true
    flyBodyVelocity = Instance.new("BodyVelocity", r)
    flyBodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    flyBodyVelocity.Velocity = Vector3.new(0,0,0)
    flyBodyGyro = Instance.new("BodyGyro", r)
    flyBodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    flyBodyGyro.CFrame = r.CFrame
    TweenService:Create(tC, TweenInfo.new(0.2), {Position = UDim2.new(1, -14, 0.5, -6)}):Play()
    TweenService:Create(tBg, TweenInfo.new(0.2), {BackgroundColor3 = theme.border}):Play()
end

-- // Loop (Smooth Lerp) //
RunService.RenderStepped:Connect(function()
    if isFlying then
        local h, r = getP()
        if not r or not flyBodyVelocity then return end
        h.PlatformStand = true
        local move = Controls:GetMoveVector()
        local cam = camera.CFrame
        local dir = (cam.RightVector * move.X) + (cam.LookVector * -move.Z)
        local vs = (upPressed and 1 or 0) - (downPressed and 1 or 0)
        local spd = baseFlySpeed * flySpeedLevel
        local target = (dir * spd) + Vector3.new(0, vs * spd, 0)
        flyBodyVelocity.Velocity = flyBodyVelocity.Velocity:Lerp(target, 0.1)
        flyBodyGyro.CFrame = cam
    end
end)

-- // Interaction //
txtClose.MouseButton1Click:Connect(function() stop() ScreenGui:Destroy() end)
btnTogArea.MouseButton1Click:Connect(function() if isFlying then stop() else start() end end)
txtPlus.MouseButton1Click:Connect(function() flySpeedLevel = flySpeedLevel + 1 txtSpd.Text = tostring(flySpeedLevel) end)
txtMinus.MouseButton1Click:Connect(function() if flySpeedLevel > 1 then flySpeedLevel = flySpeedLevel - 1 txtSpd.Text = tostring(flySpeedLevel) end end)
txtUp.MouseButton1Down:Connect(function() upPressed = true end); txtUp.MouseButton1Up:Connect(function() upPressed = false end)
txtDown.MouseButton1Down:Connect(function() downPressed = true end); txtDown.MouseButton1Up:Connect(function() downPressed = false end)
