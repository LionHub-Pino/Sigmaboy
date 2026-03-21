-- [[ CONFIG ]]
local UPDATE_INTERVAL = 30 -- Thời gian chờ giữa mỗi lần gửi (giây)
local WORKER_URL = "https://trackeraccount.binhgoldtt1.workers.dev/update"

-- [[ SERVICES ]]
local http_request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- [[ TẠO UI HIỂN THỊ TRẠNG THÁI ]]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoCloudTracker"
ScreenGui.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 200, 0, 60)
Main.Position = UDim2.new(0, 10, 0, 10) -- Mặc định ở góc trái trên
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true -- Cho phép kéo thả (cũ) hoặc dùng code kéo thả mới bên dưới
Main.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = Main

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -20, 0, 30)
StatusText.Position = UDim2.new(0, 10, 0, 5)
StatusText.BackgroundTransparency = 1
StatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusText.Text = "Cloud: Waiting..."
StatusText.Font = Enum.Font.GothamBold
StatusText.TextSize = 12
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.Parent = Main

local TimerText = Instance.new("TextLabel")
TimerText.Size = UDim2.new(1, -20, 0, 20)
TimerText.Position = UDim2.new(0, 10, 0, 30)
TimerText.BackgroundTransparency = 1
TimerText.TextColor3 = Color3.fromRGB(150, 150, 150)
TimerText.Text = "Next sync in: --s"
TimerText.Font = Enum.Font.Code
TimerText.TextSize = 10
TimerText.TextXAlignment = Enum.TextXAlignment.Left
TimerText.Parent = Main

-- [[ LOGIC KÉO THẢ MƯỢT MÀ ]]
local dragging, dragInput, dragStart, startPos
Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; startPos = Main.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- [[ VÒNG LẶP AUTO GỬI DỮ LIỆU ]]
task.spawn(function()
    while true do
        for i = UPDATE_INTERVAL, 0, -1 do
            TimerText.Text = "Next sync in: " .. i .. "s"
            task.wait(1)
        end
        
        StatusText.Text = "Cloud: Syncing..."
        StatusText.TextColor3 = Color3.fromRGB(255, 200, 0)

        local success, result = pcall(function()
            local ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
            local data = {
                username = Players.LocalPlayer.Name,
                placeId = game.PlaceId,
                placeName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
                jobId = game.JobId,
                players = #Players:GetPlayers(),
                maxPlayers = Players.MaxPlayers,
                fps = ping
            }

            return http_request({
                Url = WORKER_URL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode(data)
            })
        end)

        if success and result.StatusCode == 200 then
            StatusText.Text = "Cloud: Connected ✅"
            StatusText.TextColor3 = Color3.fromRGB(0, 255, 150)
        else
            StatusText.Text = "Cloud: Failed ❌"
            StatusText.TextColor3 = Color3.fromRGB(255, 100, 100)
            warn("Lỗi gửi dữ liệu: ", result and result.StatusCode or "Unknown")
        end
    end
end)
