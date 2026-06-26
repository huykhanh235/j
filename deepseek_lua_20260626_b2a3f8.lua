--[[
    Script Hack Roblox - Muigl Reborn v3
    Key: khanhhuy
    - Kích hoạt menu: chạm 3 ngón giữ 1 giây hoặc vuốt 3 ngón lên
    - Menu đẹp, có thể cuộn, slider FOV, Smoothness
    - ESP box bo góc đẹp, tracer, tên, máu, khoảng cách
    - Aimbot với FOV circle, silent aim
    - Speed hack
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Workspace = game:GetService("Workspace")

repeat wait() until LocalPlayer and LocalPlayer:WaitForChild("PlayerGui")

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
local TEAM_CHECK = true

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
KeyFrame.Size = UDim2.new(0,320,0,190)
KeyFrame.Position = UDim2.new(0.5,-160,0.5,-95)
KeyFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
KeyFrame.BorderSizePixel = 0
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0,16)
local stroke = Instance.new("UIStroke", KeyFrame)
stroke.Color = Color3.fromRGB(0,255,255)
stroke.Thickness = 2

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1,0,0,40)
KeyTitle.BackgroundColor3 = Color3.fromRGB(30,30,30)
KeyTitle.Text = "🔐 ĐĂNG NHẬP"
KeyTitle.TextColor3 = Color3.fromRGB(0,255,255)
KeyTitle.Font = Enum.Font.GothamBlack
KeyTitle.TextSize = 18
KeyTitle.BorderSizePixel = 0
Instance.new("UICorner", KeyTitle).CornerRadius = UDim.new(0,16)

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(1,-30,0,36)
KeyInput.Position = UDim2.new(0,15,0,55)
KeyInput.PlaceholderText = "Nhập key..."
KeyInput.BackgroundColor3 = Color3.fromRGB(35,35,35)
KeyInput.TextColor3 = Color3.fromRGB(255,255,255)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 15
KeyInput.BorderSizePixel = 0
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0,10)

local KeySubmit = Instance.new("TextButton", KeyFrame)
KeySubmit.Size = UDim2.new(0,120,0,36)
KeySubmit.Position = UDim2.new(0.5,-60,0,110)
KeySubmit.Text = "MỞ KHÓA"
KeySubmit.BackgroundColor3 = Color3.fromRGB(0,200,200)
KeySubmit.TextColor3 = Color3.fromRGB(255,255,255)
KeySubmit.Font = Enum.Font.GothamBold
KeySubmit.TextSize = 15
KeySubmit.BorderSizePixel = 0
Instance.new("UICorner", KeySubmit).CornerRadius = UDim.new(0,10)

local KeyStatus = Instance.new("TextLabel", KeyFrame)
KeyStatus.Size = UDim2.new(1,0,0,22)
KeyStatus.Position = UDim2.new(0,0,0,158)
KeyStatus.BackgroundTransparency = 1
KeyStatus.Text = ""
KeyStatus.TextColor3 = Color3.fromRGB(255,80,80)
KeyStatus.Font = Enum.Font.Gotham
KeyStatus.TextSize = 13

KeySubmit.MouseButton1Click:Connect(function()
    if KeyInput.Text == KEY then
        KeyStatus.Text = "✅ Key chính xác!"
        KeyStatus.TextColor3 = Color3.fromRGB(0,255,0)
        wait(0.4)
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

    -- Đếm kẻ địch
    local EnemyCountLabel = Instance.new("TextLabel", MainGui)
    EnemyCountLabel.Size = UDim2.new(0,200,0,30)
    EnemyCountLabel.Position = UDim2.new(0.5,-100,0,70)
    EnemyCountLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
    EnemyCountLabel.BackgroundTransparency = 0.6
    EnemyCountLabel.TextColor3 = Color3.fromRGB(255,255,0)
    EnemyCountLabel.Font = Enum.Font.GothamBold
    EnemyCountLabel.TextSize = 18
    EnemyCountLabel.Text = ""
    EnemyCountLabel.BorderSizePixel = 0
    Instance.new("UICorner", EnemyCountLabel).CornerRadius = UDim.new(0,8)
    EnemyCountLabel.Visible = false

    -- ===== MENU CHÍNH =====
    local Menu = Instance.new("Frame", MainGui)
    Menu.Size = UDim2.new(0,380,0,460)
    Menu.Position = UDim2.new(0.5,-190,1,20)
    Menu.BackgroundColor3 = Color3.fromRGB(18,18,18)
    Menu.BorderSizePixel = 0
    Menu.Visible = false
    Instance.new("UICorner", Menu).CornerRadius = UDim.new(0,20)
    local ms = Instance.new("UIStroke", Menu)
    ms.Color = Color3.fromRGB(255,255,255)
    ms.Thickness = 1.5
    ms.Transparency = 0.3

    -- Tiêu đề
    local TitleBar = Instance.new("Frame", Menu)
    TitleBar.Size = UDim2.new(1,0,0,48)
    TitleBar.Position = UDim2.new(0,0,0,0)
    TitleBar.BackgroundColor3 = Color3.fromRGB(28,28,28)
    TitleBar.BorderSizePixel = 0
    Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0,20)

    local TitleText = Instance.new("TextLabel", TitleBar)
    TitleText.Size = UDim2.new(1,-60,1,0)
    TitleText.Position = UDim2.new(0,15,0,0)
    TitleText.Text = "⚡ MUIGL REBORN ⚡"
    TitleText.TextColor3 = Color3.fromRGB(0,255,255)
    TitleText.Font = Enum.Font.GothamBlack
    TitleText.TextSize = 20
    TitleText.BackgroundTransparency = 1
    TitleText.TextXAlignment = Enum.TextXAlignment.Left

    local CloseBtn = Instance.new("TextButton", TitleBar)
    CloseBtn.Size = UDim2.new(0,30,0,30)
    CloseBtn.Position = UDim2.new(1,-38,0.5,-15)
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255,90,90)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 18
    CloseBtn.BorderSizePixel = 0
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0,15)

    -- Tab bar
    local TabBar = Instance.new("Frame", Menu)
    TabBar.Size = UDim2.new(1,-20,0,36)
    TabBar.Position = UDim2.new(0,10,0,54)
    TabBar.BackgroundTransparency = 1

    local TabLayout = Instance.new("UIListLayout", TabBar)
    TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Padding = UDim.new(0,6)

    -- Content (ScrollingFrame)
    local ContentContainer = Instance.new("ScrollingFrame", Menu)
    ContentContainer.Size = UDim2.new(1,-20,1,-102)
    ContentContainer.Position = UDim2.new(0,10,0,96)
    ContentContainer.BackgroundColor3 = Color3.fromRGB(25,25,25)
    ContentContainer.BackgroundTransparency = 0.2
    ContentContainer.BorderSizePixel = 0
    ContentContainer.ScrollBarThickness = 4
    ContentContainer.ScrollBarImageColor3 = Color3.fromRGB(0,200,200)
    ContentContainer.CanvasSize = UDim2.new(0,0,0,0)
    ContentContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Instance.new("UICorner", ContentContainer).CornerRadius = UDim.new(0,12)

    local Tabs = {"ESP", "Aimbot", "Visuals", "Other"}
    local ContentFrames = {}

    for _, name in ipairs(Tabs) do
        local frame = Instance.new("Frame", ContentContainer)
        frame.Size = UDim2.new(1,0,1,0)
        frame.BackgroundTransparency = 1
        frame.Visible = false
        -- UIListLayout
        local layout = Instance.new("UIListLayout", frame)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0,6)
        local pad = Instance.new("UIPadding", frame)
        pad.PaddingTop = UDim.new(0,8)
        pad.PaddingLeft = UDim.new(0,8)
        pad.PaddingRight = UDim.new(0,8)
        pad.PaddingBottom = UDim.new(0,8)
        ContentFrames[name] = frame
    end
    ContentFrames["ESP"].Visible = true
    local selectedTab = "ESP"
    local tabBtns = {}

    local function setTab(tab)
        selectedTab = tab
        for _, btn in ipairs(tabBtns) do
            if btn.Name == tab then
                btn.BackgroundColor3 = Color3.fromRGB(0,160,255)
                btn.TextColor3 = Color3.fromRGB(255,255,255)
            else
                btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
                btn.TextColor3 = Color3.fromRGB(180,180,180)
            end
        end
        for _, f in pairs(ContentFrames) do f.Visible = false end
        ContentFrames[tab].Visible = true
    end

    for i, tabName in ipairs(Tabs) do
        local btn = Instance.new("TextButton", TabBar)
        btn.Name = tabName
        btn.Size = UDim2.new(0,80,1,0)
        btn.BackgroundColor3 = tabName == "ESP" and Color3.fromRGB(0,160,255) or Color3.fromRGB(60,60,60)
        btn.Text = tabName
        btn.TextColor3 = tabName == "ESP" and Color3.fromRGB(255,255,255) or Color3.fromRGB(180,180,180)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 13
        btn.BorderSizePixel = 0
        btn.LayoutOrder = i
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
        btn.MouseButton1Click:Connect(function() setTab(tabName) end)
        table.insert(tabBtns, btn)
    end

    -- ===== HÀM TẠO CONTROL =====
    local function addToggle(parent, labelText, default, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1,0,0,38)
        frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
        frame.BackgroundTransparency = 0.3
        frame.BorderSizePixel = 0
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0,8)

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(1,-70,1,0)
        label.Position = UDim2.new(0,10,0,0)
        label.Text = labelText
        label.TextColor3 = Color3.fromRGB(230,230,230)
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.BackgroundTransparency = 1
        label.TextXAlignment = Enum.TextXAlignment.Left

        local state = default
        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(0,52,0,24)
        btn.Position = UDim2.new(1,-60,0.5,-12)
        btn.BackgroundColor3 = state and Color3.fromRGB(0,210,80) or Color3.fromRGB(180,40,40)
        btn.Text = state and "ON" or "OFF"
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        btn.BorderSizePixel = 0
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,7)

        btn.MouseButton1Click:Connect(function()
            state = not state
            btn.BackgroundColor3 = state and Color3.fromRGB(0,210,80) or Color3.fromRGB(180,40,40)
            btn.Text = state and "ON" or "OFF"
            callback(state)
        end)

        frame.Parent = parent
        return frame
    end

    -- Hàm tạo Slider (thanh kéo)
    local function addSlider(parent, labelText, minVal, maxVal, defaultVal, isFloat, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1,0,0,56)
        frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
        frame.BackgroundTransparency = 0.3
        frame.BorderSizePixel = 0
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0,8)

        local lbl = Instance.new("TextLabel", frame)
        lbl.Size = UDim2.new(1,-10,0,20)
        lbl.Position = UDim2.new(0,10,0,2)
        lbl.Text = labelText..": "..tostring(defaultVal)
        lbl.TextColor3 = Color3.fromRGB(230,230,230)
        lbl.Font = Enum.Font.Gotham
        lbl.TextSize = 13
        lbl.BackgroundTransparency = 1
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        -- Thanh trượt
        local sliderBg = Instance.new("Frame", frame)
        sliderBg.Size = UDim2.new(1,-20,0,6)
        sliderBg.Position = UDim2.new(0,10,0,32)
        sliderBg.BackgroundColor3 = Color3.fromRGB(70,70,70)
        sliderBg.BorderSizePixel = 0
        Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1,0)

        local fill = Instance.new("Frame", sliderBg)
        fill.Size = UDim2.new((defaultVal-minVal)/(maxVal-minVal),0,1,0)
        fill.BackgroundColor3 = Color3.fromRGB(0,200,255)
        fill.BorderSizePixel = 0
        Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)

        local knob = Instance.new("TextButton", sliderBg)
        knob.Size = UDim2.new(0,18,0,18)
        knob.Position = UDim2.new((defaultVal-minVal)/(maxVal-minVal), -9, 0.5, -9)
        knob.BackgroundColor3 = Color3.fromRGB(0,200,255)
        knob.Text = ""
        knob.BorderSizePixel = 0
        Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

        local dragging = false
        local function updateSlider(mouseX)
            local relX = math.clamp((mouseX - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
            local val = minVal + (maxVal - minVal) * relX
            if isFloat then val = math.round(val * 100) / 100 end
            val = math.clamp(val, minVal, maxVal)
            fill.Size = UDim2.new(relX,0,1,0)
            knob.Position = UDim2.new(relX, -9, 0.5, -9)
            local display = isFloat and string.format("%.2f", val) or tostring(math.floor(val))
            lbl.Text = labelText..": "..display
            callback(val)
        end

        knob.MouseButton1Down:Connect(function(x, y)
            dragging = true
        end)
        UserInputService.InputChanged:Connect(function(input, processed)
            if processed then return end
            if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
                updateSlider(input.Position.X)
            end
        end)
        UserInputService.InputEnded:Connect(function(input, processed)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        -- cho phép click trên thanh để nhảy
        sliderBg.InputBegan:Connect(function(input, processed)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                updateSlider(input.Position.X)
            end
        end)

        frame.Parent = parent
        return frame
    end

    -- Hàm tạo cycle button
    local function addCycleBtn(parent, labelText, options, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1,0,0,38)
        frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
        frame.BackgroundTransparency = 0.3
        frame.BorderSizePixel = 0
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0,8)

        local idx = 1
        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(1,-10,1,-8)
        btn.Position = UDim2.new(0,5,0,4)
        btn.Text = labelText..": "..options[idx]
        btn.BackgroundColor3 = Color3.fromRGB(55,55,55)
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 13
        btn.BorderSizePixel = 0
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

        btn.MouseButton1Click:Connect(function()
            idx = idx % #options + 1
            btn.Text = labelText..": "..options[idx]
            callback(options[idx])
        end)

        frame.Parent = parent
        return frame
    end

    -- ===== ĐỔI SETTINGS =====
    -- ESP
    local espTab = ContentFrames["ESP"]
    addToggle(espTab, "Bật ESP", false, function(v) SETTINGS.ESP = v; EnemyCountLabel.Visible = v end)
    addToggle(espTab, "Box ESP", true, function(v) SETTINGS.ESP_Box = v end)
    addToggle(espTab, "Tracer", true, function(v) SETTINGS.ESP_Tracer = v end)
    addToggle(espTab, "Tên", true, function(v) SETTINGS.ESP_Name = v end)
    addToggle(espTab, "Thanh máu", true, function(v) SETTINGS.ESP_Health = v end)
    addToggle(espTab, "Khoảng cách", true, function(v) SETTINGS.ESP_Distance = v end)

    -- Aimbot
    local aimTab = ContentFrames["Aimbot"]
    addToggle(aimTab, "Bật Aimbot", false, function(v) SETTINGS.Aimbot = v end)
    addToggle(aimTab, "Silent Aim", true, function(v) SETTINGS.SilentAim = v end)
    addToggle(aimTab, "Visible Check", true, function(v) SETTINGS.VisibleCheck = v end)
    addSlider(aimTab, "FOV", 50, 500, 200, false, function(v) SETTINGS.FOV = v end)
    addSlider(aimTab, "Độ mượt", 0, 1, 0.15, true, function(v) SETTINGS.Smoothness = v end)
    addCycleBtn(aimTab, "Bộ phận", {"Head","HumanoidRootPart","UpperTorso","LowerTorso"}, function(v) SETTINGS.AimPart = v end)

    -- Visuals
    local visTab = ContentFrames["Visuals"]
    addToggle(visTab, "FOV Circle", true, function(v) end)

    -- Other
    local otherTab = ContentFrames["Other"]
    addToggle(otherTab, "Speed Hack", false, function(v) SETTINGS.Speed = v end)

    -- ===== KÍCH HOẠT MENU (3 ngón giữ 1s hoặc vuốt lên) =====
    local menuOpen = false
    local touchData = {}
    local touchStartTimes = {}
    local swipeThreshold = 80
    local holdTime = 1  -- giây

    local function toggleMenu()
        menuOpen = not menuOpen
        if menuOpen then
            Menu.Visible = true
            Menu.Position = UDim2.new(0.5,-190,1,20)
            TweenService:Create(Menu, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5,-190,0.5,-230)
            }):Play()
        else
            TweenService:Create(Menu, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Position = UDim2.new(0.5,-190,1,20)
            }):Play()
            wait(0.35)
            Menu.Visible = false
        end
    end

    UserInputService.TouchStarted:Connect(function(touch, processed)
        touchData[touch] = {startPos = Vector2.new(touch.Position.X, touch.Position.Y), endPos = nil, active = true}
        touchStartTimes[touch] = tick()
    end)

    UserInputService.TouchMoved:Connect(function(touch, processed)
        if touchData[touch] and touchData[touch].active then
            touchData[touch].endPos = Vector2.new(touch.Position.X, touch.Position.Y)
        end
    end)

    UserInputService.TouchEnded:Connect(function(touch, processed)
        if touchData[touch] then
            touchData[touch].active = false
            touchData[touch].endPos = Vector2.new(touch.Position.X, touch.Position.Y)
        end
        local activeCount = 0
        for _, data in pairs(touchData) do if data.active then activeCount = activeCount + 1 end end
        if activeCount == 0 then
            -- Kiểm tra vuốt lên
            local allUp = true
            local totalDist = 0
            local validFingers = 0
            for _, data in pairs(touchData) do
                if data.startPos and data.endPos then
                    local distY = data.startPos.Y - data.endPos.Y
                    if distY < swipeThreshold then allUp = false end
                    totalDist = totalDist + math.abs(distY)
                    validFingers = validFingers + 1
                end
            end
            if validFingers == 3 and allUp then
                toggleMenu()
                touchData = {}
                return
            end

            -- Kiểm tra giữ 1 giây với 3 ngón
            local allHeld = true
            local timeHeld = 0
            for touch, data in pairs(touchData) do
                if data.startPos and data.endPos then
                    local duration = tick() - touchStartTimes[touch]
                    if duration < holdTime then allHeld = false end
                    timeHeld = timeHeld + duration
                else
                    allHeld = false
                end
            end
            if validFingers == 3 and allHeld and timeHeld >= holdTime*3 then
                toggleMenu()
            end
            touchData = {}
        end
    end)

    CloseBtn.MouseButton1Click:Connect(function()
        if menuOpen then toggleMenu() end
    end)

    -- ===== ESP VẼ =====
    local ESPGui = Instance.new("ScreenGui", MainGui)
    ESPGui.Name = "ESPDraw"
    ESPGui.IgnoreGuiInset = true
    ESPGui.ResetOnSpawn = false

    local espObjects = {}

    local function clearESP()
        for _, obj in pairs(espObjects) do
            if obj and obj.Parent then obj:Destroy() end
        end
        espObjects = {}
    end

    local function addESP(obj)
        obj.Parent = ESPGui
        table.insert(espObjects, obj)
        return obj
    end

    local function makeFrame(props)
        local f = Instance.new("Frame")
        for k,v in pairs(props) do f[k] = v end
        return addESP(f)
    end

    local function makeLabel(props)
        local l = Instance.new("TextLabel")
        for k,v in pairs(props) do l[k] = v end
        return addESP(l)
    end

    local function updateESP()
        clearESP()
        if not SETTINGS.ESP then return end
        local enemyCount = 0
        local lp = LocalPlayer.Character
        for _, player in ipairs(Players:GetPlayers()) do
            if player == LocalPlayer then continue end
            if TEAM_CHECK and player.Team == LocalPlayer.Team then continue end
            local char = player.Character
            if not char then continue end
            local head = char:FindFirstChild("Head")
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not head or not root or not hum or hum.Health <= 0 then continue end

            local headPos, headOn = Camera:WorldToViewportPoint(head.Position)
            local rootPos, rootOn = Camera:WorldToViewportPoint(root.Position)
            if not headOn or not rootOn then continue end

            enemyCount = enemyCount + 1
            local boxH = math.abs(headPos.Y - rootPos.Y) * 1.8
            local boxW = boxH * 0.6
            local boxX = headPos.X - boxW/2
            local boxY = headPos.Y - boxH * 0.18
            local dist = lp and lp.PrimaryPart and (lp.PrimaryPart.Position - root.Position).Magnitude or 0
            local hpPct = math.clamp(hum.Health / hum.MaxHealth, 0, 1)

            -- Box bo góc
            if SETTINGS.ESP_Box then
                local box = makeFrame({
                    Size = UDim2.new(0, boxW, 0, boxH),
                    Position = UDim2.new(0, boxX, 0, boxY),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 2,
                    BorderColor3 = Color3.fromRGB(0,255,255)
                })
                Instance.new("UICorner", box).CornerRadius = UDim.new(0,4)
            end

            -- Tracer
            if SETTINGS.ESP_Tracer then
                local midX = Camera.ViewportSize.X/2
                local midY = Camera.ViewportSize.Y
                local dx = rootPos.X - midX
                local dy = rootPos.Y - midY
                local length = math.sqrt(dx*dx + dy*dy)
                local angle = math.deg(math.atan2(dy, dx)) + 90
                makeFrame({
                    Size = UDim2.new(0, 2, 0, length),
                    Position = UDim2.new(0, midX-1, 0, midY),
                    Rotation = angle,
                    BackgroundColor3 = Color3.fromRGB(255,255,100),
                    BackgroundTransparency = 0.4,
                    BorderSizePixel = 0,
                    AnchorPoint = Vector2.new(0.5,0)
                })
            end

            -- Tên
            if SETTINGS.ESP_Name then
                makeLabel({
                    Size = UDim2.new(0,200,0,20),
                    Position = UDim2.new(0,headPos.X-100,0,boxY-22),
                    Text = player.Name,
                    TextColor3 = Color3.fromRGB(255,255,255),
                    Font = Enum.Font.GothamBold,
                    TextSize = 13,
                    BackgroundTransparency = 1,
                    TextStrokeTransparency = 0.4,
                    TextXAlignment = Enum.TextXAlignment.Center
                })
            end

            -- Máu
            if SETTINGS.ESP_Health then
                local bw = 4
                local bx = boxX - bw - 3
                makeFrame({
                    Size = UDim2.new(0,bw,0,boxH),
                    Position = UDim2.new(0,bx,0,boxY),
                    BackgroundColor3 = Color3.fromRGB(15,15,15),
                    BorderSizePixel = 0
                })
                makeFrame({
                    Size = UDim2.new(0,bw,0,math.max(2, boxH*hpPct)),
                    Position = UDim2.new(0,bx,0,boxY + boxH*(1-hpPct)),
                    BackgroundColor3 = Color3.fromHSV(hpPct*0.33, 1, 1),
                    BorderSizePixel = 0
                })
            end

            -- Khoảng cách
            if SETTINGS.ESP_Distance then
                makeLabel({
                    Size = UDim2.new(0,200,0,18),
                    Position = UDim2.new(0,headPos.X-100,0,rootPos.Y+5),
                    Text = string.format("[%.0fm]", dist),
                    TextColor3 = Color3.fromRGB(180,180,255),
                    Font = Enum.Font.Gotham,
                    TextSize = 11,
                    BackgroundTransparency = 1,
                    TextStrokeTransparency = 0.5,
                    TextXAlignment = Enum.TextXAlignment.Center
                })
            end
        end
        EnemyCountLabel.Text = enemyCount > 0 and "Kẻ địch: "..enemyCount or ""
    end

    RunService.RenderStepped:Connect(updateESP)

    -- ===== AIMBOT & FOV =====
    local FOVGui = Instance.new("ScreenGui", MainGui)
    FOVGui.Name = "FOVDraw"
    FOVGui.IgnoreGuiInset = true
    local fovObjects = {}

    local function drawFOV()
        for _, obj in pairs(fovObjects) do if obj and obj.Parent then obj:Destroy() end end
        fovObjects = {}
        if not SETTINGS.Aimbot then return end
        local cx = Camera.ViewportSize.X/2
        local cy = Camera.ViewportSize.Y/2
        local r = SETTINGS.FOV
        local segments = 72
        for i = 0, segments-1 do
            local angle = (i/segments)*math.pi*2
            local x = cx + math.cos(angle)*r
            local y = cy + math.sin(angle)*r
            local dot = Instance.new("Frame")
            dot.Size = UDim2.new(0,3,0,3)
            dot.Position = UDim2.new(0,x-1.5,0,y-1.5)
            dot.BackgroundColor3 = Color3.fromRGB(255,255,255)
            dot.BackgroundTransparency = 0.3
            dot.BorderSizePixel = 0
            dot.Parent = FOVGui
            table.insert(fovObjects, dot)
        end
    end

    local function aimbot()
        drawFOV()
        if not SETTINGS.Aimbot then return end
        if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then return end

        local closest, minDist = nil, SETTINGS.FOV
        for _, player in ipairs(Players:GetPlayers()) do
            if player == LocalPlayer then continue end
            if TEAM_CHECK and player.Team == LocalPlayer.Team then continue end
            local char = player.Character
            if not char then continue end
            local part = char:FindFirstChild(SETTINGS.AimPart)
            if not part then continue end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum or hum.Health <= 0 then continue end
            if SETTINGS.VisibleCheck then
                local rp = RaycastParams.new()
                rp.FilterDescendantsInstances = {LocalPlayer.Character}
                rp.FilterType = Enum.RaycastFilterType.Blacklist
                local ray = Workspace:Raycast(Camera.CFrame.Position, (part.Position - Camera.CFrame.Position).Unit * 1200, rp)
                if ray and not ray.Instance:IsDescendantOf(char) then continue end
            end
            local sp, onScreen = Camera:WorldToViewportPoint(part.Position)
            if not onScreen then continue end
            local dist = (Vector2.new(sp.X, sp.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
            if dist < minDist then
                minDist = dist
                closest = part
            end
        end

        if closest then
            local smooth = math.clamp(SETTINGS.Smoothness, 0.001, 1)
            local newLook = CFrame.new(Camera.CFrame.Position, closest.Position).LookVector
            local curLook = Camera.CFrame.LookVector
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + curLook:Lerp(newLook, 1 - smooth))
        end
    end

    RunService.RenderStepped:Connect(aimbot)

    -- Speed Hack
    spawn(function()
        while true do
            wait(0.25)
            if LocalPlayer.Character then
                local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum.WalkSpeed = SETTINGS.Speed and 50 or 16
                end
            end
        end
    end)

    setTab("ESP")
    print("[Muigl Reborn] Đã sẵn sàng. Chạm 3 ngón giữ 1s hoặc vuốt lên để mở menu.")
end

print("[Muigl] Đã load. Nhập key để tiếp tục.")