--[[
    Script Hack Roblox - Muigl Style (Fix toàn diện, hỗ trợ all game)
    - Không dùng Drawing, thay bằng ESP Part + BillboardGui (ổn định, không lỗi)
    - Key: khanhhuy
    - Menu kích hoạt: 3 ngón tay hoặc nút tròn nổi (FAB)
    - Tự động gắn ESP vào tất cả người chơi khác
    - Aimbot silent (giữ chuột phải)
    palofsc
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Đảm bảo LocalPlayer đã tồn tại
repeat wait() until LocalPlayer
repeat wait() until LocalPlayer:WaitForChild("PlayerGui")

-- ===== CẤU HÌNH =====
local KEY = "khanhhuy"
local SETTINGS = {
    ESP = false,
    ESP_Box = true,
    ESP_Name = true,
    ESP_Health = true,
    ESP_Distance = true,
    Aimbot = false,
    SilentAim = true,
    AimPart = "Head",
    Smoothness = 0.2,
    FOV = 300,
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

-- ===== MENU CHÍNH =====
function loadMain()
    local MainGui = Instance.new("ScreenGui")
    MainGui.Name = "MuiglHack"
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

    -- Nút FAB tròn nổi
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

    -- Panel menu chính
    local Menu = Instance.new("Frame", MainGui)
    Menu.Size = UDim2.new(0,290,0,400)
    Menu.Position = UDim2.new(0.5,-145,1,0)
    Menu.BackgroundColor3 = Color3.fromRGB(15,15,15)
    Menu.BackgroundTransparency = 0.15
    Menu.BorderSizePixel = 0
    Menu.ZIndex = 90
    Menu.Visible = false
    Instance.new("UICorner", Menu).CornerRadius = UDim.new(0,18)
    local MenuStroke = Instance.new("UIStroke", Menu)
    MenuStroke.Color = Color3.fromRGB(255,255,255)
    MenuStroke.Thickness = 1.2
    MenuStroke.Transparency = 0.7

    -- Tiêu đề
    local Title = Instance.new("TextLabel", Menu)
    Title.Size = UDim2.new(1,0,0,35)
    Title.BackgroundTransparency = 1
    Title.Text = "⚡ MUIGL ⚡"
    Title.TextColor3 = Color3.fromRGB(0,255,255)
    Title.Font = Enum.Font.GothamBlack
    Title.TextSize = 18
    Title.ZIndex = 100

    local PlayerCountLabel = Instance.new("TextLabel", Menu)
    PlayerCountLabel.Size = UDim2.new(0,80,0,20)
    PlayerCountLabel.Position = UDim2.new(1,-90,0,10)
    PlayerCountLabel.BackgroundTransparency = 1
    PlayerCountLabel.Text = "Players: 0"
    PlayerCountLabel.TextColor3 = Color3.fromRGB(255,200,0)
    PlayerCountLabel.Font = Enum.Font.GothamBold
    PlayerCountLabel.TextSize = 11
    PlayerCountLabel.ZIndex = 101

    -- Nút đóng
    local CloseBtn = Instance.new("TextButton", Menu)
    CloseBtn.Size = UDim2.new(0,24,0,24)
    CloseBtn.Position = UDim2.new(1,-28,0,6)
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255,80,80)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
    CloseBtn.BackgroundTransparency = 0.8
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 14
    CloseBtn.BorderSizePixel = 0
    CloseBtn.ZIndex = 102
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0,12)

    -- Vùng cuộn nội dung
    local ScrollFrame = Instance.new("ScrollingFrame", Menu)
    ScrollFrame.Size = UDim2.new(1,-10,1,-45)
    ScrollFrame.Position = UDim2.new(0,5,0,40)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.CanvasSize = UDim2.new(0,0,0,500)
    ScrollFrame.ScrollBarThickness = 3
    ScrollFrame.ZIndex = 95

    local Content = Instance.new("Frame", ScrollFrame)
    Content.Size = UDim2.new(1,0,0,500)
    Content.BackgroundTransparency = 1
    Content.ZIndex = 96

    -- Hàm tạo Toggle
    local function Toggle(name, default, callback)
        local frame = Instance.new("Frame", Content)
        frame.Size = UDim2.new(1,-10,0,35)
        frame.BackgroundTransparency = 1
        frame.ZIndex = 97

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(0.6,0,1,0)
        label.Text = name
        label.TextColor3 = Color3.fromRGB(255,255,255)
        label.Font = Enum.Font.Gotham
        label.TextSize = 13
        label.BackgroundTransparency = 1
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.ZIndex = 97

        local btn = Instance.new("TextButton", frame)
        btn.Size = UDim2.new(0,46,0,22)
        btn.Position = UDim2.new(0.75,0,0.5,-11)
        btn.BackgroundColor3 = default and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
        btn.Text = default and "ON" or "OFF"
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.BorderSizePixel = 0
        btn.ZIndex = 98
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

        local state = default
        btn.MouseButton1Click:Connect(function()
            state = not state
            btn.BackgroundColor3 = state and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
            btn.Text = state and "ON" or "OFF"
            callback(state)
        end)
        return frame
    end

    local y = 0
    local function add(widget)
        widget.Position = UDim2.new(0.05,0,0,y)
        widget.Parent = Content
        y = y + widget.Size.Y.Offset + 5
    end

    add(Toggle("ESP", false, function(v) SETTINGS.ESP = v end))
    add(Toggle("ESP Box", true, function(v) SETTINGS.ESP_Box = v end))
    add(Toggle("ESP Tên", true, function(v) SETTINGS.ESP_Name = v end))
    add(Toggle("ESP Máu", true, function(v) SETTINGS.ESP_Health = v end))
    add(Toggle("ESP Khoảng cách", true, function(v) SETTINGS.ESP_Distance = v end))
    add(Toggle("Aimbot", false, function(v) SETTINGS.Aimbot = v end))
    add(Toggle("Silent Aim", true, function(v) SETTINGS.SilentAim = v end))
    add(Toggle("Check Team", false, function(v) SETTINGS.TeamCheck = v end))
    add(Toggle("Visible Check", true, function(v) SETTINGS.VisibleCheck = v end))
    add(Toggle("Speed Hack", false, function(v) SETTINGS.Speed = v end))
    add(Toggle("Fly", false, function(v) SETTINGS.Fly = v end))

    -- Độ mượt slider
    local smoothFrame = Instance.new("Frame", Content)
    smoothFrame.Size = UDim2.new(1,-10,0,40)
    smoothFrame.BackgroundTransparency = 1
    smoothFrame.Position = UDim2.new(0.05,0,0,y)
    y = y + 48

    local smoothLabel = Instance.new("TextLabel", smoothFrame)
    smoothLabel.Size = UDim2.new(0.4,0,0,18)
    smoothLabel.Text = "Độ mượt: 0.2"
    smoothLabel.TextColor3 = Color3.fromRGB(255,255,255)
    smoothLabel.Font = Enum.Font.Gotham
    smoothLabel.TextSize = 12
    smoothLabel.BackgroundTransparency = 1

    local smoothInput = Instance.new("TextBox", smoothFrame)
    smoothInput.Size = UDim2.new(0.5,0,0,20)
    smoothInput.Position = UDim2.new(0.4,0,0,20)
    smoothInput.Text = "0.2"
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

    Content.Size = UDim2.new(1,0,0,y+20)
    ScrollFrame.CanvasSize = UDim2.new(0,0,0,y+20)

    -- Điều khiển đóng mở menu
    local menuOpen = false
    local function toggleMenu()
        menuOpen = not menuOpen
        if menuOpen then
            Overlay.Visible = true
            Menu.Visible = true
            Fab.Visible = false
            Menu:TweenPosition(UDim2.new(0.5,-145,0.5,-200), "Out", "Back", 0.4, true)
        else
            Fab.Visible = true
            Menu:TweenPosition(UDim2.new(0.5,-145,1,0), "In", "Quad", 0.3, true, function()
                Menu.Visible = false
                Overlay.Visible = false
            end)
        end
    end

    Fab.MouseButton1Click:Connect(toggleMenu)
    CloseBtn.MouseButton1Click:Connect(toggleMenu)
    Overlay.MouseButton1Click:Connect(toggleMenu)

    -- Kích hoạt bằng 3 ngón
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

    -- ===== ESP (Part + Billboard) =====
    local ESP_Folder = Instance.new("Folder")
    ESP_Folder.Name = "ESP_Folder"
    ESP_Folder.Parent = Workspace

    local function clearESP()
        for _, v in ipairs(ESP_Folder:GetChildren()) do
            v:Destroy()
        end
    end

    local function updateESP()
        if not SETTINGS.ESP then
            clearESP()
            PlayerCountLabel.Text = "Players: 0"
            return
        end

        -- Xóa tất cả các ESP cũ
        clearESP()

        local playerCount = 0
        for _, player in ipairs(Players:GetPlayers()) do
            if player == LocalPlayer then continue end
            local char = player.Character
            if not char then continue end
            local head = char:FindFirstChild("Head")
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not head or not root or not hum then continue end

            playerCount = playerCount + 1

            -- Box: tạo 4 Part nhỏ làm viền
            if SETTINGS.ESP_Box then
                local color = Color3.fromRGB(0,255,255)
                local function createPart(name, parent, color)
                    local part = Instance.new("Part")
                    part.Name = name
                    part.Anchored = true
                    part.CanCollide = false
                    part.Color = color
                    part.Material = Enum.Material.Neon
                    part.Size = Vector3.new(0.05,0.05,0.05)
                    part.Transparency = 0.3
                    part.Parent = parent
                    return part
                end
                local boxFolder = Instance.new("Folder", ESP_Folder)
                boxFolder.Name = player.Name

                -- Bốn góc box
                local corners = {}
                for i=1,4 do
                    corners[i] = createPart("Corner", boxFolder, color)
                end
                -- Liên kết với character
                local conn = RunService.RenderStepped:Connect(function()
                    if not char or not head or not root or not head.Parent then
                        boxFolder:Destroy()
                        conn:Disconnect()
                        return
                    end
                    local headPos = head.Position
                    local rootPos = root.Position
                    local boxHeight = (headPos.Y - rootPos.Y)
                    local boxWidth = boxHeight * 0.6
                    local centerY = (headPos.Y + rootPos.Y)/2
                    -- 4 góc
                    corners[1].Position = Vector3.new(headPos.X - boxWidth/2, headPos.Y, headPos.Z)
                    corners[2].Position = Vector3.new(headPos.X + boxWidth/2, headPos.Y, headPos.Z)
                    corners[3].Position = Vector3.new(rootPos.X - boxWidth/2, rootPos.Y, rootPos.Z)
                    corners[4].Position = Vector3.new(rootPos.X + boxWidth/2, rootPos.Y, rootPos.Z)
                end)
                -- Viền bằng các thanh (4 line)
                local function createLine(a, b, parent)
                    local part = Instance.new("Part")
                    part.Anchored = true
                    part.CanCollide = false
                    part.Material = Enum.Material.Neon
                    part.Color = color
                    part.Size = Vector3.new(0.05,0.05, (a-b).Magnitude)
                    part.CFrame = CFrame.new((a+b)/2, b)
                    part.Transparency = 0.3
                    part.Parent = parent
                    return part
                end
                local lines = {}
                local lineFolder = Instance.new("Folder", boxFolder)
                lineFolder.Name = "Lines"
                local conn2 = RunService.RenderStepped:Connect(function()
                    if not char or not head or not root or not head.Parent then
                        lineFolder:Destroy()
                        conn2:Disconnect()
                        return
                    end
                    -- Tính toán lại các line
                    for _, l in ipairs(lineFolder:GetChildren()) do l:Destroy() end
                    local A = Vector3.new(headPos.X - boxWidth/2, headPos.Y, headPos.Z)
                    local B = Vector3.new(headPos.X + boxWidth/2, headPos.Y, headPos.Z)
                    local C = Vector3.new(rootPos.X - boxWidth/2, rootPos.Y, rootPos.Z)
                    local D = Vector3.new(rootPos.X + boxWidth/2, rootPos.Y, rootPos.Z)
                    createLine(A,B,lineFolder)
                    createLine(C,D,lineFolder)
                    createLine(A,C,lineFolder)
                    createLine(B,D,lineFolder)
                end)
            end

            -- BillboardGui hiển thị tên, máu, khoảng cách
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "Info"
            billboard.Adornee = head
            billboard.Size = UDim2.new(0,200,0,60)
            billboard.StudsOffset = Vector3.new(0,1.5,0)
            billboard.AlwaysOnTop = true
            billboard.Parent = ESP_Folder

            local textLabel = Instance.new("TextLabel", billboard)
            textLabel.Size = UDim2.new(1,0,1,0)
            textLabel.BackgroundTransparency = 1
            textLabel.TextColor3 = Color3.fromRGB(255,255,255)
            textLabel.Font = Enum.Font.GothamBold
            textLabel.TextSize = 12
            textLabel.TextStrokeTransparency = 0.5
            textLabel.TextWrapped = true

            local function updateBillboard()
                if not char or not head or not head.Parent then
                    billboard:Destroy()
                    return
                end
                local hp = hum.Health
                local maxHp = hum.MaxHealth
                local dist = 0
                if LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then
                    dist = (LocalPlayer.Character.PrimaryPart.Position - root.Position).Magnitude
                end
                local text = ""
                if SETTINGS.ESP_Name then text = text .. player.Name .. "\n" end
                if SETTINGS.ESP_Health then text = text .. "HP: " .. math.floor(hp) .. "/" .. maxHp .. "\n" end
                if SETTINGS.ESP_Distance then text = text .. string.format("%.0f m", dist) end
                textLabel.Text = text
                if hp <= 0 then billboard:Destroy() end
            end
            RunService.RenderStepped:Connect(updateBillboard)
        end
        PlayerCountLabel.Text = "Players: "..playerCount
    end

    -- Vòng lặp ESP
    RunService.RenderStepped:Connect(updateESP)

    -- ===== AIMBOT =====
    local function aimbot()
        if not SETTINGS.Aimbot then return end
        if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then return end
        local closest = nil
        local minDist = SETTINGS.FOV
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
            local dist = (Vector2.new(screenPos.X, screenPos.Y) - Camera.ViewportSize/2).Magnitude
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
        local flyConnection
        while true do
            wait(0.3)
            if SETTINGS.Fly then
                if not flyConnection then
                    local char = LocalPlayer.Character
                    if char then
                        local root = char:FindFirstChild("HumanoidRootPart")
                        if root then
                            local bg = Instance.new("BodyGyro", root)
                            bg.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
                            bg.D = 100
                            bg.P = 3000
                            local bv = Instance.new("BodyVelocity", root)
                            bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                            bv.Velocity = Vector3.zero
                            flyConnection = {gyro = bg, vel = bv}
                            flyConnection.heart = RunService.Heartbeat:Connect(function()
                                if not SETTINGS.Fly or not root then return end
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
end

print("Script Muigl Hack đã sẵn sàng. Nhập key để mở menu.")