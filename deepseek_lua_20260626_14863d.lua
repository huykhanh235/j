--[[
    Script Hack Roblox - Muigl Pro Style (Fix toàn diện)
    - Menu rộng, chia tab ESP | AIMBOT | OTHER
    - ESP vẽ bằng Drawing: Box, Tracer (tia), Name, Máu, Distance
    - Aimbot có FOV circle, Silent Aim, Check team/visible
    - Key: khanhhuy | Kích hoạt: 3 ngón hoặc nút FAB
    - Hỗ trợ mọi game Roblox
    palofsc
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Workspace = game:GetService("Workspace")

-- Đảm bảo Player đã load
repeat wait() until LocalPlayer
repeat wait() until LocalPlayer:WaitForChild("PlayerGui")

-- ===== CẤU HÌNH TOÀN CỤC =====
local KEY = "khanhhuy"
local SETTINGS = {
    ESP = false,
    ESP_Box = true,
    ESP_Tracer = true,
    ESP_Name = true,
    ESP_Health = true,
    ESP_Distance = true,
    ESP_FillBox = false,       -- tô màu nền box
    Aimbot = false,
    SilentAim = true,
    AimPart = "Head",
    Smoothness = 0.15,
    FOV = 200,                -- bán kính FOV
    TeamCheck = false,
    VisibleCheck = true,
    Speed = false,
    Fly = false
}

-- ===== KEY SYSTEM =====
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "KeySystem"
KeyGui.ResetOnSpawn = false
KeyGui.Parent = LocalPlayer.PlayerGui

local KeyFrame = Instance.new("Frame", KeyGui)
KeyFrame.Size = UDim2.new(0,260,0,150)
KeyFrame.Position = UDim2.new(0.5,-130,0.5,-75)
KeyFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
KeyFrame.BorderSizePixel = 0
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0,12)

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1,0,0,30)
KeyTitle.BackgroundColor3 = Color3.fromRGB(30,30,30)
KeyTitle.Text = "🔐 NHẬP KEY"
KeyTitle.TextColor3 = Color3.fromRGB(255,200,0)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 16
Instance.new("UICorner", KeyTitle).CornerRadius = UDim.new(0,12)

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(1,-20,0,32)
KeyInput.Position = UDim2.new(0,10,0,45)
KeyInput.PlaceholderText = "Nhập key..."
KeyInput.Text = ""
KeyInput.BackgroundColor3 = Color3.fromRGB(40,40,40)
KeyInput.TextColor3 = Color3.fromRGB(255,255,255)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 14
KeyInput.BorderSizePixel = 0
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0,8)

local KeySubmit = Instance.new("TextButton", KeyFrame)
KeySubmit.Size = UDim2.new(0,90,0,30)
KeySubmit.Position = UDim2.new(0.5,-45,0,95)
KeySubmit.Text = "MỞ"
KeySubmit.BackgroundColor3 = Color3.fromRGB(0,180,0)
KeySubmit.TextColor3 = Color3.fromRGB(255,255,255)
KeySubmit.Font = Enum.Font.GothamBold
KeySubmit.TextSize = 14
KeySubmit.BorderSizePixel = 0
Instance.new("UICorner", KeySubmit).CornerRadius = UDim.new(0,8)

local KeyStatus = Instance.new("TextLabel", KeyFrame)
KeyStatus.Size = UDim2.new(1,0,0,20)
KeyStatus.Position = UDim2.new(0,0,0,130)
KeyStatus.BackgroundTransparency = 1
KeyStatus.Text = ""
KeyStatus.TextColor3 = Color3.fromRGB(255,80,80)
KeyStatus.Font = Enum.Font.Gotham
KeyStatus.TextSize = 12

KeySubmit.MouseButton1Click:Connect(function()
    if KeyInput.Text == KEY then
        KeyStatus.Text = "✅ Key đúng! Đang khởi tạo..."
        KeyStatus.TextColor3 = Color3.fromRGB(0,255,0)
        wait(0.5)
        KeyGui:Destroy()
        loadMain()
    else
        KeyStatus.Text = "❌ Sai key!"
        KeyStatus.TextColor3 = Color3.fromRGB(255,80,80)
        KeyInput.Text = ""
    end
end)

-- ===== MAIN MENU =====
function loadMain()
    local MainGui = Instance.new("ScreenGui")
    MainGui.Name = "MuiglPro"
    MainGui.ResetOnSpawn = false
    MainGui.Parent = LocalPlayer.PlayerGui

    -- Overlay
    local Overlay = Instance.new("TextButton", MainGui)
    Overlay.Size = UDim2.new(1,0,1,0)
    Overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
    Overlay.BackgroundTransparency = 0.5
    Overlay.Text = ""
    Overlay.ZIndex = 50
    Overlay.Visible = false

    -- FAB
    local Fab = Instance.new("TextButton", MainGui)
    Fab.Size = UDim2.new(0,56,0,56)
    Fab.Position = UDim2.new(1,-70,1,-70)
    Fab.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Fab.BackgroundTransparency = 0.3
    Fab.Text = "+"
    Fab.TextColor3 = Color3.fromRGB(255,255,255)
    Fab.Font = Enum.Font.GothamBlack
    Fab.TextSize = 28
    Fab.BorderSizePixel = 0
    Fab.ZIndex = 100
    Instance.new("UICorner", Fab).CornerRadius = UDim.new(1,0)
    local FabStroke = Instance.new("UIStroke", Fab)
    FabStroke.Color = Color3.fromRGB(255,255,255)
    FabStroke.Thickness = 2
    FabStroke.Transparency = 0.4

    -- Menu Panel (rộng 420, cao 380)
    local Menu = Instance.new("Frame", MainGui)
    Menu.Size = UDim2.new(0,420,0,380)
    Menu.Position = UDim2.new(0.5,-210,1,0)
    Menu.BackgroundColor3 = Color3.fromRGB(10,10,10)
    Menu.BackgroundTransparency = 0.05
    Menu.BorderSizePixel = 0
    Menu.ZIndex = 90
    Menu.Visible = false
    Instance.new("UICorner", Menu).CornerRadius = UDim.new(0,16)
    local MenuStroke = Instance.new("UIStroke", Menu)
    MenuStroke.Color = Color3.fromRGB(255,255,255)
    MenuStroke.Thickness = 1.2
    MenuStroke.Transparency = 0.6

    -- Tiêu đề
    local TitleBar = Instance.new("Frame", Menu)
    TitleBar.Size = UDim2.new(1,0,0,40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(20,20,20)
    TitleBar.BorderSizePixel = 0
    TitleBar.ZIndex = 100
    Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0,16)

    local TitleText = Instance.new("TextLabel", TitleBar)
    TitleText.Size = UDim2.new(1,-40,1,0)
    TitleText.Position = UDim2.new(0,15,0,0)
    TitleText.Text = "⚡ MUIGL PRO ⚡"
    TitleText.TextColor3 = Color3.fromRGB(0,255,255)
    TitleText.Font = Enum.Font.GothamBlack
    TitleText.TextSize = 18
    TitleText.BackgroundTransparency = 1
    TitleText.ZIndex = 101

    -- Nút đóng
    local CloseBtn = Instance.new("TextButton", TitleBar)
    CloseBtn.Size = UDim2.new(0,24,0,24)
    CloseBtn.Position = UDim2.new(1,-30,0,8)
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255,80,80)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
    CloseBtn.BackgroundTransparency = 0.8
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 14
    CloseBtn.BorderSizePixel = 0
    CloseBtn.ZIndex = 102
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0,12)

    -- Tab bar
    local TabFrame = Instance.new("Frame", Menu)
    TabFrame.Size = UDim2.new(1,-10,0,35)
    TabFrame.Position = UDim2.new(0,5,0,45)
    TabFrame.BackgroundTransparency = 1
    TabFrame.ZIndex = 90

    local selectedTab = "ESP"
    local tabButtons = {}

    local function selectTab(tab)
        selectedTab = tab
        for _, btn in ipairs(tabButtons) do
            btn.BackgroundColor3 = btn.Name == tab and Color3.fromRGB(0,140,255) or Color3.fromRGB(60,60,60)
        end
        -- Ẩn/hiện các content frame
        ESPContent.Visible = (tab == "ESP")
        AimbotContent.Visible = (tab == "Aimbot")
        OtherContent.Visible = (tab == "Other")
    end

    for i, tabName in ipairs({"ESP", "Aimbot", "Other"}) do
        local tabBtn = Instance.new("TextButton", TabFrame)
        tabBtn.Name = tabName
        tabBtn.Size = UDim2.new(0,100,1,0)
        tabBtn.Position = UDim2.new(0, (i-1)*110, 0,0)
        tabBtn.BackgroundColor3 = (tabName == "ESP") and Color3.fromRGB(0,140,255) or Color3.fromRGB(60,60,60)
        tabBtn.Text = tabName
        tabBtn.TextColor3 = Color3.fromRGB(255,255,255)
        tabBtn.Font = Enum.Font.GothamBold
        tabBtn.TextSize = 13
        tabBtn.BorderSizePixel = 0
        tabBtn.ZIndex = 91
        Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0,8)
        tabBtn.MouseButton1Click:Connect(function() selectTab(tabName) end)
        table.insert(tabButtons, tabBtn)
    end

    -- Content Frame cho từng tab
    local ESPContent = Instance.new("Frame", Menu)
    ESPContent.Size = UDim2.new(1,-20,1,-85)
    ESPContent.Position = UDim2.new(0,10,0,85)
    ESPContent.BackgroundTransparency = 1
    ESPContent.ZIndex = 89
    ESPContent.Visible = true

    local AimbotContent = Instance.new("Frame", Menu)
    AimbotContent.Size = UDim2.new(1,-20,1,-85)
    AimbotContent.Position = UDim2.new(0,10,0,85)
    AimbotContent.BackgroundTransparency = 1
    AimbotContent.ZIndex = 89
    AimbotContent.Visible = false

    local OtherContent = Instance.new("Frame", Menu)
    OtherContent.Size = UDim2.new(1,-20,1,-85)
    OtherContent.Position = UDim2.new(0,10,0,85)
    OtherContent.BackgroundTransparency = 1
    OtherContent.ZIndex = 89
    OtherContent.Visible = false

    -- Hàm tạo Toggle
    local function createToggle(parent, name, default, callback)
        local frame = Instance.new("Frame", parent)
        frame.Size = UDim2.new(1,0,0,32)
        frame.BackgroundTransparency = 1
        frame.ZIndex = 92

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(0.65,0,1,0)
        label.Text = name
        label.TextColor3 = Color3.fromRGB(220,220,220)
        label.Font = Enum.Font.Gotham
        label.TextSize = 12
        label.BackgroundTransparency = 1
        label.TextXAlignment = Enum.TextXAlignment.Left

        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(0,44,0,20)
        btn.Position = UDim2.new(0.75,0,0.5,-10)
        btn.BackgroundColor3 = default and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
        btn.Text = default and "ON" or "OFF"
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 10
        btn.BorderSizePixel = 0
        btn.ZIndex = 93
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,5)

        local state = default
        btn.MouseButton1Click:Connect(function()
            state = not state
            btn.BackgroundColor3 = state and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
            btn.Text = state and "ON" or "OFF"
            callback(state)
        end)
        return frame
    end

    -- Thêm widget vào content với tự động sắp xếp dọc
    local function addWidget(parent, widget)
        local y = 0
        for _, child in ipairs(parent:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextLabel") then
                y = y + child.Size.Y.Offset + 4
            end
        end
        widget.Position = UDim2.new(0,5,0,y)
        widget.Parent = parent
    end

    -- ESP tab
    addWidget(ESPContent, createToggle(ESPContent, "ESP", false, function(v) SETTINGS.ESP = v end))
    addWidget(ESPContent, createToggle(ESPContent, "Box", true, function(v) SETTINGS.ESP_Box = v end))
    addWidget(ESPContent, createToggle(ESPContent, "Fill Box", false, function(v) SETTINGS.ESP_FillBox = v end))
    addWidget(ESPContent, createToggle(ESPContent, "Tracer (Tia)", true, function(v) SETTINGS.ESP_Tracer = v end))
    addWidget(ESPContent, createToggle(ESPContent, "Tên", true, function(v) SETTINGS.ESP_Name = v end))
    addWidget(ESPContent, createToggle(ESPContent, "Máu", true, function(v) SETTINGS.ESP_Health = v end))
    addWidget(ESPContent, createToggle(ESPContent, "Khoảng cách", true, function(v) SETTINGS.ESP_Distance = v end))

    -- Aimbot tab
    addWidget(AimbotContent, createToggle(AimbotContent, "Aimbot", false, function(v) SETTINGS.Aimbot = v end))
    addWidget(AimbotContent, createToggle(AimbotContent, "Silent Aim", true, function(v) SETTINGS.SilentAim = v end))
    addWidget(AimbotContent, createToggle(AimbotContent, "Check Team", false, function(v) SETTINGS.TeamCheck = v end))
    addWidget(AimbotContent, createToggle(AimbotContent, "Visible Check", true, function(v) SETTINGS.VisibleCheck = v end))

    -- FOV slider
    local fovFrame = Instance.new("Frame")
    fovFrame.Size = UDim2.new(1,0,0,40)
    fovFrame.BackgroundTransparency = 1
    fovFrame.ZIndex = 92
    local fovLabel = Instance.new("TextLabel", fovFrame)
    fovLabel.Size = UDim2.new(1,0,0,18)
    fovLabel.Text = "FOV: 200"
    fovLabel.TextColor3 = Color3.fromRGB(255,255,255)
    fovLabel.Font = Enum.Font.Gotham
    fovLabel.TextSize = 12
    fovLabel.BackgroundTransparency = 1
    local fovInput = Instance.new("TextBox", fovFrame)
    fovInput.Size = UDim2.new(1,0,0,20)
    fovInput.Position = UDim2.new(0,0,0,20)
    fovInput.Text = "200"
    fovInput.BackgroundColor3 = Color3.fromRGB(40,40,40)
    fovInput.TextColor3 = Color3.fromRGB(255,255,255)
    fovInput.Font = Enum.Font.Gotham
    fovInput.TextSize = 12
    fovInput.BorderSizePixel = 0
    Instance.new("UICorner", fovInput).CornerRadius = UDim.new(0,4)
    fovInput.FocusLost:Connect(function()
        local num = tonumber(fovInput.Text)
        if num then
            num = math.clamp(num, 50, 500)
            SETTINGS.FOV = num
            fovLabel.Text = "FOV: "..num
        else
            fovInput.Text = tostring(SETTINGS.FOV)
        end
    end)
    addWidget(AimbotContent, fovFrame)

    -- Smoothness slider
    local smoothFrame = Instance.new("Frame")
    smoothFrame.Size = UDim2.new(1,0,0,40)
    smoothFrame.BackgroundTransparency = 1
    smoothFrame.ZIndex = 92
    local smoothLabel = Instance.new("TextLabel", smoothFrame)
    smoothLabel.Size = UDim2.new(1,0,0,18)
    smoothLabel.Text = "Độ mượt: 0.15"
    smoothLabel.TextColor3 = Color3.fromRGB(255,255,255)
    smoothLabel.Font = Enum.Font.Gotham
    smoothLabel.TextSize = 12
    smoothLabel.BackgroundTransparency = 1
    local smoothInput = Instance.new("TextBox", smoothFrame)
    smoothInput.Size = UDim2.new(1,0,0,20)
    smoothInput.Position = UDim2.new(0,0,0,20)
    smoothInput.Text = "0.15"
    smoothInput.BackgroundColor3 = Color3.fromRGB(40,40,40)
    smoothInput.TextColor3 = Color3.fromRGB(255,255,255)
    smoothInput.Font = Enum.Font.Gotham
    smoothInput.TextSize = 12
    smoothInput.BorderSizePixel = 0
    Instance.new("UICorner", smoothInput).CornerRadius = UDim.new(0,4)
    smoothInput.FocusLost:Connect(function()
        local num = tonumber(smoothInput.Text)
        if num then
            num = math.clamp(num, 0, 1)
            SETTINGS.Smoothness = num
            smoothLabel.Text = "Độ mượt: "..string.format("%.2f", num)
        else
            smoothInput.Text = tostring(SETTINGS.Smoothness)
        end
    end)
    addWidget(AimbotContent, smoothFrame)

    -- AimPart button
    local partBtn = Instance.new("TextButton")
    partBtn.Size = UDim2.new(1,0,0,28)
    partBtn.Text = "Bộ phận: Head"
    partBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    partBtn.TextColor3 = Color3.fromRGB(255,255,255)
    partBtn.Font = Enum.Font.GothamBold
    partBtn.TextSize = 12
    partBtn.BorderSizePixel = 0
    Instance.new("UICorner", partBtn).CornerRadius = UDim.new(0,6)
    local parts = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso"}
    local partIdx = 1
    partBtn.MouseButton1Click:Connect(function()
        partIdx = (partIdx % #parts) + 1
        SETTINGS.AimPart = parts[partIdx]
        partBtn.Text = "Bộ phận: "..parts[partIdx]
    end)
    addWidget(AimbotContent, partBtn)

    -- Other tab: Speed, Fly
    addWidget(OtherContent, createToggle(OtherContent, "Speed Hack", false, function(v) SETTINGS.Speed = v end))
    addWidget(OtherContent, createToggle(OtherContent, "Fly", false, function(v) SETTINGS.Fly = v end))

    -- Điều khiển đóng/mở menu với animation trượt lên
    local menuOpen = false
    local isAnimating = false
    local function toggleMenu()
        if isAnimating then return end
        isAnimating = true
        menuOpen = not menuOpen
        if menuOpen then
            Overlay.Visible = true
            Menu.Visible = true
            Fab.Visible = false
            Menu.Position = UDim2.new(0.5,-210,1,0)
            Menu:TweenPosition(UDim2.new(0.5,-210,0.5,-190), "Out", "Back", 0.4, true, function() isAnimating = false end)
        else
            Fab.Visible = true
            Menu:TweenPosition(UDim2.new(0.5,-210,1,0), "In", "Quad", 0.3, true, function()
                Menu.Visible = false
                Overlay.Visible = false
                isAnimating = false
            end)
        end
    end

    Fab.MouseButton1Click:Connect(toggleMenu)
    CloseBtn.MouseButton1Click:Connect(toggleMenu)
    Overlay.MouseButton1Click:Connect(toggleMenu)

    -- Chạm 3 ngón
    local touchCount = 0
    local touches = {}
    UserInputService.TouchStarted:Connect(function(touch, processed)
        if processed then return end
        touches[touch] = true
        touchCount = touchCount + 1
        if touchCount == 3 then toggleMenu() end
    end)
    UserInputService.TouchEnded:Connect(function(touch, processed)
        if processed then return end
        if touches[touch] then
            touches[touch] = nil
            touchCount = math.max(0, touchCount - 1)
        end
    end)

    -- ===== ESP VẼ BẰNG DRAWING =====
    local drawings = {}

    local function clearDrawings()
        for _, d in pairs(drawings) do
            if type(d) == "table" then
                for _, v in pairs(d) do v:Remove() end
            else
                d:Remove()
            end
        end
        drawings = {}
    end

    local function updateESP()
        clearDrawings()
        if not SETTINGS.ESP then return end

        for _, player in ipairs(Players:GetPlayers()) do
            if player == LocalPlayer then continue end
            local char = player.Character
            if not char then continue end
            local head = char:FindFirstChild("Head")
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not head or not root or not hum or hum.Health <= 0 then continue end

            local headPos, headVisible = Camera:WorldToViewportPoint(head.Position)
            local rootPos, rootVisible = Camera:WorldToViewportPoint(root.Position)
            if not headVisible or not rootVisible then continue end

            local boxHeight = math.abs(headPos.Y - rootPos.Y)
            local boxWidth = boxHeight * 0.55
            local boxX = headPos.X - boxWidth/2
            local boxY = headPos.Y
            local dist = (LocalPlayer.Character and LocalPlayer.Character.PrimaryPart) and (LocalPlayer.Character.PrimaryPart.Position - root.Position).Magnitude or 0
            local hpPct = hum.Health / hum.MaxHealth

            -- Box
            if SETTINGS.ESP_Box then
                local outline = Drawing.new("Square")
                outline.Visible = true; outline.Position = Vector2.new(boxX, boxY); outline.Size = Vector2.new(boxWidth, boxHeight)
                outline.Thickness = 1.5; outline.Color = Color3.fromRGB(0,255,255); outline.Filled = false
                table.insert(drawings, outline)

                if SETTINGS.ESP_FillBox then
                    local fill = Drawing.new("Square")
                    fill.Visible = true; fill.Position = Vector2.new(boxX, boxY); fill.Size = Vector2.new(boxWidth, boxHeight)
                    fill.Thickness = 1; fill.Color = Color3.fromRGB(0,255,255); fill.Filled = true; fill.Transparency = 0.8
                    table.insert(drawings, fill)
                end
            end

            -- Tracer
            if SETTINGS.ESP_Tracer then
                local tracer = Drawing.new("Line")
                tracer.Visible = true
                tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                tracer.To = Vector2.new(headPos.X, rootPos.Y)
                tracer.Thickness = 1; tracer.Color = Color3.fromRGB(255,255,255); tracer.Transparency = 0.3
                table.insert(drawings, tracer)
            end

            -- Name
            if SETTINGS.ESP_Name then
                local name = Drawing.new("Text")
                name.Visible = true; name.Text = player.Name; name.Position = Vector2.new(headPos.X, boxY - 18)
                name.Size = 12; name.Color = Color3.fromRGB(255,255,255); name.Font = 2; name.Center = true; name.Outline = true
                table.insert(drawings, name)
            end

            -- Health bar
            if SETTINGS.ESP_Health then
                local barWidth = 3; local barHeight = boxHeight; local barX = boxX - barWidth - 2; local barY = boxY
                local bgBar = Drawing.new("Square")
                bgBar.Visible = true; bgBar.Position = Vector2.new(barX, barY); bgBar.Size = Vector2.new(barWidth, barHeight)
                bgBar.Color = Color3.fromRGB(20,20,20); bgBar.Filled = true
                table.insert(drawings, bgBar)
                local fillBar = Drawing.new("Square")
                fillBar.Visible = true
                fillBar.Position = Vector2.new(barX, barY + (1-hpPct)*barHeight)
                fillBar.Size = Vector2.new(barWidth, hpPct*barHeight)
                fillBar.Color = Color3.fromHSV(hpPct*0.3, 1, 1); fillBar.Filled = true
                table.insert(drawings, fillBar)
            end

            -- Distance
            if SETTINGS.ESP_Distance then
                local distText = Drawing.new("Text")
                distText.Visible = true; distText.Text = string.format("%.0fm", dist)
                distText.Position = Vector2.new(headPos.X, rootPos.Y + 8)
                distText.Size = 11; distText.Color = Color3.fromRGB(200,200,200); distText.Font = 2; distText.Center = true; distText.Outline = true
                table.insert(drawings, distText)
            end
        end
    end

    RunService.RenderStepped:Connect(updateESP)

    -- ===== AIMBOT =====
    local function drawFOV()
        if not SETTINGS.Aimbot then return end
        -- Vẽ vòng tròn FOV giả bằng hình ảnh hoặc bỏ qua (có thể dùng Circle nếu executor hỗ trợ)
        -- Nhiều executor không hỗ trợ Circle, nên ta dùng cách khác: vẽ 360 đường Line tạo thành vòng tròn.
        -- Tạm thời đơn giản là vẽ một vòng tròn bằng các điểm tính toán.
        -- Để tối ưu, ta sẽ vẽ một vòng tròn tâm màn hình, bán kính FOV (theo pixel màn hình). Tuy nhiên FOV ở đây là khoảng cách trong không gian viewport, nên ta sẽ dùng đơn vị pixel.
        -- Vòng tròn có tâm là giữa màn hình, bán kính = SETTINGS.FOV.
        -- Xóa circle cũ trước khi vẽ mới.
        if not _G.FovCircle then
            _G.FovCircle = {}
        end
        -- Xóa hết các line cũ
        for _, l in ipairs(_G.FovCircle) do l:Remove() end
        _G.FovCircle = {}
        local cx, cy = Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2
        local r = SETTINGS.FOV
        local segments = 64
        for i=0, segments-1 do
            local angle1 = (i/segments) * math.pi * 2
            local angle2 = ((i+1)/segments) * math.pi * 2
            local x1 = cx + math.cos(angle1)*r; local y1 = cy + math.sin(angle1)*r
            local x2 = cx + math.cos(angle2)*r; local y2 = cy + math.sin(angle2)*r
            local line = Drawing.new("Line")
            line.Visible = true
            line.From = Vector2.new(x1, y1)
            line.To = Vector2.new(x2, y2)
            line.Color = Color3.fromRGB(255,255,255)
            line.Thickness = 1
            line.Transparency = 0.5
            table.insert(_G.FovCircle, line)
        end
    end

    local function aimbot()
        if not SETTINGS.Aimbot then return end
        if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
            drawFOV() -- vẫn vẽ FOV khi không aim để hiển thị
            return
        end
        drawFOV()
        local closest, minDist = nil, SETTINGS.FOV
        for _, player in ipairs(Players:GetPlayers()) do
            if player == LocalPlayer then continue end
            if SETTINGS.TeamCheck and player.Team == LocalPlayer.Team then continue end
            local char = player.Character
            if not char then continue end
            local part = char:FindFirstChild(SETTINGS.AimPart)
            if not part then continue end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health <= 0 then continue end

            if SETTINGS.VisibleCheck then
                local rayParams = RaycastParams.new()
                rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
                rayParams.FilterType = Enum.RaycastFilterType.Blacklist
                local ray = Workspace:Raycast(Camera.CFrame.Position, (part.Position - Camera.CFrame.Position).Unit * 1000, rayParams)
                if ray and not ray.Instance:IsDescendantOf(char) then continue end
            end

            local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
            if not onScreen then continue end
            local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
            if dist < minDist then
                minDist = dist
                closest = part
            end
        end

        if closest then
            local targetPos = closest.Position
            local smooth = math.clamp(SETTINGS.Smoothness, 0.001, 1)
            if SETTINGS.SilentAim then
                local newLook = CFrame.new(Camera.CFrame.Position, targetPos).LookVector
                local curLook = Camera.CFrame.LookVector
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + curLook:Lerp(newLook, 1 - smooth))
            else
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPos)
            end
        end
    end

    RunService.RenderStepped:Connect(aimbot)

    -- ===== SPEED HACK =====
    spawn(function()
        while true do
            wait(0.3)
            if SETTINGS.Speed and LocalPlayer.Character then
                local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = 50 end
            end
        end
    end)

    -- ===== FLY =====
    spawn(function()
        local flyConnection = nil
        while true do
            wait(0.3)
            if SETTINGS.Fly then
                if not flyConnection then
                    local char = LocalPlayer.Character
                    if char then
                        local root = char:FindFirstChild("HumanoidRootPart")
                        if root then
                            local bg = Instance.new("BodyGyro", root)
                            bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
                            bg.D = 100; bg.P = 3000
                            local bv = Instance.new("BodyVelocity", root)
                            bv.MaxForce = Vector3.new(9e9,9e9,9e9)
                            bv.Velocity = Vector3.zero
                            flyConnection = {gyro = bg, vel = bv}
                            flyConnection.heart = RunService.Heartbeat:Connect(function()
                                if not SETTINGS.Fly or not root then return end
                                local dir = Vector3.zero
                                if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += Camera.CFrame.LookVector * 30 end
                                if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= Camera.CFrame.LookVector * 30 end
                                if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= Camera.CFrame.RightVector * 30 end
                                if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += Camera.CFrame.RightVector * 30 end
                                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,30,0) end
                                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0,30,0) end
                                bg.CFrame = Camera.CFrame
                                bv.Velocity = dir
                            end)
                        end
                    end
                end
            else
                if flyConnection then
                    flyConnection.heart:Disconnect()
                    flyConnection.gyro:Destroy()
                    flyConnection.vel:Destroy()
                    flyConnection = nil
                end
            end
        end
    end)

    print("Muigl Pro ready: Chạm 3 ngón hoặc nhấn FAB để mở menu.")
end

print("Script Muigl Pro đã load. Nhập key để sử dụng.")