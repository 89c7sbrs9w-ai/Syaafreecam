-- =================================================================
-- ==     SCRIPT FREECAM LENGKAP (MOBILE) - UNLIMITED ZOOM        ==
-- ==      (FIXED: math.clamp pada FOV/Zoom dihapus)                ==
-- =================================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Service untuk kontrol karakter
local localPlayer = Players.LocalPlayer
local playerScripts = localPlayer:WaitForChild("PlayerScripts")

-- Ambil modul kontrol
local PlayerModule = playerScripts:WaitForChild("PlayerModule") 
local controls = require(PlayerModule):GetControls() 

-- Variabel Kamera
local Camera = workspace.CurrentCamera
local originalCameraType = Camera.CameraType
local originalCameraFocus = Camera.Focus

-- Variabel Status
local isFreecamActive = false
local moveSpeed = 10
local minSpeed = 0.5
local maxSpeed = 500
local speedChangeAmount = 5
local mouseSensitivity = 0.15

-- Variabel Smooth
local moveSmoothness = 10   -- Kehalusan gerak maju/mundur
local lookSmoothness = 3    -- SUPER SMOOTH (BIAR ADA INERTIA/DRIFT)
local targetFov = 70 
-- ==========================================
-- == BATAS ZOOM DIHAPUS ==
-- local minFov = 20 -- <<-- DIHAPUS
-- local maxFov = 100 -- <<-- DIHAPUS
-- ==========================================
local fovAtPinchStart = 70
local zoomSpeed = 30 -- Kecepatan zoom (derajat per detik)
local currentMoveVelocity = Vector3.new(0, 0, 0)

-- Variabel Rotasi Anti-Miring
local targetYaw = 0   
local targetPitch = 0 
local displayYaw = 0
local displayPitch = 0

-- Variabel Tap-to-Lock
local isFocusLocked = false
local focusPoint = nil
local raycastDistance = 1000 
local isDragging = false     

-- Variabel Input
local moveInputs = { F = 0, B = 0, L = 0, R = 0, U = 0, D = 0 }
local zoomInputs = { In = 0, Out = 0 } -- Variabel baru untuk zoom
local activeLookTouch = nil
local lastLookPosition = nil
local renderSteppedConnection = nil

-- =================================================================
-- 0. FUNGSI HELPER (Lerp)
-- =================================================================
local function lerp(a, b, t)
	return a + (b - a) * t
end

-- =================================================================
-- 1. BUAT SEMUA GUI KONTROL (AUTO GENERATE)
-- (Tidak ada perubahan)
-- =================================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MobileFreecamGUI"
screenGui.ResetOnSpawn = false
local function createButton(name, text, size, position, anchor, parent)
	local button = Instance.new("TextButton")
	button.Name = name
	button.Text = text
	button.Size = size
	button.Position = position
	button.AnchorPoint = anchor
	button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	button.BackgroundTransparency = 0.6
	button.BorderColor3 = Color3.fromRGB(255, 255, 255)
	button.BorderSizePixel = 1
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.SourceSansBold
	button.TextSize = 20
	button.Parent = parent
	button.Modal = true 
	return button
end
local toggleButton = createButton("ToggleButton", "Freecam: OFF", UDim2.new(0, 150, 0, 40), UDim2.new(0, 20, 0, 20), Vector2.new(0, 0), screenGui)
local lockIndicator = Instance.new("TextLabel")
lockIndicator.Name = "LockIndicator"
lockIndicator.Text = "🔒 LOCKED"
lockIndicator.Visible = false 
lockIndicator.Size = UDim2.new(0, 200, 0, 40)
lockIndicator.Position = UDim2.new(0.5, 0, 0, 70)
lockIndicator.AnchorPoint = Vector2.new(0.5, 0)
lockIndicator.BackgroundTransparency = 1
lockIndicator.TextColor3 = Color3.fromRGB(255, 50, 50)
lockIndicator.Font = Enum.Font.SourceSansBold
lockIndicator.TextSize = 24
lockIndicator.Parent = screenGui
local controlsFrame = Instance.new("Frame")
controlsFrame.Name = "ControlsFrame"
controlsFrame.BackgroundTransparency = 1
controlsFrame.Size = UDim2.new(1, 0, 1, 0)
controlsFrame.Visible = false
controlsFrame.Parent = screenGui
local moveFrame = Instance.new("Frame")
moveFrame.BackgroundTransparency = 1
moveFrame.Size = UDim2.new(0, 200, 0, 200)
moveFrame.Position = UDim2.new(0, 50, 1, -50)
moveFrame.AnchorPoint = Vector2.new(0, 1)
moveFrame.Parent = controlsFrame
local btnForward = createButton("Forward", "W", UDim2.new(0, 60, 0, 60), UDim2.new(0.5, 0, 0, 0), Vector2.new(0.5, 0), moveFrame)
local btnBack = createButton("Back", "S", UDim2.new(0, 60, 0, 60), UDim2.new(0.5, 0, 1, 0), Vector2.new(0.5, 1), moveFrame)
local btnLeft = createButton("Left", "A", UDim2.new(0, 60, 0, 60), UDim2.new(0, 0, 0.5, 0), Vector2.new(0, 0.5), moveFrame)
local btnRight = createButton("Right", "D", UDim2.new(0, 60, 0, 60), UDim2.new(1, 0, 0.5, 0), Vector2.new(1, 0.5), moveFrame)
local upDownFrame = Instance.new("Frame")
upDownFrame.BackgroundTransparency = 1
upDownFrame.Size = UDim2.new(0, 80, 0, 260) 
upDownFrame.Position = UDim2.new(1, -50, 1, -50)
upDownFrame.AnchorPoint = Vector2.new(1, 1)
upDownFrame.Parent = controlsFrame
local btnUp = createButton("Up", "E (Up)", UDim2.new(1, 0, 0.23, 0), UDim2.new(0.5, 0, 0, 0), Vector2.new(0.5, 0), upDownFrame)
local btnDown = createButton("Down", "Q (Down)", UDim2.new(1, 0, 0.23, 0), UDim2.new(0.5, 0, 0.25, 0), Vector2.new(0.5, 0), upDownFrame)
local btnZoomIn = createButton("ZoomIn", "+", UDim2.new(1, 0, 0.23, 0), UDim2.new(0.5, 0, 0.5, 0), Vector2.new(0.5, 0), upDownFrame)
local btnZoomOut = createButton("ZoomOut", "-", UDim2.new(1, 0, 0.23, 0), UDim2.new(0.5, 0, 0.75, 0), Vector2.new(0.5, 0), upDownFrame)
btnZoomIn.TextSize = 30
btnZoomOut.TextSize = 30
local speedFrame = Instance.new("Frame")
speedFrame.Name = "SpeedControlFrame"
speedFrame.BackgroundTransparency = 1
speedFrame.Size = UDim2.new(0.5, 0, 0, 40)
speedFrame.Position = UDim2.new(0.5, 0, 0, 20)
speedFrame.AnchorPoint = Vector2.new(0.5, 0)
speedFrame.Parent = controlsFrame
local btnSpeedDown = createButton("SpeedDown", "-", UDim2.new(0, 50, 1, 0), UDim2.new(0, 0, 0.5, 0), Vector2.new(0, 0.5), speedFrame)
local btnSpeedUp = createButton("SpeedUp", "+", UDim2.new(0, 50, 1, 0), UDim2.new(1, 0, 0.5, 0), Vector2.new(1, 0.5), speedFrame)
local speedLabel = Instance.new("TextLabel")
speedLabel.Name = "SpeedLabel"
speedLabel.Text = "Speed: " .. math.floor(moveSpeed)
speedLabel.Size = UDim2.new(1, -110, 1, 0)
speedLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
speedLabel.AnchorPoint = Vector2.new(0.5, 0.5)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.Font = Enum.Font.SourceSansBold
speedLabel.TextSize = 18
speedLabel.Parent = speedFrame
screenGui.Parent = localPlayer:WaitForChild("PlayerGui")

-- =================================================================
-- 2. FUNGSI INTI FREECAM (LOGIKA RENDER DIRUBAH)
-- =================================================================

local function onRenderStepped(deltaTime)
	if not isFreecamActive then return end
	
	local moveSmoothAlpha = 1 - math.exp(-moveSmoothness * deltaTime)
	local lookSmoothAlpha = 1 - math.exp(-lookSmoothness * deltaTime)
	
	local moveVector = Vector3.new(
		moveInputs.R - moveInputs.L,
		moveInputs.U - moveInputs.D,
		moveInputs.B - moveInputs.F
	)
	if moveVector.Magnitude > 0 then
		moveVector = moveVector.Unit
	end

	if isFocusLocked and focusPoint then
		-- ===========================
		-- == MODE ORBIT (LOCK NYALA) ==
		-- ===========================
		
		displayYaw = lerp(displayYaw, targetYaw, lookSmoothAlpha)
		displayPitch = lerp(displayPitch, targetPitch, lookSmoothAlpha)
		
		local targetVelocity = (
			Camera.CFrame.RightVector * moveVector.X + 
			Camera.CFrame.UpVector * moveVector.Y + 
			Camera.CFrame.LookVector * moveVector.Z
		) * moveSpeed
		
		currentMoveVelocity = currentMoveVelocity:Lerp(targetVelocity, moveSmoothAlpha)
		local newPosition = Camera.CFrame.Position + (currentMoveVelocity * deltaTime)
		Camera.CFrame = CFrame.lookAt(newPosition, focusPoint)

	else
		-- ===============================
		-- == MODE NORMAL (LOCK MATI) ==
		-- ===============================

		displayYaw = lerp(displayYaw, targetYaw, lookSmoothAlpha)
		displayPitch = lerp(displayPitch, targetPitch, lookSmoothAlpha)
		local yawCFrame = CFrame.Angles(0, math.rad(displayYaw), 0)
		local pitchCFrame = CFrame.Angles(math.rad(displayPitch), 0, 0)
		local newRotation = yawCFrame * pitchCFrame 
		
		local targetVelocity = (
			newRotation.RightVector * moveVector.X + 
			newRotation.UpVector * moveVector.Y + 
			newRotation.LookVector * moveVector.Z
		) * moveSpeed
		
		currentMoveVelocity = currentMoveVelocity:Lerp(targetVelocity, moveSmoothAlpha)
		local newPosition = Camera.CFrame.Position + (currentMoveVelocity * deltaTime)
		Camera.CFrame = newRotation + newPosition
	end
	
	-- ==========================================
	-- == LOGIKA ZOOM DIPINDAH KE SINI ==
	-- ==========================================
	-- 7. HITUNG ZOOM (DARI TOMBOL PRESS-AND-HOLD)
	local zoomDirection = zoomInputs.Out - zoomInputs.In
	if zoomDirection ~= 0 then
		targetFov = targetFov + (zoomDirection * zoomSpeed * deltaTime)
		-- targetFov = math.clamp(targetFov, minFov, maxFov) -- <<-- DIHAPUS
		
		-- Jika pakai tombol, kita 'kunci' fov start pinch
		fovAtPinchStart = targetFov 
	end

	-- 8. LERP ZOOM (SELALU JALAN)
	Camera.FieldOfView = lerp(Camera.FieldOfView, targetFov, moveSmoothAlpha)
	-- ==========================================
end

-- (Fungsi toggleFocusLock TIDAK BERUBAH)
local function toggleFocusLock(tapPosition)
	isFocusLocked = not isFocusLocked
	
	if isFocusLocked then
		lockIndicator.Visible = true
		
		local screenRay = Camera:ViewportPointToRay(tapPosition.X, tapPosition.Y)
		local raycastOrigin = screenRay.Origin
		local raycastDirection = screenRay.Direction * raycastDistance
		
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
		raycastParams.FilterDescendantsInstances = {localPlayer.Character}
		
		local result = workspace:Raycast(raycastOrigin, raycastDirection, raycastParams)
		
		if result then
			focusPoint = result.Position
		else
			focusPoint = raycastOrigin + raycastDirection
		end
		
		local lookVector = (focusPoint - Camera.CFrame.Position).Unit
		if math.abs(lookVector.Y) > 0.99 then
			lookVector = (focusPoint - (Camera.CFrame.Position + Vector3.new(0, 0.01, 0))).Unit
		end
		
		local cframeLook = CFrame.lookAt(Vector3.new(), lookVector)
		local _, yaw, pitch = cframeLook:ToEulerAnglesYXZ()
		
		targetYaw = math.deg(yaw)
		targetPitch = math.deg(pitch)
		displayYaw = targetYaw
		displayPitch = targetPitch
		
	else
		lockIndicator.Visible = false
		focusPoint = nil
		
		local _, yaw, pitch = (Camera.CFrame - Camera.CFrame.Position):ToEulerAnglesYXZ()
		targetYaw = math.deg(yaw)
		targetPitch = math.deg(pitch)
		displayYaw = targetYaw
		displayPitch = targetPitch
	end
end

-- (Fungsi setFreecamActive TIDAK BERUBAH)
local function setFreecamActive(aktif)
	isFreecamActive = aktif
	
	if isFreecamActive then
		controls:Disable()
		originalCameraType = Camera.CameraType
		originalCameraFocus = Camera.Focus
		Camera.CameraType = Enum.CameraType.Scriptable
		
		local _, yaw, pitch = (Camera.CFrame - Camera.CFrame.Position):ToEulerAnglesYXZ()
		targetYaw = math.deg(yaw)
		targetPitch = math.deg(pitch)
		displayYaw = targetYaw
		displayPitch = targetPitch
		
		currentMoveVelocity = Vector3.new(0, 0, 0)
		targetFov = Camera.FieldOfView
		fovAtPinchStart = Camera.FieldOfView
		
		toggleButton.Text = "Freecam: ON"
		controlsFrame.Visible = true
		
		renderSteppedConnection = RunService.RenderStepped:Connect(onRenderStepped)
		
	else
		controls:Enable()
		Camera.CameraType = originalCameraType
		Camera.Focus = originalCameraFocus
		
		if renderSteppedConnection then
			renderSteppedConnection:Disconnect()
			renderSteppedConnection = nil
		end
		
		toggleButton.Text = "Freecam: OFF"
		controlsFrame.Visible = false
		
		isFocusLocked = false
		lockIndicator.Visible = false
		focusPoint = nil
		
		moveInputs = { F = 0, B = 0, L = 0, R = 0, U = 0, D = 0 }
		zoomInputs = { In = 0, Out = 0 }
		activeLookTouch = nil
		lastLookPosition = nil
	end
end

-- =================================================================
-- 3. INPUT HANDLERS 
-- (Tombol zoom sudah 'press-and-hold')
-- =================================================================

toggleButton.MouseButton1Click:Connect(function()
	setFreecamActive(not isFreecamActive)
end)

btnSpeedUp.MouseButton1Click:Connect(function()
	moveSpeed = math.min(moveSpeed + speedChangeAmount, maxSpeed)
	speedLabel.Text = "Speed: " .. math.floor(moveSpeed)
end)

btnSpeedDown.MouseButton1Click:Connect(function()
	moveSpeed = math.max(moveSpeed - speedChangeAmount, minSpeed)
	speedLabel.Text = "Speed: " .. math.floor(moveSpeed)
end)

-- Fungsi helper baru untuk tombol zoom
local function connectZoomButton(button, zoomKey)
	button.InputBegan:Connect(function()
		if isFreecamActive then zoomInputs[zoomKey] = 1 end
	end)
	button.InputEnded:Connect(function()
		zoomInputs[zoomKey] = 0
	end)
end

-- Hubungkan tombol zoom ke fungsi helper baru
connectZoomButton(btnZoomIn, "In")
connectZoomButton(btnZoomOut, "Out")

local function connectMoveButton(button, directionKey)
	button.InputBegan:Connect(function()
		if isFreecamActive then moveInputs[directionKey] = 1 end
	end)
	button.InputEnded:Connect(function()
		moveInputs[directionKey] = 0
	end)
end

connectMoveButton(btnForward, "F")
connectMoveButton(btnBack, "B")
connectMoveButton(btnLeft, "L")
connectMoveButton(btnRight, "R")
connectMoveButton(btnUp, "U")
connectMoveButton(btnDown, "D")

-- Handler untuk Touch Look (Geser Layar) & Pinch-to-Zoom
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if not isFreecamActive then return end
	
	if input.UserInputType == Enum.UserInputType.Touch and not gameProcessedEvent and not activeLookTouch then
		activeLookTouch = input
		lastLookPosition = input.Position
		isDragging = false 
	elseif input.UserInputType == Enum.UserInputType.Pinch then
		fovAtPinchStart = targetFov
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if not isFreecamActive then return end
	
	-- Handler untuk 'Look' (Geser 1 jari)
	if input.UserInputType == Enum.UserInputType.Touch and input == activeLookTouch then
		if (input.Position - lastLookPosition).Magnitude > 5 then
			isDragging = true
		end
		
		local delta = input.Position - lastLookPosition
		lastLookPosition = input.Position
		
		if isFocusLocked then
			local orbitSpeed = mouseSensitivity * 2 
			local currentCFrame = Camera.CFrame
			currentCFrame = CFrame.new(currentCFrame.Position + (currentCFrame.RightVector * -delta.X * orbitSpeed))
			currentCFrame = CFrame.new(currentCFrame.Position + (currentCFrame.UpVector * delta.Y * orbitSpeed))
			Camera.CFrame = CFrame.lookAt(currentCFrame.Position, focusPoint)
			
			currentMoveVelocity = Vector3.new(0,0,0)
			
			local lookVector = (focusPoint - Camera.CFrame.Position).Unit
			if math.abs(lookVector.Y) < 0.99 then 
				local cframeLook = CFrame.lookAt(Vector3.new(), lookVector)
				local _, yaw, pitch = cframeLook:ToEulerAnglesYXZ()
				targetYaw = math.deg(yaw)
				targetPitch = math.deg(pitch)
				displayYaw = targetYaw
				displayPitch = targetPitch
			end
			
		else
			targetYaw = targetYaw - (delta.X * mouseSensitivity)
			targetPitch = targetPitch - (delta.Y * mouseSensitivity)
			targetPitch = math.clamp(targetPitch, -89, 89)
		end
	
	-- Handler untuk 'Pinch' (Jepit 2 jari)
	elseif input.UserInputType == Enum.UserInputType.Pinch then
		isDragging = true 
		-- ==========================================
		-- == BATAS ZOOM DIHAPUS ==
		-- targetFov = math.clamp(fovAtPinchStart / input.Scale, minFov, maxFov) -- <<-- DIHAPUS
		targetFov = fovAtPinchStart / input.Scale -- <<-- JADI GINI
		-- ==========================================
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input == activeLookTouch then
		if not isDragging then
			toggleFocusLock(input.Position)
		end
		
		activeLookTouch = nil
		lastLookPosition = nil
		isDragging = false
		
	elseif input.UserInputType == Enum.UserInputType.Pinch then
		fovAtPinchStart = targetFov 
	end
end)

print("Script Freecam Mobile (VERSI UNLIMITED ZOOM) (by Syaa & Gemini) berhasil dimuat.")
