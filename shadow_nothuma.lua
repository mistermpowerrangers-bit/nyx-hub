-- // NYX HUB V3.3 - O PODER DA NOITE (19 SCRIPTS)
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local NyxHub = Instance.new("ScreenGui", CoreGui)
NyxHub.Name = "NyxHub_V3"

local VERSAO_ATUAL = "3.3"

-- KEY FRAME (senha: sombra015)
local KeyFrame = Instance.new("Frame", NyxHub)
KeyFrame.Size = UDim2.new(0, 300, 0, 160)
KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -80)
KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
KeyFrame.BorderSizePixel = 0
KeyFrame.Visible = true
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", KeyFrame).Color = Color3.fromRGB(100, 0, 255)
Instance.new("UIStroke", KeyFrame).Thickness = 1.5

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Text = "🔐 DIGITE A KEY"
KeyTitle.Size = UDim2.new(1, 0, 0, 30)
KeyTitle.BackgroundTransparency = 1
KeyTitle.TextColor3 = Color3.fromRGB(120, 0, 255)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 16

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(1, -20, 0, 35)
KeyInput.Position = UDim2.new(0, 10, 0, 40)
KeyInput.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
KeyInput.TextColor3 = Color3.new(1,1,1)
KeyInput.PlaceholderText = "Digite a senha..."
KeyInput.Font = Enum.Font.SourceSans
KeyInput.TextSize = 14
Instance.new("UICorner", KeyInput)

local KeyStatus = Instance.new("TextLabel", KeyFrame)
KeyStatus.Size = UDim2.new(1, 0, 0, 20)
KeyStatus.Position = UDim2.new(0, 0, 0, 80)
KeyStatus.BackgroundTransparency = 1
KeyStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
KeyStatus.Text = ""
KeyStatus.Font = Enum.Font.SourceSans
KeyStatus.TextSize = 12

local KeyBtn = Instance.new("TextButton", KeyFrame)
KeyBtn.Size = UDim2.new(1, -20, 0, 35)
KeyBtn.Position = UDim2.new(0, 10, 0, 110)
KeyBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
KeyBtn.TextColor3 = Color3.new(1,1,1)
KeyBtn.Text = "DESBLOQUEAR"
KeyBtn.Font = Enum.Font.GothamBold
KeyBtn.TextSize = 14
Instance.new("UICorner", KeyBtn)

-- BOLINHA FLUTUANTE
local FloatingBtn = Instance.new("TextButton", NyxHub)
FloatingBtn.Size = UDim2.new(0, 50, 0, 50)
FloatingBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
FloatingBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 200)
FloatingBtn.Text = "N"
FloatingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatingBtn.TextSize = 24
FloatingBtn.Visible = false
Instance.new("UICorner", FloatingBtn).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", FloatingBtn).Thickness = 2

-- JANELA PRINCIPAL
local Main = Instance.new("Frame", NyxHub)
Main.Size = UDim2.new(0, 420, 0, 410)
Main.Position = UDim2.new(0.5, -210, 0.5, -205)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.Visible = false
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(100, 0, 255)
Instance.new("UIStroke", Main).Thickness = 1.5

local Title = Instance.new("TextLabel", Main)
Title.Text = "🌑 NYX HUB V3"
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(120, 0, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- ABAS
local TabFrame = Instance.new("Frame", Main)
TabFrame.Size = UDim2.new(1, 0, 0, 30)
TabFrame.Position = UDim2.new(0, 0, 0, 35)
TabFrame.BackgroundTransparency = 1

local AbaEditor = Instance.new("TextButton", TabFrame)
AbaEditor.Size = UDim2.new(0.33, -4, 1, 0)
AbaEditor.Position = UDim2.new(0, 0, 0, 0)
AbaEditor.Text = "📝 EDITOR"
AbaEditor.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
AbaEditor.TextColor3 = Color3.fromRGB(255, 255, 255)
AbaEditor.Font = Enum.Font.GothamBold
AbaEditor.TextSize = 12
Instance.new("UICorner", AbaEditor).CornerRadius = UDim.new(0, 6)

local AbaScripts = Instance.new("TextButton", TabFrame)
AbaScripts.Size = UDim2.new(0.33, -4, 1, 0)
AbaScripts.Position = UDim2.new(0.33, 2, 0, 0)
AbaScripts.Text = "📦 SCRIPTS"
AbaScripts.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
AbaScripts.TextColor3 = Color3.fromRGB(255, 255, 255)
AbaScripts.Font = Enum.Font.GothamBold
AbaScripts.TextSize = 12
Instance.new("UICorner", AbaScripts).CornerRadius = UDim.new(0, 6)

local AbaCreditos = Instance.new("TextButton", TabFrame)
AbaCreditos.Size = UDim2.new(0.34, -4, 1, 0)
AbaCreditos.Position = UDim2.new(0.66, 2, 0, 0)
AbaCreditos.Text = "🏆 CRÉDITOS"
AbaCreditos.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
AbaCreditos.TextColor3 = Color3.fromRGB(255, 255, 255)
AbaCreditos.Font = Enum.Font.GothamBold
AbaCreditos.TextSize = 12
Instance.new("UICorner", AbaCreditos).CornerRadius = UDim.new(0, 6)

-- FRAMES DAS ABAS
local EditorFrame = Instance.new("Frame", Main)
EditorFrame.Size = UDim2.new(1, 0, 1, -100)
EditorFrame.Position = UDim2.new(0, 0, 0, 65)
EditorFrame.BackgroundTransparency = 1
EditorFrame.Visible = true

local ScriptsFrame = Instance.new("Frame", Main)
ScriptsFrame.Size = UDim2.new(1, 0, 1, -100)
ScriptsFrame.Position = UDim2.new(0, 0, 0, 65)
ScriptsFrame.BackgroundTransparency = 1
ScriptsFrame.Visible = false

local CreditosFrame = Instance.new("Frame", Main)
CreditosFrame.Size = UDim2.new(1, 0, 1, -100)
CreditosFrame.Position = UDim2.new(0, 0, 0, 65)
CreditosFrame.BackgroundTransparency = 1
CreditosFrame.Visible = false

-- AVISO DE ATUALIZAÇÃO
local UpdateFrame = Instance.new("Frame", Main)
UpdateFrame.Size = UDim2.new(1, -20, 0, 28)
UpdateFrame.Position = UDim2.new(0, 10, 1, -30)
UpdateFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
UpdateFrame.BorderSizePixel = 0
UpdateFrame.Visible = false
Instance.new("UICorner", UpdateFrame).CornerRadius = UDim.new(0, 6)

local UpdateLabel = Instance.new("TextLabel", UpdateFrame)
UpdateLabel.Size = UDim2.new(0, 180, 1, 0)
UpdateLabel.Position = UDim2.new(0, 8, 0, 0)
UpdateLabel.BackgroundTransparency = 1
UpdateLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
UpdateLabel.Text = "🆕 Nova versão disponível!"
UpdateLabel.Font = Enum.Font.GothamBold
UpdateLabel.TextSize = 11
UpdateLabel.TextXAlignment = Enum.TextXAlignment.Left

local UpdateBtn = Instance.new("TextButton", UpdateFrame)
UpdateBtn.Size = UDim2.new(0, 170, 1, -4)
UpdateBtn.Position = UDim2.new(1, -172, 0, 2)
UpdateBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
UpdateBtn.TextColor3 = Color3.new(1,1,1)
UpdateBtn.Text = "📋 COPIAR ATUALIZAÇÃO"
UpdateBtn.Font = Enum.Font.GothamBold
UpdateBtn.TextSize = 11
Instance.new("UICorner", UpdateBtn).CornerRadius = UDim.new(0, 4)

-- EDITOR
local Editor = Instance.new("TextBox", EditorFrame)
Editor.Size = UDim2.new(1, 0, 0, 200)
Editor.Position = UDim2.new(0, 0, 0, 0)
Editor.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Editor.Text = "-- Insira seu script aqui..."
Editor.TextColor3 = Color3.fromRGB(255, 255, 255)
Editor.MultiLine = true
Editor.ClearTextOnFocus = false
Editor.TextXAlignment = Enum.TextXAlignment.Left
Editor.TextYAlignment = Enum.TextYAlignment.Top
Instance.new("UICorner", Editor)

local ExecuteBtn = Instance.new("TextButton", EditorFrame)
ExecuteBtn.Size = UDim2.new(0, 195, 0, 35)
ExecuteBtn.Position = UDim2.new(0, 0, 0, 210)
ExecuteBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
ExecuteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteBtn.Text = "EXECUTAR"
ExecuteBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", ExecuteBtn)

local ClearBtn = Instance.new("TextButton", EditorFrame)
ClearBtn.Size = UDim2.new(0, 195, 0, 35)
ClearBtn.Position = UDim2.new(1, -195, 0, 210)
ClearBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
ClearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearBtn.Text = "LIMPAR"
ClearBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", ClearBtn)

ExecuteBtn.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        loadstring(Editor.Text)()
    end)
    if not success then warn("Erro: " .. err) end
end)

ClearBtn.MouseButton1Click:Connect(function()
    Editor.Text = ""
end)

-- SCRIPTS PRONTOS (VIA GITHUB)
local baseURL = "https://raw.githubusercontent.com/mistermpowerrangers-bit/nyx-hub/main/"

local scriptsProntos = {
    {nome = "🔍 Teleporte Fantasma", arquivo = "teleporte_fantasma.lua"},
    {nome = "🥊 Hitbox Puller", arquivo = "hitbox_puller.lua"},
    {nome = "📡 V015 Farejador de Sinais", arquivo = "farejador_sinais.lua"},
    {nome = "⚙️ Configurações Elite V015", arquivo = "config_elite.lua"},
    {nome = "👻 Soul Mobile Premium", arquivo = "soul_mobile.lua"},
    {nome = "🎯 Sombra V015 Ultimato", arquivo = "sombra_ultimato.lua"},
    {nome = "💥 V015 Premium Ultra", arquivo = "premium_ultra.lua"},
    {nome = "🔨 ADMIN HAMMER V2", arquivo = "admin_hammer.lua"},
    {nome = "🌀 Infinite Yield", arquivo = "infinite_yield.lua"},
    {nome = "📜 SHipRoX Script", arquivo = "shiprox.lua"},
    {nome = "🍈 Redz Hub (Blox Fruits)", arquivo = "redz_hub.lua"},
    {nome = "🟣 Plataformas Mágicas", arquivo = "plataformas_magicas.lua"},
    {nome = "🌲 Voidware (99 Nights)", arquivo = "voidware_99nights.lua"},
    {nome = "🧠 Chill Hub (Roube um Braiot)", arquivo = "chill_hub.lua"},
    {nome = "🔄 Server Hopper", arquivo = "server_hopper.lua"},
    {nome = "👁️ Mestre da Visão", arquivo = "mestre_da_visao.lua"},
    {nome = "🎯 ELITE HUB V38 ULTRA", arquivo = "elite_hub_aim.lua"},
    {nome = "🏷️ Criador de Títulos", arquivo = "criador_titulos.lua"},
    {nome = "🧱 Wall Jumper + Gravidade", arquivo = "wall_jumper.lua"}
}

local ScriptsScroll = Instance.new("ScrollingFrame", ScriptsFrame)
ScriptsScroll.Size = UDim2.new(1, 0, 1, 0)
ScriptsScroll.BackgroundTransparency = 1
ScriptsScroll.ScrollBarThickness = 6

local ScriptsLayout = Instance.new("UIListLayout", ScriptsScroll)
ScriptsLayout.Padding = UDim.new(0, 5)

for _, script in ipairs(scriptsProntos) do
    local btn = Instance.new("TextButton", ScriptsScroll)
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = script.nome
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(function()
        local url = baseURL .. script.arquivo
        local success, err = pcall(function()
            loadstring(game:HttpGet(url))()
        end)
        if not success then warn("Erro: " .. err) else print("✅ " .. script.nome) end
    end)
end

ScriptsScroll.CanvasSize = UDim2.new(0, 0, 0, #scriptsProntos * 45 + 10)

-- CRÉDITOS
local CreditosScroll = Instance.new("ScrollingFrame", CreditosFrame)
CreditosScroll.Size = UDim2.new(1, 0, 1, 0)
CreditosScroll.BackgroundTransparency = 1

local CreditosLabel = Instance.new("TextLabel", CreditosScroll)
CreditosLabel.Size = UDim2.new(1, -10, 0, 500)
CreditosLabel.Position = UDim2.new(0, 5, 0, 5)
CreditosLabel.BackgroundTransparency = 1
CreditosLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditosLabel.Text = [[🌑 NYX HUB V3
O Poder da Noite

Desenvolvedor: sombra015

Salve, família!
Valeu demais por estarem usando o Nyx. Cada teste que faço me ajuda a trazer escapes novos e mais ajustes pra vocês.

Toda atualização mexe um pouquinho na parte dos scripts — é lá que vou adicionando scripts novos conforme vou testando e aprovando.

Se quiserem acompanhar de perto o que muda, se inscreve lá no canal:
▶️ YouTube: @sombra015br
É por lá que eu mostro as atualizações, explico as novidades e deixo vocês por dentro de tudo antes de sair.

Obrigado pela força e bora juntos! 🔥
]]
CreditosLabel.Font = Enum.Font.SourceSans
CreditosLabel.TextSize = 14
CreditosLabel.TextXAlignment = Enum.TextXAlignment.Left
CreditosLabel.TextYAlignment = Enum.TextYAlignment.Top
CreditosLabel.TextWrapped = true

CreditosScroll.CanvasSize = UDim2.new(0, 0, 0, 500)

-- ALTERNAR ABAS
AbaEditor.MouseButton1Click:Connect(function()
    EditorFrame.Visible = true
    ScriptsFrame.Visible = false
    CreditosFrame.Visible = false
    AbaEditor.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
    AbaScripts.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    AbaCreditos.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
end)

AbaScripts.MouseButton1Click:Connect(function()
    EditorFrame.Visible = false
    ScriptsFrame.Visible = true
    CreditosFrame.Visible = false
    AbaEditor.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    AbaScripts.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
    AbaCreditos.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
end)

AbaCreditos.MouseButton1Click:Connect(function()
    EditorFrame.Visible = false
    ScriptsFrame.Visible = false
    CreditosFrame.Visible = true
    AbaEditor.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    AbaScripts.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    AbaCreditos.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
end)

-- VERIFICAÇÃO DA KEY
local function verificarKey()
    if KeyInput.Text == "sombra015" then
        KeyFrame.Visible = false
        Main.Visible = true
        verificarVersao()
        print("✅ Senha correta! Nyx Hub liberado.")
    else
        KeyStatus.Text = "❌ Senha incorreta!"
        KeyStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
end

KeyBtn.MouseButton1Click:Connect(verificarKey)
KeyInput.FocusLost:Connect(function(enter)
    if enter then verificarKey() end
end)

-- FECHAR (X)
local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", CloseBtn)

CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
    FloatingBtn.Visible = true
end)

FloatingBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    FloatingBtn.Visible = false
end)

-- ARRASTAR
local function MakeDraggable(obj)
    local dragging, dragStart, startPos
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = obj.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(input) dragging = false end)
end

MakeDraggable(KeyFrame)
MakeDraggable(Main)
MakeDraggable(FloatingBtn)

-- VERIFICADOR DE VERSÃO
local LOADSTRING_COMANDO = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/mistermpowerrangers-bit/nyx-hub/main/shadow_nothuma.lua"))()'

local function verificarVersao()
    pcall(function()
        local dados = game:HttpGet("https://raw.githubusercontent.com/mistermpowerrangers-bit/nyx-hub/main/versao.txt")
        if dados then
            local versaoRemota = dados:match("(%d+%.%d+)")
            if versaoRemota and tonumber(versaoRemota) > tonumber(VERSAO_ATUAL) then
                UpdateFrame.Visible = true
                UpdateLabel.Text = "🆕 Nova versão " .. versaoRemota .. " disponível!"
                UpdateBtn.MouseButton1Click:Connect(function()
                    pcall(function() setclipboard(LOADSTRING_COMANDO) end)
                    UpdateLabel.Text = "✅ Copiado! Execute no seu executor."
                    task.delay(3, function()
                        UpdateLabel.Text = "🆕 Nova versão " .. versaoRemota .. " disponível!"
                    end)
                end)
            end
        end
    end)
end

print("🌑 NYX HUB V3.3 CARREGADO!")
print("🔐 Senha: sombra015")
print("🆕 19 scripts disponíveis!")
