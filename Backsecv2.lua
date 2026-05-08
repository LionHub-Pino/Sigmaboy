if not getgenv().Bk then

repeat task.wait() until game:IsLoaded()

if getgenv().Lib == "Linoria" then
    getgenv().Repo = "https://raw.githubusercontent.com/bocaj111004/Linoria/refs/heads/main/"
    getgenv().Library = loadstring(game:HttpGet(getgenv().Repo .. "Library.lua"))()
    getgenv().ThemeManager = loadstring(game:HttpGet(getgenv().Repo .. "addons/ThemeManager.lua"))()
    getgenv().SaveManager = loadstring(game:HttpGet(getgenv().Repo .. "addons/SaveManager.lua"))()
elseif getgenv().Lib == "Obsidian" then
    getgenv().Repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
    getgenv().Library = loadstring(game:HttpGet(getgenv().Repo .. "Library.lua"))()
    getgenv().ThemeManager = loadstring(game:HttpGet(getgenv().Repo .. "addons/ThemeManager.lua"))()
    getgenv().SaveManager = loadstring(game:HttpGet(getgenv().Repo .. "addons/SaveManager.lua"))()
elseif getgenv().Lib == "Rayfield" then
    -- Rayfield: mobile-friendly UI library (https://sirius.menu/rayfield)
    getgenv().Library = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
    -- Shim ThemeManager & SaveManager so the rest of the script works unchanged
    getgenv().ThemeManager = {
        SetLibrary = function() end,
        SetFolder   = function() end,
        ApplyToTab  = function() end,
    }
    getgenv().SaveManager = {
        SetLibrary          = function() end,
        IgnoreThemeSettings = function() end,
        SetIgnoreIndexes    = function() end,
        SetFolder           = function() end,
        BuildConfigSection  = function() end,
    }
else
    game.Players.LocalPlayer:Kick("Invalid UI library selected. Use: getgenv().Lib = 'Linoria', 'Obsidian', or 'Rayfield'")
end

local FlyModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/GeorgeRoblox/LINDOR/refs/heads/main/addonsfolder/Fly.lua"))()

    local Environments = loadstring(game:HttpGet("https://raw.githubusercontent.com/bocaj111004/Abysall/refs/heads/main/Components/Environment.luau"))()

    local Functions = {}
    local Connections = {}
    local Globals = {}

    local Services = setmetatable({}, {
    __index = function(self, Key)
        return game:GetService(Key)
    end
})

local VERSION_URL = "https://raw.githubusercontent.com/GeorgeRoblox/version/refs/heads/main/.luau"
local EXPECTED_VERSION = "v.1.0.0"
local FILE_NAME = "DONT_DELEATE_BLACKKING"

if not isfile(FILE_NAME) then
    writefile(FILE_NAME, "VersionCheck Initialized")
end

local success, onlineVersion = pcall(function()
    return game:HttpGet(VERSION_URL)
end)

if not success then
    warn("Version check failed: Could not fetch version")
    return
end

onlineVersion = tostring(onlineVersion):gsub("%s+", "")

if onlineVersion ~= EXPECTED_VERSION then
    local lp = game:GetService("Players").LocalPlayer
    lp:Kick("Your Playing With The version of blackking... Current Version: ".. EXPECTED_VERSION)
    return
end

	local EntityShortNames = {
		["RushMoving"] = "Rush",
		["AmbushMoving"] = "Ambush",
		["A60"] = "A-60",
		["A120"] = "A-120",
		["BackdoorRush"] = "Blitz",
		["Eyes"] = "Eyes",
        ["Lookman"] = "Eyes",
		["BackdoorLookman"] = "Lookman",
        ["CustomEntity"] = "Custom Entity",
		["Lookman"] = "Eyes",
		["GloombatSwarm"] = "Gloombat Swarm",
		["Jeff"] = "Jeff The Killer",
		["Halt"] = "Halt",
		["GlitchRush"] = "RNIUSHCG",
		["GlitchedAmbush"]  = "AR0xMBUSH",
		["CustomEntity"] = "Custom Entity",
		["MonumentEntity"] = "Monument",
		["Groundskeeper"] = "Groundskeeper",
		["FigureRig"] = "Figure",
        ["LiveEntityBramble"] = "Bramble",
        ["FigureRagdoll"] = "Figure",
        ["SallyMoving"] = "Sally",
        ["JeffTheKiller"] = "Jeff The Killer",
	}
    
local ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/bocaj111004/ESPLibrary/refs/heads/main/Library.lua"))()
ESPLibrary:SetRainbow(false)
ESPLibrary:SetShowDistance(false)
ESPLibrary:SetFillTransparency(0.75)
ESPLibrary:SetOutlineTransparency(0)
ESPLibrary:SetFadeTime(0.25)
ESPLibrary:SetTextSize(18)
ESPLibrary:SetFont(Enum.Font.RobotoCondensed)
ESPLibrary:SetTracers(false)
ESPLibrary:SetTracerSize(0.75)
ESPLibrary:SetTracerOrigin("Bottom")
ESPLibrary:SetArrows(false)
ESPLibrary:SetArrowRadius(250)
ESPLibrary:SetDistanceSizeRatio(0.8)
 
local Options = Library.Options
local Toggles = Library.Toggles

local Module = game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules

    	local Screech = Module:FindFirstChild("Screech") or Module:FindFirstChild("Screech_") or Module:FindFirstChild("Screech_Disabled")
	local Dread = Instance.new("Folder")
	if Module:FindFirstChild("Dread") or Module:FindFirstChild("Dread_") or Module:FindFirstChild("Dread_Disabled") then
		Dread = Module:FindFirstChild("Dread") or Module:FindFirstChild("Dread_") or Module:FindFirstChild("Dread_Disabled")
	end

    local RemotesFolder
	if Services.ReplicatedStorage:FindFirstChild("RemotesFolder") then
		RemotesFolder = Services.ReplicatedStorage:FindFirstChild("RemotesFolder")
	elseif Services.ReplicatedStorage:FindFirstChild("EntityInfo") then
		RemotesFolder = Services.ReplicatedStorage:FindFirstChild("EntityInfo")
	else
		RemotesFolder = Services.ReplicatedStorage:FindFirstChild("Bricks")
	end

	ShadeEvent = RemotesFolder:FindFirstChild("ShadeResult") or Instance.new("RemoteEvent")
	FakeShadeEvent = Instance.new("RemoteEvent")
	FakeShadeEvent.Name = "ShadeResult"
	FakeShadeEvent.Parent = ReplicatedStorage

	DreadEvent = RemotesFolder:FindFirstChild("Dread") or Instance.new("RemoteEvent")
	FakeDreadEvent = Instance.new("RemoteEvent")
	FakeDreadEvent.Name = "Dread"
	FakeDreadEvent.Parent = ReplicatedStorage

	A90Event = RemotesFolder:FindFirstChild("A90") or Instance.new("RemoteEvent")
	FakeA90Event = Instance.new("RemoteEvent")
	FakeA90Event.Name = "A90"
	FakeA90Event.Parent = ReplicatedStorage

	ScreechEvent = RemotesFolder:FindFirstChild("Screech") or Instance.new("RemoteEvent")
	FakeScreechEvent = Instance.new("RemoteEvent")
	FakeScreechEvent.Name = "Screech"
	FakeScreechEvent.Parent = ReplicatedStorage

	SurgeEvent = RemotesFolder:FindFirstChild("SurgeRemote") or Instance.new("RemoteEvent")
	FakeSurgeEvent = Instance.new("RemoteEvent")
	FakeSurgeEvent.Name = "SurgeRemote"
	FakeSurgeEvent.Parent = ReplicatedStorage

local SupportedFloors = {
    "Hotel",
    "Mines",
    "Garden",
    "Retro",
    "Ripple",
    "Backdoor",
    "Fools26",
    "Rooms",
    "Party"
}

		local OldHotel = false
			if RemotesFolder.Name == "Bricks" then
				OldHotel = true
		end

local function FloorSupported(name)
    for _, floor in ipairs(SupportedFloors) do
        if floor == name then
            return true
        end
    end
    return false
end

if not FloorSupported(Services.ReplicatedStorage.GameData.Floor.Value) then
    local list = table.concat(SupportedFloors, ", ")
        game.Players.LocalPlayer:Kick("This script doesn't support this floor. SupportedFloors: " .. list)
end

	local function sound()
		local s = Instance.new("Sound")
		s.SoundId = "rbxassetid://4590662766"
		s.Volume = 3
		s.Parent = game:GetService("SoundService")
		s:Play()
	end

local lib = getgenv().Lib
local txt = "BlackKing"

if lib == "Linoria" then
    txt = "BlackKing V3 | Doors"
elseif lib == "Obsidian" then
    txt = "BlackKing"
end

local Window = Library:CreateWindow({
    Title = txt,
    Footer = "BlackKing - V3 | Doors",
    Icon = 127847629875227,
    NotifySide = "Right",
    ShowCustomCursor = true,
})

local Tabs = {
    Info = Window:AddTab("Info", "info"),
	Main = Window:AddTab("General", "paperclip"),
	visual = Window:AddTab("Visuals", "eye"),
	Exploits = Window:AddTab("Exploits", "keyboard"),
	floortab = Window:AddTab("Floor", "lamp-floor"),
	["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}

getgenv().Bk = true

	local infTab = Tabs.Info:AddLeftTabbox()
	local inffirsttab = infTab:AddTab('Update Log')

inffirsttab:AddLabel("<DOORS>")
inffirsttab:AddLabel("<font color='#15ff00'>+ changed code</font>")
inffirsttab:AddLabel("<font color='#15ff00'>+ optimized</font>")
inffirsttab:AddLabel("<font color='#15ff00'>+ fixed bugs</font>")

inffirsttab:AddLabel("<font color='#ff0000'>- removed fly for valid reasons</font>")

	local mnTAB = Tabs.Main:AddLeftTabbox()
	local firsttab = mnTAB:AddTab('General')

		local mctab = Tabs.Main:AddRightTabbox()
	local firsttabMics = mctab:AddTab('Mics')

    		local gntab = Tabs.Main:AddRightTabbox()
	local firsttabGen = gntab:AddTab('General')

Tabs.floortab:UpdateWarningBox({
	Visible = true,
	Title = "Warning",
	Text = "Features highlighted in red do not work in the current floor you are in.",
})

	local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

local Character = Player.Character
while Character == nil do
    task.wait()
    Character = Player.Character
end

local SpeedBypassLabel = firsttab:AddLabel(
    "Speed Bypass: <font color='#FF0000'>Disabled</font>"
)

local function UpdateSpeedBypassLabel(value)
    if value > 6 then
        SpeedBypassLabel:SetText("Speed Bypass: <font color='#00FF00'>Active</font>")
    else
        SpeedBypassLabel:SetText("Speed Bypass: <font color='#FF0000'>Disabled</font>")
    end
end

local SpeedBoostConnection = nil
local SpeedBypassLoop = nil
local WalkSpeedForceConnection = nil

firsttab:AddSlider("SpeedBoostSlie", {
    Text = "Speed Boost",
    Default = 6,
    Min = 0,
    Max = 75,
    Rounding = 1,
    Compact = true,
    Callback = function(value)
        UpdateSpeedBypassLabel(value)
    end
})

local OriginWalkSpeed = nil
local OldHotel = false

local function ApplyWalkSpeedBoost()
    if not Character then return end

    local Humanoid = Character:FindFirstChild("Humanoid")
    if not Humanoid then return end

    if not OriginWalkSpeed then
        OriginWalkSpeed = Humanoid.WalkSpeed
    end

    local boost = Options.SpeedBoostSlie.Value or 0
    Humanoid.WalkSpeed = OriginWalkSpeed + boost
end

local function RestoreWalkSpeed()
    if not Character then return end

    local Humanoid = Character:FindFirstChild("Humanoid")
    if Humanoid and OriginWalkSpeed then
        Humanoid.WalkSpeed = OriginWalkSpeed
    end
end

local function StartWalkSpeedForce()
    if WalkSpeedForceConnection then return end

    WalkSpeedForceConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not OldHotel then return end
        if not Character then return end

        local Humanoid = Character:FindFirstChild("Humanoid")
        if not Humanoid then return end

        local boost = Options.SpeedBoostSlie.Value or 0
        Humanoid.WalkSpeed = (OriginWalkSpeed or Humanoid.WalkSpeed) + boost
    end)
end

local function StopWalkSpeedForce()
    if WalkSpeedForceConnection then
        WalkSpeedForceConnection:Disconnect()
        WalkSpeedForceConnection = nil
    end
end

local function StartSpeedBypassLoop()
    if SpeedBypassLoop then return end

    SpeedBypassLoop = task.spawn(function()
        while task.wait() do
            if not getgenv().SpeedBypass then continue end
            if not Character then continue end

            local slider = Options.SpeedBoostSlie.Value
            local Clone = Character:FindFirstChild("ClonedCollision")
            local HRP = Character:FindFirstChild("HumanoidRootPart")

            if not (Clone and HRP) then continue end

            if slider > 6 then
                SpeedBypassLabel:SetText("Speed Bypass: <font color='#00FF00'>Active</font>")

                if HRP.Anchored then
                    Clone.Massless = true
                    HRP.Massless = false
                    HRP.RootPriority = 0
                    task.wait(1)
                else
                    Clone.Massless = not Clone.Massless
                    HRP.Massless = not HRP.Massless
                    HRP.RootPriority = (HRP.Massless and 1 or 0)
                    task.wait(0.215)
                end
            else
                SpeedBypassLabel:SetText("Speed Bypass: <font color='#FF0000'>Disabled</font>")
                Clone.Massless = true
                HRP.Massless = false
                HRP.RootPriority = 0
            end
        end
    end)
end

Options.SpeedBoostSlie:OnChanged(function(value)
    UpdateSpeedBypassLabel(value)
    if OldHotel then
        ApplyWalkSpeedBoost()
    end
end)

if not Environments.require then
   Library:Notify("<b>[BlackKing]</b>\nSHIT SPLOIT BRO PLS USE EXECUTORS IN https://whatexpsare.online/")
    sound()
else
    print("Good Sploit Detected")
end

firsttab:AddDivider()

firsttab:AddToggle("SpeedBoost", {
    Text = "Enable Speed Boost",
    Default = false,
    Callback = function(enabled)
        if not enabled then
            getgenv().SpeedBypass = false
            OldHotel = false

            local clone = Character:FindFirstChild("ClonedCollision")
                if clone then clone:Destroy() end

            if SpeedBoostConnection then
                SpeedBoostConnection:Disconnect()
                SpeedBoostConnection = nil
            end

            StopWalkSpeedForce()
            RestoreWalkSpeed()

            if Character then
                local HRP = Character:FindFirstChild("HumanoidRootPart")
                if HRP then
                    HRP.Massless = false
                    HRP.RootPriority = 0
                end
            end

            SpeedBypassLabel:SetText("Speed Bypass: <font color='#FF0000'>Disabled</font>")
            return
        end

        task.spawn(function()
            task.wait(0.25)

            if Character then
                local HRP = Character:FindFirstChild("HumanoidRootPart")
                if HRP then
                    HRP.Massless = false
                    HRP.RootPriority = 0
                end

                local clone = Character:FindFirstChild("ClonedCollision")
                if clone then clone:Destroy() end
            end
        end)

        UpdateSpeedBypassLabel(Options.SpeedBoostSlie.Value)

        if RemotesFolder.Name == "Bricks" then
            OldHotel = true
            ApplyWalkSpeedBoost()
            StartWalkSpeedForce()
        end

        getgenv().SpeedBypass = true
        StartSpeedBypassLoop()

        if SpeedBoostConnection then
            SpeedBoostConnection:Disconnect()
        end

        SpeedBoostConnection = game:GetService("RunService").Heartbeat:Connect(function()
            ApplyWalkSpeedBoost()
        end)

        task.spawn(function()
            task.wait(0.35)

            if Character and not Character:FindFirstChild("ClonedCollision") then
                local Collision = Character:WaitForChild("Collision")
                local clone = Collision:Clone()
                clone.Name = "ClonedCollision"
                clone.Parent = Character
                clone.CanCollide = false
                clone.Massless = true

                if clone:FindFirstChild("CollisionCrouch") then
                    clone.CollisionCrouch:Destroy()
                end
            end
        end)
    end
})

game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(NewChar)
    Character = NewChar
    task.wait(0.5)

    if OldHotel then
        OriginWalkSpeed = nil
        ApplyWalkSpeedBoost()
        StartWalkSpeedForce()
    end
end)

if not _G.JumpEnforcer then
    _G.JumpEnforcer = game:GetService("RunService").Heartbeat:Connect(function()
        local char = game.Players.LocalPlayer.Character
        if not char then return end

        if Toggles.EnableJump and Toggles.EnableJump.Value == true then
            if char:GetAttribute("CanJump") ~= true then
                char:SetAttribute("CanJump", true)
            end
        else
            if char:GetAttribute("CanJump") ~= false then
                char:SetAttribute("CanJump", false)
            end
        end
    end)
end

firsttab:AddToggle("EnableJump", {
    Text = "Enable Jump",
    Default = false,
    Tooltip = "Allows you to jump even when the game disables it.",
    Callback = function(value)
        if not Character then return end

        Character:SetAttribute("CanJump", value)
    end
})

task.spawn(function()
    task.wait(0.1)

    if Toggles.EnableJump then
        if Character then
            Character:SetAttribute("CanJump", Toggles.EnableJump.Value)
        end
    end
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.1)
    if Toggles.EnableJump then
        Character:SetAttribute("CanJump", Toggles.EnableJump.Value)
    end
end)

NoAccelerationConnection = nil

ApplyNoAcceleration = function(enabled)
    Character = game.Players.LocalPlayer.Character
    if not Character then return end

    Acceleration = not enabled

    Character.LeftFoot.Massless = Acceleration
    Character.LeftHand.Massless = Acceleration
    Character.LeftLowerArm.Massless = Acceleration
    Character.LeftLowerLeg.Massless = Acceleration
    Character.LeftUpperArm.Massless = Acceleration
    Character.LeftUpperLeg.Massless = Acceleration
    Character.LowerTorso.Massless = Acceleration
    Character.RightFoot.Massless = Acceleration
    Character.RightHand.Massless = Acceleration
    Character.RightLowerArm.Massless = Acceleration
    Character.RightLowerLeg.Massless = Acceleration
    Character.RightUpperArm.Massless = Acceleration
    Character.RightUpperLeg.Massless = Acceleration
    Character.UpperTorso.Massless = Acceleration
end

firsttab:AddToggle("NoAcceleration", {
    Text = "No Acceleration",
    Default = false,
    Tooltip = "Anti Slip",
    Callback = function(enabled)

        if NoAccelerationConnection then
            NoAccelerationConnection:Disconnect()
            NoAccelerationConnection = nil
        end

        ApplyNoAcceleration(enabled)

        if not enabled then return end

        NoAccelerationConnection = Services.RunService.Heartbeat:Connect(function()
            ApplyNoAcceleration(true)
        end)
    end
})

game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.1)

    if Toggles.NoAcceleration and Toggles.NoAcceleration.Value then
        ApplyNoAcceleration(true)

        if NoAccelerationConnection then
            NoAccelerationConnection:Disconnect()
            NoAccelerationConnection = nil
        end

        NoAccelerationConnection = Services.RunService.Heartbeat:Connect(function()
            ApplyNoAcceleration(true)
        end)
    end
end)

ReplicateSignalSupport = false

if replicatesignal then
    ReplicateSignalSupport = true
end

Resetting = false

firsttabMics:AddButton({
    Text = 'Reset Character',
    Func = function()

        if ReplicateSignalSupport then
            replicatesignal(game.Players.LocalPlayer.Kill)
            task.wait(2)

            if LocalPlayer:GetAttribute("Alive") ~= false then
                if RemotesFolder:FindFirstChild("Underwater") then
                    if not Resetting then
                        RemotesFolder.Underwater:FireServer(true)
                        Resetting = true
                    else
                        RemotesFolder.Underwater:FireServer(false)
                        Resetting = false
                    end
                else
                    LocalPlayer.Character:WaitForChild("Humanoid").Health = 0
                end
            end

        else
            if RemotesFolder:FindFirstChild("Underwater") then
                if not Resetting then
                    RemotesFolder.Underwater:FireServer(true)
                    Resetting = true
                else
                    RemotesFolder.Underwater:FireServer(false)
                    Resetting = false
                end
            else
                LocalPlayer.Character:WaitForChild("Humanoid").Health = 0
            end
        end

task.spawn(function()
    local LocalPlayer = game.Players.LocalPlayer
    local gui = LocalPlayer:WaitForChild("PlayerGui")
    local main = gui:WaitForChild("MainUI")

    local function findDeathLabel()
        for _, obj in ipairs(main:GetDescendants()) do
            if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                if obj.Text == "Died to Unknown" then
                    return obj
                end
            end
        end
        return nil
    end

    local deathLabel
    repeat
        deathLabel = findDeathLabel()
        task.wait()
    until deathLabel

    local function update()
        if deathLabel.Text == "Died to Unknown" then
            print("A")
        end
    end

    deathLabel:GetPropertyChangedSignal("Text"):Connect(update)

    update()
end)

    end,

    DoubleClick = (ReplicateSignalSupport and true or false),
    Tooltip = 'Makes you die.'
})


	firsttabMics:AddButton({
		Text = 'Play Again',
		Func = function()
			RemotesFolder.PlayAgain:FireServer()
		end,
		DoubleClick = (true),
		Tooltip = 'Makes You Press Play Again Automaticly.'
	})

	firsttabMics:AddButton({
		Text = 'Return To Lobby',
		Func = function()
			RemotesFolder.Lobby:FireServer()
		end,
		DoubleClick = (true),
		Tooltip = 'Makes You Return Back To Lobby.'
	})

local REACHDOORHACK = false
    firsttabGen:AddToggle('DoorReach', {
		Text = 'Door Reach',
		Default = false,
		Tooltip = nil,
		Callback = function(value)
			REACHDOORHACK = value
		end
	})

    task.spawn(function()
		while task.wait(0.5) do  
			if REACHDOORHACK then
				local ReplicatedStorage = game:GetService("ReplicatedStorage")
				local latestRoom = ReplicatedStorage:WaitForChild("GameData"):WaitForChild("LatestRoom").Value
				local currentRoom = workspace:WaitForChild("CurrentRooms"):FindFirstChild(latestRoom)

				if currentRoom and currentRoom:FindFirstChild("Door") then
					currentRoom.Door:WaitForChild("ClientOpen"):FireServer()
				end
			end
		end
	end)

AutoInteractConnection = nil
AutoInteractRemoval = nil
AutoInteractLoop = nil

repeat task.wait() until Toggles and Options

TrackedPrompts = {}
ActiveFakeConnections = {}

local FakeNames = {
    Lock = true,
    ChestBoxLocked = true,
    Cellar = true,
    Chest_Vine = true,
    CuttableVines = true,
    SkullLock = true,
    Toolbox_Locked = true,
    Lock1 = true,
    Lock2 = true,
}

local AutoInteractPrompts = {
    UnlockPrompt = true,
    ActivateEventPrompt = true,
    LootPrompt = true,
    ModulePrompt = true,
    LeverPrompt = true,
    FusesPrompt = true,
    AwesomePrompt = true,
    LongPushPrompt = true,
    BigPropPrompt = true,
    ValvePrompt = true,
    PartyDoorPrompt = true,
    HerbPrompt = true,
}

local function AutoInteractRequested()
    local toggleEnabled = Toggles.AutoIntr and Toggles.AutoIntr.Value
    local keyHeld = Options.AutoIntrB and Options.AutoIntrB:GetState()
    return toggleEnabled or keyHeld
end

local function RemoveFakePromptOnce(fakePrompt)
    if not fakePrompt or not fakePrompt:IsA("ProximityPrompt") then return end
    if ActiveFakeConnections[fakePrompt] then return end

    local conn
    conn = fakePrompt.Triggered:Connect(function()
        if conn then
            conn:Disconnect()
            ActiveFakeConnections[fakePrompt] = nil
        end
        if fakePrompt.Parent then
            fakePrompt:Destroy()
        end
    end)

    ActiveFakeConnections[fakePrompt] = conn
end

local function TryInteract(prompt)
    if not AutoInteractRequested() then return end
    if not prompt:IsA("ProximityPrompt") then return end
    if not Character then return end

    local hrp = Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local parent = prompt.Parent
    if not parent then return end

    local modelName = parent.Name

    if FakeNames[modelName] then
        local Fake = parent:FindFirstChild("FPrompt", true)
        if Fake and Fake:IsA("ProximityPrompt") then

            RemoveFakePromptOnce(Fake)

            local part = Fake.Parent:IsA("BasePart") and Fake.Parent
                or Fake.Parent:FindFirstChildWhichIsA("BasePart", true)

            if part and (hrp.Position - part.Position).Magnitude <= Options.AutoInteractDistance.Value then
                fireproximityprompt(Fake)
            end

            return
        end
    end

    if not AutoInteractPrompts[prompt.Name] then return end

    local part = parent:IsA("BasePart") and parent
        or parent:FindFirstChildWhichIsA("BasePart", true)

    if part and (hrp.Position - part.Position).Magnitude <= Options.AutoInteractDistance.Value then
        fireproximityprompt(prompt)
    end
end

local function RegisterPrompt(obj)
    if obj:IsA("ProximityPrompt") then
        TrackedPrompts[obj] = true
    end
end

local function UnregisterPrompt(obj)
    if TrackedPrompts[obj] then
        TrackedPrompts[obj] = nil
    end

    if ActiveFakeConnections[obj] then
        ActiveFakeConnections[obj]:Disconnect()
        ActiveFakeConnections[obj] = nil
    end
end

local function StartLoop()
    if AutoInteractLoop then return end

    AutoInteractLoop = task.spawn(function()
        while true do
            task.wait(0.05)

            if AutoInteractRequested() then
                for prompt in pairs(TrackedPrompts) do
                    if not prompt.Parent then
                        UnregisterPrompt(prompt)
                    else
                        TryInteract(prompt)
                    end
                end
            end
        end
    end)
end

function EnableAutoInteractEngine()
    if AutoInteractConnection then return end

    AutoInteractConnection = workspace.DescendantAdded:Connect(RegisterPrompt)
    AutoInteractRemoval = workspace.DescendantRemoving:Connect(UnregisterPrompt)

    for _, obj in ipairs(workspace:GetDescendants()) do
        RegisterPrompt(obj)
    end

    StartLoop()
end

function DisableAutoInteractEngine()
    if AutoInteractConnection then
        AutoInteractConnection:Disconnect()
        AutoInteractConnection = nil
    end

    if AutoInteractRemoval then
        AutoInteractRemoval:Disconnect()
        AutoInteractRemoval = nil
    end

    if AutoInteractLoop then
        task.cancel(AutoInteractLoop)
        AutoInteractLoop = nil
    end

    for fake, conn in pairs(ActiveFakeConnections) do
        conn:Disconnect()
    end

    table.clear(ActiveFakeConnections)
    table.clear(TrackedPrompts)
end

firsttabGen:AddSlider('AutoInteractDistance', {
    Text = 'Interact Distance',
    Default = 12,
    Min = 5,
    Max = 12,
    Rounding = 1,
    Compact = true,
})

firsttabGen:AddToggle("AutoIntr", {
    Text = "Auto Interact",
    Default = false,
    Tooltip = "Interacts with proximity prompts instead of you.",
    Callback = function(enabled)
        if enabled then
            EnableAutoInteractEngine()
        else
            DisableAutoInteractEngine()
        end
    end
}):AddKeyPicker('AutoIntrB', {
    Default = 'R',
    SyncToggleState = true,
    Mode = "Hold",
    Text = 'Auto Interact',
    NoUI = false
})

EnableAutoInteractEngine()

firsttabGen:AddDivider()

InstantPromptConnection = nil
InstantPromptEnabled = false

local function ApplyInstantPrompt(room)
    if not room then return end

    for _, obj in ipairs(room:GetDescendants()) do
        if obj:IsA("ProximityPrompt") then
            obj.HoldDuration = InstantPromptEnabled and 0 or 1
        end
    end
end

firsttabGen:AddToggle("InstandPrompt", {
    Text = "Instant Prompt",
    Default = false,
    Tooltip = "Makes prompts getting interacted with 0 hold duration.",
    Callback = function(enabled)

        InstantPromptEnabled = enabled

        if InstantPromptConnection then
            InstantPromptConnection:Disconnect()
            InstantPromptConnection = nil
        end

        if not enabled then
            for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
                ApplyInstantPrompt(room)
            end
            return
        end

        for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
            ApplyInstantPrompt(room)
        end

        InstantPromptConnection = workspace.CurrentRooms.DescendantAdded:Connect(function(obj)
            if obj:IsA("ProximityPrompt") then
                obj.HoldDuration = 0
            end
        end)
    end
})

DistanceInteractConnection = nil
DistanceInteractEnabled = false

local function ApplyDistanceToRoom(room)
    if not room then return end

    for _, obj in ipairs(room:GetDescendants()) do
        if obj:IsA("ProximityPrompt") then
            obj.MaxActivationDistance = DistanceInteractEnabled and Options.DistanceInteractSizer.Value or 8
        end
    end
end

firsttabGen:AddSlider("DistanceInteractSizer", {
    Text = "Distance",
    Default = 8,
    Min = 8,
    Max = 18,
    Rounding = 1,
    Compact = true,
    Callback = function(value)
        if DistanceInteractEnabled then
            for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
                ApplyDistanceToRoom(room)
            end
        end
    end
})

firsttabGen:AddToggle("DistanceInteract", {
    Text = "Distance Interact",
    Default = false,
    Tooltip = "Lets you interact with prompts from far away.",
    Callback = function(enabled)

        DistanceInteractEnabled = enabled

        if DistanceInteractConnection then
            DistanceInteractConnection:Disconnect()
            DistanceInteractConnection = nil
        end

        if not enabled then
            for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
                ApplyDistanceToRoom(room)
            end
            return
        end

        for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
            ApplyDistanceToRoom(room)
        end

        DistanceInteractConnection = workspace.CurrentRooms.DescendantAdded:Connect(function(obj)
            if obj:IsA("ProximityPrompt") then
                obj.MaxActivationDistance = Options.DistanceInteractSizer.Value
            end
        end)
    end
})



	local vstab = Tabs.visual:AddLeftTabbox()
	local SecTab = vstab:AddTab('Visual')
	local epSet = Tabs.visual:AddRightTabbox()
	local SecTabSet = epSet:AddTab('Settings')
	local notifications = Tabs.visual:AddRightTabbox()
	local SecTabnot = notifications:AddTab('Notifications')

local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local AmbientColor = Color3.fromRGB(255, 255, 255)
local DefaultAmbient = Lighting.Ambient

local AmbientToggleConnection
local AmbientLockConnection

local function TweenAmbient(toColor)
    local tween = TweenService:Create(
        Lighting,
        TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
        { Ambient = toColor }
    )
    tween:Play()
end

local Camera = workspace.CurrentCamera

    Globals.ThirdPersonParts = {}
    for Index, Object in pairs(Character:GetDescendants()) do
        if Object:IsA("Accessory") and Object:FindFirstChild("Handle") then
            table.insert(Globals.ThirdPersonParts, Object.Handle)
        end
    end
    table.insert(Globals.ThirdPersonParts, Character:WaitForChild("Head"))

SecTab:AddToggle("ThirdPersonToggle", {
    Text = "Third Person",
    Default = false,
    Tooltip = "Zooms out your camera, allowing you to see your character from behind."
})

Toggles.ThirdPersonToggle:AddKeyPicker("ThirdPersonKeybind", {
    Text = "Third Person",
    Default = "T",
    Mode = "Toggle",
    SyncToggleState = true
})

SecTab:AddSlider("ThirdPersonOffsetX", {
    Text = "X Offset",
    Min = -10,
    Max = 10,
    Default = 10,
    Rounding = 1,
    Compact = true
})

SecTab:AddSlider("ThirdPersonOffsetY", {
    Text = "Y Offset",
    Min = -10,
    Max = 10,
    Default = 4,
    Rounding = 1,
    Compact = true
})

SecTab:AddSlider("ThirdPersonOffsetZ", {
    Text = "Z Offset",
    Min = -10,
    Max = 20,
    Default = 20,
    Rounding = 1,
    Compact = true
})

ThirdPersonConnection = nil

Toggles.ThirdPersonToggle:OnChanged(function(state)
    if state then
        Camera.CameraType = Enum.CameraType.Scriptable

        ThirdPersonConnection = RunService.RenderStepped:Connect(function()
            if not Character then return end

            local HRP = Character:FindFirstChild("HumanoidRootPart")
            if not HRP then return end

            offset = Vector3.new(
                Options.ThirdPersonOffsetX.Value,
                Options.ThirdPersonOffsetY.Value,
                Options.ThirdPersonOffsetZ.Value
            )

            camPos = HRP.CFrame:ToWorldSpace(CFrame.new(offset))
            targetCFrame = CFrame.new(camPos.Position, HRP.Position)

            Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, 0.15)

            for _, Part in pairs(Globals.ThirdPersonParts) do
                Part.Transparency = 0
                Part.LocalTransparencyModifier = 0
            end
        end)
    else
        if ThirdPersonConnection then
            ThirdPersonConnection:Disconnect()
            ThirdPersonConnection = nil
        end

        Camera.CameraType = Enum.CameraType.Custom
        for _, Part in pairs(Globals.ThirdPersonParts) do
            Part.Transparency = 1
            Part.LocalTransparencyModifier = 1
        end
    end
end)

local CAmbientToggle = SecTab:AddToggle('CAmbient', {
    Text = 'Ambient',
    Default = false,
    Tooltip = 'Changes the Ambient Color.',
})

CAmbientToggle:AddColorPicker("AmbientColor", {
    Default = AmbientColor,
    Title = "Ambient",
    Transparency = 0,

    Callback = function(newColor)
        AmbientColor = newColor
        if CAmbientToggle.Value then
            TweenAmbient(AmbientColor)
        end
    end
})

AmbientToggleConnection = CAmbientToggle:OnChanged(function(state)
    if state == nil then
        return
    end

    if state then
        TweenAmbient(AmbientColor)

        if AmbientLockConnection then
            AmbientLockConnection:Disconnect()
            AmbientLockConnection = nil
        end

        AmbientLockConnection = Lighting.Changed:Connect(function(prop)
            if prop == "Ambient" and Lighting.Ambient ~= AmbientColor then
                TweenAmbient(AmbientColor)
            end
        end)
    else
        TweenAmbient(DefaultAmbient)

        if AmbientLockConnection then
            AmbientLockConnection:Disconnect()
            AmbientLockConnection = nil
        end
    end
end)

local FovLockConnection = nil
local CurrentFov = 70
local DefaultFov = 70

local function GetCamera()
    return workspace.CurrentCamera
end

local function SetFov(Value)
    CurrentFov = Value

    if FovLockConnection then
        FovLockConnection:Disconnect()
        FovLockConnection = nil
    end

    local cam = GetCamera()
    local tween = Services.TweenService:Create(
        cam,
        TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
        { FieldOfView = Value }
    )
    tween:Play()

    tween.Completed:Connect(function()
        FovLockConnection = Services.RunService.RenderStepped:Connect(function()
            local cam = GetCamera()
            if cam then
                cam.FieldOfView = CurrentFov
            end
        end)
    end)
end

SecTab:AddSlider("FovSlider", {
    Text = "Fov",
    Default = 70,
    Min = 10,
    Max = 120,
    Rounding = 1,
    Compact = true,
    Callback = function(Value)
        SetFov(Value)
    end
})

SecTab:AddDivider()

ObjectsTable = ObjectsTable or {}
ObjectsTable.Closets = ObjectsTable.Closets or {}

local TweenService = game:GetService("TweenService")
local Player = game.Players.LocalPlayer

local function ScanClosets()
    ObjectsTable.Closets = {}

    for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
        local assets = room:FindFirstChild("Assets")
        if not assets then continue end

        for _, inst in ipairs(assets:GetChildren()) do
            if inst:FindFirstChild("HiddenPlayer") then
                table.insert(ObjectsTable.Closets, inst)

                for _, part in ipairs(inst:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part:SetAttribute("Transparency", part.Transparency)
                    end
                end
            end
        end
    end
end

workspace.CurrentRooms.ChildAdded:Connect(function()
    task.wait(0.1)
    ScanClosets()
end)

ScanClosets()

function UpdateAllHidingSpots()
    if not ObjectsTable or not ObjectsTable.Closets then
        return
    end

    for _, inst in pairs(ObjectsTable.Closets) do
        local hidden = inst:FindFirstChild("HiddenPlayer")
        if not hidden then continue end

        local parts = {}
        local parts2 = inst:GetDescendants()

        if inst.Name == "Double_Bed" then
            parts2 = inst.Parent:GetDescendants()
        end

        for _, part in ipairs(parts2) do
            if part:IsA("BasePart") and part:GetAttribute("Transparency") ~= nil then
                table.insert(parts, part)
            end
        end

        if not Toggles.TransparentHidingspots.Value then
            for _, e in ipairs(parts) do
                TweenService:Create(
                    e,
                    TweenInfo.new(0.75, Enum.EasingStyle.Quad),
                    { Transparency = e:GetAttribute("Transparency") }
                ):Play()
            end
            continue
        end

        if hidden.Value == Player.Character then
            for _, e in ipairs(parts) do
                TweenService:Create(
                    e,
                    TweenInfo.new(0.75, Enum.EasingStyle.Quad),
                    { Transparency = Options.SpotTransparency.Value }
                ):Play()
            end
        else

            for _, e in ipairs(parts) do
                TweenService:Create(
                    e,
                    TweenInfo.new(0.75, Enum.EasingStyle.Quad),
                    { Transparency = e:GetAttribute("Transparency") }
                ):Play()
            end
        end
    end
end

SecTab:AddSlider("SpotTransparency", {
    Text = "Hiding Spot Transparency",
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 1,
    Compact = true,
    Callback = function(Value)
        UpdateAllHidingSpots()
    end
})

SecTab:AddToggle("TransparentHidingspots", {
    Text = "Transparent Hiding Spot",
    Default = false,
    Tooltip = "Changes the transparency of every hiding spot based on the slider.",
    Callback = function(enabled)
        UpdateAllHidingSpots()
    end
})

task.spawn(function()
    while task.wait(0.1) do
        if Toggles.TransparentHidingspots.Value then
            UpdateAllHidingSpots()
        end
    end
end)

SecTab:AddDivider()

ObjectiveColor = Color3.fromRGB(26, 255, 0)
DoorESPColor   = Color3.fromRGB(0, 199, 255)
SpotESPColor   = Color3.fromRGB(255, 174, 43)
ItemESPColor   = Color3.fromRGB(170, 0, 255)

local ObjectiveESPObjects = {}
local DoorESPObjects      = {}
local SpotESPObjects      = {}
local ObjectiveBlacklist  = {}
local ItemESPObjects      = {}

local ESPConnections = {}

ObjectiveRoomConnection = ObjectiveRoomConnection or nil
ObjectiveDescendantConnection = ObjectiveDescendantConnection or nil
ProcessedObjectives = ProcessedObjectives or {}

local function AddConnection(conn)
    if conn then
        table.insert(ESPConnections, conn)
    end
end
local function ClearObjectiveESP()
    for obj in pairs(ObjectiveESPObjects) do
        ESPLibrary:RemoveESP(obj)
    end
    table.clear(ObjectiveESPObjects)
end
local function ProcessObjective(obj)
    if ProcessedObjectives[obj] then return end
    ProcessedObjectives[obj] = true

    local root = obj:FindFirstAncestorWhichIsA("Model")
    if root and ObjectiveBlacklist[root] then return end
    if not Toggles.Objective.Value then return end

    if obj.Name == "KeyObtain" then
        ESPLibrary:AddESP({
            Object = obj,
            Text   = "Door Key",
            Color  = ObjectiveColor
        })
        ObjectiveESPObjects[obj] = true
        return
    end

    if obj.Name == "FuseObtain" then
        local fusePart = obj:FindFirstChildWhichIsA("BasePart", true)
        if not fusePart then return end

        ESPLibrary:AddESP({
            Object = fusePart,
            Text   = "Generator Fuse",
            Color  = ObjectiveColor
        })
        ObjectiveESPObjects[fusePart] = true

        local function removeFuseESP()
            ESPLibrary:RemoveESP(fusePart)
            ObjectiveESPObjects[fusePart] = nil
            ObjectiveBlacklist[fusePart]  = true
        end

        local c1 = fusePart:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
            if fusePart.LocalTransparencyModifier > 0 then
                removeFuseESP()
                c1:Disconnect()
            end
        end)

        local c2 = fusePart.AncestryChanged:Connect(function(_, parent)
            if not parent then
                removeFuseESP()
                c1:Disconnect()
                c2:Disconnect()
            end
        end)

        AddConnection(c1)
        AddConnection(c2)
        return
    end

    if obj.Name == "Wheel" and obj.Parent and obj.Parent.Name == "WaterPump" then
        if ObjectiveBlacklist[obj] then return end

        ESPLibrary:AddESP({
            Object = obj,
            Text   = "Pump Wheel",
            Color  = ObjectiveColor
        })
        ObjectiveESPObjects[obj] = true

        local sound = obj:FindFirstChild("Sound")
        if sound then
            AddConnection(sound.Played:Once(function()
                ESPLibrary:RemoveESP(obj)
                ObjectiveESPObjects[obj] = nil
                ObjectiveBlacklist[obj]  = true
            end))
        end
        return
    end

    if obj.Name == "ElectricalKeyObtain" then
        ESPLibrary:AddESP({
            Object = obj,
            Text   = "Electrical Key",
            Color  = ObjectiveColor
        })
        ObjectiveESPObjects[obj] = true
        return
    end

    if obj.Name == "LiveHintBook" then
        ESPLibrary:AddESP({
            Object = obj,
            Text   = "Hint Book",
            Color  = ObjectiveColor
        })
        ObjectiveESPObjects[obj] = true
        return
    end

    if obj.Name == "MinesAnchor" then
        local sign  = obj:FindFirstChild("Sign")
        local label = sign and sign:FindFirstChild("TextLabel")
        local anchorText = label and label.Text or "?"

        ESPLibrary:AddESP({
            Object = obj,
            Text   = "Anchor: " .. anchorText,
            Color  = ObjectiveColor
        })
        ObjectiveESPObjects[obj] = true

        local anchorBase = obj:FindFirstChild("AnchorBase")
        if anchorBase then
            local sound = anchorBase:FindFirstChild("SoundStart")
            if sound then
                AddConnection(sound.Played:Once(function()
                    ESPLibrary:RemoveESP(obj)
                    ObjectiveESPObjects[obj] = nil
                    ObjectiveBlacklist[obj]  = true
                end))
            end
        end
        return
    end

    if obj.Name == "LibraryHintPaper" then
        ESPLibrary:AddESP({
            Object = obj,
            Text   = "Library Paper",
            Color  = ObjectiveColor
        })
        ObjectiveESPObjects[obj] = true
        return
    end

    if obj.Name == "CringlePresent" then
        local Box = obj:FindFirstChild("ToolProp")
        if Box then
            ESPLibrary:AddESP({
                Object = Box,
                Text   = "Present",
                Color  = ObjectiveColor
            })
            ObjectiveESPObjects[Box] = true
        end
        return
    end

    if obj.Name == "LiveBreakerPolePickup" then
        ESPLibrary:AddESP({
            Object = obj,
            Text   = "Breaker",
            Color  = ObjectiveColor
        })
        ObjectiveESPObjects[obj] = true
        return
    end

    if root and root.Name == "MinesGenerator" then
        ESPLibrary:AddESP({
            Object = root,
            Text   = "Generator",
            Color  = ObjectiveColor
        })
        ObjectiveESPObjects[root] = true

        local main = root:FindFirstChild("Lever")
        if main and main:FindFirstChild("Sound") then
            AddConnection(main.Sound.Played:Once(function()
                ESPLibrary:RemoveESP(root)
                ObjectiveESPObjects[root] = nil
                ObjectiveBlacklist[root]  = true
            end))
        end
        return
    end

    if root and root.Name == "MinesGateButton" then
        ESPLibrary:AddESP({
            Object = root,
            Text   = "Button",
            Color  = ObjectiveColor
        })
        ObjectiveESPObjects[root] = true

        local main  = root:FindFirstChild("Button")
        local sound = main and main:FindFirstChild("SoundWork")
        if sound then
            AddConnection(sound.Played:Once(function()
                ESPLibrary:RemoveESP(root)
                ObjectiveESPObjects[root] = nil
                ObjectiveBlacklist[root]  = true
            end))
        end
        return
    end

    if root and root.Name == "GardenGateButton" then
        ESPLibrary:AddESP({
            Object = root,
            Text   = "Button",
            Color  = ObjectiveColor
        })
        ObjectiveESPObjects[root] = true

        local main  = root:FindFirstChild("Button")
        local sound = main and main:FindFirstChild("SoundWork")
        if sound then
            AddConnection(sound.Played:Once(function()
                ESPLibrary:RemoveESP(root)
                ObjectiveESPObjects[root] = nil
                ObjectiveBlacklist[root]  = true
            end))
        end
        return
    end

    if obj.Name == "AlaskanVineSet" then
        local Vineg = root and root:FindFirstChild("VineGuillotine")
        local Lever = Vineg and Vineg:FindFirstChild("Lever")
        if Lever then
            ESPLibrary:AddESP({
                Object = Lever,
                Text   = "Breaker",
                Color  = ObjectiveColor
            })
            ObjectiveESPObjects[Lever] = true
        end
        return
    end

    if root and root.Name == "LeverForGate" then
        ESPLibrary:AddESP({
            Object = root,
            Text   = "Gate Lever",
            Color  = ObjectiveColor
        })
        ObjectiveESPObjects[root] = true

        local main = root:FindFirstChild("Main")
        if main and main:FindFirstChild("SoundToPlay") then
            AddConnection(main.SoundToPlay.Played:Once(function()
                ESPLibrary:RemoveESP(root)
                ObjectiveESPObjects[root] = nil
                ObjectiveBlacklist[root]  = true
            end))
        end
        return
    end

    if root and root.Name == "TimerLever" then
        ESPLibrary:AddESP({
            Object = root,
            Text   = "Lever",
            Color  = ObjectiveColor
        })
        ObjectiveESPObjects[root] = true

        local main = root:FindFirstChild("Main")
        if main and main:FindFirstChild("SoundToPlay") then
            AddConnection(main.SoundToPlay.Played:Once(function()
                ESPLibrary:RemoveESP(root)
                ObjectiveESPObjects[root] = nil
                ObjectiveBlacklist[root]  = true
            end))
        end
        return
    end
end

local function ConnectRoom(roomNumber)
    if ObjectiveDescendantConnection then
        ObjectiveDescendantConnection:Disconnect()
        ObjectiveDescendantConnection = nil
    end

    local roomFolder = workspace.CurrentRooms:FindFirstChild(tostring(roomNumber))
    if not roomFolder then return end

    for _, obj in ipairs(roomFolder:GetDescendants()) do
        ProcessObjective(obj)
    end

    ObjectiveDescendantConnection = roomFolder.DescendantAdded:Connect(function(obj)
        ProcessObjective(obj)
    end)

    AddConnection(ObjectiveDescendantConnection)
end

SecTab:AddToggle("Objective", {
    Text    = "Objectives",
    Default = false,
    Tooltip = "Highlights objectives.",
    Callback = function(enabled)
        if not enabled then
            ClearObjectiveESP()
            table.clear(ProcessedObjectives)
            return
        end

        local room = Player:GetAttribute("CurrentRoom")
        if room then
            ClearObjectiveESP()
            table.clear(ProcessedObjectives)
            ConnectRoom(room)
        end
    end
})

Toggles.Objective:AddColorPicker("ObjectiveColor", {
    Default      = ObjectiveColor,
    Title        = "Objectives",
    Transparency = 0,
    Callback     = function(newColor)
        ObjectiveColor = newColor
        for obj in pairs(ObjectiveESPObjects) do
            ESPLibrary:UpdateObjectColor(obj, newColor)
        end
    end
})

local function ClearDoorESP()
    for part in pairs(DoorESPObjects) do
        if part and part.Parent then
            ESPLibrary:RemoveESP(part)
            part:Destroy()
        end
    end
    table.clear(DoorESPObjects)
end

local function CreateDoorESP(roomNumber)
    local Rooms = workspace:WaitForChild("CurrentRooms")
    local Room  = Rooms:FindFirstChild(tostring(roomNumber))
    if not Room then return end

    local DoorFolder = Room:FindFirstChild("Door")
    if not DoorFolder then return end

    local DoorPart = DoorFolder:FindFirstChild("Door")
    if not DoorPart then return end

    if DoorFolder:FindFirstChild("DoorESPPart") then
        DoorFolder.DoorESPPart:Destroy()
    end

    local ESPPart = Instance.new("Part")
    ESPPart.Name          = "DoorESPPart"
    ESPPart.Anchored      = true
    ESPPart.CanCollide    = false
    ESPPart.Transparency  = 0.99
    ESPPart.Color         = DoorESPColor
    ESPPart.Size          = DoorPart.Size
    ESPPart.CFrame        = DoorPart.CFrame
    ESPPart.Parent        = DoorFolder

    local Humanoid = Instance.new("Humanoid")
    Humanoid.Health    = 0
    Humanoid.MaxHealth = 0
    Humanoid.Parent    = DoorFolder

    DoorESPObjects[ESPPart] = true

    ESPLibrary:AddESP({
        Object = ESPPart,
        Text   = "Door",
        Color  = DoorESPColor
    })

    local ClientOpen = DoorFolder:FindFirstChild("ClientOpen")
    if ClientOpen and ClientOpen:IsA("BindableEvent") then
        AddConnection(ClientOpen.Event:Connect(function()
            ESPLibrary:UpdateObjectText(ESPPart, "Door [Opened]")
        end))
    end
end

SecTab:AddToggle("DoorESP", {
    Text    = "Doors",
    Default = false,
    Tooltip = "esps the door.",
    Callback = function(enabled)
        if not enabled then
            ClearDoorESP()
        else
            local room = Player:GetAttribute("CurrentRoom")
            if room then
                CreateDoorESP(room)
            end
        end
    end
})

Toggles.DoorESP:AddColorPicker("DoorESPColor", {
    Default      = DoorESPColor,
    Title        = "Door Color",
    Transparency = 0,
    Callback     = function(newColor)
        DoorESPColor = newColor
        for part in pairs(DoorESPObjects) do
            if part then
                part.Color = newColor
                ESPLibrary:UpdateObjectColor(part, newColor)
            end
        end
    end
})

AddConnection(RunService.Heartbeat:Connect(function()
    if not Toggles.DoorESP.Value then return end

    for espPart in pairs(DoorESPObjects) do
        
        if not espPart or not espPart.Parent then
            ESPLibrary:RemoveESP(espPart)
            DoorESPObjects[espPart] = nil
            continue
        end

        local door = espPart.Parent:FindFirstChild("Door")
        if door then
            espPart.Size  = door.Size
            espPart.CFrame = door.CFrame
        end
    end
end))

local SpotESPObjects = SpotESPObjects or {}
local SpotESPColor   = SpotESPColor or Color3.fromRGB(0, 255, 255)

local function RemoveSpot(obj)
    ESPLibrary:RemoveESP(obj)
    SpotESPObjects[obj] = nil
end

local function ClearSpotESP()
    for obj in pairs(SpotESPObjects) do
        RemoveSpot(obj)
    end
end

local function CleanupDestroyed()
    for obj in pairs(SpotESPObjects) do
        if not obj or not obj.Parent then
            RemoveSpot(obj)
        end
    end
end

local function AddSpotESP(obj, text)
    ESPLibrary:AddESP({
        Object = obj,
        Text   = text,
        Color  = SpotESPColor
    })
    SpotESPObjects[obj] = true
end

local function ScanFolder(folder)
    for _, child in ipairs(folder:GetDescendants()) do
        local name = child.Name

        if name == "Wardrobe"
        or name == "Wardrobe-FOOLS26"
        or name == "RetroWardrobe"
        or name == "Backdoor_Wardrobe"
        or name == "Locker_Large"
        or name == "Toolshed" then
            AddSpotESP(child, "Closet")

        elseif name == "Bed" or name == "Double_Bed" then
            AddSpotESP(child, "Bed")

        elseif name == "Rooms_Locker" then
            AddSpotESP(child, "Locker")

        elseif name == "Rooms_Locker_Fridge" then
            AddSpotESP(child, "Fridge")

        elseif name == "Dumpster" then
            AddSpotESP(child, "Dumpster")

        elseif name == "CircularVent" then
            AddSpotESP(child, "CircularVent")
        end
    end
end

local function CreateSpotESP(roomNumber)
    CleanupDestroyed()

    local Rooms = workspace:WaitForChild("CurrentRooms")
    local Room  = Rooms:FindFirstChild(tostring(roomNumber))
    if not Room then return end

    local Assets = Room:FindFirstChild("Assets")
    if Assets then
        ScanFolder(Assets)
    end

    for _, obj in ipairs(Room:GetChildren()) do
        if string.find(string.lower(obj.Name), "sideroom") then
            local SRAssets = obj:FindFirstChild("Assets")
            if SRAssets then
                ScanFolder(SRAssets)
            end
        end
    end
end

SecTab:AddToggle("SpotESP", {
    Text    = "Hiding Spots",
    Default = false,
    Tooltip = "ESP for Wardrobes.",
    Callback = function(enabled)
        if not enabled then
            ClearSpotESP()
            return
        end

        CleanupDestroyed()

        local room = Player:GetAttribute("CurrentRoom")
        if room then
            CreateSpotESP(room)
        end
    end
})

Toggles.SpotESP:AddColorPicker("SpotESPColor", {
    Default      = SpotESPColor,
    Title        = "Spot Color",
    Transparency = 0,
    Callback     = function(newColor)
        SpotESPColor = newColor
        for obj in pairs(SpotESPObjects) do
            ESPLibrary:UpdateObjectColor(obj, newColor)
        end
    end
})

EntityESPObjects = {}
EntityColor = Color3.fromRGB(255, 0, 0)

local EntityEspNames = {
    ["RushMoving"]        = "Rush",
    ["CustomEntity"]      = "Custom Entity",
    ["AmbushMoving"]      = "Ambush",
    ["GlitchRush"] = "RNIUSHCG",
    ["GlitchedAmbush"]      = "AR0xMBUSH",
    ["A60"]               = "A-60",
    ["A120"]              = "A-120",
    ["Eyes"]              = "Eyes",
    ["Lookman"]           = "Eyes",
    ["FigureRig"]         = "Figure",
    ["FigureRagdoll"]     = "Figure",
    ["LiveEntityBramble"] = "Bramble",
    ["Snare"]             = "Snare",
    ["BackdoorLookman"]   = "Lookman",
    ["BackdoorRush"]      = "Blitz",
    ["GiggleCeiling"]     = "Giggle",
    ["Grumbo"]            = "Grumble",
    ["Groundskeeper"]     = "Groundskeeper",
    ["MonumentEntity"]    = "Monument",
    ["MandrakeLive"]      = "Mandrake",
    ["SallyMoving"]       = "Sally",
    ["JeffTheKiller"]     = "Jeff The Killer",
    ["GloomPile"]         = "Gloom Pile",
    ["GloomPile"]         = "Gloom Pile",
}

function SetupEntityPartESP(entityModel, partName, label)
    local part = entityModel:FindFirstChild(partName)
    if not part then return end

    for _, obj in ipairs(part:GetDescendants()) do
        if obj:IsA("Highlight") then
            obj:Destroy()
        end
    end

    local oldHum = entityModel:FindFirstChild("HighlightHumanoid") or entityModel:FindFirstChild("Humanoid")
    if oldHum then oldHum:Destroy() end

    local hum = Instance.new("Humanoid")
    hum.Name = "HighlightHumanoid"
    hum.Health = 0
    hum.MaxHealth = 0
    hum.Parent = entityModel

    if part:IsA("BasePart") then
        part.Transparency = 0.99
    end

    EntityESPObjects[entityModel] = part

    ESPLibrary:AddESP({
        Object = part,
        Text   = label,
        Color  = EntityColor
    })

    return part
end

local function ClearEntityESP()
    for model, part in pairs(EntityESPObjects) do
        ESPLibrary:RemoveESP(part)
    end
    table.clear(EntityESPObjects)
end

local function CreateEntityESP(entityModel)
    local shortName = EntityEspNames[entityModel.Name] or entityModel.Name

    if entityModel.Name == "FigureRig"
    or entityModel.Name == "GloomPile"
    or entityModel.Name == "JeffTheKiller"
    or entityModel.Name == "FigureRagdoll"
    or entityModel.Name == "LiveEntityBramble"
    or entityModel.Name == "Groundskeeper"
    or entityModel.Name == "GiggleCeiling"
    or entityModel.Name == "SallyMoving" then

        EntityESPObjects[entityModel] = entityModel
        ESPLibrary:AddESP({
            Object = entityModel,
            Text   = shortName,
            Color  = EntityColor
        })
        return
    end

    if entityModel.Name == "Grumbo" then
        SetupEntityPartESP(entityModel, "GrumbleRig", "Grumble")
        return
    end

    if entityModel.Name == "RushMoving" then
        SetupEntityPartESP(entityModel, "RushNew", "Rush")
        return
    end

    if entityModel.Name == "GlitchedAmbush" then
        SetupEntityPartESP(entityModel, "AR0xMBUSH", "AR0xMBUSH")
        return
    end

        if entityModel.Name == "GlitchRush" then
        SetupEntityPartESP(entityModel, "RNIUSHCG", "RNIUSHCG")
        return
    end

    if entityModel.Name == "AmbushMoving" then
        SetupEntityPartESP(entityModel, "RushNew", "Ambush")
        return
    end

    if entityModel.Name == "GlitchAmbush" then
        SetupEntityPartESP(entityModel, "AR0xMBUSH", "AR0xMBUSH")
        return
    end
    
    
    if entityModel.Name == "A60" then
        SetupEntityPartESP(entityModel, "Main", "A-60")
        return
    end

    if entityModel.Name == "A120" then
        SetupEntityPartESP(entityModel, "Main", "A-120")
        return
    end

    if entityModel.Name == "BackdoorRush" then
        SetupEntityPartESP(entityModel, "Main", "Blitz")
        return
    end

    if entityModel.Name == "CustomEntity" then
        SetupEntityPartESP(entityModel, "Scary Entity", "Custom Entity")
        return
    end

    if entityModel.Name == "MonumentEntity" then
        SetupEntityPartESP(entityModel, "Top", "Monument")
        return
    end

    if entityModel.Name == "Eyes" then
        SetupEntityPartESP(entityModel, "Core", "Eyes")
        return
    end

    if entityModel.Name == "Lookman" then
        SetupEntityPartESP(entityModel, "Core", "Eyes")
        return
    end

    if entityModel.Name == "BackdoorLookman" then
        SetupEntityPartESP(entityModel, "Core", "Lookman")
        return
    end

    if entityModel.Name == "Snare" then
        SetupEntityPartESP(entityModel, "SnareBase", "Snare")
        return
    end

    if entityModel.Name == "MandrakeLive" then
        SetupEntityPartESP(entityModel, "Mandrake", "Mandrake")
        return
    end
end

local function ScanForEntities()
    for model, part in pairs(EntityESPObjects) do
        if not model or not model.Parent then
            EntityESPObjects[model] = nil
        end
    end

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and EntityEspNames[obj.Name] then

            if EntityESPObjects[obj] then continue end

            CreateEntityESP(obj)
        end
    end
end

SecTab:AddToggle("EntityESP", {
    Text    = "Entities",
    Default = false,
    Tooltip = "ESP for Rush, Eyes, Figure, Snare.",
    Callback = function(enabled)
        if not enabled then
            ClearEntityESP()
        else
            ScanForEntities()
        end
    end
})

Toggles.EntityESP:AddColorPicker("EntityColor", {
    Default      = EntityColor,
    Title        = "Entity Color",
    Transparency = 0,
    Callback     = function(newColor)
        EntityColor = newColor
        for model, part in pairs(EntityESPObjects) do
            ESPLibrary:UpdateObjectColor(part, newColor)
        end
    end
})

local entityESPAccumulator = 0
AddConnection(RunService.Heartbeat:Connect(function(dt)
    if not Toggles.EntityESP.Value then return end
    entityESPAccumulator = entityESPAccumulator + dt
    if entityESPAccumulator >= 0.25 then
        entityESPAccumulator = 0
        ScanForEntities()
    end
end))


local ItemNames = {
    ["Lighter"] = "Lighter",
    ["Flashlight"] = "Flashlight",
    ["Lockpick"] = "Lockpicks",
    ["Vitamins"] = "Vitamins",
    ["Bandage"] = "Bandage",
    ["StarVial"] = "Vial of Starlight",
    ["StarBottle"] = "Bottle of Starlight",
    ["StarJug"] = "Barrel of Starlight",
    ["Shakelight"] = "Gummy Flashlight",
    ["Straplight"] = "Straplight",
    ["Bulklight"] = "Spotlight",
    ["Battery"] = "Battery",
    ["Candle"] = "Candle",
    ["Crucifix"] = "Crucifix",
    ["CrucifixWall"] = "Crucifix",
    ["Glowsticks"] = "Glowstick",
    ["SkeletonKey"] = "Skeleton Key",
    ["Candy"] = "Candy",
    ["ShieldMini"] = "Mini Shield Potion",
    ["ShieldBig"] = "Big Shield Potion",
    ["BandagePack"] = "Bandage Pack",
    ["BatteryPack"] = "Battery Pack",
    ["RiftCandle"] = "Moonlight Candle",
    ["LaserPointer"] = "Laser Pointer",
    ["HolyGrenade"] = "Hold Hand Grenade",
    ["Shears"] = "Shears",
    ["Smoothie"] = "Smoothie",
    ["Cheese"] = "Cheese",
    ["Bread"] = "Bread",
    ["AlarmClock"] = "Alarm Clock",
    ["RiftSmoothie"] = "Moonlight Smoothie",
    ["GweenSoda"] = "Gween Soda",
    ["GlitchCube"] = "Glitch Fragment",
    ["Scanner"] = "NVCS-3000",
    ["Bomb"] = "Bomb",
    ["Knockbomb"] = "Knockbomb",
    ["Nanner"] = "Nanner",
    ["BigBomb"] = "Big Bomb",
    ["SnakeBox"] = "Hiding Box",
    ["GoldGun"] = "Golden Gun",
    ["StopSign"] = "Stop Sign",
    ["TipJar"] = "Tip Jar",
    ["Lantern"] = "Lantern",
    ["IronKey"] = "Iron Key",
    ["LotusPetal"] = "Lotus Petal",
    ["Compass"] = "Compass",
    ["LotusPetalPickup"] = "Lotus Petal",
    ["LanternLitItem"] = "Lantern",
    ["KeyIron"] = "Iron Key",
    ["IronKeyForCrypt"] = "Iron Key",
    ["LotusHolder"] = "Lotus Petal",
    ["Multitool"] = "Multitool",
    ["RiftJar"] = "Rift Jar",
    ["AloeVera"] = "Aloe Vera",
    ["Donut"] = "Donut",
    ["Lotus"] = "Lotus",
    ["BoxingGloves"] = "Boxing Gloves",
    ["Green_Herb"] = "Herb of Viridis"
}

local ItemESPObjects = ItemESPObjects or {}
local ItemESPColor   = ItemESPColor or Color3.fromRGB(0, 255, 0)

local function ClearItemESP()
    for obj in pairs(ItemESPObjects) do
        ESPLibrary:RemoveESP(obj)
    end
    table.clear(ItemESPObjects)
end

local function ResolveItemRoot(inst)
    while inst and inst ~= workspace do
        if ItemNames[inst.Name] then
            return inst
        end
        inst = inst.Parent
    end
    return nil
end

local function TryAddItem(inst)
    if not Toggles.ItemESP or not Toggles.ItemESP.Value then return end

    local root = ResolveItemRoot(inst)
    if not root then return end

    if ItemESPObjects[root] then return end

    local prompt = root:FindFirstChildWhichIsA("ProximityPrompt", true)
    if not prompt then return end

    ESPLibrary:AddESP({
        Object = root,
        Text   = ItemNames[root.Name],
        Color  = ItemESPColor
    })

    ItemESPObjects[root] = true
end

local function ScanFolder(folder)
    for _, child in ipairs(folder:GetDescendants()) do
        TryAddItem(child)
    end

    if not folder:FindFirstChild("_ItemESPListener") then
        local tag = Instance.new("BoolValue")
        tag.Name = "_ItemESPListener"
        tag.Parent = folder

        local conn = folder.DescendantAdded:Connect(function(child)
            TryAddItem(child)
        end)

        AddConnection(conn)
    end
end

local function CreateItemESP(roomNumber)
    local Rooms = workspace:WaitForChild("CurrentRooms")
    local Room  = Rooms:FindFirstChild(tostring(roomNumber))
    if Room then
        local Assets = Room:FindFirstChild("Assets")
        if Assets then ScanFolder(Assets) end

        for _, obj in ipairs(Room:GetChildren()) do
            if string.find(string.lower(obj.Name), "sideroom") then
                local SRAssets = obj:FindFirstChild("Assets")
                if SRAssets then ScanFolder(SRAssets) end
            end
        end
    end

    local Drops = workspace:FindFirstChild("Drops")
    if Drops then
        ScanFolder(Drops)
    end
end

SecTab:AddToggle("ItemESP", {
    Text    = "Items",
    Default = false,
    Tooltip = "ESP for all items with prompts.",
    Callback = function(enabled)
        if not enabled then
            ClearItemESP()
        else
            local room = Player:GetAttribute("CurrentRoom")
            if room then
                ClearItemESP()
                CreateItemESP(room)
            end
        end
    end
})

Toggles.ItemESP:AddColorPicker("ItemESPColor", {
    Default      = ItemESPColor,
    Title        = "Item Color",
    Transparency = 0,
    Callback     = function(newColor)
        ItemESPColor = newColor

        for obj in pairs(ItemESPObjects) do
            ESPLibrary:UpdateObjectColor(obj, newColor)
        end
    end
})

ChestESPColor = Color3.fromRGB(255, 255, 0)
ChestESPObjects = ChestESPObjects or {}
ChestConnections = ChestConnections or {}
ChestBlacklist = ChestBlacklist or {}

ChestNames = {
    ["Toolshed_Small"] = "Toolshed",
    ["Chest_Vine"] = "Vine Chest",
    ["ChestBox"] = "Chest",
    ["ChestBoxLocked"] = "Chest [Locked]",
    ["MouseHole"] = "Mouse",
    ["Locker_Small_Locked"] = "Locker [Locked]",
    ["Toolbox_Locked"] = "Toolbox [Locked]",
    ["Toolbox"] = "Toolbox",
}

ClearChestESP = function()
    for obj in pairs(ChestESPObjects) do
        ESPLibrary:RemoveESP(obj)
    end
    table.clear(ChestESPObjects)

    for i, conn in ipairs(ChestConnections) do
        if conn and conn.Connected then
            conn:Disconnect()
        end
        ChestConnections[i] = nil
    end
end

TryAddChest = function(child)
    if not Toggles.ChestESP or not Toggles.ChestESP.Value then return end
    if ChestBlacklist[child] then return end

    chestName = ChestNames[child.Name]
    if not chestName then return end
    if ChestESPObjects[child] then return end

    ESPLibrary:AddESP({
        Object = child,
        Text   = chestName,
        Color  = ChestESPColor
    })

    ChestESPObjects[child] = true

    if child.Name == "ChestBox" or child.Name == "ChestBoxLocked" or child.Name == "Locker_Small_Locked" or child.Name == "Toolshed_Small" or child.Name == "Chest_Vine" or child.Name == "Toolbox_Locked" or child.Name == "Toolbox" then
        main = child:FindFirstChild("Main")
        if main then
            openSound = main:FindFirstChild("Open")

            if openSound and openSound:IsA("Sound") then
                conn = openSound.Played:Connect(function()
                    ChestBlacklist[child] = true

                    ESPLibrary:RemoveESP(child)
                    ChestESPObjects[child] = nil

                    if conn then
                        conn:Disconnect()
                        conn = nil
                    end
                end)

                table.insert(ChestConnections, conn)
            end
        end
    end
end

ScanChestFolder = function(folder)
    for _, child in ipairs(folder:GetDescendants()) do
        TryAddChest(child)
    end

    if not folder:FindFirstChild("_ChestESPListener") then
        tag = Instance.new("BoolValue")
        tag.Name = "_ChestESPListener"
        tag.Parent = folder

        conn = folder.DescendantAdded:Connect(function(child)
            TryAddChest(child)
        end)

        table.insert(ChestConnections, conn)
    end
end

CreateChestESP = function(roomNumber)
    Rooms = workspace:WaitForChild("CurrentRooms")
    Room  = Rooms:FindFirstChild(tostring(roomNumber))

    if Room then
        Assets = Room:FindFirstChild("Assets")
        if Assets then ScanChestFolder(Assets) end

        for _, obj in ipairs(Room:GetChildren()) do
            if string.find(string.lower(obj.Name), "sideroom") then
                SRAssets = obj:FindFirstChild("Assets")
                if SRAssets then ScanChestFolder(SRAssets) end
            end
        end
    end

    Drops = workspace:FindFirstChild("Drops")
    if Drops then ScanChestFolder(Drops) end
end

SecTab:AddToggle("ChestESP", {
    Text    = "Chests",
    Default = false,
    Tooltip = "ESP for chests, toolsheds, vine chests, mouse holes.",
    Callback = function(enabled)
        if not enabled then
            ClearChestESP()
        else
            room = Player:GetAttribute("CurrentRoom")
            if room then
                ClearChestESP()
                CreateChestESP(room)
            end
        end
    end
})

Toggles.ChestESP:AddColorPicker("ChestESPColor", {
    Default      = ChestESPColor,
    Title        = "Chest Color",
    Transparency = 0,
    Callback     = function(newColor)
        ChestESPColor = newColor

        for obj in pairs(ChestESPObjects) do
            ESPLibrary:UpdateObjectColor(obj, newColor)
        end
    end
})

CurrencyESPObjects = {}
CurrencyConnections = {}
CurrencyColor = Color3.fromRGB(255, 215, 0)

function ClearCurrencyESP()
    for obj in pairs(CurrencyESPObjects) do
        ESPLibrary:RemoveESP(obj)
    end
    table.clear(CurrencyESPObjects)

    for i, conn in ipairs(CurrencyConnections) do
        if conn and conn.Connected then
            conn:Disconnect()
        end
        CurrencyConnections[i] = nil
    end
end

function TryAddCurrency(obj)
    if not Toggles.CurrencyESP or not Toggles.CurrencyESP.Value then
        return
    end

    if obj.Name ~= "GoldPile" and obj.Name ~= "StardustPickup" then
        return
    end

    if CurrencyESPObjects[obj] then
        return
    end

    if obj.Name == "GoldPile" then
        local amount = obj:GetAttribute("GoldValue") or 0

        ESPLibrary:AddESP({
            Object = obj,
            Text   = "Gold Pile [" .. tostring(amount) .. "]",
            Color  = CurrencyColor
        })

        CurrencyESPObjects[obj] = true

        local conn = obj:GetAttributeChangedSignal("GoldValue"):Connect(function()
            local newAmount = obj:GetAttribute("GoldValue") or 0
            ESPLibrary:UpdateObjectText(obj, "Gold Pile [" .. tostring(newAmount) .. "]")
        end)

        table.insert(CurrencyConnections, conn)
        return
    end

    if obj.Name == "StardustPickup" then
        ESPLibrary:AddESP({
            Object = obj,
            Text   = "Stardust",
            Color  = CurrencyColor
        })

        CurrencyESPObjects[obj] = true
        return
    end
end

function ScanCurrencyFolder(folder)
    for _, child in ipairs(folder:GetDescendants()) do
        TryAddCurrency(child)
    end
    if not folder:FindFirstChild("_CurrencyESPListener") then
        local tag = Instance.new("BoolValue")
        tag.Name = "_CurrencyESPListener"
        tag.Parent = folder

        local conn = folder.DescendantAdded:Connect(function(child)
            TryAddCurrency(child)
        end)

        table.insert(CurrencyConnections, conn)
    end
end

function CreateCurrencyESP(roomNumber)
    local Rooms = workspace:WaitForChild("CurrentRooms")
    local Room  = Rooms:FindFirstChild(tostring(roomNumber))
    if Room then
        local Assets = Room:FindFirstChild("Assets")
        if Assets then ScanCurrencyFolder(Assets) end

        for _, obj in ipairs(Room:GetChildren()) do
            if string.find(string.lower(obj.Name), "sideroom") then
                local SRAssets = obj:FindFirstChild("Assets")
                if SRAssets then ScanCurrencyFolder(SRAssets) end
            end
        end
    end
end

SecTab:AddToggle("CurrencyESP", {
    Text    = "Currency",
    Default = false,
    Tooltip = "ESP for gold piles.",
    Callback = function(enabled)
        if not enabled then
            ClearCurrencyESP()
        else
            local room = Player:GetAttribute("CurrentRoom")
            if room then
                ClearCurrencyESP()
                CreateCurrencyESP(room)
            end
        end
    end
})

Toggles.CurrencyESP:AddColorPicker("CurrencyColor", {
    Default      = CurrencyColor,
    Title        = "Currency Color",
    Transparency = 0,
    Callback     = function(newColor)
        CurrencyColor = newColor

        for obj in pairs(CurrencyESPObjects) do
            ESPLibrary:UpdateObjectColor(obj, newColor)
        end
    end
})

PlayerESPObjects = PlayerESPObjects or {}
PlayerColor = PlayerColor or Color3.fromRGB(255, 255, 255)

function RemovePlayerESP(char)
    ESPLibrary:RemoveESP(char)
    PlayerESPObjects[char] = nil
end

function ClearPlayerESP()
    for char in pairs(PlayerESPObjects) do
        RemovePlayerESP(char)
    end
end

function CleanupDestroyedPlayers()
    for char in pairs(PlayerESPObjects) do
        if not char or not char.Parent then
            RemovePlayerESP(char)
        end
    end
end

function CreatePlayerESP(plr)
    if plr == game.Players.LocalPlayer then return end
    if not plr.Character then return end

    local char = plr.Character
    if PlayerESPObjects[char] then return end

    ESPLibrary:AddESP({
        Object = char,
        Text   = plr.Name,
        Color  = PlayerColor
    })

    PlayerESPObjects[char] = true
end

function ScanPlayers()
    CleanupDestroyedPlayers()

    for _, plr in ipairs(game.Players:GetPlayers()) do
        CreatePlayerESP(plr)
    end
end

game.Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        if Toggles.PlayerESP and Toggles.PlayerESP.Value then
            task.wait(0.2)
            CreatePlayerESP(plr)
        end
    end)
end)

SecTab:AddToggle("PlayerESP", {
    Text    = "Players",
    Default = false,
    Tooltip = "ESP for other players.",
    Callback = function(enabled)
        if not enabled then
            ClearPlayerESP()
            return
        end
        ScanPlayers()
    end
})

Toggles.PlayerESP:AddColorPicker("PlayerColor", {
    Default      = PlayerColor,
    Title        = "Player Color",
    Transparency = 0,
    Callback     = function(newColor)
        PlayerColor = newColor
        for char in pairs(PlayerESPObjects) do
            ESPLibrary:UpdateObjectColor(char, newColor)
        end
    end
})

AddConnection(Player:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
    local room = Player:GetAttribute("CurrentRoom")
    if not room then return end

    if Toggles.Objective.Value then
        ClearObjectiveESP()
        table.clear(ProcessedObjectives)
        ConnectRoom(room)
    end

    if Toggles.DoorESP.Value then
        ClearDoorESP()
        CreateDoorESP(room)
    end

    if Toggles.SpotESP.Value then
        ClearSpotESP()
        CreateSpotESP(room)
    end

    if Toggles.ItemESP and Toggles.ItemESP.Value then
        ClearItemESP()
        CreateItemESP(room)
    end

    if Toggles.ChestESP and Toggles.ChestESP.Value then
        ClearChestESP()
        CreateChestESP(room)
    end

    if Toggles.CurrencyESP and Toggles.CurrencyESP.Value then
        ClearCurrencyESP()
        CreateCurrencyESP(room)
    end
end))

SecTabSet:AddSlider('SetFadeTime', {
		Text = 'FadeTime ',
		Default = 0.5,
		Min = 0,
		Max = 2,
		Rounding = 1,
		Compact = true,
		Callback = function(Value)
			ESPLibrary:SetFadeTime(Value) 
		end
	})

	SecTabSet:AddSlider('TracerSizer', {
		Text = 'Tracer Size ',
		Default = 1,
		Min = 1,
		Max = 3,
		Rounding = 1,
		Compact = true,
		Callback = function(Value)
			ESPLibrary:SetTracerSize(Value)
		end
	})

    	SecTabSet:AddSlider('FillTransparency', {
		Text = 'Fill Transparency',
		Default = 0.75,
		Min = 0,
		Max = 1,
		Rounding = 2,
		Compact = true,
		Callback = function(Value)
			ESPLibrary:SetFillTransparency(Value)
		end
	})

    	SecTabSet:AddSlider('TextSizer', {
		Text = 'Text Size ',
		Default = 18,
		Min = 12,
		Max = 24,
		Rounding = 0,
		Compact = true,
		Callback = function(Value)
			ESPLibrary:SetTextSize(Value)
		end
	})

	SecTabSet:AddDivider()

	SecTabSet:AddToggle("DistancesEsp", {
		Text = "Distances",
		Default = false,
		Tooltip = nil,
		Callback = function(Value)
			ESPLibrary:SetShowDistance(Value)
		end,
	})

	SecTabSet:AddToggle("TracersEsp", {
		Text = "Tracers",
		Default = false,
		Tooltip = nil,
		Callback = function(Value)
			ESPLibrary:SetTracers(Value)
		end,
	})

	SecTabSet:AddToggle("ArrowsEsp", {
		Text = "Arrows",
		Default = false,
		Tooltip = nil,
		Callback = function(Value)
			ESPLibrary:SetArrows(Value)
		end,
	})

	SecTabSet:AddToggle("RainbowEsp", {
		Text = "Rainbow Esp",
		Default = false,
		Tooltip = nil,
		Callback = function(Value)
			ESPLibrary:SetRainbow(Value)
		end,
	})

	SecTabSet:AddDivider()

	SecTabSet:AddDropdown("ESPTextFont", {
    Text = "Text Font",
    Values = {
        "Legacy",
        "Arial",
        "ArialBold",
        "SourceSans",
        "SourceSansBold",
        "SourceSansLight",
        "SourceSansItalic",
        "Bodoni",
        "Garamond",
        "Cartoon",
        "Code",
        "Highway",
        "SciFi",
        "Arcade",
        "Fantasy",
        "Antique",
        "SourceSansSemibold",
        "Gotham",
        "GothamMedium",
        "GothamBold",
        "GothamBlack",
        "AmaticSC",
        "Bangers",
        "Creepster",
        "DenkOne",
        "Fondamento",
        "FredokaOne",
        "GrenzeGotisch",
        "IndieFlower",
        "JosefinSans",
        "Jura",
        "Kalam",
        "LuckiestGuy",
        "Merriweather",
        "Michroma",
        "Nunito",
        "Oswald",
        "PatrickHand",
        "PermanentMarker",
        "Roboto",
        "RobotoCondensed",
        "RobotoMono",
        "Sarpanch",
        "SpecialElite",
        "TitilliumWeb",
        "Ubuntu",
        "BuilderSans",
        "BuilderSansMedium",
        "BuilderSansBold",
        "BuilderSansExtraBold",
        "Arimo",
        "ArimoBold",
        },
    Default = 41
})

notified = {}
notifiedHalt = false

-- ── Mobile-friendly on-screen mob alert ──────────────────────────────────────
-- Creates a large, auto-dismissing notification directly on the PlayerGui
-- so players can see it even on mobile without opening the script menu.
local function ShowMobAlert(entityName, tipText)
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local lp = Players.LocalPlayer
    local pg = lp:WaitForChild("PlayerGui")

    -- Remove any existing alert
    local old = pg:FindFirstChild("BK_MobAlert")
    if old then old:Destroy() end

    local sg = Instance.new("ScreenGui")
    sg.Name = "BK_MobAlert"
    sg.ResetOnSpawn = false
    sg.IgnoreGuiInset = true
    sg.DisplayOrder = 999
    sg.Parent = pg

    local frame = Instance.new("Frame")
    frame.Name = "AlertFrame"
    frame.Size = UDim2.new(0.72, 0, 0, 110)
    frame.Position = UDim2.new(0.14, 0, 0, -120)   -- starts above screen
    frame.AnchorPoint = Vector2.new(0, 0)
    frame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    frame.BorderSizePixel = 0
    frame.Parent = sg

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 14)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2.5
    stroke.Color = Color3.fromRGB(255, 60, 60)
    stroke.Parent = frame

    -- Accent bar on left
    local accent = Instance.new("Frame")
    accent.Size = UDim2.new(0, 5, 1, -16)
    accent.Position = UDim2.new(0, 8, 0, 8)
    accent.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    accent.BorderSizePixel = 0
    accent.Parent = frame
    local aCorner = Instance.new("UICorner")
    aCorner.CornerRadius = UDim.new(1, 0)
    aCorner.Parent = accent

    -- Entity name label
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -30, 0, 46)
    titleLabel.Position = UDim2.new(0, 22, 0, 6)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "⚠ " .. entityName .. " đã xuất hiện!"
    titleLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.RichText = true
    titleLabel.Parent = frame

    -- Tip label
    local tipLabel = Instance.new("TextLabel")
    tipLabel.Size = UDim2.new(1, -30, 0, 52)
    tipLabel.Position = UDim2.new(0, 22, 0, 50)
    tipLabel.BackgroundTransparency = 1
    tipLabel.Text = tipText or "Hãy ẩn nấp ngay!"
    tipLabel.TextColor3 = Color3.fromRGB(210, 210, 210)
    tipLabel.TextScaled = true
    tipLabel.Font = Enum.Font.Gotham
    tipLabel.TextXAlignment = Enum.TextXAlignment.Left
    tipLabel.TextWrapped = true
    tipLabel.Parent = frame

    -- Slide in from top
    local tweenIn = TweenService:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.14, 0, 0, 14)
    })
    tweenIn:Play()

    -- Auto-dismiss after 5 seconds
    task.delay(5, function()
        if not sg.Parent then return end
        local tweenOut = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0.14, 0, 0, -130)
        })
        tweenOut:Play()
        tweenOut.Completed:Connect(function()
            sg:Destroy()
        end)
    end)
end
-- ── End ShowMobAlert ──────────────────────────────────────────────────────────

CustomMessages = {
    Rush = "<b>[BlackKing]</b>\nEntity 'Rush' has spawned, find a hiding spot.",
    Ambush = "<b>[BlackKing]</b>\nEntity 'Ambush' has spawned, find a hiding spot.",
    Blitz = "<b>[BlackKing]</b>\nEntity 'Blitz' has spawned, find a hiding spot.",
    Eyes = "<b>[BlackKing]</b>\nEntity 'Eyes' has spawned, avoid looking at them.",
    Lookman = "<b>[BlackKing]</b>\nEntity 'Lookman' has spawned, avoid looking at him.",
    ["Jeff The Killer"] = "<b>[BlackKing]</b>\nEntity 'Jeff The Killer' has spawned in the next room.",
    ["Custom Entity"] = "<b>[BlackKing]</b>\nA custom entity has spawned, find a hiding spot.",
    ["A-60"] = "<b>[BlackKing]</b>\nEntity 'A-60' has spawned, find a hiding spot.",
    ["A-120"] = "<b>[BlackKing]</b>\nEntity 'A-120' has spawned, find a hiding spot (Position spoof doesnt work).",
    ["Gloombat Swarm"] = "<b>[BlackKing]</b>\nA Gloombat Swarm has appeared, turn off light sources for a few rooms.",
    Halt = "<b>[BlackKing]</b>\nEntity 'Halt' will spawn in the next room.",
    Sally = "<b>[BlackKing]</b>\nEntity 'Sally' has spawned, give her a item",
    Groundskeeper = "<b>[BlackKing]</b>\nEntity 'Groundskeeper' has spawned, dont step on the grass.",
    Monument = "<b>[BlackKing]</b>\nEntity 'Monument' has spawned, look at it.",
    RNIUSHCG = "<b>[BlackKing]</b>\nEntity 'RNIUSHCG' has spawned, find a hiding spot.",
    AR0xMBUSH = "<b>[BlackKing]</b>\nEntity 'AR0xMBUSH' has spawned, find a hiding spot."
}

SecTabnot:AddDropdown('NotifyMonsters', {
    Values = {"Rush","Ambush","Blitz","Eyes","Lookman","Jeff The Killer","Custom Entity","A-60","A-120","Gloombat Swarm","Halt","Sally","Groundskeeper","Monument","RNIUSHCG","AR0xMBUSH"},
    Default = {},
    Multi = true,
    Compact = true,
    Text = 'Entity List',
    Tooltip = 'Select which Entities should notify you when they spawn'
})

SecTabnot:AddToggle('NotifyEntities', {
    Default = false,
    Text = 'Notify Entities',
    Tooltip = 'Notifies the Entities You Chose.'
})

SecTabnot:AddToggle("EntityChatToggle", {
    Text = "Chat Message",
    Default = false,
    Tooltip = "Sends a message in the chat when an entity spawns."
})

SecTabnot:AddInput("EntityChatMessage", {
    Text = "Message",
    Default = "Has Spawned!",
    Numeric = false,
    Placeholder = "Message"
})

Functions.SendChat = function(Message)
    Folder = Services.ReplicatedStorage:FindFirstChild("DefaultChatSystemEvents") or Instance.new("Folder")
    Event = Folder:FindFirstChild("SayMessageRequest") or Instance.new("RemoteEvent")
    Event:FireServer(Message ,"All")

    Channel = (Services.TextChatService:FindFirstChild("TextChannels") and Services.TextChatService.TextChannels:FindFirstChild("RBXGeneral") or Instance.new("TextChannel"))
    Channel:SendAsync(Message)
end

CheckForHalt = function(instance)
    if not Toggles.NotifyEntities.Value then return end
    if not Options.NotifyMonsters.Value["Halt"] then return end
    if notifiedHalt then return end
    if Floor == "Party" then return end

    rawName = instance:GetAttribute("RawName")
    hasShade = instance:GetAttribute("Shade") ~= nil

    if (rawName and rawName:find("Halt")) or hasShade then
        Library:Notify(CustomMessages["Halt"])
        sound()
        task.spawn(function() ShowMobAlert("Halt", "Halt sẽ xuất hiện phòng tiếp theo, hãy chuẩn bị!") end)
        notifiedHalt = true

        if Toggles.EntityChatToggle.Value then
            Functions.SendChat("[BlackKing] Halt is in the next room.")
        end
    end
end

CheckForHaltRemoval = function(instance)
    rawName = instance:GetAttribute("RawName")
    hasShade = instance:GetAttribute("Shade") ~= nil

    if (rawName and rawName:find("Halt")) or hasShade then
        notifiedHalt = false
    end
end

workspace.DescendantAdded:Connect(function(desc)
    CheckForHalt(desc)
end)

workspace.DescendantRemoving:Connect(function(desc)
    CheckForHaltRemoval(desc)
end)

workspace.CurrentRooms.ChildAdded:Connect(function(room)
    room.DescendantAdded:Connect(function(desc)
        CheckForHalt(desc)
    end)

    room.DescendantRemoving:Connect(function(desc)
        CheckForHaltRemoval(desc)
    end)
end)

workspace.ChildAdded:Connect(function(child)
    if not Toggles.NotifyEntities.Value then return end

    for instanceName, shortName in pairs(EntityShortNames) do
        if child.Name == instanceName and child:IsDescendantOf(workspace) then

            if Options.NotifyMonsters.Value[shortName] and not notified[child] then
                msg = CustomMessages[shortName] or ("<b>[BlackKing]</b>\nEntity '"..shortName.."' has spawned.")
                Library:Notify(msg)
                sound()

                -- Show mobile-friendly on-screen alert
                local tip = CustomMessages[shortName] and CustomMessages[shortName]:match("\n(.+)$") or "Hãy ẩn nấp ngay!"
                tip = tip:gsub("<.->", "")  -- strip rich text tags
                task.spawn(function() ShowMobAlert(shortName, tip) end)

                notified[child] = true

                if Toggles.EntityChatToggle.Value then
                    Functions.SendChat("[BlackKing] ".. shortName .. " " .. Options.EntityChatMessage.Value)
                end
            end
        end
    end
end)

workspace.ChildRemoved:Connect(function(child)
    if notified[child] then
        notified[child] = nil
    end
end)

workspace.CurrentRooms.ChildAdded:Connect(function(room)
    if not Toggles.NotifyEntities.Value then return end
    if not Options.NotifyMonsters.Value["Groundskeeper"] then return end

    if room:IsA("Model") then
        room.ChildAdded:Connect(function(child)
            if child.Name == "Groundskeeper" and not notified["Groundskeeper"] then
                Library:Notify(CustomMessages["Groundskeeper"])
                sound()
                task.spawn(function() ShowMobAlert("Groundskeeper", "Đừng giẫm lên cỏ!") end)

                notified["Groundskeeper"] = true

                if Toggles.EntityChatToggle.Value then
                    Functions.SendChat("[BlackKing] Groundskeeper " .. Options.EntityChatMessage.Value)
                end
            end
        end)

        room.ChildRemoved:Connect(function(child)
            if child.Name == "Groundskeeper" then
                notified["Groundskeeper"] = false
            end
        end)
    end
end)

ShowTimerConnection = nil

SecTabnot:AddToggle("ShowTimer", {
    Text = "Show Timer",
    Tooltip = "Shows you how much time is left on the screen.",
    Callback = function(enabled)

        local DigitalTimer = Services.ReplicatedStorage.FloorReplicated:WaitForChild("DigitalTimer")

        if not enabled then
            if ShowTimerConnection then
                ShowTimerConnection:Disconnect()
                ShowTimerConnection = nil
            end

            local MainUI = Player.PlayerGui.MainUI
            for _, child in ipairs(MainUI:GetChildren()) do
                if child.Name == "LiveCaption_Timer" then
                    child:Destroy()
                end
            end

            return
        end

ShowTimerConnection = DigitalTimer.Changed:Connect(function(newValue)

    local minutes = math.floor(newValue / 60)
    local seconds = newValue % 60
    local formatted = string.format("%02d:%02d", minutes, seconds)

    local MainUI = Player.PlayerGui.MainUI
    local Caption = MainUI.MainFrame:WaitForChild("Caption")

    for _, child in ipairs(MainUI:GetChildren()) do
        if child.Name == "LiveCaption_Timer" then
            child:Destroy()
        end
    end

local TimerFrame = Instance.new("Frame")
TimerFrame.Name = "LiveCaption_Timer"
TimerFrame.Parent = MainUI

TimerFrame.Size = UDim2.new(0, 181, 0, 100)

TimerFrame.Position = Caption.Position
TimerFrame.AnchorPoint = Caption.AnchorPoint

TimerFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TimerFrame.BorderSizePixel = 0

local Stroke = Instance.new("UIStroke")
Stroke.Parent = TimerFrame
Stroke.Thickness = 2
Stroke.Color = Library.Scheme.AccentColor

local Corner = Instance.new("UICorner")
Corner.Parent = TimerFrame
Corner.CornerRadius = UDim.new(0, 6)

local Label = Instance.new("TextLabel")
Label.Parent = TimerFrame
Label.Size = UDim2.new(1, 0, 1, 0)
Label.BackgroundTransparency = 1
Label.Text = formatted
Label.TextColor3 = Color3.fromRGB(255, 222, 189)
Label.Font = Options.ESPTextFont.Value
Label.TextSize = 32 
Label.TextStrokeTransparency = 0.5

Label.TextXAlignment = Enum.TextXAlignment.Center
Label.TextYAlignment = Enum.TextYAlignment.Center

task.spawn(function()
    while TimerFrame.Parent do
        Stroke.Color = Library.Scheme.AccentColor
        task.wait(0.1)
    end
end)

    local CaptionSound = Instance.new("Sound")
    CaptionSound.SoundId = "rbxassetid://3848738542"
    CaptionSound.Volume = 1
    CaptionSound.Parent = MainUI
    CaptionSound:Play()

            CaptionSound.Ended:Connect(function()
                CaptionSound:Destroy()
            end)
        end)
    end
})

ShowOxygenConnection = nil
local LastOxygen = 100

SecTabnot:AddToggle("ShowOxygen", {
    Text = "Notify Oxygen",
    Tooltip = "Shows you how much oxygen you still have on the screen.",
    Callback = function(enabled)

        local Player = game:GetService("Players").LocalPlayer
        local MainUI = Player.PlayerGui.MainUI
        local Caption = MainUI.MainFrame:WaitForChild("Caption")

        local function GetOxygenSource()
            local char = Player.Character or Player.CharacterAdded:Wait()
            return char
        end

        local OxygenSource = GetOxygenSource()

        if not enabled then
            if ShowOxygenConnection then
                ShowOxygenConnection:Disconnect()
                ShowOxygenConnection = nil
            end

            for _, child in ipairs(MainUI:GetChildren()) do
                if child.Name == "LiveCaption_Oxygen" then
                    child:Destroy()
                end
            end

            return
        end

        local function UpdateOxygenUI()
            local oxygen = OxygenSource:GetAttribute("Oxygen")
            if oxygen == nil then return end

            if oxygen >= 100 then
                for _, child in ipairs(MainUI:GetChildren()) do
                    if child.Name == "LiveCaption_Oxygen" then
                        task.spawn(function()
                            local frame = child
                            for i = 0, 1, 0.05 do
                                frame.BackgroundTransparency = i
                                task.wait(0.02)
                            end
                            frame:Destroy()
                        end)
                    end
                end
                LastOxygen = oxygen
                return
            end

            for _, child in ipairs(MainUI:GetChildren()) do
                if child.Name == "LiveCaption_Oxygen" then
                    child:Destroy()
                end
            end

            local OxygenFrame = Instance.new("Frame")
            OxygenFrame.Name = "LiveCaption_Oxygen"
            OxygenFrame.Parent = MainUI
            OxygenFrame.Size = UDim2.new(0, 181, 0, 100)
            OxygenFrame.Position = Caption.Position
            OxygenFrame.AnchorPoint = Caption.AnchorPoint
            OxygenFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            OxygenFrame.BackgroundTransparency = 0
            OxygenFrame.BorderSizePixel = 0

            local Stroke = Instance.new("UIStroke")
            Stroke.Parent = OxygenFrame
            Stroke.Thickness = 2
            Stroke.Color = Library.Scheme.AccentColor

            local Corner = Instance.new("UICorner")
            Corner.Parent = OxygenFrame
            Corner.CornerRadius = UDim.new(0, 6)

            local Label = Instance.new("TextLabel")
            Label.Parent = OxygenFrame
            Label.Size = UDim2.new(1, 0, 1, 0)
            Label.BackgroundTransparency = 1
            Label.Text = tostring(oxygen)
            Label.TextColor3 = Color3.fromRGB(255, 222, 189)
            Label.Font = Options.ESPTextFont.Value
            Label.TextSize = 32
            Label.TextStrokeTransparency = 0.5
            Label.TextXAlignment = Enum.TextXAlignment.Center
            Label.TextYAlignment = Enum.TextYAlignment.Center

            task.spawn(function()
                while OxygenFrame.Parent do
                    Stroke.Color = Library.Scheme.AccentColor
                    task.wait(0.1)
                end
            end)

            if oxygen < LastOxygen then
                local s = Instance.new("Sound")
                s.SoundId = "rbxassetid://3848738542"
                s.Volume = 1
                s.Parent = MainUI
                s:Play()
                s.Ended:Connect(function() s:Destroy() end)
            end

            LastOxygen = oxygen
        end

        UpdateOxygenUI()

        ShowOxygenConnection = OxygenSource:GetAttributeChangedSignal("Oxygen"):Connect(UpdateOxygenUI)

        Player.CharacterAdded:Connect(function(newChar)
            OxygenSource = newChar
            UpdateOxygenUI()
            if ShowOxygenConnection then ShowOxygenConnection:Disconnect() end
            ShowOxygenConnection = newChar:GetAttributeChangedSignal("Oxygen"):Connect(UpdateOxygenUI)
        end)
    end
})

	local EXPTTAB = Tabs.Exploits:AddLeftTabbox()
	local thirdtab = EXPTTAB:AddTab('Remove')
		local EXPTTAB2 = Tabs.Exploits:AddRightTabbox()
	local thirdtabPlayer = EXPTTAB2:AddTab('Movement')
    		local EXPTTAB3 = Tabs.Exploits:AddRightTabbox()
	local thirdtabbyp = EXPTTAB3:AddTab('Bypass')
    local EXPTTAB4 = Tabs.Exploits:AddLeftTabbox()
	local thirdtabKF = EXPTTAB4:AddTab('Knob Farm')

GiggleConnection = nil

local function SetAllGiggleHitboxes(state)
    local rooms = workspace:FindFirstChild("CurrentRooms")
    if not rooms then return end

    for _, room in ipairs(rooms:GetChildren()) do
        for _, inst in ipairs(room:GetDescendants()) do
            if inst.Name == "GiggleCeiling" then
                local hb = inst:FindFirstChild("Hitbox")
                if hb then
                    hb.CanTouch = state
                end
            end
        end
    end
end

thirdtab:AddToggle('AntiGiggle', {
    Text = 'Anti Giggle',
    Default = false,
    Tooltip = 'Prevents Giggle from doing any damage.',
})

Toggles.AntiGiggle:OnChanged(function(Value)

    if GiggleConnection then
        GiggleConnection:Disconnect()
        GiggleConnection = nil
    end

    if not Value then
        SetAllGiggleHitboxes(true)
        return
    end

    SetAllGiggleHitboxes(false)

    GiggleConnection = workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
        if not Toggles.AntiGiggle.Value then return end
        if inst.Name ~= "GiggleCeiling" then return end

        local hb = inst:WaitForChild("Hitbox", 5)
        if hb then
            hb.CanTouch = false
        end
    end)
end)

local Eyesa

thirdtab:AddToggle("AntiEyes", {
    Text = "Anti Eyes",
    Default = false,
    Callback = function(state)
        if Eyesa then
            Eyesa:Disconnect()
            Eyesa = nil
        end

        Eyesa = RunService.Heartbeat:Connect(function()
            if Workspace:FindFirstChild("Eyes") then
                RemotesFolder.MotorReplication:FireServer(-760)
            end
        end)
    end
})

local lookmana

thirdtab:AddToggle("Antilookyman", {
    Text = "Anti Lookman",
    Default = false,
    Callback = function(state)
        if lookmana then
            lookmana:Disconnect()
            lookmana = nil
        end

        lookmana = RunService.Heartbeat:Connect(function()
            if Workspace:FindFirstChild("BackdoorLookman") then
                RemotesFolder.MotorReplication:FireServer(-760)
            end
        end)
    end
})

AntiVacuumConnection = AntiVacuumConnection or nil

thirdtab:AddToggle("AntiVacuum", {
    Text = "Anti Vacuum",
    Default = false,
    Callback = function(state)

        if AntiVacuumConnection then
            AntiVacuumConnection:Disconnect()
            AntiVacuumConnection = nil
        end

        local function ApplyToAllVacuums(value)
            for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
                local sideroom = room:FindFirstChild("SideroomSpace")
                if sideroom then
                    local collision = sideroom:FindFirstChild("Collision")
                    if collision and collision:IsA("BasePart") then
                        collision.CanTouch = value
                    end
                end
            end
        end

        if not state then
            ApplyToAllVacuums(true)
            return
        end

        ApplyToAllVacuums(false)

        AntiVacuumConnection = workspace.DescendantAdded:Connect(function(obj)
            if obj.Name ~= "Collision" then return end
            local parent = obj.Parent
            if not parent then return end
            if parent.Name ~= "SideroomSpace" then return end

            if obj:IsA("BasePart") then
                obj.CanTouch = false
            end
        end)

        AddConnection(AntiVacuumConnection)
    end
})

AntiSnareConnection = AntiSnareConnection or nil

thirdtab:AddToggle("AntiSnare", {
    Text = "Anti Snare",
    Default = false,
    Callback = function(state)

        if AntiSnareConnection then
            AntiSnareConnection:Disconnect()
            AntiSnareConnection = nil
        end

        local function DisableSnareHitbox(snare)
            if not snare then return end

            local hitbox =
                snare:FindFirstChild("Hitbox")
                or snare:FindFirstChild("HitboxPart")
                or snare:FindFirstChild("HitboxMesh")

            if hitbox and hitbox:IsA("BasePart") then
                hitbox.CanTouch = false
            end
        end

        local function ApplyToAllSnares()
            for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
                local assets = room:FindFirstChild("Assets")
                if not assets then continue end

                local snaresFolder = assets:FindFirstChild("Snares")
                if snaresFolder then
                    for _, snare in ipairs(snaresFolder:GetChildren()) do
                        if snare.Name == "Snare" then
                            DisableSnareHitbox(snare)
                        end
                    end
                end

                local snare = assets:FindFirstChild("Snare")
                if snare then
                    DisableSnareHitbox(snare)
                end
            end
        end

        if not state then
            for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
                local assets = room:FindFirstChild("Assets")
                if not assets then continue end

                local snaresFolder = assets:FindFirstChild("Snares")
                if snaresFolder then
                    for _, snare in ipairs(snaresFolder:GetChildren()) do
                        local hitbox = snare:FindFirstChild("Hitbox")
                            or snare:FindFirstChild("HitboxPart")
                            or snare:FindFirstChild("HitboxMesh")

                        if hitbox and hitbox:IsA("BasePart") then
                            hitbox.CanTouch = true
                        end
                    end
                end
            end
            return
        end

        ApplyToAllSnares()

        AntiSnareConnection = workspace.DescendantAdded:Connect(function(obj)

            if obj.Name == "Snares" then
                for _, snare in ipairs(obj:GetChildren()) do
                    if snare.Name == "Snare" then
                        DisableSnareHitbox(snare)
                    end
                end
            end

            if obj.Name == "Snare" then
                DisableSnareHitbox(obj)
            end

            if obj.Name == "Hitbox" or obj.Name == "HitboxPart" or obj.Name == "HitboxMesh" then
                local parent = obj.Parent
                if parent and parent.Name == "Snare" then
                    obj.CanTouch = false
                end
            end
        end)

        AddConnection(AntiSnareConnection)
    end
})

AntiDupeConnection = AntiDupeConnection or nil
AntiGloomConnection = AntiGloomConnection or nil

AntiDupeEnabled = false
AntiGloomEnabled = false

function ApplyToAllDupes(canTouchValue)
    for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
        local dupe = room:FindFirstChild("SideroomDupe") or room:FindFirstChild("Dupe")
        if dupe then
            local doorFake = dupe:FindFirstChild("DoorFake", true)
            if doorFake then
                for _, obj in ipairs(doorFake:GetDescendants()) do
                    if obj:IsA("BasePart") then
                        obj.CanTouch = canTouchValue
                    end
                end
            end
        end
    end

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and string.find(obj.Name, "Dupe") then
            local doorFake = obj:FindFirstChild("DoorFake", true)
            if doorFake then
                for _, part in ipairs(doorFake:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanTouch = canTouchValue
                    end
                end
            end
        end
    end
end

function ApplyToAllGloomEggs(canTouchValue)
    for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
        local assets = room:FindFirstChild("Assets")
        if assets then
            local gloom = assets:FindFirstChild("GloomEgg")
            if gloom then
                local egg = gloom:FindFirstChild("Egg")
                if egg and egg:IsA("BasePart") then
                    egg.CanTouch = canTouchValue
                end
            end
        end
    end
end

function StartAntiDupe()
    if AntiDupeConnection then return end

    AntiDupeConnection = workspace.DescendantAdded:Connect(function(obj)
        if not AntiDupeEnabled then return end

        if obj:IsA("Model") and string.find(obj.Name, "Dupe") then
            local doorFake = obj:FindFirstChild("DoorFake", true)
            if doorFake then
                for _, part in ipairs(doorFake:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanTouch = false
                    end
                end
            end
        end
    end)

    AddConnection(AntiDupeConnection)
end

function StopAntiDupe()
    if AntiDupeConnection then
        AntiDupeConnection:Disconnect()
        AntiDupeConnection = nil
    end
end

function StartAntiGloom()
    if AntiGloomConnection then return end

    AntiGloomConnection = workspace.DescendantAdded:Connect(function(obj)
        if not AntiGloomEnabled then return end

        if obj.Name == "GloomEgg" then
            local egg = obj:FindFirstChild("Egg")
            if egg and egg:IsA("BasePart") then
                egg.CanTouch = false
            end
        end
    end)

    AddConnection(AntiGloomConnection)
end

function StopAntiGloom()
    if AntiGloomConnection then
        AntiGloomConnection:Disconnect()
        AntiGloomConnection = nil
    end
end

thirdtab:AddToggle("AntiDuper", {
    Text = "Anti Dupe",
    Default = false,
    Callback = function(state)
        AntiDupeEnabled = state

        if state then
            ApplyToAllDupes(false)
            StartAntiDupe()
        else
            ApplyToAllDupes(true)
            StopAntiDupe()
        end
    end
})

thirdtab:AddToggle("AntiGloomEggs", {
    Text = "Anti Gloombat Eggs",
    Default = false,
    Callback = function(state)
        AntiGloomEnabled = state

        if state then
            ApplyToAllGloomEggs(false)
            StartAntiGloom()
        else
            ApplyToAllGloomEggs(true)
            StopAntiGloom()
        end
    end
})


AntiJeffConnection = AntiJeffConnection or nil

thirdtab:AddToggle("AntiJeff", {
    Text = "Anti Jeff",
    Default = false,
    Callback = function(state)

        if AntiJeffConnection then
            AntiJeffConnection:Disconnect()
            AntiJeffConnection = nil
        end

        if not state then
            return
        end

        local function KillJeff(model)
            if not model then return end

            task.delay(0.5, function()
                if not model or not model.Parent then return end

                local humanoid =
                    model:FindFirstChild("Humanoid")
                    or model:WaitForChild("Humanoid", 2)

                if humanoid then
                    humanoid.Health = 0
                end
            end)
        end

        local existing = workspace:FindFirstChild("JeffTheKiller")
        if existing then
            KillJeff(existing)
        end

        AntiJeffConnection = workspace.ChildAdded:Connect(function(obj)
            if obj.Name == "JeffTheKiller" then
                KillJeff(obj)
            end
        end)

        AddConnection(AntiJeffConnection)
    end
})

thirdtab:AddToggle("AntiFH", {
    Text = "Anti Figure Hearing",
    Default = false,
    Disabled = not RemotesFolder:FindFirstChild("Crouch")
})

Connections.AntiFHLoop = nil

Toggles.AntiFH:OnChanged(function(Value)
    if not Value then
        if Connections.AntiFHLoop then
            Connections.AntiFHLoop:Disconnect()
            Connections.AntiFHLoop = nil
        end
        return
    end

    if RemotesFolder:FindFirstChild("Crouch") then
        RemotesFolder.Crouch:FireServer(true)
    end

    Connections.AntiFHLoop = game:GetService("RunService").Heartbeat:Connect(function()
        if Toggles.AntiFH.Value and RemotesFolder:FindFirstChild("Crouch") then
            RemotesFolder.Crouch:FireServer(true)
        end
    end)
end)

local function GetJamObjects()
    local gui = Services.Players.LocalPlayer:WaitForChild("PlayerGui")
    local main = gui:WaitForChild("MainUI")
    local init = main:WaitForChild("Initiator")
    local mg = init:WaitForChild("Main_Game")
    local health = mg:WaitForChild("Health")

    local Jam = health:FindFirstChild("Jam")

    local MainSound = Services.SoundService:WaitForChild("Main")
    local JamMuffle = MainSound:FindFirstChild("Jamming")

    if not JamMuffle then
        JamMuffle = Instance.new("EqualizerSoundEffect")
        JamMuffle.Name = "Jamming"
        JamMuffle.Parent = MainSound
    end

    return Jam, JamMuffle
end

local Jam, JamMuffle = GetJamObjects()

thirdtab:AddToggle("NoJamSound", {
    Text = "Remove Jammin Music",
    Default = false,
    Disabled = not Jam
})

Connections.RJM = nil

local function ApplyNoJamState()
    if not Toggles.NoJamSound.Value then return end

    Jam, JamMuffle = GetJamObjects()

    if Jam then
        Jam.Volume = 0
    end

    if JamMuffle then
        JamMuffle.Enabled = false
    end
end

Toggles.NoJamSound:OnChanged(function(Value)
    Jam, JamMuffle = GetJamObjects()

    if Jam then
       if Services.ReplicatedStorage.LiveModifiers:FindFirstChild("Jammin") then
            Jam.Volume = Value and 0 or 0.45
       end
    end

    if JamMuffle then
        if Services.ReplicatedStorage.LiveModifiers:FindFirstChild("Jammin") then
            JamMuffle.Enabled = not Value
        end
    end
end)

Services.Players.LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.2)
    ApplyNoJamState()
end)


thirdtab:AddDivider()

thirdtab:AddToggle('AntiA90', {
	Text = 'No A-90 Damage',
	Default = false, 
	Tooltip = 'Prevents A-90 from doing any damage.',
	Callback = function(Value)
	if Value == true then
		A90Event.Parent = Services.ReplicatedStorage
		FakeA90Event.Parent = RemotesFolder
	else
		A90Event.Parent = RemotesFolder
		FakeA90Event.Parent = Services.ReplicatedStorage
	end

	end
})
thirdtab:AddToggle('AntiScreecha', {
	Text = 'No Screech Damage',
	Default = false, 
	Tooltip = 'Prevents Screech from doing any damage.',
	Callback = function(Value)
	if Value == true then
		ScreechEvent.Parent = Services.ReplicatedStorage
		FakeScreechEvent.Parent = Services.ReplicatedStorage.RemotesFolder
	else
		ScreechEvent.Parent = Services.ReplicatedStorage.RemotesFolder
		FakeScreechEvent.Parent = Services.ReplicatedStorage
	end

	end
})

thirdtab:AddToggle('AntiSurge', {
	Text = 'No Surge Damage',
	Default = false, 
	Tooltip = 'Prevents Surge from doing any damage.',
	Callback = function(Value)
	if Value == true then
		SurgeEvent.Parent = Services.ReplicatedStorage
		FakeSurgeEvent.Parent = Services.ReplicatedStorage.RemotesFolder
	else
		SurgeEvent.Parent = Services.ReplicatedStorage.RemotesFolder
		FakeSurgeEvent.Parent = Services.ReplicatedStorage
	end

	end
})

thirdtab:AddToggle('AntiShade', {
	Text = 'No Halt Damage',
	Default = false, 
	Tooltip = 'Prevents Halt from doing any damage.',
	Callback = function(Value)
	if Value == true then
		ShadeEvent.Parent = Services.ReplicatedStorage
		FakeShadeEvent.Parent = Services.ReplicatedStorage.RemotesFolder
	else
		ShadeEvent.Parent = Services.ReplicatedStorage.RemotesFolder
		FakeShadeEvent.Parent = Services.ReplicatedStorage
	end

	end
})

	local Event = RemotesFolder:FindFirstChild("CamLock")
	local FastExita = false
	thirdtabPlayer:AddToggle("FastClosetExit", {
		Text = "Fast Closet Exit",
		Default = false,
		Callback = function(on)
			FastExita = on
			if FastExita then
				while FastExita do
					task.wait(0.04)
					if Character.Humanoid.MoveDirection.Magnitude > 0.1 then
						if Character:GetAttribute("Hiding") == true  then
							if Event then
								Event:FireServer()
							end
						end
					end
				end
			end
		end
	})

thirdtabPlayer:AddToggle('TeleportManipulation', {
    Default = false,
    Text = "Teleport Manipulation",
    Tooltip = 'Teleports you to the other side of the wall.',
}):AddKeyPicker('TeleportManipulationKeybind', {
    Default = 'V',
    SyncToggleState = true,
    Mode = "Hold",
    Text = 'Teleport Manipulation',
    NoUI = false
})

local TeleportConn

local function StartTeleportEngine()
    if TeleportConn then return end

    TeleportConn = game:GetService("RunService").Heartbeat:Connect(function()
        local toggle = Toggles.TeleportManipulation and Toggles.TeleportManipulation.Value
        local key = Options.TeleportManipulationKeybind and Options.TeleportManipulationKeybind:GetState()

        if not (toggle or key) then return end

        if not Character then return end

        local root = Character:FindFirstChild("HumanoidRootPart")
        if not root then return end

        Character:PivotTo(root.CFrame * CFrame.new(0, 0, 4000))
    end)
end

local function StopTeleportEngine()
    if TeleportConn then
        TeleportConn:Disconnect()
        TeleportConn = nil
    end
end

Toggles.TeleportManipulation:OnChanged(function(state)
end)

StartTeleportEngine()

thirdtabPlayer:AddDivider()

    thirdtabPlayer:AddToggle('AutoHide', {
		Default = false,
		Text = "Auto Closet",
		Tooltip = 'Auto hides in closets for you.',
	}):AddKeyPicker('AutoHideKeybind', {
    Default = 'Q',
    SyncToggleState = true,
    Mode = "Toggle",
    Text = 'Auto Closet',
    NoUI = false
})

RenderConnections = RenderConnections or {}
ObjectsTable = ObjectsTable or {}
ObjectsTable.Closets = {}
ObjectsTable.EntityModels = {}

workspace.CurrentRooms.ChildAdded:Connect(function(room)
    task.spawn(function()
        for _, obj in ipairs(room:GetDescendants()) do
            if obj.Name == "Closet" or obj.Name == "Wardrobe" then
                if obj:IsA("Model") then
                    table.insert(ObjectsTable.Closets, obj)
                end
            end
        end
    end)
end)

workspace.ChildAdded:Connect(function(obj)
    if obj:IsA("Model") then
        table.insert(ObjectsTable.EntityModels, obj)
    end
end)

local function IsEntityActive()
    for _, ent in ipairs(ObjectsTable.EntityModels) do
        if ent:FindFirstChild("RushNew") or ent:FindFirstChild("Main") then
            return true
        end
    end
    return false
end

local function GetNearestEntity()
    local nearest = nil
    local nearestDist = math.huge

    for _, ent in ipairs(ObjectsTable.EntityModels) do
        local pp = ent.PrimaryPart or ent:FindFirstChild("RushNew") or ent:FindFirstChild("Main")
        if pp then
            local dist = Player:DistanceFromCharacter(pp.Position)
            if dist < nearestDist and dist < 120 then
                nearest = ent
                nearestDist = dist
            end
        end
    end

    return nearest
end

local function IsPlayerHiding()
    for _, closet in ipairs(ObjectsTable.Closets) do
        local hidden = closet:FindFirstChild("HiddenPlayer", true)
        if hidden and hidden.Value == Character then
            return true
        end
    end
    return false
end

local function GetNearestCloset()
    local nearest = nil
    local nearestDist = math.huge

    for _, closet in ipairs(ObjectsTable.Closets) do
        local pp = closet.PrimaryPart
        if pp then
            local prompt = closet:FindFirstChild("HidePrompt", true)
            if prompt then
                local dist = Player:DistanceFromCharacter(pp.Position)
                if dist < prompt.MaxActivationDistance and dist < nearestDist then
                    nearest = closet
                    nearestDist = dist
                end
            end
        end
    end

    return nearest
end
local W_KEY = 0x57

local AutoHideConnection = RunService.RenderStepped:Connect(function()
    local autoHideActive = Toggles.AutoHide.Value or Options.AutoHideKeybind:GetState()
    if not autoHideActive then return end
    if Floor == "Retro" then return end
    if Toggles.AutoRooms and Toggles.AutoRooms.Value then return end

    local entity = GetNearestEntity()

    if IsPlayerHiding() then

        if not entity then
            keypress(W_KEY)
            task.wait(0.15)
            keyrelease(W_KEY)
            return
        end

        if not entity.Parent then
            keypress(W_KEY)
            task.wait(0.15)
            keyrelease(W_KEY)
            return
        end

        local pp = entity.PrimaryPart or entity:FindFirstChild("RushNew") or entity:FindFirstChild("Main")
        if not pp then
            keypress(W_KEY)
            task.wait(0.15)
            keyrelease(W_KEY)
            return
        end

        local dist = Player:DistanceFromCharacter(pp.Position)
        if dist > 120 then
            keypress(W_KEY)
            task.wait(0.15)
            keyrelease(W_KEY)
            return
        end
    end

    if not IsEntityActive() then return end

    if entity then
        local closet = GetNearestCloset()
        if closet then
            local prompt = closet:FindFirstChild("HidePrompt", true)
            if prompt then
                pcall(function()
                    fireproximityprompt(prompt)
                end)
            end
        end
    end
end)

table.insert(RenderConnections, AutoHideConnection)

PositionSpoofConnection = nil
PositionSpoofActive = false

local function POSITION_SPOOF(Character, enabled)
    if not Character then return end

    local humanoid = Character:FindFirstChildOfClass("Humanoid")
    local collision = Character:FindFirstChild("Collision")
    local crouch = collision and collision:FindFirstChild("CollisionCrouch")
    local lowerTorso = Character:FindFirstChild("LowerTorso")
    local root = lowerTorso and lowerTorso:FindFirstChild("Root")

    if humanoid then
        humanoid.HipHeight = enabled and 0.09 or 2.4
    end

    if collision then
        collision.Size = Vector3.new(1,1,1)
    end

    if crouch then
        crouch.Size = Vector3.new(1,1,1)
    end

    if root then
        if enabled then
            root.C1 = CFrame.new(0, -2.3, 0)
        else
            root.C1 = CFrame.new(0, 0, 0)
        end
    end

end

Stored = {}
FakePrompts = {}

Names = {
    Lock = true,
    ChestBoxLocked = true,
    Cellar = true,
    Chest_Vine = true,
    CuttableVines = true,
    SkullLock = true,
    Toolbox_Locked = true,
    Lock1 = true,
    Lock2 = true,
}
local LocalPlayer = Services.Players.LocalPlayer
GetCurrentTool = function()
    if not Character then return nil end

    local Tool =
        Character:FindFirstChild("Lockpick")
        or Character:FindFirstChild("SkeletonKey")
        or Character:FindFirstChild("Shears")
        or Character:FindFirstChild("Multitool")

    if Tool then return Tool end

    local Backpack = LocalPlayer:FindFirstChild("Backpack")
    if Backpack then
        return
            Backpack:FindFirstChild("Lockpick")
            or Backpack:FindFirstChild("SkeletonKey")
            or Backpack:FindFirstChild("Shears")
            or Backpack:FindFirstChild("Multitool")
    end

    return nil
end

UsedObjects = {}

InfPrompt = function(Prompt)
    local Character = LocalPlayer.Character
    if not Character then return end

    local Root = Character:FindFirstChild("HumanoidRootPart")
    if not Root then return end

    local Tool = GetCurrentTool()
    if not Tool then return end
    local Name = Tool.Name

    local ParentObject = Prompt.parent

    if UsedObjects[ParentObject] then
        return
    end
    if Prompt:GetAttribute("InfiniteItems") and Prompt:GetAttribute("Tool") ~= Name then
        local FP = ParentObject:FindFirstChild("FPrompt")
        if FP then FP:Destroy() end
        Prompt:SetAttribute("InfiniteItems", nil)
        Prompt:SetAttribute("Tool", nil)
        Prompt.Enabled = true
        Prompt.ClickablePrompt = true
        return
    end

    if not Prompt:GetAttribute("InfiniteItems") then
        Prompt.Enabled = false
        Prompt.ClickablePrompt = false
        Prompt:SetAttribute("InfiniteItems", true)
        Prompt:SetAttribute("Tool", Name)

        local Clone = Prompt:Clone()
        Clone.Name = "FPrompt"
        Clone.MaxActivationDistance = Prompt.MaxActivationDistance * 0.45
        Clone.Parent = ParentObject
        Clone.Enabled = true
        Clone.ClickablePrompt = true

Clone.Triggered:Connect(function()
    UsedObjects[ParentObject] = true

    if Clone and Clone.Parent then
        Clone:Destroy()
    end

    task.spawn(function()
        local CurrentTool = GetCurrentTool()
        if not CurrentTool then
            Prompt:SetAttribute("InfiniteItems", nil)
            Prompt:SetAttribute("Tool", nil)
            Prompt.Enabled = true
            Prompt.ClickablePrompt = true
            return
        end

        local DropInstance = nil
        local DropConn
        DropConn = workspace.Drops.ChildAdded:Connect(function(child)
            if child.Name == Name then
                DropInstance = child
                if DropConn then
                    DropConn:Disconnect()
                    DropConn = nil
                end
            end
        end)

        if RemotesFolder and RemotesFolder:FindFirstChild("DropItem") then
            RemotesFolder.DropItem:FireServer(CurrentTool)
        end

        local t0 = tick()
        while not DropInstance and tick() - t0 < 0.3 do
            task.wait()
        end
        if DropConn then
            DropConn:Disconnect()
            DropConn = nil
        end

    task.defer(function()
        fireproximityprompt(Prompt)
    end)

        if DropInstance then
            local DP = DropInstance:FindFirstChildWhichIsA("ProximityPrompt", true)
            if DP then
                fireproximityprompt(DP)
            end
        end

             Prompt:SetAttribute("InfiniteItems", nil)
         Prompt:SetAttribute("Tool", nil)
             Prompt.Enabled = true
          Prompt.ClickablePrompt = true
             end)
        end)
    end
end

thirdtabbyp:AddToggle("InfItems", {
    Text = "Infinite Items",
    Default = false,
    Disabled = not Environments.fireproximityprompt,
    DisabledTooltip = "your executor doesnt support this feature.",
    Callback = function(Value)
        if Value then
            table.clear(Stored)

            for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
                if v:IsA("ProximityPrompt") then
                    local parent = v.Parent
                    local grand = parent and parent.Parent

                    if Names[parent and parent.Name]
                        or v.Name == "FusesPrompt"
                        or (grand and grand.Name == "Locker_Small_Locked")
                    then
                        table.insert(Stored, v)
                    end
                end
            end
        else
            for _, Prompt in pairs(Stored) do
                if Prompt and Prompt:GetAttribute("InfiniteItems") then
                    local FP = Prompt.Parent:FindFirstChild("FPrompt")
                    if FP then FP:Destroy() end
                    Prompt:SetAttribute("InfiniteItems", nil)
                    Prompt:SetAttribute("Tool", nil)
                    Prompt.Enabled = true
                    Prompt.ClickablePrompt = true
                end
            end
            table.clear(Stored)
        end
    end
})

thirdtabbyp:AddDropdown("InfItemsList", {
    Text = "Infinite Item List",
    Values = { "Lockpicks", "Skeleton Key", "Shears", "Multitool" },
    Multi = true,
    AllowNull = true
})

workspace.CurrentRooms.DescendantAdded:Connect(function(obj)
    if not Toggles.InfItems.Value then return end
    if not obj:IsA("ProximityPrompt") then return end

    local parent = obj.Parent
    local grand = parent and parent.Parent

    if Names[parent and parent.Name]
        or obj.Name == "FusesPrompt"
        or (grand and grand.Name == "Locker_Small_Locked")
    then
        table.insert(Stored, obj)
    end
end)

CleanStored = function()
    for i = #Stored, 1, -1 do
        local p = Stored[i]
        if not p or not p.Parent then
            table.remove(Stored, i)
        end
    end
end

task.spawn(function()
    while task.wait(0.01) do
        if Toggles.InfItems.Value then
            CleanStored()
            for _, Prompt in ipairs(Stored) do
                if Prompt and Prompt.Parent then
                    InfPrompt(Prompt)
                end
            end
        end
    end
end)

thirdtabbyp:AddToggle("Positionspoff", {
    Text = "Position Spoof",
    Default = false,
    Callback = function(value)

        PositionSpoofActive = value or Options.PositionSpoofB:GetState()

        if Floor == "Garden" or Floor == "Fools" or OldHotel == true then
            return
        end

        if PositionSpoofActive and not PositionSpoofConnection then
            PositionSpoofConnection = RunService.RenderStepped:Connect(function()
                pcall(function()
                    POSITION_SPOOF(Character, true)

                    if RemotesFolder:FindFirstChild("Crouch") then
                        RemotesFolder.Crouch:FireServer(true)
                    end
                end)
            end)
        end

        if not PositionSpoofActive and PositionSpoofConnection then
            PositionSpoofConnection:Disconnect()
            PositionSpoofConnection = nil

            POSITION_SPOOF(Character, false)

            LocalPlayer:SetAttribute("Crouching", false)

            if Character:GetAttribute("Hiding") ~= true and NewHotel == true then
                Character:PivotTo(Character:GetPivot() * CFrame.new(0, 6, 0))
            end
        end
    end
})
:AddKeyPicker("PositionSpoofB", {
    Default = "B",
    SyncToggleState = true,
    Mode = "Toggle",
    Text = "Position Spoof",
    NoUI = false
})

thirdtabbyp:AddDivider()

thirdtabbyp:AddToggle('RemoveA90', {
    Text = 'Disable A-90',
    Default = false,
    Tooltip = 'Prevents A-90 from spawning.',

    Callback = function(Value)

        local A90 =
            game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules:FindFirstChild("A90")
            or game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules:FindFirstChild("_A90")
            or game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules:FindFirstChild("A90_Disabled")

        if not A90 then
            return
        end

        if Value then
            A90.Name = "A90_Disabled"
        else
            A90.Name = "A90"
        end
    end
})

thirdtabbyp:AddToggle('RemoveHalt', {
    Text = 'Disable Halt',
    Default = false,
    Tooltip = 'Prevents Halt from spawning.',

    Callback = function(Value)

        local Halt =
            game:GetService("ReplicatedStorage").ModulesClient.EntityModules:FindFirstChild("Shade")
            or game:GetService("ReplicatedStorage").ModulesClient.EntityModules:FindFirstChild("_Shade")
            or game:GetService("ReplicatedStorage").ModulesClient.EntityModules:FindFirstChild("Shade_Disabled")

        if not Halt then
            return
        end

        if Value then
            Halt.Name = "Shade_Disabled"
        else
            Halt.Name = "Shade"
        end
    end
})

thirdtabbyp:AddToggle('RemoveScreech', {
    Text = 'Disable Screech',
    Default = false,
    Tooltip = 'Prevents Screech from spawning.',

    Callback = function(Value)

        local Screech =
            game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules:FindFirstChild("Screech")
            or game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules:FindFirstChild("_Screech")
            or game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules:FindFirstChild("Screech_Disabled")

        if not Screech then
            return
        end

        if Value then
            Screech.Name = "Screech_Disabled"
        else
            Screech.Name = "Screech"
        end
    end
})

thirdtabbyp:AddToggle('RemoveScreech', {
    Text = 'Disable Dread',
    Default = false,
    Tooltip = 'Prevents Dread from spawning.',

    Callback = function(Value)

        local Dread =
            game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules:FindFirstChild("Dread")
            or game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules:FindFirstChild("_Dread")
            or game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules:FindFirstChild("Dread_Disabled")

        if not Dread then
            return
        end

        if Value then
            Dread.Name = "Dread_Disabled"
        else
            Dread.Name = "Dread"
        end
    end
})

AntiAFK_Connection = nil
farmenabled = false

function StartAntiAFK()
    if AntiAFK_Connection then
        AntiAFK_Connection:Disconnect()
        AntiAFK_Connection = nil
    end

    AntiAFK_Connection = game:GetService("Players").LocalPlayer.Idled:Connect(function()
        task.wait()
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
    end)
end

function StopAntiAFK()
    if AntiAFK_Connection then
        AntiAFK_Connection:Disconnect()
        AntiAFK_Connection = nil
    end
end

thirdtabKF:AddToggle("AntiAFK", {
    Text = "Anti AFK",
    Default = false,
    Disabled = false,
    DisabledTooltip = "This Feature is for <font color='#FFD900'>Buyers</font>.",
    Tooltip = "Prevents Roblox from kicking you for being idle.",
    Callback = function(Value)
        if Value then
            StartAntiAFK()
        else
            StopAntiAFK()
        end
    end
})

thirdtabKF:AddToggle("KnobFarm", {
    Text = "Knob Farm",
    Default = false,
    Disabled = false,
    DisabledTooltip = "This Feature is for <font color='#FFD900'>Buyers</font>.",
    Tooltip = "Farms knobs automatically. Works best in Mines.",

    Callback = function(Value)
        farmenabled = Value

        if Value and not Toggles.AntiAFK.Value then
            Library:Notify("<b>[BlackKing]</b>\nYou need to turn on anti afk.")
            sound()
            farmenabled = false
            return
        end

        if Value and Toggles.AntiAFK.Value then
            task.spawn(function()
                while farmenabled do
                    replicatesignal(game:GetService("Players").LocalPlayer.Kill)
                    game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"):WaitForChild("Statistics"):FireServer()
                    task.wait(0.25)
                end
            end)
        end
    end
})

local AutoPadlock = {}
local padlockConnection = nil

local function padlock_Fix()
    character = LocalPlayer.Character
    if not character then return {"_","_","_","_","_"} end

    paper = character:FindFirstChild("LibraryHintPaper")
    hints = LocalPlayer.PlayerGui:WaitForChild("PermUI"):WaitForChild("Hints")

    code = { "_","_","_","_","_" }

    if paper then
        for _, v in pairs(paper:WaitForChild("UI"):GetChildren()) do
            if v:IsA("ImageLabel") and v.Name ~= "Image" then
                for _, img in pairs(hints:GetChildren()) do
                    if img:IsA("ImageLabel") and img.Visible and v.ImageRectOffset == img.ImageRectOffset then
                        local num = img:FindFirstChild("TextLabel").Text
                        code[tonumber(v.Name)] = num
                    end
                end
            end
        end
    end

    return code
end

function AutoPadlock.Enable()
    if padlockConnection then
        padlockConnection:Disconnect()
        padlockConnection = nil
    end

    padlockConnection = LocalPlayer.Character.ChildAdded:Connect(function(check)
        if check:IsA("Tool") and check.Name == "LibraryHintPaper" then
            local code = table.concat(padlock_Fix())

            if code:find("_") then
                return
            else
                Library:Notify("<b>[BlackKing]</b>\nThe code is '" .. code .."'")
                sound()
                Library:Notify("<b>[BlackKing]</b>\nThe door is unlocked go to the next room.")
                sound()
                RemotesFolder.PL:FireServer(code)
            end
        end
    end)
end

function AutoPadlock.Disable()
    if padlockConnection then
        padlockConnection:Disconnect()
        padlockConnection = nil
    end
end

_G.AutoPadlock = AutoPadlock

local floortabs = Tabs.floortab:AddLeftTabbox()
local AutomationSuff = floortabs:AddTab("Automation")
local floortabs2 = Tabs.floortab:AddLeftTabbox()
local BypassStuff = floortabs2:AddTab("Bypass")
local floortabs3 = Tabs.floortab:AddRightTabbox()
local RemoveStuff3 = floortabs3:AddTab("Remove")
local floortabs4 = Tabs.floortab:AddRightTabbox()
local VisualStuff3 = floortabs4:AddTab("Visuals")



BypassSeek = false
SeekConnections = {}
SeekDeleted = {}

function DisconnectSeekConnections()
    for _, c in pairs(SeekConnections) do
        c:Disconnect()
    end
    table.clear(SeekConnections)
end

function DeleteSeekTrigger(trigger)
    if SeekDeleted[trigger] then return end
    SeekDeleted[trigger] = true

    Success = false

    for _, part in pairs(trigger:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
            part.CanTouch = false

            if Environments.firetouchinterest then
                Environments.firetouchinterest(part, game.Players.LocalPlayer.Character.HumanoidRootPart, 1)
                task.wait()
                Environments.firetouchinterest(part, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
            end
        end
    end

    SeekDeleteConnection = trigger.ChildRemoved:Connect(function()
        Success = true
        Library:Notify("<b>[BlackKing]</b>\nSuccessfully deleted Seek trigger!")
        sound()
        SeekDeleteConnection:Disconnect()
    end)

    task.delay(1, function()
        if not Success then
            Library:Notify("<b>[BlackKing]</b>\nSeek trigger deleted, but other parts may still trigger it.")
            sound()

            for _, part in pairs(trigger:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanTouch = false
                    part.CanCollide = false
                end
            end
        end
    end)
end

function WatchForSeekTriggers()
    DisconnectSeekConnections()

    function CheckSeek(inst)
        if not BypassSeek then return end
        if inst.Name == "TriggerEventCollision" then
            DeleteSeekTrigger(inst)
        end
    end

    for _, desc in pairs(workspace:GetDescendants()) do
        CheckSeek(desc)
    end

    SeekConnections["Added"] = workspace.DescendantAdded:Connect(CheckSeek)
end

RemoveStuff3:AddToggle('DeleteSeek', {
    Text = 'Delete Seek Trigger',
    Tooltip = 'Deletes the seek chase trigger.',
    Risky = not OldHotel == true,
    Callback = function(Value)
        BypassSeek = Value
        if Value and OldHotel == true or Value and Services.ReplicatedStorage.GameData.Floor.Value == "Fools" then
            WatchForSeekTriggers()
        else
            DisconnectSeekConnections()
        end
    end,
})

getgenv().AutoPlay = false

function RunAutoPlay()
    task.spawn(function()
        while getgenv().AutoPlay do
            local RS = game:GetService("ReplicatedStorage")
            local Players = game:GetService("Players")
            local LP = Players.LocalPlayer
            local Character = LP.Character or LP.CharacterAdded:Wait()
            local HRP = Character:WaitForChild("HumanoidRootPart")

            local latestRoom = RS:WaitForChild("GameData"):WaitForChild("LatestRoom").Value
            local room = workspace.CurrentRooms:FindFirstChild(latestRoom)
            if not room then task.wait(0.2) continue end

            local assets = room:FindFirstChild("Assets")

            local function fireAllPrompts(model)
                for _, obj in ipairs(model:GetDescendants()) do
                    if (obj:IsA("ProximityPrompt") or obj.Name == "ModulePrompt") and obj.Name ~= "HidePrompt" then
                        fireproximityprompt(obj)
                        task.wait(0.1)
                    end
                end
            end

            local function equipItem(name)
                local backpack = LP:WaitForChild("Backpack")
                for _, item in ipairs(backpack:GetChildren()) do
                    if item.Name == name then
                        item.Parent = Character
                    end
                end
            end

            local function entityExists()
                return workspace:FindFirstChild("AmbushMoving") or workspace:FindFirstChild("RushMoving")
            end

            local function figureClose()
                local fig = workspace.CurrentRooms["50"]
                if not fig then return false end
                fig = fig:FindFirstChild("FigureSetup")
                if not fig then return false end
                fig = fig:FindFirstChild("FigureRagdoll")
                if not fig then return false end
                if (fig.PrimaryPart.Position - HRP.Position).Magnitude <= 5 then
                    return true
                end
                return false
            end

            if tostring(latestRoom) == "50" then
                if assets then
                    local pickup = room:FindFirstChild("PickupItem")
                    local handle = pickup and pickup:FindFirstChild("Handle")
                    if handle then
                        HRP.CFrame = handle.CFrame + Vector3.new(0,3,0)
                        task.wait(0.4)
                        fireAllPrompts(pickup)
                    end

                    task.wait(0.4)

                    for _, obj in ipairs(assets:GetChildren()) do
                        if obj.Name == "Super Cool Bookshelf With Hint Book" then
                            local live = obj:FindFirstChild("LiveHintBook")
                            if live then
                                local base = live:FindFirstChild("Base")
                                local prompt = live:FindFirstChild("ActivateEventPrompt")

                                while figureClose() and getgenv().AutoPlay do
                                    task.wait(0.2)
                                end

                                if base then
                                    HRP.CFrame = base.CFrame + Vector3.new(0,3,0)
                                    task.wait(0.4)
                                    if prompt then fireproximityprompt(prompt) end
                                end
                            end
                        end
                    end

                    local door = room:FindFirstChild("Door")
                    if door and door:FindFirstChild("Door") then
                        local d = door.Door
                        HRP.CFrame = d.CFrame + d.CFrame.LookVector * 2 + Vector3.new(0,3,0)
                        task.wait(6)
                    end

                    local backpack = LP:WaitForChild("Backpack")
                    for _, item in ipairs(backpack:GetChildren()) do
                        if item.Name == "PickupItem" or item:FindFirstChild("Handle") then
                            task.wait(8)
                            item.Parent = Character
                        end
                    end
                end

                task.wait(0.2)
                continue
            end

            if tostring(latestRoom) == "100" then
                task.wait(4)

                while entityExists() and getgenv().AutoPlay do
                    HRP.CFrame = HRP.CFrame + Vector3.new(0, 10, 0)
                    task.wait(0.15)
                end

                local industrialGate = room:FindFirstChild("IndustrialGate")
                local electricalKey = assets and assets:FindFirstChild("ElectricalKeyObtain")
                local electricalDoor = room:FindFirstChild("ElectricalDoor")
                local breaker = room:FindFirstChild("ElevatorBreaker")

                if industrialGate and industrialGate:FindFirstChild("Box") then
                    local box = industrialGate.Box
                    HRP.CFrame = box.CFrame + Vector3.new(0,3,0)
                    task.wait(0.4)
                    fireAllPrompts(box)
                end

                if electricalKey and electricalKey:FindFirstChild("Hitbox") then
                    local hitbox = electricalKey.Hitbox
                    HRP.CFrame = hitbox.CFrame + Vector3.new(0,3,0)
                    task.wait(0.4)
                    fireAllPrompts(electricalKey)
                    equipItem("ElectricalKey")
                end

                if electricalDoor and electricalDoor:FindFirstChild("Hidden") then
                    local hidden = electricalDoor.Hidden
                    HRP.CFrame = hidden.CFrame + Vector3.new(0,3,0)
                    task.wait(0.4)
                    fireAllPrompts(hidden)
                end

                if electricalDoor 
                    and electricalDoor:FindFirstChild("Door")
                    and electricalDoor.Door:FindFirstChild("Lock")
                    and electricalDoor.Door.Lock:FindFirstChild("UnlockPrompt") then
                    fireproximityprompt(electricalDoor.Door.Lock.UnlockPrompt)
                end

                if electricalKey and electricalKey:FindFirstChild("Hitbox") then
                    HRP.CFrame = electricalKey.Hitbox.CFrame + Vector3.new(0,3,0)
                    task.wait(2)
                end

                if breaker and breaker:FindFirstChild("Part") then
                    local part = breaker.Part
                    local start = tick()
                    while tick() - start < 10 and getgenv().AutoPlay do
                        HRP.CFrame = part.CFrame + Vector3.new(0,3,0)
                        task.wait(0.1)
                    end
                end

                task.wait(0.2)
                continue
            end

            if assets then
                local keyHitbox = nil
                for _, obj in ipairs(assets:GetDescendants()) do
                    if obj.Name == "Hitbox" and obj.Parent and obj.Parent.Name == "KeyObtain" then
                        keyHitbox = obj
                        break
                    end
                end

                if keyHitbox then
                    HRP.CFrame = keyHitbox.CFrame + Vector3.new(0,3,0)
                    task.wait(0.4)
                    fireAllPrompts(keyHitbox.Parent)
                    equipItem("Key")
                end
            end

            local door = room:FindFirstChild("Door")
            if door and door:FindFirstChild("Door") then
                local d = door.Door
                HRP.CFrame = d.CFrame + d.CFrame.LookVector * 2 + Vector3.new(0,3,0)
                task.wait(0.4)
                fireAllPrompts(door)
            end

            task.wait(0.2)
        end
    end)
end

AutomationSuff:AddToggle("autoplay", {
    Text = "Auto Hotel",
    Risky = not OldHotel == true,
    Tooltip = "Automatically solves puzzles in rooms",
    Default = false,

    Callback = function(Value)
        getgenv().AutoPlay = Value
        if Value and OldHotel == true or Value and Services.ReplicatedStorage.GameData.Floor.Value == "Fools" then
            RunAutoPlay()
        end
    end,
})

local seekConnections = {}
local roomConnection = nil

RemoveStuff3:AddToggle("AntiseekObstuctions", {
    Text = "Anti Seek Obstructions",
     Risky = Services.ReplicatedStorage.GameData.Floor.Value ~= "Hotel",
    Default = false,
    Callback = function(enabled)

        local currentRooms = workspace:WaitForChild("CurrentRooms")

        local function cleanup()
            for _, conn in ipairs(seekConnections) do
                if conn and conn.Connected then
                    conn:Disconnect()
                end
            end
            seekConnections = {}

            if roomConnection and roomConnection.Connected then
                roomConnection:Disconnect()
            end
            roomConnection = nil
        end

        if not enabled then
            cleanup()
            return
        end

        local function disableTouch(part)
            if part.Name == "HurtPart" and part.Parent and part.Parent.Name == "ChandelierObstruction" then
                part.CanTouch = false

            elseif part.Name == "AnimatorPart" and part.Parent and part.Parent.Name == "Seek_Arm" then
                part.CanTouch = false
                part.Transparency = 1
                part.Color = Color3.fromRGB(0, 251, 255)
            end
        end

        local function monitorAssets(assets)
            for _, child in ipairs(assets:GetDescendants()) do
                disableTouch(child)
            end

            local conn = assets.DescendantAdded:Connect(disableTouch)
            table.insert(seekConnections, conn)
        end

        local function processRoom(room)
            local assets = room:FindFirstChild("Assets")

            if assets then
                monitorAssets(assets)
            else
                local conn
                conn = room.ChildAdded:Connect(function(child)
                    if child.Name == "Assets" then
                        monitorAssets(child)
                        if conn and conn.Connected then
                            conn:Disconnect()
                        end
                    end
                end)
                table.insert(seekConnections, conn)
            end
        end

        for _, room in ipairs(currentRooms:GetChildren()) do
            processRoom(room)
        end

        roomConnection = currentRooms.ChildAdded:Connect(processRoom)
    end
})


AutomationSuff:AddToggle("AutoPadLock", {
    Text = "Auto Padlock",
     Risky = Services.ReplicatedStorage.GameData.Floor.Value ~= "Hotel",
    Callback = function(state)
        if state then
            AutoPadlock.Enable()
        else
            AutoPadlock.Disable()
        end
    end
})

local AutoBreaker = false
local AutoBreakerConnection = nil
local BreakerBoxFinishedConnection = nil

local BreakerMode = "Instant"

Globals.BreakerBoxFinishedNotified = false

AutomationSuff:AddDropdown("AutoBreakerBoxMode", {
    Values = {"Instant", "Legit"},
    Default = 1,
    Multi = false,
    Compact = true,
    Text = "Auto Breaker Box Mode",
    Tooltip = "Select the mode for the breaker box.",
    Callback = function(mode)
        BreakerMode = mode
    end
})

AutomationSuff:AddToggle("AutoBreakerBox", {
    Text = "Auto Breaker Box",
    Tooltip = "Completes the elevator breakerbox works on old hotel too but only instant mode",
    Risky = Services.ReplicatedStorage.GameData.Floor.Value ~= "Hotel",
    Callback = function(Value)
        AutoBreaker = Value
    end
})

local function EnableBreaker(Breaker)
    if Breaker:GetAttribute("Enabled") == false then
        Breaker:SetAttribute("Enabled", true)
        Breaker.Light.Material = Enum.Material.Neon
        Breaker.Light.Attachment.Spark:Emit(1)
        Breaker.PrismaticConstraint.TargetPosition = -0.2
        Breaker.Sound:Play()
    end
end

local function DisableBreaker(Breaker)
    if Breaker:GetAttribute("Enabled") == true then
        Breaker:SetAttribute("Enabled", false)
        Breaker.Light.Material = Enum.Material.Glass
        Breaker.PrismaticConstraint.TargetPosition = 0.2
        Breaker.Sound:Play()
    end
end

local function SetupBreaker(inst)
    if inst.Name ~= "ElevatorBreaker" then return end

    if AutoBreakerConnection then
        AutoBreakerConnection:Disconnect()
        AutoBreakerConnection = nil
    end

    local CodeFrame = inst:WaitForChild("SurfaceGui").Frame.Code

    AutoBreakerConnection = CodeFrame:GetPropertyChangedSignal("Text"):Connect(function()
        if not AutoBreaker then return end

        local code = CodeFrame.Text
        local numeric = tonumber(code)

        if BreakerMode == "Instant" then
            RemotesFolder.EBF:FireServer()
            return
        end

        if numeric then
            for _, Breaker in ipairs(inst:GetChildren()) do
                if Breaker.Name == "BreakerSwitch" then
                    if Breaker:GetAttribute("ID") == numeric then
                        if CodeFrame.Frame.BackgroundTransparency == 0 then
                            EnableBreaker(Breaker)
                        else
                            DisableBreaker(Breaker)
                        end
                    end
                end
            end
        end
    end)
end

workspace.DescendantAdded:Connect(SetupBreaker)

workspace.DescendantAdded:Connect(function(Object)
    if Object.Name ~= "ElevatorCar" then return end

    Globals.BreakerBoxFinishedNotified = false

    if BreakerBoxFinishedConnection then
        BreakerBoxFinishedConnection:Disconnect()
        BreakerBoxFinishedConnection = nil
    end

    BreakerBoxFinishedConnection = Object.DescendantAdded:Connect(function(Object2)
        if Toggles.AutoBreakerBox.Value
        and Object2.Name == "TouchInterest"
        and not Globals.BreakerBoxFinishedNotified then

            Library:Notify("<b>[BlackKing]</b>\nSuccessfully solved the breaker box, try going to the elevator!")
            sound()
            if Toggles.autoplay.Value then
                Toggles.autoplay:SetValue(false)
            end
            Globals.BreakerBoxFinishedNotified = true
        end
    end)

    Object.Destroying:Once(function()
        if BreakerBoxFinishedConnection then
            BreakerBoxFinishedConnection:Disconnect()
            BreakerBoxFinishedConnection = nil
        end
    end)
end)

local AntiCheatBypass = {}
AntiCheatBypass.Enabled = false

local bypassThread = nil
local roomConn = nil

local Workspace = game:GetService("Workspace")

local LadderESPObjects = {}
local LadderBlacklist = {}

local function RemoveAllLadderESP()
    for obj, conn in pairs(LadderESPObjects) do
        if conn and conn.Connected then
            conn:Disconnect()
        end
        ESPLibrary:RemoveESP(obj)
        LadderESPObjects[obj] = nil
    end
end

local function CleanDeadLadders()
    for obj, conn in pairs(LadderESPObjects) do
        if not obj or not obj.Parent then
            if conn and conn.Connected then
                conn:Disconnect()
            end
            ESPLibrary:RemoveESP(obj)
            LadderESPObjects[obj] = nil
        end
    end
end

local function CreateLadderESP(roomNumber)
    local Rooms = Workspace:FindFirstChild("CurrentRooms")
    if not Rooms then return end

    local Room = Rooms:FindFirstChild(tostring(roomNumber))
    if not Room then return end

    for _, child in ipairs(Room:GetDescendants()) do
        if child.Name == "Ladder" and not LadderBlacklist[child] and not LadderESPObjects[child] then

            ESPLibrary:AddESP({
                Object = child,
                Text = "Ladder",
                Color = Color3.fromRGB(255, 255, 255)
            })

            local prompt = child:FindFirstChildWhichIsA("ProximityPrompt", true)
            if prompt then
                local conn
                conn = prompt.Triggered:Connect(function()
                    if conn and conn.Connected then conn:Disconnect() end
                    ESPLibrary:RemoveESP(child)
                    LadderESPObjects[child] = nil
                    LadderBlacklist[child] = true
                end)

                LadderESPObjects[child] = conn
            else
                LadderESPObjects[child] = false
            end
        end
    end
end

local function startRoomListener()
    if roomConn then return end

    roomConn = LocalPlayer:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
        if not AntiCheatBypass.Enabled then return end

        local room = LocalPlayer:GetAttribute("CurrentRoom")
        if room then
            CleanDeadLadders()
            CreateLadderESP(room)
        end
    end)
end

local function startBypassLoop()
    if bypassThread then return end

    bypassThread = task.spawn(function()
        while AntiCheatBypass.Enabled do
            task.wait(0.1)

            pcall(function()
                local char = LocalPlayer.Character
                if not char then return end

                if char:GetAttribute("Climbing") == true then
                    Library:Notify("<b>[BlackKing]</b>\nBypassing...")
                    sound()

                    task.wait(1)

                    if char then
                        char:SetAttribute("Climbing", false)
                    end

                    Library:Notify("<b>[BlackKing]</b>\nBypass active until next cutscene/jumpscare.")
                    sound()
                end
            end)
        end

        bypassThread = nil
    end)
end

function AntiCheatBypass.Enable()
    if AntiCheatBypass.Enabled then return end
    AntiCheatBypass.Enabled = true

    Library:Notify("<b>[BlackKing]</b>\nInteract with a ladder to bypass anticheat.")
    sound()

    local room = LocalPlayer:GetAttribute("CurrentRoom")
    if room then
        CreateLadderESP(room)
    end

    startRoomListener()
    startBypassLoop()
end

function AntiCheatBypass.Disable()
    if not AntiCheatBypass.Enabled then return end
    AntiCheatBypass.Enabled = false

    RemoveAllLadderESP()

    if roomConn then
        roomConn:Disconnect()
        roomConn = nil
    end

end

_G.AntiCheatBypass = AntiCheatBypass

BypassStuff:AddToggle("AnticheatBypass", {
    Text = "Bypass Anticheat",
    Tooltip = "Allows walking through walls after climbing a ladder.",
    Risky = Services.ReplicatedStorage.GameData.Floor.Value ~= "Mines",
    Callback = function(state)
        if state then
            AntiCheatBypass.Enable()
        else
            AntiCheatBypass.Disable()
        end
    end
})

local AutoAnchor = {}
AutoAnchor.Enabled = false
local anchorLoop = nil

local Workspace = game:GetService("Workspace")

local function getCurrentGameState()
    local ui = LocalPlayer.PlayerGui.MainUI.AnchorHintFrame

    return {
        DesignatedAnchor = ui.AnchorCode.Text,
        AnchorCode = ui.Code.Text
    }
end

local function processRoom50()
    local room50 = Workspace.CurrentRooms:FindFirstChild("50")
    if not room50 then return end

    local nest = room50:FindFirstChild("_NestHandler")
    if not nest then return end

    local state = getCurrentGameState()

    for _, anchor in ipairs(nest:GetChildren()) do
        if anchor.Name == "MinesAnchor" then
            local sign = anchor:FindFirstChild("Sign")
            if sign and sign:FindFirstChild("TextLabel") then
                if sign.TextLabel.Text == state.DesignatedAnchor then
                    anchor.AnchorRemote:InvokeServer(state.AnchorCode)
                end
            end
        end
    end
end

local function startAnchorLoop()
    if anchorLoop then return end

    anchorLoop = task.spawn(function()
        while AutoAnchor.Enabled do
            task.wait(0.2)

            pcall(function()
                processRoom50()
            end)
        end
    end)
end

function AutoAnchor.Enable()
    AutoAnchor.Enabled = true
    startAnchorLoop()
end

function AutoAnchor.Disable()
    AutoAnchor.Enabled = false
    anchorLoop = nil
end

_G.AutoAnchor = AutoAnchor

AutomationSuff:AddToggle("AutoAnchor", {
    Text = "Auto Anchor",
    Tooltip = "When you walk up to the anchor it will do the code.",
        Risky = Services.ReplicatedStorage.GameData.Floor.Value ~= "Mines",
    Callback = function(state)
        if state then
            AutoAnchor.Enable()
        else
            AutoAnchor.Disable()
        end
    end
})

Bridges = {}

function CreateBridgeClone(barrier, parent)
    clone = barrier:Clone()
    clone.CFrame = clone.CFrame * CFrame.new(0, 0, -5)
    clone.Color = Color3.new(0, 0.666667, 1)
    clone.Name = ESPLibrary:GenerateRandomString()
    clone.Size = Vector3.new(clone.Size.X, clone.Size.Y, 11)
    clone.Transparency = 0.5
    clone.CanCollide = true
    clone.Parent = parent
    table.insert(Bridges, clone)
end


function ScanAllBridges()
    for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
        if room:FindFirstChild("Parts") then
            for _, bridge in pairs(room.Parts:GetChildren()) do
                if bridge.Name == "Bridge" then
                    for _, barrier in pairs(bridge:GetChildren()) do
                        if barrier.Name == "PlayerBarrier"
                        and barrier.Size.Y == 2.75
                        and (barrier.Rotation.X == 0 or barrier.Rotation.X == 180) then
                            CreateBridgeClone(barrier, bridge)
                        end
                    end
                end
            end
        end
    end
end


function ClearBridges()
    for _, b in pairs(Bridges) do
        if b and b.Parent then
            b:Destroy()
        end
    end
    table.clear(Bridges)
end


BypassStuff:AddToggle("AntiSeekBridge", {
    Text = "Anti Seek Bridge",
    Tooltip = "Makes it that you can walk on the bridges that broke.",
    Risky = Services.ReplicatedStorage.GameData.Floor.Value ~= "Mines",

    Callback = function(state)
        if not state then
            ClearBridges()
        end
    end
})


Toggles.AntiSeekBridge:OnChanged(function(value)
    if value then
        ScanAllBridges()
    else
        ClearBridges()
    end
end)


workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
    if Toggles.AntiSeekBridge and Toggles.AntiSeekBridge.Value then

        if inst.Name == "Bridge" then
            for _, barrier in pairs(inst:GetChildren()) do
                if barrier.Name == "PlayerBarrier"
                and barrier.Size.Y == 2.75
                and (barrier.Rotation.X == 0 or barrier.Rotation.X == 180) then
                    CreateBridgeClone(barrier, inst)
                end
            end
        end
    end
end)

local SeekConnections = {}
local SeekAttachments = {}
local SeekBeams = {}

local function ClearVisuals()
    for _, a in ipairs(SeekAttachments) do
        if a and a.Parent then a:Destroy() end
    end
    table.clear(SeekAttachments)

    for _, b in ipairs(SeekBeams) do
        if b and b.Parent then b:Destroy() end
    end
    table.clear(SeekBeams)
end

local function ClearAll()
    for _, c in ipairs(SeekConnections) do
        c:Disconnect()
    end
    table.clear(SeekConnections)

    ClearVisuals()
end

local function CreateBeam(att0, att1)
    local beam = Instance.new("Beam")
    beam.Name = ESPLibrary:GenerateRandomString()
    beam.Parent = workspace.Terrain
    beam.Attachment0 = att0
    beam.Attachment1 = att1
    beam:SetAttribute("SeekNode", true)

    beam.Width0 = 0.25
    beam.Width1 = 0.25
    beam.FaceCamera = true
    beam.Brightness = 10
    beam.LightInfluence = 0
    beam.LightEmission = 0
    beam.Enabled = true

    local col = Options.ShowSeekPathColor.Value
    beam.Color = ColorSequence.new(col, col)

    table.insert(SeekBeams, beam)
end

local function BuildSeekPath()
    ClearVisuals()

    local folder = workspace:FindFirstChild("PathLights")
    if not folder then return end

    local previous = nil

    for _, node in ipairs(folder:GetChildren()) do
        if node.Name == "SeekGuidingLight" then
            local att = Instance.new("Attachment")
            att.Parent = workspace.Terrain
            att.WorldPosition = node.Position
            att:SetAttribute("SeekNode", true)

            table.insert(SeekAttachments, att)

            if previous then
                CreateBeam(previous, att)
            end

            previous = att
        end
    end
end

local function StartWatching()
    local con1 = workspace.ChildAdded:Connect(function(child)
        if child.Name == "PathLights" and Toggles.ShowSeekPath.Value then
            task.wait(0.05)
            BuildSeekPath()

            local con2 = child.ChildAdded:Connect(function()
                if Toggles.ShowSeekPath.Value then
                    task.wait(0.05)
                    BuildSeekPath()
                end
            end)

            table.insert(SeekConnections, con2)
        end
    end)

    table.insert(SeekConnections, con1)

    local folder = workspace:FindFirstChild("PathLights")
    if folder then
        local con3 = folder.ChildAdded:Connect(function()
            if Toggles.ShowSeekPath.Value then
                task.wait(0.05)
                BuildSeekPath()
            end
        end)

        table.insert(SeekConnections, con3)
    end
end

VisualStuff3:AddToggle("ShowSeekPath", {
    Text = "Show Seeks Path",
    Tooltip = "Shows Seek's chase path.",
    Risky = Services.ReplicatedStorage.GameData.Floor.Value ~= "Mines",

    Callback = function(state)
        if not state then
            ClearAll()
            return
        end

        BuildSeekPath()
        StartWatching()
    end
}):AddColorPicker("ShowSeekPathColor", {
    Default = Color3.fromRGB(0,255,0),
    Title = "Node Color",
    Transparency = 0,

    Callback = function(newColor)
        for _, beam in ipairs(SeekBeams) do
            if beam and beam.Parent then
                beam.Color = ColorSequence.new(newColor, newColor)
            end
        end
    end
})

local AntiLavaConnection = nil

BypassStuff:AddToggle("AntiLava", {
    Text = "Anti Lava",
    Tooltip = "Can Walk Thru Lava.",
    Risky = Services.ReplicatedStorage.GameData.Floor.Value ~= "Retro",
    Callback = function(enabled)

        if not enabled then
            if AntiLavaConnection then
                AntiLavaConnection:Disconnect()
                AntiLavaConnection = nil
            end

            for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
                local lavaFolder = room:FindFirstChild("ScaryLava")
                if lavaFolder and lavaFolder:FindFirstChild("Lava Strips") then
                    for _, part in ipairs(lavaFolder["Lava Strips"]:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = true
                        end
                    end
                end

                local partsFolder = room:FindFirstChild("Parts")
                if partsFolder and partsFolder:FindFirstChild("ScaryWall") then
                    local wall = partsFolder.ScaryWall:FindFirstChild("TheWall")
                    if wall and wall:IsA("BasePart") then
                    end
                end
            end

            return
        end

        AntiLavaConnection = task.spawn(function()
            while Toggles.AntiLava.Value do

                local latestRoomValue = Services.ReplicatedStorage:WaitForChild("GameData"):WaitForChild("LatestRoom")
                local latestRoom = latestRoomValue.Value

                local currentRoom = workspace.CurrentRooms:FindFirstChild(tostring(latestRoom))

                if currentRoom then
                    local lavaFolder = currentRoom:FindFirstChild("ScaryLava")
                    if lavaFolder and lavaFolder:FindFirstChild("Lava Strips") then
                        for _, part in ipairs(lavaFolder["Lava Strips"]:GetChildren()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end

                    local partsFolder = currentRoom:FindFirstChild("Parts")
                    if partsFolder and partsFolder:FindFirstChild("ScaryWall") then
                        local wall = partsFolder.ScaryWall:FindFirstChild("TheWall")
                        if wall and wall:IsA("BasePart") then
                      end
                    end
                end

                task.wait(0.1)
            end
        end)
    end
})

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

	Library.KeybindFrame.Visible = true;

	_G.ShowKeybind = false
	_G.ShowCustomCursor = true

	MenuGroup:AddToggle('ShowKeybind', { 
		Text = 'Show Keybind',
		Default = true,
		Callback = function(ShowKbs)
			_G.ShowKeybind = ShowKbs

			if _G.ShowKeybind == false then
				Library.KeybindFrame.Visible = false
			elseif _G.ShowKeybind == true then
				Library.KeybindFrame.Visible = true
			end
		end
	})

	MenuGroup:AddToggle('ShowCustomCursor', { 
		Text = 'Show CustomCursor',
		Default = _G.ShowCustomCursor,
		Callback = function(ShowCustomCursors)
			_G.ShowCustomCursor = ShowCustomCursors

			if _G.ShowCustomCursor == false then
				Library.ShowCustomCursor = false
			elseif _G.ShowCustomCursor == true then
				Library.ShowCustomCursor = true
			end
		end
	})

	MenuGroup:AddDivider()

	-- ── Switch UI Library ───────────────────────────────────────────────
	local SCRIPT_URL = "https://raw.githubusercontent.com/GeorgeRoblox/BlackKingV3/refs/heads/main/lua"

	MenuGroup:AddLabel("<font color='#ffdd44'>Đổi UI Library (Mobile / PC):</font>")

	MenuGroup:AddButton("Rayfield (Mobile)", function()
		Library:Notify("<b>[BlackKing]</b>\nĐang tải lại với Rayfield UI...")
		task.wait(1)
		Library:Unload()
		task.wait(0.25)
		getgenv().Bk = nil
		getgenv().Lib = "Rayfield"
		loadstring(game:HttpGet(SCRIPT_URL))()
	end)

	MenuGroup:AddButton("Linoria (PC)", function()
		Library:Notify("<b>[BlackKing]</b>\nĐang tải lại với Linoria UI...")
		task.wait(1)
		Library:Unload()
		task.wait(0.25)
		getgenv().Bk = nil
		getgenv().Lib = "Linoria"
		loadstring(game:HttpGet(SCRIPT_URL))()
	end)

	MenuGroup:AddButton("Obsidian (Mobile)", function()
		Library:Notify("<b>[BlackKing]</b>\nĐang tải lại với Obsidian UI...")
		task.wait(1)
		Library:Unload()
		task.wait(0.25)
		getgenv().Bk = nil
		getgenv().Lib = "Obsidian"
		loadstring(game:HttpGet(SCRIPT_URL))()
	end)

	MenuGroup:AddDivider()
	-- ── End UI Library switcher ─────────────────────────────────────────

	MenuGroup:AddButton('Copy Discord Server Link', function()
		setclipboard("https://discord.gg/HjqzMPJveZ")
		Library:Notify("<b>[BlackKing]</b>\nCopy Discord Server Link: Done!")
		sound()
	end)

	MenuGroup:AddDivider()


MenuGroup:AddButton("Unload", function()

FlyModule:Unload()

    if SpeedBoostConnection then
        SpeedBoostConnection:Disconnect()
        SpeedBoostConnection = nil
    end

    if AutoBreakerConnection then
    AutoBreakerConnection:Disconnect()
    AutoBreakerConnection = nil
end


    SpeedBypassCoroutine = nil

if NoAccelerationConnection then
    NoAccelerationConnection:Disconnect()
    NoAccelerationConnection = nil
end

local Acceleration = false
if Character then
    Character.LeftFoot.Massless = Acceleration
    Character.LeftHand.Massless = Acceleration
    Character.LeftLowerArm.Massless = Acceleration
    Character.LeftLowerLeg.Massless = Acceleration
    Character.LeftUpperArm.Massless = Acceleration
    Character.LeftUpperLeg.Massless = Acceleration
    Character.LowerTorso.Massless = Acceleration
    Character.RightFoot.Massless = Acceleration
    Character.RightHand.Massless = Acceleration
    Character.RightLowerArm.Massless = Acceleration
    Character.RightLowerLeg.Massless = Acceleration
    Character.RightUpperArm.Massless = Acceleration
    Character.RightUpperLeg.Massless = Acceleration
    Character.UpperTorso.Massless = Acceleration
end

    if AmbientToggleConnection then
        AmbientToggleConnection:Disconnect()
        AmbientToggleConnection = nil
    end

    if AmbientLockConnection then
        AmbientLockConnection:Disconnect()
        AmbientLockConnection = nil
    end

if FovLockConnection then
    FovLockConnection:Disconnect()
    FovLockConnection = nil
end

CurrentFov = DefaultFov

local cam = workspace.CurrentCamera
if cam then
    TweenService:Create(
        cam,
        TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
        { FieldOfView = DefaultFov }
    ):Play()
end


	ESPLibrary:Unload()
	Library:Unload()
    getgenv().Bk = nil
end)

	MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'RightControl', NoUI = true, Text = 'Menu keybind' })

	Library.ToggleKeybind = Options.MenuKeybind

	local AboutGroup = Tabs['UI Settings']:AddRightGroupbox('Contributors')

	AboutGroup:AddLabel("<font color='#15ff00'>bocaj11104</font> - Esp Library")
    AboutGroup:AddLabel("<font color='#15ff00'>Abbas</font> - Helped with \nPosition Spoof")
	ThemeManager:SetLibrary(Library)
	SaveManager:SetLibrary(Library)
	SaveManager:IgnoreThemeSettings()
	SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
	ThemeManager:SetFolder('BlackKing')
	SaveManager:SetFolder('BlackKing/Hub/Doors')
	SaveManager:BuildConfigSection(Tabs['UI Settings'])
	ThemeManager:ApplyToTab(Tabs['UI Settings'])
end
