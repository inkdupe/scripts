getgenv().Information = {
    ["Commanders"] = {
        "inkduper",
        "chineseobese",
    },
    ["AddedCommanders"] = {},
    Prefix = ".",
}

local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer

local Following = nil

local Disabled = false

if getgenv().ExecutedBotScript then
    return
else
    getgenv().ExecutedBotScript = true
end

getgenv().MainBot = nil

local function IsNumber(String)
    if tonumber(String) ~= nil then
        return true
    end
end

local function Notify(Title, Text)
    StarterGui:SetCore("SendNotification", {
        Title = Title,
        Text = Text,
        Duration = 5
    })    
end

local function SendChatMessage(Message)
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        local TextChannel = TextChatService.TextChannels.RBXGeneral
        TextChannel:SendAsync(Message)
    else
        ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
    end
end

Notify("Notification", "Executed")

local function GetPlayer(Commander, Name)
    Name = Name:lower()
    if Name == "me" then
        return Commander
    end

    for _, Player in ipairs(Players:GetPlayers()) do
        if Player.Name:lower():find(Name) or Player.DisplayName:lower():find(Name) then
            return Player
        end
    end
    return nil
end

local function GetCharacter(Player)
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

    return Character, Humanoid, HumanoidRootPart
end

local function AddCommander(Player)
    Player.Chatted:Connect(function(Message)
        if table.find(getgenv().Information.Commanders, Player.Name) or table.find(getgenv().Information.AddedCommanders, Player.Name) then
            print(getgenv().MainBot, "is main bot")
            local Commander = Player
            local Prefix = getgenv().Information.Prefix

            local IsOwnerCommander = table.find(getgenv().Information.Commanders, Player.Name)

            if not Disabled and string.sub(Message, 1, #Prefix) == Prefix then
                local Command = string.sub(Message, #Prefix + 1)

                local Words = Command:lower():split(" ")

                local FirstWord = Words[1]
                local SecondWord = Words[2]
        
                print(FirstWord, SecondWord)

                if FirstWord == "goto" then
                    if SecondWord then
                        local Player = GetPlayer(Commander, SecondWord)

                        if Player and Player ~= LocalPlayer then
                            local _, _, HumanoidRootPart = GetCharacter(Player)

                            if HumanoidRootPart then
                                local _, _, LocalHumanoidRootPart = GetCharacter(LocalPlayer)

                                LocalHumanoidRootPart.CFrame = HumanoidRootPart.CFrame
                            end
                        elseif not Player then
                            warn("Could not find player")
                        end
                    end

                elseif FirstWord == "disable" then
                    if getgenv().MainBot ~= LocalPlayer.Name then
                        return
                    end

                    if not IsOwnerCommander then
                        SendChatMessage("You have no permission!", Commander.Name)
                        return
                    end
                    
                    SendChatMessage(LocalPlayer.Name .. " Inactive")
                    getgenv().HasExecutedBotScript = false
                    Disabled = true

                    local _, _, HumanoidRootPart = GetCharacter(LocalPlayer)

                    for _, Velocity in ipairs(HumanoidRootPart:GetChildren()) do
                        if Velocity.Name == "Spinning" then
                            Velocity:Destroy()
                        end
                    end

                elseif FirstWord == "bring" then
                    local _, _, HumanoidRootPart = GetCharacter(Commander)

                    if HumanoidRootPart then
                        local _, _, LocalHumanoidRootPart = GetCharacter(LocalPlayer)

                        LocalHumanoidRootPart.CFrame = HumanoidRootPart.CFrame
                    end

                elseif FirstWord == "addcommander" then
                    if getgenv().MainBot ~= LocalPlayer.Name then
                        return
                    end

                    if not IsOwnerCommander then
                        SendChatMessage("You have no permission!", Commander.Name)
                        return
                    end
                    
                    if SecondWord then
                        local Player
                        if SecondWord == "all" then
                            getgenv().Information.AddedCommanders = {}
                            SendChatMessage("Removed everybody from commander list")
                            return
                        else
                            Player = GetPlayer(Commander, SecondWord)
                        end

                        if Player then
                            local Index = table.find(getgenv().Information.AddedCommanders, Player.Name)
                            if not Index then
                                table.insert(getgenv().Information.AddedCommanders, Player.Name)
                                SendChatMessage(Player.Name .. " Added to commanders list")
                            else
                                SendChatMessage(Player.Name .. " is already in the commanders list")
                            end
                        elseif not Player then
                            warn("Could not find player")
                        end
                    end

                elseif FirstWord == "removecommander" then
                    if getgenv().MainBot ~= LocalPlayer.Name then
                        return
                    end
                    if not IsOwnerCommander then
                        SendChatMessage("You have no permission!", Commander.Name)
                        return
                    end
                    if SecondWord then
                        local Player = GetPlayer(Commander, SecondWord)

                        if Player then
                            local Index = table.find(getgenv().Information.AddedCommanders, Player.Name)
                            if Index then
                                table.remove(getgenv().Information.AddedCommanders, Index)
                                SendChatMessage(Player.Name .. " Removed from commanders list")
                            end
                        elseif not Player then
                            warn("Could not find player")
                        end
                    end
                    
                elseif FirstWord == "jump" then
                    local _, Humanoid = GetCharacter(LocalPlayer)

                    if Humanoid then
                        Humanoid:ChangeState("Jumping")
                    end

                elseif FirstWord == "sit" then
                    local _, Humanoid = GetCharacter(LocalPlayer)

                    if Humanoid then
                        Humanoid.Sit = true
                    end

                elseif FirstWord == "say" then
                    if not IsOwnerCommander then
                        if getgenv().MainBot ~= LocalPlayer.Name then
                            return
                        end
                        SendChatMessage("These commands only work with my owner")
                        return
                    end
                    local FullMessage = Command:sub(5)
                    if #FullMessage > 0 then
                        SendChatMessage(FullMessage)
                    end

                elseif FirstWord == "spin" then
                    local SpinSpeed = 20

                    if SecondWord and IsNumber(SecondWord) then
                        SpinSpeed = SecondWord
                    end

                    local _, _, HumanoidRootPart = GetCharacter(LocalPlayer)

                    for _, Velocity in ipairs(HumanoidRootPart:GetChildren()) do
                        if Velocity.Name == "Spinning" then
                            Velocity:Destroy()
                        end
                    end

                    local Spin = Instance.new("BodyAngularVelocity")
                    Spin.Name = "Spinning"
                    Spin.Parent = HumanoidRootPart
                    Spin.MaxTorque = Vector3.new(0, math.huge, 0)
                    Spin.AngularVelocity = Vector3.new(0, SpinSpeed, 0)

                elseif FirstWord == "unspin" then
                    local _, _, HumanoidRootPart = GetCharacter(LocalPlayer)

                    for _, Velocity in ipairs(HumanoidRootPart:GetChildren()) do
                        if Velocity.Name == "Spinning" then
                            Velocity:Destroy()
                        end
                    end

                elseif FirstWord == "follow" then
                    local Player

                    if SecondWord then
                        Player = GetPlayer(Commander, SecondWord)
                    else
                        Player = Commander
                    end

                    if Player then
                        print(Player, "is player thing")
                        local Character, Humanoid, HumanoidRootPart = GetCharacter(Player)

                        if HumanoidRootPart then
                            local LocalCharacter, LocalHumanoid, LocalHumanoidRootPart = GetCharacter(LocalPlayer)
                            
                            Following = HumanoidRootPart
                            while not Disabled and Following ~= nil and Character ~= nil and Humanoid ~= nil and HumanoidRootPart ~= nil and LocalCharacter ~= nil and LocalHumanoid ~= nil and LocalHumanoidRootPart ~= nil do
                                LocalHumanoid:MoveTo(Following.Position)
                                wait()
                            end
                        end
                    else
                        warn("Could not find player")
                    end
                    
                elseif FirstWord == "unfollow" then
                    Following = nil
                end
            end
        end
    end)
end

if not table.find(getgenv().Information.Commanders, LocalPlayer.Name) then
    SendChatMessage(LocalPlayer.Name .. " Active")
    if not getgenv().MainBot then
        getgenv().MainBot = LocalPlayer.Name
        print(getgenv().MainBot, "is main bot since the BEGINNING hEHAeAwud6712t38672ye-;jghyuer6743452421423455909wteryuyuiyasdfghjk1234567890-=qwertyuiop[]asdfghjklzxcvbnm,.")
    end
end

for _, Player in ipairs(Players:GetPlayers()) do
    if Player ~= LocalPlayer then
        AddCommander(Player)
    end
end

Players.PlayerAdded:Connect(function(Player)
    AddCommander(Player)
end)
