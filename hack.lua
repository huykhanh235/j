--[[
    Script màn hình đỏ toàn server + tên "khanhhuy", không lơ lửng.
    Chạy trên Delta. Yêu cầu game có backdoor để tác động server-wide.
    Nếu không có backdoor, chỉ client hiện tại bị đỏ.
    Script tự động quét remote và gửi lệnh đến server.
--]]

-- 1. Tạo GUI đỏ toàn màn hình kèm tên khanhhuy
local function createGlobalGui()
    local screen = Instance.new("ScreenGui")
    screen.Name = "KhanhhuyRedGlobal"
    screen.ResetOnSpawn = false
    screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.new(1, 0, 0)
    frame.BackgroundTransparency = 0.0 -- đỏ đặc hoàn toàn
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Selectable = false
    frame.Parent = screen

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 700, 0, 200)
    label.Position = UDim2.new(0.5, -350, 0.5, -100)
    label.Text = "khanhhuy"
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.SciFi
    label.TextScaled = true
    label.BackgroundTransparency = 1
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.ZIndex = 10
    label.Parent = frame

    return screen
end

-- 2. Hàm gửi GUI đến tất cả người chơi qua server (nếu có backdoor)
local function broadcastToAllPlayers(guiClone)
    -- Thử dùng backdoor: tìm RemoteEvent hoặc RemoteFunction bất kỳ
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            local success, err = pcall(function()
                -- Gửi một hàm server-side để phân phát GUI
                local serverCode = [[
                    local guiTemplate = ... -- GUI clone được truyền vào
                    local Players = game:GetService("Players")
                    local function giveGui(player)
                        local playerGui = player:FindFirstChild("PlayerGui")
                        if playerGui then
                            local clone = guiTemplate:Clone()
                            clone.Parent = playerGui
                        end
                    end
                    for _, plr in ipairs(Players:GetPlayers()) do
                        giveGui(plr)
                    end
                    Players.PlayerAdded:Connect(giveGui)
                    -- Thiết lập ánh sáng đỏ server
                    local Lighting = game:GetService("Lighting")
                    Lighting.Ambient = Color3.new(1,0,0)
                    Lighting.OutdoorAmbient = Color3.new(1,0,0)
                    Lighting.FogColor = Color3.new(1,0,0)
                    Lighting.FogEnd = 100
                    Lighting.FogStart = 0
                    local cc = Instance.new("ColorCorrectionEffect")
                    cc.TintColor = Color3.new(1,0,0)
                    cc.Parent = Lighting
                ]]
                -- Gửi script server-side kèm GUI
                v:FireServer(serverCode, guiClone)
            end)
            if success then
                return true
            end
        end
    end
    return false
end

-- 3. Nếu không có backdoor, chỉ áp dụng cho client hiện tại
local function applyLocalOnly()
    local gui = createGlobalGui()
    gui.Parent = game:GetService("CoreGui")

    -- Thay đổi ánh sáng cục bộ
    local Lighting = game:GetService("Lighting")
    Lighting.Ambient = Color3.new(1,0,0)
    Lighting.OutdoorAmbient = Color3.new(1,0,0)
    Lighting.FogColor = Color3.new(1,0,0)
    Lighting.FogEnd = 100
    Lighting.FogStart = 0
    local cc = Instance.new("ColorCorrectionEffect")
    cc.TintColor = Color3.new(1,0,0)
    cc.Parent = Lighting
    print("[Khanhhuy] Không tìm thấy backdoor. Chỉ client này bị đỏ.")
end

-- 4. Hàm chính
local function main()
    local guiTemplate = createGlobalGui()
    local broadcastSuccess = broadcastToAllPlayers(guiTemplate)
    if not broadcastSuccess then
        applyLocalOnly()
    else
        -- Vẫn đảm bảo client hiện tại cũng thấy GUI
        guiTemplate.Parent = game:GetService("CoreGui")
        print("[Khanhhuy] Đã gửi backdoor đến server. Tất cả người chơi sẽ thấy đỏ và tên khanhhuy.")
    end
end

main()