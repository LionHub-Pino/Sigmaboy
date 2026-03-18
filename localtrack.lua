local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalizationService = game:GetService("LocalizationService")

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

    -- Hình nền
    local bgImg = Instance.new("ImageLabel", gui)
    bgImg.Name = "FullBackground"
    bgImg.Size = UDim2.fromScale(1, 1)
    bgImg.Image = "rbxassetid://92046266691091"
    bgImg.ScaleType = Enum.ScaleType.Crop 
    bgImg.ImageTransparency = 0 
    bgImg.BackgroundTransparency = 1
    bgImg.BorderSizePixel = 0
    bgImg.ZIndex = 1

    -- Container chính
    local infoContainer = Instance.new("Frame", gui)
    infoContainer.Name = "CenterContainer"
    infoContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    infoContainer.Position = UDim2.fromScale(0.5, 0.5)
    infoContainer.Size = UDim2.fromOffset(500, 300)
    infoContainer.BackgroundTransparency = 1 
    infoContainer.BorderSizePixel = 0
    infoContainer.ZIndex = 2

    local list = Instance.new("UIListLayout", infoContainer)
    list.HorizontalAlignment = Enum.HorizontalAlignment.Center
    list.VerticalAlignment = Enum.VerticalAlignment.Center
    list.Padding = UDim.new(0, 10)

    -- Hàm tạo Label dùng chung
    local function createLabel(name, size, color, parent)
        local l = Instance.new("TextLabel", parent)
        l.Name = name
        l.Size = UDim2.new(1, 0, 0, 35)
        l.BackgroundTransparency = 1
        l.RichText = true
        l.Font = Enum.Font.GothamBlack
        l.TextSize = size
        l.TextColor3 = color or Color3.new(1,1,1)
        l.TextStrokeTransparency = 0.2 
        l.TextStrokeColor3 = Color3.new(0,0,0)
        l.TextWrapped = false
        l.Text = "" -- Để trống để đánh máy hoặc cập nhật sau
        l.ZIndex = parent.ZIndex + 1
        return l
    end

    local title = createLabel("Title", 35, Color3.fromRGB(0, 255, 150), infoContainer)
    local infoTimeServer = createLabel("TimeServer", 20, nil, infoContainer)
    local infoRegion = createLabel("Region", 20, nil, infoContainer)
    local infoUptime = createLabel("Uptime", 20, nil, infoContainer)
    local infoFPS = createLabel("FPS", 20, Color3.new(0, 1, 1), infoContainer)

    -- Hiệu ứng đánh máy cho Title
    task.spawn(function()
        local fullText = "Do I look like him ?"
        for i = 1, #fullText do
            title.Text = string.sub(fullText, 1, i)
            task.wait(0.1) -- Tốc độ đánh máy (giây mỗi chữ)
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
    RunService.RenderStepped:Connect(function(dt) 
        fps = math.floor(1/dt) 
    end)

    task.spawn(function()
        while task.wait(0.5) do
            if not gui.Parent then break end
            infoTimeServer.Text = "Server Time: " .. rich(os.date("%X"), Color3.new(1, 1, 0.4))
            infoRegion.Text = "Region: " .. rich(regionCode, Color3.new(1, 0.5, 0))
            infoUptime.Text = "Uptime: " .. rich(formatTime(os.clock() - startTime), Color3.new(0.4, 1, 0.4))
            infoFPS.Text = "FPS: " .. rich(tostring(fps), Color3.new(1, 1, 1))
        end
    end)
end

-- Chạy hàm chính
CreateTrackUi()
