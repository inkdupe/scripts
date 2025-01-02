
if getgenv().Executed then
    return
else
    getgenv().Executed = true
end

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

local TargetPlayer = nil
local Speeding = false
local Circling = false
local AntiLockEnabled = false

local GetClosestPlayer = function()
    local ClosestDistance = 100000
    local ClosestPlayer = nil

    for _, Player in pairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer and not getgenv().Settings.Target.WhiteListed[Player.Name] and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health ~= 0 and Player.Character.Humanoid.Health > getgenv().AimlockSettings.Target.MinHealth then
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

Mouse.KeyDown:Connect(function(Key)
    if Key == getgenv().AimlockSettings.Aimlock.Keybind:lower() then
        TargetPlayer = not TargetPlayer and GetClosestPlayer() or nil
        
        Circling = not TargetPlayer and false

        if TargetPlayer then
            TargetPlayer.CharacterRemoving:Connect(function(Character)
                if TargetPlayer and Players:GetPlayerFromCharacter(Character) == TargetPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    if getgenv().AimlockSettings.Target.TargetDiesLockOff then
                        TargetPlayer = nil
                    end
                    if Circling then
                        Camera.CameraSubject = LocalPlayer.Character.Humanoid
                    end
                end
            end)
            Players.PlayerRemoving:Connect(function(Player)
                if Player == TargetPlayer then
                    TargetPlayer = nil
                end
            end)
        end

    elseif Key == getgenv().AimlockSettings.AntiLock.Keybind:lower() then
        AntiLockEnabled = not AntiLockEnabled
        print("Anti lock is", AntiLockEnabled)

        game:GetService("RunService").Heartbeat:Connect(function()
            if not AntiLockEnabled then
                return
            end

            local HumanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not HumanoidRootPart then return end
            local Velocity = HumanoidRootPart.Velocity

            HumanoidRootPart.Velocity = getgenv().AimlockSettings.AntiLock.Position * 10

            game:GetService("RunService").RenderStepped:Wait()

            HumanoidRootPart.Velocity = Velocity
        end)

    elseif Key == getgenv().AimlockSettings.Target.TeleportKeybind:lower() then
        if TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame
        end

    elseif Key == getgenv().AimlockSettings.Speed.Keybind:lower() then
        Speeding = not Speeding

        if LocalPlayer.Character then
            for _, part in LocalPlayer.Character:GetDescendants() do
                if part:IsA("BasePart") then
                    spawn(function()
                        while Speeding do
                            part.CustomPhysicalProperties = PhysicalProperties.new(math.huge, math.huge, math.huge)
                            wait()
                        end
                    end)
                end
            end
            local Humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if Humanoid then
                Humanoid.WalkSpeed = not Speeding and game.StarterPlayer.CharacterWalkSpeed
            end
        end


    elseif Key == getgenv().AimlockSettings.Circling.Keybind:lower() then
        Circling = not Circling
        
        while Circling do
            if TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                Camera.CameraSubject = TargetPlayer.Character.Humanoid
                local Offset
                repeat
                    Offset = Vector3.new(
                        math.random(-getgenv().AimlockSettings.Circling.MaxRadius, getgenv().AimlockSettings.Circling.MaxRadius),
                        getgenv().AimlockSettings.Circling.Height,
                        math.random(-getgenv().AimlockSettings.Circling.MaxRadius, getgenv().AimlockSettings.Circling.MaxRadius)
                    )
                until Offset.Magnitude >= getgenv().AimlockSettings.Circling.MinRadius
                
                LocalPlayer.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame + Offset                
            end
            wait(getgenv().AimlockSettings.Circling.Delay)
        end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            Camera.CameraSubject = LocalPlayer.Character.Humanoid
            if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if TargetPlayer and TargetPlayer.Character then
        local Hitpart = TargetPlayer.Character:FindFirstChild(getgenv().AimlockSettings.Aimlock.Hitpart)
    
        if Hitpart then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, Hitpart.Position + Hitpart.Velocity * Vector3.new(getgenv().AimlockSettings.Aimlock.Prediction.X, getgenv().AimlockSettings.Aimlock.Prediction.Y, getgenv().AimlockSettings.Aimlock.Prediction.X))
        end
    end
    
    local Character = LocalPlayer.Character
    local Humanoid = Character:FindFirstChild("Humanoid")
    
    if not Humanoid then
        return
    end

    if Speeding then
        Humanoid.WalkSpeed = getgenv().AimlockSettings.Speed.Value
    end
end)
