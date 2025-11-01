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
    firetouchinterest(HRP, Trophy.Base1, 0)
    task.wait()
    firetouchinterest(HRP, Trophy.Base1, 1)
end
