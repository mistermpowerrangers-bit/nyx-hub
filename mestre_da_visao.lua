local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local cfg = { espAtivo = true, barraVidaAtiva = true, corEsqueleto = Color3.fromRGB(255, 0, 0), corBorda = Color3.fromRGB(0, 255, 255), corFundo = Color3.fromRGB(0, 0, 0), corTexto = Color3.fromRGB(255, 255, 255), grosuraLinha = 1.5 }

local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "MestreDaVisao"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 240, 0, 140); main.Position = UDim2.new(0.5, -120, 0.4, -70)
main.BackgroundColor3 = cfg.corFundo; main.BorderSizePixel = 0; main.Active = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", main).Color = cfg.corBorda
Instance.new("UIStroke", main).Thickness = 2

local title = Instance.new("TextLabel", main)
title.Text = "MESTRE DA VISÃO"; title.Size = UDim2.new(1, -35, 0, 30); title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1; title.TextColor3 = cfg.corTexto; title.Font = Enum.Font.GothamBold; title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 28, 0, 28); closeBtn.Position = UDim2.new(1, -32, 0, 4)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50); closeBtn.TextColor3 = cfg.corTexto; closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.GothamBold; closeBtn.TextSize = 14
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

local espBtn = Instance.new("TextButton", main)
espBtn.Size = UDim2.new(1, -20, 0, 32); espBtn.Position = UDim2.new(0, 10, 0, 45)
espBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0); espBtn.TextColor3 = cfg.corTexto; espBtn.Text = "👁️ ESP: ON"
espBtn.Font = Enum.Font.GothamBold; espBtn.TextSize = 12
Instance.new("UICorner", espBtn).CornerRadius = UDim.new(0, 6)

local hpBtn = Instance.new("TextButton", main)
hpBtn.Size = UDim2.new(1, -20, 0, 32); hpBtn.Position = UDim2.new(0, 10, 0, 85)
hpBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0); hpBtn.TextColor3 = cfg.corTexto; hpBtn.Text = "❤️ BARRA DE VIDA: ON"
hpBtn.Font = Enum.Font.GothamBold; hpBtn.TextSize = 12
Instance.new("UICorner", hpBtn).CornerRadius = UDim.new(0, 6)

local bolinha = Instance.new("TextButton", gui)
bolinha.Size = UDim2.new(0, 44, 0, 44); bolinha.Position = UDim2.new(0, 10, 0.1, 0)
bolinha.BackgroundColor3 = cfg.corFundo; bolinha.TextColor3 = cfg.corBorda; bolinha.Text = "M"
bolinha.Font = Enum.Font.GothamBold; bolinha.TextSize = 18; bolinha.Visible = false
Instance.new("UICorner", bolinha).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", bolinha).Color = cfg.corBorda
Instance.new("UIStroke", bolinha).Thickness = 2

espBtn.MouseButton1Click:Connect(function()
    cfg.espAtivo = not cfg.espAtivo
    espBtn.Text = "👁️ ESP: " .. (cfg.espAtivo and "ON" or "OFF")
    espBtn.BackgroundColor3 = cfg.espAtivo and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)
hpBtn.MouseButton1Click:Connect(function()
    cfg.barraVidaAtiva = not cfg.barraVidaAtiva
    hpBtn.Text = "❤️ BARRA DE VIDA: " .. (cfg.barraVidaAtiva and "ON" or "OFF")
    hpBtn.BackgroundColor3 = cfg.barraVidaAtiva and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)
closeBtn.MouseButton1Click:Connect(function() main.Visible = false; bolinha.Visible = true end)
bolinha.MouseButton1Click:Connect(function() main.Visible = true; bolinha.Visible = false end)

local function makeDraggable(obj)
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
    UIS.InputEnded:Connect(function() dragging = false end)
end
makeDraggable(main)
makeDraggable(bolinha)

local R15_CONEXOES = {
    {"Head","UpperTorso"},{"UpperTorso","LowerTorso"},
    {"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},
    {"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},
    {"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},
    {"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"}
}
local R6_CONEXOES = {{"Head","Torso"},{"Torso","Left Arm"},{"Torso","Right Arm"},{"Torso","Left Leg"},{"Torso","Right Leg"}}

local function obterConexoes(char)
    if char:FindFirstChild("UpperTorso") then return R15_CONEXOES
    elseif char:FindFirstChild("Torso") then return R6_CONEXOES end
    return nil
end

local function criarLinha()
    local d = Drawing.new("Line"); d.Visible = false; d.Color = cfg.corEsqueleto; d.Thickness = cfg.grosuraLinha
    return d
end
local function criarBarraVida()
    local fundo = Drawing.new("Square"); fundo.Visible = false; fundo.Color = Color3.fromRGB(0,0,0); fundo.Filled = true; fundo.Thickness = 1
    local preenchimento = Drawing.new("Square"); preenchimento.Visible = false; preenchimento.Color = Color3.fromRGB(0,255,0); preenchimento.Filled = true
    local borda = Drawing.new("Square"); borda.Visible = false; borda.Color = cfg.corBorda; borda.Thickness = 1; borda.Filled = false
    local texto = Drawing.new("Text"); texto.Visible = false; texto.Color = cfg.corTexto; texto.Size = 12; texto.Center = true
    return {fundo = fundo, preenchimento = preenchimento, borda = borda, texto = texto}
end

local MAX_JOGADORES = 30
local MAX_LINHAS_POR_JOGADOR = 14
local poolLinhas = {}
for _ = 1, MAX_JOGADORES * MAX_LINHAS_POR_JOGADOR do table.insert(poolLinhas, criarLinha()) end
local poolBarras = {}
for _ = 1, MAX_JOGADORES do table.insert(poolBarras, criarBarraVida()) end

RunService.RenderStepped:Connect(function()
    local idxLinha = 1
    local idxBarra = 1
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LP and player.Character then
            local char = player.Character
            local humanoid = char:FindFirstChild("Humanoid")
            local head = char:FindFirstChild("Head")
            if humanoid and head and humanoid.Health > 0 then
                if cfg.espAtivo then
                    local conexoes = obterConexoes(char)
                    if conexoes then
                        for _, conexao in ipairs(conexoes) do
                            local parteA = char:FindFirstChild(conexao[1])
                            local parteB = char:FindFirstChild(conexao[2])
                            if parteA and parteB and idxLinha <= #poolLinhas then
                                local posA, visA = Camera:WorldToViewportPoint(parteA.Position)
                                local posB, visB = Camera:WorldToViewportPoint(parteB.Position)
                                local linha = poolLinhas[idxLinha]
                                if visA and visB then
                                    linha.Visible = true
                                    linha.From = Vector2.new(posA.X, posA.Y)
                                    linha.To = Vector2.new(posB.X, posB.Y)
                                else linha.Visible = false end
                                idxLinha = idxLinha + 1
                            end
                        end
                    end
                end
                if cfg.barraVidaAtiva and idxBarra <= #poolBarras then
                    local posC, visC = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 2.5, 0))
                    local barra = poolBarras[idxBarra]
                    if visC then
                        local ratio = humanoid.Health / humanoid.MaxHealth
                        local width = 80; local height = 6
                        local x = posC.X - width/2; local y = posC.Y - height/2
                        barra.fundo.Visible = true; barra.fundo.Position = Vector2.new(x, y); barra.fundo.Size = Vector2.new(width, height)
                        local corVida = ratio > 0.5 and Color3.fromRGB(0,255,0) or (ratio > 0.25 and Color3.fromRGB(255,255,0) or Color3.fromRGB(255,0,0))
                        barra.preenchimento.Visible = true; barra.preenchimento.Color = corVida
                        barra.preenchimento.Position = Vector2.new(x, y); barra.preenchimento.Size = Vector2.new(width * ratio, height)
                        barra.borda.Visible = true; barra.borda.Position = Vector2.new(x, y); barra.borda.Size = Vector2.new(width, height)
                        barra.texto.Visible = true; barra.texto.Position = Vector2.new(posC.X, y - 12)
                        barra.texto.Text = player.DisplayName; barra.texto.Color = cfg.corTexto
                    else
                        barra.fundo.Visible = false; barra.preenchimento.Visible = false
                        barra.borda.Visible = false; barra.texto.Visible = false
                    end
                    idxBarra = idxBarra + 1
                end
            end
        end
    end
    for i = idxLinha, #poolLinhas do poolLinhas[i].Visible = false end
    for i = idxBarra, #poolBarras do
        poolBarras[i].fundo.Visible = false; poolBarras[i].preenchimento.Visible = false
        poolBarras[i].borda.Visible = false; poolBarras[i].texto.Visible = false
    end
end)

print("🌑 MESTRE DA VISÃO CARREGADO!")
