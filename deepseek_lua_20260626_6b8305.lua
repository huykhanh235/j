--[[
    ⚡ ESP Items + Players + Chests + Kill Aura + Teleport ⚡
    • Menu hiện đại, nút tròn di động, hiệu ứng mượt
    • ESP: Vật phẩm (thường/quý), Rương, Người chơi (tên, box, khoảng cách)
    • Kill Aura tự động đánh NPC gần nhất, tùy chỉnh tầm
    • Danh sách teleport đến vật phẩm/rương (có thể cuộn)
    • Phím RightControl ẩn/hiện menu, menu chính có thể cuộn
    • Hỗ trợ tất cả game (theo từ khóa thông minh)
    Yêu cầu: Executor hỗ trợ Drawing, TweenService
--]]

-- ==================== SERVICES ====================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ==================== TRẠNG THÁI ====================
local ESP_Enabled = true
local ItemESP = true
local ChestESP = true
local PlayerESP = true
local KillAuraEnabled = false
local KillAuraRange = 15
local MenuOpen = false
local listOpen = false

-- ==================== TỪ KHOÁ ====================
local preciousKeywords = {"legendary","mythic","epic","rare","gold","diamond","divine","exotic","special","crystal","ancient","phoenix","god","super","mega","ultimate","omega","rainbow","shiny","blessed","cursed","enchanted","heroic","ethereal","arcane"}
local itemKeywords = {"drop","loot","coin","gem","crystal","ore","wood","stone","fruit","seed","food","potion","scroll","armor","weapon","sword","gun","bow","tool","pickup","collectible","item","treasure","key","card","charm","ring","amulet","relic","artifact","supply","crate","box","bag","pack","medkit","bandage","ammo","bullet","magazine","arrow","bolt","energy","mana","gold","silver","diamond","emerald","ruby","sapphire","platinum","cash","money","dollar","herb","flower","mushroom","fish","meat","leather","fabric","component","scrap","metal","electronics","wire","gear","battery","tape","glue","nail"}
local chestKeywords = {"chest","crate","box","loot","treasure","safe","container","barrel","cache","supply drop","airdrop","briefcase","sarcophagus","urn","coffin","locker","storage","strongbox","casket","trunk"}

-- ==================== CACHE ====================
local currentObjects = {}
local drawings = {}           -- cho items/chests
local playerDrawings = {}    -- cho players: {player = {box, text, name, ...}}

-- ==================== HELPER FUNCTIONS ====================
local function isPrecious(name)
    name = name:lower()
    for _,kw in ipairs(preciousKeywords) do
        if name:find(kw) then return true end
    end
    return false
end

local function containsKeyword(name, list)
    name = name:lower()
    for _,kw in ipairs(list) do
        if name:find(kw) then return true end
    end
    return false
end

local function getPosition(obj)
    if obj:IsA("BasePart") then return obj.Position
    elseif obj:IsA("Model") then
        local primary = obj.PrimaryPart
        if primary then return primary.Position end
        for _,v in ipairs(obj:GetDescendants()) do
            if v:IsA("BasePart") then return v.Position end
        end
    elseif obj:IsA("Tool") then
        local handle = obj:FindFirstChild("Handle")
        if handle and handle:IsA("BasePart") then return handle.Position end
        for _,v in ipairs(obj:GetDescendants()) do
            if v:IsA("BasePart") then return v.Position end
        end
    end
    return nil
end

local function worldToScreen(pos)
    local viewportPoint = Camera:WorldToViewportPoint(pos)
    return Vector2.new(viewportPoint.X, viewportPoint.Y), viewportPoint.Z > 0
end

local function createDrawing(text, color, size)
    local d = Drawing.new("Text")
    d.Text, d.Color, d.Size, d.Center, d.Outline, d.OutlineColor, d.Visible =
        text, color, size or 14, true, true, Color3.new(0,0,0), false
    return d
end

local function removeDrawing(d)
    pcall(function() d:Remove() end)
end

-- ==================== KILL AURA ====================
local function getNearestNpc(range)
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local nearest, minDist = nil, range + 1
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj ~= char then
            local hum = obj:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 and not Players:GetPlayerFromCharacter(obj) then
                local hrp = obj:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local d = (root.Position - hrp.Position).Magnitude
                    if d < minDist then
                        minDist, nearest = d, obj
                    end
                end
            end
        end
    end
    return nearest
end

local function attack(target)
    local char = LocalPlayer.Character
    if not char then return end
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool then
        local bp = LocalPlayer.Backpack
        if bp then
            local t = bp:FindFirstChildOfClass("Tool")
            if t then
                pcall(function() t.Parent = char end)
                tool = t
            end
        end
    end
    if tool then
        pcall(function() tool:Activate() end)
    else
        -- fallback: một số executor có mouse1click
        pcall(function() mouse1click() end)
    end
end

-- ==================== GUI ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn, ScreenGui.ZIndexBehavior = false, Enum.ZIndexBehavior.Sibling
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- === Nút tròn nổi ===
local CircleBtn = Instance.new("ImageButton")
CircleBtn.Size = UDim2.new(0, 55, 0, 55)
CircleBtn.Position = UDim2.new(0, 20, 0.5, -100)
CircleBtn.BackgroundTransparency = 1
CircleBtn.Image = "rbxassetid://3926307971"  -- vòng tròn trong suốt
CircleBtn.ImageColor3 = Color3.fromRGB(140, 80, 255)
CircleBtn.ScaleType = Enum.ScaleType.Fit
CircleBtn.Active = true
CircleBtn.Draggable = false
CircleBtn.Parent = ScreenGui

local CircleLabel = Instance.new("TextLabel")
CircleLabel.Size = UDim2.new(1,0,1,0)
CircleLabel.BackgroundTransparency = 1
CircleLabel.Text = "⚔️"
CircleLabel.TextColor3 = Color3.new(1,1,1)
CircleLabel.TextSize = 28
CircleLabel.Font = Enum.Font.GothamBold
CircleLabel.Parent = CircleBtn

-- Kéo nút tròn
local UIS = UserInputService
local draggingBtn, dragStart, startPos = false, nil, nil
CircleBtn.MouseButton1Down:Connect(function()
    draggingBtn = true
    dragStart = UIS:GetMouseLocation()
    startPos = CircleBtn.Position
end)
UIS.InputChanged:Connect(function(input)
    if draggingBtn and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = UIS:GetMouseLocation() - dragStart
        CircleBtn.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingBtn = false
    end
end)

-- === Menu chính ===
local MenuMain = Instance.new("Frame")
MenuMain.Size = UDim2.new(0, 230, 0, 280)  -- tăng chiều cao để chứa nhiều nút hơn
MenuMain.Position = UDim2.new(0.5, -115, 0.5, -140)
MenuMain.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MenuMain.BorderSizePixel = 0
MenuMain.BackgroundTransparency = 0.15
MenuMain.Visible = false
MenuMain.Parent = ScreenGui
Instance.new("UICorner", MenuMain).CornerRadius = UDim.new(0, 12)

-- Tiêu đề
local titleBar = Instance.new("Frame", MenuMain)
titleBar.Size = UDim2.new(1,0,0,36)
titleBar.BackgroundColor3 = Color3.fromRGB(140, 80, 255)
titleBar.BorderSizePixel = 0
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0,12)
local titleText = Instance.new("TextLabel", titleBar)
titleText.Size = UDim2.new(1,-10,1,0)
titleText.Position = UDim2.new(0,10,0,0)
titleText.BackgroundTransparency = 1
titleText.Text = "⚡ ESP & Aura"
titleText.TextColor3 = Color3.new(1,1,1)
titleText.TextSize = 18
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-35,0,3)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,8)
closeBtn.MouseButton1Click:Connect(function()
    MenuMain.Visible = false
    MenuOpen = false
end)

-- === ScrollingFrame chứa tất cả nút (có thể lướt) ===
local scrollContainer = Instance.new("ScrollingFrame", MenuMain)
scrollContainer.Size = UDim2.new(1, -16, 1, -46)
scrollContainer.Position = UDim2.new(0, 8, 0, 42)
scrollContainer.BackgroundTransparency = 1
scrollContainer.BorderSizePixel = 0
scrollContainer.ScrollBarThickness = 4
scrollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollContainer.ScrollingDirection = Enum.ScrollingDirection.Y
scrollContainer.VerticalScrollBarInset = Enum.ScrollBarInset.Always
scrollContainer.ClipsDescendants = true

local UIList = Instance.new("UIListLayout", scrollContainer)
UIList.Padding = UDim.new(0, 6)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.SortOrder = Enum.SortOrder.LayoutOrder

-- Tự động cập nhật CanvasSize khi nội dung thay đổi
UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scrollContainer.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y)
end)

-- === Hàm tạo nút toggle đẹp ===
local function createToggle(name, default, parent, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = default and Color3.fromRGB(70,130,70) or Color3.fromRGB(130,70,70)
    btn.BorderSizePixel = 0
    btn.Text = name .. ": " .. (default and "ON" or "OFF")
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamSemibold
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.Parent = parent

    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(70,130,70) or Color3.fromRGB(130,70,70)
        btn.Text = name .. ": " .. (state and "ON" or "OFF")
        callback(state)
    end)
    return btn
end

-- === Tạo các nút trong menu ===
createToggle("Master ESP", ESP_Enabled, scrollContainer, function(val) ESP_Enabled = val end)
createToggle("Item ESP", ItemESP, scrollContainer, function(val) ItemESP = val end)
createToggle("Chest ESP", ChestESP, scrollContainer, function(val) ChestESP = val end)
createToggle("Player ESP", PlayerESP, scrollContainer, function(val) PlayerESP = val end)
createToggle("Kill Aura", KillAuraEnabled, scrollContainer, function(val) KillAuraEnabled = val end)

-- === Slider tầm Kill Aura ===
local rangeFrame = Instance.new("Frame", scrollContainer)
rangeFrame.Size = UDim2.new(1,0,0,34)
rangeFrame.BackgroundTransparency = 1

local rangeLabel = Instance.new("TextLabel", rangeFrame)
rangeLabel.Size = UDim2.new(0,120,1,0)
rangeLabel.BackgroundTransparency = 1
rangeLabel.Text = "Range: "..KillAuraRange.." stud"
rangeLabel.TextColor3 = Color3.new(0.9,0.9,0.9)
rangeLabel.TextSize = 14
rangeLabel.Font = Enum.Font.Gotham

local slider = Instance.new("TextButton", rangeFrame)
slider.Size = UDim2.new(1,-130,0,24)
slider.Position = UDim2.new(0,125,0,5)
slider.BackgroundColor3 = Color3.fromRGB(100,100,100)
slider.BorderSizePixel = 0
slider.Text = ""
Instance.new("UICorner", slider).CornerRadius = UDim.new(0,6)

local fill = Instance.new("Frame", slider)
fill.Size = UDim2.new(KillAuraRange/50, 0, 1, 0)
fill.BackgroundColor3 = Color3.fromRGB(140,80,255)
fill.BorderSizePixel = 0
Instance.new("UICorner", fill).CornerRadius = UDim.new(0,6)

local draggingSlider = false
slider.MouseButton1Down:Connect(function()
    draggingSlider = true
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSlider = false
    end
end)
UIS.InputChanged:Connect(function(input)
    if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = UIS:GetMouseLocation()
        local sliderAbs = slider.AbsolutePosition
        local sliderSize = slider.AbsoluteSize
        local x = math.clamp((mousePos.X - sliderAbs.X) / sliderSize.X, 0, 1)
        KillAuraRange = math.floor(x * 50) + 1
        fill.Size = UDim2.new(x, 0, 1, 0)
        rangeLabel.Text = "Range: "..KillAuraRange.." stud"
    end
end)

-- === Nút mở danh sách Teleport ===
local teleBtn = Instance.new("TextButton", scrollContainer)
teleBtn.Size = UDim2.new(1, 0, 0, 34)
teleBtn.BackgroundColor3 = Color3.fromRGB(80,80,140)
teleBtn.BorderSizePixel = 0
teleBtn.Text = "📦 Item Teleport List"
teleBtn.TextColor3 = Color3.new(1,1,1)
teleBtn.TextSize = 14
teleBtn.Font = Enum.Font.GothamSemibold
Instance.new("UICorner", teleBtn).CornerRadius = UDim.new(0,8)
teleBtn.MouseButton1Click:Connect(function()
    listOpen = not listOpen
    TeleportFrame.Visible = listOpen
end)

-- === Animation mở/tắt menu ===
local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local function toggleMenu(open)
    MenuOpen = open
    if open then
        MenuMain.Visible = true
        MenuMain.Size = UDim2.new(0,0,0,0)
        MenuMain.Position = UDim2.new(0.5,0,0.5,0)
        local goal = {Size = UDim2.new(0,230,0,280), Position = UDim2.new(0.5,-115,0.5,-140)}
        TweenService:Create(MenuMain, tweenInfo, goal):Play()
    else
        local goal = {Size = UDim2.new(0,0,0,0), Position = UDim2.new(0.5,0,0.5,0)}
        local tw = TweenService:Create(MenuMain, tweenInfo, goal)
        tw.Completed:Connect(function()
            if not MenuOpen then MenuMain.Visible = false end
        end)
        tw:Play()
    end
end

CircleBtn.MouseButton1Click:Connect(function()
    if not draggingBtn then toggleMenu(not MenuOpen) end
end)

-- Phím tắt RightControl
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        toggleMenu(not MenuOpen)
    end
end)

-- ==================== FRAME DANH SÁCH TELEPORT ====================
local TeleportFrame = Instance.new("Frame", ScreenGui)
TeleportFrame.Size = UDim2.new(0, 280, 0, 340)
TeleportFrame.Position = UDim2.new(0.7, 0, 0.5, -170)
TeleportFrame.BackgroundColor3 = Color3.fromRGB(22,22,28)
TeleportFrame.BorderSizePixel = 0
TeleportFrame.BackgroundTransparency = 0.1
TeleportFrame.Visible = false
Instance.new("UICorner", TeleportFrame).CornerRadius = UDim.new(0,10)

-- Tiêu đề
local listTitleBar = Instance.new("Frame", TeleportFrame)
listTitleBar.Size = UDim2.new(1,0,0,32)
listTitleBar.BackgroundColor3 = Color3.fromRGB(100,80,200)
listTitleBar.BorderSizePixel = 0
Instance.new("UICorner", listTitleBar).CornerRadius = UDim.new(0,10)
local listTitle = Instance.new("TextLabel", listTitleBar)
listTitle.Size = UDim2.new(1,-70,1,0)
listTitle.Position = UDim2.new(0,10,0,0)
listTitle.BackgroundTransparency = 1
listTitle.Text = "🎯 Teleport List"
listTitle.TextColor3 = Color3.new(1,1,1)
listTitle.TextSize = 16
listTitle.Font = Enum.Font.GothamBold
listTitle.TextXAlignment = Enum.TextXAlignment.Left

local refreshBtn = Instance.new("TextButton", listTitleBar)
refreshBtn.Size = UDim2.new(0,60,0,24)
refreshBtn.Position = UDim2.new(1,-135,0,4)
refreshBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
refreshBtn.BorderSizePixel = 0
refreshBtn.Text = "🔄"
refreshBtn.TextColor3 = Color3.new(1,1,1)
refreshBtn.TextSize = 14
Instance.new("UICorner", refreshBtn).CornerRadius = UDim.new(0,6)

local closeListBtn = Instance.new("TextButton", listTitleBar)
closeListBtn.Size = UDim2.new(0,40,0,24)
closeListBtn.Position = UDim2.new(1,-65,0,4)
closeListBtn.BackgroundColor3 = Color3.fromRGB(220,60,60)
closeListBtn.BorderSizePixel = 0
closeListBtn.Text = "✕"
closeListBtn.TextColor3 = Color3.new(1,1,1)
closeListBtn.TextSize = 14
Instance.new("UICorner", closeListBtn).CornerRadius = UDim.new(0,6)
closeListBtn.MouseButton1Click:Connect(function()
    TeleportFrame.Visible = false
    listOpen = false
end)

-- ScrollingFrame danh sách
local itemScroll = Instance.new("ScrollingFrame", TeleportFrame)
itemScroll.Size = UDim2.new(1,-4,1,-38)
itemScroll.Position = UDim2.new(0,2,0,34)
itemScroll.BackgroundColor3 = Color3.fromRGB(35,35,40)
itemScroll.BorderSizePixel = 0
itemScroll.ScrollBarThickness = 5
itemScroll.CanvasSize = UDim2.new(0,0,0,0)
Instance.new("UICorner", itemScroll).CornerRadius = UDim.new(0,8)

local itemList = Instance.new("UIListLayout", itemScroll)
itemList.Padding = UDim.new(0,2)
itemList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    itemScroll.CanvasSize = UDim2.new(0,0,0,itemList.AbsoluteContentSize.Y)
end)

local function refreshTeleportList()
    -- Xóa nút cũ
    for _, child in ipairs(itemScroll:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end

    local items = {}
    for _, info in pairs(currentObjects) do
        table.insert(items, info)
    end
    table.sort(items, function(a,b) return a.distance < b.distance end)

    local count = 0
    for _, info in ipairs(items) do
        if count >= 50 then break end
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1,-4,0,26)
        btn.BackgroundColor3 = Color3.fromRGB(50,50,55)
        btn.BorderSizePixel = 0
        btn.AutoButtonColor = false
        btn.Parent = itemScroll
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

        local label = Instance.new("TextLabel", btn)
        label.Size = UDim2.new(1,-10,1,0)
        label.Position = UDim2.new(0,5,0,0)
        label.BackgroundTransparency = 1
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextSize = 13
        label.Font = Enum.Font.Gotham
        local prefix = info.type == "Chest" and "[R] " or "[I] "
        label.Text = prefix .. string.format("%.0fm", info.distance) .. " " .. info.name
        if info.type == "Chest" then
            label.TextColor3 = Color3.fromRGB(255,100,255)
        elseif isPrecious(info.name) then
            label.TextColor3 = Color3.fromRGB(255,215,0)
        else
            label.TextColor3 = Color3.fromRGB(220,220,220)
        end

        btn.MouseButton1Click:Connect(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(info.pos + Vector3.new(0,3,0))
            end
        end)
        count += 1
    end
end

refreshBtn.MouseButton1Click:Connect(refreshTeleportList)

-- ==================== VÒNG LẶP CHÍNH (ESP + Kill Aura) ====================
local function updateAllESP()
    -- === 1. Cập nhật danh sách items/chests ===
    local newObjects = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:FindFirstAncestorOfClass("Humanoid") or obj:FindFirstAncestorWhichIsA("Backpack") then continue end
        local name, class = obj.Name, obj.ClassName
        local objType = nil
        if class == "Tool" then objType = "Item"
        elseif class == "Model" or obj:IsA("BasePart") then
            if containsKeyword(name, chestKeywords) then objType = "Chest"
            elseif containsKeyword(name, itemKeywords) then objType = "Item" end
        end
        if objType then
            local pos = getPosition(obj)
            if pos and (Camera.CFrame.Position - pos).Magnitude <= 500 then
                newObjects[obj] = {
                    type = objType,
                    pos = pos,
                    name = name,
                    distance = (Camera.CFrame.Position - pos).Magnitude
                }
            end
        end
    end
    currentObjects = newObjects

    -- Xóa drawing items/chests không còn tồn tại
    for obj, data in pairs(drawings) do
        if not currentObjects[obj] then
            removeDrawing(data.drawing)
            drawings[obj] = nil
        end
    end

    -- Cập nhật/tạo mới drawing items/chests
    for obj, info in pairs(currentObjects) do
        local existing = drawings[obj]
        if not existing then
            local text, color
            if info.type == "Chest" then
                text, color = "[Rương] "..info.name, Color3.fromRGB(255,0,255)
            elseif isPrecious(info.name) then
                text, color = "[Quý] "..info.name, Color3.fromRGB(255,215,0)
            else
                text, color = info.name, Color3.fromRGB(255,255,255)
            end
            drawings[obj] = {drawing = createDrawing(text, color, 14), type = info.type}
            existing = drawings[obj]
        end
        local d = existing.drawing
        local pos, onScreen = worldToScreen(info.pos)
        local typeEnabled = (existing.type=="Item" and ItemESP) or (existing.type=="Chest" and ChestESP)
        if ESP_Enabled and typeEnabled and onScreen then
            d.Visible, d.Position = true, pos
            if existing.type == "Chest" then
                d.Text = "[Rương] "..info.name
            elseif isPrecious(info.name) then
                d.Text = "[Quý] "..info.name
                d.Color = Color3.fromRGB(255,215,0)
            else
                d.Text = info.name
                d.Color = Color3.fromRGB(255,255,255)
            end
        else
            d.Visible = false
        end
    end

    -- === 2. Cập nhật ESP Player ===
    if not ESP_Enabled or not PlayerESP then
        -- Tắt tất cả player drawings
        for _, data in pairs(playerDrawings) do
            if data.box then data.box.Visible = false end
            if data.text then data.text.Visible = false end
        end
    else
        local currentPlayers = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                currentPlayers[player] = true
                local char = player.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    local head = char:FindFirstChild("Head")
                    local humanoid = char:FindFirstChildOfClass("Humanoid")
                    if root and head and humanoid and humanoid.Health > 0 then
                        local data = playerDrawings[player]
                        if not data then
                            -- Tạo drawing mới
                            local box = Drawing.new("Square")
                            box.Thickness = 2
                            box.Filled = false
                            box.Color = player.TeamColor and player.TeamColor.Color or Color3.fromRGB(255,255,255)
                            box.Visible = false
                            local text = Drawing.new("Text")
                            text.Size = 14
                            text.Center = true
                            text.Outline = true
                            text.OutlineColor = Color3.new(0,0,0)
                            text.Color = player.TeamColor and player.TeamColor.Color or Color3.fromRGB(255,255,255)
                            text.Visible = false
                            playerDrawings[player] = {box = box, text = text}
                            data = playerDrawings[player]
                        end

                        local rootPos = root.Position
                        local headPos = head.Position + Vector3.new(0, 2, 0)
                        local rootScreen, rootVis = worldToScreen(rootPos)
                        local headScreen, headVis = worldToScreen(headPos)
                        local dist = (Camera.CFrame.Position - rootPos).Magnitude

                        if rootVis and headVis and dist <= 500 then
                            local height = math.abs(headScreen.Y - rootScreen.Y)
                            local width = height * 0.45
                            local boxX = rootScreen.X - width/2
                            local boxY = headScreen.Y

                            data.box.Visible = true
                            data.box.Position = Vector2.new(boxX, boxY)
                            data.box.Size = Vector2.new(width, height)

                            local hp = humanoid.Health > 0 and math.floor(humanoid.Health) or 0
                            data.text.Visible = true
                            data.text.Text = string.format("%s [%.0fm] [%d HP]", player.Name, dist, hp)
                            data.text.Position = Vector2.new(rootScreen.X, headScreen.Y - 20)
                        else
                            data.box.Visible = false
                            data.text.Visible = false
                        end
                    else
                        -- Character không hợp lệ -> ẩn
                        if playerDrawings[player] then
                            playerDrawings[player].box.Visible = false
                            playerDrawings[player].text.Visible = false
                        end
                    end
                else
                    -- Không có character
                    if playerDrawings[player] then
                        playerDrawings[player].box.Visible = false
                        playerDrawings[player].text.Visible = false
                    end
                end
            end
        end
        -- Xóa drawing của player đã rời
        for player, data in pairs(playerDrawings) do
            if not currentPlayers[player] then
                removeDrawing(data.box)
                removeDrawing(data.text)
                playerDrawings[player] = nil
            end
        end
    end

    -- Cập nhật danh sách teleport nếu đang mở
    if listOpen then
        pcall(refreshTeleportList)
    end
end

-- Kill Aura loop
coroutine.wrap(function()
    while task.wait(0.15) do
        if KillAuraEnabled and LocalPlayer.Character then
            local target = getNearestNpc(KillAuraRange)
            if target then attack(target) end
        end
    end
end)()

-- ESP loop
coroutine.wrap(function()
    while task.wait(0.1) do
        pcall(updateAllESP)
    end
end)()

print("⚡ ESP Items + Players + Chests + Kill Aura + Teleport loaded!")
print("Nhấn nút tròn hoặc RightControl để mở menu.")