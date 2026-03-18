local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalizationService = game:GetService("LocalizationService")
local LogService = game:GetService("LogService")

local function rich(text, color)
    return string.format('<font color="rgb(%d,%d,%d)">%s</font>', 
        math.floor(color.R*255), math.floor(color.G*255), math.floor(color.B*255), tostring(text))
end

local function formatTime(sec)
    local h = math.floor(sec/3600)
    local m = math.floor((sec%3600)/60)
    local s = math.floor(sec%60)
    return string.format("%02d:%02d:%02d", h, m, s)
end

local function CreateTrackUi()
    local LP = Players.LocalPlayer
    local PG = LP:WaitForChild("PlayerGui")
    
    if PG:FindFirstChild("TrackUi") then PG.TrackUi:Destroy() end

    local gui = Instance.new("ScreenGui", PG)
    gui.Name = "TrackUi"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = true 
    gui.DisplayOrder = -1

    local bgImg = Instance.new("ImageLabel", gui)
    bgImg.Name = "FullBackground"
    bgImg.Size = UDim2.fromScale(1, 1)
    bgImg.Image = "rbxassetid://136341057920957"
    bgImg.ScaleType = Enum.ScaleType.Crop 
    bgImg.ImageTransparency = 0 
    bgImg.BackgroundTransparency = 1
    bgImg.BorderSizePixel = 0
    bgImg.ZIndex = 1

    local infoContainer = Instance.new("Frame", gui)
    infoContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    infoContainer.Position = UDim2.fromScale(0.5, 0.5)
    infoContainer.Size = UDim2.fromOffset(400, 250)
    infoContainer.BackgroundTransparency = 1 
    infoContainer.BorderSizePixel = 0
    infoContainer.ZIndex = 2

    local list = Instance.new("UIListLayout", infoContainer)
    list.HorizontalAlignment = Enum.HorizontalAlignment.Center
    list.VerticalAlignment = Enum.VerticalAlignment.Center
    list.Padding = UDim.new(0, 8)

    local function createLabel(name, size, color, parent)
        local l = Instance.new("TextLabel", parent)
        l.Name = name
        l.Size = UDim2.new(1, 0, 0, 32)
        l.BackgroundTransparency = 1
        l.RichText = true
        l.Font = Enum.Font.GothamBlack
        l.TextSize = size
        l.TextColor3 = color or Color3.new(1,1,1)
        l.TextStrokeTransparency = 0.3 
        l.TextStrokeColor3 = Color3.new(0,0,0)
        l.ZIndex = parent.ZIndex + 1
        return l
    end

    local title = createLabel("Title", 28, Color3.fromRGB(0, 255, 150), infoContainer)
    local infoTimeServer = createLabel("TimeServer", 18, nil, infoContainer)
    local infoRegion = createLabel("Region", 18, nil, infoContainer)
    local infoUptime = createLabel("Uptime", 18, nil, infoContainer)
    local infoFPS = createLabel("FPS", 18, Color3.new(0, 1, 1), infoContainer)

    title.Text = "TRACK UI SYSTEM"
    
    local regionCode = "Unknown"
    pcall(function()
        regionCode = LocalizationService:GetCountryRegionForPlayerAsync(LP)
    end)

    local consoleFrame = Instance.new("ScrollingFrame", gui)
    consoleFrame.Name = "ConsoleLog"
    consoleFrame.AnchorPoint = Vector2.new(0.5, 1)
    consoleFrame.Position = UDim2.fromScale(0.5, 0.98)
    consoleFrame.Size = UDim2.fromOffset(350, 120)
    consoleFrame.BackgroundTransparency = 0.6 
    consoleFrame.BackgroundColor3 = Color3.new(0,0,0)
    consoleFrame.BorderSizePixel = 0
    consoleFrame.ZIndex = 3
    consoleFrame.ScrollBarThickness = 2
    consoleFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    consoleFrame.AutomaticCanvasSize = Enum.AutomaticCanvasSize.Y

    local consoleList = Instance.new("UIListLayout", consoleFrame)
    consoleList.SortOrder = Enum.SortOrder.LayoutOrder
    consoleList.Padding = UDim.new(0, 2)

    local function addLog(message, messageType)
        local color = Color3.new(1,1,1)
        if messageType == Enum.MessageType.MessageWarning then color = Color3.new(1, 1, 0)
        elseif messageType == Enum.MessageType.MessageError then color = Color3.new(1, 0, 0) end

        local logLbl = Instance.new("TextLabel", consoleFrame)
        logLbl.Size = UDim2.new(1, -5, 0, 0)
        logLbl.AutomaticSize = Enum.AutomaticSize.Y
        logLbl.BackgroundTransparency = 1
        logLbl.Text = string.format("[%s] %s", os.date("%X"), message)
        logLbl.Font = Enum.Font.Code
        logLbl.TextSize = 11
        logLbl.TextColor3 = color
        logLbl.TextXAlignment = Enum.TextXAlignment.Left
        logLbl.TextWrapped = true
        logLbl.TextStrokeTransparency = 0.5
        
        local logs = consoleFrame:GetChildren()
        local count = 0
        for _, v in pairs(logs) do if v:IsA("TextLabel") then count = count + 1 end end
        if count > 30 then
            for _, v in pairs(logs) do
                if v:IsA("TextLabel") then v:Destroy() break end
            end
        end
        
        task.wait()
        consoleFrame.CanvasPosition = Vector2.new(0, consoleFrame.AbsoluteCanvasSize.Y)
    end

    LogService.MessageOut:Connect(addLog)

    local startTime = os.clock()
    local fps = 0
    RunService.RenderStepped:Connect(function(dt) fps = math.floor(1/dt) end)

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

CreateTrackUi()
