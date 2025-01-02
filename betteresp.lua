--[[
██████╗ ███████╗████████╗████████╗███████╗██████╗ 
██╔══██╗██╔════╝╚══██╔══╝╚══██╔══╝██╔════╝██╔══██╗
██████╔╝█████╗     ██║      ██║   █████╗  ██████╔╝
██╔══██╗██╔══╝     ██║      ██║   ██╔══╝  ██╔══██╗
██████╔╝███████╗   ██║      ██║   ███████╗██║  ██║
╚═════╝ ╚══════╝   ╚═╝      ╚═╝   ╚══════╝╚═╝  ╚═╝

███████╗███████╗██████╗ 
██╔════╝██╔════╝██╔══██╗
█████╗  ███████╗██████╔╝
██╔══╝  ╚════██║██╔═══╝ 
███████╗███████║██║     
╚══════╝╚══════╝╚═╝     
]]

getgenv().ESPSettings = { -- // You can execute the script to adjust current settings, even when already executed
    ["Main"] = {
        Keybind  = "P", -- // Toggle all ESP
        TeamCheck = false, -- // Enable ESP on team
    },
    ["Tracer"] = {
        Enabled  = true,
        Color = Color3.fromRGB(255, 255, 255), -- // Color of tracers
        Transparency = 0.5, -- // Transparency of tracers
        Position = "Cursor" -- // The position of where the tracers start // Options: Top, Middle, Bottom, Cursor
    },
    ["Skeleton"] = {
        Enabled  = true,
        Color = Color3.fromRGB(255, 255, 255),
    },
    ["Highlight"] = {
        Enabled  = true,
        OutlineColor = Color3.fromRGB(255, 255, 255), -- // Outline color
        FillColor = Color3.fromRGB(255, 255, 255), -- // Fill color
        OutlineTransparency = 0, -- // Outline transparency
        FillTransparency = 1, -- // Fill transparency
    },
    ["Box"] = {
        Enabled  = true,
        OutlineTransparency = 0.5, -- // Outline transparency
        FillTransparency = 0.5, -- // Fill transparency
        OutlineColor = Color3.fromRGB(255, 255, 255), -- // Outline color
        FillColor = Color3.fromRGB(255, 255, 255), -- // Fill color
        Thickness = 1, -- // Thickness of outline
    },
    ["Name"] = {
        Enabled  = true,
        ShowName = true, -- // Show name
        ShowHealth = true, -- // Show health of playeralth of player
        ShowDistance = true, -- // Show distance from player
    },
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/inkdupe/scripts/refs/heads/main/betteresp_library.lua"))()
