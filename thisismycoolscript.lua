local res1 = 1
local res2 = 1
local sine = 0
local hue = 0
local Sound = Instance.new('Sound', game:GetService('SoundService'))
Sound.SoundId = 'rbxassetid://1835335514'
Sound.Looped = true
Sound:Play()
Sound.Volume = 10
local Distortion = Instance.new('DistortionSoundEffect', Sound)
Distortion.Level = 0.5
local CC = Instance.new('ColorCorrectionEffect', game:GetService('Lighting'))
local Camera = workspace.CurrentCamera
game:GetService("RunService").RenderStepped:Connect(
    function()
        hue += 3 if hue > 360 then
            hue = 0
        end
        sine += 1
        res1 = 0.4*math.sin(sine/10)
        res2 = 0.7*math.cos(sine/11.5)
        CC.Saturation = 0.6 + math.random(1,2)
        CC.TintColor = Color3.fromHSV(hue/360, 1,1)
        CC.Brightness = math.random(0,2)
        CC.Contrast = 3*math.sin(sine/30)
        Distortion.Level = 1*math.cos(sine/5)
        Camera.CFrame = Camera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, res2, res1, 0, 0, 0, 1)
    end
)
