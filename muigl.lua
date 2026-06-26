--[[
    Script Hack Roblox - Menu 3 Ngón Tay
    Yêu cầu key: "khanhhuy"
    Tính năng: ESP (box siêu đẹp, line, name, máu), Aimbot Silent 100% đầu,
    giao diện bo góc mịn, chạm 3 ngón để mở/tắt menu, chạm ngoài menu ẩn.
    Hỗ trợ mọi game.
    palofsc
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ===== CÀI ĐẶT HACK =====
local Hack = {
    ESP = false,
    ESPBox = true,
    ESPLine = true,
    ESPName = true,
    ESPHealth = true,
    ESPCount = 0,           -- sẽ cập nhật
    Aimbot = false,
    SilentAim = true,       -- mặc định bật silent aim
    AimPart = "Head",
    Smoothness = 0.2,
    FOV = 300,
    TeamCheck = false,
    VisibleCheck = true
}

-- ===== HỆ THỐNG KEY =====
local KeyScreen = Instance.new("ScreenGui")
KeyScreen.Name = "KeyGUI"
KeyScreen.ResetOnSpawn = false
KeyScreen.Parent = LocalPlayer:WaitForChild("PlayerGui")

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0,300,0,180)
KeyFrame.Position = UDim2.new(0.5,-150,0.5,-90)
KeyFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
KeyFrame.BorderSizePixel = 0
local KeyCorner = Instance.new("UICorner", KeyFrame)
KeyCorner.CornerRadius = UDim.new(0,12)

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1,0,0,35)
KeyTitle.BackgroundColor3 = Color3.fromRGB(30,30,30)
KeyTitle.Text = "🔐 NHẬP KEY"
KeyTitle.TextColor3 = Color3.fromRGB(255,215,0)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 18
local KeyTitleCorner = Instance.new("UICorner", KeyTitle)
KeyTitleCorner.CornerRadius = UDim.new(0,12)

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(1,-30,0,35)
KeyInput.Position = UDim2.new(0,15,0,60)
KeyInput.PlaceholderText = "Nhập key..."
KeyInput.Text = ""
KeyInput.BackgroundColor3 = Color3.fromRGB(40,40,40)
KeyInput.TextColor3 = Color3.fromRGB(255,255,255)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 16
KeyInput.BorderSizePixel = 0
local KeyInputCorner = Instance.new("UICorner", KeyInput)
KeyInputCorner.CornerRadius = UDim.new(0,8)

local KeySubmit = Instance.new("TextButton", KeyFrame)
KeySubmit.Size = UDim2.new(0,100,0,35)
KeySubmit.Position = UDim2.new(0.5,-50,0,115)
KeySubmit.Text = "XÁC NHẬN"
KeySubmit.BackgroundColor3 = Color3.fromRGB(0,170,0)
KeySubmit.TextColor3 = Color3.fromRGB(255,255,255)
KeySubmit.Font = Enum.Font.GothamBold
KeySubmit.TextSize = 14
KeySubmit.BorderSizePixel = 0
local KeySubmitCorner = Instance.new("UICorner", KeySubmit)
KeySubmitCorner.CornerRadius = UDim.new(0,8)

local KeyStatus = Instance.new("TextLabel", KeyFrame)
KeyStatus.Size = UDim2.new(1,0,0,25)
KeyStatus.Position = UDim2.new(0,0,0,160)
KeyStatus.BackgroundTransparency = 1
KeyStatus.Text = ""
KeyStatus.TextColor3 = Color3.fromRGB(255,80,80)
KeyStatus.Font = Enum.Font.Gotham
KeyStatus.TextSize = 13

KeySubmit.MouseButton1Click:Connect(function()
    if KeyInput.Text == "khanhhuy" then
        KeyStatus.Text = "✅ Key đúng! Đang mở menu..."
        KeyStatus.TextColor3 = Color3.fromRGB(0,255,0)
        wait(0.8)
        KeyScreen:Destroy()
        -- Khởi tạo menu chính sau khi key đúng
        spawn(function() InitMainMenu() end)
    else
        KeyStatus.Text = "❌ Sai key! Vui lòng thử lại."
        KeyStatus.TextColor3 = Color3.fromRGB(255,80,80)
        KeyInput.Text = ""
    end
end)

-- ===== MENU CHÍNH =====
local MainGui = nil
local MainFrame = nil
local ESPCountLabel = nil

function InitMainMenu()
    MainGui = Instance.new("ScreenGui")
    MainGui.Name = "HackMenu"
    MainGui.ResetOnSpawn = false
    MainGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    -- Nền tối toàn màn hình để chạm ngoài ẩn menu
    local BackgroundOverlay = Instance.new("TextButton")
    BackgroundOverlay.Size = UDim2.new(1,0,1,0)
    BackgroundOverlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
    BackgroundOverlay.BackgroundTransparency = 0.5
    BackgroundOverlay.Text = ""
    BackgroundOverlay.ZIndex = 50
    BackgroundOverlay.Visible = false
    BackgroundOverlay.Parent = MainGui

    MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0,300,0,450)
    MainFrame.Position = UDim2.new(0.5,-150,0.5,-225)
    MainFrame.BackgroundColor3 = Color3.fromRGB(10,10,10)
    MainFrame.BorderSizePixel = 0
    MainFrame.ZIndex = 100
    MainFrame.Visible = false
    local MainCorner = Instance.new("UICorner", MainFrame)
    MainCorner.CornerRadius = UDim.new(0,14)

    -- Thanh tiêu đề menu
    local TitleBar = Instance.new("Frame", MainFrame)
    TitleBar.Size = UDim2.new(1,0,0,40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(25,25,25)
    TitleBar.BorderSizePixel = 0
    TitleBar.ZIndex = 101
    local TitleBarCorner = Instance.new("UICorner", TitleBar)
    TitleBarCorner.CornerRadius = UDim.new(0,14)

    local TitleLabel = Instance.new("TextLabel", TitleBar)
    TitleLabel.Size = UDim2.new(1,-40,1,0)
    TitleLabel.Position = UDim2.new(0,15,0,0)
    TitleLabel.Text = "⚡ HACK MENU ⚡"
    TitleLabel.TextColor3 = Color3.fromRGB(0,255,255)
    TitleLabel.Font = Enum.Font.GothamBlack
    TitleLabel.TextSize = 18
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.ZIndex = 102

    -- Nhãn số lượng players
    ESPCountLabel = Instance.new("TextLabel", TitleBar)
    ESPCountLabel.Size = UDim2.new(0,100,1,0)
    ESPCountLabel.Position = UDim2.new(1,-140,0,0)
    ESPCountLabel.Text = "Players: 0"
    ESPCountLabel.TextColor3 = Color3.fromRGB(255,200,0)
    ESPCountLabel.Font = Enum.Font.GothamBold
    ESPCountLabel.TextSize = 13
    ESPCountLabel.BackgroundTransparency = 1
    ESPCountLabel.ZIndex = 102

    -- Nút đóng
    local CloseBtn = Instance.new("TextButton", TitleBar)
    CloseBtn.Size = UDim2.new(0,26,0,26)
    CloseBtn.Position = UDim2.new(1,-32,0,7)
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255,80,80)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 14
    CloseBtn.BorderSizePixel = 0
    CloseBtn.ZIndex = 103
    local CloseCorner = Instance.new("UICorner", CloseBtn)
    CloseCorner.CornerRadius = UDim.new(0,6)

    -- Vùng nội dung cuộn
    local ScrollingFrame = Instance.new("ScrollingFrame", MainFrame)
    ScrollingFrame.Size = UDim2.new(1,-10,1,-50)
    ScrollingFrame.Position = UDim2.new(0,5,0,45)
    ScrollingFrame.BackgroundColor3 = Color3.fromRGB(18,18,18)
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.CanvasSize = UDim2.new(0,0,0,600)
    ScrollingFrame.ScrollBarThickness = 3
    ScrollingFrame.ZIndex = 101

    local Content = Instance.new("Frame", ScrollingFrame)
    Content.Size = UDim2.new(1,0,0,600)
    Content.BackgroundTransparency = 1
    Content.ZIndex = 102

    -- Hàm tạo toggle
    local function ToggleButton(name, default, callback)
        local frame = Instance.new("Frame", Content)
        frame.Size = UDim2.new(1,-10,0,40)
        frame.BackgroundTransparency = 1
        frame.ZIndex = 103

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(0.6,0,1,0)
        label.Text = name
        label.TextColor3 = Color3.fromRGB(220,220,220)
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.BackgroundTransparency = 1
        label.TextXAlignment = Enum.TextXAlignment.Left

        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(0,46,0,24)
        btn.Position = UDim2.new(0.75,0,0.5,-12)
        btn.BackgroundColor3 = default and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
        btn.Text = default and "ON" or "OFF"
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        btn.BorderSizePixel = 0
        local btnCorner = Instance.new("UICorner", btn)
        btnCorner.CornerRadius = UDim.new(0,6)

        local toggled = default
        btn.MouseButton1Click:Connect(function()
            toggled = not toggled
            btn.BackgroundColor3 = toggled and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
            btn.Text = toggled and "ON" or "OFF"
            callback(toggled)
        end)
        return frame
    end

    local y = 0
    local function add(widget)
        widget.Position = UDim2.new(0.05,0,0,y)
        widget.Parent = Content
        y = y + widget.Size.Y.Offset + 8
    end

    add(ToggleButton("ESP", false, function(v) Hack.ESP = v end))
    add(ToggleButton("ESP Box", true, function(v) Hack.ESPBox = v end))
    add(ToggleButton("ESP Line", true, function(v) Hack.ESPLine = v end))
    add(ToggleButton("ESP Name", true, function(v) Hack.ESPName = v end))
    add(ToggleButton("ESP Máu", true, function(v) Hack.ESPHealth = v end))
    add(ToggleButton("Aimbot", false, function(v) Hack.Aimbot = v end))
    add(ToggleButton("Silent Aim", true, function(v) Hack.SilentAim = v end))
    add(ToggleButton("Check Team", false, function(v) Hack.TeamCheck = v end))
    add(ToggleButton("Check Visible", true, function(v) Hack.VisibleCheck = v end))

    -- Nhập độ mượt
    local smoothFrame = Instance.new("Frame", Content)
    smoothFrame.Size = UDim2.new(1,-10,0,40)
    smoothFrame.BackgroundTransparency = 1
    smoothFrame.Position = UDim2.new(0.05,0,0,y)
    y = y + 48

    local smoothLabel = Instance.new("TextLabel", smoothFrame)
    smoothLabel.Size = UDim2.new(0.4,0,0,20)
    smoothLabel.Text = "Độ mượt: 0.2"
    smoothLabel.TextColor3 = Color3.fromRGB(220,220,220)
    smoothLabel.Font = Enum.Font.Gotham
    smoothLabel.TextSize = 13
    smoothLabel.BackgroundTransparency = 1
    smoothLabel.TextXAlignment = Enum.TextXAlignment.Left

    local smoothInput = Instance.new("TextBox", smoothFrame)
    smoothInput.Size = UDim2.new(0.5,0,0,22)
    smoothInput.Position = UDim2.new(0.4,0,0,20)
    smoothInput.Text = "0.2"
    smoothInput.BackgroundColor3 = Color3.fromRGB(45,45,45)
    smoothInput.TextColor3 = Color3.fromRGB(255,255,255)
    smoothInput.Font = Enum.Font.Gotham
    smoothInput.TextSize = 12
    smoothInput.BorderSizePixel = 0
    local smoothCorner = Instance.new("UICorner", smoothInput)
    smoothCorner.CornerRadius = UDim.new(0,4)
    smoothInput.FocusLost:Connect(function(enterPressed)
        local num = tonumber(smoothInput.Text)
        if num then
            num = math.clamp(num, 0, 1)
            Hack.Smoothness = num
            smoothLabel.Text = "Độ mượt: "..string.format("%.2f", num)
        else
            smoothInput.Text = tostring(Hack.Smoothness)
        end
    end)

    Content.Size = UDim2.new(1,0,0,y+20)
    ScrollingFrame.CanvasSize = UDim2.new(0,0,0,y+20)

    -- Sự kiện mở/đóng menu
    local menuVisible = false
    function ToggleMenu()
        menuVisible = not menuVisible
        if menuVisible then
            MainFrame.Visible = true
            BackgroundOverlay.Visible = true
            MainFrame:TweenPosition(UDim2.new(0.5,-150,0.5,-225), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.35, true)
        else
            MainFrame:TweenPosition(UDim2.new(0.5,-150,0.5,-225), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true, function()
                MainFrame.Visible = false
                BackgroundOverlay.Visible = false
            end)
        end
    end

    CloseBtn.MouseButton1Click:Connect(ToggleMenu)
    BackgroundOverlay.MouseButton1Click:Connect(ToggleMenu)

    -- Kích hoạt 3 ngón
    local touchCount = 0
    local touches = {}
    UserInputService.TouchStarted:Connect(function(touch, processed)
        if processed then return end
        touches[touch] = true
        touchCount = touchCount + 1
        if touchCount == 3 then
            ToggleMenu()
        end
    end)
    UserInputService.TouchEnded:Connect(function(touch, processed)
        if processed then return end
        if touches[touch] then
            touches[touch] = nil
            touchCount = math.max(0, touchCount - 1)
        end
    end)
end

-- ===== ESP THỰC THI =====
local ESP_Objects = {}
local function CreateESP()
    if not Hack.ESP then
        for _, obj in pairs(ESP_Objects) do
            if type(obj) == "table" then
                for _, v in pairs(obj) do v:Remove() end
            else
                obj:Remove()
            end
        end
        ESP_Objects = {}
        if ESPCountLabel then
            ESPCountLabel.Text = "Players: 0"
        end
        return
    end

    -- Xóa cũ
    for _, obj in pairs(ESP_Objects) do
        if type(obj) == "table" then
            for _, v in pairs(obj) do v:Remove() end
        else
            obj:Remove()
        end
    end
    ESP_Objects = {}

    local playerCount = 0
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local char = player.Character
        if not char then continue end
        local head = char:FindFirstChild("Head")
        local root = char:FindFirstChild("HumanoidRootPart")
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not head or not root or not humanoid then continue end

        local headPos, headOnScreen = Camera:WorldToViewportPoint(head.Position)
        local rootPos, rootOnScreen = Camera:WorldToViewportPoint(root.Position)
        if not headOnScreen or not rootOnScreen then continue end

        playerCount = playerCount + 1
        local distance = (LocalPlayer.Character and LocalPlayer.Character.PrimaryPart and LocalPlayer.Character.PrimaryPart.Position) and (LocalPlayer.Character.PrimaryPart.Position - root.Position).Magnitude or 0
        local healthPercent = humanoid.Health / humanoid.MaxHealth

        local boxHeight = math.abs(headPos.Y - rootPos.Y)
        local boxWidth = boxHeight * 0.55
        local boxX = headPos.X - boxWidth/2
        local boxY = headPos.Y

        -- Box siêu đẹp (viền ngoài + nền mờ)
        if Hack.ESPBox then
            local boxOutline = Drawing.new("Square")
            boxOutline.Position = Vector2.new(boxX, boxY)
            boxOutline.Size = Vector2.new(boxWidth, boxHeight)
            boxOutline.Thickness = 3
            boxOutline.Color = Color3.fromRGB(0,255,255)
            boxOutline.Filled = false
            boxOutline.Visible = true
            table.insert(ESP_Objects, boxOutline)

            local boxFill = Drawing.new("Square")
            boxFill.Position = Vector2.new(boxX, boxY)
            boxFill.Size = Vector2.new(boxWidth, boxHeight)
            boxFill.Thickness = 1
            boxFill.Color = Color3.fromRGB(0,255,255)
            boxFill.Filled = true
            boxFill.Transparency = 0.85
            boxFill.Visible = true
            table.insert(ESP_Objects, boxFill)
        end

        -- Line
        if Hack.ESPLine then
            local line = Drawing.new("Line")
            line.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
            line.To = Vector2.new(headPos.X, rootPos.Y)
            line.Thickness = 2
            line.Color = Color3.fromRGB(255,255,255)
            line.Visible = true
            table.insert(ESP_Objects, line)
        end

        -- Name
        if Hack.ESPName then
            local nameText = Drawing.new("Text")
            nameText.Text = player.Name
            nameText.Position = Vector2.new(headPos.X, boxY - 20)
            nameText.Size = 14
            nameText.Font = 2 -- Drawing.Fonts.Monospace
            nameText.Color = Color3.fromRGB(255,255,255)
            nameText.Center = true
            nameText.Outline = true
            nameText.Visible = true
            table.insert(ESP_Objects, nameText)
        end

        -- Máu (thanh bar)
        if Hack.ESPHealth then
            local barWidth = 3
            local barHeight = boxHeight
            local barX = boxX - barWidth - 3
            local barY = boxY

            local barBg = Drawing.new("Square")
            barBg.Position = Vector2.new(barX, barY)
            barBg.Size = Vector2.new(barWidth, barHeight)
            barBg.Color = Color3.fromRGB(30,30,30)
            barBg.Filled = true
            barBg.Visible = true
            table.insert(ESP_Objects, barBg)

            local barFill = Drawing.new("Square")
            barFill.Position = Vector2.new(barX, barY + (1-healthPercent)*barHeight)
            barFill.Size = Vector2.new(barWidth, healthPercent * barHeight)
            barFill.Color = Color3.fromHSV(healthPercent * 0.3, 1, 1) -- xanh -> đỏ
            barFill.Filled = true
            barFill.Visible = true
            table.insert(ESP_Objects, barFill)
        end
    end
    if ESPCountLabel then
        ESPCountLabel.Text = "Players: "..playerCount
    end
end

-- ===== AIMBOT (Silent + 100% đầu) =====
local function AimbotFunction()
    if not Hack.Aimbot then return end
    local closestPart = nil
    local closestDist = Hack.FOV

    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if Hack.TeamCheck and player.Team == LocalPlayer.Team then continue end
        local char = player.Character
        if not char then continue end
        local part = char:FindFirstChild(Hack.AimPart)
        if not part then continue end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Health <= 0 then continue end

        if Hack.VisibleCheck then
            local rayParams = RaycastParams.new()
            rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
            rayParams.FilterType = Enum.RaycastFilterType.Blacklist
            local ray = workspace:Raycast(Camera.CFrame.Position, (part.Position - Camera.CFrame.Position).Unit * 1000, rayParams)
            if ray and not ray.Instance:IsDescendantOf(char) then
                continue
            end
        end

        local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
        if not onScreen then continue end
        local dist = (Vector2.new(screenPos.X, screenPos.Y) - Camera.ViewportSize/2).Magnitude
        if dist < closestDist then
            closestDist = dist
            closestPart = part
        end
    end

    if closestPart then
        local targetPos = closestPart.Position
        if Hack.SilentAim then
            -- Silent aim: thay đổi CFrame của Camera mượt mà (không giật)
            local smooth = math.clamp(Hack.Smoothness, 0.001, 1)
            local newLook = CFrame.new(Camera.CFrame.Position, targetPos).LookVector
            local currentLook = Camera.CFrame.LookVector
            local lerped = currentLook:Lerp(newLook, 1 - smooth)
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + lerped)
        else
            -- Lock cứng
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPos)
        end
    end
end

RunService.RenderStepped:Connect(function()
    CreateESP()
    if Hack.Aimbot and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        AimbotFunction()
    end
end)