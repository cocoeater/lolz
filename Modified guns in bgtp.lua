local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local damageEvent = ReplicatedStorage:WaitForChild("EngineShared"):WaitForChild("Events"):WaitForChild("damage")

-- Function to create the tool
local function createKillTool()
    local tool = Instance.new("Tool")
    tool.Name = "Limb Breaker"
    tool.ToolTip = "Click to break a playuers limb"
    tool.RequiresHandle = false -- Set to false so no physical handle is needed

    return tool
end

local killTool = createKillTool()
killTool.Parent = localPlayer.Backpack -- Give the tool to the player

local mouse = localPlayer:GetMouse()
local isToolEquipped = false

-- Event for when the tool is equipped
killTool.Equipped:Connect(function()
    isToolEquipped = true
    print("InvisibleKillerTool equipped!")
end)

-- Event for when the tool is unequipped
killTool.Unequipped:Connect(function()
    isToolEquipped = false
    print("InvisibleKillerTool unequipped.")
end)

-- Event for when the player clicks
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessedEvent and isToolEquipped then
        print("Mouse clicked with invisible tool equipped!")

        -- Perform a raycast from the mouse to find the hit target
        local target = mouse.Target -- This is the actual part that was clicked
        local targetHumanoid = nil
        local targetPart = nil -- This will store the specific limb/part that was clicked

        if target then
            local character = target.Parent
            -- Check if the clicked part's parent is a character and belongs to a player
            if character and Players:GetPlayerFromCharacter(character) and character:FindFirstChildOfClass("Humanoid") then
                targetHumanoid = character:FindFirstChildOfClass("Humanoid")
                targetPart = target -- Assign the actual clicked part to targetPart
            end
        end

        if targetHumanoid and targetPart and targetHumanoid.Health > 0 then
            local playerToKill = Players:GetPlayerFromCharacter(targetHumanoid.Parent)
            if playerToKill and playerToKill ~= localPlayer then -- Ensure it's another player
                print("Attempting to kill: " .. playerToKill.Name .. " by hitting " .. targetPart.Name)

                local args = {
                    [1] = targetHumanoid,
                    [2] = targetPart, -- Now dynamically the clicked part (Head, Arm, Leg, Torso, etc.)
                    [3] = CFrame.new(targetPart.Position), -- Use the clicked part's position for CFrame
                    [4] = targetPart.Position, -- Use the clicked part's position
                    [5] = targetPart.Position, -- Use the clicked part's position
                    [6] = 1.9375000000000004,
                    [7] = {
                        bulletLight = {
                            enabled = true,
                            brightness = 1,
                            lightRange = 10,
                            color = Color3.new(0, 1, 0)
                        },
                        lightBleedChance = 0,
                        penPower = 1000,
                        width = 1,
                        fragmentChance = 100000000,
                        heavyBleedChance = 0,
                        tracer = {
                            enabled = true,
                            everyXShots = 2,
                            lightInfluence = 0,
                            lightEmission = 1,
                            chance = 70,
                            color = Color3.new(0, 1, 0),
                            random = false,
                            width = 3
                        },
                        speed = 840,
                        armorDamage = 1003,
                        ricochetChance = 0,
                        damage = 1 -- Keep damage at 100 as it was working for killing
                    },
                    [8] = {
                        VPunchBase = 1,
                        BoltExtend = Vector3.new(0, 0, 0.4000000059604645),
                        BulletWhiz = true,
                        FocusOnSight = false,
                        Chambered = true,
                        ServerGunPos = CFrame.new(-0.30000001192092896, -1, -0.30000001192092896, -4.371138828673793e-08, 0, -1, 1, -4.371138828673793e-08, -4.371138828673793e-08, -4.371138828673793e-08, -1, 1.910685465164705e-15),
                        NewCameraMultiplier = 1,
                        CutOffGunshots = false,
                        ExpRadius = 25,
                        Mode = "Semi",
                        BurstFireRate = 900,
                        IncludeChamberedBullet = true,
                        CanJam = false,
                        ReloadType = 1,
                        Pitches = {
                            1,
                            1.12
                        },
                        MaxRecoilPower = 1,
                        BulletFlareColor = Color3.new(1, 0.40392157435417175, 0.32549020648002625),
                        LimbsDamage = {
                            30,
                            45
                        },
                        JamChance = 1000,
                        BulletPenetration = 60,
                        CanCheckMag = false,
                        BulletLight = false,
                        TracerLightInfluence = 0,
                        ServerBoltExtend = Vector3.new(0, 0, 0.4000000059604645),
                        TracerLifeTime = 0.05,
                        MaxSway = 1,
                        TracerLightEmission = 1,
                        RecoilPunch = 0.2,
                        BWMaxDistance = 200,
                        RightPos = CFrame.new(-0.6000000238418579, -0.10000000149011612, -0.949999988079071, 1, -0, 0, 0, -4.371138828673793e-08, 1, 0, -1, -4.371138828673793e-08),
                        BulletLightColor = Color3.new(1, 0.40392157435417175, 0.32549020648002625),
                        FireModes = {
                            Burst = false,
                            Semi = true,
                            Auto = true,
                            Smoke = false,
                            ChangeFiremode = true,
                            Explosive = false
                        },
                        AutoChamber = false,
                        BeltFed = false,
                        AllowPenetration = true,
                        ZoomAnim = false,
                        RandomTracer = false,
                        MinRecoilPower = -1,
                        MagCount = true,
                        TorsoDamage = {
                            75,
                            113
                        },
                        FocusOnSight2 = false,
                        BulletLightBrightness = 1,
                        OffsetSens = 0.1,
                        RainbowMode = false,
                        Name = "SA-58",
                        Ammo = 20,
                        AimRecoilReduction = 1.5,
                        BulletLightRange = 40,
                        CutOffDistance = true,
                        OffsetAngle = 5,
                        SlideLock = true,
                        BSpeed = 5000,
                        WalkMultiplier = 0.2,
                        DestroyJointRadiusPercent = 0,
                        LauncherDamage = 100,
                        Bullets = 1,
                        BWEmitter = 25,
                        FireRate = 750,
                        ExplosiveHit = false,
                        UGL = false,
                        SuppressTime = 1000000,
                        Tracer = true,
                        OldCamSway = true,
                        BulletType = "7.62x51mm",
                        LeftArmPos = CFrame.new(1.0499999523162842, 0.8999999761581421, -1.399999976158142, 0.8516507148742676, 0.3099755048751831, 0.4226182699203491, -0.33170679211616516, -0.30552393198013306, 0.8925389051437378, 0.4057852029800415, -0.9003167152404785, -0.15737870335578918),
                        TracerWidth = 7,
                        PenetrationDistance = 7,
                        BDrop = 0.1,
                        EnableHolster = false,
                        SlideExtend = Vector3.new(0, 0, 0.4000000059604645),
                        TracerChance = 70,
                        Distance = 20000,
                        FallOfDamage = 1,
                        TracerColor = Color3.new(1, 0.40392157435417175, 0.32549020648002625),
                        HolsterTo = "Torso",
                        ChangeFOV = {
                            25,
                            60
                        },
                        RightArmPos = CFrame.new(-0.8500000238418579, -0.20000000298023224, -1.2000000476837158, 1, -0, 0, 0, -4.371138828673793e-08, 1, 0, -1, -4.371138828673793e-08),
                        MinSpread = 0,
                        SpreadStepAmount = 1.5,
                        ModoTreino = false,
                        Thermal = false,
                        HRecoil = {
                            1,
                            10
                        },
                        SuppressMaxDistance = 10,
                        VRecoil = {
                            35,
                            70
                        },
                        AimRecover = 0.4,
                        LauncherRadius = 25,
                        GunType = 1,
                        BurstShot = 3,
                        LeftPos = CFrame.new(1.2000000476837158, 0.4000000059604645, -1.600000023841858, 0.7697511315345764, 0.28016647696495056, 0.5735764503479004, -0.29576510190963745, -0.6397386193275452, 0.7094064950942993, 0.5656908750534058, -0.7157102823257446, -0.40957608819007874),
                        RecoilPowerStepAmount = 0.1,
                        LauncherPressure = 500,
                        ExPressure = 500,
                        HeadDamage = {
                            1,
                            1
                        },
                        MaxSpread = 0.5,
                        LauncherDestroyJointRadiusPercent = 0,
                        FastReload = true,
                        ChamberWhileAim = false,
                        GunPos = CFrame.new(0.15000000596046448, -0.15000000596046448, 1, 1, 0, 0, 0, -4.371138828673793e-08, -1, 0, 1, -4.371138828673793e-08),
                        TracerEveryXShots = 5,
                        GunSize = 3.5,
                        HPunchBase = 0.5,
                        ServerSlideExtend = Vector3.new(0, 0, 0.4000000059604645),
                        LauncherReady = false,
                        MoveBolt = false,
                        ArcadeMode = false,
                        PunchRecover = 0.1,
                        BulletFlare = false,
                        SwayBase = 0,
                        HolsterPos = CFrame.new(0.25, -0.10000000149011612, -0.800000011920929, 0.6403416395187378, -0.7631294131278992, -0.08715573698282242, 0.7582467198371887, 0.6461606025695801, -0.08682408183813095, 0.12257461249828339, -0.010488472878932953, 0.9924039244651794),
                        OldRecoil = true,
                        GunFOVReduction = 3,
                        BoltLock = false,
                        DPunchBase = 1,
                        ExplosionDamage = 100
                    },
                    [9] = "canYouBypassThis???\226\128\142"
                }

                -- Attempt to fire the server with the faked arguments
                damageEvent:FireServer(unpack(args))
            end
        end
    end
end)




local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local damageEvent = ReplicatedStorage:WaitForChild("EngineShared"):WaitForChild("Events"):WaitForChild("damage")

-- Function to create the tool
local function createKillTool()
    local tool = Instance.new("Tool")
    tool.Name = "bleed"
    tool.ToolTip = "Click to make a player bleed"
    tool.RequiresHandle = false -- Set to false so no physical handle is needed

    return tool
end

local killTool = createKillTool()
killTool.Parent = localPlayer.Backpack -- Give the tool to the player

local mouse = localPlayer:GetMouse()
local isToolEquipped = false

-- Event for when the tool is equipped
killTool.Equipped:Connect(function()
    isToolEquipped = true
    print("InvisibleKillerTool equipped!")
end)

-- Event for when the tool is unequipped
killTool.Unequipped:Connect(function()
    isToolEquipped = false
    print("InvisibleKillerTool unequipped.")
end)

-- Event for when the player clicks
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessedEvent and isToolEquipped then
        print("Mouse clicked with invisible tool equipped!")

        -- Perform a raycast from the mouse to find the hit target
        local target = mouse.Target -- This is the actual part that was clicked
        local targetHumanoid = nil
        local targetPart = nil -- This will store the specific limb/part that was clicked

        if target then
            local character = target.Parent
            -- Check if the clicked part's parent is a character and belongs to a player
            if character and Players:GetPlayerFromCharacter(character) and character:FindFirstChildOfClass("Humanoid") then
                targetHumanoid = character:FindFirstChildOfClass("Humanoid")
                targetPart = target -- Assign the actual clicked part to targetPart
            end
        end

        if targetHumanoid and targetPart and targetHumanoid.Health > 0 then
            local playerToKill = Players:GetPlayerFromCharacter(targetHumanoid.Parent)
            if playerToKill and playerToKill ~= localPlayer then -- Ensure it's another player
                print("Attempting to kill: " .. playerToKill.Name .. " by hitting " .. targetPart.Name)

                local args = {
                    [1] = targetHumanoid,
                    [2] = targetPart, -- Now dynamically the clicked part (Head, Arm, Leg, Torso, etc.)
                    [3] = CFrame.new(targetPart.Position), -- Use the clicked part's position for CFrame
                    [4] = targetPart.Position, -- Use the clicked part's position
                    [5] = targetPart.Position, -- Use the clicked part's position
                    [6] = 1.9375000000000004,
                    [7] = {
                        bulletLight = {
                            enabled = true,
                            brightness = 1,
                            lightRange = 10,
                            color = Color3.new(0, 1, 0)
                        },
                        lightBleedChance = 100000000,
                        penPower = 1000,
                        width = 1,
                        fragmentChance = 0,
                        heavyBleedChance = 10000000,
                        tracer = {
                            enabled = true,
                            everyXShots = 2,
                            lightInfluence = 0,
                            lightEmission = 1,
                            chance = 70,
                            color = Color3.new(0, 1, 0),
                            random = false,
                            width = 3
                        },
                        speed = 840,
                        armorDamage = 1003,
                        ricochetChance = 0,
                        damage = 1 -- Keep damage at 100 as it was working for killing
                    },
                    [8] = {
                        VPunchBase = 1,
                        BoltExtend = Vector3.new(0, 0, 0.4000000059604645),
                        BulletWhiz = true,
                        FocusOnSight = false,
                        Chambered = true,
                        ServerGunPos = CFrame.new(-0.30000001192092896, -1, -0.30000001192092896, -4.371138828673793e-08, 0, -1, 1, -4.371138828673793e-08, -4.371138828673793e-08, -4.371138828673793e-08, -1, 1.910685465164705e-15),
                        NewCameraMultiplier = 1,
                        CutOffGunshots = false,
                        ExpRadius = 25,
                        Mode = "Semi",
                        BurstFireRate = 900,
                        IncludeChamberedBullet = true,
                        CanJam = false,
                        ReloadType = 1,
                        Pitches = {
                            1,
                            1.12
                        },
                        MaxRecoilPower = 1,
                        BulletFlareColor = Color3.new(1, 0.40392157435417175, 0.32549020648002625),
                        LimbsDamage = {
                            30,
                            45
                        },
                        JamChance = 1000,
                        BulletPenetration = 60,
                        CanCheckMag = false,
                        BulletLight = false,
                        TracerLightInfluence = 0,
                        ServerBoltExtend = Vector3.new(0, 0, 0.4000000059604645),
                        TracerLifeTime = 0.05,
                        MaxSway = 1,
                        TracerLightEmission = 1,
                        RecoilPunch = 0.2,
                        BWMaxDistance = 200,
                        RightPos = CFrame.new(-0.6000000238418579, -0.10000000149011612, -0.949999988079071, 1, -0, 0, 0, -4.371138828673793e-08, 1, 0, -1, -4.371138828673793e-08),
                        BulletLightColor = Color3.new(1, 0.40392157435417175, 0.32549020648002625),
                        FireModes = {
                            Burst = false,
                            Semi = true,
                            Auto = true,
                            Smoke = false,
                            ChangeFiremode = true,
                            Explosive = false
                        },
                        AutoChamber = false,
                        BeltFed = false,
                        AllowPenetration = true,
                        ZoomAnim = false,
                        RandomTracer = false,
                        MinRecoilPower = -1,
                        MagCount = true,
                        TorsoDamage = {
                            75,
                            113
                        },
                        FocusOnSight2 = false,
                        BulletLightBrightness = 1,
                        OffsetSens = 0.1,
                        RainbowMode = false,
                        Name = "SA-58",
                        Ammo = 20,
                        AimRecoilReduction = 1.5,
                        BulletLightRange = 40,
                        CutOffDistance = true,
                        OffsetAngle = 5,
                        SlideLock = true,
                        BSpeed = 5000,
                        WalkMultiplier = 0.2,
                        DestroyJointRadiusPercent = 0,
                        LauncherDamage = 100,
                        Bullets = 1,
                        BWEmitter = 25,
                        FireRate = 750,
                        ExplosiveHit = false,
                        UGL = false,
                        SuppressTime = 1000000,
                        Tracer = true,
                        OldCamSway = true,
                        BulletType = "7.62x51mm",
                        LeftArmPos = CFrame.new(1.0499999523162842, 0.8999999761581421, -1.399999976158142, 0.8516507148742676, 0.3099755048751831, 0.4226182699203491, -0.33170679211616516, -0.30552393198013306, 0.8925389051437378, 0.4057852029800415, -0.9003167152404785, -0.15737870335578918),
                        TracerWidth = 7,
                        PenetrationDistance = 7,
                        BDrop = 0.1,
                        EnableHolster = false,
                        SlideExtend = Vector3.new(0, 0, 0.4000000059604645),
                        TracerChance = 70,
                        Distance = 20000,
                        FallOfDamage = 1,
                        TracerColor = Color3.new(1, 0.40392157435417175, 0.32549020648002625),
                        HolsterTo = "Torso",
                        ChangeFOV = {
                            25,
                            60
                        },
                        RightArmPos = CFrame.new(-0.8500000238418579, -0.20000000298023224, -1.2000000476837158, 1, -0, 0, 0, -4.371138828673793e-08, 1, 0, -1, -4.371138828673793e-08),
                        MinSpread = 0,
                        SpreadStepAmount = 1.5,
                        ModoTreino = false,
                        Thermal = false,
                        HRecoil = {
                            1,
                            10
                        },
                        SuppressMaxDistance = 10,
                        VRecoil = {
                            35,
                            70
                        },
                        AimRecover = 0.4,
                        LauncherRadius = 25,
                        GunType = 1,
                        BurstShot = 3,
                        LeftPos = CFrame.new(1.2000000476837158, 0.4000000059604645, -1.600000023841858, 0.7697511315345764, 0.28016647696495056, 0.5735764503479004, -0.29576510190963745, -0.6397386193275452, 0.7094064950942993, 0.5656908750534058, -0.7157102823257446, -0.40957608819007874),
                        RecoilPowerStepAmount = 0.1,
                        LauncherPressure = 500,
                        ExPressure = 500,
                        HeadDamage = {
                            1,
                            1
                        },
                        MaxSpread = 0.5,
                        LauncherDestroyJointRadiusPercent = 0,
                        FastReload = true,
                        ChamberWhileAim = false,
                        GunPos = CFrame.new(0.15000000596046448, -0.15000000596046448, 1, 1, 0, 0, 0, -4.371138828673793e-08, -1, 0, 1, -4.371138828673793e-08),
                        TracerEveryXShots = 5,
                        GunSize = 3.5,
                        HPunchBase = 0.5,
                        ServerSlideExtend = Vector3.new(0, 0, 0.4000000059604645),
                        LauncherReady = false,
                        MoveBolt = false,
                        ArcadeMode = false,
                        PunchRecover = 0.1,
                        BulletFlare = false,
                        SwayBase = 0,
                        HolsterPos = CFrame.new(0.25, -0.10000000149011612, -0.800000011920929, 0.6403416395187378, -0.7631294131278992, -0.08715573698282242, 0.7582467198371887, 0.6461606025695801, -0.08682408183813095, 0.12257461249828339, -0.010488472878932953, 0.9924039244651794),
                        OldRecoil = true,
                        GunFOVReduction = 3,
                        BoltLock = false,
                        DPunchBase = 1,
                        ExplosionDamage = 100
                    },
                    [9] = "canYouBypassThis???\226\128\142"
                }

                -- Attempt to fire the server with the faked arguments
                damageEvent:FireServer(unpack(args))
            end
        end
    end
end)




local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local damageEvent = ReplicatedStorage:WaitForChild("EngineShared"):WaitForChild("Events"):WaitForChild("damage")

-- Function to create the tool
local function createKillTool()
    local tool = Instance.new("Tool")
    tool.Name = "Damage - 65"
    tool.ToolTip = "Click to damage"
    tool.RequiresHandle = false -- Set to false so no physical handle is needed

    return tool
end

local killTool = createKillTool()
killTool.Parent = localPlayer.Backpack -- Give the tool to the player

local mouse = localPlayer:GetMouse()
local isToolEquipped = false

-- Event for when the tool is equipped
killTool.Equipped:Connect(function()
    isToolEquipped = true
    print("InvisibleKillerTool equipped!")
end)

-- Event for when the tool is unequipped
killTool.Unequipped:Connect(function()
    isToolEquipped = false
    print("InvisibleKillerTool unequipped.")
end)

-- Event for when the player clicks
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessedEvent and isToolEquipped then
        print("Mouse clicked with invisible tool equipped!")

        -- Perform a raycast from the mouse to find the hit target
        local target = mouse.Target -- This is the actual part that was clicked
        local targetHumanoid = nil
        local targetPart = nil -- This will store the specific limb/part that was clicked

        if target then
            local character = target.Parent
            -- Check if the clicked part's parent is a character and belongs to a player
            if character and Players:GetPlayerFromCharacter(character) and character:FindFirstChildOfClass("Humanoid") then
                targetHumanoid = character:FindFirstChildOfClass("Humanoid")
                targetPart = target -- Assign the actual clicked part to targetPart
            end
        end

        if targetHumanoid and targetPart and targetHumanoid.Health > 0 then
            local playerToKill = Players:GetPlayerFromCharacter(targetHumanoid.Parent)
            if playerToKill and playerToKill ~= localPlayer then -- Ensure it's another player
                print("Attempting to kill: " .. playerToKill.Name .. " by hitting " .. targetPart.Name)

                local args = {
                    [1] = targetHumanoid,
                    [2] = targetPart, -- Now dynamically the clicked part (Head, Arm, Leg, Torso, etc.)
                    [3] = CFrame.new(targetPart.Position), -- Use the clicked part's position for CFrame
                    [4] = targetPart.Position, -- Use the clicked part's position
                    [5] = targetPart.Position, -- Use the clicked part's position
                    [6] = 1.9375000000000004,
                    [7] = {
                        bulletLight = {
                            enabled = true,
                            brightness = 1,
                            lightRange = 10,
                            color = Color3.new(0, 1, 0)
                        },
                        lightBleedChance = 10000,
                        penPower = 1000,
                        width = 1,
                        fragmentChance = 0,
                        heavyBleedChance = 10000,
                        tracer = {
                            enabled = true,
                            everyXShots = 2,
                            lightInfluence = 0,
                            lightEmission = 1,
                            chance = 70,
                            color = Color3.new(0, 1, 0),
                            random = false,
                            width = 3
                        },
                        speed = 840,
                        armorDamage = 1003,
                        ricochetChance = 0,
                        damage = 65 -- Keep damage at 100 as it was working for killing
                    },
                    [8] = {
                        VPunchBase = 1,
                        BoltExtend = Vector3.new(0, 0, 0.4000000059604645),
                        BulletWhiz = true,
                        FocusOnSight = false,
                        Chambered = true,
                        ServerGunPos = CFrame.new(-0.30000001192092896, -1, -0.30000001192092896, -4.371138828673793e-08, 0, -1, 1, -4.371138828673793e-08, -4.371138828673793e-08, -4.371138828673793e-08, -1, 1.910685465164705e-15),
                        NewCameraMultiplier = 1,
                        CutOffGunshots = false,
                        ExpRadius = 25,
                        Mode = "Semi",
                        BurstFireRate = 900,
                        IncludeChamberedBullet = true,
                        CanJam = false,
                        ReloadType = 1,
                        Pitches = {
                            1,
                            1.12
                        },
                        MaxRecoilPower = 1,
                        BulletFlareColor = Color3.new(1, 0.40392157435417175, 0.32549020648002625),
                        LimbsDamage = {
                            30,
                            45
                        },
                        JamChance = 1000,
                        BulletPenetration = 60,
                        CanCheckMag = false,
                        BulletLight = false,
                        TracerLightInfluence = 0,
                        ServerBoltExtend = Vector3.new(0, 0, 0.4000000059604645),
                        TracerLifeTime = 0.05,
                        MaxSway = 1,
                        TracerLightEmission = 1,
                        RecoilPunch = 0.2,
                        BWMaxDistance = 200,
                        RightPos = CFrame.new(-0.6000000238418579, -0.10000000149011612, -0.949999988079071, 1, -0, 0, 0, -4.371138828673793e-08, 1, 0, -1, -4.371138828673793e-08),
                        BulletLightColor = Color3.new(1, 0.40392157435417175, 0.32549020648002625),
                        FireModes = {
                            Burst = false,
                            Semi = true,
                            Auto = true,
                            Smoke = false,
                            ChangeFiremode = true,
                            Explosive = false
                        },
                        AutoChamber = false,
                        BeltFed = false,
                        AllowPenetration = true,
                        ZoomAnim = false,
                        RandomTracer = false,
                        MinRecoilPower = -1,
                        MagCount = true,
                        TorsoDamage = {
                            75,
                            113
                        },
                        FocusOnSight2 = false,
                        BulletLightBrightness = 1,
                        OffsetSens = 0.1,
                        RainbowMode = false,
                        Name = "SA-58",
                        Ammo = 20,
                        AimRecoilReduction = 1.5,
                        BulletLightRange = 40,
                        CutOffDistance = true,
                        OffsetAngle = 5,
                        SlideLock = true,
                        BSpeed = 5000,
                        WalkMultiplier = 0.2,
                        DestroyJointRadiusPercent = 0,
                        LauncherDamage = 100,
                        Bullets = 1,
                        BWEmitter = 25,
                        FireRate = 750,
                        ExplosiveHit = false,
                        UGL = false,
                        SuppressTime = 1000000,
                        Tracer = true,
                        OldCamSway = true,
                        BulletType = "7.62x51mm",
                        LeftArmPos = CFrame.new(1.0499999523162842, 0.8999999761581421, -1.399999976158142, 0.8516507148742676, 0.3099755048751831, 0.4226182699203491, -0.33170679211616516, -0.30552393198013306, 0.8925389051437378, 0.4057852029800415, -0.9003167152404785, -0.15737870335578918),
                        TracerWidth = 7,
                        PenetrationDistance = 7,
                        BDrop = 0.1,
                        EnableHolster = false,
                        SlideExtend = Vector3.new(0, 0, 0.4000000059604645),
                        TracerChance = 70,
                        Distance = 20000,
                        FallOfDamage = 1,
                        TracerColor = Color3.new(1, 0.40392157435417175, 0.32549020648002625),
                        HolsterTo = "Torso",
                        ChangeFOV = {
                            25,
                            60
                        },
                        RightArmPos = CFrame.new(-0.8500000238418579, -0.20000000298023224, -1.2000000476837158, 1, -0, 0, 0, -4.371138828673793e-08, 1, 0, -1, -4.371138828673793e-08),
                        MinSpread = 0,
                        SpreadStepAmount = 1.5,
                        ModoTreino = false,
                        Thermal = false,
                        HRecoil = {
                            1,
                            10
                        },
                        SuppressMaxDistance = 10,
                        VRecoil = {
                            35,
                            70
                        },
                        AimRecover = 0.4,
                        LauncherRadius = 25,
                        GunType = 1,
                        BurstShot = 3,
                        LeftPos = CFrame.new(1.2000000476837158, 0.4000000059604645, -1.600000023841858, 0.7697511315345764, 0.28016647696495056, 0.5735764503479004, -0.29576510190963745, -0.6397386193275452, 0.7094064950942993, 0.5656908750534058, -0.7157102823257446, -0.40957608819007874),
                        RecoilPowerStepAmount = 0.1,
                        LauncherPressure = 500,
                        ExPressure = 500,
                        HeadDamage = {
                            1,
                            1
                        },
                        MaxSpread = 0.5,
                        LauncherDestroyJointRadiusPercent = 0,
                        FastReload = true,
                        ChamberWhileAim = false,
                        GunPos = CFrame.new(0.15000000596046448, -0.15000000596046448, 1, 1, 0, 0, 0, -4.371138828673793e-08, -1, 0, 1, -4.371138828673793e-08),
                        TracerEveryXShots = 5,
                        GunSize = 3.5,
                        HPunchBase = 0.5,
                        ServerSlideExtend = Vector3.new(0, 0, 0.4000000059604645),
                        LauncherReady = false,
                        MoveBolt = false,
                        ArcadeMode = false,
                        PunchRecover = 0.1,
                        BulletFlare = false,
                        SwayBase = 0,
                        HolsterPos = CFrame.new(0.25, -0.10000000149011612, -0.800000011920929, 0.6403416395187378, -0.7631294131278992, -0.08715573698282242, 0.7582467198371887, 0.6461606025695801, -0.08682408183813095, 0.12257461249828339, -0.010488472878932953, 0.9924039244651794),
                        OldRecoil = true,
                        GunFOVReduction = 3,
                        BoltLock = false,
                        DPunchBase = 1,
                        ExplosionDamage = 100
                    },
                    [9] = "canYouBypassThis???\226\128\142"
                }

                -- Attempt to fire the server with the faked arguments
                damageEvent:FireServer(unpack(args))
            end
        end
    end
end)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local damageEvent = ReplicatedStorage:WaitForChild("EngineShared"):WaitForChild("Events"):WaitForChild("damage")

-- Function to create the tool
local function createKillTool()
    local tool = Instance.new("Tool")
    tool.Name = "Damage - 150"
    tool.ToolTip = "Click to damage"
    tool.RequiresHandle = false -- Set to false so no physical handle is needed

    return tool
end

local killTool = createKillTool()
killTool.Parent = localPlayer.Backpack -- Give the tool to the player

local mouse = localPlayer:GetMouse()
local isToolEquipped = false

-- Event for when the tool is equipped
killTool.Equipped:Connect(function()
    isToolEquipped = true
    print("InvisibleKillerTool equipped!")
end)

-- Event for when the tool is unequipped
killTool.Unequipped:Connect(function()
    isToolEquipped = false
    print("InvisibleKillerTool unequipped.")
end)

-- Event for when the player clicks
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessedEvent and isToolEquipped then
        print("Mouse clicked with invisible tool equipped!")

        -- Perform a raycast from the mouse to find the hit target
        local target = mouse.Target -- This is the actual part that was clicked
        local targetHumanoid = nil
        local targetPart = nil -- This will store the specific limb/part that was clicked

        if target then
            local character = target.Parent
            -- Check if the clicked part's parent is a character and belongs to a player
            if character and Players:GetPlayerFromCharacter(character) and character:FindFirstChildOfClass("Humanoid") then
                targetHumanoid = character:FindFirstChildOfClass("Humanoid")
                targetPart = target -- Assign the actual clicked part to targetPart
            end
        end

        if targetHumanoid and targetPart and targetHumanoid.Health > 0 then
            local playerToKill = Players:GetPlayerFromCharacter(targetHumanoid.Parent)
            if playerToKill and playerToKill ~= localPlayer then -- Ensure it's another player
                print("Attempting to kill: " .. playerToKill.Name .. " by hitting " .. targetPart.Name)

                local args = {
                    [1] = targetHumanoid,
                    [2] = targetPart, -- Now dynamically the clicked part (Head, Arm, Leg, Torso, etc.)
                    [3] = CFrame.new(targetPart.Position), -- Use the clicked part's position for CFrame
                    [4] = targetPart.Position, -- Use the clicked part's position
                    [5] = targetPart.Position, -- Use the clicked part's position
                    [6] = 1.9375000000000004,
                    [7] = {
                        bulletLight = {
                            enabled = true,
                            brightness = 1,
                            lightRange = 10,
                            color = Color3.new(0, 1, 0)
                        },
                        lightBleedChance = 0000,
                        penPower = 1000,
                        width = 1,
                        fragmentChance = 0,
                        heavyBleedChance = 0000,
                        tracer = {
                            enabled = true,
                            everyXShots = 2,
                            lightInfluence = 0,
                            lightEmission = 1,
                            chance = 70,
                            color = Color3.new(0, 1, 0),
                            random = false,
                            width = 3
                        },
                        speed = 840,
                        armorDamage = 1003,
                        ricochetChance = 0,
                        damage = 150 -- Keep damage at 100 as it was working for killing
                    },
                    [8] = {
                        VPunchBase = 1,
                        BoltExtend = Vector3.new(0, 0, 0.4000000059604645),
                        BulletWhiz = true,
                        FocusOnSight = false,
                        Chambered = true,
                        ServerGunPos = CFrame.new(-0.30000001192092896, -1, -0.30000001192092896, -4.371138828673793e-08, 0, -1, 1, -4.371138828673793e-08, -4.371138828673793e-08, -4.371138828673793e-08, -1, 1.910685465164705e-15),
                        NewCameraMultiplier = 1,
                        CutOffGunshots = false,
                        ExpRadius = 25,
                        Mode = "Semi",
                        BurstFireRate = 900,
                        IncludeChamberedBullet = true,
                        CanJam = false,
                        ReloadType = 1,
                        Pitches = {
                            1,
                            1.12
                        },
                        MaxRecoilPower = 1,
                        BulletFlareColor = Color3.new(1, 0.40392157435417175, 0.32549020648002625),
                        LimbsDamage = {
                            30,
                            45
                        },
                        JamChance = 1000,
                        BulletPenetration = 60,
                        CanCheckMag = false,
                        BulletLight = false,
                        TracerLightInfluence = 0,
                        ServerBoltExtend = Vector3.new(0, 0, 0.4000000059604645),
                        TracerLifeTime = 0.05,
                        MaxSway = 1,
                        TracerLightEmission = 1,
                        RecoilPunch = 0.2,
                        BWMaxDistance = 200,
                        RightPos = CFrame.new(-0.6000000238418579, -0.10000000149011612, -0.949999988079071, 1, -0, 0, 0, -4.371138828673793e-08, 1, 0, -1, -4.371138828673793e-08),
                        BulletLightColor = Color3.new(1, 0.40392157435417175, 0.32549020648002625),
                        FireModes = {
                            Burst = false,
                            Semi = true,
                            Auto = true,
                            Smoke = false,
                            ChangeFiremode = true,
                            Explosive = false
                        },
                        AutoChamber = false,
                        BeltFed = false,
                        AllowPenetration = true,
                        ZoomAnim = false,
                        RandomTracer = false,
                        MinRecoilPower = -1,
                        MagCount = true,
                        TorsoDamage = {
                            75,
                            113
                        },
                        FocusOnSight2 = false,
                        BulletLightBrightness = 1,
                        OffsetSens = 0.1,
                        RainbowMode = false,
                        Name = "SA-58",
                        Ammo = 20,
                        AimRecoilReduction = 1.5,
                        BulletLightRange = 40,
                        CutOffDistance = true,
                        OffsetAngle = 5,
                        SlideLock = true,
                        BSpeed = 5000,
                        WalkMultiplier = 0.2,
                        DestroyJointRadiusPercent = 0,
                        LauncherDamage = 100,
                        Bullets = 1,
                        BWEmitter = 25,
                        FireRate = 750,
                        ExplosiveHit = false,
                        UGL = false,
                        SuppressTime = 1000000,
                        Tracer = true,
                        OldCamSway = true,
                        BulletType = "7.62x51mm",
                        LeftArmPos = CFrame.new(1.0499999523162842, 0.8999999761581421, -1.399999976158142, 0.8516507148742676, 0.3099755048751831, 0.4226182699203491, -0.33170679211616516, -0.30552393198013306, 0.8925389051437378, 0.4057852029800415, -0.9003167152404785, -0.15737870335578918),
                        TracerWidth = 7,
                        PenetrationDistance = 7,
                        BDrop = 0.1,
                        EnableHolster = false,
                        SlideExtend = Vector3.new(0, 0, 0.4000000059604645),
                        TracerChance = 70,
                        Distance = 20000,
                        FallOfDamage = 1,
                        TracerColor = Color3.new(1, 0.40392157435417175, 0.32549020648002625),
                        HolsterTo = "Torso",
                        ChangeFOV = {
                            25,
                            60
                        },
                        RightArmPos = CFrame.new(-0.8500000238418579, -0.20000000298023224, -1.2000000476837158, 1, -0, 0, 0, -4.371138828673793e-08, 1, 0, -1, -4.371138828673793e-08),
                        MinSpread = 0,
                        SpreadStepAmount = 1.5,
                        ModoTreino = false,
                        Thermal = false,
                        HRecoil = {
                            1,
                            10
                        },
                        SuppressMaxDistance = 10,
                        VRecoil = {
                            35,
                            70
                        },
                        AimRecover = 0.4,
                        LauncherRadius = 25,
                        GunType = 1,
                        BurstShot = 3,
                        LeftPos = CFrame.new(1.2000000476837158, 0.4000000059604645, -1.600000023841858, 0.7697511315345764, 0.28016647696495056, 0.5735764503479004, -0.29576510190963745, -0.6397386193275452, 0.7094064950942993, 0.5656908750534058, -0.7157102823257446, -0.40957608819007874),
                        RecoilPowerStepAmount = 0.1,
                        LauncherPressure = 500,
                        ExPressure = 500,
                        HeadDamage = {
                            1,
                            1
                        },
                        MaxSpread = 0.5,
                        LauncherDestroyJointRadiusPercent = 0,
                        FastReload = true,
                        ChamberWhileAim = false,
                        GunPos = CFrame.new(0.15000000596046448, -0.15000000596046448, 1, 1, 0, 0, 0, -4.371138828673793e-08, -1, 0, 1, -4.371138828673793e-08),
                        TracerEveryXShots = 5,
                        GunSize = 3.5,
                        HPunchBase = 0.5,
                        ServerSlideExtend = Vector3.new(0, 0, 0.4000000059604645),
                        LauncherReady = false,
                        MoveBolt = false,
                        ArcadeMode = false,
                        PunchRecover = 0.1,
                        BulletFlare = false,
                        SwayBase = 0,
                        HolsterPos = CFrame.new(0.25, -0.10000000149011612, -0.800000011920929, 0.6403416395187378, -0.7631294131278992, -0.08715573698282242, 0.7582467198371887, 0.6461606025695801, -0.08682408183813095, 0.12257461249828339, -0.010488472878932953, 0.9924039244651794),
                        OldRecoil = true,
                        GunFOVReduction = 3,
                        BoltLock = false,
                        DPunchBase = 1,
                        ExplosionDamage = 100
                    },
                    [9] = "canYouBypassThis???\226\128\142"
                }

                -- Attempt to fire the server with the faked arguments
                damageEvent:FireServer(unpack(args))
            end
        end
    end
end)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local damageEvent = ReplicatedStorage:WaitForChild("EngineShared"):WaitForChild("Events"):WaitForChild("damage")

-- Function to create the tool
local function createKillTool()
    local tool = Instance.new("Tool")
    tool.Name = "Kill tool"
    tool.ToolTip = "Click to kill a player"
    tool.RequiresHandle = false -- Set to false so no physical handle is needed

    return tool
end

local killTool = createKillTool()
killTool.Parent = localPlayer.Backpack -- Give the tool to the player

local mouse = localPlayer:GetMouse()
local isToolEquipped = false

-- Event for when the tool is equipped
killTool.Equipped:Connect(function()
    isToolEquipped = true
    print("InvisibleKillerTool equipped!")
end)

-- Event for when the tool is unequipped
killTool.Unequipped:Connect(function()
    isToolEquipped = false
    print("InvisibleKillerTool unequipped.")
end)

-- Event for when the player clicks
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessedEvent and isToolEquipped then
        print("Mouse clicked with invisible tool equipped!")

        -- Perform a raycast from the mouse to find the hit target
        local target = mouse.Target -- This is the actual part that was clicked
        local targetHumanoid = nil
        local targetPart = nil -- This will store the specific limb/part that was clicked

        if target then
            local character = target.Parent
            -- Check if the clicked part's parent is a character and belongs to a player
            if character and Players:GetPlayerFromCharacter(character) and character:FindFirstChildOfClass("Humanoid") then
                targetHumanoid = character:FindFirstChildOfClass("Humanoid")
                targetPart = target -- Assign the actual clicked part to targetPart
            end
        end

        if targetHumanoid and targetPart and targetHumanoid.Health > 0 then
            local playerToKill = Players:GetPlayerFromCharacter(targetHumanoid.Parent)
            if playerToKill and playerToKill ~= localPlayer then -- Ensure it's another player
                print("Attempting to kill: " .. playerToKill.Name .. " by hitting " .. targetPart.Name)

                local args = {
                    [1] = targetHumanoid,
                    [2] = targetPart, -- Now dynamically the clicked part (Head, Arm, Leg, Torso, etc.)
                    [3] = CFrame.new(targetPart.Position), -- Use the clicked part's position for CFrame
                    [4] = targetPart.Position, -- Use the clicked part's position
                    [5] = targetPart.Position, -- Use the clicked part's position
                    [6] = 1.9375000000000004,
                    [7] = {
                        bulletLight = {
                            enabled = true,
                            brightness = 1,
                            lightRange = 10,
                            color = Color3.new(0, 1, 0)
                        },
                        lightBleedChance = 0000,
                        penPower = 1000,
                        width = 1,
                        fragmentChance = 0,
                        heavyBleedChance = 0000,
                        tracer = {
                            enabled = true,
                            everyXShots = 2,
                            lightInfluence = 0,
                            lightEmission = 1,
                            chance = 70,
                            color = Color3.new(0, 1, 0),
                            random = false,
                            width = 3
                        },
                        speed = 840,
                        armorDamage = 1003,
                        ricochetChance = 0,
                        damage = 153453454554353450 -- Keep damage at 100 as it was working for killing
                    },
                    [8] = {
                        VPunchBase = 1,
                        BoltExtend = Vector3.new(0, 0, 0.4000000059604645),
                        BulletWhiz = true,
                        FocusOnSight = false,
                        Chambered = true,
                        ServerGunPos = CFrame.new(-0.30000001192092896, -1, -0.30000001192092896, -4.371138828673793e-08, 0, -1, 1, -4.371138828673793e-08, -4.371138828673793e-08, -4.371138828673793e-08, -1, 1.910685465164705e-15),
                        NewCameraMultiplier = 1,
                        CutOffGunshots = false,
                        ExpRadius = 25,
                        Mode = "Semi",
                        BurstFireRate = 900,
                        IncludeChamberedBullet = true,
                        CanJam = false,
                        ReloadType = 1,
                        Pitches = {
                            1,
                            1.12
                        },
                        MaxRecoilPower = 1,
                        BulletFlareColor = Color3.new(1, 0.40392157435417175, 0.32549020648002625),
                        LimbsDamage = {
                            30,
                            45
                        },
                        JamChance = 1000,
                        BulletPenetration = 60,
                        CanCheckMag = false,
                        BulletLight = false,
                        TracerLightInfluence = 0,
                        ServerBoltExtend = Vector3.new(0, 0, 0.4000000059604645),
                        TracerLifeTime = 0.05,
                        MaxSway = 1,
                        TracerLightEmission = 1,
                        RecoilPunch = 0.2,
                        BWMaxDistance = 200,
                        RightPos = CFrame.new(-0.6000000238418579, -0.10000000149011612, -0.949999988079071, 1, -0, 0, 0, -4.371138828673793e-08, 1, 0, -1, -4.371138828673793e-08),
                        BulletLightColor = Color3.new(1, 0.40392157435417175, 0.32549020648002625),
                        FireModes = {
                            Burst = false,
                            Semi = true,
                            Auto = true,
                            Smoke = false,
                            ChangeFiremode = true,
                            Explosive = false
                        },
                        AutoChamber = false,
                        BeltFed = false,
                        AllowPenetration = true,
                        ZoomAnim = false,
                        RandomTracer = false,
                        MinRecoilPower = -1,
                        MagCount = true,
                        TorsoDamage = {
                            75,
                            113
                        },
                        FocusOnSight2 = false,
                        BulletLightBrightness = 1,
                        OffsetSens = 0.1,
                        RainbowMode = false,
                        Name = "SA-58",
                        Ammo = 20,
                        AimRecoilReduction = 1.5,
                        BulletLightRange = 40,
                        CutOffDistance = true,
                        OffsetAngle = 5,
                        SlideLock = true,
                        BSpeed = 5000,
                        WalkMultiplier = 0.2,
                        DestroyJointRadiusPercent = 0,
                        LauncherDamage = 100,
                        Bullets = 1,
                        BWEmitter = 25,
                        FireRate = 750,
                        ExplosiveHit = false,
                        UGL = false,
                        SuppressTime = 1000000,
                        Tracer = true,
                        OldCamSway = true,
                        BulletType = "7.62x51mm",
                        LeftArmPos = CFrame.new(1.0499999523162842, 0.8999999761581421, -1.399999976158142, 0.8516507148742676, 0.3099755048751831, 0.4226182699203491, -0.33170679211616516, -0.30552393198013306, 0.8925389051437378, 0.4057852029800415, -0.9003167152404785, -0.15737870335578918),
                        TracerWidth = 7,
                        PenetrationDistance = 7,
                        BDrop = 0.1,
                        EnableHolster = false,
                        SlideExtend = Vector3.new(0, 0, 0.4000000059604645),
                        TracerChance = 70,
                        Distance = 20000,
                        FallOfDamage = 1,
                        TracerColor = Color3.new(1, 0.40392157435417175, 0.32549020648002625),
                        HolsterTo = "Torso",
                        ChangeFOV = {
                            25,
                            60
                        },
                        RightArmPos = CFrame.new(-0.8500000238418579, -0.20000000298023224, -1.2000000476837158, 1, -0, 0, 0, -4.371138828673793e-08, 1, 0, -1, -4.371138828673793e-08),
                        MinSpread = 0,
                        SpreadStepAmount = 1.5,
                        ModoTreino = false,
                        Thermal = false,
                        HRecoil = {
                            1,
                            10
                        },
                        SuppressMaxDistance = 10,
                        VRecoil = {
                            35,
                            70
                        },
                        AimRecover = 0.4,
                        LauncherRadius = 25,
                        GunType = 1,
                        BurstShot = 3,
                        LeftPos = CFrame.new(1.2000000476837158, 0.4000000059604645, -1.600000023841858, 0.7697511315345764, 0.28016647696495056, 0.5735764503479004, -0.29576510190963745, -0.6397386193275452, 0.7094064950942993, 0.5656908750534058, -0.7157102823257446, -0.40957608819007874),
                        RecoilPowerStepAmount = 0.1,
                        LauncherPressure = 500,
                        ExPressure = 500,
                        HeadDamage = {
                            1,
                            1
                        },
                        MaxSpread = 0.5,
                        LauncherDestroyJointRadiusPercent = 0,
                        FastReload = true,
                        ChamberWhileAim = false,
                        GunPos = CFrame.new(0.15000000596046448, -0.15000000596046448, 1, 1, 0, 0, 0, -4.371138828673793e-08, -1, 0, 1, -4.371138828673793e-08),
                        TracerEveryXShots = 5,
                        GunSize = 3.5,
                        HPunchBase = 0.5,
                        ServerSlideExtend = Vector3.new(0, 0, 0.4000000059604645),
                        LauncherReady = false,
                        MoveBolt = false,
                        ArcadeMode = false,
                        PunchRecover = 0.1,
                        BulletFlare = false,
                        SwayBase = 0,
                        HolsterPos = CFrame.new(0.25, -0.10000000149011612, -0.800000011920929, 0.6403416395187378, -0.7631294131278992, -0.08715573698282242, 0.7582467198371887, 0.6461606025695801, -0.08682408183813095, 0.12257461249828339, -0.010488472878932953, 0.9924039244651794),
                        OldRecoil = true,
                        GunFOVReduction = 3,
                        BoltLock = false,
                        DPunchBase = 1,
                        ExplosionDamage = 100
                    },
                    [9] = "canYouBypassThis???\226\128\142"
                }

                -- Attempt to fire the server with the faked arguments
                damageEvent:FireServer(unpack(args))
            end
        end
    end
end)
