local Hint = Instance.new("Hint", workspace)
Hint.Text = "collecting items!"

local Character = game.Players.LocalPlayer.Character
local HRP = Character:WaitForChild("HumanoidRootPart", 5)

if HRP then
    pcall(function()
        local Toggle = 0

        while workspace.CornMaze:FindFirstChild("Trophy") and workspace.CornMaze.Trophy:FindFirstChild("Touching") do
            firetouchinterest(HRP, workspace.CornMaze.Trophy.Touching, Toggle)
            Toggle = 1 - Toggle
            task.wait()
        end
        
        Hint.Text = "collected trophy"
    end)

    task.wait(1)

    local Count = 0
    
    for _, v in pairs(workspace.CornMaze.Chests:GetChildren()) do
        local Toggle = 0

        while v:FindFirstChild("Touch") do
            firetouchinterest(HRP, v.Touch, Toggle)
            Toggle = 1 - Toggle
            task.wait()
        end

        Count += 1

        Hint.Text = string.format("collected %s/10", Count)
    end
else
    warn("no character found!")
end

Hint:Destroy()
