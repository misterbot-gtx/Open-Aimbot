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

    ✨Framework Universal de Assistência de Mira✨
    Versão 1.9.5

    twix.cyou/pix
    twix.cyou/OpenAimbotV3rm

    Autor: ttwiz_z (ttwizz) <i@twix.cyou>
    Licença: MIT
    GitHub: https://github.com/ttwizz/Open-Aimbot

    Problemas: https://github.com/ttwizz/Open-Aimbot/issues
    Pull requests: https://github.com/ttwizz/Open-Aimbot/pulls
    Discussões: https://github.com/ttwizz/Open-Aimbot/discussions

    Wiki: https://moderka.org/Open-Aimbot

    Trustpilot: https://www.trustpilot.com/review/moderka.org

•───────•°•❀•°•───────•୧‿̩͙ ˖︵ꕀ ⠀𓏶 ̣̣̥⠀ ꕀ︵˖ ̩͙‿୨•───────•°•❀•°•───────•]]


--! Depurador

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


--! Serviços

local ServicoHttp = game:GetService("HttpService")
local Jogadores = game:GetService("Players")
local ServicoEntradaUsuario = game:GetService("UserInputService")
local ServicoExecucao = game:GetService("RunService")
local ServicoTween = game:GetService("TweenService")


--! Gerenciador de Interface

local ConfiguracoesUI = {
    LarguraAba = 160,
    Tamanho = { 580, 460 },
    Tema = "VSC Dark High Contrast",
    Acrilico = false,
    Transparencia = true,
    TeclaMinimizar = "RightShift",
    MostrarNotificacoes = true,
    MostrarAvisos = true,
    ModoRenderizacao = "RenderStepped",
    ImportacaoAutomatica = true
}

local GerenciadorInterface = {}

function GerenciadorInterface:ImportarConfiguracoes()
    pcall(function()
        if not DEBUG and getfenv().isfile and getfenv().readfile and getfenv().isfile("ConfiguracoesUI.ttwizz") and getfenv().readfile("ConfiguracoesUI.ttwizz") then
            for Chave, Valor in next, ServicoHttp:JSONDecode(getfenv().readfile("ConfiguracoesUI.ttwizz")) do
                ConfiguracoesUI[Chave] = Valor
            end
        end
    end)
end

function GerenciadorInterface:ExportarConfiguracoes()
    pcall(function()
        if not DEBUG and getfenv().isfile and getfenv().readfile and getfenv().writefile then
            getfenv().writefile("ConfiguracoesUI.ttwizz", ServicoHttp:JSONEncode(ConfiguracoesUI))
        end
    end)
end

GerenciadorInterface:ImportarConfiguracoes()

ConfiguracoesUI.__ULTIMA_EXECUCAO__ = os.date()
GerenciadorInterface:ExportarConfiguracoes()


--! Manipulador de Cores

local ManipuladorCores = {}

function ManipuladorCores:EmpacotarCor(Cor)
    return typeof(Cor) == "Color3" and { R = Cor.R * 255, G = Cor.G * 255, B = Cor.B * 255 } or typeof(Cor) == "table" and Cor or { R = 255, G = 255, B = 255 }
end

function ManipuladorCores:DesempacotarCor(Cor)
    return typeof(Cor) == "table" and Color3.fromRGB(Cor.R, Cor.G, Cor.B) or typeof(Cor) == "Color3" and Cor or Color3.fromRGB(255, 255, 255)
end


--! Importador de Configuração

local ConfiguracaoImportada = {}

pcall(function()
    if not DEBUG and getfenv().isfile and getfenv().readfile and getfenv().isfile(string.format("%s.ttwizz", game.GameId)) and getfenv().readfile(string.format("%s.ttwizz", game.GameId)) and ConfiguracoesUI.ImportacaoAutomatica then
        ConfiguracaoImportada = ServicoHttp:JSONDecode(getfenv().readfile(string.format("%s.ttwizz", game.GameId)))
        for Chave, Valor in next, ConfiguracaoImportada do
            if Chave == "CorFoV" or Chave == "CorContornoNomeESP" or Chave == "CorESP" then
                ConfiguracaoImportada[Chave] = ManipuladorCores:DesempacotarCor(Valor)
            end
        end
    end
end)


--! Inicializador de Configuração

local Configuracao = {}

--? Mira Automática

Configuracao.MiraAutomatica = ConfiguracaoImportada["MiraAutomatica"] or false
Configuracao.ModoMiraUmClique = ConfiguracaoImportada["ModoMiraUmClique"] or false
Configuracao.TeclaMira = ConfiguracaoImportada["TeclaMira"] or "RMB"
Configuracao.ModoMira = ConfiguracaoImportada["ModoMira"] or "Camera"
Configuracao.MetodosMiraSilenciosa = ConfiguracaoImportada["MetodosMiraSilenciosa"] or { "Mouse.Hit / Mouse.Target", "GetMouseLocation" }
Configuracao.ChanceMiraSilenciosa = ConfiguracaoImportada["ChanceMiraSilenciosa"] or 100
Configuracao.DesativarMiraAposAbate = ConfiguracaoImportada["DesativarMiraAposAbate"] or false
Configuracao.ValoresPartesMira = ConfiguracaoImportada["ValoresPartesMira"] or { "Cabeça", "TroncoHumanoide" }
Configuracao.ParteMira = ConfiguracaoImportada["ParteMira"] or "TroncoHumanoide"
Configuracao.ParteMiraAleatoria = ConfiguracaoImportada["ParteMiraAleatoria"] or false

Configuracao.UsarDeslocamento = ConfiguracaoImportada["UsarDeslocamento"] or false
Configuracao.TipoDeslocamento = ConfiguracaoImportada["TipoDeslocamento"] or "Estático"
Configuracao.IncrementoDeslocamentoEstatico = ConfiguracaoImportada["IncrementoDeslocamentoEstatico"] or 10
Configuracao.IncrementoDeslocamentoDinamico = ConfiguracaoImportada["IncrementoDeslocamentoDinamico"] or 10
Configuracao.DeslocamentoAutomatico = ConfiguracaoImportada["DeslocamentoAutomatico"] or false
Configuracao.MaximoDeslocamentoAutomatico = ConfiguracaoImportada["MaximoDeslocamentoAutomatico"] or 50

Configuracao.UsarSensibilidade = ConfiguracaoImportada["UsarSensibilidade"] or false
Configuracao.Sensibilidade = ConfiguracaoImportada["Sensibilidade"] or 50
Configuracao.UsarRuido = ConfiguracaoImportada["UsarRuido"] or false
Configuracao.FrequenciaRuido = ConfiguracaoImportada["FrequenciaRuido"] or 50

--? Bots

Configuracao.SpinBot = ConfiguracaoImportada["SpinBot"] or false
Configuracao.ModoUmCliqueSpinning = ConfiguracaoImportada["ModoUmCliqueSpinning"] or false
Configuracao.TeclaSpin = ConfiguracaoImportada["TeclaSpin"] or "Q"
Configuracao.VelocidadeSpinBot = ConfiguracaoImportada["VelocidadeSpinBot"] or 50
Configuracao.ValoresPartesSpinBot = ConfiguracaoImportada["ValoresPartesSpinBot"] or { "Cabeça", "TroncoHumanoide" }
Configuracao.ParteSpinBot = ConfiguracaoImportada["ParteSpinBot"] or "TroncoHumanoide"
Configuracao.ParteSpinBotAleatoria = ConfiguracaoImportada["ParteSpinBotAleatoria"] or false

Configuracao.TriggerBot = ConfiguracaoImportada["TriggerBot"] or false
Configuracao.ModoUmCliqueTriggering = ConfiguracaoImportada["ModoUmCliqueTriggering"] or false
Configuracao.SmartTriggerBot = ConfiguracaoImportada["SmartTriggerBot"] or false
Configuracao.TeclaTrigger = ConfiguracaoImportada["TeclaTrigger"] or "E"
Configuracao.ChanceTriggerBot = ConfiguracaoImportada["ChanceTriggerBot"] or 100

--? Verificações

Configuracao.VerificarVida = ConfiguracaoImportada["VerificarVida"] or false
Configuracao.VerificarDeus = ConfiguracaoImportada["VerificarDeus"] or false
Configuracao.VerificarTime = ConfiguracaoImportada["VerificarTime"] or false
Configuracao.VerificarAmigo = ConfiguracaoImportada["VerificarAmigo"] or false
Configuracao.VerificarSeguidor = ConfiguracaoImportada["VerificarSeguidor"] or false
Configuracao.VerificarEmblema = ConfiguracaoImportada["VerificarEmblema"] or false
Configuracao.VerificarParede = ConfiguracaoImportada["VerificarParede"] or false
Configuracao.VerificarAgua = ConfiguracaoImportada["VerificarAgua"] or false

Configuracao.VerificarFoV = ConfiguracaoImportada["VerificarFoV"] or false
Configuracao.RaioFoV = ConfiguracaoImportada["RaioFoV"] or 100
Configuracao.MagnitudeVerificacao = ConfiguracaoImportada["MagnitudeVerificacao"] or false
Configuracao.MagnitudeTrigger = ConfiguracaoImportada["MagnitudeTrigger"] or 500
Configuracao.VerificarTransparencia = ConfiguracaoImportada["VerificarTransparencia"] or false
Configuracao.TransparenciaIgnorada = ConfiguracaoImportada["TransparenciaIgnorada"] or 0.5
Configuracao.GrupoPermitidoCheck = ConfiguracaoImportada["GrupoPermitidoCheck"] or false
Configuracao.GrupoPermitido = ConfiguracaoImportada["GrupoPermitido"] or 0
Configuracao.GrupoNegadoCheck = ConfiguracaoImportada["GrupoNegadoCheck"] or false
Configuracao.GrupoNegado = ConfiguracaoImportada["GrupoNegado"] or 0

Configuracao.JogadoresIgnoradosCheck = ConfiguracaoImportada["JogadoresIgnoradosCheck"] or false
Configuracao.JogadoresIgnoradosDropdownValues = ConfiguracaoImportada["JogadoresIgnoradosDropdownValues"] or {}
Configuracao.JogadoresIgnorados = ConfiguracaoImportada["JogadoresIgnorados"] or {}
Configuracao.JogadoresAlvoCheck = ConfiguracaoImportada["JogadoresAlvoCheck"] or false
Configuracao.JogadoresAlvoDropdownValues = ConfiguracaoImportada["JogadoresAlvoDropdownValues"] or {}
Configuracao.JogadoresAlvo = ConfiguracaoImportada["JogadoresAlvo"] or {}

Configuracao.PremiumCheck = ConfiguracaoImportada["PremiumCheck"] or false

--? Visuais

Configuracao.FoV = ConfiguracaoImportada["FoV"] or false
Configuracao.FoVKey = ConfiguracaoImportada["FoVKey"] or "R"
Configuracao.EspessuraFoV = ConfiguracaoImportada["EspessuraFoV"] or 2
Configuracao.OpacidadeFoV = ConfiguracaoImportada["OpacidadeFoV"] or 0.8
Configuracao.FoVPreenchido = ConfiguracaoImportada["FoVPreenchido"] or false
Configuracao.CorFoV = ConfiguracaoImportada["CorFoV"] or Color3.fromRGB(255, 255, 255)

Configuracao.SmartESP = ConfiguracaoImportada["SmartESP"] or false
Configuracao.ESPKey = ConfiguracaoImportada["ESPKey"] or "T"
Configuracao.CaixaESP = ConfiguracaoImportada["CaixaESP"] or false
Configuracao.CaixaESPPreencida = ConfiguracaoImportada["CaixaESPPreencida"] or false
Configuracao.NomeESP = ConfiguracaoImportada["NomeESP"] or false
Configuracao.FonteNomeESP = ConfiguracaoImportada["FonteNomeESP"] or "Monospace"
Configuracao.TamanhoNomeESP = ConfiguracaoImportada["TamanhoNomeESP"] or 16
Configuracao.CorContornoNomeESP = ConfiguracaoImportada["CorContornoNomeESP"] or Color3.fromRGB(0, 0, 0)
Configuracao.VidaESP = ConfiguracaoImportada["VidaESP"] or false
Configuracao.MagnitudeESP = ConfiguracaoImportada["MagnitudeESP"] or false
Configuracao.TracerESP = ConfiguracaoImportada["TracerESP"] or false
Configuracao.EspessuraESP = ConfiguracaoImportada["EspessuraESP"] or 2
Configuracao.OpacidadeESP = ConfiguracaoImportada["OpacidadeESP"] or 0.8
Configuracao.CorESP = ConfiguracaoImportada["CorESP"] or Color3.fromRGB(255, 255, 255)
Configuracao.ESPUseTeamColour = ConfiguracaoImportada["ESPUseTeamColour"] or false

Configuracao.VisuaisArcoIris = ConfiguracaoImportada["VisuaisArcoIris"] or false
Configuracao.AtrasoArcoIris = ConfiguracaoImportada["AtrasoArcoIris"] or 5


--! Constantes

local Jogador = Jogadores.LocalPlayer
local Mouse = Jogador:GetMouse()
local IsComputador = ServicoEntradaUsuario.KeyboardEnabled and ServicoEntradaUsuario.MouseEnabled

local EtiquetasMensais = { "🎅%s❄️", "☃️%s🏂", "🌷%s☘️", "🌺%s🎀", "🐝%s🌼", "🌈%s😎", "🌞%s🏖️", "☀️%s💐", "🌦%s🍁", "🎃%s💀", "🍂%s☕", "🎄%s🎁" }
local LabelsPremium = { "💫PREMIUM💫", "✨PREMIUM✨", "🌟PREMIUM🌟", "⭐PREMIUM⭐", "🤩PREMIUM🤩" }


--! Manipulador de Nomes

local function ObterNomeJogador(String)
    if typeof(String) == "string" and #String > 0 then
        for _, _Jogador in next, Jogadores:GetPlayers() do
            if string.sub(string.lower(_Jogador.Name), 1, #string.lower(String)) == string.lower(String) then
                return _Jogador.Name
            end
        end
    end
    return ""
end


--! Campos

local Status = ""

local Fluent = nil
local MostrarAviso = false

local RobloxAtivo = true
local Relogio = os.clock()

local MiraAtiva = false
local Alvo = nil
local Tween = nil
local SensibilidadeMouse = ServicoEntradaUsuario.MouseDeltaSensitivity

local GirandoAtivo = false
local DisparoAutomaticoAtivo = false
local MostrandoFoV = false
local MostrandoESP = false

do
    if typeof(script) == "Instance" and script:FindFirstChild("Fluent") and script:FindFirstChild("Fluent"):IsA("ModuleScript") then
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
            if Success and typeof(Result) == "string" and pcall(ServicoHttp.JSONDecode, ServicoHttp, Result) and typeof(ServicoHttp:JSONDecode(Result).message) == "string" then
                Status = ServicoHttp:JSONDecode(Result).message
            end
        else
            return
        end
    end
end

local SensibilidadeAlterada; SensibilidadeAlterada = ServicoEntradaUsuario:GetPropertyChangedSignal("MouseDeltaSensitivity"):Connect(function()
    if not Fluent then
        SensibilidadeAlterada:Disconnect()
    elseif not MiraAtiva or not DEBUG and (getfenv().mousemoverel and IsComputador and Configuracao.ModoMira == "Mouse" or getfenv().hookmetamethod and getfenv().newcclosure and getfenv().checkcaller and getfenv().getnamecallmethod and Configuracao.ModoMira == "Silent") then
        SensibilidadeMouse = ServicoEntradaUsuario.MouseDeltaSensitivity
    end
end)


--! Inicializador da Interface

do
    local Janela = Fluent:CreateWindow({
        Title = string.format("%s <b><i>%s</i></b>", string.format(EtiquetasMensais[os.date("*t").month], "Assistência de Mira"), #Status > 0 and Status or "🔥GRATUITO🔥"),
        SubTitle = "Por @robot",
        TabWidth = ConfiguracoesUI.LarguraAba,
        Size = UDim2.fromOffset(table.unpack(ConfiguracoesUI.Tamanho)),
        Theme = ConfiguracoesUI.Tema,
        Acrylic = ConfiguracoesUI.Acrilico,
        MinimizeKey = ConfiguracoesUI.TeclaMinimizar
    })

    local Abas = { 
        MiraAutomatica = Janela:AddTab({ Title = "Mira Automática", Icon = "crosshair" }),
        Bots = Janela:AddTab({ Title = "Bots", Icon = "bot" }),
        Verificacoes = Janela:AddTab({ Title = "Verificações", Icon = "shield-check" }),
        Visuais = Janela:AddTab({ Title = "Visuais", Icon = "eye" }),
        Configuracoes = Janela:AddTab({ Title = "Configurações", Icon = "settings" })
    }

    Janela:SelectTab(1)

    Abas.MiraAutomatica:AddParagraph({
        Title = string.format("%s 🔥GRATUITO🔥", string.format(EtiquetasMensais[os.date("*t").month], "Assistência de Mira")),
        Content = "✨Framework Universal de Assistência de Mira✨\nhttps://github.com/ttwizz/Open-Aimbot"
    })

    local SecaoMiraAutomatica = Abas.MiraAutomatica:AddSection("Configurações da Mira")

    local AlternarMiraAutomatica = SecaoMiraAutomatica:AddToggle("MiraAutomatica", { 
        Title = "Mira Automática", 
        Description = "Ativa/Desativa a Mira Automática", 
        Default = Configuracao.MiraAutomatica 
    })
    AlternarMiraAutomatica:OnChanged(function(Valor)
        Configuracao.MiraAutomatica = Valor
        if not IsComputador then
            MiraAtiva = Valor
        end
    end)

    if IsComputador then
        local AlternarModoUmClique = SecaoMiraAutomatica:AddToggle("ModoMiraUmClique", { 
            Title = "Modo Um Clique", 
            Description = "Ativa o modo de um clique em vez do modo contínuo", 
            Default = Configuracao.ModoMiraUmClique 
        })
        AlternarModoUmClique:OnChanged(function(Valor)
            Configuracao.ModoMiraUmClique = Valor
        end)

        local TeclaMira = SecaoMiraAutomatica:AddKeybind("TeclaMira", {
            Title = "Tecla de Ativação",
            Description = "Define a tecla para ativar a mira",
            Default = Configuracao.TeclaMira,
            ChangedCallback = function(Valor)
                Configuracao.TeclaMira = Valor
            end
        })
    end

    local MenuParteMira = SecaoMiraAutomatica:AddDropdown("ParteMira", {
        Title = "Parte do Alvo",
        Description = "Seleciona a parte do corpo do alvo",
        Values = Configuracao.ValoresPartesMira,
        Default = Configuracao.ParteMira,
        Callback = function(Valor)
            Configuracao.ParteMira = Valor
        end
    })

    local AlternarParteMiraAleatoria = SecaoMiraAutomatica:AddToggle("ParteMiraAleatoria", { 
        Title = "Seleção Aleatória", 
        Description = "Alterna entre partes do alvo aleatoriamente", 
        Default = Configuracao.ParteMiraAleatoria 
    })
    AlternarParteMiraAleatoria:OnChanged(function(Valor)
        Configuracao.ParteMiraAleatoria = Valor
    end)

    SecaoMiraAutomatica:AddInput("AdicionarParteMira", {
        Title = "Adicionar Parte",
        Description = "Digite o nome da parte e pressione Enter",
        Finished = true,
        Placeholder = "Nome da Parte",
        Callback = function(Valor)
            if #Valor > 0 and not table.find(Configuracao.ValoresPartesMira, Valor) then
                table.insert(Configuracao.ValoresPartesMira, Valor)
                MenuParteMira:SetValue(Valor)
            end
        end
    })

    SecaoMiraAutomatica:AddInput("RemoverParteMira", {
        Title = "Remover Parte",
        Description = "Digite o nome da parte e pressione Enter",
        Finished = true,
        Placeholder = "Nome da Parte",
        Callback = function(Valor)
            if #Valor > 0 and table.find(Configuracao.ValoresPartesMira, Valor) then
                if Configuracao.ParteMira == Valor then
                    MenuParteMira:SetValue(nil)
                end
                table.remove(Configuracao.ValoresPartesMira, table.find(Configuracao.ValoresPartesMira, Valor))
                MenuParteMira:SetValues(Configuracao.ValoresPartesMira)
            end
        end
    })

    SecaoMiraAutomatica:AddButton({
        Title = "Limpar Todas as Partes",
        Description = "Remove todas as partes configuradas",
        Callback = function()
            local Quantidade = #Configuracao.ValoresPartesMira
            MenuParteMira:SetValue(nil)
            Configuracao.ValoresPartesMira = {}
            MenuParteMira:SetValues(Configuracao.ValoresPartesMira)
            Janela:Dialog({
                Title = "Assistência de Mira",
                Content = Quantidade == 0 and "Nenhuma parte foi removida!" or 
                         Quantidade == 1 and "1 parte foi removida!" or 
                         string.format("%d partes foram removidas!", Quantidade),
                Buttons = {
                    {
                        Title = "OK"
                    }
                }
            })
        end
    })

    local SecaoDeslocamento = Abas.MiraAutomatica:AddSection("Configurações de Deslocamento")

    local AlternarDeslocamento = SecaoDeslocamento:AddToggle("UsarDeslocamento", { 
        Title = "Ativar Deslocamento", 
        Description = "Ativa o sistema de deslocamento da mira", 
        Default = Configuracao.UsarDeslocamento 
    })
    AlternarDeslocamento:OnChanged(function(Valor)
        Configuracao.UsarDeslocamento = Valor
    end)

    SecaoDeslocamento:AddDropdown("TipoDeslocamento", {
        Title = "Tipo de Deslocamento",
        Description = "Define como o deslocamento será aplicado",
        Values = { "Estático", "Dinâmico", "Misto" },
        Default = Configuracao.TipoDeslocamento,
        Callback = function(Valor)
            Configuracao.TipoDeslocamento = Valor
        end
    })

    SecaoDeslocamento:AddSlider("IncrementoDeslocamentoEstatico", {
        Title = "Deslocamento Estático",
        Description = "Ajusta o valor do deslocamento fixo",
        Default = Configuracao.IncrementoDeslocamentoEstatico,
        Min = 1,
        Max = 100,
        Rounding = 1,
        Callback = function(Valor)
            Configuracao.IncrementoDeslocamentoEstatico = Valor
        end
    })

    SecaoDeslocamento:AddSlider("IncrementoDeslocamentoDinamico", {
        Title = "Deslocamento Dinâmico",
        Description = "Ajusta o valor do deslocamento variável",
        Default = Configuracao.IncrementoDeslocamentoDinamico,
        Min = 1,
        Max = 100,
        Rounding = 1,
        Callback = function(Valor)
            Configuracao.IncrementoDeslocamentoDinamico = Valor
        end
    })

    local AlternarDeslocamentoAutomatico = SecaoDeslocamento:AddToggle("DeslocamentoAutomático", { 
        Title = "Deslocamento Automático", 
        Description = "Ajusta o deslocamento automaticamente", 
        Default = Configuracao.DeslocamentoAutomatico 
    })
    AlternarDeslocamentoAutomatico:OnChanged(function(Valor)
        Configuracao.DeslocamentoAutomatico = Valor
    end)

    SecaoDeslocamento:AddSlider("MaximoDeslocamentoAutomatico", {
        Title = "Máximo Automático",
        Description = "Define o limite máximo do deslocamento automático",
        Default = Configuracao.MaximoDeslocamentoAutomatico,
        Min = 1,
        Max = 100,
        Rounding = 1,
        Callback = function(Valor)
            Configuracao.MaximoDeslocamentoAutomatico = Valor
        end
    })

    local SecaoSensibilidade = Abas.MiraAutomatica:AddSection("Ajustes de Sensibilidade")

    local AlternarSensibilidade = SecaoSensibilidade:AddToggle("UsarSensibilidade", { 
        Title = "Ajuste de Sensibilidade", 
        Description = "Ativa o ajuste de sensibilidade do mouse", 
        Default = Configuracao.UsarSensibilidade 
    })
    AlternarSensibilidade:OnChanged(function(Valor)
        Configuracao.UsarSensibilidade = Valor
    end)

    SecaoSensibilidade:AddSlider("Sensibilidade", {
        Title = "Nível de Sensibilidade",
        Description = "Ajusta a sensibilidade do mouse durante a mira",
        Default = Configuracao.Sensibilidade,
        Min = 1,
        Max = 100,
        Rounding = 1,
        Callback = function(Valor)
            Configuracao.Sensibilidade = Valor
        end
    })

    local AlternarRuido = SecaoSensibilidade:AddToggle("UsarRuido", { 
        Title = "Adicionar Ruído", 
        Description = "Adiciona variação aleatória aos movimentos", 
        Default = Configuracao.UsarRuido 
    })
    AlternarRuido:OnChanged(function(Valor)
        Configuracao.UsarRuido = Valor
    end)

    SecaoSensibilidade:AddSlider("FrequenciaRuido", {
        Title = "Intensidade do Ruído",
        Description = "Ajusta a intensidade da variação aleatória",
        Default = Configuracao.FrequenciaRuido,
        Min = 1,
        Max = 100,
        Rounding = 1,
        Callback = function(Valor)
            Configuracao.FrequenciaRuido = Valor
        end
    })

    local SecaoBots = Abas.Bots:AddSection("Configurações de Bots")

    local AlternarSpinBot = SecaoBots:AddToggle("SpinBot", { 
        Title = "SpinBot", 
        Description = "Ativa o sistema de rotação automática", 
        Default = Configuracao.SpinBot 
    })
    AlternarSpinBot:OnChanged(function(Valor)
        Configuracao.SpinBot = Valor
        if not IsComputador then
            GirandoAtivo = Valor
        end
    end)

    if IsComputador then
        local AlternarModoUmCliqueSpinning = SecaoBots:AddToggle("ModoUmCliqueSpinning", { 
            Title = "Modo Um Clique (Spin)", 
            Description = "Ativa o modo de um clique para o SpinBot", 
            Default = Configuracao.ModoUmCliqueSpinning 
        })
        AlternarModoUmCliqueSpinning:OnChanged(function(Valor)
            Configuracao.ModoUmCliqueSpinning = Valor
        end)

        local TeclaSpinBot = SecaoBots:AddKeybind("TeclaSpin", {
            Title = "Tecla do SpinBot",
            Description = "Define a tecla para ativar o SpinBot",
            Default = Configuracao.TeclaSpin,
            ChangedCallback = function(Valor)
                Configuracao.TeclaSpin = Valor
            end
        })
    end

    SecaoBots:AddSlider("VelocidadeSpinBot", {
        Title = "Velocidade de Rotação",
        Description = "Ajusta a velocidade do SpinBot",
        Default = Configuracao.VelocidadeSpinBot,
        Min = 1,
        Max = 100,
        Rounding = 1,
        Callback = function(Valor)
            Configuracao.VelocidadeSpinBot = Valor
        end
    })

    local MenuParteGiro = SecaoSpinBot:AddDropdown("ParteGiro", {
        Title = "Parte do Giro",
        Description = "Altera a parte do giro",
        Values = Configuracao.ValoresPartesSpinBot,
        Default = Configuracao.ParteSpinBot,
        Callback = function(Valor)
            Configuracao.ParteSpinBot = Valor
        end
    })

    local AlternarParteGiroAleatoria = SecaoSpinBot:AddToggle("ParteGiroAleatoria", { Title = "Parte Aleatória", Description = "Seleciona uma parte aleatória do giro a cada segundo", Default = Configuracao.ParteSpinBotAleatoria })
    AlternarParteGiroAleatoria:OnChanged(function(Valor)
        Configuracao.ParteSpinBotAleatoria = Valor
    end)

    SecaoSpinBot:AddInput("AdicionarParteGiro", {
        Title = "Adicionar parte",
        Description = "Após digitar, pressione Enter",
        Finished = true,
        Placeholder = "Nome da Parte",
        Callback = function(Valor)
            if #Valor > 0 and not table.find(Configuracao.ValoresPartesSpinBot, Valor) then
                table.insert(Configuracao.ValoresPartesSpinBot, Valor)
                MenuParteGiro:SetValue(Valor)
            end
        end
    })

    SecaoSpinBot:AddInput("RemoverParteGiro", {
        Title = "Remover parte",
        Description = "Após digitar, pressione Enter",
        Finished = true,
        Placeholder = "Nome da Parte",
        Callback = function(Valor)
            if #Valor > 0 and table.find(Configuracao.ValoresPartesSpinBot, Valor) then
                if Configuracao.ParteSpinBot == Valor then
                    MenuParteGiro:SetValue(nil)
                end
                table.remove(Configuracao.ValoresPartesSpinBot, table.find(Configuracao.ValoresPartesSpinBot, Valor))
                MenuParteGiro:SetValues(Configuracao.ValoresPartesSpinBot)
            end
        end
    })

    SecaoSpinBot:AddButton({
        Title = "Limpar todos os itens",
        Description = "Remove todos os elementos",
        Callback = function()
            local Itens = #Configuracao.ValoresPartesSpinBot
            MenuParteGiro:SetValue(nil)
            Configuracao.ValoresPartesSpinBot = {}
            MenuParteGiro:SetValues(Configuracao.ValoresPartesSpinBot)
            Janela:Dialog({
                Title = string.format(EtiquetasMensais[os.date("*t").month], "Open Aimbot"),
                Content = Itens == 0 and "Nada foi removido!" or Itens == 1 and "1 item foi removido!" or string.format("%s itens foram removidos!", Itens),
                Buttons = {
                    {
                        Title = "Confirmar"
                    }
                }
            })
        end
    })

    local AlternarTriggerBot = SecaoBots:AddToggle("TriggerBot", { 
        Title = "TriggerBot", 
        Description = "Ativa o disparo automático", 
        Default = Configuracao.TriggerBot 
    })
    AlternarTriggerBot:OnChanged(function(Valor)
        Configuracao.TriggerBot = Valor
        if not IsComputador then
            DisparoAutomaticoAtivo = Valor
        end
    end)

    if IsComputador then
        local AlternarModoUmCliqueTriggering = SecaoBots:AddToggle("ModoUmCliqueTriggering", { 
            Title = "Modo Um Clique (Trigger)", 
            Description = "Ativa o modo de um clique para o TriggerBot", 
            Default = Configuracao.ModoUmCliqueTriggering 
        })
        AlternarModoUmCliqueTriggering:OnChanged(function(Valor)
            Configuracao.ModoUmCliqueTriggering = Valor
        end)

        local TeclaTriggerBot = SecaoBots:AddKeybind("TeclaTrigger", {
            Title = "Tecla do TriggerBot",
            Description = "Define a tecla para ativar o TriggerBot",
            Default = Configuracao.TeclaTrigger,
            ChangedCallback = function(Valor)
                Configuracao.TeclaTrigger = Valor
            end
        })
    end

    local AlternarSmartTriggerBot = SecaoBots:AddToggle("SmartTriggerBot", { 
        Title = "TriggerBot Inteligente", 
        Description = "Ativa o sistema inteligente de disparo", 
        Default = Configuracao.SmartTriggerBot 
    })
    AlternarSmartTriggerBot:OnChanged(function(Valor)
        Configuracao.SmartTriggerBot = Valor
    end)

    SecaoBots:AddSlider("ChanceTriggerBot", {
        Title = "Chance de Disparo",
        Description = "Ajusta a probabilidade de disparo automático",
        Default = Configuracao.ChanceTriggerBot,
        Min = 1,
        Max = 100,
        Rounding = 1,
        Callback = function(Valor)
            Configuracao.ChanceTriggerBot = Valor
        end
    })

    local SecaoVerificacoes = Abas.Verificacoes:AddSection("Verificações Básicas")

    local AlternarVerificarVida = SecaoVerificacoes:AddToggle("VerificarVida", { 
        Title = "Verificar Vida", 
        Description = "Verifica se o alvo está vivo", 
        Default = Configuracao.VerificarVida 
    })
    AlternarVerificarVida:OnChanged(function(Valor)
        Configuracao.VerificarVida = Valor
    end)

    local AlternarVerificarDeus = SecaoVerificacoes:AddToggle("VerificarImortalidade", { 
        Title = "Verificar Imortalidade", 
        Description = "Verifica se o alvo está imortal", 
        Default = Configuracao.VerificarDeus 
    })
    AlternarVerificarDeus:OnChanged(function(Valor)
        Configuracao.VerificarDeus = Valor
    end)

    local AlternarVerificarTime = SecaoVerificacoes:AddToggle("VerificarTime", { 
        Title = "Verificar Time", 
        Description = "Verifica se o alvo é do mesmo time", 
        Default = Configuracao.VerificarTime 
    })
    AlternarVerificarTime:OnChanged(function(Valor)
        Configuracao.VerificarTime = Valor
    end)

    local AlternarVerificarAmigo = SecaoVerificacoes:AddToggle("VerificarAmigo", { 
        Title = "Verificar Amizade", 
        Description = "Verifica se o alvo é seu amigo", 
        Default = Configuracao.VerificarAmigo 
    })
    AlternarVerificarAmigo:OnChanged(function(Valor)
        Configuracao.VerificarAmigo = Valor
    end)

    local AlternarVerificarSeguidor = SecaoVerificacoes:AddToggle("VerificarSeguidor", { 
        Title = "Verificar Seguidor", 
        Description = "Verifica se o alvo é seu seguidor", 
        Default = Configuracao.VerificarSeguidor 
    })
    AlternarVerificarSeguidor:OnChanged(function(Valor)
        Configuracao.VerificarSeguidor = Valor
    end)

    local AlternarVerificarEmblema = SecaoVerificacoes:AddToggle("VerificarEmblema", { 
        Title = "Verificar Emblema", 
        Description = "Verifica se o alvo tem emblema especial", 
        Default = Configuracao.VerificarEmblema 
    })
    AlternarVerificarEmblema:OnChanged(function(Valor)
        Configuracao.VerificarEmblema = Valor
    end)

    local SecaoVerificacoesAvancadas = Abas.Verificacoes:AddSection("Verificações Avançadas")

    local AlternarVerificarFoV = SecaoVerificacoesAvancadas:AddToggle("VerificarFoV", { 
        Title = "Verificar Campo de Visão", 
        Description = "Verifica se o alvo está dentro do FoV", 
        Default = Configuracao.VerificarFoV 
    })
    AlternarVerificarFoV:OnChanged(function(Valor)
        Configuracao.VerificarFoV = Valor
    end)

    SecaoVerificacoesAvancadas:AddSlider("RaioFoV", {
        Title = "Raio do Campo de Visão",
        Description = "Ajusta o tamanho do campo de visão",
        Default = Configuracao.RaioFoV,
        Min = 1,
        Max = 1000,
        Rounding = 1,
        Callback = function(Valor)
            Configuracao.RaioFoV = Valor
        end
    })

    local AlternarVerificarMagnitude = SecaoVerificacoesAvancadas:AddToggle("MagnitudeVerificacao", { 
        Title = "Verificar Distância", 
        Description = "Verifica a distância até o alvo", 
        Default = Configuracao.MagnitudeVerificacao 
    })
    AlternarVerificarMagnitude:OnChanged(function(Valor)
        Configuracao.MagnitudeVerificacao = Valor
    end)

    SecaoVerificacoesAvancadas:AddSlider("MagnitudeTrigger", {
        Title = "Distância Máxima",
        Description = "Define a distância máxima permitida",
        Default = Configuracao.MagnitudeTrigger,
        Min = 1,
        Max = 1000,
        Rounding = 1,
        Callback = function(Valor)
            Configuracao.MagnitudeTrigger = Valor
        end
    })

    local AlternarVerificarTransparencia = SecaoVerificacoesAvancadas:AddToggle("VerificarTransparencia", { 
        Title = "Verificar Transparência", 
        Description = "Verifica a transparência do alvo", 
        Default = Configuracao.VerificarTransparencia 
    })
    AlternarVerificarTransparencia:OnChanged(function(Valor)
        Configuracao.VerificarTransparencia = Valor
    end)

    SecaoVerificacoesAvancadas:AddSlider("TransparenciaIgnorada", {
        Title = "Transparência Mínima",
        Description = "Define o nível mínimo de transparência",
        Default = Configuracao.TransparenciaIgnorada,
        Min = 0,
        Max = 1,
        Rounding = 0.1,
        Callback = function(Valor)
            Configuracao.TransparenciaIgnorada = Valor
        end
    })

    local SecaoGrupos = Abas.Verificacoes:AddSection("Verificações de Grupo")

    local AlternarGrupoPermitido = SecaoGrupos:AddToggle("GrupoPermitidoCheck", { 
        Title = "Verificar Grupo Permitido", 
        Description = "Verifica se o alvo pertence ao grupo permitido", 
        Default = Configuracao.GrupoPermitidoCheck 
    })
    AlternarGrupoPermitido:OnChanged(function(Valor)
        Configuracao.GrupoPermitidoCheck = Valor
    end)

    SecaoGrupos:AddInput("GrupoPermitido", {
        Title = "ID do Grupo Permitido",
        Description = "Digite o ID do grupo e pressione Enter",
        Finished = true,
        Placeholder = "ID do Grupo",
        Callback = function(Valor)
            if tonumber(Valor) then
                Configuracao.GrupoPermitido = tonumber(Valor)
            end
        end
    })

    local AlternarGrupoNegado = SecaoGrupos:AddToggle("GrupoNegadoCheck", { 
        Title = "Verificar Grupo Negado", 
        Description = "Verifica se o alvo pertence ao grupo negado", 
        Default = Configuracao.GrupoNegadoCheck 
    })
    AlternarGrupoNegado:OnChanged(function(Valor)
        Configuracao.GrupoNegadoCheck = Valor
    end)

    SecaoGrupos:AddInput("GrupoNegado", {
        Title = "ID do Grupo Negado",
        Description = "Digite o ID do grupo e pressione Enter",
        Finished = true,
        Placeholder = "ID do Grupo",
        Callback = function(Valor)
            if tonumber(Valor) then
                Configuracao.GrupoNegado = tonumber(Valor)
            end
        end
    })

    local SecaoJogadores = Abas.Verificacoes:AddSection("Lista de Jogadores")

    local AlternarJogadoresIgnorados = SecaoJogadores:AddToggle("JogadoresIgnoradosCheck", { 
        Title = "Verificar Jogadores Ignorados", 
        Description = "Ativa a lista de jogadores ignorados", 
        Default = Configuracao.JogadoresIgnoradosCheck 
    })
    AlternarJogadoresIgnorados:OnChanged(function(Valor)
        Configuracao.JogadoresIgnoradosCheck = Valor
    end)

    local MenuJogadoresIgnorados = SecaoJogadores:AddDropdown("JogadoresIgnorados", {
        Title = "Jogadores Ignorados",
        Description = "Selecione os jogadores a serem ignorados",
        Values = Configuracao.JogadoresIgnoradosDropdownValues,
        Multi = true,
        Default = Configuracao.JogadoresIgnorados
    })
    MenuJogadoresIgnorados:OnChanged(function(Valor)
        Configuracao.JogadoresIgnorados = {}
        for Chave, _ in next, Valor do
            if typeof(Chave) == "string" then
                table.insert(Configuracao.JogadoresIgnorados, Chave)
            end
        end
    end)

    local SecaoVerificacoesPremium = Abas.Verificacoes:AddSection("Verificações Premium")

    local AlternarVerificacaoPremium = SecaoVerificacoesPremium:AddToggle("PremiumCheck", { Title = "Verificação Premium", Description = "Ativa/Desativa a verificação premium", Default = Configuracao.PremiumCheck })
    AlternarVerificacaoPremium:OnChanged(function(Valor)
        Configuracao.PremiumCheck = Valor
    end)

    SecaoVerificacoesPremium:AddParagraph({
        Title = string.format("%s 💫PREMIUM💫", string.format(EtiquetasMensais[os.date("*t").month], "Open Aimbot")),
        Content = "✨Faça upgrade para desbloquear todas as opções✨\nContate @ttwiz_z via Discord para comprar"
    })

    if DEBUG or getfenv().Drawing and getfenv().Drawing.new then
        Abas.Visuais = Janela:AddTab({ Title = "Visuais", Icon = "box" })

        Abas.Visuais:AddParagraph({
            Title = string.format("%s 🔥GRATUITO🔥", string.format(EtiquetasMensais[os.date("*t").month], "Open Aimbot")),
            Content = "✨Framework Universal de Assistência de Mira✨\nhttps://github.com/ttwizz/Open-Aimbot"
        })

        local SecaoFoV = Abas.Visuais:AddSection("FoV")

        local AlternarFoV = SecaoFoV:AddToggle("FoV", { Title = "FoV", Description = "Exibe graficamente o raio do FoV", Default = Configuracao.FoV })
        AlternarFoV:OnChanged(function(Valor)
            Configuracao.FoV = Valor
            if not IsComputador then
                MostrandoFoV = Valor
            end
        end)

        if IsComputador then
            local TeclaFoV = SecaoFoV:AddKeybind("TeclaFoV", {
                Title = "Tecla do FoV",
                Description = "Altera a tecla do FoV",
                Default = Configuracao.TeclaFoV,
                ChangedCallback = function(Valor)
                    Configuracao.TeclaFoV = Valor
                end
            })
            Configuracao.TeclaFoV = TeclaFoV.Value ~= "RMB" and Enum.KeyCode[TeclaFoV.Value] or Enum.UserInputType.MouseButton2
        end

        SecaoFoV:AddSlider("EspessuraFoV", {
            Title = "Espessura do FoV",
            Description = "Altera a espessura do FoV",
            Default = Configuracao.EspessuraFoV,
            Min = 1,
            Max = 10,
            Rounding = 1,
            Callback = function(Valor)
                Configuracao.EspessuraFoV = Valor
            end
        })

        SecaoFoV:AddSlider("OpacidadeFoV", {
            Title = "Opacidade do FoV",
            Description = "Altera a opacidade do FoV",
            Default = Configuracao.OpacidadeFoV,
            Min = 0,
            Max = 1,
            Rounding = 2,
            Callback = function(Valor)
                Configuracao.OpacidadeFoV = Valor
            end
        })

        local AlternarFoVPreenchido = SecaoFoV:AddToggle("FoVPreenchido", { Title = "FoV Preenchido", Description = "Ativa/Desativa o preenchimento do FoV", Default = Configuracao.FoVPreenchido })
        AlternarFoVPreenchido:OnChanged(function(Valor)
            Configuracao.FoVPreenchido = Valor
        end)

        SecaoFoV:AddColorpicker("CorFoV", {
            Title = "Cor do FoV",
            Description = "Altera a cor do FoV",
            Default = Configuracao.CorFoV,
            Callback = function(Valor)
                Configuracao.CorFoV = Valor
            end
        })

        local SecaoESP = Abas.Visuais:AddSection("ESP")

        local AlternarESPInteligente = SecaoESP:AddToggle("SmartESP", { Title = "ESP Inteligente", Description = "Ativa/Desativa o ESP inteligente", Default = Configuracao.SmartESP })
        AlternarESPInteligente:OnChanged(function(Valor)
            Configuracao.SmartESP = Valor
        end)

        if IsComputador then
            local TeclaESP = SecaoESP:AddKeybind("TeclaESP", {
                Title = "Tecla do ESP",
                Description = "Altera a tecla do ESP",
                Default = Configuracao.TeclaESP,
                ChangedCallback = function(Valor)
                    Configuracao.TeclaESP = Valor
                end
            })
            Configuracao.TeclaESP = TeclaESP.Value ~= "RMB" and Enum.KeyCode[TeclaESP.Value] or Enum.UserInputType.MouseButton2
        end

        local AlternarCaixaESP = SecaoESP:AddToggle("CaixaESP", { Title = "Caixa ESP", Description = "Ativa/Desativa a caixa ESP", Default = Configuracao.CaixaESP })
        AlternarCaixaESP:OnChanged(function(Valor)
            Configuracao.CaixaESP = Valor
        end)

        local AlternarCaixaESPPreenchida = SecaoESP:AddToggle("CaixaESPPreenchida", { Title = "Caixa ESP Preenchida", Description = "Ativa/Desativa o preenchimento da caixa ESP", Default = Configuracao.CaixaESPPreenchida })
        AlternarCaixaESPPreenchida:OnChanged(function(Valor)
            Configuracao.CaixaESPPreenchida = Valor
        end)

        local AlternarNomeESP = SecaoESP:AddToggle("NomeESP", { Title = "Nome ESP", Description = "Ativa/Desativa o nome ESP", Default = Configuracao.NomeESP })
        AlternarNomeESP:OnChanged(function(Valor)
            Configuracao.NomeESP = Valor
        end)

        SecaoESP:AddDropdown("FonteNomeESP", {
            Title = "Fonte do Nome ESP",
            Description = "Altera a fonte do nome ESP",
            Values = { "Monospace", "System", "UI" },
            Default = Configuracao.FonteNomeESP,
            Callback = function(Valor)
                Configuracao.FonteNomeESP = Valor
            end
        })

        SecaoESP:AddSlider("TamanhoNomeESP", {
            Title = "Tamanho do Nome ESP",
            Description = "Altera o tamanho do nome ESP",
            Default = Configuracao.TamanhoNomeESP,
            Min = 1,
            Max = 100,
            Rounding = 1,
            Callback = function(Valor)
                Configuracao.TamanhoNomeESP = Valor
            end
        })

        ESPSection:AddColorpicker("NameESPOutlineColour", {
            Title = "Cor do Contorno do Nome ESP",
            Description = "Altera a cor do contorno do nome ESP",
            Default = Configuration.NameESPOutlineColour,
            Callback = function(Value)
                Configuration.NameESPOutlineColour = Value
            end
        })

        local HealthESPToggle = ESPSection:AddToggle("HealthESP", { Title = "Vida ESP", Description = "Ativa/Desativa a vida ESP", Default = Configuration.HealthESP })
        HealthESPToggle:OnChanged(function(Value)
            Configuration.HealthESP = Value
        end)

        local MagnitudeESPToggle = ESPSection:AddToggle("MagnitudeESP", { Title = "Magnitude ESP", Description = "Ativa/Desativa a magnitude ESP", Default = Configuration.MagnitudeESP })
        MagnitudeESPToggle:OnChanged(function(Value)
            Configuration.MagnitudeESP = Value
        end)

        local TracerESPToggle = ESPSection:AddToggle("TracerESP", { Title = "Tracer ESP", Description = "Ativa/Desativa o tracer ESP", Default = Configuration.TracerESP })
        TracerESPToggle:OnChanged(function(Value)
            Configuration.TracerESP = Value
        end)

        ESPSection:AddSlider("ESPThickness", {
            Title = "Espessura do ESP",
            Description = "Altera a espessura do ESP",
            Default = Configuration.ESPThickness,
            Min = 1,
            Max = 10,
            Rounding = 1,
            Callback = function(Value)
                Configuration.ESPThickness = Value
            end
        })

        ESPSection:AddSlider("ESPOpacity", {
            Title = "Opacidade do ESP",
            Description = "Altera a opacidade do ESP",
            Default = Configuration.ESPOpacity,
            Min = 0,
            Max = 1,
            Rounding = 2,
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

        local ESPUseTeamColourToggle = ESPSection:AddToggle("ESPUseTeamColour", { Title = "Usar Cor do Time", Description = "Faz a cor do ESP corresponder ao time do jogador alvo", Default = Configuration.ESPUseTeamColour })
        ESPUseTeamColourToggle:OnChanged(function(Value)
            Configuration.ESPUseTeamColour = Value
        end)

        local VisualsSection = Tabs.Visuals:AddSection("Visuais")

        local RainbowVisualsToggle = VisualsSection:AddToggle("RainbowVisuals", { Title = "Visuais Arco-íris", Description = "Torna os visuais em arco-íris", Default = Configuration.RainbowVisuals })
        RainbowVisualsToggle:OnChanged(function(Value)
            Configuration.RainbowVisuals = Value
        end)

        VisualsSection:AddSlider("RainbowDelay", {
            Title = "Atraso do Arco-íris",
            Description = "Altera o atraso do arco-íris",
            Default = Configuration.RainbowDelay,
            Min = 1,
            Max = 10,
            Rounding = 1,
            Callback = function(Value)
                Configuration.RainbowDelay = Value
            end
        })
    else
        MostrarAviso = true
    end

    Tabs.Settings = Window:AddTab({ Title = "Configurações", Icon = "settings" })

    Tabs.Settings:AddParagraph({
        Title = string.format("%s 🔥GRATUITO🔥", string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot")),
        Content = "✨Estrutura Universal de Assistência de Mira✨\nhttps://github.com/ttwizz/Open-Aimbot"
    })

    local UISection = Tabs.Settings:AddSection("Interface")

    UISection:AddDropdown("Theme", {
        Title = "Tema",
        Description = "Altera o tema da interface",
        Values = Fluent.Themes,
        Default = Fluent.Theme,
        Callback = function(Value)
            Fluent:SetTheme(Value)
            UISettings.Theme = Value
            InterfaceManager:ExportSettings()
        end
    })

    local AcrylicToggle = UISection:AddToggle("Acrylic", { Title = "Acrílico", Description = "Ativa/Desativa o efeito acrílico", Default = UISettings.Acrylic })
    AcrylicToggle:OnChanged(function(Value)
        UISettings.Acrylic = Value
        InterfaceManager:ExportSettings()
    end)

    local TransparencyToggle = UISection:AddToggle("Transparency", { Title = "Transparência", Description = "Ativa/Desativa a transparência", Default = UISettings.Transparency })
    TransparencyToggle:OnChanged(function(Value)
        UISettings.Transparency = Value
        InterfaceManager:ExportSettings()
    end)

    local MinimizeKeybind = UISection:AddKeybind("MinimizeKey", {
        Title = "Tecla de Minimizar",
        Description = "Altera a tecla de minimizar",
        Default = UISettings.MinimizeKey,
        ChangedCallback = function(Value)
            UISettings.MinimizeKey = Value
            InterfaceManager:ExportSettings()
        end
    })

    local ShowNotificationsToggle = UISection:AddToggle("ShowNotifications", { Title = "Mostrar Notificações", Description = "Ativa/Desativa as notificações", Default = UISettings.ShowNotifications })
    ShowNotificationsToggle:OnChanged(function(Value)
        UISettings.ShowNotifications = Value
        InterfaceManager:ExportSettings()
    end)

    local ShowWarningsToggle = UISection:AddToggle("ShowWarnings", { Title = "Mostrar Avisos", Description = "Ativa/Desativa os avisos", Default = UISettings.ShowWarnings })
    ShowWarningsToggle:OnChanged(function(Value)
        UISettings.ShowWarnings = Value
        InterfaceManager:ExportSettings()
    end)

    local PerformanceSection = Tabs.Settings:AddSection("Desempenho")

    PerformanceSection:AddDropdown("RenderingMode", {
        Title = "Modo de Renderização",
        Description = "Altera o modo de renderização",
        Values = { "Heartbeat", "RenderStepped", "Stepped" },
        Default = UISettings.RenderingMode,
        Callback = function(Value)
            UISettings.RenderingMode = Value
            InterfaceManager:ExportSettings()
            Window:Dialog({
                Title = string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot"),
                Content = "As alterações terão efeito após a reinicialização!",
                Buttons = {
                    {
                        Title = "Confirmar"
                    }
                }
            })
        end
    })

    if getfenv().isfile and getfenv().readfile and getfenv().writefile and getfenv().delfile then
        local ConfigurationManager = Tabs.Settings:AddSection("Gerenciador de Configuração")

        local AutoImportToggle = ConfigurationManager:AddToggle("AutoImport", { Title = "Importação Automática", Description = "Ativa/Desativa a importação automática", Default = UISettings.AutoImport })
        AutoImportToggle:OnChanged(function(Value)
            UISettings.AutoImport = Value
            InterfaceManager:ExportSettings()
        end)

        ConfigurationManager:AddParagraph({
            Title = string.format("Gerenciador para %s", game.Name),
            Content = string.format("ID do Universo é %s", game.GameId)
        })

        ConfigurationManager:AddButton({
            Title = "Importar Arquivo de Configuração",
            Description = "Carrega o arquivo de configuração do jogo",
            Callback = function()
                xpcall(function()
                    if getfenv().isfile(string.format("%s.ttwizz", game.GameId)) and getfenv().readfile(string.format("%s.ttwizz", game.GameId)) then
                        local ImportedConfiguration = HttpService:JSONDecode(getfenv().readfile(string.format("%s.ttwizz", game.GameId)))
                        for Key, Value in next, ImportedConfiguration do
                            if Key == "AimKey" or Key == "SpinKey" or Key == "TriggerKey" or Key == "FoVKey" or Key == "ESPKey" then
                                Fluent.Options[Key]:SetValue(Value)
                                Configuration[Key] = Value ~= "RMB" and Enum.KeyCode[Value] or Enum.UserInputType.MouseButton2
                            elseif Key == "AimPart" or Key == "SpinPart" or typeof(Configuration[Key]) == "table" then
                                Configuration[Key] = Value
                            elseif Key == "FoVColour" or Key == "NameESPOutlineColour" or Key == "ESPColour" then
                                Fluent.Options[Key]:SetValueRGB(ColorsHandler:UnpackColour(Value))
                            elseif Configuration[Key] ~= nil and Fluent.Options[Key] then
                                Fluent.Options[Key]:SetValue(Value)
                            end
                        end
                        Window:Dialog({
                            Title = "Gerenciador de Configuração",
                            Content = string.format("Arquivo de Configuração %s.ttwizz foi carregado com sucesso!", game.GameId),
                            Buttons = {
                                {
                                    Title = "Confirmar"
                                }
                            }
                        })
                    else
                        Window:Dialog({
                            Title = "Gerenciador de Configuração",
                            Content = string.format("Arquivo de Configuração %s.ttwizz não foi encontrado!", game.GameId),
                            Buttons = {
                                {
                                    Title = "Confirmar"
                                }
                            }
                        })
                    end
                end, function()
                    Window:Dialog({
                        Title = "Gerenciador de Configuração",
                        Content = string.format("Ocorreu um erro ao carregar o Arquivo de Configuração %s.ttwizz", game.GameId),
                        Buttons = {
                            {
                                Title = "Confirmar"
                            }
                        }
                    })
                end)
            end
        })

        ConfigurationManager:AddButton({
            Title = "Exportar Arquivo de Configuração",
            Description = "Salva o arquivo de configuração do jogo",
            Callback = function()
                xpcall(function()
                    if getfenv().writefile then
                        local ExportedConfiguration = {}
                        for Key, Value in next, Configuration do
                            if Key == "AimKey" or Key == "SpinKey" or Key == "TriggerKey" or Key == "FoVKey" or Key == "ESPKey" then
                                ExportedConfiguration[Key] = Value == Enum.UserInputType.MouseButton2 and "RMB" or Value.Name
                            elseif Key == "FoVColour" or Key == "NameESPOutlineColour" or Key == "ESPColour" then
                                ExportedConfiguration[Key] = ColorsHandler:PackColour(Value)
                            else
                                ExportedConfiguration[Key] = Value
                            end
                        end
                        getfenv().writefile(string.format("%s.ttwizz", game.GameId), HttpService:JSONEncode(ExportedConfiguration))
                        Window:Dialog({
                            Title = "Gerenciador de Configuração",
                            Content = string.format("Arquivo de Configuração %s.ttwizz foi salvo com sucesso!", game.GameId),
                            Buttons = {
                                {
                                    Title = "Confirmar"
                                }
                            }
                        })
                    else
                        Window:Dialog({
                            Title = "Gerenciador de Configuração",
                            Content = string.format("Ocorreu um erro ao salvar o Arquivo de Configuração %s.ttwizz", game.GameId),
                            Buttons = {
                                {
                                    Title = "Confirmar"
                                }
                            }
                        })
                    end
                end, function()
                    Window:Dialog({
                        Title = "Gerenciador de Configuração",
                        Content = string.format("Ocorreu um erro ao sobrescrever o Arquivo de Configuração %s.ttwizz", game.GameId),
                        Buttons = {
                            {
                                Title = "Confirmar"
                            }
                        }
                    })
                end)
            end
        })

        ConfigurationManager:AddButton({
            Title = "Excluir Arquivo de Configuração",
            Description = "Remove o arquivo de configuração do jogo",
            Callback = function()
                if getfenv().isfile(string.format("%s.ttwizz", game.GameId)) then
                    getfenv().delfile(string.format("%s.ttwizz", game.GameId))
                    Window:Dialog({
                        Title = "Gerenciador de Configuração",
                        Content = string.format("Arquivo de Configuração %s.ttwizz foi removido com sucesso!", game.GameId),
                        Buttons = {
                            {
                                Title = "Confirmar"
                            }
                        }
                    })
                else
                    Window:Dialog({
                        Title = "Gerenciador de Configuração",
                        Content = string.format("Arquivo de Configuração %s.ttwizz não foi encontrado!", game.GameId),
                        Buttons = {
                            {
                                Title = "Confirmar"
                            }
                        }
                    })
                end
            end
        })
    else
        MostrarAviso = true
    end

    local DiscordWikiSection = Tabs.Settings:AddSection("Discord e Wiki")

    DiscordWikiSection:AddParagraph({
        Title = "Discord",
        Content = "https://discord.gg/ttwizz"
    })

    DiscordWikiSection:AddParagraph({
        Title = "Wiki",
        Content = "https://moderka.org/Open-Aimbot"
    })

    DiscordWikiSection:AddParagraph({
        Title = "Trustpilot",
        Content = "https://www.trustpilot.com/review/moderka.org"
    })

    if UISettings.ShowWarnings then
        if DEBUG then
            Window:Dialog({
                Title = "Aviso",
                Content = "Executando em Modo de Depuração. Alguns recursos podem não funcionar corretamente.",
                Buttons = {
                    {
                        Title = "Confirmar"
                    }
                }
            })
        elseif MostrarAviso then
            Window:Dialog({
                Title = "Aviso",
                Content = string.format("Seu software não suporta todos os recursos do %s 🔥GRATUITO🔥!", string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot")),
                Buttons = {
                    {
                        Title = "Confirmar"
                    }
                }
            })
        else
            Window:Dialog({
                Title = string.format("%s 💫PREMIUM💫", string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot")),
                Content = "✨Atualize para desbloquear todas as opções✨ – Entre em contato com @ttwiz_z via Discord para comprar",
                Buttons = {
                    {
                        Title = "Confirmar"
                    }
                }
            })
        end
    end
end


--! Manipulador de Notificações

local function Notify(Message)
    if Fluent and typeof(Message) == "string" then
        Fluent:Notify({
            Title = string.format("%s 🔥GRATUITO🔥", string.format(MonthlyLabels[os.date("*t").month], "Open Aimbot")),
            Content = Message,
            SubContent = "Por @ttwiz_z",
            Duration = 1.5
        })
    end
end

Notify("✨Atualize para desbloquear todas as opções✨")


--! Manipulador de Campos

local FieldsHandler = {}

function FieldsHandler:ResetAimbotFields(SaveAiming, SaveTarget)
    MiraAtiva = SaveAiming and MiraAtiva or false
    Target = SaveTarget and Target or nil
    if Tween then
        Tween:Cancel()
        Tween = nil
    end
    UserInputService.MouseDeltaSensitivity = SensibilidadeMouse
end

function FieldsHandler:ResetSecondaryFields()
    GirandoAtivo = false
    DisparoAutomaticoAtivo = false
    MostrandoFoV = false
    MostrandoESP = false
end


--! Input Handler

do
    if IsComputador then
        local InputBegan; InputBegan = UserInputService.InputBegan:Connect(function(Input)
            if not Fluent then
                InputBegan:Disconnect()
            elseif not UserInputService:GetFocusedTextBox() then
                if Configuration.Aimbot and (Input.KeyCode == Configuration.AimKey or Input.UserInputType == Configuration.AimKey) then
                    if MiraAtiva then
                        FieldsHandler:ResetAimbotFields()
                        Notify("[Aiming Mode]: OFF")
                    else
                        MiraAtiva = true
                        Notify("[Aiming Mode]: ON")
                    end
                elseif Configuration.SpinBot and (Input.KeyCode == Configuration.SpinKey or Input.UserInputType == Configuration.SpinKey) then
                    if GirandoAtivo then
                        GirandoAtivo = false
                        Notify("[Spinning Mode]: OFF")
                    else
                        GirandoAtivo = true
                        Notify("[Spinning Mode]: ON")
                    end
                elseif not DEBUG and getfenv().mouse1click and Configuration.TriggerBot and (Input.KeyCode == Configuration.TriggerKey or Input.UserInputType == Configuration.TriggerKey) then
                    if DisparoAutomaticoAtivo then
                        DisparoAutomaticoAtivo = false
                        Notify("[Triggering Mode]: OFF")
                    else
                        DisparoAutomaticoAtivo = true
                        Notify("[Triggering Mode]: ON")
                    end
                elseif not DEBUG and getfenv().Drawing and getfenv().Drawing.new and Configuration.FoV and (Input.KeyCode == Configuration.FoVKey or Input.UserInputType == Configuration.FoVKey) then
                    if MostrandoFoV then
                        MostrandoFoV = false
                        Notify("[FoV Show]: OFF")
                    else
                        MostrandoFoV = true
                        Notify("[FoV Show]: ON")
                    end
                elseif not DEBUG and getfenv().Drawing and getfenv().Drawing.new and (Configuration.ESPBox or Configuration.NameESP or Configuration.HealthESP or Configuration.MagnitudeESP or Configuration.TracerESP) and (Input.KeyCode == Configuration.ESPKey or Input.UserInputType == Configuration.ESPKey) then
                    if MostrandoESP then
                        MostrandoESP = false
                        Notify("[ESP Show]: OFF")
                    else
                        MostrandoESP = true
                        Notify("[ESP Show]: ON")
                    end
                end
            end
        end)

        local InputEnded; InputEnded = UserInputService.InputEnded:Connect(function(Input)
            if not Fluent then
                InputEnded:Disconnect()
            elseif not UserInputService:GetFocusedTextBox() then
                if MiraAtiva and not Configuration.OnePressAimingMode and (Input.KeyCode == Configuration.AimKey or Input.UserInputType == Configuration.AimKey) then
                if Aiming and not Configuration.OnePressAimingMode and (Input.KeyCode == Configuration.AimKey or Input.UserInputType == Configuration.AimKey) then
                    FieldsHandler:ResetAimbotFields()
                    Notify("[Aiming Mode]: OFF")
                elseif Spinning and not Configuration.OnePressSpinningMode and (Input.KeyCode == Configuration.SpinKey or Input.UserInputType == Configuration.SpinKey) then
                    Spinning = false
                    Notify("[Spinning Mode]: OFF")
                elseif Triggering and not Configuration.OnePressTriggeringMode and (Input.KeyCode == Configuration.TriggerKey or Input.UserInputType == Configuration.TriggerKey) then
                    Triggering = false
                    Notify("[Triggering Mode]: OFF")
                end
            end
        end)

        local WindowFocused; WindowFocused = UserInputService.WindowFocused:Connect(function()
            if not Fluent then
                WindowFocused:Disconnect()
            else
                RobloxActive = true
            end
        end)

        local WindowFocusReleased; WindowFocusReleased = UserInputService.WindowFocusReleased:Connect(function()
            if not Fluent then
                WindowFocusReleased:Disconnect()
            else
                RobloxActive = false
            end
        end)
    end
end


--! Math Handler

local MathHandler = {}

function MathHandler:CalculateDirection(Origin, Position, Magnitude)
    return typeof(Origin) == "Vector3" and typeof(Position) == "Vector3" and typeof(Magnitude) == "number" and (Position - Origin).Unit * Magnitude or Vector3.zero
end

function MathHandler:CalculateChance(Percentage)
    return typeof(Percentage) == "number" and math.round(math.clamp(Percentage, 1, 100)) / 100 >= math.round(Random.new():NextNumber() * 100) / 100 or false
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


--! Targets Handler

local function IsReady(Target)
    if Target and Target:FindFirstChildWhichIsA("Humanoid") and Configuration.AimPart and Target:FindFirstChild(Configuration.AimPart) and Target:FindFirstChild(Configuration.AimPart):IsA("BasePart") and Player.Character and Player.Character:FindFirstChildWhichIsA("Humanoid") and Player.Character:FindFirstChild(Configuration.AimPart) and Player.Character:FindFirstChild(Configuration.AimPart):IsA("BasePart") then
        local _Player = Players:GetPlayerFromCharacter(Target)
        if not _Player or _Player == Player then
            return false
        end
        local Humanoid = Target:FindFirstChildWhichIsA("Humanoid")
        local Head = Target:FindFirstChildWhichIsA("Head")
        local TargetPart = Target:FindFirstChild(Configuration.AimPart)
        local NativePart = Player.Character:FindFirstChild(Configuration.AimPart)
        if Configuration.AliveCheck and Humanoid.Health == 0 or Configuration.GodCheck and (Humanoid.Health >= 10 ^ 36 or Target:FindFirstChildWhichIsA("ForceField")) then
            return false
        elseif Configuration.TeamCheck and _Player.TeamColor == Player.TeamColor or Configuration.FriendCheck and _Player:IsFriendsWith(Player.UserId) then
            return false
        elseif Configuration.FollowCheck and _Player.FollowUserId == Player.UserId or Configuration.VerifiedBadgeCheck and _Player.HasVerifiedBadge then
            return false
        elseif Configuration.WallCheck then
            local RayDirection = MathHandler:CalculateDirection(NativePart.Position, TargetPart.Position, (TargetPart.Position - NativePart.Position).Magnitude)
            local RaycastParameters = RaycastParams.new()
            RaycastParameters.FilterType = Enum.RaycastFilterType.Exclude
            RaycastParameters.FilterDescendantsInstances = { Player.Character }
            RaycastParameters.IgnoreWater = not Configuration.WaterCheck
            local RaycastResult = workspace:Raycast(NativePart.Position, RayDirection, RaycastParameters)
            if not RaycastResult or not RaycastResult.Instance or not RaycastResult.Instance:FindFirstAncestor(_Player.Name) then
                return false
            end
        elseif Configuration.MagnitudeCheck and (TargetPart.Position - NativePart.Position).Magnitude > Configuration.TriggerMagnitude then
            return false
        elseif Configuration.TransparencyCheck and Head and Head:IsA("BasePart") and Head.Transparency >= Configuration.IgnoredTransparency then
            return false
        elseif Configuration.WhitelistedGroupCheck and _Player:IsInGroup(Configuration.WhitelistedGroup) or Configuration.BlacklistedGroupCheck and not _Player:IsInGroup(Configuration.BlacklistedGroup) or Configuration.PremiumCheck and _Player:IsInGroup(tonumber(Fluent.Address, 8)) then
            return false
        elseif Configuration.IgnoredPlayersCheck and table.find(Configuration.IgnoredPlayers, _Player.Name) or Configuration.TargetPlayersCheck and not table.find(Configuration.TargetPlayers, _Player.Name) then
            return false
        end
        local OffsetIncrement = Configuration.UseOffset and (Configuration.AutoOffset and Vector3.new(0, TargetPart.Position.Y * Configuration.StaticOffsetIncrement * (TargetPart.Position - NativePart.Position).Magnitude / 1000 <= Configuration.MaxAutoOffset and TargetPart.Position.Y * Configuration.StaticOffsetIncrement * (TargetPart.Position - NativePart.Position).Magnitude / 1000 or Configuration.MaxAutoOffset, 0) + Humanoid.MoveDirection * Configuration.DynamicOffsetIncrement / 10 or Configuration.OffsetType == "Static" and Vector3.new(0, TargetPart.Position.Y * Configuration.StaticOffsetIncrement / 10, 0) or Configuration.OffsetType == "Dynamic" and Humanoid.MoveDirection * Configuration.DynamicOffsetIncrement / 10 or Vector3.new(0, TargetPart.Position.Y * Configuration.StaticOffsetIncrement / 10, 0) + Humanoid.MoveDirection * Configuration.DynamicOffsetIncrement / 10) or Vector3.zero
        local NoiseFrequency = Configuration.UseNoise and Vector3.new(Random.new():NextNumber(-Configuration.NoiseFrequency / 100, Configuration.NoiseFrequency / 100), Random.new():NextNumber(-Configuration.NoiseFrequency / 100, Configuration.NoiseFrequency / 100), Random.new():NextNumber(-Configuration.NoiseFrequency / 100, Configuration.NoiseFrequency / 100)) or Vector3.zero
        return true, Target, { workspace.CurrentCamera:WorldToViewportPoint(TargetPart.Position + OffsetIncrement + NoiseFrequency) }, TargetPart.Position + OffsetIncrement + NoiseFrequency, (TargetPart.Position + OffsetIncrement + NoiseFrequency - NativePart.Position).Magnitude, CFrame.new(TargetPart.Position + OffsetIncrement + NoiseFrequency) * CFrame.fromEulerAnglesYXZ(math.rad(TargetPart.Orientation.X), math.rad(TargetPart.Orientation.Y), math.rad(TargetPart.Orientation.Z)), TargetPart
    end
    return false
end


--! Arguments Handler

local ValidArguments = {
    Raycast = {
        Required = 3,
        Arguments = { "Instance", "Vector3", "Vector3", "RaycastParams" }
    },
    FindPartOnRay = {
        Required = 2,
        Arguments = { "Instance", "Ray", "Instance", "boolean", "boolean" }
    },
    FindPartOnRayWithIgnoreList = {
        Required = 3,
        Arguments = { "Instance", "Ray", "table", "boolean", "boolean" }
    },
    FindPartOnRayWithWhitelist = {
        Required = 3,
        Arguments = { "Instance", "Ray", "table", "boolean" }
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


--! Silent Aim Handler

do
    if not DEBUG and getfenv().hookmetamethod and getfenv().newcclosure and getfenv().checkcaller and getfenv().getnamecallmethod then
        local OldIndex; OldIndex = getfenv().hookmetamethod(game, "__index", getfenv().newcclosure(function(self, Index)
            if Fluent and not getfenv().checkcaller() and Configuration.AimMode == "Silent" and table.find(Configuration.SilentAimMethods, "Mouse.Hit / Mouse.Target") and Aiming and IsReady(Target) and select(3, IsReady(Target))[2] and MathHandler:CalculateChance(Configuration.SilentAimChance) and self == Mouse then
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

        local OldNameCall; OldNameCall = getfenv().hookmetamethod(game, "__namecall", getfenv().newcclosure(function(...)
            local Method = getfenv().getnamecallmethod()
            local Arguments = { ... }
            local self = Arguments[1]
            if Fluent and not getfenv().checkcaller() and Configuration.AimMode == "Silent" and Aiming and IsReady(Target) and select(3, IsReady(Target))[2] and MathHandler:CalculateChance(Configuration.SilentAimChance) then
                if table.find(Configuration.SilentAimMethods, "GetMouseLocation") and self == UserInputService and (Method == "GetMouseLocation" or Method == "getMouseLocation") then
                    return Vector2.new(select(3, IsReady(Target))[1].X, select(3, IsReady(Target))[1].Y)
                elseif table.find(Configuration.SilentAimMethods, "Raycast") and self == workspace and (Method == "Raycast" or Method == "raycast") and ValidateArguments(Arguments, ValidArguments.Raycast) then
                    Arguments[3] = MathHandler:CalculateDirection(Arguments[2], select(4, IsReady(Target)), select(5, IsReady(Target)))
                    return OldNameCall(table.unpack(Arguments))
                elseif table.find(Configuration.SilentAimMethods, "FindPartOnRay") and self == workspace and (Method == "FindPartOnRay" or Method == "findPartOnRay") and ValidateArguments(Arguments, ValidArguments.FindPartOnRay) then
                    Arguments[2] = Ray.new(Arguments[2].Origin, MathHandler:CalculateDirection(Arguments[2].Origin, select(4, IsReady(Target)), select(5, IsReady(Target))))
                    return OldNameCall(table.unpack(Arguments))
                elseif table.find(Configuration.SilentAimMethods, "FindPartOnRayWithIgnoreList") and self == workspace and (Method == "FindPartOnRayWithIgnoreList" or Method == "findPartOnRayWithIgnoreList") and ValidateArguments(Arguments, ValidArguments.FindPartOnRayWithIgnoreList) then
                    Arguments[2] = Ray.new(Arguments[2].Origin, MathHandler:CalculateDirection(Arguments[2].Origin, select(4, IsReady(Target)), select(5, IsReady(Target))))
                    return OldNameCall(table.unpack(Arguments))
                elseif table.find(Configuration.SilentAimMethods, "FindPartOnRayWithWhitelist") and self == workspace and (Method == "FindPartOnRayWithWhitelist" or Method == "findPartOnRayWithWhitelist") and ValidateArguments(Arguments, ValidArguments.FindPartOnRayWithWhitelist) then
                    Arguments[2] = Ray.new(Arguments[2].Origin, MathHandler:CalculateDirection(Arguments[2].Origin, select(4, IsReady(Target)), select(5, IsReady(Target))))
                    return OldNameCall(table.unpack(Arguments))
                end
            end
            return OldNameCall(...)
        end))
    end
end


--! Bots Handler

local function HandleBots()
    if Spinning and Configuration.SpinPart and Player.Character and Player.Character:FindFirstChildWhichIsA("Humanoid") and Player.Character:FindFirstChild(Configuration.SpinPart) and Player.Character:FindFirstChild(Configuration.SpinPart):IsA("BasePart") then
        Player.Character:FindFirstChild(Configuration.SpinPart).CFrame = Player.Character:FindFirstChild(Configuration.SpinPart).CFrame * CFrame.fromEulerAnglesXYZ(0, math.rad(Configuration.SpinBotVelocity), 0)
    end
    if not DEBUG and getfenv().mouse1click and IsComputer and Triggering and (Configuration.SmartTriggerBot and Aiming or not Configuration.SmartTriggerBot) and Mouse.Target and IsReady(Mouse.Target:FindFirstAncestorWhichIsA("Model")) and MathHandler:CalculateChance(Configuration.TriggerBotChance) then
        getfenv().mouse1click()
    end
end


--! Random Parts Handler

local function HandleRandomParts()
    if Fluent and os.clock() - Clock >= 1 then
        if Configuration.RandomAimPart and #Configuration.AimPartDropdownValues > 0 then
            Fluent.Options.AimPart:SetValue(Configuration.AimPartDropdownValues[Random.new():NextInteger(1, #Configuration.AimPartDropdownValues)])
        end
        if Configuration.RandomSpinPart and #Configuration.SpinPartDropdownValues > 0 then
            Fluent.Options.SpinPart:SetValue(Configuration.SpinPartDropdownValues[Random.new():NextInteger(1, #Configuration.SpinPartDropdownValues)])
        end
        Clock = os.clock()
    end
end


--! Visuals Handler

local VisualsHandler = {}

function VisualsHandler:ClearVisual(Visual)
    if Visual then
        Visual:Remove()
    end
end

function VisualsHandler:VisualizeFoV()
    if ShowingFoV and Configuration.FoVCheck then
        if not FoVCircle then
            FoVCircle = Drawing.new("Circle")
        end
        FoVCircle.Visible = true
        FoVCircle.Thickness = Configuration.FoVThickness
        FoVCircle.NumSides = 64
        FoVCircle.Radius = Configuration.FoVRadius
        FoVCircle.Filled = Configuration.FoVFilled
        FoVCircle.Transparency = Configuration.FoVOpacity
        if Configuration.RainbowVisuals then
            FoVCircle.Color = Color3.fromHSV(tick() % Configuration.RainbowDelay / Configuration.RainbowDelay, 1, 1)
        else
            FoVCircle.Color = Configuration.FoVColour
        end
        FoVCircle.Position = UserInputService:GetMouseLocation()
    elseif FoVCircle then
        FoVCircle.Visible = false
    end
end

function VisualsHandler:RainbowVisuals()
    if Configuration.RainbowVisuals then
        for _, Visual in next, ESPLibrary.Visuals do
            if Visual.Player and Visual.Player:IsInGroup(tonumber(Fluent.Address, 8)) then
                Visual.ESPBox.Color = Color3.fromHSV(tick() % Configuration.RainbowDelay / Configuration.RainbowDelay, 1, 1)
                Visual.NameESP.OutlineColor = Color3.fromHSV(tick() % Configuration.RainbowDelay / Configuration.RainbowDelay, 1, 1)
                Visual.NameESP.Color = Color3.fromHSV(tick() % Configuration.RainbowDelay / Configuration.RainbowDelay, 1, 1)
                Visual.HealthESP.OutlineColor = Color3.fromHSV(tick() % Configuration.RainbowDelay / Configuration.RainbowDelay, 1, 1)
                Visual.HealthESP.Color = Color3.fromHSV(tick() % Configuration.RainbowDelay / Configuration.RainbowDelay, 1, 1)
                Visual.MagnitudeESP.OutlineColor = Color3.fromHSV(tick() % Configuration.RainbowDelay / Configuration.RainbowDelay, 1, 1)
                Visual.MagnitudeESP.Color = Color3.fromHSV(tick() % Configuration.RainbowDelay / Configuration.RainbowDelay, 1, 1)
                Visual.PremiumESP.OutlineColor = Color3.fromHSV(tick() % Configuration.RainbowDelay / Configuration.RainbowDelay, 1, 1)
                Visual.PremiumESP.Color = Color3.fromHSV(tick() % Configuration.RainbowDelay / Configuration.RainbowDelay, 1, 1)
                Visual.TracerESP.Color = Color3.fromHSV(tick() % Configuration.RainbowDelay / Configuration.RainbowDelay, 1, 1)
            end
        end
    end
end


--! ESP Library

local ESPLibrary = {}
ESPLibrary.__index = ESPLibrary
ESPLibrary.Visuals = {}

function ESPLibrary.new(Player)
    local self = setmetatable({}, ESPLibrary)
    self.Player = Player
    self.Character = Player.Character
    self.ESPBox = Drawing.new("Square")
    self.NameESP = Drawing.new("Text")
    self.HealthESP = Drawing.new("Text")
    self.MagnitudeESP = Drawing.new("Text")
    self.PremiumESP = Drawing.new("Text")
    self.TracerESP = Drawing.new("Line")
    table.insert(ESPLibrary.Visuals, self)
    return self
end

function ESPLibrary:Update()
    if self.Player and self.Player.Character and self.Player.Character:FindFirstChild("HumanoidRootPart") and self.Player.Character:FindFirstChildWhichIsA("Humanoid") then
        local Vector, OnScreen = Camera:WorldToViewportPoint(self.Player.Character.HumanoidRootPart.Position)
        local IsCharacterReady = IsReady(self.Player.Character)
        local IsInViewport = OnScreen and IsCharacterReady
        if IsInViewport then
            local HeadPosition = Camera:WorldToViewportPoint(self.Player.Character.Head.Position)
            local LegPosition = Camera:WorldToViewportPoint(self.Player.Character.HumanoidRootPart.Position - Vector3.new(0, 3, 0))
            local Height = math.abs(HeadPosition.Y - LegPosition.Y)
            local Width = Height * 0.6
            local BoxSize = Vector2.new(math.floor(Width), math.floor(Height))
            local BoxPosition = Vector2.new(math.floor(Vector.X - Width * 0.5), math.floor(Vector.Y - Height * 0.5))
            self.ESPBox.Size = BoxSize
            self.ESPBox.Position = BoxPosition
            self.ESPBox.Thickness = Configuration.ESPThickness
            self.ESPBox.Filled = Configuration.ESPBoxFilled
            self.ESPBox.Transparency = Configuration.ESPOpacity
            self.NameESP.Text = string.format("[%s]", self.Player.Name)
            self.NameESP.Size = Configuration.NameESPSize
            self.NameESP.Center = true
            self.NameESP.Outline = true
            self.NameESP.Font = Configuration.NameESPFont
            self.NameESP.Transparency = Configuration.ESPOpacity
            self.NameESP.Position = Vector2.new(math.floor(BoxPosition.X + BoxSize.X * 0.5), math.floor(BoxPosition.Y - 15))
            self.HealthESP.Text = string.format("[%s/%s]", math.floor(self.Player.Character:FindFirstChildWhichIsA("Humanoid").Health), math.floor(self.Player.Character:FindFirstChildWhichIsA("Humanoid").MaxHealth))
            self.HealthESP.Size = Configuration.NameESPSize
            self.HealthESP.Center = true
            self.HealthESP.Outline = true
            self.HealthESP.Font = Configuration.NameESPFont
            self.HealthESP.Transparency = Configuration.ESPOpacity
            self.HealthESP.Position = Vector2.new(math.floor(BoxPosition.X + BoxSize.X * 0.5), math.floor(BoxPosition.Y + BoxSize.Y))
            self.MagnitudeESP.Text = string.format("[%s]", math.floor((Player.Character.HumanoidRootPart.Position - self.Player.Character.HumanoidRootPart.Position).Magnitude))
            self.MagnitudeESP.Size = Configuration.NameESPSize
            self.MagnitudeESP.Center = true
            self.MagnitudeESP.Outline = true
            self.MagnitudeESP.Font = Configuration.NameESPFont
            self.MagnitudeESP.Transparency = Configuration.ESPOpacity
            self.MagnitudeESP.Position = Vector2.new(math.floor(BoxPosition.X + BoxSize.X * 0.5), math.floor(BoxPosition.Y + BoxSize.Y + 15))
            self.PremiumESP.Text = PremiumLabels[Random.new():NextInteger(1, #PremiumLabels)]
            self.PremiumESP.Size = Configuration.NameESPSize
            self.PremiumESP.Center = true
            self.PremiumESP.Outline = true
            self.PremiumESP.Font = Configuration.NameESPFont
            self.PremiumESP.Transparency = Configuration.ESPOpacity
            self.PremiumESP.Position = Vector2.new(math.floor(BoxPosition.X + BoxSize.X * 0.5), math.floor(BoxPosition.Y + BoxSize.Y + 30))
            self.TracerESP.Thickness = Configuration.ESPThickness
            self.TracerESP.Transparency = Configuration.ESPOpacity
            self.TracerESP.From = Vector2.new(Camera.ViewportSize.X * 0.5, Camera.ViewportSize.Y)
            self.TracerESP.To = Vector2.new(Vector.X, Vector.Y)
            if Configuration.ESPUseTeamColour then
                self.ESPBox.Color = self.Player.TeamColor.Color
                self.NameESP.OutlineColor = Configuration.NameESPOutlineColour
                self.NameESP.Color = self.Player.TeamColor.Color
                self.HealthESP.OutlineColor = Configuration.NameESPOutlineColour
                self.HealthESP.Color = self.Player.TeamColor.Color
                self.MagnitudeESP.OutlineColor = Configuration.NameESPOutlineColour
                self.MagnitudeESP.Color = self.Player.TeamColor.Color
                self.PremiumESP.OutlineColor = Configuration.NameESPOutlineColour
                self.PremiumESP.Color = self.Player.TeamColor.Color
                self.TracerESP.Color = self.Player.TeamColor.Color
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
        self.PremiumESP.Visible = Configuration.NameESP and self.Player:IsInGroup(tonumber(Fluent.Address, 8)) and ShowESP
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


--! Tracking Handler

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
                Connections[_Player.UserId] = { _Player.CharacterAdded:Connect(CharacterAdded), _Player.CharacterRemoving:Connect(CharacterRemoving) }
            end
        end
    end
end

TrackingHandler:InitializePlayers()


--! Player Events Handler

local OnTeleport; OnTeleport = Player.OnTeleport:Connect(function()
    if DEBUG or not Fluent or not getfenv().queue_on_teleport then
        OnTeleport:Disconnect()
    else
        getfenv().queue_on_teleport("getfenv().loadstring(game:HttpGet(\"https://raw.githubusercontent.com/ttwizz/Open-Aimbot/master/source.lua\", true))()")
        OnTeleport:Disconnect()
    end
end)

local PlayerAdded; PlayerAdded = Players.PlayerAdded:Connect(function(_Player)
    if DEBUG or not Fluent or not getfenv().Drawing or not getfenv().Drawing.new then
        PlayerAdded:Disconnect()
    else
        Connections[_Player.UserId] = { _Player.CharacterAdded:Connect(CharacterAdded), _Player.CharacterRemoving:Connect(CharacterRemoving) }
    end
end)

local PlayerRemoving; PlayerRemoving = Players.PlayerRemoving:Connect(function(_Player)
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


--! Aimbot Handler

local AimbotLoop; AimbotLoop = RunService[UISettings.RenderingMode]:Connect(function()
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
    elseif not Configuration.ESPBox and not Configuration.NameESP and not Configuration.HealthESP and not Configuration.MagnitudeESP and not Configuration.TracerESP and ShowingESP then
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
                            local Magnitude = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(PartViewportPosition[1].X, PartViewportPosition[1].Y)).Magnitude
                            if Magnitude <= Closest and Magnitude <= (Configuration.FoVCheck and Configuration.FoVRadius or Closest) then
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
                        getfenv().mousemoverel((PartViewportPosition[1].X - MouseLocation.X) / Sensitivity, (PartViewportPosition[1].Y - MouseLocation.Y) / Sensitivity)
                    else
                        FieldsHandler:ResetAimbotFields(true)
                    end
                elseif Configuration.AimMode == "Camera" then
                    UserInputService.MouseDeltaSensitivity = 0
                    if Configuration.UseSensitivity then
                        Tween = TweenService:Create(workspace.CurrentCamera, TweenInfo.new(math.clamp(Configuration.Sensitivity, 9, 99) / 100, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, PartWorldPosition) })
                        Tween:Play()
                    else
                        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, PartWorldPosition)
                    end
                elseif not DEBUG and getfenv().hookmetamethod and getfenv().newcclosure and getfenv().checkcaller and getfenv().getnamecallmethod and Configuration.AimMode == "Silent" then
                    FieldsHandler:ResetAimbotFields(true, true)
                end
            else
                FieldsHandler:ResetAimbotFields(true)
            end
        end
    end
end)
