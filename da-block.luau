local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Event = ReplicatedStorage.ZAP.ZAP_RELIABLE

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

local function BypassTp(NewCFrame)
    local _, _, Hum = GetCharacter()

    if Hum then
        Hum.Sit = true
        task.wait(0.05)
        Tp(NewCFrame)
        task.wait(0.05)
        Hum.Sit = false
    end
end

local Character, HRP = GetCharacter()

local function BoxCycle()
    Event:FireServer(
        buffer.fromstring("\xAC\x00\t\x00MoveBoxes"),
        {}
    )

    while Character and Character == LocalPlayer.Character and not Character:FindFirstChild("Box") do
        BypassTp(workspace.Boxes.PrimaryPart.CFrame)

        Event:FireServer(
            buffer.fromstring("w\x00"),
            {}
        )
        task.wait()
    end

    while Character and Character == LocalPlayer.Character and Character:FindFirstChild("Box") do
        BypassTp(CFrame.new(workspace.BoxGoal.Part.Position) + Vector3.new(0, 3.5, 0))

        Event:FireServer(
            buffer.fromstring("x\x00"),
            {}
        )
        task.wait()
    end
end

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "autofarm for da block"
})

local Tab = Window:Tab({
    Title = "main"
})

Window:SelectTab(1)

Tab:Paragraph({
    Title = "make sure to turn off pvp"
})

local Enabled = false

Tab:Toggle({
    Title = "autofarm",
    Callback = function(State)
        Enabled = State

        if Enabled then
            local Velocity = Instance.new("BodyVelocity", HRP)
            Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            Velocity.Velocity = Vector3.zero

            while Enabled do
                if not LocalPlayer:GetAttribute("PvpProtection") then
                    Event:FireServer(
                        buffer.fromstring("\x1E\x01"),
                        {}
                    )
                end

                BoxCycle()
                
                task.wait()
            end
            
            Velocity:Destroy()
        end
    end
})
