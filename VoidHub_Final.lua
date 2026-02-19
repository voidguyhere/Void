repeat task.wait() until game:IsLoaded()

-- ============================================================
-- VOID HUB — ALL FEATURES COMBINED
-- Key System | Combat | Movement | Stealing | Visuals | Booster | Semi TP | Auto Duel | AP Spammer
-- Discord: https://discord.gg/xzcRvnbncb  (Key: VOID1982)
-- ============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")
local ProximityPromptService = game:GetService("ProximityPromptService")
local TextChatService = game:GetService("TextChatService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local playerGui = Player:WaitForChild("PlayerGui")

local function waitForCharacter()
    local char = Player.Character
    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChildOfClass("Humanoid") then return char end
    return Player.CharacterAdded:Wait()
end
task.spawn(function() waitForCharacter() end)
if not getgenv then getgenv = function() return _G end end

-- ============================================================
-- COLORS & THEME
-- ============================================================
local C = {
    bg          = Color3.fromRGB(10, 7, 15),
    panel       = Color3.fromRGB(18, 13, 25),
    purple      = Color3.fromRGB(139, 92, 246),
    purpleLight = Color3.fromRGB(167, 139, 250),
    purpleDark  = Color3.fromRGB(88, 28, 135),
    purpleGlow  = Color3.fromRGB(196, 181, 253),
    accent      = Color3.fromRGB(139, 92, 246),
    text        = Color3.fromRGB(255, 255, 255),
    textDim     = Color3.fromRGB(167, 139, 250),
    success     = Color3.fromRGB(34, 197, 94),
    danger      = Color3.fromRGB(239, 68, 68),
    border      = Color3.fromRGB(88, 28, 135),
    tabInactive = Color3.fromRGB(30, 22, 45),
}

-- ============================================================
-- KEY SYSTEM
-- ============================================================
local VALID_KEY = "VOID1982"
local DISCORD_LINK = "https://discord.gg/xzcRvnbncb"
local keyVerified = false

local keyGui = Instance.new("ScreenGui")
keyGui.Name = "VoidKeySystem"
keyGui.ResetOnSpawn = false
keyGui.Parent = playerGui

local keyBg = Instance.new("Frame")
keyBg.Size = UDim2.new(1, 0, 1, 0)
keyBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
keyBg.BackgroundTransparency = 0.4
keyBg.BorderSizePixel = 0
keyBg.Parent = keyGui

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 420, 0, 280)
keyFrame.Position = UDim2.new(0.5, -210, 0.5, -140)
keyFrame.BackgroundColor3 = C.bg
keyFrame.BorderSizePixel = 0
keyFrame.Parent = keyGui
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 16)

local keyStroke = Instance.new("UIStroke", keyFrame)
keyStroke.Thickness = 2
keyStroke.Color = C.purple
keyStroke.Transparency = 0

task.spawn(function()
    local rot = 0
    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, C.purple),
        ColorSequenceKeypoint.new(0.5, C.purpleLight),
        ColorSequenceKeypoint.new(1, C.purple),
    }
    grad.Parent = keyStroke
    while keyFrame and keyFrame.Parent do
        rot = (rot + 3) % 360
        grad.Rotation = rot
        task.wait(0.02)
    end
end)

-- Particles on key screen
for i = 1, 25 do
    local ball = Instance.new("Frame", keyFrame)
    ball.Size = UDim2.new(0, math.random(2,4), 0, math.random(2,4))
    ball.Position = UDim2.new(math.random(2,98)/100, 0, math.random(2,98)/100, 0)
    ball.BackgroundColor3 = C.purpleLight
    ball.BackgroundTransparency = 0.4
    ball.BorderSizePixel = 0; ball.ZIndex = 1
    Instance.new("UICorner", ball).CornerRadius = UDim.new(1,0)
    task.spawn(function()
        local sx = ball.Position.X.Scale; local sy = ball.Position.Y.Scale
        local phase = math.random() * math.pi * 2
        while ball and ball.Parent do
            local t = tick() + phase
            ball.Position = UDim2.new(math.clamp(sx+math.sin(t*0.5)*0.04,0.01,0.99),0,
                                       math.clamp(sy+math.cos(t*0.4)*0.05,0.01,0.99),0)
            ball.BackgroundTransparency = 0.3 + math.sin(t*2) * 0.2
            task.wait(0.03)
        end
    end)
end

local keyTitle = Instance.new("TextLabel", keyFrame)
keyTitle.Size = UDim2.new(1, 0, 0, 50)
keyTitle.Position = UDim2.new(0, 0, 0, 10)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "✦ VOID HUB ✦"
keyTitle.Font = Enum.Font.GothamBlack
keyTitle.TextSize = 28
keyTitle.TextColor3 = C.text
keyTitle.ZIndex = 5
local keyTitleGrad = Instance.new("UIGradient")
keyTitleGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, C.purpleLight),
    ColorSequenceKeypoint.new(0.5, C.purple),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(217, 70, 239)),
}
keyTitleGrad.Parent = keyTitle

local keySubtitle = Instance.new("TextLabel", keyFrame)
keySubtitle.Size = UDim2.new(1, 0, 0, 20)
keySubtitle.Position = UDim2.new(0, 0, 0, 58)
keySubtitle.BackgroundTransparency = 1
keySubtitle.Text = "Enter your key to continue"
keySubtitle.Font = Enum.Font.GothamSemibold
keySubtitle.TextSize = 13
keySubtitle.TextColor3 = C.textDim
keySubtitle.ZIndex = 5

local keyDiscordInfo = Instance.new("TextLabel", keyFrame)
keyDiscordInfo.Size = UDim2.new(1, 0, 0, 16)
keyDiscordInfo.Position = UDim2.new(0, 0, 0, 80)
keyDiscordInfo.BackgroundTransparency = 1
keyDiscordInfo.Text = "Get your key from: discord.gg/xzcRvnbncb"
keyDiscordInfo.Font = Enum.Font.Gotham
keyDiscordInfo.TextSize = 10
keyDiscordInfo.TextColor3 = Color3.fromRGB(139, 92, 246)
keyDiscordInfo.ZIndex = 5

local keyInputBg = Instance.new("Frame", keyFrame)
keyInputBg.Size = UDim2.new(0.85, 0, 0, 44)
keyInputBg.Position = UDim2.new(0.075, 0, 0, 108)
keyInputBg.BackgroundColor3 = C.panel
keyInputBg.BorderSizePixel = 0
keyInputBg.ZIndex = 5
Instance.new("UICorner", keyInputBg).CornerRadius = UDim.new(0, 10)
local keyInputStroke = Instance.new("UIStroke", keyInputBg)
keyInputStroke.Color = C.purpleDark; keyInputStroke.Thickness = 1.5

local keyInput = Instance.new("TextBox", keyInputBg)
keyInput.Size = UDim2.new(1, -20, 1, 0)
keyInput.Position = UDim2.new(0, 10, 0, 0)
keyInput.BackgroundTransparency = 1
keyInput.PlaceholderText = "Enter key here..."
keyInput.PlaceholderColor3 = Color3.fromRGB(80, 60, 100)
keyInput.Text = ""
keyInput.Font = Enum.Font.GothamBold
keyInput.TextSize = 14
keyInput.TextColor3 = C.text
keyInput.ZIndex = 6
keyInput.ClearTextOnFocus = false

local keyStatus = Instance.new("TextLabel", keyFrame)
keyStatus.Size = UDim2.new(1, 0, 0, 20)
keyStatus.Position = UDim2.new(0, 0, 0, 160)
keyStatus.BackgroundTransparency = 1
keyStatus.Text = ""
keyStatus.Font = Enum.Font.GothamBold
keyStatus.TextSize = 12
keyStatus.ZIndex = 5

local keyBtn = Instance.new("TextButton", keyFrame)
keyBtn.Size = UDim2.new(0.4, 0, 0, 40)
keyBtn.Position = UDim2.new(0.075, 0, 0, 186)
keyBtn.BackgroundColor3 = C.purple
keyBtn.Text = "✓ UNLOCK"
keyBtn.Font = Enum.Font.GothamBold
keyBtn.TextSize = 14
keyBtn.TextColor3 = C.text
keyBtn.BorderSizePixel = 0
keyBtn.ZIndex = 5
Instance.new("UICorner", keyBtn).CornerRadius = UDim.new(0, 10)

local copyDiscordBtn = Instance.new("TextButton", keyFrame)
copyDiscordBtn.Size = UDim2.new(0.38, 0, 0, 40)
copyDiscordBtn.Position = UDim2.new(0.545, 0, 0, 186)
copyDiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
copyDiscordBtn.Text = "📋 Discord"
copyDiscordBtn.Font = Enum.Font.GothamBold
copyDiscordBtn.TextSize = 12
copyDiscordBtn.TextColor3 = C.text
copyDiscordBtn.BorderSizePixel = 0
copyDiscordBtn.ZIndex = 5
Instance.new("UICorner", copyDiscordBtn).CornerRadius = UDim.new(0, 10)

copyDiscordBtn.MouseButton1Click:Connect(function()
    pcall(function() setclipboard(DISCORD_LINK) end)
    copyDiscordBtn.Text = "✅ Copied!"
    copyDiscordBtn.BackgroundColor3 = C.success
    task.delay(2, function()
        copyDiscordBtn.Text = "📋 Discord"
        copyDiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    end)
end)

local keyVersion = Instance.new("TextLabel", keyFrame)
keyVersion.Size = UDim2.new(1, 0, 0, 16)
keyVersion.Position = UDim2.new(0, 0, 1, -20)
keyVersion.BackgroundTransparency = 1
keyVersion.Text = "Void Hub v2.0 | Key: VOID1982"
keyVersion.Font = Enum.Font.Gotham
keyVersion.TextSize = 9
keyVersion.TextColor3 = C.textDim
keyVersion.ZIndex = 5

-- Animate key frame entrance
keyFrame.Size = UDim2.new(0, 0, 0, 0)
keyFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
TweenService:Create(keyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 420, 0, 280),
    Position = UDim2.new(0.5, -210, 0.5, -140)
}):Play()

local function verifyKey()
    local entered = keyInput.Text:gsub("%s", "")
    if entered == VALID_KEY then
        keyStatus.Text = "✅ Key Verified! Loading..."
        keyStatus.TextColor3 = C.success
        keyInputStroke.Color = C.success
        keyBtn.BackgroundColor3 = C.success
        task.delay(0.8, function()
            TweenService:Create(keyFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }):Play()
            task.delay(0.5, function()
                keyGui:Destroy()
                keyVerified = true
            end)
        end)
    else
        keyStatus.Text = "❌ Invalid Key! Get it from Discord."
        keyStatus.TextColor3 = C.danger
        keyInputStroke.Color = C.danger
        task.delay(2, function()
            keyStatus.Text = ""
            keyInputStroke.Color = C.purpleDark
        end)
    end
end

keyBtn.MouseButton1Click:Connect(verifyKey)
keyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then verifyKey() end
end)

-- Wait for key verification before loading main hub
repeat task.wait(0.1) until keyVerified

-- ============================================================
-- CONFIG & STATE
-- ============================================================
local ConfigFileName = "VoidHubConfig.json"
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local guiScale = isMobile and 0.5 or 1

local Enabled = {
    SpeedBoost         = false,
    AntiRagdoll        = false,
    SpinBot            = false,
    SpeedWhileStealing = false,
    AutoSteal          = false,
    Unwalk             = false,
    Optimizer          = false,
    Galaxy             = false,
    SpamBat            = false,
    BatAimbot          = false,
    AutoDisableSpeed   = true,
    GalaxySkyBright    = false,
    AutoWalkEnabled    = false,
    AutoRightEnabled   = false,
    ScriptUserESP      = true,
    MedusaInRange      = false,
    PlayerFollower     = false,
    AutoStealBooster   = false,
    SemiInvisible      = false,
    HighestBrainrot    = false,
    SpeedBoostBooster  = false,
    SpeedWhileStealingBooster = false,
    -- Semi TP features
    SemiTPEnabled      = false,
    AutoPotion         = false,
    SpeedAfterSteal    = false,
    -- AP Spammer
    AutoDefenseEnabled = false,
}

local Values = {
    BoostSpeed            = 30,
    SpinSpeed             = 30,
    StealingSpeedValue    = 29,
    STEAL_RADIUS          = 20,
    STEAL_DURATION        = 1.3,
    DEFAULT_GRAVITY       = 196.2,
    GalaxyGravityPercent  = 70,
    HOP_POWER             = 35,
    HOP_COOLDOWN          = 0.08,
    MedusaRange           = 15,
    PlayerFollowerSpeed   = 50,
    PlayerFollowerDistance = 5,
    BOOST_STEAL_RADIUS    = 25,
    BOOST_STEAL_DURATION  = 0.01,
    BOOST_SPEED           = 37.6,
    BoosterStealSpeed     = 28,
    SEMI_SPEED_BOOST      = 28,
}

local KEYBINDS = {
    SPEED     = Enum.KeyCode.V,
    SPIN      = Enum.KeyCode.N,
    GALAXY    = Enum.KeyCode.M,
    BATAIMBOT = Enum.KeyCode.X,
    NUKE      = Enum.KeyCode.Q,
    AUTOLEFT  = Enum.KeyCode.Z,
    AUTORIGHT = Enum.KeyCode.C,
}

pcall(function()
    if readfile and isfile and isfile(ConfigFileName) then
        local data = HttpService:JSONDecode(readfile(ConfigFileName))
        if data then
            for k, v in pairs(data) do if Enabled[k] ~= nil then Enabled[k] = v end end
            for k, v in pairs(data) do if Values[k] ~= nil then Values[k] = v end end
            if data.KEY_SPEED     then KEYBINDS.SPEED     = Enum.KeyCode[data.KEY_SPEED]     end
            if data.KEY_SPIN      then KEYBINDS.SPIN      = Enum.KeyCode[data.KEY_SPIN]      end
            if data.KEY_GALAXY    then KEYBINDS.GALAXY    = Enum.KeyCode[data.KEY_GALAXY]    end
            if data.KEY_BATAIMBOT then KEYBINDS.BATAIMBOT = Enum.KeyCode[data.KEY_BATAIMBOT] end
            if data.KEY_AUTOLEFT  then KEYBINDS.AUTOLEFT  = Enum.KeyCode[data.KEY_AUTOLEFT]  end
            if data.KEY_AUTORIGHT then KEYBINDS.AUTORIGHT = Enum.KeyCode[data.KEY_AUTORIGHT] end
        end
    end
end)

local function SaveConfig()
    local data = {}
    for k, v in pairs(Enabled) do data[k] = v end
    for k, v in pairs(Values)  do data[k] = v end
    data.KEY_SPEED     = KEYBINDS.SPEED.Name
    data.KEY_SPIN      = KEYBINDS.SPIN.Name
    data.KEY_GALAXY    = KEYBINDS.GALAXY.Name
    data.KEY_BATAIMBOT = KEYBINDS.BATAIMBOT.Name
    data.KEY_AUTOLEFT  = KEYBINDS.AUTOLEFT.Name
    data.KEY_AUTORIGHT = KEYBINDS.AUTORIGHT.Name
    local success = false
    if writefile then pcall(function() writefile(ConfigFileName, HttpService:JSONEncode(data)) success = true end) end
    return success
end

-- ============================================================
-- SHARED STATE & CONNECTIONS
-- ============================================================
local Connections = {}
local State = {
    medusaConnection         = nil,
    medusaEnabled            = false,
    playerFollowerConnection = nil,
    playerFollowerActive     = false,
    playerFollowerTarget     = nil,
}
local isStealing      = false
local lastBatSwing    = 0
local BAT_SWING_COOLDOWN = 0.12

local boosterStealData  = {}
local boosterIsStealing = false
local lastHighestCheck  = 0
local HIGHEST_CHECK_INTERVAL  = 0.5
local currentHighestPrompt    = nil
local currentHighestValue     = nil
local semiConnections         = {SemiInvisible = {}}
local isInvisible             = false
local semiClone, oldRoot, hip, animTrack, semiConnection, characterConnection

local SlapList = {
    {1,"Bat"},{2,"Slap"},{3,"Iron Slap"},{4,"Gold Slap"},
    {5,"Diamond Slap"},{6,"Emerald Slap"},{7,"Ruby Slap"},
    {8,"Dark Matter Slap"},{9,"Flame Slap"},{10,"Nuclear Slap"},
    {11,"Galaxy Slap"},{12,"Glitched Slap"},
}

local ADMIN_KEY        = "78a772b6-9e1c-4827-ab8b-04a07838f298"
local REMOTE_EVENT_ID  = "352aad58-c786-4998-886b-3e4fa390721e"
local BALLOON_REMOTE   = ReplicatedStorage:FindFirstChild(REMOTE_EVENT_ID, true)

-- Semi TP state
local pos1        = Vector3.new(-352.98, -7, 74.30)
local pos2        = Vector3.new(-352.98, -6.49, 45.76)
local standing1   = Vector3.new(-336.36, -4.59, 99.51)
local standing2   = Vector3.new(-334.81, -4.59, 18.90)
local spot1_sequence = {
    CFrame.new(-370.810913,-7.00000334,41.2687263,0.99984771,1.22364419e-09,0.0174523517,-6.54859778e-10,1,-3.2596418e-08,-0.0174523517,3.25800258e-08,0.99984771),
    CFrame.new(-336.355286,-5.10107088,17.2327671,-0.999883354,-2.76150569e-08,0.0152716246,-2.88224964e-08,1,-7.88441525e-08,-0.0152716246,-7.9275118e-08,-0.999883354),
}
local spot2_sequence = {
    CFrame.new(-354.782867,-7.00000334,92.8209305,-0.999997616,-1.11891862e-09,-0.00218066527,-1.11958298e-09,1,3.03415071e-10,0.00218066527,3.05855785e-10,-0.999997616),
    CFrame.new(-336.942902,-5.10106993,99.3276443,0.999914348,-3.63984611e-08,0.0130875716,3.67094941e-08,1,-2.35254749e-08,-0.0130875716,2.40038975e-08,0.999914348),
}
local autoSemiTpCFrameLeft  = CFrame.new(-349.325867,-7.00000238,95.0031433,-0.999048233,-8.29406233e-09,-0.0436184891,-1.03892832e-08,1,4.78084594e-08,0.0436184891,4.82161227e-08,-0.999048233)
local autoSemiTpCFrameRight = CFrame.new(-349.560211,-7.00000238,27.0543289,-0.999961913,5.50995267e-08,-0.00872585084,5.48100907e-08,1,3.34090586e-08,0.00872585084,3.29295204e-08,-0.999961913)
local semiSpeedConnection   = nil
local semiIsHolding         = false
local semiEquipTask         = nil

-- AP Spammer state
local selectedPlayers   = {}
local selectedSet       = {}
local lastDefenseTime   = 0
local defenseCooldown   = 3
local lastDefenseCheck  = 0

-- Auto Duel state
local duelWaypoints      = {}
local duelCurrentWP      = 1
local duelMoving         = false
local duelConnection     = nil
local duelSpeedConn      = nil
local duelWaitingGrab    = false
local duelGrabDetected   = false

-- ============================================================
-- HELPER FUNCTIONS
-- ============================================================
local function getHRP()
    local char = Player.Character
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart")
end

local function getHumanoid()
    local char = Player.Character
    if not char then return nil end
    return char:FindFirstChildOfClass("Humanoid")
end

local function getMovementDirection()
    local c = Player.Character; if not c then return Vector3.zero end
    local hum = c:FindFirstChildOfClass("Humanoid")
    return hum and hum.MoveDirection or Vector3.zero
end

local function getNearestPlayer()
    local c = Player.Character; if not c then return nil end
    local h = c:FindFirstChild("HumanoidRootPart"); if not h then return nil end
    local pos = h.Position
    local nearest, dist = nil, math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Player and p.Character then
            local oh = p.Character:FindFirstChild("HumanoidRootPart")
            if oh then
                local d = (pos - oh.Position).Magnitude
                if d < dist then dist = d; nearest = p end
            end
        end
    end
    return nearest
end

local function INSTANT_NUKE(target)
    if not BALLOON_REMOTE or not target then return end
    for _, p in ipairs({"balloon","ragdoll","jumpscare","morph","tiny","rocket","inverse","jail"}) do
        BALLOON_REMOTE:FireServer(ADMIN_KEY, target, p)
    end
end

local function findBat()
    local c = Player.Character; if not c then return nil end
    local bp = Player:FindFirstChildOfClass("Backpack")
    for _, ch in ipairs(c:GetChildren()) do
        if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end
    end
    if bp then
        for _, ch in ipairs(bp:GetChildren()) do
            if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end
        end
    end
    for _, i in ipairs(SlapList) do
        local t = c:FindFirstChild(i[2]) or (bp and bp:FindFirstChild(i[2]))
        if t then return t end
    end
    return nil
end

local function findMedusa()
    local char = Player.Character; if not char then return nil end
    local bp = Player:FindFirstChildOfClass("Backpack")
    for _, item in ipairs(char:GetChildren()) do
        if item:IsA("Tool") and item.Name:lower():find("medusa") then return item end
    end
    if bp then
        for _, item in ipairs(bp:GetChildren()) do
            if item:IsA("Tool") and item.Name:lower():find("medusa") then return item end
        end
    end
    return nil
end

local function isMyPlotByName(pn)
    local plots = Workspace:FindFirstChild("Plots"); if not plots then return false end
    local plot = plots:FindFirstChild(pn); if not plot then return false end
    local sign = plot:FindFirstChild("PlotSign")
    if sign then local yb = sign:FindFirstChild("YourBase"); if yb and yb:IsA("BillboardGui") then return yb.Enabled == true end end
    return false
end

-- ============================================================
-- COMBAT FEATURES
-- ============================================================
local function startSpamBat()
    if Connections.spamBat then return end
    Connections.spamBat = RunService.Heartbeat:Connect(function()
        if not Enabled.SpamBat then return end
        local c = Player.Character; if not c then return end
        local bat = findBat(); if not bat then return end
        if bat.Parent ~= c then bat.Parent = c end
        local now = tick()
        if now - lastBatSwing < BAT_SWING_COOLDOWN then return end
        lastBatSwing = now
        pcall(function() bat:Activate() end)
    end)
end
local function stopSpamBat()
    if Connections.spamBat then Connections.spamBat:Disconnect(); Connections.spamBat = nil end
end

local aimbotTarget = nil
local function findNearestEnemy(myHRP)
    local nearest, nearestDist, nearestTorso = nil, math.huge, nil
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Player and p.Character then
            local eh = p.Character:FindFirstChild("HumanoidRootPart")
            local torso = p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("Torso")
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if eh and hum and hum.Health > 0 then
                local d = (eh.Position - myHRP.Position).Magnitude
                if d < nearestDist then nearestDist = d; nearest = eh; nearestTorso = torso or eh end
            end
        end
    end
    return nearest, nearestDist, nearestTorso
end
local function startBatAimbot()
    if Connections.batAimbot then return end
    Connections.batAimbot = RunService.Heartbeat:Connect(function(dt)
        if not Enabled.BatAimbot then return end
        local c = Player.Character; if not c then return end
        local h = c:FindFirstChild("HumanoidRootPart"); local hum = c:FindFirstChildOfClass("Humanoid")
        if not h or not hum then return end
        local bat = findBat(); if bat and bat.Parent ~= c then hum:EquipTool(bat) end
        local target, dist, torso = findNearestEnemy(h)
        aimbotTarget = torso or target
        if target and torso then
            local dir = (torso.Position - h.Position)
            local flatDir = Vector3.new(dir.X, 0, dir.Z)
            local flatDist = flatDir.Magnitude
            if flatDist > 1.5 then
                local moveDir = flatDir.Unit
                h.AssemblyLinearVelocity = Vector3.new(moveDir.X * 55, h.AssemblyLinearVelocity.Y, moveDir.Z * 55)
            else
                local tv = target.AssemblyLinearVelocity
                h.AssemblyLinearVelocity = Vector3.new(tv.X, h.AssemblyLinearVelocity.Y, tv.Z)
            end
        end
    end)
end
local function stopBatAimbot()
    if Connections.batAimbot then Connections.batAimbot:Disconnect(); Connections.batAimbot = nil end
    aimbotTarget = nil
end

local function startMedusaInRange()
    if State.medusaConnection then State.medusaConnection:Disconnect() end
    State.medusaEnabled = true
    State.medusaConnection = RunService.RenderStepped:Connect(function()
        if not State.medusaEnabled then return end
        local char = Player.Character; if not char then return end
        local root = getHRP(); local humanoid = getHumanoid()
        if not root or not humanoid then return end
        local medusa = findMedusa()
        if medusa then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local target = p.Character.HumanoidRootPart
                    local dist = (target.Position - root.Position).Magnitude
                    if dist <= Values.MedusaRange then
                        humanoid:Move((target.Position - root.Position).Unit)
                        if medusa.Parent ~= char then humanoid:EquipTool(medusa) end
                        pcall(function() medusa:Activate() end)
                    end
                end
            end
        end
    end)
end
local function stopMedusaInRange()
    State.medusaEnabled = false
    if State.medusaConnection then State.medusaConnection:Disconnect(); State.medusaConnection = nil end
end

local function startAntiRagdoll()
    if Connections.antiRagdoll then return end
    Connections.antiRagdoll = RunService.Heartbeat:Connect(function()
        if not Enabled.AntiRagdoll then return end
        local c = Player.Character; if not c then return end
        local hum = c:FindFirstChildOfClass("Humanoid"); if not hum then return end
        if hum:GetState() == Enum.HumanoidStateType.Ragdoll or hum:GetState() == Enum.HumanoidStateType.FallingDown then
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end)
end
local function stopAntiRagdoll()
    if Connections.antiRagdoll then Connections.antiRagdoll:Disconnect(); Connections.antiRagdoll = nil end
end

local function startSpeedBoost()
    if Connections.speedBoost then return end
    Connections.speedBoost = RunService.Heartbeat:Connect(function()
        if not Enabled.SpeedBoost then return end
        local c = Player.Character; if not c then return end
        local h = c:FindFirstChild("HumanoidRootPart"); if not h then return end
        local md = getMovementDirection()
        if md.Magnitude > 0.1 then
            h.AssemblyLinearVelocity = Vector3.new(md.X * Values.BoostSpeed, h.AssemblyLinearVelocity.Y, md.Z * Values.BoostSpeed)
        end
    end)
end
local function stopSpeedBoost()
    if Connections.speedBoost then Connections.speedBoost:Disconnect(); Connections.speedBoost = nil end
end

local spaceHeld = false
local function startSpinBot()
    if Connections.spinBot then return end
    Connections.spinBot = RunService.Heartbeat:Connect(function()
        if not Enabled.SpinBot then return end
        local c = Player.Character; if not c then return end
        local h = c:FindFirstChild("HumanoidRootPart"); if not h then return end
        h.AssemblyAngularVelocity = Vector3.new(0, math.rad(Values.SpinSpeed) * 60, 0)
    end)
end
local function stopSpinBot()
    if Connections.spinBot then Connections.spinBot:Disconnect(); Connections.spinBot = nil end
end

local function setupGalaxyForce() end
local function adjustGalaxyJump() end
local function startGalaxy()
    if Connections.galaxy then return end
    Workspace.Gravity = Values.DEFAULT_GRAVITY * (Values.GalaxyGravityPercent / 100)
    Connections.galaxy = RunService.Heartbeat:Connect(function()
        if not Enabled.Galaxy then return end
        local c = Player.Character; if not c then return end
        local h = c:FindFirstChild("HumanoidRootPart"); if not h then return end
        if spaceHeld then
            h.AssemblyLinearVelocity = Vector3.new(h.AssemblyLinearVelocity.X, Values.HOP_POWER, h.AssemblyLinearVelocity.Z)
        end
    end)
end
local function stopGalaxy()
    if Connections.galaxy then Connections.galaxy:Disconnect(); Connections.galaxy = nil end
    Workspace.Gravity = Values.DEFAULT_GRAVITY
end

local function startUnwalk()
    if Connections.unwalk then return end
    Connections.unwalk = RunService.Heartbeat:Connect(function()
        if not Enabled.Unwalk then return end
        local c = Player.Character; if not c then return end
        local hum = c:FindFirstChildOfClass("Humanoid"); if not hum then return end
        hum.WalkSpeed = 0
    end)
end
local function stopUnwalk()
    if Connections.unwalk then Connections.unwalk:Disconnect(); Connections.unwalk = nil end
end

-- Player Follower
local function startPlayerFollower()
    if State.playerFollowerConnection then State.playerFollowerConnection:Disconnect() end
    State.playerFollowerActive = true
    State.playerFollowerConnection = RunService.Heartbeat:Connect(function()
        if not State.playerFollowerActive then return end
        local closestPlayer, closestDist = nil, math.huge
        local ourHRP = getHRP(); if not ourHRP then return end
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= Player and p.Character then
                local oh = p.Character:FindFirstChild("HumanoidRootPart")
                if oh then
                    local d = (oh.Position - ourHRP.Position).Magnitude
                    if d < closestDist then closestDist = d; closestPlayer = p end
                end
            end
        end
        State.playerFollowerTarget = closestPlayer
        if not closestPlayer or not closestPlayer.Character then return end
        local targetHRP = closestPlayer.Character:FindFirstChild("HumanoidRootPart"); if not targetHRP then return end
        local offsetPos = targetHRP.Position - (targetHRP.CFrame.LookVector * Values.PlayerFollowerDistance)
        local moveDir = (offsetPos - ourHRP.Position)
        if moveDir.Magnitude > 0.5 then
            ourHRP.AssemblyLinearVelocity = ourHRP.AssemblyLinearVelocity:Lerp(moveDir.Unit * Values.PlayerFollowerSpeed, 0.2)
        end
    end)
end
local function stopPlayerFollower()
    State.playerFollowerActive = false
    if State.playerFollowerConnection then State.playerFollowerConnection:Disconnect(); State.playerFollowerConnection = nil end
    State.playerFollowerTarget = nil
end

-- Auto Walk / Auto Right
local POSITION_1  = Vector3.new(-476.48, -6.28, 92.73)
local POSITION_2  = Vector3.new(-483.12, -4.95, 94.80)
local POSITION_R1 = Vector3.new(-476.16, -6.52, 25.62)
local POSITION_R2 = Vector3.new(-483.04, -5.09, 23.14)
local autoWalkPhase = 1; local autoRightPhase = 1
local autoWalkConnection = nil; local autoRightConnection = nil
local AutoWalkEnabled = false; local AutoRightEnabled = false

local coordESPFolder = Instance.new("Folder", Workspace)
coordESPFolder.Name = "VoidHub_CoordESP"
local function createCoordMarker(position, labelText, color)
    local dot = Instance.new("Part", coordESPFolder)
    dot.Anchored = true; dot.CanCollide = false; dot.CastShadow = false
    dot.Material = Enum.Material.Neon; dot.Color = color
    dot.Shape = Enum.PartType.Ball; dot.Size = Vector3.new(1,1,1)
    dot.Position = position; dot.Transparency = 0.2
    local bb = Instance.new("BillboardGui", dot)
    bb.AlwaysOnTop = true; bb.Size = UDim2.new(0,100,0,20); bb.StudsOffset = Vector3.new(0,2,0); bb.MaxDistance = 300
    local text = Instance.new("TextLabel", bb)
    text.Size = UDim2.new(1,0,1,0); text.BackgroundTransparency = 1; text.Text = labelText; text.TextColor3 = color
    text.TextStrokeColor3 = Color3.fromRGB(0,0,0); text.TextStrokeTransparency = 0; text.Font = Enum.Font.GothamBold; text.TextSize = 12
end
createCoordMarker(POSITION_1,  "L1",    Color3.fromRGB(167,139,250))
createCoordMarker(POSITION_2,  "L END", Color3.fromRGB(139,92,246))
createCoordMarker(POSITION_R1, "R1",    Color3.fromRGB(236,72,153))
createCoordMarker(POSITION_R2, "R END", Color3.fromRGB(217,70,239))

local function faceSouth()
    local c = Player.Character; if not c then return end
    local h = c:FindFirstChild("HumanoidRootPart"); if not h then return end
    h.CFrame = CFrame.new(h.Position) * CFrame.Angles(0,0,0)
end
local function faceNorth()
    local c = Player.Character; if not c then return end
    local h = c:FindFirstChild("HumanoidRootPart"); if not h then return end
    h.CFrame = CFrame.new(h.Position) * CFrame.Angles(0,math.rad(180),0)
end

local VisualSetters
local function startAutoWalk()
    if autoWalkConnection then autoWalkConnection:Disconnect() end
    autoWalkPhase = 1
    autoWalkConnection = RunService.Heartbeat:Connect(function()
        if not AutoWalkEnabled then return end
        local c = Player.Character; if not c then return end
        local h = c:FindFirstChild("HumanoidRootPart"); local hum = c:FindFirstChildOfClass("Humanoid")
        if not h or not hum then return end
        if autoWalkPhase == 1 then
            local dist = (Vector3.new(POSITION_1.X, h.Position.Y, POSITION_1.Z) - h.Position).Magnitude
            if dist < 1 then autoWalkPhase = 2 end
            local dir = (POSITION_1 - h.Position); local md = Vector3.new(dir.X,0,dir.Z).Unit
            hum:Move(md,false); h.AssemblyLinearVelocity = Vector3.new(md.X*Values.BoostSpeed, h.AssemblyLinearVelocity.Y, md.Z*Values.BoostSpeed)
        elseif autoWalkPhase == 2 then
            local dist = (Vector3.new(POSITION_2.X, h.Position.Y, POSITION_2.Z) - h.Position).Magnitude
            if dist < 1 then
                hum:Move(Vector3.zero,false); h.AssemblyLinearVelocity = Vector3.new(0,0,0)
                AutoWalkEnabled = false; Enabled.AutoWalkEnabled = false
                if VisualSetters and VisualSetters.AutoWalkEnabled then VisualSetters.AutoWalkEnabled(false,true) end
                if autoWalkConnection then autoWalkConnection:Disconnect(); autoWalkConnection = nil end
                faceSouth(); return
            end
            local dir = (POSITION_2 - h.Position); local md = Vector3.new(dir.X,0,dir.Z).Unit
            hum:Move(md,false); h.AssemblyLinearVelocity = Vector3.new(md.X*Values.BoostSpeed, h.AssemblyLinearVelocity.Y, md.Z*Values.BoostSpeed)
        end
    end)
end
local function stopAutoWalk()
    if autoWalkConnection then autoWalkConnection:Disconnect(); autoWalkConnection = nil end
    autoWalkPhase = 1
    local c = Player.Character; if c then local hum = c:FindFirstChildOfClass("Humanoid"); if hum then hum:Move(Vector3.zero,false) end end
end
local function startAutoRight()
    if autoRightConnection then autoRightConnection:Disconnect() end
    autoRightPhase = 1
    autoRightConnection = RunService.Heartbeat:Connect(function()
        if not AutoRightEnabled then return end
        local c = Player.Character; if not c then return end
        local h = c:FindFirstChild("HumanoidRootPart"); local hum = c:FindFirstChildOfClass("Humanoid")
        if not h or not hum then return end
        if autoRightPhase == 1 then
            local dist = (Vector3.new(POSITION_R1.X, h.Position.Y, POSITION_R1.Z) - h.Position).Magnitude
            if dist < 1 then autoRightPhase = 2 end
            local dir = (POSITION_R1 - h.Position); local md = Vector3.new(dir.X,0,dir.Z).Unit
            hum:Move(md,false); h.AssemblyLinearVelocity = Vector3.new(md.X*Values.BoostSpeed, h.AssemblyLinearVelocity.Y, md.Z*Values.BoostSpeed)
        elseif autoRightPhase == 2 then
            local dist = (Vector3.new(POSITION_R2.X, h.Position.Y, POSITION_R2.Z) - h.Position).Magnitude
            if dist < 1 then
                hum:Move(Vector3.zero,false); h.AssemblyLinearVelocity = Vector3.new(0,0,0)
                AutoRightEnabled = false; Enabled.AutoRightEnabled = false
                if VisualSetters and VisualSetters.AutoRightEnabled then VisualSetters.AutoRightEnabled(false,true) end
                if autoRightConnection then autoRightConnection:Disconnect(); autoRightConnection = nil end
                faceNorth(); return
            end
            local dir = (POSITION_R2 - h.Position); local md = Vector3.new(dir.X,0,dir.Z).Unit
            hum:Move(md,false); h.AssemblyLinearVelocity = Vector3.new(md.X*Values.BoostSpeed, h.AssemblyLinearVelocity.Y, md.Z*Values.BoostSpeed)
        end
    end)
end
local function stopAutoRight()
    if autoRightConnection then autoRightConnection:Disconnect(); autoRightConnection = nil end
    autoRightPhase = 1
    local c = Player.Character; if c then local hum = c:FindFirstChildOfClass("Humanoid"); if hum then hum:Move(Vector3.zero,false) end end
end

-- ============================================================
-- STEALING FEATURES
-- ============================================================
local ProgressBarFill, ProgressLabel, ProgressPercentLabel, RadiusInput
local stealStartTime   = nil
local progressConnection = nil
local StealData        = {}

local function ResetProgressBar()
    if ProgressLabel then ProgressLabel.Text = "READY" end
    if ProgressPercentLabel then ProgressPercentLabel.Text = "" end
    if ProgressBarFill then ProgressBarFill.Size = UDim2.new(0,0,1,0) end
end

local function findNearestPrompt()
    local h = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart"); if not h then return nil end
    local plots = Workspace:FindFirstChild("Plots"); if not plots then return nil end
    local np, nd, nn = nil, math.huge, nil
    for _, plot in ipairs(plots:GetChildren()) do
        if isMyPlotByName(plot.Name) then continue end
        local podiums = plot:FindFirstChild("AnimalPodiums"); if not podiums then continue end
        for _, pod in ipairs(podiums:GetChildren()) do
            pcall(function()
                local base = pod:FindFirstChild("Base"); local spawn = base and base:FindFirstChild("Spawn")
                if spawn then
                    local dist = (spawn.Position - h.Position).Magnitude
                    if dist < nd and dist <= Values.STEAL_RADIUS then
                        local att = spawn:FindFirstChild("PromptAttachment")
                        if att then
                            for _, ch in ipairs(att:GetChildren()) do
                                if ch:IsA("ProximityPrompt") then np, nd, nn = ch, dist, pod.Name; break end
                            end
                        end
                    end
                end
            end)
        end
    end
    return np, nd, nn
end

local function executeSteal(prompt, name)
    if isStealing then return end
    if not StealData[prompt] then
        StealData[prompt] = {hold={},trigger={},ready=true}
        pcall(function()
            if getconnections then
                for _, c in ipairs(getconnections(prompt.PromptButtonHoldBegan)) do if c.Function then table.insert(StealData[prompt].hold, c.Function) end end
                for _, c in ipairs(getconnections(prompt.Triggered)) do if c.Function then table.insert(StealData[prompt].trigger, c.Function) end end
            end
        end)
    end
    local data = StealData[prompt]; if not data.ready then return end
    data.ready = false; isStealing = true; stealStartTime = tick()
    if ProgressLabel then ProgressLabel.Text = name or "STEALING..." end
    if progressConnection then progressConnection:Disconnect() end
    progressConnection = RunService.Heartbeat:Connect(function()
        if not isStealing then progressConnection:Disconnect(); return end
        local prog = math.clamp((tick()-stealStartTime)/Values.STEAL_DURATION, 0, 1)
        if ProgressBarFill then ProgressBarFill.Size = UDim2.new(prog,0,1,0) end
        if ProgressPercentLabel then ProgressPercentLabel.Text = math.floor(prog*100).."%/" end
    end)
    task.spawn(function()
        for _, f in ipairs(data.hold) do task.spawn(f) end
        task.wait(Values.STEAL_DURATION)
        for _, f in ipairs(data.trigger) do task.spawn(f) end
        if progressConnection then progressConnection:Disconnect() end
        ResetProgressBar(); data.ready = true; isStealing = false
    end)
end

local function startAutoSteal()
    if Connections.autoSteal then return end
    Connections.autoSteal = RunService.Heartbeat:Connect(function()
        if not Enabled.AutoSteal or isStealing then return end
        local p, _, n = findNearestPrompt(); if p then executeSteal(p, n) end
    end)
end
local function stopAutoSteal()
    if Connections.autoSteal then Connections.autoSteal:Disconnect(); Connections.autoSteal = nil end
    isStealing = false; ResetProgressBar()
end

local function startSpeedWhileStealing()
    if Connections.speedWhileStealing then return end
    Connections.speedWhileStealing = RunService.Heartbeat:Connect(function()
        if not Enabled.SpeedWhileStealing or not Player:GetAttribute("Stealing") then return end
        local c = Player.Character; if not c then return end
        local h = c:FindFirstChild("HumanoidRootPart"); if not h then return end
        local md = getMovementDirection()
        if md.Magnitude > 0.1 then h.AssemblyLinearVelocity = Vector3.new(md.X*Values.StealingSpeedValue, h.AssemblyLinearVelocity.Y, md.Z*Values.StealingSpeedValue) end
    end)
end
local function stopSpeedWhileStealing()
    if Connections.speedWhileStealing then Connections.speedWhileStealing:Disconnect(); Connections.speedWhileStealing = nil end
end

-- ============================================================
-- VISUAL FEATURES
-- ============================================================
local originalTransparency = {}; local xrayEnabled = false
local function enableOptimizer()
    if getgenv and getgenv().OPTIMIZER_ACTIVE then return end
    if getgenv then getgenv().OPTIMIZER_ACTIVE = true end
    pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01; Lighting.GlobalShadows = false; Lighting.Brightness = 3; Lighting.FogEnd = 9e9 end)
    pcall(function()
        for _, obj in ipairs(Workspace:GetDescendants()) do
            pcall(function()
                if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then obj:Destroy()
                elseif obj:IsA("BasePart") then obj.CastShadow = false; obj.Material = Enum.Material.Plastic end
            end)
        end
    end)
    xrayEnabled = true
    pcall(function()
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Anchored and (obj.Name:lower():find("base") or (obj.Parent and obj.Parent.Name:lower():find("base"))) then
                originalTransparency[obj] = obj.LocalTransparencyModifier; obj.LocalTransparencyModifier = 0.85
            end
        end
    end)
end
local function disableOptimizer()
    if getgenv then getgenv().OPTIMIZER_ACTIVE = false end
    if xrayEnabled then
        for part, value in pairs(originalTransparency) do if part then part.LocalTransparencyModifier = value end end
        originalTransparency = {}; xrayEnabled = false
    end
end

local originalSkybox, galaxySkyBright, galaxySkyBrightConn, galaxyBloom, galaxyCC = nil, nil, nil, nil, nil
local galaxyPlanets = {}
local function enableGalaxySkyBright()
    for _, sky in ipairs(Lighting:GetChildren()) do if sky:IsA("Sky") then originalSkybox = sky; sky.Parent = nil; break end end
    galaxySkyBright = Instance.new("Sky")
    galaxySkyBright.SkyboxBk = "rbxassetid://1534951537"; galaxySkyBright.SkyboxDn = "rbxassetid://1534951537"
    galaxySkyBright.SkyboxFt = "rbxassetid://1534951537"; galaxySkyBright.SkyboxLf = "rbxassetid://1534951537"
    galaxySkyBright.SkyboxRt = "rbxassetid://1534951537"; galaxySkyBright.SkyboxUp = "rbxassetid://1534951537"
    galaxySkyBright.StarCount = 10000; galaxySkyBright.CelestialBodiesShown = false; galaxySkyBright.Parent = Lighting
    galaxyBloom = Instance.new("BloomEffect"); galaxyBloom.Intensity = 1.5; galaxyBloom.Size = 40; galaxyBloom.Threshold = 0.8; galaxyBloom.Parent = Lighting
    galaxyCC = Instance.new("ColorCorrectionEffect"); galaxyCC.Saturation = 0.8; galaxyCC.Contrast = 0.3; galaxyCC.TintColor = Color3.fromRGB(200,150,255); galaxyCC.Parent = Lighting
    Lighting.Ambient = Color3.fromRGB(120,60,180); Lighting.Brightness = 3; Lighting.ClockTime = 0
    galaxySkyBrightConn = RunService.Heartbeat:Connect(function()
        if not Enabled.GalaxySkyBright then return end
        local t = tick()*0.5; Lighting.Ambient = Color3.fromRGB(120+math.sin(t)*60, 50+math.sin(t*0.8)*40, 180+math.sin(t*1.2)*50)
        if galaxyBloom then galaxyBloom.Intensity = 1.2 + math.sin(t*2)*0.4 end
    end)
end
local function disableGalaxySkyBright()
    if galaxySkyBrightConn then galaxySkyBrightConn:Disconnect(); galaxySkyBrightConn = nil end
    if galaxySkyBright then galaxySkyBright:Destroy(); galaxySkyBright = nil end
    if originalSkybox then originalSkybox.Parent = Lighting end
    if galaxyBloom then galaxyBloom:Destroy(); galaxyBloom = nil end
    if galaxyCC then galaxyCC:Destroy(); galaxyCC = nil end
    for _, obj in ipairs(galaxyPlanets) do if obj then obj:Destroy() end end
    galaxyPlanets = {}; Lighting.Ambient = Color3.fromRGB(127,127,127); Lighting.Brightness = 2; Lighting.ClockTime = 14
end

-- ============================================================
-- BOOSTER FEATURES
-- ============================================================
local function removeFolders()
    local playerFolder = Workspace:FindFirstChild(Player.Name); if not playerFolder then return end
    local doubleRig = playerFolder:FindFirstChild("DoubleRig"); if doubleRig then doubleRig:Destroy() end
    local constraints = playerFolder:FindFirstChild("Constraints"); if constraints then constraints:Destroy() end
    local conn = playerFolder.ChildAdded:Connect(function(child)
        if child.Name == "DoubleRig" or child.Name == "Constraints" then child:Destroy() end
    end)
    table.insert(semiConnections.SemiInvisible, conn)
end

local function doClone()
    if Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health > 0 then
        hip = Player.Character.Humanoid.HipHeight
        oldRoot = Player.Character:FindFirstChild("HumanoidRootPart")
        if not oldRoot or not oldRoot.Parent then return false end
        local tempParent = Instance.new("Model"); tempParent.Parent = game
        Player.Character.Parent = tempParent
        semiClone = oldRoot:Clone(); semiClone.Parent = Player.Character
        oldRoot.Parent = Workspace.CurrentCamera; semiClone.CFrame = oldRoot.CFrame
        Player.Character.PrimaryPart = semiClone; Player.Character.Parent = Workspace
        for _, v in pairs(Player.Character:GetDescendants()) do
            if v:IsA("Weld") or v:IsA("Motor6D") then
                if v.Part0 == oldRoot then v.Part0 = semiClone end
                if v.Part1 == oldRoot then v.Part1 = semiClone end
            end
        end
        tempParent:Destroy(); return true
    end
    return false
end

local function revertClone()
    if not oldRoot or not oldRoot:IsDescendantOf(Workspace) or not Player.Character or Player.Character.Humanoid.Health <= 0 then return false end
    local tempParent = Instance.new("Model"); tempParent.Parent = game
    Player.Character.Parent = tempParent; oldRoot.Parent = Player.Character
    Player.Character.PrimaryPart = oldRoot; Player.Character.Parent = Workspace; oldRoot.CanCollide = true
    for _, v in pairs(Player.Character:GetDescendants()) do
        if v:IsA("Weld") or v:IsA("Motor6D") then
            if v.Part0 == semiClone then v.Part0 = oldRoot end
            if v.Part1 == semiClone then v.Part1 = oldRoot end
        end
    end
    if semiClone then local oldPos = semiClone.CFrame; semiClone:Destroy(); semiClone = nil; oldRoot.CFrame = oldPos end
    oldRoot = nil
    if Player.Character and Player.Character.Humanoid then Player.Character.Humanoid.HipHeight = hip end
end

local function animationTrickery()
    if Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health > 0 then
        local anim = Instance.new("Animation"); anim.AnimationId = "http://www.roblox.com/asset/?id=18537363391"
        local humanoid = Player.Character.Humanoid
        local animator = humanoid:FindFirstChild("Animator") or Instance.new("Animator", humanoid)
        animTrack = animator:LoadAnimation(anim); animTrack.Priority = Enum.AnimationPriority.Action4; animTrack:Play(0,1,0); anim:Destroy()
        local animStoppedConn = animTrack.Stopped:Connect(function() if isInvisible then animationTrickery() end end)
        table.insert(semiConnections.SemiInvisible, animStoppedConn)
        task.delay(0, function() animTrack.TimePosition = 0.7; task.delay(1, function() animTrack:AdjustSpeed(math.huge) end) end)
    end
end

local function enableInvisibility()
    if not Player.Character or Player.Character.Humanoid.Health <= 0 then return false end
    removeFolders(); local success = doClone()
    if success then
        task.wait(0.1); animationTrickery()
        semiConnection = RunService.PreSimulation:Connect(function(dt)
            if Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health > 0 and oldRoot then
                local root = Player.Character.PrimaryPart or Player.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    local cf = root.CFrame - Vector3.new(0, Player.Character.Humanoid.HipHeight + (root.Size.Y/2) - 1 + 0.09, 0)
                    oldRoot.CFrame = cf * CFrame.Angles(math.rad(180),0,0); oldRoot.Velocity = root.Velocity; oldRoot.CanCollide = false
                end
            end
        end)
        table.insert(semiConnections.SemiInvisible, semiConnection)
        characterConnection = Player.CharacterAdded:Connect(function()
            if isInvisible then
                if animTrack then animTrack:Stop(); animTrack:Destroy(); animTrack = nil end
                if semiConnection then semiConnection:Disconnect() end
                revertClone(); removeFolders(); isInvisible = false
                for _, conn in ipairs(semiConnections.SemiInvisible) do if conn then conn:Disconnect() end end
                semiConnections.SemiInvisible = {}
            end
        end)
        table.insert(semiConnections.SemiInvisible, characterConnection)
        return true
    end
    return false
end

local function disableInvisibility()
    if animTrack then animTrack:Stop(); animTrack:Destroy(); animTrack = nil end
    if semiConnection then semiConnection:Disconnect() end
    if characterConnection then characterConnection:Disconnect() end
    revertClone(); removeFolders()
end

local function setupGodmode()
    local char = Player.Character or Player.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    pcall(function()
        local mt = getrawmetatable(game); local oldNC = mt.__namecall; local oldNI = mt.__newindex
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local m = getnamecallmethod()
            if self == hum then
                if m == "ChangeState" and select(1,...) == Enum.HumanoidStateType.Dead then return end
                if m == "SetStateEnabled" then local st,en = ...; if st == Enum.HumanoidStateType.Dead and en == true then return end end
                if m == "Destroy" then return end
            end
            if self == char and m == "BreakJoints" then return end
            return oldNC(self, ...)
        end)
        mt.__newindex = newcclosure(function(self, k, v)
            if self == hum then
                if k == "Health" and type(v) == "number" and v <= 0 then return end
                if k == "MaxHealth" and type(v) == "number" and v < hum.MaxHealth then return end
                if k == "BreakJointsOnDeath" and v == true then return end
                if k == "Parent" and v == nil then return end
            end
            return oldNI(self, k, v)
        end)
        setreadonly(mt, true)
    end)
end

local function toggleSemiInvisible(state)
    Enabled.SemiInvisible = state; isInvisible = state
    if state then
        if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then warn("⚠️ Wait for character!"); return end
        removeFolders(); setupGodmode(); enableInvisibility()
    else
        disableInvisibility()
        for _, conn in ipairs(semiConnections.SemiInvisible) do if conn then conn:Disconnect() end end
        semiConnections.SemiInvisible = {}
    end
end

-- Highest Brainrot
local function parseGenValue(text)
    if not text or text == "" then return 0 end
    text = text:gsub(",",""):gsub("%s+","")
    local suffixes = {K=1e3,M=1e6,B=1e9,T=1e12}
    for suffix, mult in pairs(suffixes) do
        local num = text:match("^([%d%.]+)"..suffix.."$"); if num then return (tonumber(num) or 0) * mult end
    end
    return tonumber(text) or 0
end

local function findHighestBrainrotPrompt()
    local plots = Workspace:FindFirstChild("Plots"); if not plots then return nil, 0 end
    local bestPrompt, bestValue = nil, 0
    for _, plot in ipairs(plots:GetChildren()) do
        if plot.Name:lower():find(Player.Name:lower()) then continue end
        for _, obj in ipairs(plot:GetDescendants()) do
            if obj:IsA("BillboardGui") and obj.Name == "AnimalOverhead" then
                local genLabel = obj:FindFirstChild("Generation")
                if genLabel and genLabel:IsA("TextLabel") then
                    local value = parseGenValue(genLabel.Text)
                    if value > bestValue then
                        local base = obj.Parent
                        for _ = 1, 6 do
                            if not base then break end
                            local spawn = base:FindFirstChild("Spawn")
                            if spawn then
                                local att = spawn:FindFirstChild("PromptAttachment")
                                if att then
                                    for _, ch in ipairs(att:GetChildren()) do
                                        if ch:IsA("ProximityPrompt") then bestValue = value; bestPrompt = ch; break end
                                    end
                                end
                            end
                            base = base.Parent
                        end
                    end
                end
            end
        end
    end
    return bestPrompt, bestValue
end

local function findNearestBoosterPrompt()
    if Enabled.HighestBrainrot then
        if tick() - lastHighestCheck > HIGHEST_CHECK_INTERVAL then
            lastHighestCheck = tick()
            local prompt, value = findHighestBrainrotPrompt()
            currentHighestPrompt = prompt; currentHighestValue = value
        end
        return currentHighestPrompt, 0, "HighestBrainrot"
    end
    local h = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart"); if not h then return nil end
    local plots = Workspace:FindFirstChild("Plots"); if not plots then return nil end
    local np, nd, nn = nil, math.huge, nil
    for _, plot in ipairs(plots:GetChildren()) do
        if plot.Name:lower():find(Player.Name:lower()) then continue end
        local podiums = plot:FindFirstChild("AnimalPodiums"); if not podiums then continue end
        for _, pod in ipairs(podiums:GetChildren()) do
            pcall(function()
                local base = pod:FindFirstChild("Base"); local spawn = base and base:FindFirstChild("Spawn")
                if spawn then
                    local dist = (spawn.Position - h.Position).Magnitude
                    if dist < nd and dist <= Values.BOOST_STEAL_RADIUS then
                        local att = spawn:FindFirstChild("PromptAttachment")
                        if att then for _, ch in ipairs(att:GetChildren()) do if ch:IsA("ProximityPrompt") then np,nd,nn = ch,dist,pod.Name; break end end end
                    end
                end
            end)
        end
    end
    return np, nd, nn
end

local function executeBoosterSteal(prompt)
    if boosterIsStealing then return end
    if not boosterStealData[prompt] then
        boosterStealData[prompt] = {hold={},trigger={},ready=true}
        pcall(function()
            if getconnections then
                for _, c in ipairs(getconnections(prompt.PromptButtonHoldBegan)) do if c.Function then table.insert(boosterStealData[prompt].hold, c.Function) end end
                for _, c in ipairs(getconnections(prompt.Triggered)) do if c.Function then table.insert(boosterStealData[prompt].trigger, c.Function) end end
            end
        end)
    end
    local data = boosterStealData[prompt]; if not data.ready then return end
    data.ready = false; boosterIsStealing = true
    task.spawn(function()
        for _, f in ipairs(data.hold) do task.spawn(f) end
        task.wait(Values.BOOST_STEAL_DURATION)
        for _, f in ipairs(data.trigger) do task.spawn(f) end
        data.ready = true; boosterIsStealing = false
    end)
end

local function startBoosterAutoSteal()
    if Connections.boosterAutoSteal then return end
    Connections.boosterAutoSteal = RunService.Heartbeat:Connect(function()
        if not Enabled.AutoStealBooster or boosterIsStealing then return end
        local p = findNearestBoosterPrompt(); if p then executeBoosterSteal(p) end
    end)
end
local function stopBoosterAutoSteal()
    if Connections.boosterAutoSteal then Connections.boosterAutoSteal:Disconnect(); Connections.boosterAutoSteal = nil end
    boosterIsStealing = false; currentHighestPrompt = nil; currentHighestValue = nil
end

local function startBoosterSpeedWhileStealing()
    if Connections.boosterSpeedWhileStealing then return end
    Connections.boosterSpeedWhileStealing = RunService.Heartbeat:Connect(function()
        if not Enabled.SpeedWhileStealingBooster or not Player:GetAttribute("Stealing") then return end
        local c = Player.Character; if not c then return end
        local h = c:FindFirstChild("HumanoidRootPart"); if not h then return end
        local md = getMovementDirection()
        if md.Magnitude > 0.1 then h.AssemblyLinearVelocity = Vector3.new(md.X*Values.BoosterStealSpeed, h.AssemblyLinearVelocity.Y, md.Z*Values.BoosterStealSpeed) end
    end)
end
local function stopBoosterSpeedWhileStealing()
    if Connections.boosterSpeedWhileStealing then Connections.boosterSpeedWhileStealing:Disconnect(); Connections.boosterSpeedWhileStealing = nil end
end

local function toggleBoosterSpeedBoost(state)
    Enabled.SpeedBoostBooster = state
    if Connections.boosterSpeed then Connections.boosterSpeed:Disconnect(); Connections.boosterSpeed = nil end
    if Connections.boosterGiantPotion then Connections.boosterGiantPotion:Disconnect(); Connections.boosterGiantPotion = nil end
    if state then
        Connections.boosterSpeed = RunService.Heartbeat:Connect(function()
            local char = Player.Character; if char then local hum = char:FindFirstChildOfClass("Humanoid"); if hum then hum.WalkSpeed = Values.BOOST_SPEED end end
        end)
        Connections.boosterGiantPotion = RunService.RenderStepped:Connect(function()
            local char = Player.Character; local backpack = Player:FindFirstChild("Backpack"); if not char or not backpack then return end
            local tool = char:FindFirstChild("Giant Potion") or backpack:FindFirstChild("Giant Potion")
            if tool and tool:IsA("Tool") then tool.Parent = char; pcall(function() tool:Activate() end) end
        end)
    else
        local char = Player.Character; if char then local hum = char:FindFirstChildOfClass("Humanoid"); if hum then hum.WalkSpeed = 16 end end
    end
end

local TP_POSITIONS = {
    BASE1 = {STAND_HERE = Vector3.new(-334.84,-5.40,101.02)},
    BASE2 = {STAND_HERE = Vector3.new(-334.84,-5.40,19.20)},
}
local function carpetTeleportToBase(baseNum)
    local char = Player.Character; if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    local backpack = Player:FindFirstChild("Backpack")
    if backpack then
        local carpet = backpack:FindFirstChild("Flying Carpet")
        if carpet and char:FindFirstChild("Humanoid") then char.Humanoid:EquipTool(carpet); task.wait(0.1) end
    end
    if baseNum == 1 then hrp.CFrame = CFrame.new(TP_POSITIONS.BASE1.STAND_HERE)
    elseif baseNum == 2 then hrp.CFrame = CFrame.new(TP_POSITIONS.BASE2.STAND_HERE) end
end

-- Stand Here Orbs
local standHereOrbs = {}
local function createStandHereOrbs()
    local function createOrb(name, position, text)
        local part = Instance.new("Part"); part.Name = name; part.Size = Vector3.new(3.8,0.3,3.8)
        part.Material = Enum.Material.Neon; part.Color = C.purple; part.Transparency = 0.3
        part.Anchored = true; part.CanCollide = false; part.Position = position; part.Parent = Workspace
        local billboard = Instance.new("BillboardGui"); billboard.Size = UDim2.new(0,200,0,50)
        billboard.StudsOffset = Vector3.new(0,4,0); billboard.AlwaysOnTop = true; billboard.Parent = part
        local textLabel = Instance.new("TextLabel"); textLabel.Size = UDim2.new(1,0,1,0); textLabel.BackgroundTransparency = 1
        textLabel.Text = text; textLabel.TextColor3 = C.text; textLabel.TextStrokeTransparency = 0.3
        textLabel.TextStrokeColor3 = C.purple; textLabel.Font = Enum.Font.GothamBold; textLabel.TextSize = 18; textLabel.Parent = billboard
    end
    createOrb("VoidStandBase1", TP_POSITIONS.BASE1.STAND_HERE, "⬇ STAND HERE (BASE 1) ⬇")
    createOrb("VoidStandBase2", TP_POSITIONS.BASE2.STAND_HERE, "⬇ STAND HERE (BASE 2) ⬇")
end
createStandHereOrbs()

-- Semi TP functions
local function semiTpExecuteTP(sequence)
    local char = Player.Character; local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid"); local backpack = Player:FindFirstChild("Backpack")
    if root and hum and backpack then
        local carpet = backpack:FindFirstChild("Flying Carpet"); if carpet then hum:EquipTool(carpet); task.wait(0.1) end
        root.CFrame = sequence[1]; task.wait(0.1); root.CFrame = sequence[2]
    end
end

local function createSemiTPESP()
    local function makeESP(position, labelText)
        local box = Instance.new("Part"); box.Size = Vector3.new(5,0.5,5); box.Position = position
        box.Anchored = true; box.CanCollide = false; box.Transparency = 0.5; box.Material = Enum.Material.Neon
        box.Color = Color3.fromRGB(0,0,0); box.Parent = Workspace
        local selectionBox = Instance.new("SelectionBox"); selectionBox.Adornee = box; selectionBox.LineThickness = 0.05
        selectionBox.Color3 = C.purple; selectionBox.Parent = box
        local billboard = Instance.new("BillboardGui"); billboard.Adornee = box; billboard.Size = UDim2.new(0,150,0,40)
        billboard.StudsOffset = Vector3.new(0,2,0); billboard.AlwaysOnTop = true; billboard.Parent = box
        local textLabel = Instance.new("TextLabel"); textLabel.Size = UDim2.new(1,0,1,0); textLabel.BackgroundTransparency = 1
        textLabel.Text = labelText; textLabel.TextColor3 = C.text; textLabel.TextSize = 18
        textLabel.Font = Enum.Font.GothamBold; textLabel.TextStrokeTransparency = 0.5; textLabel.Parent = billboard
    end
    makeESP(pos1, "TP Here (Left)"); makeESP(pos2, "TP Here (Right)")
    makeESP(standing1, "Standing 1"); makeESP(standing2, "Standing 2")
    makeESP(autoSemiTpCFrameLeft.Position, "Auto TP Left"); makeESP(autoSemiTpCFrameRight.Position, "Auto TP Right")
end
createSemiTPESP()

-- Semi TP proximity prompt hooks
ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt, plr)
    if plr ~= Player or not Enabled.SemiTPEnabled then return end
    semiIsHolding = true
    if semiEquipTask then task.cancel(semiEquipTask) end
    semiEquipTask = task.spawn(function()
        task.wait(1)
        if semiIsHolding and Enabled.SemiTPEnabled then
            local backpack = Player:WaitForChild("Backpack", 2)
            if backpack then
                local carpet = backpack:FindFirstChild("Flying Carpet")
                if carpet and Player.Character and Player.Character:FindFirstChild("Humanoid") then
                    Player.Character.Humanoid:EquipTool(carpet)
                end
            end
        end
    end)
end)

ProximityPromptService.PromptButtonHoldEnded:Connect(function(prompt, plr)
    if plr ~= Player then return end
    semiIsHolding = false; if semiEquipTask then task.cancel(semiEquipTask) end
end)

ProximityPromptService.PromptTriggered:Connect(function(prompt, plr)
    if plr ~= Player or not Enabled.SemiTPEnabled then return end
    local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    if root then
        local backpack = Player:FindFirstChild("Backpack"); local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if backpack and hum then local carpet = backpack:FindFirstChild("Flying Carpet"); if carpet then hum:EquipTool(carpet); task.wait(0.1) end end
        local d1 = (root.Position - pos1).Magnitude; local d2 = (root.Position - pos2).Magnitude
        root.CFrame = CFrame.new(d1 < d2 and pos1 or pos2)
        if Enabled.AutoPotion then
            local backpack2 = Player:FindFirstChild("Backpack")
            if backpack2 then
                local potion = backpack2:FindFirstChild("Giant Potion")
                if potion and Player.Character and Player.Character:FindFirstChild("Humanoid") then
                    Player.Character.Humanoid:EquipTool(potion); task.wait(0.1); pcall(function() potion:Activate() end)
                end
            end
        end
        if Enabled.SpeedAfterSteal then
            local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                if semiSpeedConnection then semiSpeedConnection:Disconnect() end
                semiSpeedConnection = RunService.Heartbeat:Connect(function()
                    if not Enabled.SpeedAfterSteal or humanoid.MoveDirection.Magnitude == 0 or not root.Parent then return end
                    local moveDir = humanoid.MoveDirection.Unit
                    root.AssemblyLinearVelocity = Vector3.new(moveDir.X*Values.SEMI_SPEED_BOOST, root.AssemblyLinearVelocity.Y, moveDir.Z*Values.SEMI_SPEED_BOOST)
                end)
            end
        end
    end
    semiIsHolding = false
end)

-- ============================================================
-- AP SPAMMER LOGIC
-- ============================================================
local function spamAPCommands(targetName)
    local commands = {
        ";balloon "..targetName, ";rocket "..targetName, ";morph "..targetName,
        ";jumpscare "..targetName, ";jail "..targetName, ";ragdoll "..targetName,
        ";tiny "..targetName, ";inverse "..targetName,
    }
    local channel = TextChatService.TextChannels and TextChatService.TextChannels:FindFirstChild("RBXGeneral")
    if not channel then return end
    task.spawn(function()
        for _, cmd in ipairs(commands) do pcall(function() channel:SendAsync(cmd) end); task.wait(0.12) end
    end)
end

local function spamSelected()
    if #selectedPlayers == 0 then return end
    for _, plr in ipairs(selectedPlayers) do spamAPCommands(plr.Name) end
end

local function checkForStealingNotification()
    local success, result = pcall(function()
        local notifGui = Player.PlayerGui:FindFirstChild("Notification"); if not notifGui then return false end
        local notifFrame = notifGui:FindFirstChild("Notification"); if not notifFrame then return false end
        local children = notifFrame:GetChildren(); if #children < 4 then return false end
        local textLabel = children[4]; if not textLabel:IsA("TextLabel") then return false end
        return textLabel.Text:find("Someone is stealing your") ~= nil
    end)
    return success and result
end

task.spawn(function()
    while task.wait(0.1) do
        if Enabled.AutoDefenseEnabled and tick() - lastDefenseCheck >= 0.1 then
            lastDefenseCheck = tick()
            if checkForStealingNotification() then
                local now = tick()
                if now - lastDefenseTime >= defenseCooldown then
                    lastDefenseTime = now
                    local myChar = Player.Character
                    if myChar then
                        local myHead = myChar:FindFirstChild("Head")
                        if myHead then
                            local closestPlayer, closestDist2 = nil, math.huge
                            for _, plr in ipairs(Players:GetPlayers()) do
                                if plr ~= Player then
                                    local head = plr.Character and plr.Character:FindFirstChild("Head")
                                    if head then
                                        local dist = (head.Position - myHead.Position).Magnitude
                                        if dist < closestDist2 then closestDist2 = dist; closestPlayer = plr end
                                    end
                                end
                            end
                            if closestPlayer then spamAPCommands(closestPlayer.Name) end
                        end
                    end
                end
            end
        end
    end
end)

-- ============================================================
-- AUTO DUEL LOGIC
-- ============================================================
local duelStatusText = "Ready"
local duelSpeedText  = "--"

local function duelStopMoving()
    if duelConnection then duelConnection:Disconnect(); duelConnection = nil end
    duelMoving = false; duelWaitingGrab = false; duelGrabDetected = false
end

local function duelMoveToWaypoint()
    if duelConnection then duelConnection:Disconnect() end
    duelConnection = RunService.Stepped:Connect(function()
        if not duelMoving or duelWaitingGrab then return end
        local char = Player.Character; local root = char and char:FindFirstChild("HumanoidRootPart"); if not root then return end
        local wp = duelWaypoints[duelCurrentWP]
        local dist = (root.Position - wp.position).Magnitude
        if dist < 5 then
            if (duelCurrentWP == 4 or duelCurrentWP == 6) and not duelGrabDetected then
                duelWaitingGrab = true; duelStatusText = "Grab the pet please..."
                root.Velocity = Vector3.zero; return
            end
            if duelCurrentWP == #duelWaypoints then
                duelStatusText = "FINISHED!"; duelStopMoving(); return
            end
            duelCurrentWP += 1; duelStatusText = "Void bot at: "..duelCurrentWP
        else
            local dir = (wp.position - root.Position).Unit
            root.Velocity = Vector3.new(dir.X * wp.speed, root.Velocity.Y, dir.Z * wp.speed)
        end
    end)
end

duelSpeedConn = RunService.Heartbeat:Connect(function()
    local char = Player.Character; local hum = char and char:FindFirstChild("Humanoid")
    if hum then
        duelSpeedText = tostring(math.floor(hum.WalkSpeed))
        if hum.WalkSpeed < 23 then
            if duelWaitingGrab and not duelGrabDetected then
                task.wait(0.3); duelWaitingGrab = false; duelGrabDetected = true
                duelStatusText = "Void bot at: "..duelCurrentWP
            end
        end
    end
end)

local function startAutoDuel()
    local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart"); if not root then return end
    duelMoving = true; duelGrabDetected = false
    if (root.Position - Vector3.new(-475,-7,96)).Magnitude > (root.Position - Vector3.new(-474,-7,23)).Magnitude then
        duelWaypoints = {
            {position=Vector3.new(-475,-7,96), speed=59},{position=Vector3.new(-483,-5,95), speed=59},
            {position=Vector3.new(-487,-5,95), speed=55},{position=Vector3.new(-492,-5,95), speed=55},
            {position=Vector3.new(-473,-7,95), speed=29},{position=Vector3.new(-473,-7,11), speed=29},
        }
    else
        duelWaypoints = {
            {position=Vector3.new(-474,-7,23), speed=55},{position=Vector3.new(-484,-5,24), speed=55},
            {position=Vector3.new(-488,-5,24), speed=55},{position=Vector3.new(-493,-5,25), speed=55},
            {position=Vector3.new(-473,-7,25), speed=29},{position=Vector3.new(-474,-7,112), speed=29},
        }
    end
    duelCurrentWP = 1; duelMoveToWaypoint()
end

-- ============================================================
-- SOUND
-- ============================================================
local function playSound(id, vol, spd)
    pcall(function()
        local s = Instance.new("Sound", SoundService); s.SoundId = id; s.Volume = vol or 0.3; s.PlaybackSpeed = spd or 1
        s:Play(); game:GetService("Debris"):AddItem(s, 1)
    end)
end

-- ============================================================
-- MAIN GUI SETUP
-- ============================================================
if playerGui:FindFirstChild("VoidHub") then playerGui.VoidHub:Destroy() end
local sg = Instance.new("ScreenGui")
sg.Name = "VoidHub"; sg.ResetOnSpawn = false; sg.Parent = playerGui

local function makeRotatingGradient(stroke, r, g, b, speed)
    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(r,g,b)),
        ColorSequenceKeypoint.new(0.25,Color3.fromRGB(math.min(r+60,255),math.min(g+60,255),math.min(b+5,255))),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(r,g,b)),
        ColorSequenceKeypoint.new(0.75,Color3.fromRGB(math.max(r-50,0),math.max(g-65,0),b)),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(r,g,b)),
    }
    grad.Parent = stroke
    task.spawn(function()
        local rot = 0
        while stroke and stroke.Parent do rot = (rot+speed)%360; grad.Rotation = rot; task.wait(0.02) end
    end)
    return grad
end

-- Progress Bar
local progressBar = Instance.new("Frame", sg)
progressBar.Size = UDim2.new(0,420*guiScale,0,56*guiScale)
progressBar.Position = UDim2.new(0.5,-210*guiScale,1,-168*guiScale)
progressBar.BackgroundColor3 = C.bg; progressBar.BorderSizePixel = 0; progressBar.ClipsDescendants = true
Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0,14*guiScale)
local pStroke = Instance.new("UIStroke", progressBar); pStroke.Thickness = 2
makeRotatingGradient(pStroke, 167, 139, 250, 3)
ProgressLabel = Instance.new("TextLabel", progressBar)
ProgressLabel.Size = UDim2.new(0.35,0,0.5,0); ProgressLabel.Position = UDim2.new(0,10*guiScale,0,0)
ProgressLabel.BackgroundTransparency = 1; ProgressLabel.Text = "READY"
ProgressLabel.TextColor3 = C.text; ProgressLabel.Font = Enum.Font.GothamBold; ProgressLabel.TextSize = 14*guiScale
ProgressLabel.TextXAlignment = Enum.TextXAlignment.Left; ProgressLabel.ZIndex = 3
ProgressPercentLabel = Instance.new("TextLabel", progressBar)
ProgressPercentLabel.Size = UDim2.new(1,0,0.5,0); ProgressPercentLabel.Position = UDim2.new(0,0,0.5,0)
ProgressPercentLabel.BackgroundTransparency = 1; ProgressPercentLabel.Text = ""
ProgressPercentLabel.TextColor3 = C.purpleLight; ProgressPercentLabel.Font = Enum.Font.GothamBlack
ProgressPercentLabel.TextSize = 18*guiScale; ProgressPercentLabel.TextXAlignment = Enum.TextXAlignment.Center; ProgressPercentLabel.ZIndex = 3
local pTrack = Instance.new("Frame", progressBar)
pTrack.Size = UDim2.new(0.94,0,0,8*guiScale); pTrack.Position = UDim2.new(0.03,0,1,-15*guiScale)
pTrack.BackgroundColor3 = C.panel; pTrack.ZIndex = 2; Instance.new("UICorner", pTrack).CornerRadius = UDim.new(1,0)
ProgressBarFill = Instance.new("Frame", pTrack)
ProgressBarFill.Size = UDim2.new(0,0,1,0); ProgressBarFill.BackgroundColor3 = C.purple; ProgressBarFill.ZIndex = 2
Instance.new("UICorner", ProgressBarFill).CornerRadius = UDim.new(1,0)

-- Main Window
local WINDOW_W = 960 * guiScale
local WINDOW_H = 760 * guiScale
local TAB_H    = 44  * guiScale
local main = Instance.new("Frame", sg)
main.Name = "Main"; main.Size = UDim2.new(0,WINDOW_W,0,WINDOW_H)
main.Position = isMobile and UDim2.new(0.5,-WINDOW_W/2,0.5,-WINDOW_H/2) or UDim2.new(1,-WINDOW_W-10,0,10)
main.BackgroundColor3 = C.bg; main.BorderSizePixel = 0; main.Active = true; main.Draggable = true; main.ClipsDescendants = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,16*guiScale)
local mainStroke = Instance.new("UIStroke", main); mainStroke.Thickness = 2
makeRotatingGradient(mainStroke, 139, 92, 246, 3)

-- Floating particles
for i = 1, 50 do
    local ball = Instance.new("Frame", main)
    ball.Size = UDim2.new(0,math.random(2,4),0,math.random(2,4))
    ball.Position = UDim2.new(math.random(2,98)/100,0,math.random(2,98)/100,0)
    ball.BackgroundColor3 = C.purpleLight; ball.BackgroundTransparency = math.random(20,50)/100; ball.BorderSizePixel = 0; ball.ZIndex = 1
    Instance.new("UICorner", ball).CornerRadius = UDim.new(1,0)
    task.spawn(function()
        local sx = ball.Position.X.Scale; local sy = ball.Position.Y.Scale; local phase = math.random()*math.pi*2; local spd = 0.3+math.random()*0.4
        while ball.Parent do
            local t = tick()+phase
            ball.Position = UDim2.new(math.clamp(sx+math.sin(t*spd)*0.02,0.01,0.99),0,math.clamp(sy+math.cos(t*spd*0.8)*0.015,0.01,0.99),0)
            ball.BackgroundTransparency = 0.2+math.sin(t*1.5+phase)*0.25; task.wait(0.03)
        end
    end)
end

-- Header
local headerH = 58 * guiScale
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,headerH); header.BackgroundColor3 = C.panel; header.BorderSizePixel = 0; header.ZIndex = 4
Instance.new("UICorner", header).CornerRadius = UDim.new(0,12*guiScale)

local titleLabel = Instance.new("TextLabel", header)
titleLabel.Size = UDim2.new(0.6,0,0,34*guiScale); titleLabel.Position = UDim2.new(0.02,0,0.5,-17*guiScale)
titleLabel.BackgroundTransparency = 1; titleLabel.Text = "✦ VOID HUB ✦"
titleLabel.Font = Enum.Font.GothamBlack; titleLabel.TextSize = 22*guiScale; titleLabel.TextColor3 = C.text
titleLabel.TextXAlignment = Enum.TextXAlignment.Left; titleLabel.ZIndex = 5
local titleGrad = Instance.new("UIGradient")
titleGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, C.purpleLight), ColorSequenceKeypoint.new(0.5, C.purple), ColorSequenceKeypoint.new(1, Color3.fromRGB(217,70,239)),
}
titleGrad.Parent = titleLabel

-- Discord button in header
local discordHeaderBtn = Instance.new("TextButton", header)
discordHeaderBtn.Size = UDim2.new(0,90*guiScale,0,28*guiScale)
discordHeaderBtn.Position = UDim2.new(1,-200*guiScale,0.5,-14*guiScale)
discordHeaderBtn.BackgroundColor3 = Color3.fromRGB(88,101,242); discordHeaderBtn.Text = "📋 Discord"
discordHeaderBtn.Font = Enum.Font.GothamBold; discordHeaderBtn.TextSize = 11*guiScale; discordHeaderBtn.TextColor3 = C.text
discordHeaderBtn.BorderSizePixel = 0; discordHeaderBtn.ZIndex = 6
Instance.new("UICorner", discordHeaderBtn).CornerRadius = UDim.new(0,8*guiScale)
discordHeaderBtn.MouseButton1Click:Connect(function()
    pcall(function() setclipboard(DISCORD_LINK) end)
    discordHeaderBtn.Text = "✅ Copied!"; discordHeaderBtn.BackgroundColor3 = C.success
    task.delay(2, function() discordHeaderBtn.Text = "📋 Discord"; discordHeaderBtn.BackgroundColor3 = Color3.fromRGB(88,101,242) end)
end)

local function makeHeaderBtn(xOffset, text, bg, hover)
    local btn = Instance.new("TextButton", header)
    btn.Size = UDim2.new(0,30*guiScale,0,30*guiScale)
    btn.Position = UDim2.new(1,xOffset,0.5,-15*guiScale)
    btn.BackgroundColor3 = bg; btn.Text = text; btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16*guiScale; btn.TextColor3 = C.text; btn.BorderSizePixel = 0; btn.ZIndex = 6
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8*guiScale)
    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = hover end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = bg end)
    return btn
end

local closeBtn2 = makeHeaderBtn(-10*guiScale, "×", Color3.fromRGB(60,20,30), C.danger)
closeBtn2.MouseButton1Click:Connect(function()
    TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0,0,0,0), Position = UDim2.new(0.5,0,0.5,0)}):Play()
    task.delay(0.35, function() sg:Destroy() end)
end)

local isMinimized = false
local minBtn = makeHeaderBtn(-10*guiScale-38*guiScale, "–", Color3.fromRGB(40,40,60), C.purpleDark)
minBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = isMinimized and UDim2.new(0,WINDOW_W,0,headerH) or UDim2.new(0,WINDOW_W,0,WINDOW_H)
    }):Play()
    minBtn.Text = isMinimized and "□" or "–"
end)

-- Tab Bar
local TABS = {"⚔ Combat","🏃 Movement","🎯 Stealing","✨ Visuals","👻 Booster","🔀 Semi TP","⚡ Auto Duel","📣 AP Spam"}
local tabBar = Instance.new("Frame", main)
tabBar.Size = UDim2.new(1,-8*guiScale,0,TAB_H); tabBar.Position = UDim2.new(0,4*guiScale,0,headerH+4*guiScale)
tabBar.BackgroundColor3 = C.panel; tabBar.BorderSizePixel = 0; tabBar.ZIndex = 4
Instance.new("UICorner", tabBar).CornerRadius = UDim.new(0,8*guiScale)
Instance.new("UIStroke", tabBar).Color = C.border
local tabLayout = Instance.new("UIListLayout", tabBar)
tabLayout.FillDirection = Enum.FillDirection.Horizontal; tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center; tabLayout.Padding = UDim.new(0,2*guiScale)

local contentArea = Instance.new("Frame", main)
contentArea.Size = UDim2.new(1,-8*guiScale,1,-(headerH+TAB_H+12*guiScale))
contentArea.Position = UDim2.new(0,4*guiScale,0,headerH+TAB_H+8*guiScale)
contentArea.BackgroundTransparency = 1; contentArea.ZIndex = 3

local tabPages = {}; local tabButtons = {}; local currentTab = nil

local function switchTab(name)
    for _, p in pairs(tabPages) do p.Visible = false end
    for n, b in pairs(tabButtons) do
        if n == name then TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = C.purple}):Play(); b.TextColor3 = C.text
        else TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = C.tabInactive}):Play(); b.TextColor3 = C.textDim end
    end
    if tabPages[name] then tabPages[name].Visible = true end
    currentTab = name
end

for _, tabName in ipairs(TABS) do
    local btn = Instance.new("TextButton", tabBar)
    btn.Size = UDim2.new(1/#TABS,-4*guiScale,0.85,0)
    btn.BackgroundColor3 = C.tabInactive; btn.BorderSizePixel = 0
    btn.Text = tabName; btn.Font = Enum.Font.GothamBold; btn.TextSize = 10*guiScale; btn.TextColor3 = C.textDim; btn.ZIndex = 5
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6*guiScale)
    local page = Instance.new("ScrollingFrame", contentArea)
    page.Size = UDim2.new(1,0,1,0); page.BackgroundTransparency = 1; page.BorderSizePixel = 0
    page.ScrollBarThickness = 3; page.ScrollBarImageColor3 = C.purple
    page.CanvasSize = UDim2.new(0,0,0,0); page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.ZIndex = 3; page.Visible = false
    local pageLayout = Instance.new("UIListLayout", page)
    pageLayout.Padding = UDim.new(0,6*guiScale); pageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center; pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    local pagePad = Instance.new("UIPadding", page); pagePad.PaddingTop = UDim.new(0,6*guiScale)
    tabPages[tabName] = page; tabButtons[tabName] = btn
    btn.MouseButton1Click:Connect(function() playSound("rbxassetid://6895079813",0.3,1.2); switchTab(tabName) end)
end

-- ============================================================
-- WIDGET FACTORY
-- ============================================================
VisualSetters = {}
local SliderSetters = {}
local KeyButtons    = {}
local waitingForKeybind = nil

local function createSectionHeader(parent, text, order)
    local lbl = Instance.new("TextLabel", parent)
    lbl.Size = UDim2.new(0.95,0,0,24*guiScale); lbl.BackgroundColor3 = Color3.fromRGB(30,18,50)
    lbl.BorderSizePixel = 0; lbl.Text = text; lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 11*guiScale
    lbl.TextColor3 = Color3.fromRGB(210,180,255); lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 4; lbl.LayoutOrder = order or 0
    local pad = Instance.new("UIPadding", lbl); pad.PaddingLeft = UDim.new(0,8*guiScale)
    Instance.new("UICorner", lbl).CornerRadius = UDim.new(0,5*guiScale)
    return lbl
end

local function createToggle(parent, labelText, enabledKey, callback, specialColor, order)
    local onColor = specialColor or C.purple
    local defaultOn = Enabled[enabledKey]
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(0.95,0,0,44*guiScale); row.BackgroundColor3 = C.panel; row.BorderSizePixel = 0; row.ZIndex = 4; row.LayoutOrder = order or 0
    Instance.new("UICorner", row).CornerRadius = UDim.new(0,8*guiScale)
    local label = Instance.new("TextLabel", row)
    label.Size = UDim2.new(1,-72*guiScale,1,0); label.Position = UDim2.new(0,12*guiScale,0,0)
    label.BackgroundTransparency = 1; label.Text = labelText; label.TextColor3 = C.text
    label.Font = Enum.Font.GothamSemibold; label.TextSize = 13*guiScale; label.TextXAlignment = Enum.TextXAlignment.Left; label.ZIndex = 5
    local toggleBg = Instance.new("Frame", row)
    toggleBg.Size = UDim2.new(0,48*guiScale,0,26*guiScale); toggleBg.Position = UDim2.new(1,-56*guiScale,0.5,-13*guiScale)
    toggleBg.BackgroundColor3 = defaultOn and onColor or Color3.fromRGB(25,20,35); toggleBg.ZIndex = 5
    Instance.new("UICorner", toggleBg).CornerRadius = UDim.new(1,0)
    local toggleCircle = Instance.new("Frame", toggleBg)
    toggleCircle.Size = UDim2.new(0,20*guiScale,0,20*guiScale)
    toggleCircle.Position = defaultOn and UDim2.new(1,-23*guiScale,0.5,-10*guiScale) or UDim2.new(0,3*guiScale,0.5,-10*guiScale)
    toggleCircle.BackgroundColor3 = Color3.new(1,1,1); toggleCircle.ZIndex = 6
    Instance.new("UICorner", toggleCircle).CornerRadius = UDim.new(1,0)
    local clickBtn = Instance.new("TextButton", row)
    clickBtn.Size = UDim2.new(1,0,1,0); clickBtn.BackgroundTransparency = 1; clickBtn.Text = ""; clickBtn.ZIndex = 7
    local isOn = defaultOn
    local function setVisual(state, skipCallback)
        isOn = state
        TweenService:Create(toggleBg, TweenInfo.new(0.25), {BackgroundColor3 = isOn and onColor or Color3.fromRGB(25,20,35)}):Play()
        TweenService:Create(toggleCircle, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
            Position = isOn and UDim2.new(1,-23*guiScale,0.5,-10*guiScale) or UDim2.new(0,3*guiScale,0.5,-10*guiScale)
        }):Play()
        if not skipCallback and callback then callback(isOn) end
    end
    if enabledKey then VisualSetters[enabledKey] = setVisual end
    clickBtn.MouseButton1Click:Connect(function()
        isOn = not isOn; if enabledKey then Enabled[enabledKey] = isOn end
        setVisual(isOn); playSound("rbxassetid://6895079813",0.4,1)
    end)
    return row, setVisual
end

local function createButton(parent, text, color, callback, order)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.95,0,0,42*guiScale); btn.BackgroundColor3 = color or C.purple
    btn.Text = text; btn.Font = Enum.Font.GothamBold; btn.TextSize = 13*guiScale
    btn.TextColor3 = C.text; btn.BorderSizePixel = 0; btn.ZIndex = 4; btn.LayoutOrder = order or 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8*guiScale)
    if callback then btn.MouseButton1Click:Connect(callback) end
    return btn
end

local function createButtonPair(parent, text1, text2, cb1, cb2, order)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(0.95,0,0,42*guiScale); row.BackgroundTransparency = 1; row.ZIndex = 4; row.LayoutOrder = order or 0
    local layout = Instance.new("UIListLayout", row)
    layout.FillDirection = Enum.FillDirection.Horizontal; layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Padding = UDim.new(0,6*guiScale)
    local function mkBtn(t, cb)
        local btn = Instance.new("TextButton", row)
        btn.Size = UDim2.new(0.47,0,1,0); btn.BackgroundColor3 = C.purpleDark; btn.Text = t
        btn.Font = Enum.Font.GothamBold; btn.TextSize = 11*guiScale; btn.TextColor3 = C.text; btn.BorderSizePixel = 0; btn.ZIndex = 4
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8*guiScale)
        btn.MouseButton1Click:Connect(cb); return btn
    end
    mkBtn(text1, cb1); mkBtn(text2, cb2); return row
end

local function createSlider(parent, labelText, key, minVal, maxVal, order)
    local val = Values[key] or minVal
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(0.95,0,0,58*guiScale); row.BackgroundColor3 = C.panel; row.BorderSizePixel = 0; row.ZIndex = 4; row.LayoutOrder = order or 0
    Instance.new("UICorner", row).CornerRadius = UDim.new(0,8*guiScale)
    local label = Instance.new("TextLabel", row)
    label.Size = UDim2.new(0.75,0,0,22*guiScale); label.Position = UDim2.new(0,10*guiScale,0,4*guiScale)
    label.BackgroundTransparency = 1; label.Text = labelText; label.Font = Enum.Font.GothamSemibold; label.TextSize = 12*guiScale
    label.TextColor3 = C.text; label.TextXAlignment = Enum.TextXAlignment.Left; label.ZIndex = 5
    local valLabel = Instance.new("TextLabel", row)
    valLabel.Size = UDim2.new(0.22,0,0,22*guiScale); valLabel.Position = UDim2.new(0.78,0,0,4*guiScale)
    valLabel.BackgroundTransparency = 1; valLabel.Text = tostring(math.floor(val)); valLabel.Font = Enum.Font.GothamBold
    valLabel.TextSize = 12*guiScale; valLabel.TextColor3 = C.purple; valLabel.TextXAlignment = Enum.TextXAlignment.Right; valLabel.ZIndex = 5
    local track = Instance.new("Frame", row)
    track.Size = UDim2.new(0.9,0,0,8*guiScale); track.Position = UDim2.new(0.05,0,0,36*guiScale)
    track.BackgroundColor3 = Color3.fromRGB(25,20,35); track.ZIndex = 5
    Instance.new("UICorner", track).CornerRadius = UDim.new(1,0)
    local fill = Instance.new("Frame", track)
    fill.Size = UDim2.new((val-minVal)/(maxVal-minVal),0,1,0); fill.BackgroundColor3 = C.purple; fill.ZIndex = 5
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)
    local knob = Instance.new("Frame", track)
    knob.Size = UDim2.new(0,14*guiScale,0,14*guiScale)
    knob.Position = UDim2.new((val-minVal)/(maxVal-minVal),0,0.5,-7*guiScale)
    knob.BackgroundColor3 = Color3.new(1,1,1); knob.ZIndex = 6
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)
    local dragging2 = false
    local function updateSlider(absPos)
        local trackPos = track.AbsolutePosition.X; local trackW = track.AbsoluteSize.X
        local pct = math.clamp((absPos - trackPos) / trackW, 0, 1)
        local newVal = math.floor(minVal + pct*(maxVal-minVal))
        Values[key] = newVal; valLabel.Text = tostring(newVal)
        fill.Size = UDim2.new(pct,0,1,0); knob.Position = UDim2.new(pct,0,0.5,-7*guiScale)
    end
    knob.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging2 = true end end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging2 and input.UserInputType == Enum.UserInputType.MouseMovement then updateSlider(input.Position.X) end
    end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging2 = false end end)
    SliderSetters[key] = function(v) local pct = math.clamp((v-minVal)/(maxVal-minVal),0,1); fill.Size = UDim2.new(pct,0,1,0); knob.Position = UDim2.new(pct,0,0.5,-7*guiScale); valLabel.Text = tostring(math.floor(v)) end
    return row
end

local function createToggleWithKey(parent, labelText, keybindKey, enabledKey, callback, specialColor, order)
    local onColor = specialColor or C.purple
    local defaultOn = Enabled[enabledKey]
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(0.95,0,0,44*guiScale); row.BackgroundColor3 = C.panel; row.BorderSizePixel = 0; row.ZIndex = 4; row.LayoutOrder = order or 0
    Instance.new("UICorner", row).CornerRadius = UDim.new(0,8*guiScale)
    local label = Instance.new("TextLabel", row)
    label.Size = UDim2.new(1,-116*guiScale,1,0); label.Position = UDim2.new(0,12*guiScale,0,0)
    label.BackgroundTransparency = 1; label.Text = labelText; label.TextColor3 = C.text
    label.Font = Enum.Font.GothamSemibold; label.TextSize = 13*guiScale; label.TextXAlignment = Enum.TextXAlignment.Left; label.ZIndex = 5
    local keyBtn2 = Instance.new("TextButton", row)
    keyBtn2.Size = UDim2.new(0,50*guiScale,0,26*guiScale); keyBtn2.Position = UDim2.new(1,-108*guiScale,0.5,-13*guiScale)
    keyBtn2.BackgroundColor3 = C.purpleDark; keyBtn2.Font = Enum.Font.GothamBold; keyBtn2.TextSize = 10*guiScale; keyBtn2.TextColor3 = C.textDim
    keyBtn2.Text = KEYBINDS[keybindKey] and KEYBINDS[keybindKey].Name or "?"; keyBtn2.ZIndex = 6; keyBtn2.BorderSizePixel = 0
    Instance.new("UICorner", keyBtn2).CornerRadius = UDim.new(0,5*guiScale)
    KeyButtons[keybindKey] = keyBtn2
    keyBtn2.MouseButton1Click:Connect(function()
        waitingForKeybind = keybindKey; keyBtn2.Text = "..."
    end)
    local toggleBg = Instance.new("Frame", row)
    toggleBg.Size = UDim2.new(0,48*guiScale,0,26*guiScale); toggleBg.Position = UDim2.new(1,-56*guiScale,0.5,-13*guiScale)
    toggleBg.BackgroundColor3 = defaultOn and onColor or Color3.fromRGB(25,20,35); toggleBg.ZIndex = 5
    Instance.new("UICorner", toggleBg).CornerRadius = UDim.new(1,0)
    local toggleCircle = Instance.new("Frame", toggleBg)
    toggleCircle.Size = UDim2.new(0,20*guiScale,0,20*guiScale)
    toggleCircle.Position = defaultOn and UDim2.new(1,-23*guiScale,0.5,-10*guiScale) or UDim2.new(0,3*guiScale,0.5,-10*guiScale)
    toggleCircle.BackgroundColor3 = Color3.new(1,1,1); toggleCircle.ZIndex = 6
    Instance.new("UICorner", toggleCircle).CornerRadius = UDim.new(1,0)
    local clickBtn = Instance.new("TextButton", row)
    clickBtn.Size = UDim2.new(1,-116*guiScale,1,0); clickBtn.BackgroundTransparency = 1; clickBtn.Text = ""; clickBtn.ZIndex = 7
    local isOn = defaultOn
    local function setVisual(state, skipCallback)
        isOn = state
        TweenService:Create(toggleBg, TweenInfo.new(0.25), {BackgroundColor3 = isOn and onColor or Color3.fromRGB(25,20,35)}):Play()
        TweenService:Create(toggleCircle, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
            Position = isOn and UDim2.new(1,-23*guiScale,0.5,-10*guiScale) or UDim2.new(0,3*guiScale,0.5,-10*guiScale)
        }):Play()
        if not skipCallback and callback then callback(isOn) end
    end
    if enabledKey then VisualSetters[enabledKey] = setVisual end
    clickBtn.MouseButton1Click:Connect(function()
        isOn = not isOn; if enabledKey then Enabled[enabledKey] = isOn end
        setVisual(isOn); playSound("rbxassetid://6895079813",0.4,1)
    end)
    return row, setVisual
end

-- ============================================================
-- TAB 1: ⚔ Combat
-- ============================================================
local combatPage = tabPages["⚔ Combat"]
createSectionHeader(combatPage, "⚔ Attack", 1)
createToggle(combatPage, "Spam Bat / Slap", "SpamBat", function(s)
    Enabled.SpamBat = s; if s then startSpamBat() else stopSpamBat() end
end, Color3.fromRGB(239,68,68), 2)
createToggleWithKey(combatPage, "Bat Aimbot", "BATAIMBOT", "BatAimbot", function(s)
    Enabled.BatAimbot = s; if s then startBatAimbot() else stopBatAimbot() end
end, Color3.fromRGB(251,146,60), 3)
createToggle(combatPage, "Anti Ragdoll", "AntiRagdoll", function(s)
    Enabled.AntiRagdoll = s; if s then startAntiRagdoll() else stopAntiRagdoll() end
end, Color3.fromRGB(34,197,94), 4)
createToggle(combatPage, "Medusa Auto-Activate In Range", "MedusaInRange", function(s)
    Enabled.MedusaInRange = s; if s then startMedusaInRange() else stopMedusaInRange() end
end, Color3.fromRGB(180,80,255), 5)
createSlider(combatPage, "Medusa Range (studs)", "MedusaRange", 5, 50, 6)
createSectionHeader(combatPage, "☢ Nuke", 7)
createButton(combatPage, "☢ INSTANT NUKE NEAREST [Q]", C.danger, function()
    local n = getNearestPlayer(); if n then INSTANT_NUKE(n) end
end, 8)
createSectionHeader(combatPage, "👁 Follower", 9)
createToggle(combatPage, "Player Follower (Auto Follow Nearest)", "PlayerFollower", function(s)
    Enabled.PlayerFollower = s; if s then startPlayerFollower() else stopPlayerFollower() end
end, Color3.fromRGB(139,92,246), 10)
createSlider(combatPage, "Follower Speed", "PlayerFollowerSpeed", 10, 200, 11)

-- ============================================================
-- TAB 2: 🏃 Movement
-- ============================================================
local movePage = tabPages["🏃 Movement"]
createSectionHeader(movePage, "🚀 Speed", 1)
createToggleWithKey(movePage, "Speed Boost", "SPEED", "SpeedBoost", function(s)
    Enabled.SpeedBoost = s; if s then startSpeedBoost() else stopSpeedBoost() end
end, Color3.fromRGB(34,197,94), 2)
createSlider(movePage, "Boost Speed", "BoostSpeed", 10, 200, 3)
createToggleWithKey(movePage, "SpinBot", "SPIN", "SpinBot", function(s)
    Enabled.SpinBot = s; if s then startSpinBot() else stopSpinBot() end
end, Color3.fromRGB(251,146,60), 4)
createSlider(movePage, "Spin Speed", "SpinSpeed", 5, 100, 5)
createToggleWithKey(movePage, "Galaxy Mode (Low Gravity + Hop)", "GALAXY", "Galaxy", function(s)
    Enabled.Galaxy = s; if s then startGalaxy() else stopGalaxy() end
end, Color3.fromRGB(139,92,246), 6)
createToggle(movePage, "Unwalk (WalkSpeed = 0)", "Unwalk", function(s)
    Enabled.Unwalk = s; if s then startUnwalk() else stopUnwalk() end
end, Color3.fromRGB(239,68,68), 7)
createSectionHeader(movePage, "🏃 Auto Walk (Duel Positions)", 8)
createToggleWithKey(movePage, "Auto Walk Left [Z]", "AUTOLEFT", "AutoWalkEnabled", function(s)
    AutoWalkEnabled = s; Enabled.AutoWalkEnabled = s; if s then startAutoWalk() else stopAutoWalk() end
end, C.purple, 9)
createToggleWithKey(movePage, "Auto Walk Right [C]", "AUTORIGHT", "AutoRightEnabled", function(s)
    AutoRightEnabled = s; Enabled.AutoRightEnabled = s; if s then startAutoRight() else stopAutoRight() end
end, Color3.fromRGB(217,70,239), 10)
createSlider(movePage, "Walk Boost Speed", "BoostSpeed", 10, 200, 11)

-- ============================================================
-- TAB 3: 🎯 Stealing
-- ============================================================
local stealPage = tabPages["🎯 Stealing"]
createSectionHeader(stealPage, "🎯 Auto Steal", 1)
createToggle(stealPage, "Auto Steal (Duels Mode)", "AutoSteal", function(s)
    Enabled.AutoSteal = s; if s then startAutoSteal() else stopAutoSteal() end
end, Color3.fromRGB(251,146,60), 2)
createToggle(stealPage, "Speed While Stealing", "SpeedWhileStealing", function(s)
    Enabled.SpeedWhileStealing = s; if s then startSpeedWhileStealing() else stopSpeedWhileStealing() end
end, Color3.fromRGB(34,197,94), 3)
createSlider(stealPage, "Steal Radius", "STEAL_RADIUS", 5, 100, 4)
createSlider(stealPage, "Steal Speed While Stealing", "StealingSpeedValue", 10, 80, 5)
createSectionHeader(stealPage, "🎯 Teleport To Spots", 6)
createButtonPair(stealPage, "🏠 TP Spot 1", "🏠 TP Spot 2",
    function() semiTpExecuteTP(spot1_sequence) end,
    function() semiTpExecuteTP(spot2_sequence) end, 7)

-- ============================================================
-- TAB 4: ✨ Visuals
-- ============================================================
local visualPage = tabPages["✨ Visuals"]
createSectionHeader(visualPage, "⚡ Performance", 1)
createToggle(visualPage, "Optimizer + XRay", "Optimizer", function(s)
    Enabled.Optimizer = s; if s then enableOptimizer() else disableOptimizer() end
end, Color3.fromRGB(59,130,246), 2)
createSectionHeader(visualPage, "🌌 Skybox / Lighting", 3)
createToggle(visualPage, "Galaxy Sky Bright", "GalaxySkyBright", function(s)
    Enabled.GalaxySkyBright = s; if s then enableGalaxySkyBright() else disableGalaxySkyBright() end
end, Color3.fromRGB(180,80,255), 4)
createSectionHeader(visualPage, "💾 Config", 5)
local saveBtn = createButton(visualPage, "💾 SAVE CONFIG", C.purple, nil, 6)
saveBtn.MouseButton1Click:Connect(function()
    local success = SaveConfig()
    saveBtn.Text = success and "✅ SAVED!" or "❌ FAILED"
    saveBtn.BackgroundColor3 = success and C.success or C.danger
    task.delay(1.5, function() saveBtn.Text = "💾 SAVE CONFIG"; saveBtn.BackgroundColor3 = C.purple end)
end)
createSectionHeader(visualPage, "⌨ Keybinds Info", 7)
local infoLbl = Instance.new("TextLabel", visualPage)
infoLbl.Size = UDim2.new(0.95,0,0,50*guiScale); infoLbl.BackgroundColor3 = C.panel; infoLbl.BorderSizePixel = 0; infoLbl.ZIndex = 4
infoLbl.Text = "V=Speed | N=Spin | M=Galaxy | X=Aimbot\nZ=AutoLeft | C=AutoRight | Q=Nuke | U=Hide GUI\nF=AP Spam Selected"
infoLbl.TextColor3 = C.textDim; infoLbl.Font = Enum.Font.Gotham; infoLbl.TextSize = 10*guiScale; infoLbl.LayoutOrder = 8
Instance.new("UICorner", infoLbl).CornerRadius = UDim.new(0,8*guiScale)

-- ============================================================
-- TAB 5: 👻 Booster
-- ============================================================
local boosterPage = tabPages["👻 Booster"]
createSectionHeader(boosterPage, "👁 Invisibility", 1)
createToggle(boosterPage, "Semi Invisible (With Brainrot)", "SemiInvisible", function(s)
    toggleSemiInvisible(s)
end, Color3.fromRGB(109,40,217), 2)
createSectionHeader(boosterPage, "🚀 Speed", 3)
createToggle(boosterPage, "Potion Speed Boost (37.6 WalkSpeed)", "SpeedBoostBooster", function(s)
    toggleBoosterSpeedBoost(s)
end, Color3.fromRGB(34,197,94), 4)
createSectionHeader(boosterPage, "🎯 Booster Auto Steal", 5)
createToggle(boosterPage, "Auto Steal (Booster Mode)", "AutoStealBooster", function(s)
    Enabled.AutoStealBooster = s; if s then startBoosterAutoSteal() else stopBoosterAutoSteal() end
end, Color3.fromRGB(251,146,60), 6)
createToggle(boosterPage, "Highest Brainrot First", "HighestBrainrot", function(s)
    Enabled.HighestBrainrot = s
end, Color3.fromRGB(217,70,239), 7)
createToggle(boosterPage, "Speed While Stealing (Booster)", "SpeedWhileStealingBooster", function(s)
    Enabled.SpeedWhileStealingBooster = s; if s then startBoosterSpeedWhileStealing() else stopBoosterSpeedWhileStealing() end
end, Color3.fromRGB(34,197,94), 8)
createSectionHeader(boosterPage, "🏠 Carpet Teleport", 9)
createButtonPair(boosterPage, "🏠 Base 1", "🏠 Base 2",
    function() carpetTeleportToBase(1) end,
    function() carpetTeleportToBase(2) end, 10)

-- ============================================================
-- TAB 6: 🔀 Semi TP
-- ============================================================
local semiTPPage = tabPages["🔀 Semi TP"]
createSectionHeader(semiTPPage, "🔀 Semi Teleport", 1)
createToggle(semiTPPage, "Half TP On Steal (Semi TP)", "SemiTPEnabled", function(s)
    Enabled.SemiTPEnabled = s
end, Color3.fromRGB(255,50,50), 2)
createToggle(semiTPPage, "Auto Potion On Steal", "AutoPotion", function(s)
    Enabled.AutoPotion = s
end, Color3.fromRGB(34,197,94), 3)
createToggle(semiTPPage, "Speed Boost After Steal", "SpeedAfterSteal", function(s)
    Enabled.SpeedAfterSteal = s
    if not s and semiSpeedConnection then semiSpeedConnection:Disconnect(); semiSpeedConnection = nil end
end, Color3.fromRGB(251,146,60), 4)
createSlider(semiTPPage, "Semi Speed After Steal", "SEMI_SPEED_BOOST", 10, 100, 5)
createSectionHeader(semiTPPage, "📍 Manual Teleport", 6)
createButton(semiTPPage, "🔀 Auto TP Left", Color3.fromRGB(255,50,50), function()
    local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart"); if not root then return end
    local backpack = Player:FindFirstChild("Backpack"); local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if backpack and hum then local carpet = backpack:FindFirstChild("Flying Carpet"); if carpet then hum:EquipTool(carpet); task.wait(0.1) end end
    root.CFrame = spot1_sequence[1]; task.wait(0.1); root.CFrame = spot1_sequence[2]
    task.wait(0.2); local d1 = (root.Position-pos1).Magnitude; local d2 = (root.Position-pos2).Magnitude
    root.CFrame = CFrame.new(d1 < d2 and pos1 or pos2)
end, 7)
createButton(semiTPPage, "🔀 Auto TP Right", Color3.fromRGB(255,200,0), function()
    local root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart"); if not root then return end
    local backpack = Player:FindFirstChild("Backpack"); local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if backpack and hum then local carpet = backpack:FindFirstChild("Flying Carpet"); if carpet then hum:EquipTool(carpet); task.wait(0.1) end end
    root.CFrame = spot2_sequence[1]; task.wait(0.1); root.CFrame = spot2_sequence[2]
    task.wait(0.2); local d1 = (root.Position-pos1).Magnitude; local d2 = (root.Position-pos2).Magnitude
    root.CFrame = CFrame.new(d1 < d2 and pos1 or pos2)
end, 8)
createButton(semiTPPage, "📍 TP to Spot 1", C.purple, function() semiTpExecuteTP(spot1_sequence) end, 9)
createButton(semiTPPage, "📍 TP to Spot 2", C.purpleDark, function() semiTpExecuteTP(spot2_sequence) end, 10)
createSectionHeader(semiTPPage, "📣 Spam AP Nearest", 11)
createButton(semiTPPage, "📣 SPAM AP NEAREST", Color3.fromRGB(255,50,50), function()
    local target = getNearestPlayer()
    if not target then return end
    spamAPCommands(target.Name)
end, 12)

-- ============================================================
-- TAB 7: ⚡ Auto Duel
-- ============================================================
local autoDuelPage = tabPages["⚡ Auto Duel"]
createSectionHeader(autoDuelPage, "⚡ Auto Duel Bot", 1)

local duelInfoFrame = Instance.new("Frame", autoDuelPage)
duelInfoFrame.Size = UDim2.new(0.95,0,0,80*guiScale); duelInfoFrame.BackgroundColor3 = C.panel; duelInfoFrame.BorderSizePixel = 0; duelInfoFrame.ZIndex = 4; duelInfoFrame.LayoutOrder = 2
Instance.new("UICorner", duelInfoFrame).CornerRadius = UDim.new(0,8*guiScale)

local duelSpeedDisplay = Instance.new("TextLabel", duelInfoFrame)
duelSpeedDisplay.Size = UDim2.new(1,0,0.5,0); duelSpeedDisplay.BackgroundTransparency = 1
duelSpeedDisplay.Font = Enum.Font.GothamSemibold; duelSpeedDisplay.TextSize = 14*guiScale; duelSpeedDisplay.TextColor3 = Color3.fromRGB(67,181,129); duelSpeedDisplay.ZIndex = 5
duelSpeedDisplay.Text = "Speed: --"

local duelStatusDisplay = Instance.new("TextLabel", duelInfoFrame)
duelStatusDisplay.Size = UDim2.new(1,0,0.5,0); duelStatusDisplay.Position = UDim2.new(0,0,0.5,0); duelStatusDisplay.BackgroundTransparency = 1
duelStatusDisplay.Font = Enum.Font.GothamSemibold; duelStatusDisplay.TextSize = 12*guiScale; duelStatusDisplay.TextColor3 = Color3.fromRGB(67,181,129); duelStatusDisplay.ZIndex = 5
duelStatusDisplay.Text = "Ready"

RunService.Heartbeat:Connect(function()
    duelSpeedDisplay.Text = "Speed: "..duelSpeedText
    duelStatusDisplay.Text = duelStatusText
end)

local duelToggleBtn = createButton(autoDuelPage, "▶ START AUTO DUEL", Color3.fromRGB(88,101,242), nil, 3)
duelToggleBtn.MouseButton1Click:Connect(function()
    if duelMoving or duelWaitingGrab then
        duelStopMoving(); duelToggleBtn.Text = "▶ START AUTO DUEL"; duelToggleBtn.BackgroundColor3 = Color3.fromRGB(88,101,242); duelStatusText = "Ready"
    else
        startAutoDuel(); duelToggleBtn.Text = "⏹ STOP AUTO DUEL"; duelToggleBtn.BackgroundColor3 = C.danger
    end
end)

createSectionHeader(autoDuelPage, "ℹ How It Works", 4)
local duelHowTo = Instance.new("TextLabel", autoDuelPage)
duelHowTo.Size = UDim2.new(0.95,0,0,80*guiScale); duelHowTo.BackgroundColor3 = C.panel; duelHowTo.BorderSizePixel = 0; duelHowTo.ZIndex = 4; duelHowTo.LayoutOrder = 5
duelHowTo.Text = "Bot navigates to duel positions automatically.\nWhen it pauses: grab the pet from podium.\nWhen speed drops below 23, grab detected."
duelHowTo.Font = Enum.Font.Gotham; duelHowTo.TextSize = 11*guiScale; duelHowTo.TextColor3 = C.textDim; duelHowTo.TextWrapped = true
Instance.new("UICorner", duelHowTo).CornerRadius = UDim.new(0,8*guiScale)

-- ============================================================
-- TAB 8: 📣 AP Spam
-- ============================================================
local apSpamPage = tabPages["📣 AP Spam"]
createSectionHeader(apSpamPage, "🛡 Auto Defense", 1)
createToggle(apSpamPage, "Auto Defense (AP When Stolen From)", "AutoDefenseEnabled", function(s)
    Enabled.AutoDefenseEnabled = s
end, Color3.fromRGB(239,68,68), 2)
createSectionHeader(apSpamPage, "🎯 Select Targets & Spam", 3)

-- Player list for AP spam
local playerListFrame = Instance.new("Frame", apSpamPage)
playerListFrame.Size = UDim2.new(0.95,0,0,160*guiScale); playerListFrame.BackgroundColor3 = C.panel; playerListFrame.BorderSizePixel = 0; playerListFrame.ZIndex = 4; playerListFrame.LayoutOrder = 4
Instance.new("UICorner", playerListFrame).CornerRadius = UDim.new(0,8*guiScale)

local plTitle = Instance.new("TextLabel", playerListFrame)
plTitle.Size = UDim2.new(1,0,0,20*guiScale); plTitle.BackgroundTransparency = 1; plTitle.Text = "  Select Targets"
plTitle.Font = Enum.Font.GothamBold; plTitle.TextSize = 11*guiScale; plTitle.TextColor3 = C.text; plTitle.TextXAlignment = Enum.TextXAlignment.Left; plTitle.ZIndex = 5

local playerScroll = Instance.new("ScrollingFrame", playerListFrame)
playerScroll.Size = UDim2.new(1,-6,1,-24*guiScale); playerScroll.Position = UDim2.new(0,3,0,22*guiScale)
playerScroll.BackgroundColor3 = Color3.fromRGB(25,20,35); playerScroll.BorderSizePixel = 0; playerScroll.ScrollBarThickness = 2
playerScroll.ScrollBarImageColor3 = C.purple; playerScroll.ZIndex = 4
Instance.new("UICorner", playerScroll).CornerRadius = UDim.new(0,4*guiScale)
local playerListLayout2 = Instance.new("UIListLayout", playerScroll)
playerListLayout2.Padding = UDim.new(0,2); playerListLayout2.SortOrder = Enum.SortOrder.LayoutOrder

local function refreshPlayerList()
    for _, child in ipairs(playerScroll:GetChildren()) do if child:IsA("Frame") then child:Destroy() end end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Player then
            local card = Instance.new("Frame", playerScroll)
            card.Size = UDim2.new(1,-4,0,22*guiScale); card.BackgroundColor3 = Color3.fromRGB(20,15,28); card.BorderSizePixel = 0; card.ZIndex = 5
            Instance.new("UICorner", card).CornerRadius = UDim.new(0,4*guiScale)
            local pName = Instance.new("TextLabel", card)
            pName.Size = UDim2.new(1,-24,1,0); pName.Position = UDim2.new(0,4,0,0); pName.BackgroundTransparency = 1
            pName.Text = plr.DisplayName; pName.Font = Enum.Font.GothamSemibold; pName.TextSize = 10*guiScale; pName.TextColor3 = C.text; pName.TextXAlignment = Enum.TextXAlignment.Left; pName.ZIndex = 6
            local check = Instance.new("TextLabel", card)
            check.Size = UDim2.new(0,16*guiScale,0,16*guiScale); check.Position = UDim2.new(1,-20*guiScale,0.5,-8*guiScale)
            check.BackgroundColor3 = Color3.fromRGB(30,25,40); check.Text = selectedSet[plr] and "✓" or ""; check.Font = Enum.Font.GothamBold
            check.TextSize = 10*guiScale; check.TextColor3 = C.success; check.ZIndex = 6
            if selectedSet[plr] then check.BackgroundColor3 = C.success end
            Instance.new("UICorner", check).CornerRadius = UDim.new(0.25,0)
            local cardBtn2 = Instance.new("TextButton", card)
            cardBtn2.Size = UDim2.new(1,0,1,0); cardBtn2.BackgroundTransparency = 1; cardBtn2.Text = ""; cardBtn2.ZIndex = 7
            cardBtn2.MouseButton1Click:Connect(function()
                if selectedSet[plr] then
                    selectedSet[plr] = nil
                    for i, p in ipairs(selectedPlayers) do if p == plr then table.remove(selectedPlayers,i); break end end
                else
                    selectedSet[plr] = true; table.insert(selectedPlayers, plr)
                end
                refreshPlayerList()
            end)
        end
    end
    playerScroll.CanvasSize = UDim2.new(0,0,0,playerListLayout2.AbsoluteContentSize.Y+4)
end

task.spawn(function() task.wait(1); refreshPlayerList() end)
Players.PlayerAdded:Connect(function() task.wait(0.5); refreshPlayerList() end)
Players.PlayerRemoving:Connect(function(removedPlayer)
    selectedSet[removedPlayer] = nil
    for i = #selectedPlayers, 1, -1 do if selectedPlayers[i] == removedPlayer then table.remove(selectedPlayers, i) end end
    refreshPlayerList()
end)

local spamBtn2 = createButton(apSpamPage, "📣 SPAM SELECTED [F]", C.purple, function() spamSelected() end, 5)
createButton(apSpamPage, "🔄 Refresh Player List", C.purpleDark, function() refreshPlayerList() end, 6)
createSectionHeader(apSpamPage, "⚡ Quick Spam", 7)
createButton(apSpamPage, "📣 Spam Nearest Player", C.danger, function()
    local target = getNearestPlayer(); if target then spamAPCommands(target.Name) end
end, 8)

local discordInfoLbl = Instance.new("TextLabel", apSpamPage)
discordInfoLbl.Size = UDim2.new(0.95,0,0,30*guiScale); discordInfoLbl.BackgroundColor3 = C.panel; discordInfoLbl.BorderSizePixel = 0; discordInfoLbl.ZIndex = 4; discordInfoLbl.LayoutOrder = 9
discordInfoLbl.Text = "discord.gg/xzcRvnbncb | Key: VOID1982"
discordInfoLbl.Font = Enum.Font.GothamBold; discordInfoLbl.TextSize = 10*guiScale; discordInfoLbl.TextColor3 = C.purple
Instance.new("UICorner", discordInfoLbl).CornerRadius = UDim.new(0,8*guiScale)

-- ============================================================
-- DEFAULT TAB & INTRO ANIMATION
-- ============================================================
switchTab("⚔ Combat")

main.Size = UDim2.new(0,0,0,0); main.Position = UDim2.new(0.5,0,0.5,0)
TweenService:Create(main, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0,WINDOW_W,0,WINDOW_H),
    Position = isMobile and UDim2.new(0.5,-WINDOW_W/2,0.5,-WINDOW_H/2) or UDim2.new(1,-WINDOW_W-10,0,10)
}):Play()

-- ============================================================
-- INPUT HANDLING
-- ============================================================
local guiVisible = true

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if waitingForKeybind and input.KeyCode ~= Enum.KeyCode.Unknown then
        local k = input.KeyCode; KEYBINDS[waitingForKeybind] = k
        if KeyButtons[waitingForKeybind] then KeyButtons[waitingForKeybind].Text = k.Name end
        waitingForKeybind = nil; return
    end
    if input.KeyCode == Enum.KeyCode.U then guiVisible = not guiVisible; main.Visible = guiVisible; return end
    if input.KeyCode == Enum.KeyCode.Space then spaceHeld = true; return end
    if input.KeyCode == Enum.KeyCode.F then spamSelected(); return end
    if input.KeyCode == KEYBINDS.SPEED then
        Enabled.SpeedBoost = not Enabled.SpeedBoost
        if VisualSetters.SpeedBoost then VisualSetters.SpeedBoost(Enabled.SpeedBoost) end
        if Enabled.SpeedBoost then startSpeedBoost() else stopSpeedBoost() end
    end
    if input.KeyCode == KEYBINDS.SPIN then
        Enabled.SpinBot = not Enabled.SpinBot
        if VisualSetters.SpinBot then VisualSetters.SpinBot(Enabled.SpinBot) end
        if Enabled.SpinBot then startSpinBot() else stopSpinBot() end
    end
    if input.KeyCode == KEYBINDS.GALAXY then
        Enabled.Galaxy = not Enabled.Galaxy
        if VisualSetters.Galaxy then VisualSetters.Galaxy(Enabled.Galaxy) end
        if Enabled.Galaxy then startGalaxy() else stopGalaxy() end
    end
    if input.KeyCode == KEYBINDS.BATAIMBOT then
        Enabled.BatAimbot = not Enabled.BatAimbot
        if VisualSetters.BatAimbot then VisualSetters.BatAimbot(Enabled.BatAimbot) end
        if Enabled.BatAimbot then startBatAimbot() else stopBatAimbot() end
    end
    if input.KeyCode == KEYBINDS.NUKE then
        local n = getNearestPlayer(); if n then INSTANT_NUKE(n) end
    end
    if input.KeyCode == KEYBINDS.AUTOLEFT then
        AutoWalkEnabled = not AutoWalkEnabled; Enabled.AutoWalkEnabled = AutoWalkEnabled
        if VisualSetters.AutoWalkEnabled then VisualSetters.AutoWalkEnabled(AutoWalkEnabled) end
        if AutoWalkEnabled then startAutoWalk() else stopAutoWalk() end
    end
    if input.KeyCode == KEYBINDS.AUTORIGHT then
        AutoRightEnabled = not AutoRightEnabled; Enabled.AutoRightEnabled = AutoRightEnabled
        if VisualSetters.AutoRightEnabled then VisualSetters.AutoRightEnabled(AutoRightEnabled) end
        if AutoRightEnabled then startAutoRight() else stopAutoRight() end
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then spaceHeld = false end
end)

-- ============================================================
-- CHARACTER RESPAWN HANDLER
-- ============================================================
Player.CharacterAdded:Connect(function()
    task.wait(1)
    if Enabled.SpinBot    then stopSpinBot();   task.wait(0.1); startSpinBot()   end
    if Enabled.Galaxy     then startGalaxy()                                     end
    if Enabled.SpamBat    then stopSpamBat();   task.wait(0.1); startSpamBat()   end
    if Enabled.BatAimbot  then stopBatAimbot(); task.wait(0.1); startBatAimbot() end
    if Enabled.Unwalk     then startUnwalk()                                     end
    if Enabled.MedusaInRange   then stopMedusaInRange();  task.wait(0.1); startMedusaInRange()  end
    if Enabled.PlayerFollower  then stopPlayerFollower(); task.wait(0.1); startPlayerFollower() end
end)

-- ============================================================
-- CONFIG RESTORE ON LOAD
-- ============================================================
task.spawn(function()
    task.wait(3)
    local c = Player.Character
    if not c or not c:FindFirstChild("HumanoidRootPart") then c = Player.CharacterAdded:Wait(); task.wait(1) end
    for key, btn in pairs(KeyButtons) do if btn and KEYBINDS[key] then btn.Text = KEYBINDS[key].Name end end
    for key, setter in pairs(VisualSetters) do if Enabled[key] then setter(true, true) end end
    for key, setter in pairs(SliderSetters) do if Values[key] then setter(Values[key]) end end
    if Enabled.AntiRagdoll     then startAntiRagdoll()     end
    if Enabled.AutoSteal       then startAutoSteal()        end
    if Enabled.Optimizer       then enableOptimizer()       end
    if Enabled.GalaxySkyBright then enableGalaxySkyBright() end
    task.wait(0.5)
    if Enabled.SpeedBoost      then startSpeedBoost()       end
    if Enabled.SpinBot         then startSpinBot()          end
    if Enabled.SpamBat         then startSpamBat()          end
    if Enabled.BatAimbot       then startBatAimbot()        end
    if Enabled.Galaxy          then startGalaxy()           end
    if Enabled.SpeedWhileStealing then startSpeedWhileStealing() end
    if Enabled.Unwalk          then startUnwalk()           end
    if Enabled.AutoWalkEnabled then AutoWalkEnabled = true; startAutoWalk()  end
    if Enabled.AutoRightEnabled then AutoRightEnabled = true; startAutoRight() end
    if Enabled.MedusaInRange   then startMedusaInRange()   end
    if Enabled.PlayerFollower  then startPlayerFollower()  end
    if Enabled.AutoStealBooster then startBoosterAutoSteal() end
    if Enabled.SpeedWhileStealingBooster then startBoosterSpeedWhileStealing() end
    if Enabled.SpeedBoostBooster then toggleBoosterSpeedBoost(true) end
end)

print("✦ VOID HUB LOADED — 8 Tabs Active")
print("⌨ U=Hide | Q=Nuke | V/N/M/X/Z/C=Keybinds | F=Spam")
print("🔑 Discord: discord.gg/xzcRvnbncb")
