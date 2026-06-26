--[[
    Script Hack Roblox - Muigl Ultra (Fix mượt, giao diện rộng, tab ngang)
    - Menu kích hoạt 3 ngón: mở/tắt linh hoạt, không kẹt.
    - Key: khanhhuy
    - Giao diện rộng (520x420), chia tab: ESP | Aimbot | Visuals | Other
    - Tất cả chức năng hiển thị đầy đủ, không mất tên.
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

-- ===== CẤU HÌNH =====
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

function loadMain()
    local MainGui = Instance.new("ScreenGui")
    MainGui.Name = "MuiglUltra"
    MainGui.ResetOnSpawn = false
    MainGui.Parent = LocalPlayer.PlayerGui

    -- Overlay nền tối
    local Overlay = Instance.new("TextButton", MainGui)
    Overlay.Size = UDim2.new(1,0,1,0)
    Overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
    Overlay.BackgroundTransparency = 0.5
    Overlay.Text = ""
    Overlay.ZIndex = 50
    Overlay.Visible = false

    -- Nút FAB nổi
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

    -- Menu chính (rộng 520, cao 420)
    local Menu = Instance.new("Frame", MainGui)
    Menu.Size = UDim2.new(0,520,0,420)
    Menu.Position = UDim2.new(0.5,-260,1,0)
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
    TitleText.Text = "⚡ MUIGL ULTRA ⚡"
    TitleText.TextColor3 = Color3.fromRGB(0,255,255)
    TitleText.Font = Enum.Font.GothamBlack
    TitleText.TextSize = 20
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

    -- Tab bar ngang
    local TabBar = Instance.new("Frame", Menu)
    TabBar.Size = UDim2.new(1,-10,0,38)
    TabBar.Position = UDim2.new(0,5,0,45)
    TabBar.BackgroundTransparency = 1
    TabBar.ZIndex = 90

    -- Tab content container
    local ContentContainer = Instance.new("Frame", Menu)
    ContentContainer.Size = UDim2.new(1,-20,1,-90)
    ContentContainer.Position = UDim2.new(0,10,0,88)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.ZIndex = 89

    -- Tạo các content frame cho từng tab
    local ContentFrames = {}
    for _, name in ipairs({"ESP", "Aimbot", "Visuals", "Other"}) do
        local frame = Instance.new("Frame", ContentContainer)
        frame.Size = UDim2.new(1,0,1,0)
        frame.BackgroundTransparency = 1
        frame.Visible = false
        frame.ZIndex = 90
        ContentFrames[name] = frame
    end
    ContentFrames["ESP"].Visible = true -- mặc định tab ESP

    -- Tạo tab button (ngang)
    local tabBtns = {}
    local tabNames = {"ESP", "Aimbot", "Visuals", "Other"}
    local selectedTab = "ESP"

    local function setTab(tab)
        selectedTab = tab
        for _, btn in ipairs(tabBtns) do
            btn.BackgroundColor3 = btn.Name == tab and Color3.fromRGB(0,140,255) or Color3.fromRGB(60,60,60)
        end
        for _, frame in pairs(ContentFrames) do
            frame.Visible = false
        end
        ContentFrames[tab].Visible = true
    end

    for i, tabName in ipairs(tabNames) do
        local btn = Instance.new("TextButton", TabBar)
        btn.Name = tabName
        btn.Size = UDim2.new(0,110,1,0)
        btn.Position = UDim2.new(0,(i-1)*120,0,0)
        btn.BackgroundColor3 = tabName == "ESP" and Color3.fromRGB(0,140,255) or Color3.fromRGB(60,60,60)
        btn.Text = tabName
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 14
        btn.BorderSizePixel = 0
        btn.ZIndex = 91
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
        btn.MouseButton1Click:Connect(function() setTab(tabName) end)
        table.insert(tabBtns, btn)
    end

    -- Hàm tạo toggle (nằm trong content frame)
    local function addToggle(parent, name, default, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1,0,0,32)
        frame.BackgroundTransparency = 1
        frame.ZIndex = 92

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(0.65,0,1,0)
        label.Text = name
        label.TextColor3 = Color3.fromRGB(220,220,220)
        label.Font = Enum.Font.Gotham
        label.TextSize = 13
        label.BackgroundTransparency = 1
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.ZIndex = 92

        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(0,44,0,20)
        btn.Position = UDim2.new(0.75,0,0.5,-10)
        btn.BackgroundColor3 = default and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
        btn.Text = default and "ON" or "OFF"
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.BorderSizePixel = 0
        btn.ZIndex = 93
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

        local state = default
        btn.MouseButton1Click:Connect(function()
            state = not state
            btn.BackgroundColor3 = state and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
            btn.Text = state and "ON" or "OFF"
            callback(state)
        end)

        -- Thêm vào parent
        local y = 10
        for _, child in ipairs(parent:GetChildren()) do
            if child:IsA("Frame") then
                y = y + child.Size.Y.Offset + 6
            end
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

    -- FOV slider
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
    local y = 10
    for _, child in ipairs(aimTab:GetChildren()) do
        if child:IsA("Frame") then y = y + child.Size.Y.Offset + 6 end
    end
    fovFrame.Position = UDim2.new(0,10,0,y)
    fovFrame.Parent = aimTab

    -- Smoothness slider
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
    local y2 = 10
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
    local y3 = 10
    for _, child in ipairs(aimTab:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextButton") then y3 = y3 + child.Size.Y.Offset + 6 end
    end
    partBtn.Position = UDim2.new(0,10,0,y3)
    partBtn.Parent = aimTab

    -- Tab Visuals: chứa tùy chỉnh màu sắc (có thể để trống, thêm nếu cần)
    local visTab = ContentFrames["Visuals"]
    addToggle(visTab, "FOV Circle", true, function(v) end) -- placeholder

    -- Tab Other
    local otherTab = ContentFrames["Other"]
    addToggle(otherTab, "Speed Hack", false, function(v) SETTINGS.Speed = v end)
    addToggle(otherTab, "Fly", false, function(v) SETTINGS.Fly = v end)

    -- Điều khiển đóng mở menu
    local menuOpen = false
    local openTween, closeTween
    local function toggleMenu()
        if openTween then openTween:Cancel() end
        if closeTween then closeTween:Cancel() end
        menuOpen = not menuOpen
        if menuOpen then
            Overlay.Visible = true
            Menu.Visible = true
            Fab.Visible = false
            Menu.Position = UDim2.new(0.5,-260,1,0)
            openTween = TweenService:Create(Menu, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5,-260,0.5,-210)})
            openTween:Play()
        else
            Fab.Visible = true
            closeTween = TweenService:Create(Menu, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5,-260,1,0)})
            closeTween:Play()
            closeTween.Completed:Connect(function()
                Menu.Visible = false
                Overlay.Visible = false
            end)
        end
    end

    Fab.MouseButton1Click:Connect(toggleMenu)
    CloseBtn.MouseButton1Click:Connect(toggleMenu)
    Overlay.MouseButton1Click:Connect(toggleMenu)

    -- Chạm 3 ngón (detect dễ dàng, không cần giữ)
    local activeTouches = {}
    UserInputService.TouchStarted:Connect(function(touch, processed)
        if processed then return end
        activeTouches[touch] = true
        if #activeTouches == 3 then
            toggleMenu()
            -- reset để không bị trigger liên tục
            activeTouches = {}
        end
    end)
    UserInputService.TouchEnded:Connect(function(touch, processed)
        if processed then return end
        activeTouches[touch] = nil
    end)

    -- ===== ESP =====
    local espDrawings = {}
    local function clearEspDrawings()
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
        clearEspDrawings()
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
            local boxW = boxH * 0.55
            local boxX = headPos.X - boxW/2
            local boxY = headPos.Y
            local dist = LocalPlayer.Character and LocalPlayer.Character.PrimaryPart and (LocalPlayer.Character.PrimaryPart.Position - root.Position).Magnitude or 0
            local hpPct = hum.Health / hum.MaxHealth

            if SETTINGS.ESP_Box then
                local outline = Drawing.new("Square")
                outline.Visible = true; outline.Position = Vector2.new(boxX, boxY); outline.Size = Vector2.new(boxW, boxH)
                outline.Thickness = 1.5; outline.Color = Color3.fromRGB(0,255,255); outline.Filled = false
                table.insert(espDrawings, outline)

                if SETTINGS.ESP_FillBox then
                    local fill = Drawing.new("Square")
                    fill.Visible = true; fill.Position = Vector2.new(boxX, boxY); fill.Size = Vector2.new(boxW, boxH)
                    fill.Thickness = 1; fill.Color = Color3.fromRGB(0,255,255); fill.Filled = true; fill.Transparency = 0.8
                    table.insert(espDrawings, fill)
                end
            end

            if SETTINGS.ESP_Tracer then
                local tracer = Drawing.new("Line")
                tracer.Visible = true; tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                tracer.To = Vector2.new(headPos.X, rootPos.Y)
                tracer.Thickness = 1; tracer.Color = Color3.fromRGB(255,255,255); tracer.Transparency = 0.3
                table.insert(espDrawings, tracer)
            end

            if SETTINGS.ESP_Name then
                local name = Drawing.new("Text")
                name.Visible = true; name.Text = player.Name; name.Position = Vector2.new(headPos.X, boxY - 18)
                name.Size = 12; name.Color = Color3.fromRGB(255,255,255); name.Font = 2; name.Center = true; name.Outline = true
                table.insert(espDrawings, name)
            end

            if SETTINGS.ESP_Health then
                local bw = 3; local bh = boxH; local bx = boxX - bw - 2; local by = boxY
                local bg = Drawing.new("Square")
                bg.Visible = true; bg.Position = Vector2.new(bx, by); bg.Size = Vector2.new(bw, bh)
                bg.Color = Color3.fromRGB(20,20,20); bg.Filled = true
                table.insert(espDrawings, bg)
                local fill = Drawing.new("Square")
                fill.Visible = true; fill.Position = Vector2.new(bx, by + (1-hpPct)*bh)
                fill.Size = Vector2.new(bw, hpPct*bh)
                fill.Color = Color3.fromHSV(hpPct*0.3, 1, 1); fill.Filled = true
                table.insert(espDrawings, fill)
            end

            if SETTINGS.ESP_Distance then
                local distText = Drawing.new("Text")
                distText.Visible = true; distText.Text = string.format("%.0fm", dist)
                distText.Position = Vector2.new(headPos.X, rootPos.Y + 8)
                distText.Size = 11; distText.Color = Color3.fromRGB(200,200,200); distText.Font = 2; distText.Center = true; distText.Outline = true
                table.insert(espDrawings, distText)
            end
        end
    end

    RunService.RenderStepped:Connect(updateESP)

    -- ===== AIMBOT + FOV =====
    local fovLines = {}
    local function drawFOV()
        for _, l in ipairs(fovLines) do l:Remove() end
        fovLines = {}
        if not SETTINGS.Aimbot then return end
        local cx, cy = Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2
        local r = SETTINGS.FOV
        local segments = 64
        for i = 0, segments-1 do
            local a1 = (i/segments) * math.pi * 2
            local a2 = ((i+1)/segments) * math.pi * 2
            local line = Drawing.new("Line")
            line.Visible = true
            line.From = Vector2.new(cx + math.cos(a1)*r, cy + math.sin(a1)*r)
            line.To = Vector2.new(cx + math.cos(a2)*r, cy + math.sin(a2)*r)
            line.Color = Color3.fromRGB(255,255,255)
            line.Thickness = 1
            line.Transparency = 0.5
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

    -- Speed & Fly
    spawn(function() while wait(0.3) do if SETTINGS.Speed and LocalPlayer.Character then local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid") if hum then hum.WalkSpeed = 50 end end end end)

    spawn(function()
        local flyConn
        while wait(0.3) do
            if SETTINGS.Fly and LocalPlayer.Character then
                if not flyConn then
                    local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if root then
                        local bg = Instance.new("BodyGyro", root); bg.MaxTorque = Vector3.new(9e9,9e9,9e9); bg.D = 100; bg.P = 3000
                        local bv = Instance.new("BodyVelocity", root); bv.MaxForce = Vector3.new(9e9,9e9,9e9); bv.Velocity = Vector3.zero
                        flyConn = {gyro = bg, vel = bv}
                        flyConn.heart = RunService.Heartbeat:Connect(function()
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
            else
                if flyConn then flyConn.heart:Disconnect(); flyConn.gyro:Destroy(); flyConn.vel:Destroy(); flyConn = nil end
            end
        end
    end)

    print("Muigl Ultra đã sẵn sàng. Chạm 3 ngón hoặc FAB để mở menu.")
end

print("Script đã load. Nhập key để bắt đầu.")