local player = game:GetService("Players").LocalPlayer
local backpack = player:FindFirstChild("Backpack")

if backpack then
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:FindFirstChild("ACS_Module") then
            local variables = tool.ACS_Module:FindFirstChild("Variables")
            
            if variables then
                local settingsModule = variables:FindFirstChild("Settings")
                if settingsModule then
                    local settings = require(settingsModule)
                    settings.Bullets = 1
                    settings.FireRate = 950
                    settings.Mode = "Auto"
                    settings.MinRecoilPower = 0
                    settings.MaxRecoilPower = 0
                    settings.RecoilPunch = 0
                    settings.VPunchBase = 0
                    settings.HPunchBase = 0
                    settings.DPunchBase = 0
                    settings.VRecoil = {0, 0}
                    settings.HRecoil = {0, 0}
                    settings.PunchRecover = 1000
                    settings.BulletPenetration = 9999999999999999999
                    settings.MaxSpread = 0
                    settings.AimRecover = 100
                    settings.AimRecoilReduction = 0.1
                    settings.BDrop = 0
                    settings.BSpeed = 500000000
                    settings.AllowPenetration = true
                    settings.CanJam = false
                    settings.Distance = 2000000000000000000000000000
                    settings.LimbsDamage = {440, 440}
                    settings.TorsoDamage = {440, 440}
                    settings.HeadDamage = {440, 440}
                    settings.MaxSway = 0
                    settings.PenetrationDistane = 1000000000000000000000
                    settings.SpreadStepAmount = 0
                end
                
                local ammo = variables:FindFirstChild("Ammo")
                if ammo then
                    ammo.Value = 10000000000000
                end
            end
        end
    end
end
