local FarmRate = 100 -- higher = laggier




-- // most difficult script ever!!! best anticheat!1!!11 //

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character
local HRP = Character:WaitForChild("HumanoidRootPart")
local SteppedEvent

if Character:FindFirstChild("Humanoid") and Character.Humanoid.Health <= 0 then
    local Message = Instance.new("Message", workspace)
    Message.Text = "game is bugged\n(recommend to rejoin)"
    return
end

SteppedEvent = RunService.Stepped:Connect(function()
    if Character then
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

local Wheat = workspace:FindFirstChild("Wheat&Sickle").Wheat.Wheat

local Velocity = Instance.new("BodyVelocity", HRP)
Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
Velocity.Velocity = Vector3.new(0, 0, 0)

local LastFire = 0
local Timeout = tick() + 20

while task.wait() and HRP and not LocalPlayer.Backpack:FindFirstChild("Sickle") and not Character:FindFirstChild("Sickle") and tick() < Timeout do
    local Sickle = workspace:FindFirstChild("Wheat&Sickle").Sickle.Handle
    TweenService:Create(HRP, TweenInfo.new((HRP.Position - Sickle.Position).Magnitude / 150, Enum.EasingStyle.Linear), {CFrame = CFrame.new(Sickle.Position)}):Play()
    if tick() > LastFire then
        fireproximityprompt(Sickle.ProximityPrompt)
        LastFire = tick() + 0.5
    end
end

task.wait(1)

if LocalPlayer.Backpack:FindFirstChild("Sickle") then
    LocalPlayer.Backpack.Sickle.Parent = Character
end

if Character:FindFirstChild("Sickle") then
    local Tween = TweenService:Create(HRP, TweenInfo.new((HRP.Position - Wheat.Position).Magnitude / 150, Enum.EasingStyle.Linear), {CFrame = CFrame.new(Wheat.Position)})
    Tween:Play()
    Tween.Completed:Wait()

    for _ = 1, FarmRate * 1000 do
        fireproximityprompt(Wheat.ProximityPrompt)
    end

    task.wait(1)

    Character:WaitForChild("Humanoid").Health = 0

    if Velocity then Velocity:Destroy() end
    if SteppedEvent then SteppedEvent:Disconnect() end

    task.wait(1)

    local Message = Instance.new("Message", workspace)
    Message.Text = "finished\n(might be laggy until the cash is fully loaded)\n\nrejoin if it takes too long"
    task.wait(12)
    Message:Destroy()
else
    warn("no sickle found")
    local Message = Instance.new("Message", workspace)
    Message.Text = "game is bugged\n(recommend to rejoin)"
end
