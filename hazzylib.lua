--[[
    HazzyLib - Custom UI Library
    Style: Fluent UI + Windi UI hybrid
    Features: Tabs, Drag to Resize, Notifications, Toggles, Buttons, Dropdowns, Sliders, Labels
]]

local HazzyLib = {}
HazzyLib.__index = HazzyLib

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Theme
local Theme = {
    Background     = Color3.fromRGB(15, 15, 20),
    Surface        = Color3.fromRGB(22, 22, 30),
    SurfaceAlt     = Color3.fromRGB(28, 28, 38),
    Border         = Color3.fromRGB(45, 45, 60),
    BorderAccent   = Color3.fromRGB(80, 80, 110),
    Accent         = Color3.fromRGB(99, 102, 241),
    AccentHover    = Color3.fromRGB(118, 121, 255),
    AccentMuted    = Color3.fromRGB(49, 52, 120),
    Text           = Color3.fromRGB(240, 240, 248),
    TextMuted      = Color3.fromRGB(160, 160, 180),
    TextDim        = Color3.fromRGB(100, 100, 120),
    Success        = Color3.fromRGB(52, 211, 153),
    Warning        = Color3.fromRGB(251, 191, 36),
    Danger         = Color3.fromRGB(239, 68, 68),
    TabActive      = Color3.fromRGB(99, 102, 241),
    TabInactive    = Color3.fromRGB(28, 28, 38),
    TabText        = Color3.fromRGB(240, 240, 248),
    TabTextMuted   = Color3.fromRGB(120, 120, 140),
    Handle         = Color3.fromRGB(60, 60, 80),
    Shadow         = Color3.fromRGB(0, 0, 0),
}

local MIN_WIDTH  = 340
local MIN_HEIGHT = 280
local MAX_WIDTH  = 800
local MAX_HEIGHT = 700
local CORNER_R   = UDim.new(0, 8)
local CORNER_SM  = UDim.new(0, 5)
local CORNER_XS  = UDim.new(0, 4)

local function makeTween(obj, t, props)
    return TweenService:Create(obj, TweenInfo.new(t, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), props)
end

local function corner(parent, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = r or CORNER_R
    c.Parent = parent
    return c
end

local function stroke(parent, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or Theme.Border
    s.Thickness = thickness or 1
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = parent
    return s
end

local function newFrame(props)
    local f = Instance.new("Frame")
    for k, v in pairs(props or {}) do f[k] = v end
    return f
end

local function newLabel(props)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Font = Enum.Font.GothamMedium
    l.TextColor3 = Theme.Text
    l.TextSize = 13
    for k, v in pairs(props or {}) do l[k] = v end
    return l
end

local function newButton(props)
    local b = Instance.new("TextButton")
    b.Font = Enum.Font.GothamMedium
    b.TextColor3 = Theme.Text
    b.TextSize = 13
    b.AutoButtonColor = false
    for k, v in pairs(props or {}) do b[k] = v end
    return b
end

-- Drag helper
local function makeDraggable(handle, target)
    local dragging = false
    local dragStart, startPos

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = target.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            target.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

-- Resize helper (bottom-right corner handle)
local function makeResizable(resizeHandle, target)
    local resizing = false
    local resizeStart, startSize

    resizeHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = true
            resizeStart = input.Position
            startSize = target.Size
            resizeHandle.BackgroundColor3 = Theme.AccentHover
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - resizeStart
            local newW = math.clamp(startSize.X.Offset + delta.X, MIN_WIDTH, MAX_WIDTH)
            local newH = math.clamp(startSize.Y.Offset + delta.Y, MIN_HEIGHT, MAX_HEIGHT)
            target.Size = UDim2.new(0, newW, 0, newH)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = false
            resizeHandle.BackgroundColor3 = Theme.Handle
        end
    end)

    resizeHandle.MouseEnter:Connect(function()
        resizeHandle.BackgroundColor3 = Theme.AccentHover
    end)
    resizeHandle.MouseLeave:Connect(function()
        if not resizing then
            resizeHandle.BackgroundColor3 = Theme.Handle
        end
    end)
end

-- Notification queue
local notifQueue = {}
local notifContainer

local function setupNotifContainer(screenGui)
    notifContainer = newFrame({
        Name = "NotifContainer",
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 280, 1, 0),
        Position = UDim2.new(1, -290, 0, 0),
        Parent = screenGui,
    })
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Parent = notifContainer

    local pad = Instance.new("UIPadding")
    pad.PaddingBottom = UDim.new(0, 16)
    pad.Parent = notifContainer
end

function HazzyLib:Notify(opts)
    opts = opts or {}
    local title    = opts.Title or "Hazzy"
    local message  = opts.Message or ""
    local duration = opts.Duration or 4
    local color    = opts.Color or Theme.Accent

    local notif = newFrame({
        Name = "Notif",
        BackgroundColor3 = Theme.Surface,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        ClipsDescendants = true,
        Parent = notifContainer,
    })
    corner(notif, CORNER_SM)
    stroke(notif, color, 1)

    local accent = newFrame({
        BackgroundColor3 = color,
        Size = UDim2.new(0, 3, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        Parent = notif,
    })
    corner(accent, UDim.new(0, 2))

    local inner = newFrame({
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -16, 0, 0),
        Position = UDim2.new(0, 12, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Parent = notif,
    })
    local innerLayout = Instance.new("UIListLayout")
    innerLayout.Padding = UDim.new(0, 2)
    innerLayout.Parent = inner

    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 8)
    pad.PaddingBottom = UDim.new(0, 8)
    pad.Parent = inner

    local titleLbl = newLabel({
        Text = title,
        TextColor3 = color,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        Size = UDim2.new(1, 0, 0, 16),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = inner,
    })

    local msgLbl = newLabel({
        Text = message,
        TextColor3 = Theme.TextMuted,
        TextSize = 12,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        Parent = inner,
    })

    notif.BackgroundTransparency = 1
    makeTween(notif, 0.3, { BackgroundTransparency = 0 }):Play()

    task.delay(duration, function()
        makeTween(notif, 0.3, { BackgroundTransparency = 1 }):Play()
        task.wait(0.35)
        notif:Destroy()
    end)
end

-- Main window creator
function HazzyLib:CreateWindow(opts)
    opts = opts or {}
    local title   = opts.Title   or "Hazzy"
    local footer  = opts.Footer  or ""
    local initW   = math.clamp(opts.Width  or 480, MIN_WIDTH, MAX_WIDTH)
    local initH   = math.clamp(opts.Height or 380, MIN_HEIGHT, MAX_HEIGHT)

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "HazzyLib_" .. title
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = 999
    pcall(function() screenGui.Parent = CoreGui end)
    if not screenGui.Parent then
        screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end

    setupNotifContainer(screenGui)

    -- Shadow
    local shadow = newFrame({
        Name = "Shadow",
        BackgroundColor3 = Theme.Shadow,
        BackgroundTransparency = 0.6,
        Size = UDim2.new(0, initW + 12, 0, initH + 12),
        Position = UDim2.new(0.5, -(initW + 12) / 2 + 4, 0.5, -(initH + 12) / 2 + 4),
        ZIndex = 0,
        Parent = screenGui,
    })
    corner(shadow, CORNER_R)

    -- Main window frame
    local win = newFrame({
        Name = "HazzyWindow",
        BackgroundColor3 = Theme.Background,
        Size = UDim2.new(0, initW, 0, initH),
        Position = UDim2.new(0.5, -initW / 2, 0.5, -initH / 2),
        ClipsDescendants = false,
        ZIndex = 1,
        Parent = screenGui,
    })
    corner(win, CORNER_R)
    stroke(win, Theme.Border, 1)

    -- Keep shadow in sync
    RunService.RenderStepped:Connect(function()
        shadow.Size = UDim2.new(0, win.Size.X.Offset + 12, 0, win.Size.Y.Offset + 12)
        shadow.Position = UDim2.new(
            win.Position.X.Scale,
            win.Position.X.Offset - 6,
            win.Position.Y.Scale,
            win.Position.Y.Offset + 4
        )
    end)

    -- Title bar
    local titleBar = newFrame({
        Name = "TitleBar",
        BackgroundColor3 = Theme.Surface,
        Size = UDim2.new(1, 0, 0, 44),
        ZIndex = 2,
        Parent = win,
    })
    corner(titleBar, CORNER_R)
    -- cover bottom corners of title bar
    local titleBarFill = newFrame({
        BackgroundColor3 = Theme.Surface,
        Size = UDim2.new(1, 0, 0, 10),
        Position = UDim2.new(0, 0, 1, -10),
        ZIndex = 2,
        Parent = titleBar,
    })

    local accentLine = newFrame({
        BackgroundColor3 = Theme.Accent,
        Size = UDim2.new(0, 3, 0, 24),
        Position = UDim2.new(0, 14, 0.5, -12),
        ZIndex = 3,
        Parent = titleBar,
    })
    corner(accentLine, UDim.new(0, 2))

    local titleLbl = newLabel({
        Text = title,
        Font = Enum.Font.GothamBold,
        TextSize = 15,
        TextColor3 = Theme.Text,
        Size = UDim2.new(1, -120, 1, 0),
        Position = UDim2.new(0, 26, 0, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 3,
        Parent = titleBar,
    })

    -- Close button
    local closeBtn = newButton({
        Text = "×",
        Font = Enum.Font.GothamBold,
        TextSize = 18,
        TextColor3 = Theme.TextMuted,
        BackgroundColor3 = Theme.SurfaceAlt,
        Size = UDim2.new(0, 28, 0, 28),
        Position = UDim2.new(1, -38, 0.5, -14),
        ZIndex = 4,
        Parent = titleBar,
    })
    corner(closeBtn, UDim.new(0, 6))

    closeBtn.MouseEnter:Connect(function()
        makeTween(closeBtn, 0.15, { BackgroundColor3 = Theme.Danger, TextColor3 = Color3.new(1,1,1) }):Play()
    end)
    closeBtn.MouseLeave:Connect(function()
        makeTween(closeBtn, 0.15, { BackgroundColor3 = Theme.SurfaceAlt, TextColor3 = Theme.TextMuted }):Play()
    end)
    closeBtn.MouseButton1Click:Connect(function()
        makeTween(win, 0.2, { Size = UDim2.new(0, win.Size.X.Offset, 0, 0), BackgroundTransparency = 1 }):Play()
        task.wait(0.25)
        screenGui:Destroy()
    end)

    -- Minimize button
    local minBtn = newButton({
        Text = "–",
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        TextColor3 = Theme.TextMuted,
        BackgroundColor3 = Theme.SurfaceAlt,
        Size = UDim2.new(0, 28, 0, 28),
        Position = UDim2.new(1, -70, 0.5, -14),
        ZIndex = 4,
        Parent = titleBar,
    })
    corner(minBtn, UDim.new(0, 6))

    local minimized = false
    local savedHeight = initH

    minBtn.MouseEnter:Connect(function()
        makeTween(minBtn, 0.15, { BackgroundColor3 = Theme.Warning, TextColor3 = Color3.new(1,1,1) }):Play()
    end)
    minBtn.MouseLeave:Connect(function()
        makeTween(minBtn, 0.15, { BackgroundColor3 = Theme.SurfaceAlt, TextColor3 = Theme.TextMuted }):Play()
    end)
    minBtn.MouseButton1Click:Connect(function()
        if minimized then
            makeTween(win, 0.25, { Size = UDim2.new(0, win.Size.X.Offset, 0, savedHeight) }):Play()
            minimized = false
        else
            savedHeight = win.Size.Y.Offset
            makeTween(win, 0.25, { Size = UDim2.new(0, win.Size.X.Offset, 0, 44) }):Play()
            minimized = true
        end
    end)

    makeDraggable(titleBar, win)

    -- Tab bar
    local tabBar = newFrame({
        Name = "TabBar",
        BackgroundColor3 = Theme.Surface,
        Size = UDim2.new(1, 0, 0, 36),
        Position = UDim2.new(0, 0, 0, 44),
        ZIndex = 2,
        Parent = win,
    })

    local tabBarBorder = newFrame({
        BackgroundColor3 = Theme.Border,
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1),
        ZIndex = 3,
        Parent = tabBar,
    })

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    tabLayout.Padding = UDim.new(0, 4)
    tabLayout.Parent = tabBar

    local tabPad = Instance.new("UIPadding")
    tabPad.PaddingLeft = UDim.new(0, 10)
    tabPad.PaddingRight = UDim.new(0, 10)
    tabPad.Parent = tabBar

    -- Content area
    local contentArea = newFrame({
        Name = "ContentArea",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, -96),
        Position = UDim2.new(0, 0, 0, 80),
        ClipsDescendants = true,
        ZIndex = 1,
        Parent = win,
    })

    -- Footer
    local footerBar = newFrame({
        Name = "Footer",
        BackgroundColor3 = Theme.Surface,
        Size = UDim2.new(1, 0, 0, 24),
        Position = UDim2.new(0, 0, 1, -24),
        ZIndex = 2,
        Parent = win,
    })
    corner(footerBar, CORNER_R)
    local footerFill = newFrame({
        BackgroundColor3 = Theme.Surface,
        Size = UDim2.new(1, 0, 0, 10),
        Position = UDim2.new(0, 0, 0, 0),
        ZIndex = 2,
        Parent = footerBar,
    })
    local footerLbl = newLabel({
        Text = footer,
        TextSize = 11,
        TextColor3 = Theme.TextDim,
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 3,
        Parent = footerBar,
    })

    -- Resize handle (bottom-right corner)
    local resizeHandle = newFrame({
        Name = "ResizeHandle",
        BackgroundColor3 = Theme.Handle,
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(1, -14, 1, -14),
        ZIndex = 10,
        Parent = win,
    })
    corner(resizeHandle, UDim.new(0, 3))

    -- Resize grip dots
    for row = 0, 1 do
        for col = 0, 1 do
            local dot = newFrame({
                BackgroundColor3 = Theme.BorderAccent,
                Size = UDim2.new(0, 3, 0, 3),
                Position = UDim2.new(0, 3 + col * 5, 0, 3 + row * 5),
                ZIndex = 11,
                Parent = resizeHandle,
            })
            corner(dot, UDim.new(1, 0))
        end
    end

    makeResizable(resizeHandle, win)

    -- Tab system
    local tabs = {}
    local activeTab = nil

    local Window = {}
    Window._gui = screenGui
    Window._win = win
    Window._tabs = tabs

    function Window:Notify(opts)
        HazzyLib:Notify(opts)
    end

    function Window:Unload()
        screenGui:Destroy()
    end

    function Window:AddTab(name)
        local tabBtn = newButton({
            Text = name,
            Font = Enum.Font.GothamMedium,
            TextSize = 12,
            TextColor3 = Theme.TabTextMuted,
            BackgroundColor3 = Theme.TabInactive,
            Size = UDim2.new(0, 0, 0, 26),
            AutomaticSize = Enum.AutomaticSize.X,
            ZIndex = 4,
            LayoutOrder = #tabs + 1,
            Parent = tabBar,
        })

        local tabBtnPad = Instance.new("UIPadding")
        tabBtnPad.PaddingLeft  = UDim.new(0, 12)
        tabBtnPad.PaddingRight = UDim.new(0, 12)
        tabBtnPad.Parent = tabBtn
        corner(tabBtn, CORNER_XS)

        -- Tab content page
        local page = newFrame({
            Name = "Page_" .. name,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = false,
            ZIndex = 1,
            Parent = contentArea,
        })

        local scroll = Instance.new("ScrollingFrame")
        scroll.BackgroundTransparency = 1
        scroll.Size = UDim2.new(1, 0, 1, 0)
        scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
        scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
        scroll.ScrollBarThickness = 4
        scroll.ScrollBarImageColor3 = Theme.Accent
        scroll.BorderSizePixel = 0
        scroll.ZIndex = 1
        scroll.Parent = page

        local scrollLayout = Instance.new("UIListLayout")
        scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
        scrollLayout.Padding = UDim.new(0, 8)
        scrollLayout.Parent = scroll

        local scrollPad = Instance.new("UIPadding")
        scrollPad.PaddingLeft   = UDim.new(0, 12)
        scrollPad.PaddingRight  = UDim.new(0, 12)
        scrollPad.PaddingTop    = UDim.new(0, 10)
        scrollPad.PaddingBottom = UDim.new(0, 10)
        scrollPad.Parent = scroll

        local tabObj = {}
        tabObj._btn    = tabBtn
        tabObj._page   = page
        tabObj._scroll = scroll
        tabObj._order  = 0

        table.insert(tabs, tabObj)

        -- Activate tab
        local function activate()
            if activeTab then
                activeTab._page.Visible = false
                makeTween(activeTab._btn, 0.15, {
                    BackgroundColor3 = Theme.TabInactive,
                    TextColor3 = Theme.TabTextMuted,
                }):Play()
            end
            activeTab = tabObj
            page.Visible = true
            makeTween(tabBtn, 0.15, {
                BackgroundColor3 = Theme.TabActive,
                TextColor3 = Theme.TabText,
            }):Play()
        end

        tabBtn.MouseButton1Click:Connect(activate)
        tabBtn.MouseEnter:Connect(function()
            if activeTab ~= tabObj then
                makeTween(tabBtn, 0.1, { BackgroundColor3 = Theme.SurfaceAlt }):Play()
            end
        end)
        tabBtn.MouseLeave:Connect(function()
            if activeTab ~= tabObj then
                makeTween(tabBtn, 0.1, { BackgroundColor3 = Theme.TabInactive }):Play()
            end
        end)

        if not activeTab then activate() end

        -- Groupbox builder
        function tabObj:AddGroupbox(groupTitle, side)
            local groupWrap = newFrame({
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = tabObj._order,
                Parent = scroll,
            })
            tabObj._order = tabObj._order + 1

            local group = newFrame({
                Name = "Group_" .. groupTitle,
                BackgroundColor3 = Theme.Surface,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                Parent = groupWrap,
            })
            corner(group, CORNER_SM)
            stroke(group, Theme.Border, 1)

            local header = newFrame({
                BackgroundColor3 = Theme.SurfaceAlt,
                Size = UDim2.new(1, 0, 0, 30),
                ZIndex = 2,
                Parent = group,
            })
            corner(header, CORNER_SM)
            local headerFill = newFrame({
                BackgroundColor3 = Theme.SurfaceAlt,
                Size = UDim2.new(1, 0, 0, 10),
                Position = UDim2.new(0, 0, 1, -10),
                ZIndex = 2,
                Parent = header,
            })

            local groupTitleLbl = newLabel({
                Text = groupTitle,
                Font = Enum.Font.GothamBold,
                TextSize = 12,
                TextColor3 = Theme.Accent,
                Size = UDim2.new(1, -20, 1, 0),
                Position = UDim2.new(0, 12, 0, 0),
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 3,
                Parent = header,
            })

            local itemList = newFrame({
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                Position = UDim2.new(0, 0, 0, 30),
                Parent = group,
            })
            local itemLayout = Instance.new("UIListLayout")
            itemLayout.SortOrder = Enum.SortOrder.LayoutOrder
            itemLayout.Padding = UDim.new(0, 2)
            itemLayout.Parent = itemList
            local itemPad = Instance.new("UIPadding")
            itemPad.PaddingLeft   = UDim.new(0, 10)
            itemPad.PaddingRight  = UDim.new(0, 10)
            itemPad.PaddingTop    = UDim.new(0, 6)
            itemPad.PaddingBottom = UDim.new(0, 8)
            itemPad.Parent = itemList

            local gOrder = 0
            local groupObj = {}

            local function rowFrame()
                local row = newFrame({
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 32),
                    LayoutOrder = gOrder,
                    Parent = itemList,
                })
                gOrder = gOrder + 1
                return row
            end

            -- AddToggle
            function groupObj:AddToggle(id, opts)
                opts = opts or {}
                local row = rowFrame()
                local enabled = opts.Default or false

                local lbl = newLabel({
                    Text = opts.Text or id,
                    TextSize = 13,
                    TextColor3 = Theme.Text,
                    Size = UDim2.new(1, -50, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = row,
                })

                if opts.Risky then
                    local risk = newLabel({
                        Text = "⚠",
                        TextSize = 12,
                        TextColor3 = Theme.Warning,
                        Size = UDim2.new(0, 16, 1, 0),
                        Position = UDim2.new(0, lbl.Text:len() * 7 + 4, 0, 0),
                        Parent = row,
                    })
                end

                local trackBg = newFrame({
                    BackgroundColor3 = Theme.SurfaceAlt,
                    Size = UDim2.new(0, 40, 0, 22),
                    Position = UDim2.new(1, -44, 0.5, -11),
                    Parent = row,
                })
                corner(trackBg, UDim.new(1, 0))
                stroke(trackBg, Theme.Border, 1)

                local thumb = newFrame({
                    BackgroundColor3 = Theme.TextDim,
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 3, 0.5, -8),
                    Parent = trackBg,
                })
                corner(thumb, UDim.new(1, 0))

                local toggleObj = { Value = enabled }

                local function setToggle(val, silent)
                    enabled = val
                    toggleObj.Value = val
                    if val then
                        makeTween(trackBg, 0.2, { BackgroundColor3 = Theme.Accent }):Play()
                        makeTween(thumb, 0.2, { Position = UDim2.new(0, 21, 0.5, -8), BackgroundColor3 = Color3.new(1,1,1) }):Play()
                    else
                        makeTween(trackBg, 0.2, { BackgroundColor3 = Theme.SurfaceAlt }):Play()
                        makeTween(thumb, 0.2, { Position = UDim2.new(0, 3, 0.5, -8), BackgroundColor3 = Theme.TextDim }):Play()
                    end
                    if not silent and opts.Callback then
                        pcall(opts.Callback, val)
                    end
                end

                function toggleObj:SetValue(val)
                    setToggle(val, false)
                end

                setToggle(enabled, true)

                local btn = Instance.new("TextButton")
                btn.BackgroundTransparency = 1
                btn.Text = ""
                btn.Size = UDim2.new(1, 0, 1, 0)
                btn.ZIndex = 5
                btn.Parent = row

                btn.MouseButton1Click:Connect(function()
                    setToggle(not enabled, false)
                end)

                if opts.Tooltip then
                    btn.MouseEnter:Connect(function()
                        HazzyLib:Notify({ Title = "Info", Message = opts.Tooltip, Duration = 2, Color = Theme.TextMuted })
                    end)
                end

                return toggleObj
            end

            -- AddButton
            function groupObj:AddButton(text, callback)
                local row = rowFrame()
                row.Size = UDim2.new(1, 0, 0, 30)

                local btn = newButton({
                    Text = text,
                    Font = Enum.Font.GothamMedium,
                    TextSize = 12,
                    TextColor3 = Theme.Text,
                    BackgroundColor3 = Theme.SurfaceAlt,
                    Size = UDim2.new(1, 0, 1, 0),
                    Parent = row,
                })
                corner(btn, CORNER_XS)
                stroke(btn, Theme.Border, 1)

                btn.MouseEnter:Connect(function()
                    makeTween(btn, 0.15, { BackgroundColor3 = Theme.AccentMuted, TextColor3 = Theme.AccentHover }):Play()
                end)
                btn.MouseLeave:Connect(function()
                    makeTween(btn, 0.15, { BackgroundColor3 = Theme.SurfaceAlt, TextColor3 = Theme.Text }):Play()
                end)
                btn.MouseButton1Click:Connect(function()
                    makeTween(btn, 0.05, { BackgroundColor3 = Theme.Accent }):Play()
                    task.wait(0.1)
                    makeTween(btn, 0.15, { BackgroundColor3 = Theme.SurfaceAlt }):Play()
                    if callback then pcall(callback) end
                end)
            end

            -- AddLabel
            function groupObj:AddLabel(text)
                local row = rowFrame()
                row.Size = UDim2.new(1, 0, 0, 0)
                row.AutomaticSize = Enum.AutomaticSize.Y

                local lbl = newLabel({
                    Text = text,
                    TextSize = 12,
                    TextColor3 = Theme.TextMuted,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    RichText = true,
                    Parent = row,
                })
            end

            -- AddDivider
            function groupObj:AddDivider()
                local row = rowFrame()
                row.Size = UDim2.new(1, 0, 0, 12)
                local line = newFrame({
                    BackgroundColor3 = Theme.Border,
                    Size = UDim2.new(1, 0, 0, 1),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    Parent = row,
                })
            end

            -- AddDropdown
            function groupObj:AddDropdown(id, opts)
                opts = opts or {}
                local values  = opts.Values or {}
                local current = values[opts.Default or 1] or ""
                local row = rowFrame()
                row.Size = UDim2.new(1, 0, 0, 0)
                row.AutomaticSize = Enum.AutomaticSize.Y

                local lbl = newLabel({
                    Text = opts.Text or id,
                    TextSize = 12,
                    TextColor3 = Theme.TextMuted,
                    Size = UDim2.new(1, 0, 0, 20),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = row,
                })

                local dropBtn = newButton({
                    Text = current .. "  ▾",
                    Font = Enum.Font.GothamMedium,
                    TextSize = 12,
                    TextColor3 = Theme.Text,
                    BackgroundColor3 = Theme.SurfaceAlt,
                    Size = UDim2.new(1, 0, 0, 28),
                    Position = UDim2.new(0, 0, 0, 22),
                    ZIndex = 2,
                    Parent = row,
                })
                corner(dropBtn, CORNER_XS)
                stroke(dropBtn, Theme.Border, 1)

                local open = false
                local dropList

                local dropObj = { Value = current }

                dropBtn.MouseButton1Click:Connect(function()
                    open = not open
                    if open then
                        dropList = newFrame({
                            BackgroundColor3 = Theme.SurfaceAlt,
                            Size = UDim2.new(1, 0, 0, 0),
                            AutomaticSize = Enum.AutomaticSize.Y,
                            Position = UDim2.new(0, 0, 0, 52),
                            ZIndex = 20,
                            Parent = row,
                        })
                        corner(dropList, CORNER_XS)
                        stroke(dropList, Theme.Border, 1)

                        local dLayout = Instance.new("UIListLayout")
                        dLayout.SortOrder = Enum.SortOrder.LayoutOrder
                        dLayout.Parent = dropList

                        for i, val in ipairs(values) do
                            local item = newButton({
                                Text = val,
                                Font = Enum.Font.GothamMedium,
                                TextSize = 12,
                                TextColor3 = val == current and Theme.Accent or Theme.Text,
                                BackgroundColor3 = Theme.SurfaceAlt,
                                Size = UDim2.new(1, 0, 0, 26),
                                ZIndex = 21,
                                LayoutOrder = i,
                                Parent = dropList,
                            })
                            local iPad = Instance.new("UIPadding")
                            iPad.PaddingLeft = UDim.new(0, 10)
                            iPad.Parent = item

                            item.MouseEnter:Connect(function()
                                makeTween(item, 0.1, { BackgroundColor3 = Theme.AccentMuted }):Play()
                            end)
                            item.MouseLeave:Connect(function()
                                makeTween(item, 0.1, { BackgroundColor3 = Theme.SurfaceAlt }):Play()
                            end)
                            item.MouseButton1Click:Connect(function()
                                current = val
                                dropObj.Value = val
                                dropBtn.Text = val .. "  ▾"
                                open = false
                                dropList:Destroy()
                                dropList = nil
                                if opts.Callback then pcall(opts.Callback, val) end
                            end)
                        end
                    else
                        if dropList then dropList:Destroy() dropList = nil end
                    end
                end)

                return dropObj
            end

            -- AddSlider
            function groupObj:AddSlider(id, opts)
                opts = opts or {}
                local min     = opts.Min     or 0
                local max     = opts.Max     or 100
                local default = opts.Default or min
                local current = default

                local row = rowFrame()
                row.Size = UDim2.new(1, 0, 0, 52)

                local lbl = newLabel({
                    Text = (opts.Text or id) .. ": " .. tostring(current),
                    TextSize = 12,
                    TextColor3 = Theme.TextMuted,
                    Size = UDim2.new(1, 0, 0, 18),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = row,
                })

                local track = newFrame({
                    BackgroundColor3 = Theme.SurfaceAlt,
                    Size = UDim2.new(1, 0, 0, 6),
                    Position = UDim2.new(0, 0, 0, 26),
                    Parent = row,
                })
                corner(track, UDim.new(1, 0))

                local fill = newFrame({
                    BackgroundColor3 = Theme.Accent,
                    Size = UDim2.new((current - min) / (max - min), 0, 1, 0),
                    Parent = track,
                })
                corner(fill, UDim.new(1, 0))

                local knob = newFrame({
                    BackgroundColor3 = Color3.new(1,1,1),
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new((current - min) / (max - min), -7, 0.5, -7),
                    ZIndex = 3,
                    Parent = track,
                })
                corner(knob, UDim.new(1, 0))

                local dragging = false
                local sliderObj = { Value = current }

                local function setVal(v)
                    v = math.clamp(math.round(v), min, max)
                    current = v
                    sliderObj.Value = v
                    local t = (v - min) / (max - min)
                    fill.Size = UDim2.new(t, 0, 1, 0)
                    knob.Position = UDim2.new(t, -7, 0.5, -7)
                    lbl.Text = (opts.Text or id) .. ": " .. tostring(v)
                    if opts.Callback then pcall(opts.Callback, v) end
                end

                local clickArea = Instance.new("TextButton")
                clickArea.BackgroundTransparency = 1
                clickArea.Text = ""
                clickArea.Size = UDim2.new(1, 0, 0, 20)
                clickArea.Position = UDim2.new(0, 0, 0, 18)
                clickArea.ZIndex = 5
                clickArea.Parent = row

                clickArea.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end)
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
                end)
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local abs = track.AbsolutePosition
                        local sz  = track.AbsoluteSize
                        local t   = math.clamp((input.Position.X - abs.X) / sz.X, 0, 1)
                        setVal(min + t * (max - min))
                    end
                end)

                setVal(current)
                return sliderObj
            end

            -- AddKeybind (simple display)
            function groupObj:AddKeybind(id, opts)
                opts = opts or {}
                local row = rowFrame()

                local lbl = newLabel({
                    Text = opts.Text or id,
                    TextSize = 13,
                    TextColor3 = Theme.Text,
                    Size = UDim2.new(0.7, 0, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = row,
                })

                local keyLbl = newLabel({
                    Text = tostring(opts.Default or "None"),
                    TextSize = 11,
                    TextColor3 = Theme.TextMuted,
                    BackgroundColor3 = Theme.SurfaceAlt,
                    Size = UDim2.new(0, 70, 0, 22),
                    Position = UDim2.new(1, -74, 0.5, -11),
                    Parent = row,
                })
                corner(keyLbl, CORNER_XS)
                stroke(keyLbl, Theme.Border, 1)
            end

            return groupObj
        end

        -- Shorthand aliases
        function tabObj:AddLeftGroupbox(title)  return self:AddGroupbox(title, "left") end
        function tabObj:AddRightGroupbox(title) return self:AddGroupbox(title, "right") end

        return tabObj
    end

    return Window
end

return HazzyLib
