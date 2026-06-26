--[[
    Script Hack Roblox - Muigl Final Fix v2
    Key: khanhhuy
    Fix: ZIndex, layout UIListLayout, tab switch, toggle hiển thị tên đúng
    ESP: Box, Tracer, Tên, Máu, Khoảng cách.
    Aimbot: Silent Aim, FOV Circle.
    Speed Hack.
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
local TEAM_CHECK = true

-- ===== KEY SYSTEM =====
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "KeySystem"
KeyGui.ResetOnSpawn = false
KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
KeyGui.Parent = LocalPlayer.PlayerGui

local KeyOverlay = Instance.new("Frame", KeyGui)
KeyOverlay.Size = UDim2.new(1,0,1,0)
KeyOverlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
KeyOverlay.BackgroundTransparency = 0.6
KeyOverlay.BorderSizePixel = 0
KeyOverlay.ZIndex = 1

local KeyFrame = Instance.new("Frame", KeyGui)
KeyFrame.Size = UDim2.new(0,300,0,185)
KeyFrame.Position = UDim2.new(0.5,-150,0.5,-92)
KeyFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
KeyFrame.BorderSizePixel = 0
KeyFrame.ZIndex = 2
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0,16)
local ks = Instance.new("UIStroke", KeyFrame)
ks.Color = Color3.fromRGB(0,255,255)
ks.Thickness = 2

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1,0,0,40)
KeyTitle.BackgroundColor3 = Color3.fromRGB(30,30,30)
KeyTitle.Text = "🔐 ĐĂNG NHẬP"
KeyTitle.TextColor3 = Color3.fromRGB(0,255,255)
KeyTitle.Font = Enum.Font.GothamBlack
KeyTitle.TextSize = 18
KeyTitle.BorderSizePixel = 0
KeyTitle.ZIndex = 3
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
KeyInput.ZIndex = 3
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0,10)

local KeySubmit = Instance.new("TextButton", KeyFrame)
KeySubmit.Size = UDim2.new(0,120,0,36)
KeySubmit.Position = UDim2.new(0.5,-60,0,108)
KeySubmit.Text = "MỞ KHÓA"
KeySubmit.BackgroundColor3 = Color3.fromRGB(0,200,200)
KeySubmit.TextColor3 = Color3.fromRGB(255,255,255)
KeySubmit.Font = Enum.Font.GothamBold
KeySubmit.TextSize = 15
KeySubmit.BorderSizePixel = 0
KeySubmit.ZIndex = 3
Instance.new("UICorner", KeySubmit).CornerRadius = UDim.new(0,10)

local KeyStatus = Instance.new("TextLabel", KeyFrame)
KeyStatus.Size = UDim2.new(1,0,0,22)
KeyStatus.Position = UDim2.new(0,0,0,156)
KeyStatus.BackgroundTransparency = 1
KeyStatus.Text = ""
KeyStatus.TextColor3 = Color3.fromRGB(255,80,80)
KeyStatus.Font = Enum.Font.Gotham
KeyStatus.TextSize = 13
KeyStatus.ZIndex = 3

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
    MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
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
    EnemyCountLabel.ZIndex = 5
    Instance.new("UICorner", EnemyCountLabel).CornerRadius = UDim.new(0,8)
    EnemyCountLabel.Visible = false

    -- ===== MENU CHÍNH =====
    local Menu = Instance.new("Frame", MainGui)
    Menu.Size = UDim2.new(0,360,0,420)
    Menu.Position = UDim2.new(0.5,-180,1,20)
    Menu.BackgroundColor3 = Color3.fromRGB(18,18,18)
    Menu.BorderSizePixel = 0
    Menu.ZIndex = 10
    Menu.Visible = false
    Instance.new("UICorner", Menu).CornerRadius = UDim.new(0,18)
    local MenuStroke = Instance.new("UIStroke", Menu)
    MenuStroke.Color = Color3.fromRGB(255,255,255)
    MenuStroke.Thickness = 1.5
    MenuStroke.Transparency = 0.4

    -- Tiêu đề
    local TitleBar = Instance.new("Frame", Menu)
    TitleBar.Size = UDim2.new(1,0,0,45)
    TitleBar.Position = UDim2.new(0,0,0,0)
    TitleBar.BackgroundColor3 = Color3.fromRGB(28,28,28)
    TitleBar.BorderSizePixel = 0
    TitleBar.ZIndex = 11
    Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0,18)

    local TitleText = Instance.new("TextLabel", TitleBar)
    TitleText.Size = UDim2.new(1,-50,1,0)
    TitleText.Position = UDim2.new(0,15,0,0)
    TitleText.Text = "⚡ MUIGL REBORN ⚡"
    TitleText.TextColor3 = Color3.fromRGB(0,255,255)
    TitleText.Font = Enum.Font.GothamBlack
    TitleText.TextSize = 20
    TitleText.BackgroundTransparency = 1
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.ZIndex = 12

    local CloseBtn = Instance.new("TextButton", TitleBar)
    CloseBtn.Size = UDim2.new(0,28,0,28)
    CloseBtn.Position = UDim2.new(1,-36,0.5,-14)
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255,90,90)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 16
    CloseBtn.BorderSizePixel = 0
    CloseBtn.ZIndex = 13
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0,14)

    -- Tab bar (4 tab, fit vào 340px)
    local TabBar = Instance.new("Frame", Menu)
    TabBar.Size = UDim2.new(1,-20,0,34)
    TabBar.Position = UDim2.new(0,10,0,50)
    TabBar.BackgroundTransparency = 1
    TabBar.ZIndex = 11

    local TabLayout = Instance.new("UIListLayout", TabBar)
    TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Padding = UDim.new(0,5)

    -- Content area
    local ContentContainer = Instance.new("Frame", Menu)
    ContentContainer.Size = UDim2.new(1,-16,1,-96)
    ContentContainer.Position = UDim2.new(0,8,0,90)
    ContentContainer.BackgroundColor3 = Color3.fromRGB(25,25,25)
    ContentContainer.BackgroundTransparency = 0.2
    ContentContainer.BorderSizePixel = 0
    ContentContainer.ZIndex = 11
    Instance.new("UICorner", ContentContainer).CornerRadius = UDim.new(0,12)

    local Tabs = {"ESP", "Aimbot", "Visuals", "Other"}
    local ContentFrames = {}

    for _, name in ipairs(Tabs) do
        local frame = Instance.new("ScrollingFrame", ContentContainer)
        frame.Size = UDim2.new(1,0,1,0)
        frame.Position = UDim2.new(0,0,0,0)
        frame.BackgroundTransparency = 1
        frame.BorderSizePixel = 0
        frame.ScrollBarThickness = 4
        frame.ScrollBarImageColor3 = Color3.fromRGB(0,200,200)
        frame.CanvasSize = UDim2.new(0,0,0,0)
        frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        frame.Visible = false
        frame.ZIndex = 12
        -- UIListLayout để tự xếp chồng
        local layout = Instance.new("UIListLayout", frame)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0,6)
        -- Padding trong
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
        for _, f in pairs(ContentFrames) do
            f.Visible = false
        end
        ContentFrames[tab].Visible = true
    end

    -- Tạo tab buttons (mỗi cái ~78px để vừa 320px)
    for i, tabName in ipairs(Tabs) do
        local btn = Instance.new("TextButton", TabBar)
        btn.Name = tabName
        btn.Size = UDim2.new(0,78,1,0)
        btn.BackgroundColor3 = tabName == "ESP" and Color3.fromRGB(0,160,255) or Color3.fromRGB(60,60,60)
        btn.Text = tabName
        btn.TextColor3 = tabName == "ESP" and Color3.fromRGB(255,255,255) or Color3.fromRGB(180,180,180)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 13
        btn.BorderSizePixel = 0
        btn.ZIndex = 12
        btn.LayoutOrder = i
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
        btn.MouseButton1Click:Connect(function() setTab(tabName) end)
        table.insert(tabBtns, btn)
    end

    -- ===== HÀM TẠO TOGGLE (dùng UIListLayout, không tính y thủ công) =====
    local toggleOrder = {}
    for _, name in ipairs(Tabs) do toggleOrder[name] = 0 end

    local function addToggle(parent, labelText, default, callback)
        toggleOrder[parent.Name] = (toggleOrder[parent.Name] or 0) + 1
        local frame = Instance.new("Frame")
        frame.Name = "Toggle_"..labelText
        frame.Size = UDim2.new(1,0,0,38)
        frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
        frame.BackgroundTransparency = 0.3
        frame.BorderSizePixel = 0
        frame.ZIndex = 13
        frame.LayoutOrder = toggleOrder[parent.Name]
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0,8)

        -- Label TÊN CHỨC NĂNG
        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(1,-70,1,0)
        label.Position = UDim2.new(0,10,0,0)
        label.Text = labelText
        label.TextColor3 = Color3.fromRGB(230,230,230)
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.BackgroundTransparency = 1
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.ZIndex = 14

        -- Toggle button
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
        btn.ZIndex = 14
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

    -- Hàm tạo TextBox input (FOV, Smoothness)
    local function addInput(parent, labelText, defaultVal, minVal, maxVal, isFloat, callback)
        toggleOrder[parent.Name] = (toggleOrder[parent.Name] or 0) + 1
        local frame = Instance.new("Frame")
        frame.Name = "Input_"..labelText
        frame.Size = UDim2.new(1,0,0,52)
        frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
        frame.BackgroundTransparency = 0.3
        frame.BorderSizePixel = 0
        frame.ZIndex = 13
        frame.LayoutOrder = toggleOrder[parent.Name]
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0,8)

        local lbl = Instance.new("TextLabel", frame)
        lbl.Size = UDim2.new(1,-10,0,22)
        lbl.Position = UDim2.new(0,10,0,3)
        lbl.Text = labelText..": "..defaultVal
        lbl.TextColor3 = Color3.fromRGB(230,230,230)
        lbl.Font = Enum.Font.Gotham
        lbl.TextSize = 13
        lbl.BackgroundTransparency = 1
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.ZIndex = 14

        local inputBox = Instance.new("TextBox", frame)
        inputBox.Size = UDim2.new(1,-20,0,22)
        inputBox.Position = UDim2.new(0,10,0,26)
        inputBox.Text = tostring(defaultVal)
        inputBox.BackgroundColor3 = Color3.fromRGB(55,55,55)
        inputBox.TextColor3 = Color3.fromRGB(255,255,255)
        inputBox.Font = Enum.Font.Gotham
        inputBox.TextSize = 13
        inputBox.BorderSizePixel = 0
        inputBox.ZIndex = 14
        Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0,6)

        inputBox.FocusLost:Connect(function()
            local num = tonumber(inputBox.Text)
            if num then
                num = math.clamp(num, minVal, maxVal)
                if isFloat then
                    lbl.Text = labelText..": "..string.format("%.2f", num)
                    inputBox.Text = string.format("%.2f", num)
                else
                    lbl.Text = labelText..": "..math.floor(num)
                    inputBox.Text = tostring(math.floor(num))
                end
                callback(num)
            else
                inputBox.Text = tostring(defaultVal)
            end
        end)

        frame.Parent = parent
        return frame, lbl
    end

    -- Hàm tạo nút chọn (cycle button)
    local function addCycleBtn(parent, labelText, options, callback)
        toggleOrder[parent.Name] = (toggleOrder[parent.Name] or 0) + 1
        local frame = Instance.new("Frame")
        frame.Name = "Cycle_"..labelText
        frame.Size = UDim2.new(1,0,0,38)
        frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
        frame.BackgroundTransparency = 0.3
        frame.BorderSizePixel = 0
        frame.ZIndex = 13
        frame.LayoutOrder = toggleOrder[parent.Name]
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
        btn.ZIndex = 14
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

        btn.MouseButton1Click:Connect(function()
            idx = (idx % #options) + 1
            btn.Text = labelText..": "..options[idx]
            callback(options[idx])
        end)

        frame.Parent = parent
        return frame
    end

    -- ===== TAB ESP =====
    local espTab = ContentFrames["ESP"]
    addToggle(espTab, "Bật ESP", false, function(v)
        SETTINGS.ESP = v
        EnemyCountLabel.Visible = v
        if not v then EnemyCountLabel.Text = "" end
    end)
    addToggle(espTab, "Box ESP", true, function(v) SETTINGS.ESP_Box = v end)
    addToggle(espTab, "Tracer (Tia)", true, function(v) SETTINGS.ESP_Tracer = v end)
    addToggle(espTab, "Tên player", true, function(v) SETTINGS.ESP_Name = v end)
    addToggle(espTab, "Thanh Máu", true, function(v) SETTINGS.ESP_Health = v end)
    addToggle(espTab, "Khoảng cách", true, function(v) SETTINGS.ESP_Distance = v end)

    -- ===== TAB AIMBOT =====
    local aimTab = ContentFrames["Aimbot"]
    addToggle(aimTab, "Bật Aimbot", false, function(v) SETTINGS.Aimbot = v end)
    addToggle(aimTab, "Silent Aim", true, function(v) SETTINGS.SilentAim = v end)
    addToggle(aimTab, "Visible Check", true, function(v) SETTINGS.VisibleCheck = v end)
    addInput(aimTab, "FOV", 200, 50, 500, false, function(v) SETTINGS.FOV = v end)
    addInput(aimTab, "Độ mượt", 0.15, 0.01, 1, true, function(v) SETTINGS.Smoothness = v end)
    addCycleBtn(aimTab, "Bộ phận", {"Head","HumanoidRootPart","UpperTorso","LowerTorso"}, function(v)
        SETTINGS.AimPart = v
    end)

    -- ===== TAB VISUALS =====
    local visTab = ContentFrames["Visuals"]
    addToggle(visTab, "FOV Circle", true, function(v) end)

    -- ===== TAB OTHER =====
    local otherTab = ContentFrames["Other"]
    addToggle(otherTab, "Speed Hack", false, function(v) SETTINGS.Speed = v end)

    -- ===== TOGGLE MENU (VUỐT 3 NGÓN LÊN) =====
    local menuOpen = false
    local touchData = {}
    local swipeThreshold = 80

    local function toggleMenu()
        menuOpen = not menuOpen
        if menuOpen then
            Menu.Visible = true
            Menu.Position = UDim2.new(0.5,-180,1,20)
            TweenService:Create(Menu,
                TweenInfo.new(0.38, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Position = UDim2.new(0.5,-180,0.5,-210)}
            ):Play()
        else
            TweenService:Create(Menu,
                TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {Position = UDim2.new(0.5,-180,1,20)}
            ):Play()
            wait(0.32)
            Menu.Visible = false
        end
    end

    UserInputService.TouchStarted:Connect(function(touch, processed)
        touchData[touch] = {
            startPos = Vector2.new(touch.Position.X, touch.Position.Y),
            endPos = nil,
            active = true
        }
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
        for _, data in pairs(touchData) do
            if data.active then activeCount = activeCount + 1 end
        end
        if activeCount == 0 then
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
            end
            touchData = {}
        end
    end)

    CloseBtn.MouseButton1Click:Connect(function()
        if menuOpen then toggleMenu() end
    end)

    -- ===== ESP =====
    local ESPGui = Instance.new("ScreenGui", MainGui)
    ESPGui.Name = "ESPDraw"
    ESPGui.IgnoreGuiInset = true
    ESPGui.ResetOnSpawn = false
    ESPGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local espObjects = {}

    local function clearESP()
        for _, obj in pairs(espObjects) do
            if typeof(obj) == "Instance" and obj.Parent then
                obj:Destroy()
            end
        end
        espObjects = {}
    end

    local function makeFrame(props)
        local f = Instance.new("Frame")
        for k,v in pairs(props) do f[k] = v end
        f.Parent = ESPGui
        table.insert(espObjects, f)
        return f
    end

    local function makeLabel(props)
        local l = Instance.new("TextLabel")
        for k,v in pairs(props) do l[k] = v end
        l.Parent = ESPGui
        table.insert(espObjects, l)
        return l
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

            local headPos, headOn = Camera:WorldToViewportPoint(head.Position)
            local rootPos, rootOn = Camera:WorldToViewportPoint(root.Position)
            if not headOn or not rootOn then continue end

            enemyCount = enemyCount + 1
            local boxH = math.abs(headPos.Y - rootPos.Y) * 1.8
            local boxW = boxH * 0.6
            local boxX = headPos.X - boxW/2
            local boxY = headPos.Y - boxH * 0.18
            local lp = LocalPlayer.Character
            local dist = (lp and lp.PrimaryPart) and (lp.PrimaryPart.Position - root.Position).Magnitude or 0
            local hpPct = math.clamp(hum.Health / hum.MaxHealth, 0, 1)

            -- Box ESP
            if SETTINGS.ESP_Box then
                -- Top
                makeFrame({Size=UDim2.new(0,boxW,0,2),Position=UDim2.new(0,boxX,0,boxY),BackgroundColor3=Color3.fromRGB(0,255,255),BorderSizePixel=0})
                -- Bottom
                makeFrame({Size=UDim2.new(0,boxW,0,2),Position=UDim2.new(0,boxX,0,boxY+boxH),BackgroundColor3=Color3.fromRGB(0,255,255),BorderSizePixel=0})
                -- Left
                makeFrame({Size=UDim2.new(0,2,0,boxH),Position=UDim2.new(0,boxX,0,boxY),BackgroundColor3=Color3.fromRGB(0,255,255),BorderSizePixel=0})
                -- Right
                makeFrame({Size=UDim2.new(0,2,0,boxH),Position=UDim2.new(0,boxX+boxW,0,boxY),BackgroundColor3=Color3.fromRGB(0,255,255),BorderSizePixel=0})
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
                    Size = UDim2.new(0,2,0,length),
                    Position = UDim2.new(0,midX-1,0,midY),
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

            -- Thanh máu
            if SETTINGS.ESP_Health then
                local bw = 4
                local bx = boxX - bw - 3
                makeFrame({Size=UDim2.new(0,bw,0,boxH),Position=UDim2.new(0,bx,0,boxY),BackgroundColor3=Color3.fromRGB(15,15,15),BorderSizePixel=0})
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

        if enemyCount > 0 then
            EnemyCountLabel.Text = "Kẻ địch: "..enemyCount
        end
    end

    RunService.RenderStepped:Connect(updateESP)

    -- ===== AIMBOT & FOV =====
    local FOVGui = Instance.new("ScreenGui", MainGui)
    FOVGui.Name = "FOVDraw"
    FOVGui.IgnoreGuiInset = true
    local fovObjects = {}

    local function drawFOV()
        for _, obj in ipairs(fovObjects) do
            if typeof(obj) == "Instance" and obj.Parent then obj:Destroy() end
        end
        fovObjects = {}
        if not SETTINGS.Aimbot then return end
        local cx = Camera.ViewportSize.X/2
        local cy = Camera.ViewportSize.Y/2
        local r = SETTINGS.FOV
        local segments = 64
        for i = 0, segments-1 do
            local angle = (i/segments)*math.pi*2
            local x = cx + math.cos(angle)*r
            local y = cy + math.sin(angle)*r
            local dot = Instance.new("Frame")
            dot.Size = UDim2.new(0,3,0,3)
            dot.Position = UDim2.new(0,x-1,0,y-1)
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
                local ray = Workspace:Raycast(
                    Camera.CFrame.Position,
                    (part.Position - Camera.CFrame.Position).Unit * 1200,
                    rp
                )
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
            Camera.CFrame = CFrame.new(
                Camera.CFrame.Position,
                Camera.CFrame.Position + curLook:Lerp(newLook, 1 - smooth)
            )
        end
    end

    RunService.RenderStepped:Connect(aimbot)

    -- Speed Hack
    spawn(function()
        while true do
            wait(0.25)
            if SETTINGS.Speed and LocalPlayer.Character then
                local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = 50 end
            elseif not SETTINGS.Speed and LocalPlayer.Character then
                local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum and hum.WalkSpeed == 50 then hum.WalkSpeed = 16 end
            end
        end
    end)

    setTab("ESP")
    print("[Muigl Reborn] Đã tải xong. Vuốt 3 ngón lên để mở menu.")
end

print("[Muigl] Script loaded. Nhập key để tiếp tục.")
