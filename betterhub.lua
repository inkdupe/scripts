local RunService = game:GetService("RunService")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Camera = workspace.CurrentCamera

local Speed = 5
local Speeding = false

local Hitpart = nil
local TargetDiesLockOff = false
local TargetPlayer = nil
local XPrediction = 0.165
local YPrediction = 0.12
local Whitelisted = {}
local MinimumHealth = 15

local AntiAimlocking = false
local AntiAimlockPosition = Vector3.new(0, 10000, 0)

local function GetCharacter(Player)
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:FindFirstChild("Humanoid")
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

    return Character, Humanoid, HumanoidRootPart
end

local function GetPlayerFromString(Name)
    Name = Name:lower()

    for _, Player in ipairs(Players:GetPlayers()) do
        if Player.Name:lower():find(Name) or Player.DisplayName:lower():find(Name) then
            return Player
        end
    end
    return nil
end

local function GetClosestPlayer()
    local ClosestDistance = 100000
    local ClosestPlayer = nil

    for _, Player in pairs(Players:GetPlayers()) do
        local IsWhitelisted = false
        for _, WhitelistedPlayer in ipairs(Whitelisted) do
            if Player.Name == WhitelistedPlayer.Name then
                IsWhitelisted = true
                break
            end
        end
        
        if not IsWhitelisted and Player.Name ~= LocalPlayer.Name and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health ~= 0 and Player.Character.Humanoid.Health > MinimumHealth then
            local Root, Visible = Camera:WorldToScreenPoint(Player.Character.HumanoidRootPart.Position)
            if not Visible then
                continue
            end
            Root = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(Root.X, Root.Y)).Magnitude
            if Root < ClosestDistance then
                ClosestPlayer = Player
                ClosestDistance = Root
            end
        end
    end
    return ClosestPlayer
end

RunService.RenderStepped:Connect(function()
    if TargetPlayer and TargetPlayer.Character and Hitpart then
        local Hitpart = TargetPlayer.Character:FindFirstChild(Hitpart)
    
        if Hitpart then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, Hitpart.Position + Hitpart.Velocity * Vector3.new(XPrediction, YPrediction, XPrediction))
        end
    end
end)

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Better Hub",
    SubTitle = "v1",
    TabWidth = 100,
    Size = UDim2.fromOffset(500, 600),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Player = Window:AddTab({ Title = "Player", Icon = "user" }),
    Aimlock = Window:AddTab({ Title = "Aimlock", Icon = "crosshair" }),
    ESP = Window:AddTab({ Title = "ESP", Icon = "eye" }),
}

Window:SelectTab(1)

local SpeedSection = Tabs.Player:AddSection("Speed")

local SpeedValue = SpeedSection:AddSlider("Slider", 
{
    Title = "Speed speed",
    Description = "Speedy speedy speed speed",
    Default = Speed,
    Min = 1,
    Max = 20,
    Rounding = 0,
    Callback = function(Value)
        Speed = Value
    end
})

local SpeedKeybind = SpeedSection:AddKeybind("Keybind", {
    Title = "Toggle speed",
    Description = "Toggle speed with this keybind wooow",
    Mode = "Toggle",
    Default = "T",

    Callback = function(Value)
        Speeding = Value

        while Speeding do
            local Delta = RunService.Heartbeat:Wait()
        
            local Character, Humanoid = GetCharacter(LocalPlayer)
        
            if Humanoid and Humanoid.MoveDirection.Magnitude > 0 then
                Character:TranslateBy(Humanoid.MoveDirection * Speed * Delta * 10)
            end
            task.wait()
        end
    end
})

local AimlockSection = Tabs.Aimlock:AddSection("Aimlock")

local AimlockToggle = AimlockSection:AddToggle("MyToggle", 
{
    Title = "Toggle aimlock!!?!", 
    Description = "(this button doesnt do anything, its just to show if the aimlock is on or off)",
    Default = false,
    Callback = function(state)
        
    end
})

local AimlockKeybind = AimlockSection:AddKeybind("Keybind", {
    Title = "Toggle aimlock",
    Description = "Use THIS beautiful wonderful keybind to toggle the aimlock",
    Mode = "Toggle",
    Default = "Q",

    Callback = function(Value)
        TargetPlayer = not TargetPlayer and GetClosestPlayer() or nil

        if TargetPlayer then
            AimlockToggle:SetValue(true)
            TargetPlayer.CharacterRemoving:Connect(function(Character)
                if TargetPlayer and Players:GetPlayerFromCharacter(Character) == TargetPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and TargetDiesLockOff then
                    TargetPlayer = nil
                end
            end)
            Players.PlayerRemoving:Connect(function(Player)
                if Player == TargetPlayer then
                    TargetPlayer = nil
                end
            end)
        else
            AimlockToggle:SetValue(false)
        end
    end
})

local Toggle = AimlockSection:AddToggle("MyToggle", 
{
    Title = "Target Dies lock-off", 
    Description = "If target dies to lock off of player!?!?!",
    Default = false,
    Callback = function(state)
        TargetDiesLockOff = state
    end
})

local TeamCheckToggle = AimlockSection:AddToggle("MyToggle", 
{
    Title = "Team check", 
    Description = "Toggle ANTI aimlock to expose those pesky aimlockers! (you would never aimlock)",
    Default = false,
    Callback = function(state)
        AntiAimlocking = state
    end
})

local Input = AimlockSection:AddInput("Input", {
    Title = "Whitelist",
    Description = "NO more accidental slaughtering!",
    Default = "",
    Placeholder = "user/display name",
    Numeric = false,
    Finished = true,
    Callback = function(Value)
        if not Value or Value == "" then
            return
        end
        
        local Player = GetPlayerFromString(Value)

        if Player and Player ~= Localplayer then
            local index = table.find(Whitelisted, Player)

            if not index then
                Window:Dialog({
                    Title = "Warning",
                    Content = "Add @" .. Player.Name .. " (" .. Player.DisplayName .. ") to the whitelist?",
                    Buttons = {
                        { 
                            Title = "YES",
                            Callback = function()
                                table.insert(Whitelisted, Player)
                            end 
                        }, {
                            Title = "no i changed my mind.",
                            Callback = function()
                                return
                            end 
                        }
                    }
                })
            else
                Window:Dialog({
                    Title = "Warning",
                    Content = "ALREAYD IN THE WHITELIST!!",
                    Buttons = {
                        { 
                            Title = "oooh ok.",
                            Callback = function()
                                return
                            end 
                        }
                    }
                })
            end
        else
            Window:Dialog({
                Title = "Error",
                Content = "I CANT FIND THE PLAYER",
                Buttons = {
                    { 
                        Title = "WHY?!?!?11!",
                        Callback = function()
                            return
                        end 
                    }
                }
            })
        end
    end
})

local Input = AimlockSection:AddInput("Input", {
    Title = "Remove from whitelist",
    Description = "FINALLY SLAUGHTER and MURDER them!!",
    Default = "",
    Placeholder = "user/display name",
    Numeric = false,
    Finished = true,
    Callback = function(Value)
        if not Value or Value == "" then
            return
        end

        local Player = GetPlayerFromString(Value)

        if Player and Player ~= Localplayer then
            local index = table.find(Whitelisted, Player)
            
            if index then
                Window:Dialog({
                    Title = "Warning",
                    Content = "Remove @" .. Player.Name .. " (" .. Player.DisplayName .. ") from whitelist?",
                    Buttons = {
                        { 
                            Title = "YES",
                            Callback = function()
                                table.remove(Whitelisted, index)
                            end 
                        }, {
                            Title = "sikeee nahh",
                            Callback = function()
                                return
                            end 
                        }
                    }
                })
            else
                Window:Dialog({
                    Title = "Error",
                    Content = "They ARENT in the whitelist!!",
                    Buttons = {
                        { 
                            Title = "oh ok",
                            Callback = function()
                                return
                            end 
                        }
                    }
                })
            end
        else
            Window:Dialog({
                Title = "Error",
                Content = "I CANT FIND THE PLAYER",
                Buttons = {
                    { 
                        Title = "WHY?!?!?11!",
                        Callback = function()
                            return
                        end 
                    }
                }
            })
        end
    end
})

local HitpartDropdown = AimlockSection:AddDropdown("Dropdown", {
    Title = "Hit part",
    Description = "part you shoot to hit to shoot yes with aimlock",
    Values = {"Head", "UpperTorso", "LowerTorso", "HumanoidRootPart"},
    Multi = false,
    Default = 1,
})

HitpartDropdown:OnChanged(function(Value)
    Hitpart = Value
end)

local PredictionYSlider = AimlockSection:AddSlider("Slider", 
{
    Title = "Prediction Y",
    Description = "thas predictionas for Y height yeyeas",
    Default = YPrediction,
    Min = 0,
    Max = 0.5,
    Rounding = 2.5,
    Callback = function(Value)
        YPrediction = Value
    end
})

local PredictionXSlider = AimlockSection:AddSlider("Slider", 
{
    Title = "Prediction X",
    Description = "YES!!! the obesity of the X width WOAH!",
    Default = XPrediction,
    Min = 0,
    Max = 0.5,
    Rounding = 2.5,
    Callback = function(Value)
        XPrediction = Value
    end
})

local AntiAimlockSection = Tabs.Aimlock:AddSection("Anti Aimlock")

local AntiAimlockToggle = AntiAimlockSection:AddToggle("MyToggle", 
{
    Title = "Anti aimlock", 
    Description = "Toggle ANTI aimlock to expose those pesky aimlockers! (you would never aimlock)",
    Default = false,
    Callback = function(state)
        AntiAimlocking = state
    end
})

local AimlockKeybind = AntiAimlockSection:AddKeybind("Keybind", {
    Title = "Keybind",
    Description = "ze keybind to toggel ze anti aimlockerzszsaw",
    Mode = "Toggle",
    Default = "B",

    Callback = function(Value)
        AntiAimlockToggle:SetValue(Value)
    end
})

local AntilockXInput = AntiAimlockSection:AddInput("Input", {
    Title = "X Position",
    Description = "LEFT IRGHT LEFT RIGHT!",
    Default = AntiAimlockPosition.X,
    Placeholder = "0",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        AntiAimlockPosition = Vector3.new(Value, AntiAimlockPosition.Y, AntiAimlockPosition.Z)
    end
})

local AntilockYInput = AntiAimlockSection:AddInput("Input", {
    Title = "Y Position",
    Description = "UP! or down or UP! or down",
    Default = AntiAimlockPosition.Y,
    Placeholder = "0",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        AntiAimlockPosition = Vector3.new(AntiAimlockPosition.X, Value, AntiAimlockPosition.Z)
    end
})

local AntilockZInput = AntiAimlockSection:AddInput("Input", {
    Title = "Z Position",
    Description = "BACK! OR FORWARD OR BACK!! or.. forward.",
    Default = AntiAimlockPosition.Z,
    Placeholder = "0",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        AntiAimlockPosition = Vector3.new(AntiAimlockPosition.X, AntiAimlockPosition.Y, Value)
    end
})

local MainESPSection = Tabs.ESP:AddSection("Main")

local ESPKeybind = MainESPSection:AddKeybind("Keybind", {
    Title = "Toggle",
    Description = "Toggle all esp at once OH MY GOD",
    Mode = "Toggle",
    Default = "H",

    Callback = function(Value)
        
    end
})
