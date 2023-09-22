--████████╗██╗███████╗██████╗░░░███╗░░░░░░░██╗░█████╗░░██████╗██╗░░██╗  
--╚══██╔══╝██║██╔════╝██╔══██╗░████║░░░░░░░██║██╔══██╗██╔════╝██║░░██║  
--░░░██║░░░██║█████╗░░██████╔╝██╔██║░░░░░░░██║██║░░██║╚█████╗░███████║  
--░░░██║░░░██║██╔══╝░░██╔══██╗╚═╝██║░░██╗░░██║██║░░██║░╚═══██╗██╔══██║  
--░░░██║░░░██║███████╗██║░░██║███████╗╚█████╔╝╚█████╔╝██████╔╝██║░░██║  
--░░░╚═╝░░░╚═╝╚══════╝╚═╝░░╚═╝╚══════╝░╚════╝░░╚════╝░╚═════╝░╚═╝░░╚═╝  
--██████╗░██╗░░░██╗███╗░░██╗░██████╗  ██╗░░░██╗░█████╗░██╗░░░██╗██╗
--██╔══██╗██║░░░██║████╗░██║██╔════╝  ╚██╗░██╔╝██╔══██╗██║░░░██║██║
--██████╔╝██║░░░██║██╔██╗██║╚█████╗░  ░╚████╔╝░██║░░██║██║░░░██║██║
--██╔══██╗██║░░░██║██║╚████║░╚═══██╗  ░░╚██╔╝░░██║░░██║██║░░░██║╚═╝
--██║░░██║╚██████╔╝██║░╚███║██████╔╝  ░░░██║░░░╚█████╔╝╚██████╔╝██╗
--╚═╝░░╚═╝░╚═════╝░╚═╝░░╚══╝╚═════╝░  ░░░╚═╝░░░░╚════╝░░╚═════╝░╚═╝

setfpscap(10000)

loadstring(game:HttpGet("https://raw.githubusercontent.com/tier1joshh/ChatSpy/main/ChatSpy"))()

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/tier1joshh/gui-/main/gui%20tier1josh", true))()
--Library.theme.accentcolor = Color3.new(20, 79, 13)--
local Window = Library:CreateWindow("0Comp | tier1josh", Vector2.new(492, 598), Enum.KeyCode.Z)
game.StarterGui:SetCore("SendNotification", {
    Title = "0Comp | tier1josh";
    Text = "Loading...";
    Icon = "";
    Duration = "10";
    callbakc = bindableFunction;
    Button1 = "Okay!";
})
wait(3)

local Aiming = loadstring(game:HttpGet(('https://raw.githubusercontent.com/tier1joshh/silentaim-2.0s/main/2.0%20silent%20aim%20tier1josh'),true))()
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/tier1joshh/tier1esp2.0/main/tier1joshesp2.0"))()
ESP:Toggle(false)
ESP.Tracers = false
ESP.Names = false
ESP.Boxes = false
Aiming.TeamCheck(false)
Aiming.VisibleCheck = true

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CurrentCamera = Workspace.CurrentCamera

local HoodsenseSettings = {
    Blatant = {
        Movement = {
            SpeedEnabled = false,
            SpeedType = "Default",
            SpeedRender = "Default",
            SpeedAmount = 5
        },
        Cash = {
            AutoDrop = false,
            AutoDropAmount = 5000,
            AutoPickCash = false
        },
        Character = {
            AntiBag = false,
        },
    },
}

local AimingTab = Window:CreateTab("Main")
local SilentSection = AimingTab:CreateSector("Aim Configuration", "left")

local DaHoodSettings = {
    SilentAim = false,
    AimLock = false,
    Prediction = 0.178
}

local SilentAimToggle = SilentSection:AddToggle("Silent Aim", nil, function(bool)
    DaHoodSettings.SilentAim = bool
end)
SilentAimToggle:AddKeybind()

local PredictLagToggle = SilentSection:AddToggle("Predict Lag", nil, function(bool)
    DaHoodSettings.Prediction.Lag = bool
end)

local FovCircleToggle = SilentSection:AddToggle("FOV Circle", nil, function(bool)
    Aiming.ShowFOV = bool
end)

local VisibleCheckToggle = SilentSection:AddToggle("Visible Check", nil, function(bool)
    Aiming.VisibleCheck = bool
end)

local HitAirShootsToggle = SilentSection:AddToggle("Hit Airshots", nil, function(bool)
    Aiming.Airshots = true
end)

local fovsettings = AimingTab:CreateSector("Fov Configuration", "right")

local HitChanceSlider = fovsettings:AddSlider("Silent Aim Hitchance", 0, 100, 400, 1, function(value)
    DaHoodSettings.Prediction = tonumer("0." .. value)
end)

local fovsize = fovsettings:AddSlider("Silent Aim Size", 0, 30, 500, 1, function(value)
    Aiming.FOV = value
end)

local fovsides = fovsettings:AddSlider("Fov Circle Sides", 1, 40, 40, 1, function(value)
    Aiming.FOVSides  = value
end)
-------------------------------
-----// AIMING FUNCTION -----
function Aiming.Check()
    if not (Aiming.Enabled == true and Aiming.Selected ~= LocalPlayer and Aiming.SelectedPart ~= nil) then
        return false
    end
 
    local Character = Aiming.Character(Aiming.Selected)
    local KOd = Character:WaitForChild("BodyEffects")["K.O"].Value
    local Grabbed = Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil
 
    if (KOd or Grabbed) then
        return false
    end
 
    return true
end
local __index
__index = hookmetamethod(game, "__index", function(t, k)
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target") and Aiming.Check()) then
        local SelectedPart = Aiming.SelectedPart
        if (DaHoodSettings.SilentAim and (k == "Hit" or k == "Target")) then
            local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings.Prediction)
 
            return (k == "Hit" and Hit or SelectedPart)
        end
    end
 
    return __index(t, k)
end)
 
local LMFAO = false
 
UserInputService.InputBegan:Connect(function(Key, Is)
    if Key.UserInputType == Enum.UserInputType.MouseButton2 and not Is then
        LMFAO = true
    end
end)
 
UserInputService.InputEnded:Connect(function(Key, Is)
    if Key.UserInputType == Enum.UserInputType.MouseButton2 and not Is then
        LMFAO = false
    end
end)


local aimlock = AimingTab:CreateSector("Aimlock", "left")
local aimlocktoggle = aimlock:AddToggle("Aimlock",  nil, function()
getgenv().AimPart = "HumanoidRootPart"
getgenv().AimlockKey = ""
getgenv().AimRadius = 30
getgenv().ThirdPerson = true
getgenv().FirstPerson = true
getgenv().TeamCheck = false
getgenv().PredictMovement = true
getgenv().PredictionVelocity = 9
local L_27_, L_28_, L_29_, L_30_ =
    game:GetService "Players",
game:GetService "UserInputService",
game:GetService "RunService",
game:GetService "StarterGui"
local L_31_, L_32_, L_33_, L_34_, L_35_, L_36_, L_37_ =
    L_27_.LocalPlayer,
L_27_.LocalPlayer:GetMouse(),
workspace.CurrentCamera,
CFrame.new,
Ray.new,
Vector3.new,
Vector2.new
local L_38_, L_39_, L_40_ = true, false, false
local L_41_
getgenv().CiazwareUniversalAimbotLoaded = true
getgenv().WorldToViewportPoint = function(L_42_arg0)
    return L_33_:WorldToViewportPoint(L_42_arg0)
end
getgenv().WorldToScreenPoint = function(L_43_arg0)
    return L_33_.WorldToScreenPoint(L_33_, L_43_arg0)
end
getgenv().GetObscuringObjects = function(L_44_arg0)
    if L_44_arg0 and L_44_arg0:FindFirstChild(getgenv().AimPart) and L_31_ and L_31_.Character:FindFirstChild("Head") then
        local L_45_ = workspace:FindPartOnRay(L_35_(L_44_arg0[getgenv().AimPart].Position, L_31_.Character.Head.Position))
        if L_45_ then
            return L_45_:IsDescendantOf(L_44_arg0)
        end
    end
end
getgenv().GetNearestTarget = function()
    local L_46_ = {}
    local L_47_ = {}
    local L_48_ = {}
    for L_50_forvar0, L_51_forvar1 in pairs(L_27_:GetPlayers()) do
        if L_51_forvar1 ~= L_31_ then
            table.insert(L_46_, L_51_forvar1)
        end
    end
    for L_52_forvar0, L_53_forvar1 in pairs(L_46_) do
        if L_53_forvar1.Character ~= nil then
            local L_54_ = L_53_forvar1.Character:FindFirstChild("Head")
            if getgenv().TeamCheck == true and L_53_forvar1.Team ~= L_31_.Team then
                local L_55_ =
                    (L_53_forvar1.Character:FindFirstChild("Head").Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
                local L_56_ =
                    Ray.new(
                        game.Workspace.CurrentCamera.CFrame.p,
                        (L_32_.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * L_55_
                    )
                local L_57_, L_58_ = game.Workspace:FindPartOnRay(L_56_, game.Workspace)
                local L_59_ = math.floor((L_58_ - L_54_.Position).magnitude)
                L_47_[L_53_forvar1.Name .. L_52_forvar0] = {}
                L_47_[L_53_forvar1.Name .. L_52_forvar0].dist = L_55_
                L_47_[L_53_forvar1.Name .. L_52_forvar0].plr = L_53_forvar1
                L_47_[L_53_forvar1.Name .. L_52_forvar0].diff = L_59_
                table.insert(L_48_, L_59_)
            elseif getgenv().TeamCheck == false and L_53_forvar1.Team == L_31_.Team then
                local L_60_ =
                    (L_53_forvar1.Character:FindFirstChild("Head").Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
                local L_61_ =
                    Ray.new(
                        game.Workspace.CurrentCamera.CFrame.p,
                        (L_32_.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * L_60_
                    )
                local L_62_, L_63_ = game.Workspace:FindPartOnRay(L_61_, game.Workspace)
                local L_64_ = math.floor((L_63_ - L_54_.Position).magnitude)
                L_47_[L_53_forvar1.Name .. L_52_forvar0] = {}
                L_47_[L_53_forvar1.Name .. L_52_forvar0].dist = L_60_
                L_47_[L_53_forvar1.Name .. L_52_forvar0].plr = L_53_forvar1
                L_47_[L_53_forvar1.Name .. L_52_forvar0].diff = L_64_
                table.insert(L_48_, L_64_)
            end
        end
    end
    if unpack(L_48_) == nil then
        return nil
    end
    local L_49_ = math.floor(math.min(unpack(L_48_)))
    if L_49_ > getgenv().AimRadius then
        return nil
    end
    for L_65_forvar0, L_66_forvar1 in pairs(L_47_) do
        if L_66_forvar1.diff == L_49_ then
            return L_66_forvar1.plr
        end
    end
    return nil
end
L_32_.KeyDown:Connect(
    function(L_67_arg0)
        if L_67_arg0 == AimlockKey and L_41_ == nil then
            pcall(
                function()
                    if L_39_ ~= true then
                        L_39_ = true
                    end
                    local L_68_
                    L_68_ = GetNearestTarget()
                    if L_68_ ~= nil then
                        L_41_ = L_68_
                    end
                end
            )
        elseif L_67_arg0 == AimlockKey and L_41_ ~= nil then
            if L_41_ ~= nil then
                L_41_ = nil
            end
            if L_39_ ~= false then
                L_39_ = false
            end
        end
    end
)
L_29_.RenderStepped:Connect(
    function()
        if getgenv().ThirdPerson == true and getgenv().FirstPerson == true then
            if
                (L_33_.Focus.p - L_33_.CoordinateFrame.p).Magnitude > 1 or
                (L_33_.Focus.p - L_33_.CoordinateFrame.p).Magnitude <= 1
            then
                L_40_ = true
            else
                L_40_ = false
            end
        elseif getgenv().ThirdPerson == true and getgenv().FirstPerson == false then
            if (L_33_.Focus.p - L_33_.CoordinateFrame.p).Magnitude > 1 then
                L_40_ = true
            else
                L_40_ = false
            end
        elseif getgenv().ThirdPerson == false and getgenv().FirstPerson == true then
            if (L_33_.Focus.p - L_33_.CoordinateFrame.p).Magnitude <= 1 then
                L_40_ = true
            else
                L_40_ = false
            end
        end
        if L_38_ == true and L_39_ == true then
            if L_41_ and L_41_.Character and L_41_.Character:FindFirstChild(getgenv().AimPart) then
                if getgenv().FirstPerson == true then
                    if L_40_ == true then
                        if getgenv().PredictMovement == true then
                            L_33_.CFrame =
                                L_34_(
                                    L_33_.CFrame.p,
                                    L_41_.Character[getgenv().AimPart].Position +
                                    L_41_.Character[getgenv().AimPart].Velocity / PredictionVelocity
                                )
                        elseif getgenv().PredictMovement == false then
                            L_33_.CFrame = L_34_(L_33_.CFrame.p, L_41_.Character[getgenv().AimPart].Position)
                        end
                    end
                elseif getgenv().ThirdPerson == true then
                    if L_40_ == true then
                        if getgenv().PredictMovement == true then
                            L_33_.CFrame =
                                L_34_(
                                    L_33_.CFrame.p,
                                    L_41_.Character[getgenv().AimPart].Position +
                                    L_41_.Character[getgenv().AimPart].Velocity / PredictionVelocity
                                )
                        elseif getgenv().PredictMovement == false then
                            L_33_.CFrame = L_34_(L_33_.CFrame.p, L_41_.Character[getgenv().AimPart].Position)
                        end
                    end
                end
            end
        end
    end
)
end
)

aimlock:AddTextbox("Aimlock Key", nil, function(L_69_arg0)
		getgenv().AimlockKey = L_69_arg0
end)

aimlock:AddTextbox("Aimlock Prediction", nil, function(L_70_arg0)
    PredictionVelocity = L_70_arg0
end)

aimlock:AddDropdown("Aim Part", {"Head", "UpperTorso", "HumanoidRootPart", "LowerTorso"}, "Head", false, function(L_71_arg0)
    getgenv().AimPart = L_71_arg0
end)


local TeleportsTab = Window:CreateTab("Teleports")
local gunssection = TeleportsTab:CreateSector("Guns", "left")

local revolver = gunssection:AddButton("Revolver", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-638.75, 18.8500004, -118.175011, -1, 0, 0, 0, 1, 0, 0, 0, -1)
end)

local ak = gunssection:AddButton("Ak", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-587.529358, 5.39480686, -753.717712, -1, 0, 0, 0, 1, 0, 0, 0, -1)
end)

local smg = gunssection:AddButton("Smg", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-577.123413, 5.47666788, -718.031433, -1, 0, 0, 0, 1, 0, 0, 0, -1)
end)

local ar = gunssection:AddButton("AR", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-591.824158, 5.46046877, -744.731628, 0, 0, 1, 0, 1, -0, -1, 0, 0)
end)

local dbs = gunssection:AddButton("Double Barrel", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1039.59985, 18.8513641, -256.449951, -1, 0, 0, 0, 1, 0, 0, 0, -1)
end)

local shotgun = gunssection:AddButton("Shotgun", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-578.623657, 5.47212696, -725.131531, 0, 0, 1, 0, 1, -0, -1, 0, 0)
end)

local flame = gunssection:AddButton("Flame Thrower", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-157.122437, 50.9120102, -104.93145, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end)

local tac = gunssection:AddButton("Tactical Shotgun", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(470.877533, 45.1272316, -620.630676, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end)

local rpg = gunssection:AddButton("Rpg", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(118.664856, -29.6487694, -272.349792, -1, 0, 0, 0, 1, 0, 0, 0, -1)
end)

local drumgun = gunssection:AddButton("Drum Gun", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-83.548996, 19.7020588, -82.1449585, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end)

local armor = gunssection:AddButton("High Medium Armor", function(bool)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-939, -25, 571)
end)

local bat = gunssection:AddButton("Bat", function(bool)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(380, 49, -283)
end)

local mediumarmor = gunssection:AddButton("Medium Armor", function(bool)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(528, 50, -637)
end)

local placessection = TeleportsTab:CreateSector("Places", "right")

local church = placessection:AddButton("Church", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(147.299988, 18.8493252, 31.7999744, 0, 0, 1, 0, 1, -0, -1, 0, 0)
end)

local admin1 = placessection:AddButton("Admin Base", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-872.853516, -34.4276848, -538.013306, -0.999724388, -3.9898886e-08, -0.0234765243, -3.9204977e-08, 1, -3.00177518e-08, 0.0234765243, -2.90890814e-08, -0.999724388)
end)

local admin2 = placessection:AddButton("Admin Guns", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-808.708557, -39.6492004, -932.789368, 0.999899805, 2.01343173e-08, -0.0141554065, -2.17800533e-08, 1, -1.16108232e-07, 0.0141554065, 1.16404912e-07, 0.999899805)
end)

local admin3 = placessection:AddButton("Admin Food", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-788.053406, -39.6492004, -932.951233, 0.998369277, 2.46515359e-08, 0.0570784509, -2.8773524e-08, 1, 7.13949646e-08, -0.0570784509, -7.29209759e-08, 0.998369277)
end)

local ufo = placessection:AddButton("Ufo", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2.85052466, 132, -736.571106, -0.0460956171, -4.24733706e-08, -0.998937011, 7.26012459e-08, 1, -4.58687275e-08, 0.998937011, -7.46384217e-08, -0.0460956171)
end)

local casino = placessection:AddButton("Casino", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-995, 21.6998043, -153.100037, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end)

local bank = placessection:AddButton("Bank", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-318.891174, 80.2145309, -257.177429, 0.0479469746, -5.14644114e-08, 0.998850107, -3.12971538e-09, 1, 5.16738901e-08, -0.998850107, -5.60372015e-09, 0.0479469746)
end)

local taco = placessection:AddButton("Taco", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(584.026855, 48.1605072, -474.033936, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end)

local revRoof = placessection:AddButton("Revolver Roof", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-634.463135, 80.434761, -204.232559, -0.0190527271, -1.03574322e-07, -0.999818563, 4.36709335e-09, 1, -1.03676342e-07, 0.999818563, -6.3416179e-09, -0.0190527271)
end)

local playground = placessection:AddButton("PlayGround", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-282.694153, 19.7496624, -807.719727, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end)

local gas = placessection:AddButton("Gas Station", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(604.800415, 46.0998344, -258.249573, 0, 0, 1, 0, 1, -0, -1, 0, 0)
end)

local cementery = placessection:AddButton("Cementery", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135.109558, 99.75, -57.2315979, 0.999993503, -0.000633752206, -0.0035054055, 0.000638642872, 0.999998808, 0.00139435288, 0.00350463158, -0.00139658386, 0.999992728)
end)

local school = placessection:AddButton("School Roof", function(bool)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-525.353455, 68.125, 311.824402, 0.999992013, 1.03866675e-08, -0.00399552286, -1.03507425e-08, 1, 9.01170427e-09, 0.00399552286, -8.97027519e-09, 0.999992013)
end)

--- Esp Tab ---
local EspSection = AimingTab:CreateSector("Esp", "left")

local espToggle = EspSection:AddToggle("Enable ESP", false, function(bool)
    ESP:Toggle(bool)
end)

local tracersToggle = EspSection:AddToggle("Enable Tracers", false, function(bool)
    ESP.Tracers = bool
end)

local namesToggle = EspSection:AddToggle("Enable Names", false, function(bool)
    ESP.Names = bool
end)

local boxesToggle = EspSection:AddToggle("Enable Boxes", false, function(bool)
    ESP.Boxes = bool
end)
espToggle:AddKeybind()

local togglessector = AimingTab:CreateSector("Toggles", "right")

local AntiSlow = togglessector:AddToggle("Anti Slow", nil, function(gh)
    if gh == true then
        game:GetService('RunService'):BindToRenderStep("Anti-Slow", 0 , function()
            if game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("NoWalkSpeed") then game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("NoWalkSpeed"):Destroy() end
            if game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("ReduceWalk") then game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("ReduceWalk"):Destroy() end
            if game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("NoJumping") then game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("NoJumping"):Destroy() end
            if game.Players.LocalPlayer.Character.BodyEffects.Reload.Value == true then game.Players.LocalPlayer.Character.BodyEffects.Reload.Value = false end
        end)
    elseif gh == false then
        game:GetService('RunService'):UnbindFromRenderStep("Anti-Slow")
    end
end)



local AutoReload = togglessector:AddToggle("Auto Reload", nil, function(r)
    if r == true then
        game:GetService('RunService'):BindToRenderStep("Auto-Reload", 0 , function()
            if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then
                if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo") then
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo").Value <= 0 then
                        game:GetService("ReplicatedStorage").MainEvent:FireServer("Reload", game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool")) 
                        wait(1)
                    end
                end
            end
        end)
    elseif r == false then
        game:GetService('RunService'):UnbindFromRenderStep("Auto-Reload")
    end
end)

local aura = togglessector:AddToggle("Cashaura", false, function(State)
    HoodsenseSettings.Blatant.Cash.AutoPickCash = State
end)

local Noclip = togglessector:AddButton("No Clip", function()
local noclipplayer = game:GetService("Players").LocalPlayer
local noclipmouse = noclipplayer:GetMouse()
 
local donoclip = false
local noclip = false
 
function b_noclip(key)
if (key == "b") then
if noclip == false then
donoclip = true
 
noclip = true
elseif noclip == true then
donoclip = false
 
noclip = false
end
end
end
 
noclipmouse.KeyDown:connect(b_noclip)
 
game:GetService("Players").LocalPlayer.Character.Head.Touched:connect(function(obj)
if obj ~= workspace.Terrain then
if donoclip == true then
obj.CanCollide = false
else
obj.CanCollide = true
end
end
end)
game.StarterGui:SetCore("SendNotification", {
    Title = "0Comp";
    Text = "Noclip keybind is B.";
    Icon = "";
    Duration = "BLANK";
    callbakc = bindableFunction;
})
end)

local Antilock = togglessector:AddButton("AimViewer", function()
	loadstring(game:HttpGet(('https://raw.githubusercontent.com/tier1joshh/aimviewer2.0/main/aimviewer2.0'),true))()
end)

local Antilock = togglessector:AddButton("AntiLock | C to enable", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/tier1joshh/AntiAimlock/main/AntiAimlock"))()
end)

local MemorySpoofer = togglessector:AddButton("Memory spoofer| Click Once.", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/tier1joshh/Memory-Spoofer/main/MemorySpoofer"))()
end)

local fovchanger = togglessector:AddSlider("Change Fov", 1, 70, 120, 1, function(value)
    game:GetService'Workspace'.Camera.FieldOfView = value
end)

getgenv().SpinBotSpeed = 20

local spinbot = togglessector:AddToggle("Spin Bot", nil, function(state)
	function getRoot(char)
				local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('UpperTorso')
				return rootPart
			end

			if state == true then
				local Spin = Instance.new("BodyAngularVelocity")
				Spin.Name = "Spinning"
				Spin.Parent = getRoot(game.Players.LocalPlayer.Character)
				Spin.MaxTorque = Vector3.new(0, math.huge, 0)
				Spin.AngularVelocity = Vector3.new(0,getgenv().SpinBotSpeed,0)
			else
				for i,v in pairs(getRoot(game.Players.LocalPlayer.Character):GetChildren()) do
					if v.Name == "Spinning" then
						v:Destroy()
					end
				end
			end
		end)
spinbot:AddKeybind()

local spinbotspeed = togglessector:AddSlider("Spinbot Speed", 1, 20, 50, 1, function(value)
    getgenv().SpinBotSpeed = value
end)

--- Visuals Tab ---
local VisualsTab = Window:CreateTab("Avatar")
local VisualsSection = VisualsTab:CreateSector("Character", "left")
local VisualsSection2 = VisualsTab:CreateSector("Other", "right")

local animationgamepass = VisualsSection:AddButton("Animation Gamepass", function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/eksotopro/holders/main/animation_gamepass.lua'))()
end)

local animbutton = VisualsSection:AddButton("Animation | Tryhard", function(bool)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/eksotopro/holders/main/anims.lua"))()
end)

local headlbutton = VisualsSection:AddButton("Headless", function(bool)
game.Players.LocalPlayer.Character.Head.Transparency = 1
for i,v in pairs(game.Players.LocalPlayer.Character.Head:GetChildren()) do
if (v:IsA("Decal")) then
v:Destroy()
end
end
end)

local animatedbeastmode = VisualsSection:AddButton("Animated Beast Mode", function()
	while true do
local player = game.Players.LocalPlayer.Character
if player:findFirstChild("Humanoid") then
    player.Head.face.Texture = "https://www.roblox.com/asset/?id=209712379"
    end
wait(1)
if player:findFirstChild("Humanoid") then
    player.Head.face.Texture = "https://www.roblox.com/asset/?id=127959433"
    end
wait(1)
end
end)

local facesection = VisualsTab:CreateSector("Face Changer", "left")

local meanie = facesection:AddButton("Meanie", function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/eksotopro/holders/main/faces/508490451.lua'))()
end)

local sshf = facesection:AddButton("Super Super Happy Face", function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/eksotopro/holders/main/faces/494290547.lua'))()
end)

local silverpunk = facesection:AddButton("Silver Punk Face", function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/eksotopro/holders/main/faces/387256104.lua'))()
end)

local yum = facesection:AddButton("Yum", function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/eksotopro/holders/main/faces/26018945.lua'))()
end)

local playful = facesection:AddButton("Playful Vampire", function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/eksotopro/holders/main/faces/2409281591.lua'))()
end)

local beastmode = facesection:AddButton("Beast Mode", function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/eksotopro/holders/main/faces/127959433.lua'))()
end)

--- Misc Tab ---
local MiscTab = Window:CreateTab("Misc")
local MiscSection = MiscTab:CreateSector("Miscelanious", "left")
local scriptsSection = MiscTab:CreateSector("Fun Stuff", "right")
local autofarmsection = MiscTab:CreateSector("Auto Farm", "left")
local autofarm = autofarmsection:AddToggle("ATM AutoFarm", nil, function(texto)
        repeat
            wait()
        until game:IsLoaded()
        local gm = getrawmetatable(game)
        setreadonly(gm, false)
        local namecall = gm.__namecall
        gm.__namecall =
            newcclosure(
            function(self, ...)
                local args = {...}
                if not checkcaller() and getnamecallmethod() == "FireServer" and tostring(self) == "MainEvent" then
                    if tostring(getcallingscript()) ~= "Framework" then
                        return
                    end
                end
                if not checkcaller() and getnamecallmethod() == "Kick" then
                    return
                end
                return namecall(self, unpack(args))
            end
        )
        
        local LocalPlayer = game:GetService("Players").LocalPlayer
        
        function gettarget()
            local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait()
            local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
            local maxdistance = math.huge
            local target
            for i, v in pairs(game:GetService("Workspace").Cashiers:GetChildren()) do
                if v:FindFirstChild("Head") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    local distance = (HumanoidRootPart.Position - v.Head.Position).magnitude
                    if distance < maxdistance then
                        target = v
                        maxdistance = distance
                    end
                end
            end
            return target
        end
        
        for i, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Seat") then
                v:Destroy()
            end
        end
        
        shared.MoneyFarm = texto
        
        while shared.MoneyFarm do
            wait()
            local Target = gettarget()
            repeat
                wait()
                pcall(
                    function()
                        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait()
                        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                        local Combat = LocalPlayer.Backpack:FindFirstChild("Combat") or Character:FindFirstChild("Combat")
                        if not Combat then
                            Character:FindFirstChild("Humanoid").Health = 0
                            return
                        end
                        HumanoidRootPart.CFrame = Target.Head.CFrame * CFrame.new(0, -2.5, 3)
                        Combat.Parent = Character
                        Combat:Activate()
                    end
                )
            until not Target or Target.Humanoid.Health < 0
            for i, v in pairs(game:GetService("Workspace").Ignored.Drop:GetDescendants()) do
                if v:IsA("ClickDetector") and v.Parent and v.Parent.Name:find("Money") then
                    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait()
                    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                    if (v.Parent.Position - HumanoidRootPart.Position).magnitude <= 18 then
                        repeat
                            wait()
                            fireclickdetector(v)
                        until not v or not v.Parent.Parent
                    end
                end
            end
            wait(1)
        end
    end)
autofarm:AddKeybind()



local nocooldown = MiscSection:AddButton("No jump cooldown", function(State)
    loadstring(game:HttpGet('https://raw.githubusercontent.com/eksotopro/holders/main/no-jump-cooldown.lua'))()
end)
    

local MovementSector = MiscTab:CreateSector("Movement", "right")
local SpeedToggle = MovementSector:AddToggle('Speed Enabled', false, function(State)
    HoodsenseSettings.Blatant.Movement.SpeedEnabled = State
end)

SpeedToggle:AddSlider(0, 5, 10, 1, function(Value)
    HoodsenseSettings.Blatant.Movement.SpeedAmount = Value
end)

MovementSector:AddDropdown("Speed Type", {"CFrame"}, "CFrame", false, function(Value)
    HoodsenseSettings.Blatant.Movement.SpeedType = Value
end)

MovementSector:AddDropdown("Speed Render Type", {"Default", "Fast"}, "Default", false, function(Value)
    HoodsenseSettings.Blatant.Movement.SpeedRenderType = Value
end)
SpeedToggle:AddKeybind()

local swagfly = scriptsSection:AddButton("Fly", function ()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/eksotopro/holders/main/cracked%20stuff/admin_fly.lua'))()
    game.StarterGui:SetCore("SendNotification", {
        Title = "0Comp";
        Text = "Fly keybind is X.";
        Icon = "";
        Duration = "BLANK";
        callbakc = bindableFunction;
    })
end)

local CreditsTab = Window:CreateTab("Credits")
local CreditsSection = CreditsTab:CreateSector("Developers", "left")

local esko = CreditsSection:AddButton("tier1josh | Owner", function(bool)
    setclipboard("yvng.jad#4989")
    game.StarterGui:SetCore("SendNotification", {
        Title = "0Comp";
        Text = "Owner copied on clipboard!";
        Icon = "";
        Duration = "BLANK";
        callbakc = bindableFunction;
        Button1 = "Okay!";
    })
end)

local discord1 = CreditsSection:AddButton("jr2shiesty | Gui creator", function(bool)
    setclipboard("jr2shiesty#0001")
    game.StarterGui:SetCore("SendNotification", {
        Title = "0Comp";
        Text = "Staff member copied on clipboard!";
        Icon = "";
        Duration = "BLANK";
        callbakc = bindableFunction;
        Button1 = "Okay!";
    })
end)



local partnersSection = CreditsTab:CreateSector("Discord", "right")
local partners1 = partnersSection:AddButton("discord.gg/0comp", function(bool)
    setclipboard("discord.gg/z4XD93xHjQ")
    game.StarterGui:SetCore("SendNotification", {
        Title = "0Comp";
        Text = "Server Copied on clipboard!";
        Icon = "";
        Duration = "BLANK";
        callbakc = bindableFunction;
        Button1 = "Okay!";
    })
end)




function Alive(Player)
    if Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") ~= nil and Player.Character:FindFirstChild("Humanoid") ~= nil and Player.Character:FindFirstChild("Head") ~= nil then
        return true
    end
    return false
end

local GetService = setmetatable({}, {
    __index = function(self, key)
        return game:GetService(key)
    end
})
local RunSer = GetService.RunService
RunSer.Heartbeat:Connect(function()
    if Alive(LocalPlayer) then
        if HoodsenseSettings.Blatant.Movement.SpeedEnabled and HoodsenseSettings.Blatant.Movement.SpeedType == "CFrame" then
            if HoodsenseSettings.Blatant.Movement.SpeedRenderType == "Default" then
                if LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
                    for i = 1, HoodsenseSettings.Blatant.Movement.SpeedAmount do
                        LocalPlayer.Character:TranslateBy(LocalPlayer.Character.Humanoid.MoveDirection)
                    end
                end
            end
        end
        if HoodsenseSettings.Blatant.Movement.SpeedEnabled and HoodsenseSettings.Blatant.Movement.SpeedType == "CFrame" then
            if HoodsenseSettings.Blatant.Movement.SpeedRenderType == "Fast" and Alive(LocalPlayer) then
                if LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
                    for i = 1, HoodsenseSettings.Blatant.Movement.SpeedAmount do
                        LocalPlayer.Character:TranslateBy(LocalPlayer.Character.Humanoid.MoveDirection)
                    end
                end
            end
        end
        if HoodsenseSettings.Blatant.Cash.AutoPickCash then
            pcall(function()
                for _, v in pairs(Workspace.Ignored.Drop:GetChildren()) do
                    if v.Name == "MoneyDrop" then
                        local MoneyMagnitude = (v.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                        if MoneyMagnitude < 25 then
                            fireclickdetector(v.ClickDetector)
                        end 
                    end
                end
            end)
        end
        if HoodsenseSettings.Blatant.Character.AntiBag then
            if LocalPlayer.Character:FindFirstChild("Christmas_Sock") then
                LocalPlayer.Character:FindFirstChild("Christmas_Sock"):Destroy()
            end
        end
    end
end)

game.StarterGui:SetCore("SendNotification", {
    Title = "0Comp";
    Text = "Succesfully loaded!";
    Icon = "";
    Duration = "4";
    callbakc = bindableFunction;
})
wait(8)
game.StarterGui:SetCore("SendNotification", {
    Title = "0Comp |  Z to close Ui";
    Text = "Thank you for purchasing 0Comp";
    Icon = "";
    Duration = "3";
    callbakc = bindableFunction;
    Button1 = "Okay!";
})
