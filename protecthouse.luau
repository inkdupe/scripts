-- https://www.roblox.com/games/115286378269814/Protect-The-House-From-Monsters

-- fire rate, inf ammo, no recoil, no spread, insta reload

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Guns = ReplicatedStorage.Modules.WeaponSettings.Gun

for _, v in pairs(Guns:GetDescendants()) do
    if v.Name == "1" then
        local m = require(v)

        m.FireRate = 0
        m.ReloadTime = 0
        m.AmmoPerMag = math.huge
        m.Recoil = 0
        m.Spread = 0
    end
end
