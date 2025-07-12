-- getgenv().FarmEnabled = true -- set to false if u wana stop the farm
-- getgenv().Speed = 0.25 -- putting it too low will probably kick you

if not getgenv().FarmEnabled then return end

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function GetCharacter()
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local HRP = Character:FindFirstChild("HumanoidRootPart")
    local Hum = Character:FindFirstChild("Humanoid")

    return Character, HRP, Hum
end

local function Tp(NewCFrame)
    local _, HRP = GetCharacter()

    if HRP then
        HRP.CFrame = typeof(NewCFrame) == "Vector3" and CFrame.new(NewCFrame) or NewCFrame
    end
end

local Character, HRP = GetCharacter()

local function GetWrench()
    local Wrench = workspace.CityBuildings.VehicleShop.MeshPart

    while task.wait() and not Character:FindFirstChild("Wrench") do
        Tp(Wrench.Position - Vector3.new(0, 9, 0))
        fireproximityprompt(Wrench.ProximityPrompt)
    end
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

local Velocity = Instance.new("BodyVelocity", HRP)
Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
Velocity.Velocity = Vector3.new(0, 0, 0)

GetWrench()

local LastEvent = 0

for _, v in pairs(workspace.CityBuildings.VehicleShop.CarMake.Vehicle:GetDescendants()) do
    if v:IsA("ProximityPrompt") and v.ObjectText == "Requiers Wrench" then
        while task.wait() and getgenv().FarmEnabled do
            GetWrench()
            Tp(v.Parent.Position - Vector3.new(0, 9, 0))
            if tick() > LastEvent then
                fireproximityprompt(v)
                LastEvent = tick() + getgenv().Speed
            end
        end
        break
    end
end

Tp(workspace.CityBuildings.VehicleShop.CarMake.Vehicle.Roof.WorldPivot.Position + Vector3.new(0, 8, 0))

Velocity:Destroy()
if SteppedEvent then SteppedEvent:Disconnect() end
