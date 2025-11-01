local LocalPlayer = game:GetService("Players").LocalPlayer

local HRP = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
local Trophy = workspace:FindFirstChild("Trophy")

if not Trophy then
    HRP.CFrame = CFrame.new(-377, -1, -347)

    local Msg = Instance.new("Message", workspace)
    Msg.Text = "execute the script again once you joined the maze game"

    task.wait(8)

    Msg:Destroy()
else
    for _, v in pairs(workspace.Chests:GetChildren()) do
        if not v:FindFirstChild("Touch") then continue end

        firetouchinterest(HRP, v.Touch, 0)
    end

    firetouchinterest(HRP, Trophy.Base1, 0)
end
