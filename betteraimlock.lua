--[[
██████╗ ███████╗████████╗████████╗███████╗██████╗ 
██╔══██╗██╔════╝╚══██╔══╝╚══██╔══╝██╔════╝██╔══██╗
██████╔╝█████╗     ██║      ██║   █████╗  ██████╔╝
██╔══██╗██╔══╝     ██║      ██║   ██╔══╝  ██╔══██╗
██████╔╝███████╗   ██║      ██║   ███████╗██║  ██║
╚═════╝ ╚══════╝   ╚═╝      ╚═╝   ╚══════╝╚═╝  ╚═╝
                                                  
█████╗ ██╗███╗   ███╗██╗      ██████╗  ██████╗██╗  ██╗
██╔══██╗██║████╗ ████║██║     ██╔═══██╗██╔════╝██║ ██╔╝
███████║██║██╔████╔██║██║     ██║   ██║██║     █████╔╝ 
██╔══██║██║██║╚██╔╝██║██║     ██║   ██║██║     ██╔═██╗ 
██║  ██║██║██║ ╚═╝ ██║███████╗╚██████╔╝╚██████╗██║  ██╗
╚═╝  ╚═╝╚═╝╚═╝     ╚═╝╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝
]]

getgenv().AimlockSettings = { -- // You can execute the script to adjust current settings, even when already executed
    ["Aimlock"] = {
        Keybind  = "Q", -- // Toggle the aimlock
        Hitpart = "Head", -- // For example: Head, UpperTorso, LowerTorso, HumanoidRootPart
        ["Prediction"] = {
            X = 0.165,
            Y = 0.1,
        },
    },

    ["AntiLock"] = {
        Keybind = "L", -- // Toggle the anti lock
        Position = Vector3.new(0, 10000, 0) -- // How many studs away from you XYZ
    },

    ["Circling"] = {
        Keybind  = "H", -- // Toggle circling the target
        Delay = 0.065, -- // Delay between teleports
        MinRadius = 10, -- // Minimum distance between target and you while circling
        MaxRadius = 14, -- // Maximum distance
        Height = 3, -- // Adjust height while circling
    },

    ["Speed"] = {
        Keybind  = "T", -- // Toggle speed
        Value = 100, -- // Adjust walking speed
    },

    ["Target"] = {
        TeleportKeybind  = "F", -- // Teleport to target
        MinHealth = 15, -- // Minimum health a player needs before getting locked onto, To avoid locking onto knocked people
        TargetDiesLockOff = true, -- // If target dies to automatically lock off
        ["Whitelisted"] = { -- // You can here whitelist people so it doesn't lock onto them (has to be full username)
            "",
        },
    },
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/inkdupe/scripts/refs/heads/main/betteraimlock_library.lua"))()
