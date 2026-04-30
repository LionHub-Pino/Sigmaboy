local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalizationService = game:GetService("LocalizationService")
local UserInputService = game:GetService("UserInputService")

-- Hàm tạo mã màu RichText
local function rich(text, color)
    return string.format('<font color="rgb(%d,%d,%d)">%s</font>', 
        math.floor(color.R*255), math.floor(color.G*255), math.floor(color.B*255), tostring(text))
end

-- Hàm định dạng thời gian HH:MM:SS
local function formatTime(sec)
    local h = math.floor(sec/3600)
    local m = math.floor((sec%3600)/60)
    local s = math.floor(sec%60)
    return string.format("%02d:%02d:%02d", h, m, s)
end

-- Hàm tính Ping (ước tính)
local function getPing()
    local ping = (game:GetNetworkReceiveTime() * 1000)
    return math.floor(ping)
end

-- Hàm lấy thông tin RAM (ước tính)
local function getMemoryUsage()
    local memory = collectgarbage("count")
    return string.format("%.2f MB", memory / 1024)
end

-- Hàm tạo hiệu ứng gradient
local function createGradientBackground(parent, color1, color2)
    local gradient = Instance.new("UIGradient", parent)
    gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, color1), ColorSequenceKeypoint.new(1, color2)}
    gradient.Rotation = 45
    return gradient
end

local function CreateTrackUi()
    local LP = Players.LocalPlayer
    local PG = LP:WaitForChild("PlayerGui")
    
    -- Xóa UI cũ nếu tồn tại
    if PG:FindFirstChild("TrackUi") then PG.TrackUi:Destroy() end

    local gui = Instance.new("ScreenGui", PG)
    gui.Name = "TrackUi"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = true 
    gui.DisplayOrder = -1

    -- Hình nền chính
    local bgImg = Instance.new("ImageLabel", gui)
    bgImg.Name = "FullBackground"
    bgImg.Size = UDim2.fromScale(1, 1)
    bgImg.Image = "rbxassetid://95957052149966"
    bgImg.ScaleType = Enum.ScaleType.Crop 
    bgImg.ImageTransparency = 0.2
    bgImg.BackgroundTransparency = 1
    bgImg.BorderSizePixel = 0
    bgImg.ZIndex = 1

    -- Lớp overlay
    local overlay = Instance.new("Frame", gui)
    overlay.Name = "Overlay"
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.BackgroundColor3 = Color3.new(0, 0, 0)
    overlay.BackgroundTransparency = 0.3
    overlay.BorderSizePixel = 0
    overlay.ZIndex = 1

    -- Container chính với đường viền
    local infoContainer = Instance.new("Frame", gui)
    infoContainer.Name = "CenterContainer"
    infoContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    infoContainer.Position = UDim2.fromScale(0.5, 0.5)
    infoContainer.Size = UDim2.fromOffset(520, 380)
    infoContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    infoContainer.BackgroundTransparency = 0.15
    infoContainer.BorderSizePixel = 0
    infoContainer.ZIndex = 2
    
    -- Hiệu ứng góc bo
    local corner = Instance.new("UICorner", infoContainer)
    corner.CornerRadius = UDim.new(0, 12)
    
    -- Hiệu ứng stroke viền
    local stroke = Instance.new("UIStroke", infoContainer)
    stroke.Color = Color3.fromRGB(0, 255, 150)
    stroke.Thickness = 2
    stroke.Transparency = 0.3

    local list = Instance.new("UIListLayout", infoContainer)
    list.HorizontalAlignment = Enum.HorizontalAlignment.Center
    list.VerticalAlignment = Enum.VerticalAlignment.Top
    list.Padding = UDim.new(0, 12)
    
    -- Padding bên trong container
    local padding = Instance.new("UIPadding", infoContainer)
    padding.PaddingTop = UDim.new(0, 15)
    padding.PaddingBottom = UDim.new(0, 15)

    -- Hàm tạo Label dùng chung
    local function createLabel(name, size, color, parent, bold)
        local l = Instance.new("TextLabel", parent)
        l.Name = name
        l.Size = UDim2.new(1, 0, 0, 35)
        l.BackgroundTransparency = 1
        l.RichText = true
        l.Font = bold and Enum.Font.GothamBlack or Enum.Font.Gotham
        l.TextSize = size
        l.TextColor3 = color or Color3.new(1,1,1)
        l.TextStrokeTransparency = 0.3
        l.TextStrokeColor3 = Color3.new(0,0,0)
        l.TextWrapped = false
        l.Text = ""
        l.ZIndex = parent.ZIndex + 1
        return l
    end

    -- Title
    local title = createLabel("Title", 38, Color3.fromRGB(0, 255, 150), infoContainer, true)
    
    -- Info labels
    local infoTimeServer = createLabel("TimeServer", 18, Color3.fromRGB(255, 200, 100), infoContainer, false)
    local infoRegion = createLabel("Region", 18, Color3.fromRGB(100, 200, 255), infoContainer, false)
    local infoUptime = createLabel("Uptime", 18, Color3.fromRGB(100, 255, 150), infoContainer, false)
    local infoFPS = createLabel("FPS", 18, Color3.fromRGB(255, 100, 200), infoContainer, false)
    local infoPing = createLabel("Ping", 18, Color3.fromRGB(255, 150, 100), infoContainer, false)
    local infoMemory = createLabel("Memory", 18, Color3.fromRGB(150, 100, 255), infoContainer, false)
    local infoPlayers = createLabel("Players", 18, Color3.fromRGB(100, 255, 200), infoContainer, false)

    -- Hiệu ứng đánh máy cho Title
    task.spawn(function()
        local fullText = "⚡ Do I look like him ?"
        for i = 1, #fullText do
            title.Text = string.sub(fullText, 1, i)
            task.wait(0.08)
        end
    end)
    
    -- Lấy Region
    local regionCode = "Unknown"
    task.spawn(function()
        pcall(function()
            regionCode = LocalizationService:GetCountryRegionForPlayerAsync(LP)
        end)
    end)

    -- Xử lý FPS và Update thông tin
    local startTime = os.clock()
    local fps = 0
    local frameCount = 0
    local fpsUpdateTime = 0
    
    RunService.RenderStepped:Connect(function(dt) 
        frameCount = frameCount + 1
        fpsUpdateTime = fpsUpdateTime + dt
        
        if fpsUpdateTime >= 0.1 then
            fps = math.floor(frameCount / fpsUpdateTime)
            frameCount = 0
            fpsUpdateTime = 0
        end
    end)

    -- Update loop
    task.spawn(function()
        while task.wait(0.5) do
            if not gui.Parent then break end
            
            local ping = getPing()
            local memory = getMemoryUsage()
            local playerCount = #Players:GetPlayers()
            
            infoTimeServer.Text = "🕐 Server Time: " .. rich(os.date("%X"), Color3.fromRGB(255, 200, 100))
            infoRegion.Text = "🌍 Region: " .. rich(regionCode, Color3.fromRGB(100, 200, 255))
            infoUptime.Text = "⏱️ Uptime: " .. rich(formatTime(os.clock() - startTime), Color3.fromRGB(100, 255, 150))
            infoFPS.Text = "📊 FPS: " .. rich(tostring(fps), Color3.fromRGB(255, 100, 200))
            infoPing.Text = "📡 Ping: " .. rich(ping .. "ms", Color3.fromRGB(255, 150, 100))
            infoMemory.Text = "💾 Memory: " .. rich(memory, Color3.fromRGB(150, 100, 255))
            infoPlayers.Text = "👥 Players: " .. rich(playerCount .. "/25", Color3.fromRGB(100, 255, 200))
        end
    end)

    -- Draggable functionality
    local dragging = false
    local dragInput
    local dragStart
    local startPos

    infoContainer.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = infoContainer.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input, gameProcessed)
        if not dragging then return end
        
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            infoContainer.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input, gameProcessed)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    -- Toggle UI visibility with Backspace
    local uiVisible = true
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.BackSpace then
            uiVisible = not uiVisible
            infoContainer.Visible = uiVisible
        end
    end)
end

-- Chạy hàm chính
CreateTrackUi()
