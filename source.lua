--[[⊹˚₊‧───────────────‧₊˚⊹·͙⁺˚*•̩̩͙✩•̩̩͙*˚⁺‧͙⁺˚*•̩̩͙✩•̩̩͙*˚⁺‧͙⁺˚*•̩̩͙✩•̩̩͙*˚⁺‧͙⊹˚₊‧───────────────‧₊˚⊹

  ______                                   ______  __              __                  __     
 /      \                                 /      \|  \            |  \                |  \    
|  ▓▓▓▓▓▓\ ______   ______  _______      |  ▓▓▓▓▓▓\\▓▓______ ____ | ▓▓____   ______  _| ▓▓_   
| ▓▓  | ▓▓/      \ /      \|       \     | ▓▓__| ▓▓  \      \    \| ▓▓    \ /      \|   ▓▓ \  
| ▓▓  | ▓▓  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\ ▓▓▓▓▓▓▓\    | ▓▓    ▓▓ ▓▓ ▓▓▓▓▓▓\▓▓▓▓\ ▓▓▓▓▓▓▓\  ▓▓▓▓▓▓\\▓▓▓▓▓▓  
| ▓▓  | ▓▓ ▓▓  | ▓▓ ▓▓    ▓▓ ▓▓  | ▓▓    | ▓▓▓▓▓▓▓▓ ▓▓ ▓▓ | ▓▓ | ▓▓ ▓▓  | ▓▓ ▓▓  | ▓▓ | ▓▓ __ 
| ▓▓__/ ▓▓ ▓▓__/ ▓▓ ▓▓▓▓▓▓▓▓ ▓▓  | ▓▓    | ▓▓  | ▓▓ ▓▓ ▓▓ | ▓▓ | ▓▓ ▓▓__/ ▓▓ ▓▓__/ ▓▓ | ▓▓|  \
 \▓▓    ▓▓ ▓▓    ▓▓\▓▓     \ ▓▓  | ▓▓    | ▓▓  | ▓▓ ▓▓ ▓▓ | ▓▓ | ▓▓ ▓▓    ▓▓\▓▓    ▓▓  \▓▓  ▓▓
  \▓▓▓▓▓▓| ▓▓▓▓▓▓▓  \▓▓▓▓▓▓▓\▓▓   \▓▓     \▓▓   \▓▓\▓▓\▓▓  \▓▓  \▓▓\▓▓▓▓▓▓▓  \▓▓▓▓▓▓    \▓▓▓▓ 
         | ▓▓                                                                                 
         | ▓▓                                                                                 
          \▓▓                                                                                 

༺☆༻____________☾✧ ✩ ✧☽____________༺☆༻༺☆༻____________☾✧ ✩ ✧☽____________༺☆༻

    ✨Estrutura Universal de Assistência de Mira✨
    Release 1.9.5

    twix.cyou/pix
    twix.cyou/OpenAimbotV3rm

    Author: ttwiz_z (ttwizz) <i@twix.cyou>
    License: MIT
    GitHub: https://github.com/ttwizz/Open-Aimbot

    Issues: https://github.com/ttwizz/Open-Aimbot/issues
    Pull requests: https://github.com/ttwizz/Open-Aimbot/pulls
    Discussions: https://github.com/ttwizz/Open-Aimbot/discussions

    Wiki: https://moderka.org/Open-Aimbot

    Trustpilot: https://www.trustpilot.com/review/moderka.org

•───────•°•❀•°•───────•୧‿̩͙ ˖︵ꕀ ⠀𓏶 ̣̣̥⠀ ꕀ︵˖ ̩͙‿୨•───────•°•❀•°•───────•]] -- ! Debugger
local DEBUG = false

if DEBUG then
    getfenv().getfenv = function()
        return setmetatable({}, {
            __index = function()
                return function()
                    return true
                end
            end
        })
    end
end

-- ! Services

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- ! Interface Manager

local UISettings = {
    TabWidth = 160,
    Size = {580, 460},
    Theme = "VSC Dark High Contrast",
    Acrylic = false,
    Transparency = true,
    MinimizeKey = "RightShift",
    ShowNotifications = true,
    ShowWarnings = true,
    RenderingMode = "RenderStepped",
    AutoImport = true
}

local InterfaceManager = {}

function InterfaceManager:ImportSettings()
    pcall(function()
        if not DEBUG and getfenv().isfile and getfenv().readfile and getfenv().isfile("UISettings.ttwizz") and
            getfenv().readfile("UISettings.ttwizz") then
            for Key, Value in next, HttpService:JSONDecode(getfenv().readfile("UISettings.ttwizz")) do
                UISettings[Key] = Value
            end
        end
    end)
end

function InterfaceManager:ExportSettings()
    pcall(function()
        if not DEBUG and getfenv().isfile and getfenv().readfile and getfenv().writefile then
            getfenv().writefile("UISettings.ttwizz", HttpService:JSONEncode(UISettings))
        end
    end)
end

InterfaceManager:ImportSettings()

UISettings.__LAST_RUN__ = os.date()
InterfaceManager:ExportSettings()

-- ! Colors Handler

local ColorsHandler = {}

function ColorsHandler:PackColour(Colour)
    return typeof(Colour) == "Color3" and {
        R = Colour.R * 255,
        G = Colour.G * 255,
        B = Colour.B * 255
    } or typeof(Colour) == "table" and Colour or {
        R = 255,
        G = 255,
        B = 255
    }
end

function ColorsHandler:UnpackColour(Colour)
    return typeof(Colour) == "table" and Color3.fromRGB(Colour.R, Colour.G, Colour.B) or typeof(Colour) == "Color3" and
               Colour or Color3.fromRGB(255, 255, 255)
end

-- ! Configuration Importer

local ImportedConfiguration = {}

pcall(function()
    if not DEBUG and getfenv().isfile and getfenv().readfile and
        getfenv().isfile(string.format("%s.ttwizz", game.GameId)) and
        getfenv().readfile(string.format("%s.ttwizz", game.GameId)) and UISettings.AutoImport then
        ImportedConfiguration = HttpService:JSONDecode(getfenv().readfile(string.format("%s.ttwizz", game.GameId)))
        for Key, Value in next, ImportedConfiguration do
            if Key == "FoVColour" or Key == "NameESPOutlineColour" or Key == "ESPColour" then
                ImportedConfiguration[Key] = ColorsHandler:UnpackColour(Value)
            end
        end
    end
end)

-- ! Configuration Initializer

local Configuration = {}

-- ? Aimbot

Configuration.Aimbot = ImportedConfiguration["Aimbot"] or false
Configuration.OnePressAimingMode = ImportedConfiguration["OnePressAimingMode"] or false
Configuration.AimKey = ImportedConfiguration["AimKey"] or "RMB"
Configuration.AimMode = ImportedConfiguration["AimMode"] or "Camera"
Configuration.SilentAimMethods = ImportedConfiguration["SilentAimMethods"] or
                                     {"Mouse.Hit / Mouse.Target", "GetMouseLocation"}
Configuration.SilentAimChance = ImportedConfiguration["SilentAimChance"] or 100
Configuration.OffAimbotAfterKill = ImportedConfiguration["OffAimbotAfterKill"] or false
Configuration.AimPartDropdownValues = ImportedConfiguration["AimPartDropdownValues"] or {"Head", "HumanoidRootPart"}
Configuration.AimPart = ImportedConfiguration["AimPart"] or "HumanoidRootPart"
Configuration.RandomAimPart = ImportedConfiguration["RandomAimPart"] or false

Configuration.UseOffset = ImportedConfiguration["UseOffset"] or false
Configuration.OffsetType = ImportedConfiguration["OffsetType"] or "Static"
Configuration.StaticOffsetIncrement = ImportedConfiguration["StaticOffsetIncrement"] or 10
Configuration.DynamicOffsetIncrement = ImportedConfiguration["DynamicOffsetIncrement"] or 10
Configuration.AutoOffset = ImportedConfiguration["AutoOffset"] or false
Configuration.MaxAutoOffset = ImportedConfiguration["MaxAutoOffset"] or 50

Configuration.UseSensitivity = ImportedConfiguration["UseSensitivity"] or false
Configuration.Sensitivity = ImportedConfiguration["Sensitivity"] or 50
Configuration.UseNoise = ImportedConfiguration["UseNoise"] or false
Configuration.NoiseFrequency = ImportedConfiguration["NoiseFrequency"] or 50

-- ? Bots

Configuration.SpinBot = ImportedConfiguration["SpinBot"] or false
Configuration.OnePressSpinningMode = ImportedConfiguration["OnePressSpinningMode"] or false
Configuration.SpinKey = ImportedConfiguration["SpinKey"] or "Q"
Configuration.SpinBotVelocity = ImportedConfiguration["SpinBotVelocity"] or 50
Configuration.SpinPartDropdownValues = ImportedConfiguration["SpinPartDropdownValues"] or {"Head", "HumanoidRootPart"}
Configuration.SpinPart = ImportedConfiguration["SpinPart"] or "HumanoidRootPart"
Configuration.RandomSpinPart = ImportedConfiguration["RandomSpinPart"] or false

Configuration.TriggerBot = ImportedConfiguration["TriggerBot"] or false
Configuration.OnePressTriggeringMode = ImportedConfiguration["OnePressTriggeringMode"] or false
Configuration.SmartTriggerBot = ImportedConfiguration["SmartTriggerBot"] or false
Configuration.TriggerKey = ImportedConfiguration["TriggerKey"] or "E"
Configuration.TriggerBotChance = ImportedConfiguration["TriggerBotChance"] or 100

-- ? Checks

Configuration.AliveCheck = ImportedConfiguration["AliveCheck"] or false
Configuration.GodCheck = ImportedConfiguration["GodCheck"] or false
Configuration.TeamCheck = ImportedConfiguration["TeamCheck"] or false
Configuration.FriendCheck = ImportedConfiguration["FriendCheck"] or false
Configuration.FollowCheck = ImportedConfiguration["FollowCheck"] or false
Configuration.VerifiedBadgeCheck = ImportedConfiguration["VerifiedBadgeCheck"] or false
Configuration.WallCheck = ImportedConfiguration["WallCheck"] or false
Configuration.WaterCheck = ImportedConfiguration["WaterCheck"] or false

Configuration.FoVCheck = ImportedConfiguration["FoVCheck"] or false
Configuration.FoVRadius = ImportedConfiguration["FoVRadius"] or 100
Configuration.MagnitudeCheck = ImportedConfiguration["MagnitudeCheck"] or false
Configuration.TriggerMagnitude = ImportedConfiguration["TriggerMagnitude"] or 500
Configuration.TransparencyCheck = ImportedConfiguration["TransparencyCheck"] or false
Configuration.IgnoredTransparency = ImportedConfiguration["IgnoredTransparency"] or 0.5
Configuration.WhitelistedGroupCheck = ImportedConfiguration["WhitelistedGroupCheck"] or false
Configuration.WhitelistedGroup = ImportedConfiguration["WhitelistedGroup"] or 0
Configuration.BlacklistedGroupCheck = ImportedConfiguration["BlacklistedGroupCheck"] or false
Configuration.BlacklistedGroup = ImportedConfiguration["BlacklistedGroup"] or 0

Configuration.IgnoredPlayersCheck = ImportedConfiguration["IgnoredPlayersCheck"] or false
Configuration.IgnoredPlayersDropdownValues = ImportedConfiguration["IgnoredPlayersDropdownValues"] or {}
Configuration.IgnoredPlayers = ImportedConfiguration["IgnoredPlayers"] or {}
Configuration.TargetPlayersCheck = ImportedConfiguration["TargetPlayersCheck"] or false
Configuration.TargetPlayersDropdownValues = ImportedConfiguration["TargetPlayersDropdownValues"] or {}
Configuration.TargetPlayers = ImportedConfiguration["TargetPlayers"] or {}

Configuration.PremiumCheck = ImportedConfiguration["PremiumCheck"] or false

-- ? Visuals

Configuration.FoV = ImportedConfiguration["FoV"] or false
Configuration.FoVKey = ImportedConfiguration["FoVKey"] or "R"
Configuration.FoVThickness = ImportedConfiguration["FoVThickness"] or 2
Configuration.FoVOpacity = ImportedConfiguration["FoVOpacity"] or 0.8
Configuration.FoVFilled = ImportedConfiguration["FoVFilled"] or false
Configuration.FoVColour = ImportedConfiguration["FoVColour"] or Color3.fromRGB(255, 255, 255)

Configuration.SmartESP = ImportedConfiguration["SmartESP"] or false
Configuration.ESPKey = ImportedConfiguration["ESPKey"] or "T"
Configuration.ESPBox = ImportedConfiguration["ESPBox"] or false
Configuration.ESPBoxFilled = ImportedConfiguration["ESPBoxFilled"] or false
Configuration.NameESP = ImportedConfiguration["NameESP"] or false
Configuration.NameESPFont = ImportedConfiguration["NameESPFont"] or "Monospace"
Configuration.NameESPSize = ImportedConfiguration["NameESPSize"] or 16
Configuration.NameESPOutlineColour = ImportedConfiguration["NameESPOutlineColour"] or Color3.fromRGB(0, 0, 0)
Configuration.HealthESP = ImportedConfiguration["HealthESP"] or false
Configuration.MagnitudeESP = ImportedConfiguration["MagnitudeESP"] or false
Configuration.TracerESP = ImportedConfiguration["TracerESP"] or false
Configuration.ESPThickness = ImportedConfiguration["ESPThickness"] or 2
Configuration.ESPOpacity = ImportedConfiguration["ESPOpacity"] or 0.8
Configuration.ESPColour = ImportedConfiguration["ESPColour"] or Color3.fromRGB(255, 255, 255)
Configuration.ESPUseTeamColour = ImportedConfiguration["ESPUseTeamColour"] or false

Configuration.RainbowVisuals = ImportedConfiguration["RainbowVisuals"] or false
Configuration.RainbowDelay = ImportedConfiguration["RainbowDelay"] or 5

-- ! Constants

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local IsComputer = UserInputService.KeyboardEnabled and UserInputService.MouseEnabled

local MonthlyLabels = {"🎅%s❄️", "☃️%s🏂", "🌷%s☘️", "🌺%s🎀", "🐝%s🌼", "🌈%s😎",
                       "🌞%s🏖️", "☀️%s💐", "🌦%s🍁", "🎃%s💀", "🍂%s☕", "🎄%s🎁"}
local PremiumLabels = {"💫PREMIUM💫", "✨PREMIUM✨", "🌟PREMIUM🌟", "⭐PREMIUM⭐", "🤩PREMIUM🤩"}

-- ! Names Handler

local function GetPlayerName(String)
    if typeof(String) == "string" and #String > 0 then
        for _, _Player in next, Players:GetPlayers() do
            if string.sub(string.lower(_Player.Name), 1, #string.lower(String)) == string.lower(String) then
                return _Player.Name
            end
        end
    end
    return ""
end

-- ! Fields

local Status = ""

local Fluent = nil
local ShowWarning = false

local RobloxActive = true
local Clock = os.clock()

local Aiming = false
local Target = nil
local Tween = nil
local MouseSensitivity = UserInputService.MouseDeltaSensitivity

local Spinning = false
local Triggering = false
local ShowingFoV = false
local ShowingESP = false

do
    if typeof(script) == "Instance" and script:FindFirstChild("Fluent") and
        script:FindFirstChild("Fluent"):IsA("ModuleScript") then
        Fluent = require(script:FindFirstChild("Fluent"))
    else
        local Success, Result = pcall(function()
            return game:HttpGet("https://twix.cyou/Fluent.txt", true)
        end)
        if Success and typeof(Result) == "string" and string.find(Result, "dawid") then
            Fluent = getfenv().loadstring(Result)()
            if Fluent.Premium then
                return getfenv().loadstring(game:HttpGet("https://twix.cyou/Aimbot.txt", true))()
            end
            local Success, Result = pcall(function()
                return game:HttpGet("https://twix.cyou/AimbotStatus.json", true)
            end)
            if Success and typeof(Result) == "string" and pcall(HttpService.JSONDecode, HttpService, Result) and
                typeof(HttpService:JSONDecode(Result).message) == "string" then
                Status = HttpService:JSONDecode(Result).message
            end
        else
            return
        end
    end
end

local SensitivityChanged;
SensitivityChanged = UserInputService:GetPropertyChangedSignal("MouseDeltaSensitivity"):Connect(function()
    if not Fluent then
        SensitivityChanged:Disconnect()
    elseif not Aiming or not DEBUG and
        (getfenv().mousemoverel and IsComputer and Configuration.AimMode == "Mouse" or getfenv().hookmetamethod and
            getfenv().newcclosure and getfenv().checkcaller and getfenv().getnamecallmethod and Configuration.AimMode ==
            "Silent") then
        MouseSensitivity = UserInputService.MouseDeltaSensitivity
    end
end)

-- ! UI Initializer

do
    local Window = Fluent:CreateWindow({
        Title = string.format("%s <b><i>%s</i></b>",
            string.format(MonthlyLabels[os.date("*t").month], "Assistência de Mira"),
            #Status > 0 and Status or "🔥GRATUITO🔥"),
        SubTitle = "By @ttwiz_z",
        TabWidth = UISettings.TabWidth,
        Size = UDim2.fromOffset(table.unpack(UISettings.Size)),
        Theme = UISettings.Theme,
        Acrylic = UISettings.Acrylic,
        MinimizeKey = UISettings.MinimizeKey
    })

    local Tabs = {
        Aimbot = Window:AddTab({
            Title = "Aimbot",
            Icon = "crosshair"
        })
    }

    Window:SelectTab(1)

    Tabs.Aimbot:AddParagraph({
        Title = string.format("%s 🔥GRATUITO🔥",
            string.format(EtiquetasMensais[os.date("*t").month], "Assistência de Mira")),
        Content = "✨Framework Universal de Assistência de Mira✨\nhttps://github.com/ttwizz/Open-Aimbot"
    })

    local AimbotSection = Tabs.Aimbot:AddSection("Aimbot")

    local AimbotToggle = AimbotSection:AddToggle("Aimbot", {
        Title = "Aimbot",
        Description = "Toggles the Aimbot",
        Default = Configuration.Aimbot
    })
    AimbotToggle:OnChanged(function(Value)
        Configuration.Aimbot = Value
        if not IsComputer then
            Aiming = Value
        end
    end)

    if IsComputer then
        local OnePressAimingModeToggle = AimbotSection:AddToggle("OnePressAimingMode", {
            Title = "Modo de um toque",
            Description = "Usa o modo de um toque em vez do modo de espera",
            Default = Configuration.OnePressAimingMode
        })
        OnePressAimingModeToggle:OnChanged(function(Value)
            Configuration.OnePressAimingMode = Value
        end)

        local AimKeybind = AimbotSection:AddKeybind("AimKey", {
            Title = "Tecla de Mira",
            Description = "Altera a Tecla de Mira",
            Default = Configuration.AimKey,
            ChangedCallback = function(Value)
                Configuration.AimKey = Value
            end
        })
        Configuration.AimKey = AimKeybind.Value ~= "RMB" and Enum.KeyCode[AimKeybind.Value] or
                                   Enum.UserInputType.MouseButton2
    end

    local AimModeDropdown = AimbotSection:AddDropdown("AimMode", {
        Title = "Modo de Mira",
        Description = "Altera o Modo de Mira",
        Values = {"Camera"},
        Default = Configuration.AimMode,
        Callback = function(Value)
            Configuration.AimMode = Value
        end
    })
    if getfenv().mousemoverel and IsComputer then
        table.insert(AimModeDropdown.Values, "Mouse")
        AimModeDropdown:BuildDropdownList()
    else
        ShowWarning = true
    end
    if getfenv().hookmetamethod and getfenv().newcclosure and getfenv().checkcaller and getfenv().getnamecallmethod then
        table.insert(AimModeDropdown.Values, "Silent")
        AimModeDropdown:BuildDropdownList()

        local SilentAimMethodsDropdown = AimbotSection:AddDropdown("SilentAimMethods", {
            Title = "Métodos de Mira Silenciosa",
            Description = "Define os Métodos de Mira Silenciosa",
            Values = {"Mouse.Hit / Mouse.Target", "GetMouseLocation", "Raycast", "FindPartOnRay",
                      "FindPartOnRayWithIgnoreList", "FindPartOnRayWithWhitelist"},
            Multi = true,
            Default = Configuration.SilentAimMethods
        })
        SilentAimMethodsDropdown:OnChanged(function(Value)
            Configuration.SilentAimMethods = {}
            for Key, _ in next, Value do
                if typeof(Key) == "string" then
                    table.insert(Configuration.SilentAimMethods, Key)
                end
            end
        end)

        AimbotSection:AddSlider("SilentAimChance", {
            Title = "Chance de Mira Silenciosa",
            Description = "Altera a Chance de Acerto da Mira Silenciosa",
            Default = Configuration.SilentAimChance,
            Min = 1,
            Max = 100,
            Rounding = 1,
            Callback = function(Value)
                Configuration.SilentAimChance = Value
            end
        })
    else
        ShowWarning = true
    end

    local OffAimbotAfterKillToggle = AimbotSection:AddToggle("OffAimbotAfterKill", {
        Title = "Fora após matar",
        Description = "Desativa o Modo de Mira após matar um Alvo",
        Default = Configuration.OffAimbotAfterKill
    })
    OffAimbotAfterKillToggle:OnChanged(function(Value)
        Configuration.OffAimbotAfterKill = Value
    end)

    local AimPartDropdown = AimbotSection:AddDropdown("AimPart", {
        Title = "Parte de Mira",
        Description = "Altera a Parte de Mira",
        Values = Configuration.AimPartDropdownValues,
        Default = Configuration.AimPart,
        Callback = function(Value)
            Configuration.AimPart = Value
        end
    })

    local RandomAimPartToggle = AimbotSection:AddToggle("RandomAimPart", {
        Title = "Parte de Mira Aleatória",
        Description = "Seleciona a cada segundo uma parte de mira aleatória no menu suspenso",
        Default = Configuration.RandomAimPart
    })
    RandomAimPartToggle:OnChanged(function(Value)
        Configuration.RandomAimPart = Value
    end)

    AimbotSection:AddInput("AddAimPart", {
        Title = "Adicionar parte de mira",
        Description = "Após digitar, pressione Enter",
        Finished = true,
        Placeholder = "Part Name",
        Callback = function(Value)
            if #Value > 0 and not table.find(Configuration.AimPartDropdownValues, Value) then
                table.insert(Configuration.AimPartDropdownValues, Value)
                AimPartDropdown:SetValue(Value)
            end
        end
    })
    

    AimbotSection:AddInput("RemoveAimPart", {
        Title = "Remover Parte da Mira",
        Description = "Após digitar, pressione Enter",
        Finished = true,
        Placeholder = "Nome da Parte",
        Callback = function(Value)
            if #Value > 0 and table.find(Configuration.AimPartDropdownValues, Value) then
                if Configuration.AimPart == Value then
                    AimPartDropdown:SetValue(nil)
                end
                table.remove(Configuration.AimPartDropdownValues, table.find(Configuration.AimPartDropdownValues, Value))
                AimPartDropdown:SetValues(Configuration.AimPartDropdownValues)
            end
        end
    })

    AimbotSection:AddButton({
        Title = "Limpar todos os itens",
        Description = "Remove todos os elementos",
        Callback = function()
            local Items = #Configuration.AimPartDropdownValues
            AimPartDropdown:SetValue(nil)
            Configuration.AimPartDropdownValues = {}
            AimPartDropdown:SetValues(Configuration.AimPartDropdownValues)
            Window:Dialog({
                Title = string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot"),
                Content = Items == 0 and "Nada foi limpo!" or Items == 1 and "1 item foi limpo!" or
                    string.format("%s Itens foram limpos!", Items),
                Buttons = {{
                    Title = "Confirmar"
                }}
            })
        end
    })

    local AimOffsetSection = Tabs.Aimbot:AddSection("Aim Offset")

    local UseOffsetToggle = AimOffsetSection:AddToggle("UseOffset", {
        Title = "Usar Deslocamento",
        Description = "Alterna o Deslocamento",
        Default = Configuration.UseOffset
    })
    UseOffsetToggle:OnChanged(function(Value)
        Configuration.UseOffset = Value
    end)

    AimOffsetSection:AddDropdown("OffsetType", {
        Title = "Tipo de Deslocamento",
        Description = "Altera o Tipo de Deslocamento",
        Values = {"Static", "Dynamic", "Static & Dynamic"},
        Default = Configuration.OffsetType,
        Callback = function(Value)
            Configuration.OffsetType = Value
        end
    })

    AimOffsetSection:AddSlider("StaticOffsetIncrement", {
        Title = "Incremento de Deslocamento Estático",
        Description = "Altera o Incremento de Deslocamento Estático",
        Default = Configuration.StaticOffsetIncrement,
        Min = 1,
        Max = 50,
        Rounding = 1,
        Callback = function(Value)
            Configuration.StaticOffsetIncrement = Value
        end
    })

    AimOffsetSection:AddSlider("DynamicOffsetIncrement", {
        Title = "Incremento de Deslocamento Dinâmico",
        Description = "Altera o Incremento de Deslocamento Dinâmico",
        Default = Configuration.DynamicOffsetIncrement,
        Min = 1,
        Max = 50,
        Rounding = 1,
        Callback = function(Value)
            Configuration.DynamicOffsetIncrement = Value
        end
    })

    local AutoOffsetToggle = AimOffsetSection:AddToggle("AutoOffset", {
        Title = "Deslocamento Automático",
        Description = "Alterna o Deslocamento Automático",
        Default = Configuration.AutoOffset
    })
    AutoOffsetToggle:OnChanged(function(Value)
        Configuration.AutoOffset = Value
    end)

    AimOffsetSection:AddSlider("MaxAutoOffset", {
        Title = "Deslocamento Automático Máximo",
        Description = "Altera o Deslocamento Automático Máximo",
        Default = Configuration.MaxAutoOffset,
        Min = 1,
        Max = 50,
        Rounding = 1,
        Callback = function(Value)
            Configuration.MaxAutoOffset = Value
        end
    })

    local SensitivityNoiseSection = Tabs.Aimbot:AddSection("Sensitivity & Noise")

    local UseSensitivityToggle = SensitivityNoiseSection:AddToggle("UseSensitivity", {
        Title = "Usar Sensibilidade",
        Description = "Alterna a Sensibilidade",
        Default = Configuration.UseSensitivity
    })
    UseSensitivityToggle:OnChanged(function(Value)
        Configuration.UseSensitivity = Value
    end)

    SensitivityNoiseSection:AddSlider("Sensitivity", {
        Title = "Sensibilidade",
        Description = "Suaviza os movimentos do mouse/câmera ao mirar",
        Default = Configuration.Sensitivity,
        Min = 1,
        Max = 100,
        Rounding = 1,
        Callback = function(Value)
            Configuration.Sensitivity = Value
        end
    })

    local UseNoiseToggle = SensitivityNoiseSection:AddToggle("UseNoise", {
        Title = "Usar Ruído",
        Description = "Alterna a trepidação da câmera ao mirar",
        Default = Configuration.UseNoise
    })
    UseNoiseToggle:OnChanged(function(Value)
        Configuration.UseNoise = Value
    end)

    SensitivityNoiseSection:AddSlider("NoiseFrequency", {
        Title = "Frequência do Ruído",
        Description = "Altera a Frequência do Ruído",
        Default = Configuration.NoiseFrequency,
        Min = 1,
        Max = 100,
        Rounding = 1,
        Callback = function(Value)
            Configuration.NoiseFrequency = Value
        end
    })

    Tabs.Bots = Window:AddTab({
        Title = "Bots",
        Icon = "bot"
    })

    Tabs.Bots:AddParagraph({
        Title = string.format("%s 🔥GRÁTIS🔥", string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot")),
        Content = "✨Estrutura Universal de Assistência de Mira✨\nhttps://github.com/ttwizz/Open-Aimbot"
    })

    local SpinBotSection = Tabs.Bots:AddSection("SpinBot")

    SpinBotSection:AddParagraph({
        Title = "NOTA",
        Content = "O SpinBot não funciona normalmente no Modo de Renderização RenderStepped. Defina um valor diferente de RenderStepped para resolver este problema."
    })

    local SpinBotToggle = SpinBotSection:AddToggle("SpinBot", {
        Title = "SpinBot",
        Description = "Alterna o SpinBot",
        Default = Configuration.SpinBot
    })
    SpinBotToggle:OnChanged(function(Value)
        Configuration.SpinBot = Value
        if not IsComputer then
            Spinning = Value
        end
    end)

    if IsComputer then
        local OnePressSpinningModeToggle = SpinBotSection:AddToggle("OnePressSpinningMode", {
            Title = "Modo de um toque",
            Description = "Usa o Modo de um toque em vez do Modo de espera",
            Default = Configuration.OnePressSpinningMode
        })
        OnePressSpinningModeToggle:OnChanged(function(Value)
            Configuration.OnePressSpinningMode = Value
        end)

        local SpinKeybind = SpinBotSection:AddKeybind("SpinKey", {
            Title = "Chave de Giro",
            Description = "Altera a Chave de Giro",
            Default = Configuration.SpinKey,
            ChangedCallback = function(Value)
                Configuration.SpinKey = Value
            end
        })
        Configuration.SpinKey = SpinKeybind.Value ~= "RMB" and Enum.KeyCode[SpinKeybind.Value] or
                                    Enum.UserInputType.MouseButton2
    end

    SpinBotSection:AddSlider("SpinBotVelocity", {
        Title = "Velocidade do SpinBot",
        Description = "Altera a Velocidade do SpinBot",
        Default = Configuration.SpinBotVelocity,
        Min = 1,
        Max = 50,
        Rounding = 1,
        Callback = function(Value)
            Configuration.SpinBotVelocity = Value
        end
    })

    local SpinPartDropdown = SpinBotSection:AddDropdown("SpinPart", {
        Title = "Parte Giratória",
        Description = "Altera a Parte Giratória",
        Values = Configuration.SpinPartDropdownValues,
        Default = Configuration.SpinPart,
        Callback = function(Value)
            Configuration.SpinPart = Value
        end
    })

    local RandomSpinPartToggle = SpinBotSection:AddToggle("RandomSpinPart", {
        Title = "Parte de Giro Aleatório",
        Description = "Seleciona a cada segundo uma Parte de Giro Aleatório no Menu Suspenso",
        Default = Configuration.RandomSpinPart
    })
    RandomSpinPartToggle:OnChanged(function(Value)
        Configuration.RandomSpinPart = Value
    end)

    SpinBotSection:AddInput("AddSpinPart", {
        Title = "Adicionar Parte Giratória",
        Description = "Após digitar, pressione Enter",
        Finished = true,
        Placeholder = "Part Name",
        Callback = function(Value)
            if #Value > 0 and not table.find(Configuration.SpinPartDropdownValues, Value) then
                table.insert(Configuration.SpinPartDropdownValues, Value)
                SpinPartDropdown:SetValue(Value)
            end
        end
    })

    SpinBotSection:AddInput("RemoveSpinPart", {
        Title = "Remover parte giratória",
        Description = "Após digitar, pressione Enter",
        Finished = true,
        Placeholder = "Part Name",
        Callback = function(Value)
            if #Value > 0 and table.find(Configuration.SpinPartDropdownValues, Value) then
                if Configuration.SpinPart == Value then
                    SpinPartDropdown:SetValue(nil)
                end
                table.remove(Configuration.SpinPartDropdownValues,
                    table.find(Configuration.SpinPartDropdownValues, Value))
                SpinPartDropdown:SetValues(Configuration.SpinPartDropdownValues)
            end
        end
    })

    SpinBotSection:AddButton({
        Title = "Limpar todos os itens",
        Description = "Remove todos os elementos",
        Callback = function()
            local Items = #Configuration.SpinPartDropdownValues
            SpinPartDropdown:SetValue(nil)
            Configuration.SpinPartDropdownValues = {}
            SpinPartDropdown:SetValues(Configuration.SpinPartDropdownValues)
            Window:Dialog({
                Title = string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot"),
                Content = Items == 0 and "Nada foi esclarecido!" or Items == 1 and "1 item foi limpo!" or
                    string.format("%s Itens foram limpos!", Items),
                Buttons = {{
                    Title = "Confirmar"
                }}
            })
        end
    })

    if getfenv().mouse1click and IsComputer then
        local TriggerBotSection = Tabs.Bots:AddSection("TriggerBot")

        local TriggerBotToggle = TriggerBotSection:AddToggle("TriggerBot", {
            Title = "TriggerBot",
            Description = "Toggles the TriggerBot",
            Default = Configuration.TriggerBot
        })
        TriggerBotToggle:OnChanged(function(Value)
            Configuration.TriggerBot = Value
        end)

        local OnePressTriggeringModeToggle = TriggerBotSection:AddToggle("OnePressTriggeringMode", {
            Title = "One-Press Mode",
            Description = "Uses the One-Press Mode instead of the Holding Mode",
            Default = Configuration.OnePressTriggeringMode
        })
        OnePressTriggeringModeToggle:OnChanged(function(Value)
            Configuration.OnePressTriggeringMode = Value
        end)

        local SmartTriggerBotToggle = TriggerBotSection:AddToggle("SmartTriggerBot", {
            Title = "Smart TriggerBot",
            Description = "Uses the TriggerBot only when Aiming",
            Default = Configuration.SmartTriggerBot
        })
        SmartTriggerBotToggle:OnChanged(function(Value)
            Configuration.SmartTriggerBot = Value
        end)

        local TriggerKeybind = TriggerBotSection:AddKeybind("TriggerKey", {
            Title = "Trigger Key",
            Description = "Changes the Trigger Key",
            Default = Configuration.TriggerKey,
            ChangedCallback = function(Value)
                Configuration.TriggerKey = Value
            end
        })
        Configuration.TriggerKey = TriggerKeybind.Value ~= "RMB" and Enum.KeyCode[TriggerKeybind.Value] or
                                       Enum.UserInputType.MouseButton2

        TriggerBotSection:AddSlider("TriggerBotChance", {
            Title = "TriggerBot Chance",
            Description = "Changes the Hit Chance for TriggerBot",
            Default = Configuration.TriggerBotChance,
            Min = 1,
            Max = 100,
            Rounding = 1,
            Callback = function(Value)
                Configuration.TriggerBotChance = Value
            end
        })
    else
        ShowWarning = true
    end

    Tabs.Checks = Window:AddTab({
        Title = "Checks",
        Icon = "list-checks"
    })

    Tabs.Checks:AddParagraph({
        Title = string.format("%s 🔥GRÁTIS🔥", string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot")),
        Content = "✨Estrutura Universal de Assistência de Mira✨\nhttps://github.com/ttwizz/Open-Aimbot"
    })

    local SimpleChecksSection = Tabs.Checks:AddSection("Simple Checks")

    local AliveCheckToggle = SimpleChecksSection:AddToggle("AliveCheck", {
        Title = "Alive Check",
        Description = "Toggles the Alive Check",
        Default = Configuration.AliveCheck
    })
    AliveCheckToggle:OnChanged(function(Value)
        Configuration.AliveCheck = Value
    end)

    local GodCheckToggle = SimpleChecksSection:AddToggle("GodCheck", {
        Title = "God Check",
        Description = "Toggles the God Check",
        Default = Configuration.GodCheck
    })
    GodCheckToggle:OnChanged(function(Value)
        Configuration.GodCheck = Value
    end)

    local TeamCheckToggle = SimpleChecksSection:AddToggle("TeamCheck", {
        Title = "Team Check",
        Description = "Toggles the Team Check",
        Default = Configuration.TeamCheck
    })
    TeamCheckToggle:OnChanged(function(Value)
        Configuration.TeamCheck = Value
    end)

    local FriendCheckToggle = SimpleChecksSection:AddToggle("FriendCheck", {
        Title = "Friend Check",
        Description = "Toggles the Friend Check",
        Default = Configuration.FriendCheck
    })
    FriendCheckToggle:OnChanged(function(Value)
        Configuration.FriendCheck = Value
    end)

    local FollowCheckToggle = SimpleChecksSection:AddToggle("FollowCheck", {
        Title = "Follow Check",
        Description = "Toggles the Follow Check",
        Default = Configuration.FollowCheck
    })
    FollowCheckToggle:OnChanged(function(Value)
        Configuration.FollowCheck = Value
    end)

    local VerifiedBadgeCheckToggle = SimpleChecksSection:AddToggle("VerifiedBadgeCheck", {
        Title = "Verified Badge Check",
        Description = "Toggles the Verified Badge Check",
        Default = Configuration.VerifiedBadgeCheck
    })
    VerifiedBadgeCheckToggle:OnChanged(function(Value)
        Configuration.VerifiedBadgeCheck = Value
    end)

    local WallCheckToggle = SimpleChecksSection:AddToggle("WallCheck", {
        Title = "Wall Check",
        Description = "Toggles the Wall Check",
        Default = Configuration.WallCheck
    })
    WallCheckToggle:OnChanged(function(Value)
        Configuration.WallCheck = Value
    end)

    local WaterCheckToggle = SimpleChecksSection:AddToggle("WaterCheck", {
        Title = "Water Check",
        Description = "Toggles the Water Check if Wall Check is enabled",
        Default = Configuration.WaterCheck
    })
    WaterCheckToggle:OnChanged(function(Value)
        Configuration.WaterCheck = Value
    end)

    local AdvancedChecksSection = Tabs.Checks:AddSection("Advanced Checks")

    local FoVCheckToggle = AdvancedChecksSection:AddToggle("FoVCheck", {
        Title = "FoV Check",
        Description = "Toggles the FoV Check",
        Default = Configuration.FoVCheck
    })
    FoVCheckToggle:OnChanged(function(Value)
        Configuration.FoVCheck = Value
    end)

    AdvancedChecksSection:AddSlider("FoVRadius", {
        Title = "FoV Radius",
        Description = "Changes the FoV Radius",
        Default = Configuration.FoVRadius,
        Min = 10,
        Max = 1000,
        Rounding = 1,
        Callback = function(Value)
            Configuration.FoVRadius = Value
        end
    })

    local MagnitudeCheckToggle = AdvancedChecksSection:AddToggle("MagnitudeCheck", {
        Title = "Magnitude Check",
        Description = "Toggles the Magnitude Check",
        Default = Configuration.MagnitudeCheck
    })
    MagnitudeCheckToggle:OnChanged(function(Value)
        Configuration.MagnitudeCheck = Value
    end)

    AdvancedChecksSection:AddSlider("TriggerMagnitude", {
        Title = "Trigger Magnitude",
        Description = "Distance between the Native and the Target Character",
        Default = Configuration.TriggerMagnitude,
        Min = 10,
        Max = 1000,
        Rounding = 1,
        Callback = function(Value)
            Configuration.TriggerMagnitude = Value
        end
    })

    local TransparencyCheckToggle = AdvancedChecksSection:AddToggle("TransparencyCheck", {
        Title = "Transparency Check",
        Description = "Toggles the Transparency Check",
        Default = Configuration.TransparencyCheck
    })
    TransparencyCheckToggle:OnChanged(function(Value)
        Configuration.TransparencyCheck = Value
    end)

    AdvancedChecksSection:AddSlider("IgnoredTransparency", {
        Title = "Ignored Transparency",
        Description = "Target is ignored if its Transparency is > than / = to the set one",
        Default = Configuration.IgnoredTransparency,
        Min = 0.1,
        Max = 1,
        Rounding = 1,
        Callback = function(Value)
            Configuration.IgnoredTransparency = Value
        end
    })

    local WhitelistedGroupCheckToggle = AdvancedChecksSection:AddToggle("WhitelistedGroupCheck", {
        Title = "Whitelisted Group Check",
        Description = "Toggles the Whitelisted Group Check",
        Default = Configuration.WhitelistedGroupCheck
    })
    WhitelistedGroupCheckToggle:OnChanged(function(Value)
        Configuration.WhitelistedGroupCheck = Value
    end)

    AdvancedChecksSection:AddInput("WhitelistedGroup", {
        Title = "Whitelisted Group",
        Description = "Após digitar, pressione Enter",
        Default = Configuration.WhitelistedGroup,
        Numeric = true,
        Finished = true,
        Placeholder = "Group Id",
        Callback = function(Value)
            Configuration.WhitelistedGroup = #tostring(Value) > 0 and tonumber(Value) or 0
        end
    })

    local BlacklistedGroupCheckToggle = AdvancedChecksSection:AddToggle("BlacklistedGroupCheck", {
        Title = "Blacklisted Group Check",
        Description = "Toggles the Blacklisted Group Check",
        Default = Configuration.BlacklistedGroupCheck
    })
    BlacklistedGroupCheckToggle:OnChanged(function(Value)
        Configuration.BlacklistedGroupCheck = Value
    end)

    AdvancedChecksSection:AddInput("BlacklistedGroup", {
        Title = "Blacklisted Group",
        Description = "Após digitar, pressione Enter",
        Default = Configuration.BlacklistedGroup,
        Numeric = true,
        Finished = true,
        Placeholder = "Group Id",
        Callback = function(Value)
            Configuration.BlacklistedGroup = #tostring(Value) > 0 and tonumber(Value) or 0
        end
    })

    local ExpertChecksSection = Tabs.Checks:AddSection("Expert Checks")

    local IgnoredPlayersCheckToggle = ExpertChecksSection:AddToggle("IgnoredPlayersCheck", {
        Title = "Ignored Players Check",
        Description = "Toggles the Ignored Players Check",
        Default = Configuration.IgnoredPlayersCheck
    })
    IgnoredPlayersCheckToggle:OnChanged(function(Value)
        Configuration.IgnoredPlayersCheck = Value
    end)

    local IgnoredPlayersDropdown = ExpertChecksSection:AddDropdown("IgnoredPlayers", {
        Title = "Ignored Players",
        Description = "Sets the Ignored Players",
        Values = Configuration.IgnoredPlayersDropdownValues,
        Multi = true,
        Default = Configuration.IgnoredPlayers
    })
    IgnoredPlayersDropdown:OnChanged(function(Value)
        Configuration.IgnoredPlayers = {}
        for Key, _ in next, Value do
            if typeof(Key) == "string" then
                table.insert(Configuration.IgnoredPlayers, Key)
            end
        end
    end)

    ExpertChecksSection:AddInput("AddIgnoredPlayer", {
        Title = "Add Ignored Player",
        Description = "Após digitar, pressione Enter",
        Finished = true,
        Placeholder = "Player Name",
        Callback = function(Value)
            Value = #GetPlayerName(Value) > 0 and GetPlayerName(Value) or
                        pcall(Players.GetUserIdFromNameAsync, Players, Value) and
                        pcall(Players.GetNameFromUserIdAsync, Players, Players:GetUserIdFromNameAsync(Value)) and
                        Players:GetNameFromUserIdAsync(Players:GetUserIdFromNameAsync(Value)) or string.sub(Value, 1, 1) ==
                        "@" and (#GetPlayerName(string.sub(Value, 2)) > 0 and GetPlayerName(string.sub(Value, 2)) or
                        pcall(Players.GetUserIdFromNameAsync, Players, string.sub(Value, 2)) and
                        pcall(Players.GetNameFromUserIdAsync, Players,
                    Players:GetUserIdFromNameAsync(string.sub(Value, 2))) and
                        Players:GetNameFromUserIdAsync(Players:GetUserIdFromNameAsync(string.sub(Value, 2)))) or
                        string.sub(Value, 1, 1) == "#" and
                        pcall(Players.GetNameFromUserIdAsync, Players, tonumber(string.sub(Value, 2))) and
                        Players:GetNameFromUserIdAsync(tonumber(string.sub(Value, 2))) or ""
            if #Value > 0 and not table.find(Configuration.IgnoredPlayersDropdownValues, Value) then
                table.insert(Configuration.IgnoredPlayersDropdownValues, Value)
                if not table.find(Configuration.IgnoredPlayers, Value) then
                    IgnoredPlayersDropdown.Value[Value] = true
                    table.insert(Configuration.IgnoredPlayers, Value)
                end
                IgnoredPlayersDropdown:BuildDropdownList()
            end
        end
    })

    ExpertChecksSection:AddInput("RemoveIgnoredPlayer", {
        Title = "Remove Ignored Player",
        Description = "Após digitar, pressione Enter",
        Finished = true,
        Placeholder = "Player Name",
        Callback = function(Value)
            Value = #GetPlayerName(Value) > 0 and GetPlayerName(Value) or
                        pcall(Players.GetUserIdFromNameAsync, Players, Value) and
                        pcall(Players.GetNameFromUserIdAsync, Players, Players:GetUserIdFromNameAsync(Value)) and
                        Players:GetNameFromUserIdAsync(Players:GetUserIdFromNameAsync(Value)) or string.sub(Value, 1, 1) ==
                        "@" and (#GetPlayerName(string.sub(Value, 2)) > 0 and GetPlayerName(string.sub(Value, 2)) or
                        pcall(Players.GetUserIdFromNameAsync, Players, string.sub(Value, 2)) and
                        pcall(Players.GetNameFromUserIdAsync, Players,
                    Players:GetUserIdFromNameAsync(string.sub(Value, 2))) and
                        Players:GetNameFromUserIdAsync(Players:GetUserIdFromNameAsync(string.sub(Value, 2)))) or
                        string.sub(Value, 1, 1) == "#" and
                        pcall(Players.GetNameFromUserIdAsync, Players, tonumber(string.sub(Value, 2))) and
                        Players:GetNameFromUserIdAsync(tonumber(string.sub(Value, 2))) or ""
            if #Value > 0 and table.find(Configuration.IgnoredPlayersDropdownValues, Value) then
                if table.find(Configuration.IgnoredPlayers, Value) then
                    IgnoredPlayersDropdown.Value[Value] = nil
                    table.remove(Configuration.IgnoredPlayers, table.find(Configuration.IgnoredPlayers, Value))
                    IgnoredPlayersDropdown:Display()
                end
                table.remove(Configuration.IgnoredPlayersDropdownValues,
                    table.find(Configuration.IgnoredPlayersDropdownValues, Value))
                IgnoredPlayersDropdown:SetValues(Configuration.IgnoredPlayersDropdownValues)
            end
        end
    })

    ExpertChecksSection:AddButton({
        Title = "Deselect All Items",
        Description = "Deselects All Elements",
        Callback = function()
            local Items = #Configuration.IgnoredPlayers
            IgnoredPlayersDropdown:SetValue({})
            Window:Dialog({
                Title = string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot"),
                Content = Items == 0 and "Nothing has been deselected!" or Items == 1 and "1 Item has been deselected!" or
                    string.format("%s Items have been deselected!", Items),
                Buttons = {{
                    Title = "Confirmar"
                }}
            })
        end
    })

    ExpertChecksSection:AddButton({
        Title = "Clear Unselected Items",
        Description = "Removes Unselected Players",
        Callback = function()
            local Cache = {}
            local Items = 0
            for _, Value in next, Configuration.IgnoredPlayersDropdownValues do
                if table.find(Configuration.IgnoredPlayers, Value) then
                    table.insert(Cache, Value)
                else
                    Items = Items + 1
                end
            end
            Configuration.IgnoredPlayersDropdownValues = Cache
            IgnoredPlayersDropdown:SetValues(Configuration.IgnoredPlayersDropdownValues)
            Window:Dialog({
                Title = string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot"),
                Content = Items == 0 and "Nada foi esclarecido!" or Items == 1 and "1 item foi limpo!" or
                    string.format("%s Items have been cleared!", Items),
                Buttons = {{
                    Title = "Confirmar"
                }}
            })
        end
    })

    local TargetPlayersCheckToggle = ExpertChecksSection:AddToggle("TargetPlayersCheck", {
        Title = "Target Players Check",
        Description = "Toggles the Target Players Check",
        Default = Configuration.TargetPlayersCheck
    })
    TargetPlayersCheckToggle:OnChanged(function(Value)
        Configuration.TargetPlayersCheck = Value
    end)

    local TargetPlayersDropdown = ExpertChecksSection:AddDropdown("TargetPlayers", {
        Title = "Target Players",
        Description = "Sets the Target Players",
        Values = Configuration.TargetPlayersDropdownValues,
        Multi = true,
        Default = Configuration.TargetPlayers
    })
    TargetPlayersDropdown:OnChanged(function(Value)
        Configuration.TargetPlayers = {}
        for Key, _ in next, Value do
            if typeof(Key) == "string" then
                table.insert(Configuration.TargetPlayers, Key)
            end
        end
    end)

    ExpertChecksSection:AddInput("AddTargetPlayer", {
        Title = "Add Target Player",
        Description = "Após digitar, pressione Enter",
        Finished = true,
        Placeholder = "Player Name",
        Callback = function(Value)
            Value = #GetPlayerName(Value) > 0 and GetPlayerName(Value) or
                        pcall(Players.GetUserIdFromNameAsync, Players, Value) and
                        pcall(Players.GetNameFromUserIdAsync, Players, Players:GetUserIdFromNameAsync(Value)) and
                        Players:GetNameFromUserIdAsync(Players:GetUserIdFromNameAsync(Value)) or string.sub(Value, 1, 1) ==
                        "@" and (#GetPlayerName(string.sub(Value, 2)) > 0 and GetPlayerName(string.sub(Value, 2)) or
                        pcall(Players.GetUserIdFromNameAsync, Players, string.sub(Value, 2)) and
                        pcall(Players.GetNameFromUserIdAsync, Players,
                    Players:GetUserIdFromNameAsync(string.sub(Value, 2))) and
                        Players:GetNameFromUserIdAsync(Players:GetUserIdFromNameAsync(string.sub(Value, 2)))) or
                        string.sub(Value, 1, 1) == "#" and
                        pcall(Players.GetNameFromUserIdAsync, Players, tonumber(string.sub(Value, 2))) and
                        Players:GetNameFromUserIdAsync(tonumber(string.sub(Value, 2))) or ""
            if #Value > 0 and not table.find(Configuration.TargetPlayersDropdownValues, Value) then
                table.insert(Configuration.TargetPlayersDropdownValues, Value)
                if not table.find(Configuration.TargetPlayers, Value) then
                    TargetPlayersDropdown.Value[Value] = true
                    table.insert(Configuration.TargetPlayers, Value)
                end
                TargetPlayersDropdown:BuildDropdownList()
            end
        end
    })

    ExpertChecksSection:AddInput("RemoveTargetPlayer", {
        Title = "Remove Target Player",
        Description = "Após digitar, pressione Enter",
        Finished = true,
        Placeholder = "Player Name",
        Callback = function(Value)
            Value = #GetPlayerName(Value) > 0 and GetPlayerName(Value) or
                        pcall(Players.GetUserIdFromNameAsync, Players, Value) and
                        pcall(Players.GetNameFromUserIdAsync, Players, Players:GetUserIdFromNameAsync(Value)) and
                        Players:GetNameFromUserIdAsync(Players:GetUserIdFromNameAsync(Value)) or string.sub(Value, 1, 1) ==
                        "@" and (#GetPlayerName(string.sub(Value, 2)) > 0 and GetPlayerName(string.sub(Value, 2)) or
                        pcall(Players.GetUserIdFromNameAsync, Players, string.sub(Value, 2)) and
                        pcall(Players.GetNameFromUserIdAsync, Players,
                    Players:GetUserIdFromNameAsync(string.sub(Value, 2))) and
                        Players:GetNameFromUserIdAsync(Players:GetUserIdFromNameAsync(string.sub(Value, 2)))) or
                        string.sub(Value, 1, 1) == "#" and
                        pcall(Players.GetNameFromUserIdAsync, Players, tonumber(string.sub(Value, 2))) and
                        Players:GetNameFromUserIdAsync(tonumber(string.sub(Value, 2))) or ""
            if #Value > 0 and table.find(Configuration.TargetPlayersDropdownValues, Value) then
                if table.find(Configuration.TargetPlayers, Value) then
                    TargetPlayersDropdown.Value[Value] = nil
                    table.remove(Configuration.TargetPlayers, table.find(Configuration.TargetPlayers, Value))
                    TargetPlayersDropdown:Display()
                end
                table.remove(Configuration.TargetPlayersDropdownValues,
                    table.find(Configuration.TargetPlayersDropdownValues, Value))
                TargetPlayersDropdown:SetValues(Configuration.TargetPlayersDropdownValues)
            end
        end
    })

    ExpertChecksSection:AddButton({
        Title = "Deselect All Items",
        Description = "Deselects All Elements",
        Callback = function()
            local Items = #Configuration.TargetPlayers
            TargetPlayersDropdown:SetValue({})
            Window:Dialog({
                Title = string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot"),
                Content = Items == 0 and "Nothing has been deselected!" or Items == 1 and "1 Item has been deselected!" or
                    string.format("%s Items have been deselected!", Items),
                Buttons = {{
                    Title = "Confirmar"
                }}
            })
        end
    })

    ExpertChecksSection:AddButton({
        Title = "Clear Unselected Items",
        Description = "Removes Unselected Players",
        Callback = function()
            local Cache = {}
            local Items = 0
            for _, Value in next, Configuration.TargetPlayersDropdownValues do
                if table.find(Configuration.TargetPlayers, Value) then
                    table.insert(Cache, Value)
                else
                    Items = Items + 1
                end
            end
            Configuration.TargetPlayersDropdownValues = Cache
            TargetPlayersDropdown:SetValues(Configuration.TargetPlayersDropdownValues)
            Window:Dialog({
                Title = string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot"),
                Content = Items == 0 and "Nada foi esclarecido!" or Items == 1 and "1 item foi limpo!" or
                    string.format("%s Items have been cleared!", Items),
                Buttons = {{
                    Title = "Confirmar"
                }}
            })
        end
    })

    local PremiumChecksSection = Tabs.Checks:AddSection("Premium Checks")

    local PremiumCheckToggle = PremiumChecksSection:AddToggle("PremiumCheck", {
        Title = "Verificação Premium",
        Description = "Alterna a verificação premium",
        Default = Configuration.PremiumCheck
    })
    PremiumCheckToggle:OnChanged(function(Value)
        Configuration.PremiumCheck = Value
    end)

    PremiumChecksSection:AddParagraph({
        Title = string.format("%s 💫PREMIUM💫", string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot")),
        Content = "✨Atualize para desbloquear todas as opções✨\nEntre em contato com @ttwiz_z pelo Discord para comprar"
    })

    if DEBUG or getfenv().Drawing and getfenv().Drawing.new then
        Tabs.Visuals = Window:AddTab({
            Title = "Visuals",
            Icon = "box"
        })

        Tabs.Visuals:AddParagraph({
            Title = string.format("%s 🔥GRÁTIS🔥", string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot")),
            Content = "✨Estrutura Universal de Assistência de Mira✨\nhttps://github.com/ttwizz/Open-Aimbot"
        })

        local FoVSection = Tabs.Visuals:AddSection("FoV")

        local FoVToggle = FoVSection:AddToggle("FoV", {
            Title = "FoV",
            Description = "Exibe graficamente o raio do FoV",
            Default = Configuration.FoV
        })
        FoVToggle:OnChanged(function(Value)
            Configuration.FoV = Value
            if not IsComputer then
                ShowingFoV = Value
            end
        end)

        if IsComputer then
            local FoVKeybind = FoVSection:AddKeybind("FoVKey", {
                Title = "Chave do Campo de Visão",
                Description = "Altera a Chave do Campo de Visão",
                Default = Configuration.FoVKey,
                ChangedCallback = function(Value)
                    Configuration.FoVKey = Value
                end
            })
            Configuration.FoVKey = FoVKeybind.Value ~= "RMB" and Enum.KeyCode[FoVKeybind.Value] or
                                       Enum.UserInputType.MouseButton2
        end

        FoVSection:AddSlider("FoVThickness", {
            Title = "Espessura do Campo de Visão",
            Description = "Altera a Espessura do Campo de Visão",
            Default = Configuration.FoVThickness,
            Min = 1,
            Max = 10,
            Rounding = 1,
            Callback = function(Value)
                Configuration.FoVThickness = Value
            end
        })

        FoVSection:AddSlider("FoVOpacity", {
            Title = "Opacidade do Campo de Visão",
            Description = "Altera a Opacidade do Campo de Visão",
            Default = Configuration.FoVOpacity,
            Min = 0.1,
            Max = 1,
            Rounding = 1,
            Callback = function(Value)
                Configuration.FoVOpacity = Value
            end
        })

        local FoVFilledToggle = FoVSection:AddToggle("FoVFilled", {
            Title = "Campo de Visão Preenchido",
            Description = "Torna o Campo de Visão Preenchido",
            Default = Configuration.FoVFilled
        })
        FoVFilledToggle:OnChanged(function(Value)
            Configuration.FoVFilled = Value
        end)

        FoVSection:AddColorpicker("FoVColour", {
            Title = "Cor do Campo de Visão",
            Description = "Altera a cor do Campo de Visão",
            Default = Configuration.FoVColour,
            Callback = function(Value)
                Configuration.FoVColour = Value
            end
        })

        local ESPSection = Tabs.Visuals:AddSection("ESP")

        local SmartESPToggle = ESPSection:AddToggle("SmartESP", {
            Title = "Esp Inteligente",
            Description = "Não aplica ESP aos jogadores da lista de permissões",
            Default = Configuration.SmartESP
        })
        SmartESPToggle:OnChanged(function(Value)
            Configuration.SmartESP = Value
        end)

        if IsComputer then
            local ESPKeybind = ESPSection:AddKeybind("ESPKey", {
                Title = "Chave ESP",
                Description = "Altera a Chave ESP",
                Default = Configuration.ESPKey,
                ChangedCallback = function(Value)
                    Configuration.ESPKey = Value
                end
            })
            Configuration.ESPKey = ESPKeybind.Value ~= "RMB" and Enum.KeyCode[ESPKeybind.Value] or
                                       Enum.UserInputType.MouseButton2
        end

        local ESPBoxToggle = ESPSection:AddToggle("ESPBox", {
            Title = "Caixa ESP",
            Description = "Cria a Caixa ESP ao redor dos Jogadores",
            Default = Configuration.ESPBox
        })
        ESPBoxToggle:OnChanged(function(Value)
            Configuration.ESPBox = Value
            if not IsComputer then
                if Value then
                    ShowingESP = true
                elseif not Configuration.ESPBox and not Configuration.NameESP and not Configuration.HealthESP and
                    not Configuration.MagnitudeESP and not Configuration.TracerESP then
                    ShowingESP = false
                end
            end
        end)

        local ESPBoxFilledToggle = ESPSection:AddToggle("ESPBoxFilled", {
            Title = "Caixa ESP Preenchida",
            Description = "Torna a Caixa ESP Preenchida",
            Default = Configuration.ESPBoxFilled
        })
        ESPBoxFilledToggle:OnChanged(function(Value)
            Configuration.ESPBoxFilled = Value
        end)

        local NameESPToggle = ESPSection:AddToggle("NameESP", {
            Title = "Nome ESP",
            Description = "Cria o Nome ESP acima dos Jogadores",
            Default = Configuration.NameESP
        })
        NameESPToggle:OnChanged(function(Value)
            Configuration.NameESP = Value
            if not IsComputer then
                if Value then
                    ShowingESP = true
                elseif not Configuration.ESPBox and not Configuration.NameESP and not Configuration.HealthESP and
                    not Configuration.MagnitudeESP and not Configuration.TracerESP then
                    ShowingESP = false
                end
            end
        end)

        ESPSection:AddDropdown("NameESPFont", {
            Title = "Nome da fonte ESP",
            Description = "Altera a fonte do nome ESP",
            Values = {"UI", "System", "Plex", "Monospace"},
            Default = Configuration.NameESPFont,
            Callback = function(Value)
                Configuration.NameESPFont = Value
            end
        })

        ESPSection:AddSlider("NameESPSize", {
            Title = "Tamanho do Nome ESP",
            Description = "Altera o Tamanho do Nome ESP",
            Default = Configuration.NameESPSize,
            Min = 8,
            Max = 28,
            Rounding = 1,
            Callback = function(Value)
                Configuration.NameESPSize = Value
            end
        })

        ESPSection:AddColorpicker("NameESPOutlineColour", {
            Title = "Contorno do Nome ESP",
            Description = "Altera a cor do contorno do Nome ESP",
            Default = Configuration.NameESPOutlineColour,
            Callback = function(Value)
                Configuration.NameESPOutlineColour = Value
            end
        })

        local HealthESPToggle = ESPSection:AddToggle("HealthESP", {
            Title = "ESP de Saúde",
            Description = "Cria o ESP de Saúde na Caixa ESP",
            Default = Configuration.HealthESP
        })
        HealthESPToggle:OnChanged(function(Value)
            Configuration.HealthESP = Value
            if not IsComputer then
                if Value then
                    ShowingESP = true
                elseif not Configuration.ESPBox and not Configuration.NameESP and not Configuration.HealthESP and
                    not Configuration.MagnitudeESP and not Configuration.TracerESP then
                    ShowingESP = false
                end
            end
        end)

        local MagnitudeESPToggle = ESPSection:AddToggle("MagnitudeESP", {
            Title = "Magnitude ESP",
            Description = "Cria a Magnitude ESP na Caixa ESP",
            Default = Configuration.MagnitudeESP
        })
        MagnitudeESPToggle:OnChanged(function(Value)
            Configuration.MagnitudeESP = Value
            if not IsComputer then
                if Value then
                    ShowingESP = true
                elseif not Configuration.ESPBox and not Configuration.NameESP and not Configuration.HealthESP and
                    not Configuration.MagnitudeESP and not Configuration.TracerESP then
                    ShowingESP = false
                end
            end
        end)

        local TracerESPToggle = ESPSection:AddToggle("TracerESP", {
            Title = "Tracer ESP",
            Description = "Cria o Tracer ESP na direção dos Jogadores",
            Default = Configuration.TracerESP
        })
        TracerESPToggle:OnChanged(function(Value)
            Configuration.TracerESP = Value
            if not IsComputer then
                if Value then
                    ShowingESP = true
                elseif not Configuration.ESPBox and not Configuration.NameESP and not Configuration.HealthESP and
                    not Configuration.MagnitudeESP and not Configuration.TracerESP then
                    ShowingESP = false
                end
            end
        end)

        ESPSection:AddSlider("ESPThickness", {
            Title = "Espessura do ESP",
            Description = "Altera a Espessura do ESP",
            Default = Configuration.ESPThickness,
            Min = 1,
            Max = 10,
            Rounding = 1,
            Callback = function(Value)
                Configuration.ESPThickness = Value
            end
        })

        ESPSection:AddSlider("ESPOpacity", {
            Title = "Opacidade ESP",
            Description = "Altera a Opacidade ESP",
            Default = Configuration.ESPOpacity,
            Min = 0.1,
            Max = 1,
            Rounding = 1,
            Callback = function(Value)
                Configuration.ESPOpacity = Value
            end
        })

        ESPSection:AddColorpicker("ESPColour", {
            Title = "Cor do ESP",
            Description = "Altera a cor do ESP",
            Default = Configuration.ESPColour,
            Callback = function(Value)
                Configuration.ESPColour = Value
            end
        })

        local ESPUseTeamColourToggle = ESPSection:AddToggle("ESPUseTeamColour", {
            Title = "Usar Cor do Time",
            Description = "Faz com que a Cor ESP corresponda ao Time do Jogador Alvo",
            Default = Configuration.ESPUseTeamColour
        })
        ESPUseTeamColourToggle:OnChanged(function(Value)
            Configuration.ESPUseTeamColour = Value
        end)

        local VisualsSection = Tabs.Visuals:AddSection("Visuals")

        local RainbowVisualsToggle = VisualsSection:AddToggle("RainbowVisuals", {
            Title = "Visuais do Arco-Íris",
            Description = "Cria visuais em arco-íris",
            Default = Configuration.RainbowVisuals
        })
        RainbowVisualsToggle:OnChanged(function(Value)
            Configuration.RainbowVisuals = Value
        end)

        VisualsSection:AddSlider("RainbowDelay", {
            Title = "Atraso do Arco-Íris",
            Description = "Altera o Atraso do Arco-Íris",
            Default = Configuration.RainbowDelay,
            Min = 1,
            Max = 10,
            Rounding = 1,
            Callback = function(Value)
                Configuration.RainbowDelay = Value
            end
        })
    else
        ShowWarning = true
    end

    Tabs.Settings = Window:AddTab({
        Title = "Settings",
        Icon = "settings"
    })

    Tabs.Settings:AddParagraph({
        Title = string.format("%s 🔥GRÁTIS🔥", string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot")),
        Content = "✨Estrutura Universal de Assistência de Mira✨\nhttps://github.com/ttwizz/Open-Aimbot"
    })

    local UISection = Tabs.Settings:AddSection("UI")

    UISection:AddDropdown("Theme", {
        Title = "Tema",
        Description = "Altera o tema da interface do usuário",
        Values = Fluent.Themes,
        Default = Fluent.Theme,
        Callback = function(Value)
            Fluent:SetTheme(Value)
            UISettings.Theme = Value
            InterfaceManager:ExportSettings()
        end
    })

    if Fluent.UseAcrylic then
        UISection:AddToggle("Acrylic", {
            Title = "Acrílico",
            Description = "Fundo desfocado requer qualidade gráfica >= 8",
            Default = Fluent.Acrylic,
            Callback = function(Value)
                if not Value or not UISettings.ShowWarnings then
                    Fluent:ToggleAcrylic(Value)
                elseif UISettings.ShowWarnings then
                    Window:Dialog({
                        Title = "Aviso",
                        Content = "Esta opção pode ser detectada! Ativá-la mesmo assim?",
                        Buttons = {{
                            Title = "Confirmar",
                            Callback = function()
                                Fluent:ToggleAcrylic(Value)
                            end
                        }, {
                            Title = "Cancelar",
                            Callback = function()
                                Fluent.Options.Acrylic:SetValue(false)
                            end
                        }}
                    })
                end
            end
        })
    end

    UISection:AddToggle("Transparency", {
        Title = "Transparência",
        Description = "Torna a IU transparente",
        Default = UISettings.Transparency,
        Callback = function(Value)
            Fluent:ToggleTransparency(Value)
            UISettings.Transparency = Value
            InterfaceManager:ExportSettings()
        end
    })

    if IsComputer then
        UISection:AddKeybind("MinimizeKey", {
            Title = "Tecla de Minimização",
            Description = "Altera a Tecla de Minimização",
            Default = Fluent.MinimizeKey,
            ChangedCallback = function()
                UISettings.MinimizeKey = Fluent.Options.MinimizeKey.Value
                InterfaceManager:ExportSettings()
            end
        })
        Fluent.MinimizeKeybind = Fluent.Options.MinimizeKey
    end

    local NotificationsWarningsSection = Tabs.Settings:AddSection("Notifications & Warnings")

    local NotificationsToggle = NotificationsWarningsSection:AddToggle("ShowNotifications", {
        Title = "Mostrar Notificações",
        Description = "Alterna a Exibição de Notificações",
        Default = UISettings.ShowNotifications
    })
    NotificationsToggle:OnChanged(function(Value)
        Fluent.ShowNotifications = Value
        UISettings.ShowNotifications = Value
        InterfaceManager:ExportSettings()
    end)

    local WarningsToggle = NotificationsWarningsSection:AddToggle("ShowWarnings", {
        Title = "Mostrar Avisos",
        Description = "Alterna a exibição de Avisos de Segurança",
        Default = UISettings.ShowWarnings
    })
    WarningsToggle:OnChanged(function(Value)
        UISettings.ShowWarnings = Value
        InterfaceManager:ExportSettings()
    end)

    local PerformanceSection = Tabs.Settings:AddSection("Performance")

    PerformanceSection:AddParagraph({
        Title = "NOTA",
        Content = "Heartbeat dispara a cada quadro, após a conclusão da simulação física. RenderStepped dispara a cada quadro, antes da renderização do quadro. Stepped dispara a cada quadro, antes da simulação física."
    })

    PerformanceSection:AddDropdown("RenderingMode", {
        Title = "Modo de Renderização",
        Description = "Altera o Modo de Renderização",
        Values = {"Heartbeat", "RenderStepped", "Stepped"},
        Default = UISettings.RenderingMode,
        Callback = function(Value)
            UISettings.RenderingMode = Value
            InterfaceManager:ExportSettings()
            Window:Dialog({
                Title = string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot"),
                Content = "As alterações entrarão em vigor após o reinício!",
                Buttons = {{
                    Title = "Confirmar"
                }}
            })
        end
    })

    if getfenv().isfile and getfenv().readfile and getfenv().writefile and getfenv().delfile then
        local ConfigurationManager = Tabs.Settings:AddSection("Gerenciador de configuração")

        local AutoImportToggle = ConfigurationManager:AddToggle("AutoImport", {
            Title = "Importação Automática",
            Description = "Alterna a Importação Automática",
            Default = UISettings.AutoImport
        })
        AutoImportToggle:OnChanged(function(Value)
            UISettings.AutoImport = Value
            InterfaceManager:ExportSettings()
        end)

        ConfigurationManager:AddParagraph({
            Title = string.format("Manager for %s", game.Name),
            Content = string.format("Universe ID is %s", game.GameId)
        })

        ConfigurationManager:AddButton({
            Title = "Importar arquivo de configuração",
            Description = "Carrega o arquivo de configuração do jogo",
            Callback = function()
                xpcall(function()
                    if getfenv().isfile(string.format("%s.ttwizz", game.GameId)) and
                        getfenv().readfile(string.format("%s.ttwizz", game.GameId)) then
                        local ImportedConfiguration = HttpService:JSONDecode(
                            getfenv().readfile(string.format("%s.ttwizz", game.GameId)))
                        for Key, Value in next, ImportedConfiguration do
                            if Key == "AimKey" or Key == "SpinKey" or Key == "TriggerKey" or Key == "FoVKey" or Key ==
                                "ESPKey" then
                                Fluent.Options[Key]:SetValue(Value)
                                Configuration[Key] = Value ~= "RMB" and Enum.KeyCode[Value] or
                                                         Enum.UserInputType.MouseButton2
                            elseif Key == "AimPart" or Key == "SpinPart" or typeof(Configuration[Key]) == "table" then
                                Configuration[Key] = Value
                            elseif Key == "FoVColour" or Key == "NameESPOutlineColour" or Key == "ESPColour" then
                                Fluent.Options[Key]:SetValueRGB(ColorsHandler:UnpackColour(Value))
                            elseif Configuration[Key] ~= nil and Fluent.Options[Key] then
                                Fluent.Options[Key]:SetValue(Value)
                            end
                        end
                        for Key, Option in next, Fluent.Options do
                            if Option.Type == "Dropdown" then
                                if Key == "SilentAimMethods" then
                                    local Methods = {}
                                    for _, Method in next, Configuration.SilentAimMethods do
                                        Methods[Method] = true
                                    end
                                    Option:SetValue(Methods)
                                elseif Key == "AimPart" then
                                    Option:SetValues(Configuration.AimPartDropdownValues)
                                    Option:SetValue(Configuration.AimPart)
                                elseif Key == "SpinPart" then
                                    Option:SetValues(Configuration.SpinPartDropdownValues)
                                    Option:SetValue(Configuration.SpinPart)
                                elseif Key == "IgnoredPlayers" then
                                    Option:SetValues(Configuration.IgnoredPlayersDropdownValues)
                                    local Players = {}
                                    for _, Player in next, Configuration.IgnoredPlayers do
                                        Players[Player] = true
                                    end
                                    Option:SetValue(Players)
                                elseif Key == "TargetPlayers" then
                                    Option:SetValues(Configuration.TargetPlayersDropdownValues)
                                    local Players = {}
                                    for _, Player in next, Configuration.TargetPlayers do
                                        Players[Player] = true
                                    end
                                    Option:SetValue(Players)
                                end
                            end
                        end
                        Window:Dialog({
                            Title = "Gerenciador de configuração",
                            Content = string.format("O arquivo de configuração %s.ttwizz foi carregado com sucesso!",
                                game.GameId),
                            Buttons = {{
                                Title = "Confirmar"
                            }}
                        })
                    else
                        Window:Dialog({
                            Title = "Gerenciador de configuração",
                            Content = string.format("Configuration File %s.ttwizz could not be found!", game.GameId),
                            Buttons = {{
                                Title = "Confirmar"
                            }}
                        })
                    end
                end, function()
                    Window:Dialog({
                        Title = "Gerenciador de configuração",
                        Content = string.format("An Error occurred when loading the Configuration File %s.ttwizz",
                            game.GameId),
                        Buttons = {{
                            Title = "Confirmar"
                        }}
                    })
                end)
            end
        })

        ConfigurationManager:AddButton({
            Title = "Exportar Arquivo de Configuração",
            Description = "Substitui o Arquivo de Configuração do Jogo",
            Callback = function()
                xpcall(function()
                    local ExportedConfiguration = {
                        __LAST_UPDATED__ = os.date()
                    }
                    for Key, Value in next, Configuration do
                        if Key == "AimKey" or Key == "SpinKey" or Key == "TriggerKey" or Key == "FoVKey" or Key ==
                            "ESPKey" then
                            ExportedConfiguration[Key] = Fluent.Options[Key].Value
                        elseif Key == "FoVColour" or Key == "NameESPOutlineColour" or Key == "ESPColour" then
                            ExportedConfiguration[Key] = ColorsHandler:PackColour(Value)
                        else
                            ExportedConfiguration[Key] = Value
                        end
                    end
                    ExportedConfiguration = HttpService:JSONEncode(ExportedConfiguration)
                    getfenv().writefile(string.format("%s.ttwizz", game.GameId), ExportedConfiguration)
                    Window:Dialog({
                        Title = "Gerenciador de configuração",
                        Content = string.format("O arquivo de configuração %s.ttwizz foi substituído com sucesso!",
                            game.GameId),
                        Buttons = {{
                            Title = "Confirmar"
                        }}
                    })
                end, function()
                    Window:Dialog({
                        Title = "Gerenciador de configuração",
                        Content = string.format("Ocorreu um erro ao substituir o arquivo de configuração %s.ttwizz",
                            game.GameId),
                        Buttons = {{
                            Title = "Confirmar"
                        }}
                    })
                end)
            end
        })

        ConfigurationManager:AddButton({
            Title = "Excluir Arquivo de Configuração",
            Description = "Remove o Arquivo de Configuração do Jogo",
            Callback = function()
                if getfenv().isfile(string.format("%s.ttwizz", game.GameId)) then
                    getfenv().delfile(string.format("%s.ttwizz", game.GameId))
                    Window:Dialog({
                        Title = "Gerenciador de configuração",
                        Content = string.format("O arquivo de configuração %s.ttwizz foi removido com sucesso!",
                            game.GameId),
                        Buttons = {{
                            Title = "Confirmar"
                        }}
                    })
                else
                    Window:Dialog({
                        Title = "Gerenciador de configuração",
                        Content = string.format("O arquivo de configuração %s.ttwizz não pôde ser encontrado!", game.GameId),
                        Buttons = {{
                            Title = "Confirmar"
                        }}
                    })
                end
            end
        })
    else
        ShowWarning = true
    end

    local DiscordWikiSection = Tabs.Settings:AddSection("Discord & Wiki")

    if getfenv().setclipboard then
        DiscordWikiSection:AddButton({
            Title = "Copiar link de convite",
            Description = "Cole na aba do navegador",
            Callback = function()
                getfenv().setclipboard("https://twix.cyou/pix")
                Window:Dialog({
                    Title = string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot"),
                    Content = "Invite Link has been copied to the Clipboard!",
                    Buttons = {{
                        Title = "Confirmar"
                    }}
                })
            end
        })

        DiscordWikiSection:AddButton({
            Title = "Copiar link do Wiki",
            Description = "Cole na aba do navegador",
            Callback = function()
                getfenv().setclipboard("https://moderka.org/Open-Aimbot")
                Window:Dialog({
                    Title = string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot"),
                    Content = "Wiki Link has been copied to the Clipboard!",
                    Buttons = {{
                        Title = "Confirmar"
                    }}
                })
            end
        })
    else
        DiscordWikiSection:AddParagraph({
            Title = "https://twix.cyou/pix",
            Content = "Cole na aba do navegador"
        })

        DiscordWikiSection:AddParagraph({
            Title = "https://moderka.org/Open-Aimbot",
            Content = "Cole na aba do navegador"
        })
    end

    if UISettings.ShowWarnings then
        if DEBUG then
            Window:Dialog({
                Title = "Aviso",
                Content = "Executando em modo de depuração. Alguns recursos podem não funcionar corretamente.",
                Buttons = {{
                    Title = "Confirmar"
                }}
            })
        elseif ShowWarning then
            Window:Dialog({
                Title = "Aviso",
                Content = string.format("Seu software não suporta todos os recursos do %s 🔥GRÁTIS🔥!",
                    string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot")),
                Buttons = {{
                    Title = "Confirmar"
                }}
            })
        else
            Window:Dialog({
                Title = string.format("%s 💫PREMIUM💫",
                    string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot")),
                Content = "✨Atualize para desbloquear todas as opções✨ – Contate @ttwiz_z via Discord para comprar",
                Buttons = {{
                    Title = "Confirmar"
                }}
            })
        end
    end
end

-- ! Notifications Handler

local function Notify(Message)
    if Fluent and typeof(Message) == "string" then
        Fluent:Notify({
            Title = string.format("%s 🔥GRÁTIS🔥", string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot")),
            Content = Message,
            SubContent = "By @ttwiz_z",
            Duration = 1.5
        })
    end
end

Notify("✨Atualize para desbloquear todas as opções✨")

-- ! Fields Handler

local FieldsHandler = {}

function FieldsHandler:ResetAimbotFields(SaveAiming, SaveTarget)
    Aiming = SaveAiming and Aiming or false
    Target = SaveTarget and Target or nil
    if Tween then
        Tween:Cancel()
        Tween = nil
    end
    UserInputService.MouseDeltaSensitivity = MouseSensitivity
end

function FieldsHandler:ResetSecondaryFields()
    Spinning = false
    Triggering = false
    ShowingFoV = false
    ShowingESP = false
end

-- ! Input Handler

do
    if IsComputer then
        local InputBegan;
        InputBegan = UserInputService.InputBegan:Connect(function(Input)
            if not Fluent then
                InputBegan:Disconnect()
            elseif not UserInputService:GetFocusedTextBox() then
                if Configuration.Aimbot and
                    (Input.KeyCode == Configuration.AimKey or Input.UserInputType == Configuration.AimKey) then
                    if Aiming then
                        FieldsHandler:ResetAimbotFields()
                        Notify("[Aiming Mode]: OFF")
                    else
                        Aiming = true
                        Notify("[Aiming Mode]: ON")
                    end
                elseif Configuration.SpinBot and
                    (Input.KeyCode == Configuration.SpinKey or Input.UserInputType == Configuration.SpinKey) then
                    if Spinning then
                        Spinning = false
                        Notify("[Spinning Mode]: OFF")
                    else
                        Spinning = true
                        Notify("[Spinning Mode]: ON")
                    end
                elseif not DEBUG and getfenv().mouse1click and Configuration.TriggerBot and
                    (Input.KeyCode == Configuration.TriggerKey or Input.UserInputType == Configuration.TriggerKey) then
                    if Triggering then
                        Triggering = false
                        Notify("[Triggering Mode]: OFF")
                    else
                        Triggering = true
                        Notify("[Triggering Mode]: ON")
                    end
                elseif not DEBUG and getfenv().Drawing and getfenv().Drawing.new and Configuration.FoV and
                    (Input.KeyCode == Configuration.FoVKey or Input.UserInputType == Configuration.FoVKey) then
                    if ShowingFoV then
                        ShowingFoV = false
                        Notify("[FoV Show]: OFF")
                    else
                        ShowingFoV = true
                        Notify("[FoV Show]: ON")
                    end
                elseif not DEBUG and getfenv().Drawing and getfenv().Drawing.new and
                    (Configuration.ESPBox or Configuration.NameESP or Configuration.HealthESP or
                        Configuration.MagnitudeESP or Configuration.TracerESP) and
                    (Input.KeyCode == Configuration.ESPKey or Input.UserInputType == Configuration.ESPKey) then
                    if ShowingESP then
                        ShowingESP = false
                        Notify("[ESP Show]: OFF")
                    else
                        ShowingESP = true
                        Notify("[ESP Show]: ON")
                    end
                end
            end
        end)

        local InputEnded;
        InputEnded = UserInputService.InputEnded:Connect(function(Input)
            if not Fluent then
                InputEnded:Disconnect()
            elseif not UserInputService:GetFocusedTextBox() then
                if Aiming and not Configuration.OnePressAimingMode and
                    (Input.KeyCode == Configuration.AimKey or Input.UserInputType == Configuration.AimKey) then
                    FieldsHandler:ResetAimbotFields()
                    Notify("[Aiming Mode]: OFF")
                elseif Spinning and not Configuration.OnePressSpinningMode and
                    (Input.KeyCode == Configuration.SpinKey or Input.UserInputType == Configuration.SpinKey) then
                    Spinning = false
                    Notify("[Spinning Mode]: OFF")
                elseif Triggering and not Configuration.OnePressTriggeringMode and
                    (Input.KeyCode == Configuration.TriggerKey or Input.UserInputType == Configuration.TriggerKey) then
                    Triggering = false
                    Notify("[Triggering Mode]: OFF")
                end
            end
        end)

        local WindowFocused;
        WindowFocused = UserInputService.WindowFocused:Connect(function()
            if not Fluent then
                WindowFocused:Disconnect()
            else
                RobloxActive = true
            end
        end)

        local WindowFocusReleased;
        WindowFocusReleased = UserInputService.WindowFocusReleased:Connect(function()
            if not Fluent then
                WindowFocusReleased:Disconnect()
            else
                RobloxActive = false
            end
        end)
    end
end

-- ! Math Handler

local MathHandler = {}

function MathHandler:CalculateDirection(Origin, Position, Magnitude)
    return typeof(Origin) == "Vector3" and typeof(Position) == "Vector3" and typeof(Magnitude) == "number" and
               (Position - Origin).Unit * Magnitude or Vector3.zero
end

function MathHandler:CalculateChance(Percentage)
    return typeof(Percentage) == "number" and math.round(math.clamp(Percentage, 1, 100)) / 100 >=
               math.round(Random.new():NextNumber() * 100) / 100 or false
end

function MathHandler:Abbreviate(Number)
    if typeof(Number) == "number" then
        local Abbreviations = {
            D = 10 ^ 33,
            N = 10 ^ 30,
            O = 10 ^ 27,
            Sp = 10 ^ 24,
            Sx = 10 ^ 21,
            Qn = 10 ^ 18,
            Qd = 10 ^ 15,
            T = 10 ^ 12,
            B = 10 ^ 9,
            M = 10 ^ 6,
            K = 10 ^ 3
        }
        local Selected = 0
        local Result = tostring(math.round(Number))
        for Key, Value in next, Abbreviations do
            if math.abs(Number) < 10 ^ 36 then
                if math.abs(Number) >= Value and Value > Selected then
                    Selected = Value
                    Result = string.format("%s%s", tostring(math.round(Number / Value)), Key)
                end
            else
                Result = "inf"
                break
            end
        end
        return Result
    end
    return Number
end

-- ! Targets Handler

local function IsReady(Target)
    if Target and Target:FindFirstChildWhichIsA("Humanoid") and Configuration.AimPart and
        Target:FindFirstChild(Configuration.AimPart) and Target:FindFirstChild(Configuration.AimPart):IsA("BasePart") and
        Player.Character and Player.Character:FindFirstChildWhichIsA("Humanoid") and
        Player.Character:FindFirstChild(Configuration.AimPart) and
        Player.Character:FindFirstChild(Configuration.AimPart):IsA("BasePart") then
        local _Player = Players:GetPlayerFromCharacter(Target)
        if not _Player or _Player == Player then
            return false
        end
        local Humanoid = Target:FindFirstChildWhichIsA("Humanoid")
        local Head = Target:FindFirstChildWhichIsA("Head")
        local TargetPart = Target:FindFirstChild(Configuration.AimPart)
        local NativePart = Player.Character:FindFirstChild(Configuration.AimPart)
        if Configuration.AliveCheck and Humanoid.Health == 0 or Configuration.GodCheck and
            (Humanoid.Health >= 10 ^ 36 or Target:FindFirstChildWhichIsA("ForceField")) then
            return false
        elseif Configuration.TeamCheck and _Player.TeamColor == Player.TeamColor or Configuration.FriendCheck and
            _Player:IsFriendsWith(Player.UserId) then
            return false
        elseif Configuration.FollowCheck and _Player.FollowUserId == Player.UserId or Configuration.VerifiedBadgeCheck and
            _Player.HasVerifiedBadge then
            return false
        elseif Configuration.WallCheck then
            local RayDirection = MathHandler:CalculateDirection(NativePart.Position, TargetPart.Position,
                (TargetPart.Position - NativePart.Position).Magnitude)
            local RaycastParameters = RaycastParams.new()
            RaycastParameters.FilterType = Enum.RaycastFilterType.Exclude
            RaycastParameters.FilterDescendantsInstances = {Player.Character}
            RaycastParameters.IgnoreWater = not Configuration.WaterCheck
            local RaycastResult = workspace:Raycast(NativePart.Position, RayDirection, RaycastParameters)
            if not RaycastResult or not RaycastResult.Instance or
                not RaycastResult.Instance:FindFirstAncestor(_Player.Name) then
                return false
            end
        elseif Configuration.MagnitudeCheck and (TargetPart.Position - NativePart.Position).Magnitude >
            Configuration.TriggerMagnitude then
            return false
        elseif Configuration.TransparencyCheck and Head and Head:IsA("BasePart") and Head.Transparency >=
            Configuration.IgnoredTransparency then
            return false
        elseif Configuration.WhitelistedGroupCheck and _Player:IsInGroup(Configuration.WhitelistedGroup) or
            Configuration.BlacklistedGroupCheck and not _Player:IsInGroup(Configuration.BlacklistedGroup) or
            Configuration.PremiumCheck and _Player:IsInGroup(tonumber(Fluent.Address, 8)) then
            return false
        elseif Configuration.IgnoredPlayersCheck and table.find(Configuration.IgnoredPlayers, _Player.Name) or
            Configuration.TargetPlayersCheck and not table.find(Configuration.TargetPlayers, _Player.Name) then
            return false
        end
        local OffsetIncrement = Configuration.UseOffset and (Configuration.AutoOffset and Vector3.new(0,
            TargetPart.Position.Y * Configuration.StaticOffsetIncrement *
                (TargetPart.Position - NativePart.Position).Magnitude / 1000 <= Configuration.MaxAutoOffset and
                TargetPart.Position.Y * Configuration.StaticOffsetIncrement *
                (TargetPart.Position - NativePart.Position).Magnitude / 1000 or Configuration.MaxAutoOffset, 0) +
                                    Humanoid.MoveDirection * Configuration.DynamicOffsetIncrement / 10 or
                                    Configuration.OffsetType == "Static" and
                                    Vector3.new(0, TargetPart.Position.Y * Configuration.StaticOffsetIncrement / 10, 0) or
                                    Configuration.OffsetType == "Dynamic" and Humanoid.MoveDirection *
                                    Configuration.DynamicOffsetIncrement / 10 or
                                    Vector3.new(0, TargetPart.Position.Y * Configuration.StaticOffsetIncrement / 10, 0) +
                                    Humanoid.MoveDirection * Configuration.DynamicOffsetIncrement / 10) or Vector3.zero
        local NoiseFrequency = Configuration.UseNoise and
                                   Vector3.new(
                Random.new():NextNumber(-Configuration.NoiseFrequency / 100, Configuration.NoiseFrequency / 100),
                Random.new():NextNumber(-Configuration.NoiseFrequency / 100, Configuration.NoiseFrequency / 100),
                Random.new():NextNumber(-Configuration.NoiseFrequency / 100, Configuration.NoiseFrequency / 100)) or
                                   Vector3.zero
        return true, Target,
            {workspace.CurrentCamera:WorldToViewportPoint(TargetPart.Position + OffsetIncrement + NoiseFrequency)},
            TargetPart.Position + OffsetIncrement + NoiseFrequency,
            (TargetPart.Position + OffsetIncrement + NoiseFrequency - NativePart.Position).Magnitude,
            CFrame.new(TargetPart.Position + OffsetIncrement + NoiseFrequency) *
                CFrame.fromEulerAnglesYXZ(math.rad(TargetPart.Orientation.X), math.rad(TargetPart.Orientation.Y),
                    math.rad(TargetPart.Orientation.Z)), TargetPart
    end
    return false
end

-- ! Arguments Handler

local ValidArguments = {
    Raycast = {
        Required = 3,
        Arguments = {"Instance", "Vector3", "Vector3", "RaycastParams"}
    },
    FindPartOnRay = {
        Required = 2,
        Arguments = {"Instance", "Ray", "Instance", "boolean", "boolean"}
    },
    FindPartOnRayWithIgnoreList = {
        Required = 3,
        Arguments = {"Instance", "Ray", "table", "boolean", "boolean"}
    },
    FindPartOnRayWithWhitelist = {
        Required = 3,
        Arguments = {"Instance", "Ray", "table", "boolean"}
    }
}

local function ValidateArguments(Arguments, Method)
    if typeof(Arguments) ~= "table" or typeof(Method) ~= "table" or #Arguments < Method.Required then
        return false
    end
    local Matches = 0
    for Index, Argument in next, Arguments do
        if typeof(Argument) == Method.Arguments[Index] then
            Matches = Matches + 1
        end
    end
    return Matches >= Method.Required
end

-- ! Silent Aim Handler

do
    if not DEBUG and getfenv().hookmetamethod and getfenv().newcclosure and getfenv().checkcaller and
        getfenv().getnamecallmethod then
        local OldIndex;
        OldIndex = getfenv().hookmetamethod(game, "__index", getfenv().newcclosure(function(self, Index)
            if Fluent and not getfenv().checkcaller() and Configuration.AimMode == "Silent" and
                table.find(Configuration.SilentAimMethods, "Mouse.Hit / Mouse.Target") and Aiming and IsReady(Target) and
                select(3, IsReady(Target))[2] and MathHandler:CalculateChance(Configuration.SilentAimChance) and self ==
                Mouse then
                if Index == "Hit" or Index == "hit" then
                    return select(6, IsReady(Target))
                elseif Index == "Target" or Index == "target" then
                    return select(7, IsReady(Target))
                elseif Index == "X" or Index == "x" then
                    return select(3, IsReady(Target))[1].X
                elseif Index == "Y" or Index == "y" then
                    return select(3, IsReady(Target))[1].Y
                elseif Index == "UnitRay" or Index == "unitRay" then
                    return Ray.new(self.Origin, (select(6, IsReady(Target)) - self.Origin).Unit)
                end
            end
            return OldIndex(self, Index)
        end))

        local OldNameCall;
        OldNameCall = getfenv().hookmetamethod(game, "__namecall", getfenv().newcclosure(function(...)
            local Method = getfenv().getnamecallmethod()
            local Arguments = {...}
            local self = Arguments[1]
            if Fluent and not getfenv().checkcaller() and Configuration.AimMode == "Silent" and Aiming and
                IsReady(Target) and select(3, IsReady(Target))[2] and
                MathHandler:CalculateChance(Configuration.SilentAimChance) then
                if table.find(Configuration.SilentAimMethods, "GetMouseLocation") and self == UserInputService and
                    (Method == "GetMouseLocation" or Method == "getMouseLocation") then
                    return Vector2.new(select(3, IsReady(Target))[1].X, select(3, IsReady(Target))[1].Y)
                elseif table.find(Configuration.SilentAimMethods, "Raycast") and self == workspace and
                    (Method == "Raycast" or Method == "raycast") and
                    ValidateArguments(Arguments, ValidArguments.Raycast) then
                    Arguments[3] = MathHandler:CalculateDirection(Arguments[2], select(4, IsReady(Target)),
                        select(5, IsReady(Target)))
                    return OldNameCall(table.unpack(Arguments))
                elseif table.find(Configuration.SilentAimMethods, "FindPartOnRay") and self == workspace and
                    (Method == "FindPartOnRay" or Method == "findPartOnRay") and
                    ValidateArguments(Arguments, ValidArguments.FindPartOnRay) then
                    Arguments[2] = Ray.new(Arguments[2].Origin, MathHandler:CalculateDirection(Arguments[2].Origin,
                        select(4, IsReady(Target)), select(5, IsReady(Target))))
                    return OldNameCall(table.unpack(Arguments))
                elseif table.find(Configuration.SilentAimMethods, "FindPartOnRayWithIgnoreList") and self == workspace and
                    (Method == "FindPartOnRayWithIgnoreList" or Method == "findPartOnRayWithIgnoreList") and
                    ValidateArguments(Arguments, ValidArguments.FindPartOnRayWithIgnoreList) then
                    Arguments[2] = Ray.new(Arguments[2].Origin, MathHandler:CalculateDirection(Arguments[2].Origin,
                        select(4, IsReady(Target)), select(5, IsReady(Target))))
                    return OldNameCall(table.unpack(Arguments))
                elseif table.find(Configuration.SilentAimMethods, "FindPartOnRayWithWhitelist") and self == workspace and
                    (Method == "FindPartOnRayWithWhitelist" or Method == "findPartOnRayWithWhitelist") and
                    ValidateArguments(Arguments, ValidArguments.FindPartOnRayWithWhitelist) then
                    Arguments[2] = Ray.new(Arguments[2].Origin, MathHandler:CalculateDirection(Arguments[2].Origin,
                        select(4, IsReady(Target)), select(5, IsReady(Target))))
                    return OldNameCall(table.unpack(Arguments))
                end
            end
            return OldNameCall(...)
        end))
    end
end

-- ! Bots Handler

local function HandleBots()
    if Spinning and Configuration.SpinPart and Player.Character and Player.Character:FindFirstChildWhichIsA("Humanoid") and
        Player.Character:FindFirstChild(Configuration.SpinPart) and
        Player.Character:FindFirstChild(Configuration.SpinPart):IsA("BasePart") then
        Player.Character:FindFirstChild(Configuration.SpinPart).CFrame =
            Player.Character:FindFirstChild(Configuration.SpinPart).CFrame *
                CFrame.fromEulerAnglesXYZ(0, math.rad(Configuration.SpinBotVelocity), 0)
    end
    if not DEBUG and getfenv().mouse1click and IsComputer and Triggering and
        (Configuration.SmartTriggerBot and Aiming or not Configuration.SmartTriggerBot) and Mouse.Target and
        IsReady(Mouse.Target:FindFirstAncestorWhichIsA("Model")) and
        MathHandler:CalculateChance(Configuration.TriggerBotChance) then
        getfenv().mouse1click()
    end
end

-- ! Random Parts Handler

local function HandleRandomParts()
    if Fluent and os.clock() - Clock >= 1 then
        if Configuration.RandomAimPart and #Configuration.AimPartDropdownValues > 0 then
            Fluent.Options.AimPart:SetValue(Configuration.AimPartDropdownValues[Random.new():NextInteger(1,
                #Configuration.AimPartDropdownValues)])
        end
        if Configuration.RandomSpinPart and #Configuration.SpinPartDropdownValues > 0 then
            Fluent.Options.SpinPart:SetValue(Configuration.SpinPartDropdownValues[Random.new():NextInteger(1,
                #Configuration.SpinPartDropdownValues)])
        end
        Clock = os.clock()
    end
end

-- ! Visuals Handler

local VisualsHandler = {}

function VisualsHandler:Visualize(Object)
    if not DEBUG and Fluent and getfenv().Drawing and getfenv().Drawing.new and typeof(Object) == "string" then
        if string.lower(Object) == "fov" then
            local FoV = getfenv().Drawing.new("Circle")
            FoV.Visible = false
            FoV.ZIndex = 4
            FoV.NumSides = 1000
            FoV.Radius = Configuration.FoVRadius
            FoV.Thickness = Configuration.FoVThickness
            FoV.Transparency = Configuration.FoVOpacity
            FoV.Filled = Configuration.FoVFilled
            FoV.Color = Configuration.FoVColour
            return FoV
        elseif string.lower(Object) == "espbox" then
            local ESPBox = getfenv().Drawing.new("Square")
            ESPBox.Visible = false
            ESPBox.ZIndex = 2
            ESPBox.Thickness = Configuration.ESPThickness
            ESPBox.Transparency = Configuration.ESPOpacity
            ESPBox.Filled = Configuration.ESPBoxFilled
            ESPBox.Color = Configuration.ESPColour
            return ESPBox
        elseif string.lower(Object) == "nameesp" then
            local NameESP = getfenv().Drawing.new("Text")
            NameESP.Visible = false
            NameESP.ZIndex = 3
            NameESP.Center = true
            NameESP.Outline = true
            NameESP.OutlineColor = Configuration.NameESPOutlineColour
            NameESP.Font = getfenv().Drawing.Fonts and getfenv().Drawing.Fonts[Configuration.NameESPFont]
            NameESP.Size = Configuration.NameESPSize
            NameESP.Transparency = Configuration.ESPOpacity
            NameESP.Color = Configuration.ESPColour
            return NameESP
        elseif string.lower(Object) == "traceresp" then
            local TracerESP = getfenv().Drawing.new("Line")
            TracerESP.Visible = false
            TracerESP.ZIndex = 1
            TracerESP.Thickness = Configuration.ESPThickness
            TracerESP.Transparency = Configuration.ESPOpacity
            TracerESP.Color = Configuration.ESPColour
            return TracerESP
        end
    end
    return nil
end

local Visuals = {
    FoV = VisualsHandler:Visualize("FoV")
}

function VisualsHandler:ClearVisual(Visual, Key)
    local FoundVisual = table.find(Visuals, Visual)
    if Visual and (FoundVisual or Key == "FoV") then
        if Visual.Destroy then
            Visual:Destroy()
        elseif Visual.Remove then
            Visual:Remove()
        end
        if FoundVisual then
            table.remove(Visuals, FoundVisual)
        elseif Key == "FoV" then
            Visuals.FoV = nil
        end
    end
end

function VisualsHandler:ClearVisuals()
    for Key, Visual in next, Visuals do
        self:ClearVisual(Visual, Key)
    end
end

function VisualsHandler:VisualizeFoV()
    if not Fluent then
        return self:ClearVisuals()
    end
    local MouseLocation = UserInputService:GetMouseLocation()
    Visuals.FoV.Position = Vector2.new(MouseLocation.X, MouseLocation.Y)
    Visuals.FoV.Radius = Configuration.FoVRadius
    Visuals.FoV.Thickness = Configuration.FoVThickness
    Visuals.FoV.Transparency = Configuration.FoVOpacity
    Visuals.FoV.Filled = Configuration.FoVFilled
    Visuals.FoV.Color = Configuration.FoVColour
    Visuals.FoV.Visible = ShowingFoV
end

function VisualsHandler:RainbowVisuals()
    if not Fluent then
        self:ClearVisuals()
    elseif Configuration.RainbowVisuals then
        local Hue = os.clock() % Configuration.RainbowDelay / Configuration.RainbowDelay
        Fluent.Options.FoVColour:SetValue({Hue, 1, 1})
        Fluent.Options.NameESPOutlineColour:SetValue({1 - Hue, 1, 1})
        Fluent.Options.ESPColour:SetValue({Hue, 1, 1})
    end
end

-- ! ESP Library

local ESPLibrary = {}

function ESPLibrary:Initialize(_Character)
    if not Fluent then
        VisualsHandler:ClearVisuals()
        return nil
    elseif typeof(_Character) ~= "Instance" then
        return nil
    end
    local self = setmetatable({}, {
        __index = self
    })
    self.Player = Players:GetPlayerFromCharacter(_Character)
    self.Character = _Character
    self.ESPBox = VisualsHandler:Visualize("ESPBox")
    self.NameESP = VisualsHandler:Visualize("NameESP")
    self.HealthESP = VisualsHandler:Visualize("NameESP")
    self.MagnitudeESP = VisualsHandler:Visualize("NameESP")
    self.PremiumESP = VisualsHandler:Visualize("NameESP")
    self.TracerESP = VisualsHandler:Visualize("TracerESP")
    table.insert(Visuals, self.ESPBox)
    table.insert(Visuals, self.NameESP)
    table.insert(Visuals, self.HealthESP)
    table.insert(Visuals, self.MagnitudeESP)
    table.insert(Visuals, self.PremiumESP)
    table.insert(Visuals, self.TracerESP)
    local Head = self.Character:FindFirstChild("Head")
    local HumanoidRootPart = self.Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = self.Character:FindFirstChildWhichIsA("Humanoid")
    if Head and Head:IsA("BasePart") and HumanoidRootPart and HumanoidRootPart:IsA("BasePart") and Humanoid then
        local IsCharacterReady = true
        if Configuration.SmartESP then
            IsCharacterReady = IsReady(self.Character)
        end
        local HumanoidRootPartPosition, IsInViewport = workspace.CurrentCamera:WorldToViewportPoint(
            HumanoidRootPart.Position)
        local HeadPosition = workspace.CurrentCamera:WorldToViewportPoint(Head.Position)
        local TopPosition = workspace.CurrentCamera:WorldToViewportPoint(Head.Position + Vector3.new(0, 0.5, 0))
        local BottomPosition = workspace.CurrentCamera:WorldToViewportPoint(HumanoidRootPart.Position -
                                                                                Vector3.new(0, 3, 0))
        if IsInViewport then
            self.ESPBox.Size = Vector2.new(2350 / HumanoidRootPartPosition.Z, TopPosition.Y - BottomPosition.Y)
            self.ESPBox.Position = Vector2.new(HumanoidRootPartPosition.X - self.ESPBox.Size.X / 2,
                HumanoidRootPartPosition.Y - self.ESPBox.Size.Y / 2)
            self.NameESP.Text = Aiming and IsReady(Target) and self.Character == Target and
                                    string.format("🎯@%s🎯", self.Player.Name) or
                                    string.format("@%s", self.Player.Name)
            self.NameESP.Position = Vector2.new(HumanoidRootPartPosition.X,
                HumanoidRootPartPosition.Y + self.ESPBox.Size.Y / 2 - 25)
            self.HealthESP.Text = string.format("[%s%%]", MathHandler:Abbreviate(Humanoid.Health))
            self.HealthESP.Position = Vector2.new(HumanoidRootPartPosition.X, HeadPosition.Y)
            self.MagnitudeESP.Text = string.format("[%sm]",
                Player.Character and Player.Character:FindFirstChild("Head") and
                    Player.Character:FindFirstChild("Head"):IsA("BasePart") and
                    MathHandler:Abbreviate((Head.Position - Player.Character:FindFirstChild("Head").Position).Magnitude) or
                    "?")
            self.MagnitudeESP.Position = Vector2.new(HumanoidRootPartPosition.X, HumanoidRootPartPosition.Y)
            self.PremiumESP.Text = PremiumLabels[Random.new():NextInteger(1, #PremiumLabels)]
            self.PremiumESP.Position = Vector2.new(HumanoidRootPartPosition.X,
                HumanoidRootPartPosition.Y - self.ESPBox.Size.Y / 2)
            self.TracerESP.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2,
                workspace.CurrentCamera.ViewportSize.Y)
            self.TracerESP.To = Vector2.new(HumanoidRootPartPosition.X,
                HumanoidRootPartPosition.Y - self.ESPBox.Size.Y / 2)
            if Configuration.ESPUseTeamColour and not Configuration.RainbowVisuals then
                local TeamColour = self.Player.TeamColor.Color
                local InvertedTeamColour = Color3.fromRGB(255 - TeamColour.R * 255, 255 - TeamColour.G * 255,
                    255 - TeamColour.B * 255)
                self.ESPBox.Color = TeamColour
                self.NameESP.OutlineColor = InvertedTeamColour
                self.NameESP.Color = TeamColour
                self.HealthESP.OutlineColor = InvertedTeamColour
                self.HealthESP.Color = TeamColour
                self.MagnitudeESP.OutlineColor = InvertedTeamColour
                self.MagnitudeESP.Color = TeamColour
                self.PremiumESP.OutlineColor = InvertedTeamColour
                self.PremiumESP.Color = TeamColour
                self.TracerESP.Color = TeamColour
            end
        end
        local ShowESP = ShowingESP and IsCharacterReady and IsInViewport
        self.ESPBox.Visible = Configuration.ESPBox and ShowESP
        self.NameESP.Visible = Configuration.NameESP and ShowESP
        self.HealthESP.Visible = Configuration.HealthESP and ShowESP
        self.MagnitudeESP.Visible = Configuration.MagnitudeESP and ShowESP
        self.PremiumESP.Visible = Configuration.NameESP and self.Player:IsInGroup(tonumber(Fluent.Address, 8)) and
                                      ShowESP
        self.TracerESP.Visible = Configuration.TracerESP and ShowESP
    end
    return self
end

function ESPLibrary:Visualize()
    if not Fluent then
        return VisualsHandler:ClearVisuals()
    elseif not self.Character then
        return self:Disconnect()
    end
    local Head = self.Character:FindFirstChild("Head")
    local HumanoidRootPart = self.Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = self.Character:FindFirstChildWhichIsA("Humanoid")
    if Head and Head:IsA("BasePart") and HumanoidRootPart and HumanoidRootPart:IsA("BasePart") and Humanoid then
        local IsCharacterReady = true
        if Configuration.SmartESP then
            IsCharacterReady = IsReady(self.Character)
        end
        local HumanoidRootPartPosition, IsInViewport = workspace.CurrentCamera:WorldToViewportPoint(
            HumanoidRootPart.Position)
        local HeadPosition = workspace.CurrentCamera:WorldToViewportPoint(Head.Position)
        local TopPosition = workspace.CurrentCamera:WorldToViewportPoint(Head.Position + Vector3.new(0, 0.5, 0))
        local BottomPosition = workspace.CurrentCamera:WorldToViewportPoint(HumanoidRootPart.Position -
                                                                                Vector3.new(0, 3, 0))
        if IsInViewport then
            self.ESPBox.Size = Vector2.new(2350 / HumanoidRootPartPosition.Z, TopPosition.Y - BottomPosition.Y)
            self.ESPBox.Position = Vector2.new(HumanoidRootPartPosition.X - self.ESPBox.Size.X / 2,
                HumanoidRootPartPosition.Y - self.ESPBox.Size.Y / 2)
            self.ESPBox.Thickness = Configuration.ESPThickness
            self.ESPBox.Transparency = Configuration.ESPOpacity
            self.ESPBox.Filled = Configuration.ESPBoxFilled
            self.NameESP.Text = Aiming and IsReady(Target) and self.Character == Target and
                                    string.format("🎯@%s🎯", self.Player.Name) or
                                    string.format("@%s", self.Player.Name)
            self.NameESP.Font = getfenv().Drawing.Fonts and getfenv().Drawing.Fonts[Configuration.NameESPFont]
            self.NameESP.Size = Configuration.NameESPSize
            self.NameESP.Transparency = Configuration.ESPOpacity
            self.NameESP.Position = Vector2.new(HumanoidRootPartPosition.X,
                HumanoidRootPartPosition.Y + self.ESPBox.Size.Y / 2 - 25)
            self.HealthESP.Text = string.format("[%s%%]", MathHandler:Abbreviate(Humanoid.Health))
            self.HealthESP.Font = getfenv().Drawing.Fonts and getfenv().Drawing.Fonts[Configuration.NameESPFont]
            self.HealthESP.Size = Configuration.NameESPSize
            self.HealthESP.Transparency = Configuration.ESPOpacity
            self.HealthESP.Position = Vector2.new(HumanoidRootPartPosition.X, HeadPosition.Y)
            self.MagnitudeESP.Text = string.format("[%sm]",
                Player.Character and Player.Character:FindFirstChild("Head") and
                    Player.Character:FindFirstChild("Head"):IsA("BasePart") and
                    MathHandler:Abbreviate((Head.Position - Player.Character:FindFirstChild("Head").Position).Magnitude) or
                    "?")
            self.MagnitudeESP.Font = getfenv().Drawing.Fonts and getfenv().Drawing.Fonts[Configuration.NameESPFont]
            self.MagnitudeESP.Size = Configuration.NameESPSize
            self.MagnitudeESP.Transparency = Configuration.ESPOpacity
            self.MagnitudeESP.Position = Vector2.new(HumanoidRootPartPosition.X, HumanoidRootPartPosition.Y)
            self.PremiumESP.Text = PremiumLabels[Random.new():NextInteger(1, #PremiumLabels)]
            self.PremiumESP.Font = getfenv().Drawing.Fonts and getfenv().Drawing.Fonts[Configuration.NameESPFont]
            self.PremiumESP.Size = Configuration.NameESPSize
            self.PremiumESP.Transparency = Configuration.ESPOpacity
            self.PremiumESP.Position = Vector2.new(HumanoidRootPartPosition.X,
                HumanoidRootPartPosition.Y - self.ESPBox.Size.Y / 2)
            self.TracerESP.Thickness = Configuration.ESPThickness
            self.TracerESP.Transparency = Configuration.ESPOpacity
            self.TracerESP.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2,
                workspace.CurrentCamera.ViewportSize.Y)
            self.TracerESP.To = Vector2.new(HumanoidRootPartPosition.X,
                HumanoidRootPartPosition.Y - self.ESPBox.Size.Y / 2)
            if Configuration.ESPUseTeamColour and not Configuration.RainbowVisuals then
                local TeamColour = self.Player.TeamColor.Color
                local InvertedTeamColour = Color3.fromRGB(255 - TeamColour.R * 255, 255 - TeamColour.G * 255,
                    255 - TeamColour.B * 255)
                self.ESPBox.Color = TeamColour
                self.NameESP.OutlineColor = InvertedTeamColour
                self.NameESP.Color = TeamColour
                self.HealthESP.OutlineColor = InvertedTeamColour
                self.HealthESP.Color = TeamColour
                self.MagnitudeESP.OutlineColor = InvertedTeamColour
                self.MagnitudeESP.Color = TeamColour
                self.PremiumESP.OutlineColor = InvertedTeamColour
                self.PremiumESP.Color = TeamColour
                self.TracerESP.Color = TeamColour
            else
                self.ESPBox.Color = Configuration.ESPColour
                self.NameESP.OutlineColor = Configuration.NameESPOutlineColour
                self.NameESP.Color = Configuration.ESPColour
                self.HealthESP.OutlineColor = Configuration.NameESPOutlineColour
                self.HealthESP.Color = Configuration.ESPColour
                self.MagnitudeESP.OutlineColor = Configuration.NameESPOutlineColour
                self.MagnitudeESP.Color = Configuration.ESPColour
                self.PremiumESP.OutlineColor = Configuration.NameESPOutlineColour
                self.PremiumESP.Color = Configuration.ESPColour
                self.TracerESP.Color = Configuration.ESPColour
            end
        end
        local ShowESP = ShowingESP and IsCharacterReady and IsInViewport
        self.ESPBox.Visible = Configuration.ESPBox and ShowESP
        self.NameESP.Visible = Configuration.NameESP and ShowESP
        self.HealthESP.Visible = Configuration.HealthESP and ShowESP
        self.MagnitudeESP.Visible = Configuration.MagnitudeESP and ShowESP
        self.PremiumESP.Visible = Configuration.NameESP and self.Player:IsInGroup(tonumber(Fluent.Address, 8)) and
                                      ShowESP
        self.TracerESP.Visible = Configuration.TracerESP and ShowESP
    else
        self.ESPBox.Visible = false
        self.NameESP.Visible = false
        self.HealthESP.Visible = false
        self.MagnitudeESP.Visible = false
        self.PremiumESP.Visible = false
        self.TracerESP.Visible = false
    end
end

function ESPLibrary:Disconnect()
    self.Player = nil
    self.Character = nil
    VisualsHandler:ClearVisual(self.ESPBox)
    VisualsHandler:ClearVisual(self.NameESP)
    VisualsHandler:ClearVisual(self.HealthESP)
    VisualsHandler:ClearVisual(self.MagnitudeESP)
    VisualsHandler:ClearVisual(self.PremiumESP)
    VisualsHandler:ClearVisual(self.TracerESP)
end

-- ! Tracking Handler

local TrackingHandler = {}

local Tracking = {}
local Connections = {}

function TrackingHandler:VisualizeESP()
    for _, Tracked in next, Tracking do
        Tracked:Visualize()
    end
end

function TrackingHandler:DisconnectTracking(Key)
    if Key and Tracking[Key] then
        Tracking[Key]:Disconnect()
        Tracking[Key] = nil
    end
end

function TrackingHandler:DisconnectConnection(Key)
    if Key and Connections[Key] then
        for _, Connection in next, Connections[Key] do
            Connection:Disconnect()
        end
        Connections[Key] = nil
    end
end

function TrackingHandler:DisconnectConnections()
    for Key, _ in next, Connections do
        self:DisconnectConnection(Key)
    end
    for Key, _ in next, Tracking do
        self:DisconnectTracking(Key)
    end
end

function TrackingHandler:DisconnectAimbot()
    FieldsHandler:ResetAimbotFields()
    FieldsHandler:ResetSecondaryFields()
    self:DisconnectConnections()
    VisualsHandler:ClearVisuals()
end

local function CharacterAdded(_Character)
    if typeof(_Character) == "Instance" then
        local _Player = Players:GetPlayerFromCharacter(_Character)
        Tracking[_Player.UserId] = ESPLibrary:Initialize(_Character)
    end
end

local function CharacterRemoving(_Character)
    if typeof(_Character) == "Instance" then
        for Key, Tracked in next, Tracking do
            if Tracked.Character == _Character then
                TrackingHandler:DisconnectTracking(Key)
            end
        end
    end
end

function TrackingHandler:InitializePlayers()
    if not DEBUG and getfenv().Drawing and getfenv().Drawing.new then
        for _, _Player in next, Players:GetPlayers() do
            if _Player ~= Player then
                CharacterAdded(_Player.Character)
                Connections[_Player.UserId] = {_Player.CharacterAdded:Connect(CharacterAdded),
                                               _Player.CharacterRemoving:Connect(CharacterRemoving)}
            end
        end
    end
end

TrackingHandler:InitializePlayers()

-- ! Player Events Handler

local OnTeleport;
OnTeleport = Player.OnTeleport:Connect(function()
    if DEBUG or not Fluent or not getfenv().queue_on_teleport then
        OnTeleport:Disconnect()
    else
        getfenv().queue_on_teleport(
            "getfenv().loadstring(game:HttpGet(\"https://raw.githubusercontent.com/ttwizz/Open-Aimbot/master/source.lua\", true))()")
        OnTeleport:Disconnect()
    end
end)

local PlayerAdded;
PlayerAdded = Players.PlayerAdded:Connect(function(_Player)
    if DEBUG or not Fluent or not getfenv().Drawing or not getfenv().Drawing.new then
        PlayerAdded:Disconnect()
    else
        Connections[_Player.UserId] = {_Player.CharacterAdded:Connect(CharacterAdded),
                                       _Player.CharacterRemoving:Connect(CharacterRemoving)}
    end
end)

local PlayerRemoving;
PlayerRemoving = Players.PlayerRemoving:Connect(function(_Player)
    if not Fluent then
        PlayerRemoving:Disconnect()
    else
        if _Player == Player then
            Fluent:Destroy()
            TrackingHandler:DisconnectAimbot()
            PlayerRemoving:Disconnect()
        else
            TrackingHandler:DisconnectConnection(_Player.UserId)
            TrackingHandler:DisconnectTracking(_Player.UserId)
        end
    end
end)

-- ! Aimbot Handler

local AimbotLoop;
AimbotLoop = RunService[UISettings.RenderingMode]:Connect(function()
    if Fluent.Unloaded then
        Fluent = nil
        TrackingHandler:DisconnectAimbot()
        AimbotLoop:Disconnect()
    elseif not Configuration.Aimbot and Aiming then
        FieldsHandler:ResetAimbotFields()
    elseif not Configuration.SpinBot and Spinning then
        Spinning = false
    elseif not Configuration.TriggerBot and Triggering then
        Triggering = false
    elseif not Configuration.FoV and ShowingFoV then
        ShowingFoV = false
    elseif not Configuration.ESPBox and not Configuration.NameESP and not Configuration.HealthESP and
        not Configuration.MagnitudeESP and not Configuration.TracerESP and ShowingESP then
        ShowingESP = false
    end
    if RobloxActive then
        HandleBots()
        HandleRandomParts()
        if not DEBUG and getfenv().Drawing and getfenv().Drawing.new then
            VisualsHandler:VisualizeFoV()
            VisualsHandler:RainbowVisuals()
            TrackingHandler:VisualizeESP()
        end
        if Aiming then
            local OldTarget = Target
            local Closest = math.huge
            if not IsReady(OldTarget) then
                if OldTarget and not Configuration.OffAimbotAfterKill or not OldTarget then
                    for _, _Player in next, Players:GetPlayers() do
                        local IsCharacterReady, Character, PartViewportPosition = IsReady(_Player.Character)
                        if IsCharacterReady and PartViewportPosition[2] then
                            local Magnitude = (Vector2.new(Mouse.X, Mouse.Y) -
                                                  Vector2.new(PartViewportPosition[1].X, PartViewportPosition[1].Y)).Magnitude
                            if Magnitude <= Closest and Magnitude <=
                                (Configuration.FoVCheck and Configuration.FoVRadius or Closest) then
                                Target = Character
                                Closest = Magnitude
                            end
                        end
                    end
                else
                    FieldsHandler:ResetAimbotFields()
                end
            end
            local IsTargetReady, _, PartViewportPosition, PartWorldPosition = IsReady(Target)
            if IsTargetReady then
                if not DEBUG and getfenv().mousemoverel and IsComputer and Configuration.AimMode == "Mouse" then
                    if PartViewportPosition[2] then
                        FieldsHandler:ResetAimbotFields(true, true)
                        local MouseLocation = UserInputService:GetMouseLocation()
                        local Sensitivity = Configuration.UseSensitivity and Configuration.Sensitivity / 5 or 10
                        getfenv().mousemoverel((PartViewportPosition[1].X - MouseLocation.X) / Sensitivity,
                            (PartViewportPosition[1].Y - MouseLocation.Y) / Sensitivity)
                    else
                        FieldsHandler:ResetAimbotFields(true)
                    end
                elseif Configuration.AimMode == "Camera" then
                    UserInputService.MouseDeltaSensitivity = 0
                    if Configuration.UseSensitivity then
                        Tween = TweenService:Create(workspace.CurrentCamera, TweenInfo.new(
                            math.clamp(Configuration.Sensitivity, 9, 99) / 100, Enum.EasingStyle.Sine,
                            Enum.EasingDirection.Out), {
                            CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, PartWorldPosition)
                        })
                        Tween:Play()
                    else
                        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position,
                            PartWorldPosition)
                    end
                elseif not DEBUG and getfenv().hookmetamethod and getfenv().newcclosure and getfenv().checkcaller and
                    getfenv().getnamecallmethod and Configuration.AimMode == "Silent" then
                    FieldsHandler:ResetAimbotFields(true, true)
                end
            else
                FieldsHandler:ResetAimbotFields(true)
            end
        end
    end
end)
