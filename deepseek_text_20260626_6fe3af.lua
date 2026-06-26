--[[
    Script Hack Roblox - Muigl Final Fix (Hoạt động ổn định)
    Key: khanhhuy
    Mở menu: vuốt 3 ngón lên trên (swipe up) – không giữ, không vuốt ngang.
    Menu: giao diện rõ ràng, tab ngang, toggle và slider dễ nhìn.
    ESP: Box, Tracer, Tên, Máu, Khoảng cách (dùng ScreenGui).
    Aimbot: Silent Aim, FOV Circle, chỉ bắn kẻ địch.
    Speed Hack.
    palofsc
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Workspace = game:GetService("Workspace")

repeat wait() until LocalPlayer
repeat wait() until LocalPlayer:WaitForChild("PlayerGui")

local KEY = "khanhhuy"
local SETTINGS = {
    ESP = false,
    ESP_Box = true,
    ESP_Tracer = true,
    ESP_Name = true,
    ESP_Health = true,
    ESP_Distance = true,
    Aimbot = false,
    SilentAim = true,
    AimPart = "Head",
    Smoothness = 0.15,
    FOV = 200,
    VisibleCheck = true,
    Speed = false
}
local TEAM_CHECK = true -- luôn bật

-- ===== KEY SYSTEM =====
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "KeySystem"
KeyGui.ResetOnSpawn = false
KeyGui.Parent = LocalPlayer.PlayerGui

local KeyOverlay = Instance.new("Frame", KeyGui)
KeyOverlay.Size = UDim2.new(1,0,1,0)
KeyOverlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
KeyOverlay.BackgroundTransparency = 0.6
KeyOverlay.BorderSizePixel = 0

local KeyFrame = Instance.new("Frame", KeyGui)
KeyFrame.Size = UDim2.new(0,300,0,180)
KeyFrame.Position = UDim2.new(0.5,-150,0.5,-90)
KeyFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
KeyFrame.BorderSizePixel = 0
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0,16)
Instance.new("UIStroke", KeyFrame).Color = Color3.fromRGB(0,255,255)
KeyFrame.UIStroke.Thickness = 2

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1,0,0,40)
KeyTitle.BackgroundColor3 = Color3.fromRGB(30,30,30)
KeyTitle.Text = "🔐 ĐĂNG NHẬP"
KeyTitle.TextColor3 = Color3.fromRGB(0,255,255)
KeyTitle.Font = Enum.Font.GothamBlack
KeyTitle.TextSize = 18
Instance.new("UICorner", KeyTitle).CornerRadius = UDim.new(0,16)

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(1,-30,0,36)
KeyInput.Position = UDim2.new(0,15,0,55)
KeyInput.PlaceholderText = "Nhập key..."
KeyInput.Text = ""
KeyInput.BackgroundColor3 = Color3.fromRGB(35,35,35)
KeyInput.TextColor3 = Color3.fromRGB(255,255,255)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 15
KeyInput.BorderSizePixel = 0
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0,10)

local KeySubmit = Instance.new("TextButton", KeyFrame)
KeySubmit.Size = UDim2.new(0,100,0,36)
KeySubmit.Position = UDim2.new(0.5,-50,0,115)
KeySubmit.Text = "MỞ KHÓA"
KeySubmit.BackgroundColor3 = Color3.fromRGB(0,200,200)
KeySubmit.TextColor3 = Color3.fromRGB(255,255,255)
KeySubmit.Font = Enum.Font.GothamBold
KeySubmit.TextSize = 15
KeySubmit.BorderSizePixel = 0
Instance.new("UICorner", KeySubmit).CornerRadius = UDim.new(0,10)

local KeyStatus = Instance.new("TextLabel", KeyFrame)
KeyStatus.Size = UDim2.new(1,0,0,20)
KeyStatus.Position = UDim2.new(0,0,0,160)
KeyStatus.BackgroundTransparency = 1
KeyStatus.Text = ""
KeyStatus.TextColor3 = Color3.fromRGB(255,80,80)
KeyStatus.Font = Enum.Font.Gotham
KeyStatus.TextSize = 13

KeySubmit.MouseButton1Click:Connect(function()
    if KeyInput.Text == KEY then
        KeyStatus.Text = "✅ Key chính xác! Đang tải..."
        KeyStatus.TextColor3 = Color3.fromRGB(0,255,0)
        wait(0.6)
        KeyGui:Destroy()
        spawn(loadMain)
    else
        KeyStatus.Text = "❌ Sai key. Thử lại."
        KeyStatus.TextColor3 = Color3.fromRGB(255,80,80)
        KeyInput.Text = ""
    end
end)

function loadMain()
    local MainGui = Instance.new("ScreenGui")
    MainGui.Name = "MuiglMain"
    MainGui.ResetOnSpawn = false
    MainGui.Parent = LocalPlayer.PlayerGui

    -- Số kẻ địch
    local EnemyCountLabel = Instance.new("TextLabel", MainGui)
    EnemyCountLabel.Size = UDim2.new(0,200,0,30)
    EnemyCountLabel.Position = UDim2.new(0.5,-100,0,70)
    EnemyCountLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
    EnemyCountLabel.BackgroundTransparency = 0.6
    EnemyCountLabel.TextColor3 = Color3.fromRGB(255,255,0)
    EnemyCountLabel.Font = Enum.Font.GothamBold
    EnemyCountLabel.TextSize = 18
    EnemyCountLabel.Text = ""
    EnemyCountLabel.ZIndex = 100
    Instance.new("UICorner", EnemyCountLabel).CornerRadius = UDim.new(0,8)
    EnemyCountLabel.Visible = false

    -- Menu chính
    local Menu = Instance.new("Frame", MainGui)
    Menu.Size = UDim2.new(0,540,0,440)
    Menu.Position = UDim2.new(0.5,-270,1,0)
    Menu.BackgroundColor3 = Color3.fromRGB(20,20,20)
    Menu.BorderSizePixel = 0
    Menu.ZIndex = 200
    Menu.Visible = false
    Instance.new("UICorner", Menu).CornerRadius = UDim.new(0,18)
    local MenuStroke = Instance.new("UIStroke", Menu)
    MenuStroke.Color = Color3.fromRGB(255,255,255)
    MenuStroke.Thickness = 1.5
    MenuStroke.Transparency = 0.3

    -- Tiêu đề
    local TitleBar = Instance.new("Frame", Menu)
    TitleBar.Size = UDim2.new(1,0,0,45)
    TitleBar.BackgroundColor3 = Color3.fromRGB(30,30,30)
    TitleBar.BorderSizePixel = 0
    TitleBar.ZIndex = 155
    Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0,18)
    local TitleText = Instance.new("TextLabel", TitleBar)
    TitleText.Size = UDim2.new(1,-40,1,0)
    TitleText.Position = UDim2.new(0,15,0,0)
    TitleText.Text = "⚡ MUIGL REBORN ⚡"
    TitleText.TextColor3 = Color3.fromRGB(0,255,255)
    TitleText.Font = Enum.Font.GothamBlack
    TitleText.TextSize = 20
    TitleText.BackgroundTransparency = 1
    TitleText.ZIndex = 156

    local CloseBtn = Instance.new("TextButton", TitleBar)
    CloseBtn.Size = UDim2.new(0,28,0,28)
    CloseBtn.Position = UDim2.new(1,-34,0,8)
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255,90,90)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 16
    CloseBtn.BorderSizePixel = 0
    CloseBtn.ZIndex = 157
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0,14)

    -- Tab bar
    local TabBar = Instance.new("Frame", Menu)
    TabBar.Size = UDim2.new(1,-10,0,40)
    TabBar.Position = UDim2.new(0,5,0,50)
    TabBar.BackgroundTransparency = 1
    TabBar.ZIndex = 150

    -- Content container
    local ContentContainer = Instance.new("Frame", Menu)
    ContentContainer.Size = UDim2.new(1,-20,1,-100)
    ContentContainer.Position = UDim2.new(0,10,0,95)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.ZIndex = 140

    local Tabs = {"ESP", "Aimbot", "Visuals", "Other"}
    local ContentFrames = {}
    for _, name in ipairs(Tabs) do
        local frame = Instance.new("Frame", ContentContainer)
        frame.Size = UDim2.new(1,0,1,0)
        frame.BackgroundTransparency = 1
        frame.Visible = false
        frame.ZIndex = 140
        ContentFrames[name] = frame
    end
    ContentFrames["ESP"].Visible = true

    local selectedTab = "ESP"
    local tabBtns = {}
    local function setTab(tab)
        selectedTab = tab
        for _, btn in ipairs(tabBtns) do
            btn.BackgroundColor3 = btn.Name == tab and Color3.fromRGB(0,160,255) or Color3.fromRGB(70,70,70)
        end
        for _, f in pairs(ContentFrames) do f.Visible = false end
        ContentFrames[tab].Visible = true
    end

    for i, tabName in ipairs(Tabs) do
        local btn = Instance.new("TextButton", TabBar)
        btn.Name = tabName
        btn.Size = UDim2.new(0,115,1,0)
        btn.Position = UDim2.new(0,(i-1)*125,0,0)
        btn.BackgroundColor3 = tabName == "ESP" and Color3.fromRGB(0,160,255) or Color3.fromRGB(70,70,70)
        btn.Text = tabName
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 14
        btn.BorderSizePixel = 0
        btn.ZIndex = 151
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
        btn.MouseButton1Click:Connect(function() setTab(tabName) end)
        table.insert(tabBtns, btn)
    end

    -- Hàm tạo Toggle
    local function addToggle(parent, name, default, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1,0,0,36)
        frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
        frame.BackgroundTransparency = 0.2
        frame.ZIndex = 141
        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(0.65,0,1,0)
        label.Position = UDim2.new(0,5,0,0)
        label.Text = name
        label.TextColor3 = Color3.fromRGB(255,255,255)
        label.Font = Enum.Font.Gotham
        label.TextSize = 13
        label.BackgroundTransparency = 1
        label.TextXAlignment = Enum.TextXAlignment.Left
        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(0,46,0,22)
        btn.Position = UDim2.new(0.75,0,0.5,-11)
        btn.BackgroundColor3 = default and Color3.fromRGB(0,210,0) or Color3.fromRGB(210,0,0)
        btn.Text = default and "ON" or "OFF"
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.BorderSizePixel = 0
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
        local state = default
        btn.MouseButton1Click:Connect(function()
            state = not state
            btn.BackgroundColor3 = state and Color3.fromRGB(0,210,0) or Color3.fromRGB(210,0,0)
            btn.Text = state and "ON" or "OFF"
            callback(state)
        end)
        local y = 8
        for _, child in ipairs(parent:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextButton") then y = y + child.Size.Y.Offset + 6 end
        end
        frame.Position = UDim2.new(0,10,0,y)
        frame.Parent = parent
        return frame
    end

    -- Tab ESP
    local espTab = ContentFrames["ESP"]
    addToggle(espTab, "Bật ESP", false, function(v)
        SETTINGS.ESP = v
        EnemyCountLabel.Visible = v
        if not v then EnemyCountLabel.Text = "" end
    end)
    addToggle(espTab, "Box", true, function(v) SETTINGS.ESP_Box = v end)
    addToggle(espTab, "Tracer (Tia)", true, function(v) SETTINGS.ESP_Tracer = v end)
    addToggle(espTab, "Tên", true, function(v) SETTINGS.ESP_Name = v end)
    addToggle(espTab, "Máu", true, function(v) SETTINGS.ESP_Health = v end)
    addToggle(espTab, "Khoảng cách", true, function(v) SETTINGS.ESP_Distance = v end)

    -- Tab Aimbot
    local aimTab = ContentFrames["Aimbot"]
    addToggle(aimTab, "Bật Aimbot", false, function(v) SETTINGS.Aimbot = v end)
    addToggle(aimTab, "Silent Aim", true, function(v) SETTINGS.SilentAim = v end)
    addToggle(aimTab, "Visible Check", true, function(v) SETTINGS.VisibleCheck = v end)

    -- FOV slider
    local fovFrame = Instance.new("Frame")
    fovFrame.Size = UDim2.new(1,0,0,42)
    fovFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
    fovFrame.BackgroundTransparency = 0.2
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
    fovInput.BackgroundColor3 = Color3.fromRGB(50,50,50)
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
    local y1 = 8
    for _, child in ipairs(aimTab:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextButton") then y1 = y1 + child.Size.Y.Offset + 6 end
    end
    fovFrame.Position = UDim2.new(0,10,0,y1)
    fovFrame.Parent = aimTab

    -- Smoothness slider
    local smoothFrame = Instance.new("Frame")
    smoothFrame.Size = UDim2.new(1,0,0,42)
    smoothFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
    smoothFrame.BackgroundTransparency = 0.2
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
    smoothInput.BackgroundColor3 = Color3.fromRGB(50,50,50)
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
    local y2 = 8
    for _, child in ipairs(aimTab:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextButton") then y2 = y2 + child.Size.Y.Offset + 6 end
    end
    smoothFrame.Position = UDim2.new(0,10,0,y2)
    smoothFrame.Parent = aimTab

    -- Chọn bộ phận
    local partBtn = Instance.new("TextButton")
    partBtn.Size = UDim2.new(1,0,0,30)
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
    local y3 = 8
    for _, child in ipairs(aimTab:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextButton") then y3 = y3 + child.Size.Y.Offset + 6 end
    end
    partBtn.Position = UDim2.new(0,10,0,y3)
    partBtn.Parent = aimTab

    -- Tab Visuals
    local visTab = ContentFrames["Visuals"]
    addToggle(visTab, "FOV Circle", true, function(v) end)

    -- Tab Other
    local otherTab = ContentFrames["Other"]
    addToggle(otherTab, "Speed Hack", false, function(v) SETTINGS.Speed = v end)

    -- ===== KÍCH HOẠT MENU (CỬ CHỈ VUỐT 3 NGÓN LÊN) =====
    local menuOpen = false
    local touchData = {} -- mỗi ngón: {startPos, endPos, active}
    local swipeThreshold = 100 -- tổng quãng đường tối thiểu để kích hoạt
    local threeTouchActive = false

    local function toggleMenu()
        menuOpen = not menuOpen
        if menuOpen then
            Menu.Visible = true
            Menu.Position = UDim2.new(0.5,-270,1,0)
            TweenService:Create(Menu, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5,-270,0.5,-220)}):Play()
        else
            TweenService:Create(Menu, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5,-270,1,0)}):Play()
            wait(0.35)
            Menu.Visible = false
        end
    end

    UserInputService.TouchStarted:Connect(function(touch, processed)
        if processed then return end
        touchData[touch] = {startPos = Vector2.new(touch.Position.X, touch.Position.Y), endPos = nil, active = true}
        -- Kiểm tra số ngón đang chạm
        local count = 0
        for _, data in pairs(touchData) do
            if data.active then count = count + 1 end
        end
        if count == 3 and not threeTouchActive then
            threeTouchActive = true
        end
    end)

    UserInputService.TouchMoved:Connect(function(touch, processed)
        if processed then return end
        if touchData[touch] and touchData[touch].active then
            touchData[touch].endPos = Vector2.new(touch.Position.X, touch.Position.Y)
        end
    end)

    UserInputService.TouchEnded:Connect(function(touch, processed)
        if processed then return end
        if touchData[touch] then
            touchData[touch].active = false
            touchData[touch].endPos = Vector2.new(touch.Position.X, touch.Position.Y)
        end
        -- Kiểm tra xem tất cả 3 ngón đã kết thúc chưa
        local count = 0
        for _, data in pairs(touchData) do
            if data.active then count = count + 1 end
        end
        if count == 0 and threeTouchActive then
            -- Tất cả ngón đã rời, kiểm tra cử chỉ vuốt lên
            local allUp = true
            local totalDist = 0
            local validFingers = 0
            for _, data in pairs(touchData) do
                if data.startPos and data.endPos then
                    local distY = data.startPos.Y - data.endPos.Y -- dương nếu vuốt lên
                    if distY < 0 then allUp = false end
                    totalDist = totalDist + math.abs(distY)
                    validFingers = validFingers + 1
                end
            end
            if validFingers == 3 and allUp and totalDist >= swipeThreshold then
                toggleMenu()
            end
            -- Reset trạng thái
            threeTouchActive = false
            touchData = {}
        end
    end)

    CloseBtn.MouseButton1Click:Connect(function()
        if menuOpen then toggleMenu() end
    end)

    -- ===== ESP (ScreenGui) =====
    local ESPGui = Instance.new("ScreenGui", MainGui)
    ESPGui.Name = "ESP"
    ESPGui.IgnoreGuiInset = true
    ESPGui.ResetOnSpawn = false

    local espObjects = {}

    local function clearESP()
        for _, obj in pairs(espObjects) do
            if obj.Destroy then obj:Destroy() end
        end
        espObjects = {}
    end

    local function createESP(className, properties)
        local obj = Instance.new(className)
        for prop, value in pairs(properties) do
            obj[prop] = value
        end
        obj.Parent = ESPGui
        table.insert(espObjects, obj)
        return obj
    end

    local function updateESP()
        clearESP()
        EnemyCountLabel.Text = ""
        if not SETTINGS.ESP then return end

        local enemyCount = 0
        for _, player in ipairs(Players:GetPlayers()) do
            if player == LocalPlayer then continue end
            if TEAM_CHECK and player.Team == LocalPlayer.Team then continue end
            local char = player.Character
            if not char then continue end
            local head = char:FindFirstChild("Head")
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not head or not root or not hum or hum.Health <= 0 then continue end

            local headPos, headOnScreen = Camera:WorldToViewportPoint(head.Position)
            local rootPos, rootOnScreen = Camera:WorldToViewportPoint(root.Position)
            if not headOnScreen or not rootOnScreen then continue end

            enemyCount = enemyCount + 1
            local boxH = math.abs(headPos.Y - rootPos.Y) * 1.8
            local boxW = boxH * 0.65
            local boxX = headPos.X - boxW/2
            local boxY = headPos.Y - boxH * 0.2
            local dist = LocalPlayer.Character and LocalPlayer.Character.PrimaryPart and (LocalPlayer.Character.PrimaryPart.Position - root.Position).Magnitude or 0
            local hpPct = hum.Health / hum.MaxHealth

            -- Box
            if SETTINGS.ESP_Box then
                createESP("Frame", {
                    Size = UDim2.new(0, boxW, 0, boxH),
                    Position = UDim2.new(0, boxX, 0, boxY),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 2,
                    BorderColor3 = Color3.fromRGB(0,255,255)
                })
            end

            -- Tracer
            if SETTINGS.ESP_Tracer then
                local midX = Camera.ViewportSize.X/2
                local midY = Camera.ViewportSize.Y
                local dx = headPos.X - midX
                local dy = rootPos.Y - midY
                local length = math.sqrt(dx*dx + dy*dy)
                local angle = math.deg(math.atan2(dy, dx))
                local tracerLine = createESP("Frame", {
                    Size = UDim2.new(0, 1, 0, length),
                    Position = UDim2.new(0, midX, 0, midY),
                    Rotation = angle,
                    BackgroundColor3 = Color3.fromRGB(255,255,255),
                    BackgroundTransparency = 0.6,
                    BorderSizePixel = 0,
                    AnchorPoint = Vector2.new(0.5, 0)
                })
            end

            -- Name
            if SETTINGS.ESP_Name then
                createESP("TextLabel", {
                    Size = UDim2.new(0, 200, 0, 20),
                    Position = UDim2.new(0, headPos.X - 100, 0, boxY - 22),
                    Text = player.Name,
                    TextColor3 = Color3.fromRGB(255,255,255),
                    Font = Enum.Font.GothamBold,
                    TextSize = 13,
                    BackgroundTransparency = 1,
                    TextStrokeTransparency = 0.5
                })
            end

            -- Health bar
            if SETTINGS.ESP_Health then
                local bw = 3
                local bh = boxH
                local bx = boxX - bw - 3
                local by = boxY
                createESP("Frame", {
                    Size = UDim2.new(0, bw, 0, bh),
                    Position = UDim2.new(0, bx, 0, by),
                    BackgroundColor3 = Color3.fromRGB(20,20,20),
                    BorderSizePixel = 0
                })
                createESP("Frame", {
                    Size = UDim2.new(0, bw, 0, bh * hpPct),
                    Position = UDim2.new(0, bx, 0, by + bh * (1 - hpPct)),
                    BackgroundColor3 = Color3.fromHSV(hpPct * 0.3, 1, 1),
                    BorderSizePixel = 0
                })
            end

            -- Distance
            if SETTINGS.ESP_Distance then
                createESP("TextLabel", {
                    Size = UDim2.new(0, 200, 0, 20),
                    Position = UDim2.new(0, headPos.X - 100, 0, rootPos.Y + 5),
                    Text = string.format("%.0f m", dist),
                    TextColor3 = Color3.fromRGB(200,200,200),
                    Font = Enum.Font.Gotham,
                    TextSize = 11,
                    BackgroundTransparency = 1,
                    TextStrokeTransparency = 0.5
                })
            end
        end

        if enemyCount > 0 then
            EnemyCountLabel.Text = "Kẻ địch: "..enemyCount
        end
    end

    RunService.RenderStepped:Connect(updateESP)

    -- ===== AIMBOT & FOV (GUI) =====
    local FOVGui = Instance.new("ScreenGui", MainGui)
    FOVGui.Name = "FOV"
    FOVGui.IgnoreGuiInset = true
    local fovObjects = {}

    local function drawFOV()
        for _, obj in ipairs(fovObjects) do
            if obj.Destroy then obj:Destroy() end
        end
        fovObjects = {}
        if not SETTINGS.Aimbot then return end
        local cx, cy = Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2
        local r = SETTINGS.FOV
        for i = 0, 71 do
            local angle = (i / 72) * math.pi * 2
            local x = cx + math.cos(angle) * r
            local y = cy + math.sin(angle) * r
            local dot = Instance.new("Frame")
            dot.Size = UDim2.new(0, 4, 0, 4)
            dot.Position = UDim2.new(0, x-2, 0, y-2)
            dot.BackgroundColor3 = Color3.fromRGB(255,255,255)
            dot.BackgroundTransparency = 0.4
            dot.BorderSizePixel = 0
            dot.Parent = FOVGui
            table.insert(fovObjects, dot)
        end
    end

    local function aimbot()
        if not SETTINGS.Aimbot then return end
        drawFOV()
        if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
            return
        end
        local closest, minDist = nil, SETTINGS.FOV
        for _, player in ipairs(Players:GetPlayers()) do
            if player == LocalPlayer then continue end
            if TEAM_CHECK and player.Team == LocalPlayer.Team then continue end
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

    -- Speed Hack
    spawn(function()
        while true do
            wait(0.3)
            if SETTINGS.Speed and LocalPlayer.Character then
                local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = 50 end
            end
        end
    end)

    print("Muigl Reborn sẵn sàng. Vuốt 3 ngón lên để mở menu.")
end

print("Script đã load. Nhập key để tiếp tục.")