local Speed = 100
local YPosition = 13

local TargetCFrame = CFrame.new(-157, 14, 569.5) * CFrame.Angles(0, math.rad(-90), 0)

-- // most difficult script ever!!! best anticheat!1!!11 //

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character
local HRP = Character:WaitForChild("HumanoidRootPart")
local SteppedEvent

local Velocity = Instance.new("BodyVelocity", HRP)
Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
Velocity.Velocity = Vector3.new(0, 0, 0)

if Character:FindFirstChild("Humanoid") and Character.Humanoid.Health <= 0 then
    local Message = Instance.new("Message", workspace)
    Message.Text = "game is bugged\n(recommend to rejoin)"
    return
end

SteppedEvent = RunService.Stepped:Connect(function()
    if Character then
        if Character:FindFirstChild("Humanoid") then
            Character.Humanoid.Sit = false
        end

        for _, v in pairs(Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then
                v.CanCollide = false
                v.CanTouch = false
            end
        end
    else
        if SteppedEvent then SteppedEvent:Disconnect() end
    end
end)

if Character:FindFirstChild("Humanoid") then
    Character.Humanoid.Died:Connect(function()
        Character = nil
    end)
end

local Tween = TweenService:Create(HRP, TweenInfo.new((HRP.Position - Vector3.new(HRP.Position.X, YPosition, HRP.Position.Z)).Magnitude / Speed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(HRP.Position.X, YPosition, HRP.Position.Z)})
Tween:Play()
Tween.Completed:Wait()

local Tween = TweenService:Create(HRP, TweenInfo.new((HRP.Position - TargetCFrame.Position).Magnitude / Speed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(TargetCFrame.Position.X, YPosition, TargetCFrame.Position.Z)})
Tween:Play()
Tween.Completed:Wait()

local Spatula

for _, v in pairs(workspace:GetChildren()) do
    if v.Name == "Handle" and v:FindFirstChild("ProximityPrompt") and (v.Position - Vector3.new(-180, 14, 565)).Magnitude < 1 then
        Spatula = v
        break
    end
end

if not Spatula then warn("spatula not found rip rip rip") return end

local LastFire = 0
local Timeout = tick() + 20

local Tween = TweenService:Create(HRP, TweenInfo.new((HRP.Position - CFrame.new(Spatula.Position.X, YPosition, Spatula.Position.Z).Position).Magnitude / Speed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(Spatula.Position.X, YPosition, Spatula.Position.Z)})
Tween:Play()
Tween.Completed:Wait()

while task.wait() and HRP and not LocalPlayer.Backpack:FindFirstChild("Spatula") and not Character:FindFirstChild("Spatula") and tick() < Timeout do
    TweenService:Create(HRP, TweenInfo.new((HRP.Position - Spatula.Position).Magnitude / Speed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(Spatula.Position)}):Play()

    if tick() > LastFire then
        fireproximityprompt(Spatula.ProximityPrompt)
        LastFire = tick() + 0.5
    end
end

if LocalPlayer.Backpack:FindFirstChild("Spatula") or Character:FindFirstChild("Spatula") then
    local Tween = TweenService:Create(HRP, TweenInfo.new((HRP.Position - TargetCFrame.Position).Magnitude / Speed, Enum.EasingStyle.Linear), {CFrame = TargetCFrame})
    Tween:Play()
    Tween.Completed:Wait()

    local Message = Instance.new("Message", workspace)
    Message.Text = "WOW farm is running?!?!?!1/1\n\nreset ur character or rejoin the game to disable"

    while task.wait() and LocalPlayer.Character == Character and HRP do
        HRP.CFrame = TargetCFrame
        if LocalPlayer.Backpack:FindFirstChild("Spatula") then
            LocalPlayer.Backpack.Spatula.Parent = Character
        end
        
        for _ = 1, getgenv().FarmRate do
            task.spawn(function()
                for _, v in pairs(workspace:GetChildren()) do
                    if v.Name == "Part" and v.Color == Color3.fromRGB(124, 92, 70) and v.Material == Enum.Material.Grass then
                        fireproximityprompt(v.ProximityPrompt)
                    end
                end
            end)
        end
    end
else
    warn("no spatula found")
    local Message = Instance.new("Message", workspace)
    Message.Text = "game is bugged\n(recommend to rejoin)"
end
