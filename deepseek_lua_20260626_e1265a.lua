--[[
    Script Hack Roblox - Muigl Reborn (Complete Overhaul)
    Key: khanhhuy
    Giao diện đẹp, menu rộng, tab ngang.
    ESP box to, tracer, name, health, distance.
    Aimbot mượt, có FOV circle, tùy chỉnh.
    Fly, Speed hoạt động ổn định.
    Mở menu: chạm 3 ngón hoặc FAB, tắt menu: nút X hoặc chạm 3 ngón (overlay không tắt).
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
    ESP_FillBox = false,
    Aimbot = false,
    SilentAim = true,
    AimPart = "Head",
    Smoothness = 0.15,
    FOV = 200,
    TeamCheck = false,
    VisibleCheck = true,
    Speed = false,
    Fly = false
}

-- ===== KEY SYSTEM (ĐẸP) =====
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
KeyFrame.BackgroundColor3 = Color3.fromRGB(18,18,18)
KeyFrame.BorderSizePixel = 0
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0,16)
local KeyStroke = Instance.new("UIStroke", KeyFrame)
KeyStroke.Color = Color3.fromRGB(255,200,0)
KeyStroke.Thickness = 2

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1,0,0,40)
KeyTitle.BackgroundColor3 = Color3.fromRGB(25,25,25)
KeyTitle.Text = "🔐 ĐĂNG NHẬP"
KeyTitle.TextColor3 = Color3.fromRGB(255,215,0)
KeyTitle.Font = Enum.Font.GothamBlack
KeyTitle.TextSize = 18
Instance.new("UICorner", KeyTitle).CornerRadius = UDim.new(0,16)

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(1,-30,0,36)
KeyInput.Position = UDim2.new(0,15,0,55)
KeyInput.PlaceholderText = "Nhập key..."
KeyInput.Text = ""
KeyInput.BackgroundColor3 = Color3.fromRGB(30,30,30)
KeyInput.TextColor3 = Color3.fromRGB(255,255,255)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 15
KeyInput.BorderSizePixel = 0
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0,10)

local KeySubmit = Instance.new("TextButton", KeyFrame)
KeySubmit.Size = UDim2.new(0,100,0,36)
KeySubmit.Position = UDim2.new(0.5,-50,0,115)
KeySubmit.Text = "MỞ KHÓA"
KeySubmit.BackgroundColor3 = Color3.fromRGB(0,180,0)
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
    -- ===== MAIN GUI =====
    local MainGui = Instance.new("ScreenGui")
    MainGui.Name = "MuiglReborn"
    MainGui.ResetOnSpawn = false
    MainGui.Parent = LocalPlayer.PlayerGui

    -- FAB
    local Fab = Instance.new("TextButton", MainGui)
    Fab.Size = UDim2.new(0,60,0,60)
    Fab.Position = UDim2.new(1,-75,1,-75)
    Fab.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Fab.BackgroundTransparency = 0.25
    Fab.Text = "+"
    Fab.TextColor3 = Color3.fromRGB(255,255,255)
    Fab.Font = Enum.Font.GothamBlack
    Fab.TextSize = 30
    Fab.BorderSizePixel = 0
    Fab.ZIndex = 200
    Instance.new("UICorner", Fab).CornerRadius = UDim.new(1,0)
    local FabStroke = Instance.new("UIStroke", Fab)
    FabStroke.Color = Color3.fromRGB(255,255,255)
    FabStroke.Thickness = 2
    FabStroke.Transparency = 0.3

    -- Menu chính
    local Menu = Instance.new("Frame", MainGui)
    Menu.Size = UDim2.new(0,540,0,440)
    Menu.Position = UDim2.new(0.5,-270,1,0)
    Menu.BackgroundColor3 = Color3.fromRGB(12,12,12)
    Menu.BackgroundTransparency = 0.08
    Menu.BorderSizePixel = 0
    Menu.ZIndex = 150
    Menu.Visible = false
    Instance.new("UICorner", Menu).CornerRadius = UDim.new(0,18)
    local MenuStroke = Instance.new("UIStroke", Menu)
    MenuStroke.Color = Color3.fromRGB(255,255,255)
    MenuStroke.Thickness = 1.3
    MenuStroke.Transparency = 0.5

    -- Tiêu đề
    local TitleBar = Instance.new("Frame", Menu)
    TitleBar.Size = UDim2.new(1,0,0,45)
    TitleBar.BackgroundColor3 = Color3.fromRGB(22,22,22)
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

    -- Nút X
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

    -- Tab bar (ngang)
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

    -- Các tab nội dung
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
            btn.BackgroundColor3 = btn.Name == tab and Color3.fromRGB(0,160,255) or Color3.fromRGB(60,60,60)
        end
        for _, f in pairs(ContentFrames) do f.Visible = false end
        ContentFrames[tab].Visible = true
    end

    for i, tabName in ipairs(Tabs) do
        local btn = Instance.new("TextButton", TabBar)
        btn.Name = tabName
        btn.Size = UDim2.new(0,115,1,0)
        btn.Position = UDim2.new(0,(i-1)*125,0,0)
        btn.BackgroundColor3 = tabName == "ESP" and Color3.fromRGB(0,160,255) or Color3.fromRGB(60,60,60)
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

    -- Widget: Toggle
    local function addToggle(parent, name, default, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1,0,0,34)
        frame.BackgroundTransparency = 1
        frame.ZIndex = 141
        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(0.65,0,1,0)
        label.Text = name
        label.TextColor3 = Color3.fromRGB(230,230,230)
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
            if child:IsA("Frame") then y = y + child.Size.Y.Offset + 6 end
        end
        frame.Position = UDim2.new(0,10,0,y)
        frame.Parent = parent
        return frame
    end

    -- Điền nội dung tab ESP
    local espTab = ContentFrames["ESP"]
    addToggle(espTab, "Bật ESP", false, function(v) SETTINGS.ESP = v end)
    addToggle(espTab, "Box", true, function(v) SETTINGS.ESP_Box = v end)
    addToggle(espTab, "Fill Box", false, function(v) SETTINGS.ESP_FillBox = v end)
    addToggle(espTab, "Tracer (Tia)", true, function(v) SETTINGS.ESP_Tracer = v end)
    addToggle(espTab, "Tên", true, function(v) SETTINGS.ESP_Name = v end)
    addToggle(espTab, "Máu", true, function(v) SETTINGS.ESP_Health = v end)
    addToggle(espTab, "Khoảng cách", true, function(v) SETTINGS.ESP_Distance = v end)

    -- Tab Aimbot
    local aimTab = ContentFrames["Aimbot"]
    addToggle(aimTab, "Bật Aimbot", false, function(v) SETTINGS.Aimbot = v end)
    addToggle(aimTab, "Silent Aim", true, function(v) SETTINGS.SilentAim = v end)
    addToggle(aimTab, "Check Team", false, function(v) SETTINGS.TeamCheck = v end)
    addToggle(aimTab, "Visible Check", true, function(v) SETTINGS.VisibleCheck = v end)

    -- Slider FOV
    local fovFrame = Instance.new("Frame")
    fovFrame.Size = UDim2.new(1,0,0,42)
    fovFrame.BackgroundTransparency = 1
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
    local y1 = 8
    for _, child in ipairs(aimTab:GetChildren()) do
        if child:IsA("Frame") then y1 = y1 + child.Size.Y.Offset + 6 end
    end
    fovFrame.Position = UDim2.new(0,10,0,y1)
    fovFrame.Parent = aimTab

    -- Slider Smoothness
    local smoothFrame = Instance.new("Frame")
    smoothFrame.Size = UDim2.new(1,0,0,42)
    smoothFrame.BackgroundTransparency = 1
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
    local y2 = 8
    for _, child in ipairs(aimTab:GetChildren()) do
        if child:IsA("Frame") then y2 = y2 + child.Size.Y.Offset + 6 end
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

    -- Tab Visuals (có thể để trống)
    local visTab = ContentFrames["Visuals"]
    addToggle(visTab, "FOV Circle", true, function(v) end) -- placeholder

    -- Tab Other
    local otherTab = ContentFrames["Other"]
    addToggle(otherTab, "Speed Hack", false, function(v) SETTINGS.Speed = v end)
    addToggle(otherTab, "Fly", false, function(v) SETTINGS.Fly = v end)

    -- ===== ĐIỀU KHIỂN MENU =====
    local menuOpen = false
    local openTween, closeTween
    local function toggleMenu()
        if openTween then openTween:Cancel() end
        if closeTween then closeTween:Cancel() end
        menuOpen = not menuOpen
        if menuOpen then
            Menu.Visible = true
            Fab.Visible = false
            Menu.Position = UDim2.new(0.5,-270,1,0)
            openTween = TweenService:Create(Menu, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5,-270,0.5,-220)})
            openTween:Play()
        else
            Fab.Visible = true
            closeTween = TweenService:Create(Menu, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5,-270,1,0)})
            closeTween:Play()
            closeTween.Completed:Connect(function()
                Menu.Visible = false
            end)
        end
    end

    Fab.MouseButton1Click:Connect(toggleMenu)
    CloseBtn.MouseButton1Click:Connect(toggleMenu)

    -- Chạm 3 ngón (cải thiện)
    local activeTouches = {}
    UserInputService.TouchStarted:Connect(function(touch, processed)
        if processed then return end
        activeTouches[touch] = true
        local count = 0
        for _, _ in pairs(activeTouches) do count = count + 1 end
        if count == 3 then
            toggleMenu()
            activeTouches = {} -- reset
        end
    end)
    UserInputService.TouchEnded:Connect(function(touch, processed)
        if processed then return end
        activeTouches[touch] = nil
    end)

    -- ===== ESP (Drawing) =====
    local espDrawings = {}
    local function clearESP()
        for _, d in ipairs(espDrawings) do
            if type(d) == "table" then
                for _, v in pairs(d) do v:Remove() end
            else
                d:Remove()
            end
        end
        espDrawings = {}
    end

    local function updateESP()
        clearESP()
        if not SETTINGS.ESP then return end

        for _, player in ipairs(Players:GetPlayers()) do
            if player == LocalPlayer then continue end
            local char = player.Character
            if not char then continue end
            local head = char:FindFirstChild("Head")
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not head or not root or not hum or hum.Health <= 0 then continue end

            local headPos, headVis = Camera:WorldToViewportPoint(head.Position)
            local rootPos, rootVis = Camera:WorldToViewportPoint(root.Position)
            if not headVis or not rootVis then continue end

            local boxH = math.abs(headPos.Y - rootPos.Y)
            local boxW = boxH * 0.65  -- to hơn một chút
            local boxX = headPos.X - boxW/2
            local boxY = headPos.Y
            local dist = LocalPlayer.Character and LocalPlayer.Character.PrimaryPart and (LocalPlayer.Character.PrimaryPart.Position - root.Position).Magnitude or 0
            local hpPct = hum.Health / hum.MaxHealth

            -- Box
            if SETTINGS.ESP_Box then
                local outline = Drawing.new("Square")
                outline.Visible = true
                outline.Position = Vector2.new(boxX, boxY)
                outline.Size = Vector2.new(boxW, boxH)
                outline.Thickness = 2
                outline.Color = Color3.fromRGB(0,255,255)
                outline.Filled = false
                table.insert(espDrawings, outline)

                if SETTINGS.ESP_FillBox then
                    local fill = Drawing.new("Square")
                    fill.Visible = true
                    fill.Position = Vector2.new(boxX, boxY)
                    fill.Size = Vector2.new(boxW, boxH)
                    fill.Thickness = 1
                    fill.Color = Color3.fromRGB(0,255,255)
                    fill.Filled = true
                    fill.Transparency = 0.85
                    table.insert(espDrawings, fill)
                end
            end

            -- Tracer
            if SETTINGS.ESP_Tracer then
                local tracer = Drawing.new("Line")
                tracer.Visible = true
                tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                tracer.To = Vector2.new(headPos.X, rootPos.Y)
                tracer.Thickness = 1.2
                tracer.Color = Color3.fromRGB(255,255,255)
                tracer.Transparency = 0.25
                table.insert(espDrawings, tracer)
            end

            -- Name
            if SETTINGS.ESP_Name then
                local name = Drawing.new("Text")
                name.Visible = true
                name.Text = player.Name
                name.Position = Vector2.new(headPos.X, boxY - 20)
                name.Size = 13
                name.Color = Color3.fromRGB(255,255,255)
                name.Font = 2
                name.Center = true
                name.Outline = true
                table.insert(espDrawings, name)
            end

            -- Health bar
            if SETTINGS.ESP_Health then
                local bw = 3
                local bh = boxH
                local bx = boxX - bw - 3
                local by = boxY
                local bg = Drawing.new("Square")
                bg.Visible = true
                bg.Position = Vector2.new(bx, by)
                bg.Size = Vector2.new(bw, bh)
                bg.Color = Color3.fromRGB(20,20,20)
                bg.Filled = true
                table.insert(espDrawings, bg)
                local fill = Drawing.new("Square")
                fill.Visible = true
                fill.Position = Vector2.new(bx, by + (1-hpPct)*bh)
                fill.Size = Vector2.new(bw, hpPct*bh)
                fill.Color = Color3.fromHSV(hpPct*0.3, 1, 1)
                fill.Filled = true
                table.insert(espDrawings, fill)
            end

            -- Distance
            if SETTINGS.ESP_Distance then
                local distText = Drawing.new("Text")
                distText.Visible = true
                distText.Text = string.format("%.0fm", dist)
                distText.Position = Vector2.new(headPos.X, rootPos.Y + 10)
                distText.Size = 12
                distText.Color = Color3.fromRGB(200,200,200)
                distText.Font = 2
                distText.Center = true
                distText.Outline = true
                table.insert(espDrawings, distText)
            end
        end
    end

    RunService.RenderStepped:Connect(updateESP)

    -- ===== AIMBOT & FOV =====
    local fovLines = {}
    local function drawFOV()
        for _, l in ipairs(fovLines) do l:Remove() end
        fovLines = {}
        if not SETTINGS.Aimbot then return end
        local cx, cy = Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2
        local r = SETTINGS.FOV
        local segments = 72
        for i = 0, segments-1 do
            local a1 = (i/segments) * math.pi * 2
            local a2 = ((i+1)/segments) * math.pi * 2
            local line = Drawing.new("Line")
            line.Visible = true
            line.From = Vector2.new(cx + math.cos(a1)*r, cy + math.sin(a1)*r)
            line.To = Vector2.new(cx + math.cos(a2)*r, cy + math.sin(a2)*r)
            line.Color = Color3.fromRGB(255,255,255)
            line.Thickness = 1
            line.Transparency = 0.4
            table.insert(fovLines, line)
        end
    end

    local function aimbot()
        if not SETTINGS.Aimbot then return end
        if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
            drawFOV()
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

    -- Fly (cải tiến)
    local flyObjects = nil
    spawn(function()
        while true do
            wait(0.5)
            if SETTINGS.Fly then
                if not flyObjects and LocalPlayer.Character then
                    local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if root then
                        local bg = Instance.new("BodyGyro")
                        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                        bg.D = 100
                        bg.P = 3000
                        bg.Parent = root
                        local bv = Instance.new("BodyVelocity")
                        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                        bv.Velocity = Vector3.zero
                        bv.Parent = root
                        flyObjects = {gyro = bg, vel = bv}
                        flyObjects.heart = RunService.Heartbeat:Connect(function()
                            if not SETTINGS.Fly or not root or not root.Parent then return end
                            local dir = Vector3.zero
                            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + Camera.CFrame.LookVector * 30 end
                            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - Camera.CFrame.LookVector * 30 end
                            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - Camera.CFrame.RightVector * 30 end
                            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + Camera.CFrame.RightVector * 30 end
                            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,30,0) end
                            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0,30,0) end
                            bg.CFrame = Camera.CFrame
                            bv.Velocity = dir
                        end)
                    end
                end
            else
                if flyObjects then
                    flyObjects.heart:Disconnect()
                    flyObjects.gyro:Destroy()
                    flyObjects.vel:Destroy()
                    flyObjects = nil
                end
            end
        end
    end)

    print("Muigl Reborn đã sẵn sàng. Nhấn FAB hoặc chạm 3 ngón để mở menu.")
end

print("Script đã load. Nhập key để tiếp tục.")