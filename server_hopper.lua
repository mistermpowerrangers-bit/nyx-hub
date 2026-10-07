local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId

local historicoServidores = {}

local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "ServerHopper"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 300, 0, 250)
main.Position = UDim2.new(0.5, -150, 0.5, -125)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
main.BorderSizePixel = 0
main.Active = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", main).Color = Color3.fromRGB(0, 150, 255)
Instance.new("UIStroke", main).Thickness = 1.5

local title = Instance.new("TextLabel", main)
title.Text = "🔄 SERVER HOPPER"
title.Size = UDim2.new(1, -35, 0, 30)
title.Position = UDim2.new(0, 5, 0, 5)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(0, 150, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 14

local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -32, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

local bolinha = Instance.new("TextButton", gui)
bolinha.Size = UDim2.new(0, 45, 0, 45)
bolinha.Position = UDim2.new(0, 10, 0.1, 0)
bolinha.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
bolinha.TextColor3 = Color3.new(1,1,1)
bolinha.Text = "🔄"
bolinha.Font = Enum.Font.GothamBold
bolinha.TextSize = 18
bolinha.Visible = false
Instance.new("UICorner", bolinha).CornerRadius = UDim.new(1, 0)

local hopBtn = Instance.new("TextButton", main)
hopBtn.Size = UDim2.new(1, -20, 0, 35)
hopBtn.Position = UDim2.new(0, 10, 0, 45)
hopBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
hopBtn.TextColor3 = Color3.new(1,1,1)
hopBtn.Text = "🔄 TROCAR DE SERVIDOR"
hopBtn.Font = Enum.Font.GothamBold
hopBtn.TextSize = 13
Instance.new("UICorner", hopBtn).CornerRadius = UDim.new(0, 6)

local scriptLabel = Instance.new("TextLabel", main)
scriptLabel.Text = "📝 Insira um Script para executar:"
scriptLabel.Size = UDim2.new(1, -20, 0, 20)
scriptLabel.Position = UDim2.new(0, 10, 0, 90)
scriptLabel.BackgroundTransparency = 1
scriptLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
scriptLabel.Font = Enum.Font.SourceSans
scriptLabel.TextSize = 12
scriptLabel.TextXAlignment = Enum.TextXAlignment.Left

local scriptInput = Instance.new("TextBox", main)
scriptInput.Size = UDim2.new(1, -20, 0, 35)
scriptInput.Position = UDim2.new(0, 10, 0, 112)
scriptInput.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
scriptInput.TextColor3 = Color3.new(1,1,1)
scriptInput.PlaceholderText = "Cole o script aqui..."
scriptInput.Font = Enum.Font.Code
scriptInput.TextSize = 13
Instance.new("UICorner", scriptInput).CornerRadius = UDim.new(0, 6)

local execBtn = Instance.new("TextButton", main)
execBtn.Size = UDim2.new(1, -20, 0, 30)
execBtn.Position = UDim2.new(0, 10, 0, 152)
execBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
execBtn.TextColor3 = Color3.new(1,1,1)
execBtn.Text = "▶️ EXECUTAR SCRIPT"
execBtn.Font = Enum.Font.GothamBold
execBtn.TextSize = 13
Instance.new("UICorner", execBtn).CornerRadius = UDim.new(0, 6)

local historicoLabel = Instance.new("TextLabel", main)
historicoLabel.Text = "📋 Últimos servidores:"
historicoLabel.Size = UDim2.new(1, -20, 0, 20)
historicoLabel.Position = UDim2.new(0, 10, 0, 190)
historicoLabel.BackgroundTransparency = 1
historicoLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
historicoLabel.Font = Enum.Font.SourceSans
historicoLabel.TextSize = 12
historicoLabel.TextXAlignment = Enum.TextXAlignment.Left

local historicoScroll = Instance.new("ScrollingFrame", main)
historicoScroll.Size = UDim2.new(1, -20, 0, 45)
historicoScroll.Position = UDim2.new(0, 10, 0, 212)
historicoScroll.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
historicoScroll.BorderSizePixel = 0
historicoScroll.ScrollBarThickness = 4
Instance.new("UICorner", historicoScroll).CornerRadius = UDim.new(0, 6)

local historicoLayout = Instance.new("UIListLayout", historicoScroll)
historicoLayout.Padding = UDim.new(0, 2)

local function atualizarHistorico()
    for _, child in pairs(historicoScroll:GetChildren()) do
        if child:IsA("TextLabel") then child:Destroy() end
    end
    for _, servidor in ipairs(historicoServidores) do
        local lbl = Instance.new("TextLabel", historicoScroll)
        lbl.Size = UDim2.new(1, 0, 0, 18)
        lbl.BackgroundTransparency = 1
        lbl.TextColor3 = Color3.new(0.7, 0.7, 0.7)
        lbl.Text = servidor
        lbl.Font = Enum.Font.Code
        lbl.TextSize = 10
        lbl.TextXAlignment = Enum.TextXAlignment.Left
    end
    historicoScroll.CanvasSize = UDim2.new(0, 0, 0, #historicoServidores * 20 + 5)
end

local function adicionarAoHistorico(jobId)
    for _, s in ipairs(historicoServidores) do
        if s == jobId then return end
    end
    table.insert(historicoServidores, 1, jobId)
    if #historicoServidores > 10 then
        table.remove(historicoServidores, #historicoServidores)
    end
    atualizarHistorico()
end

if game.JobId ~= "" then adicionarAoHistorico(game.JobId) end

local function trocarServidor()
    local success, serversData = pcall(function()
        local url = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        return HttpService:JSONDecode(game:HttpGet(url))
    end)
    if success and serversData and serversData.data and #serversData.data > 0 then
        local validos = {}
        for _, server in ipairs(serversData.data) do
            if server.id ~= game.JobId and server.playing < server.maxPlayers then
                table.insert(validos, server)
            end
        end
        if #validos > 0 then
            local escolhido = validos[math.random(1, #validos)]
            pcall(function()
                TeleportService:TeleportToPlaceInstance(PlaceId, escolhido.id, LocalPlayer)
            end)
            adicionarAoHistorico(escolhido.id)
        else
            TeleportService:Teleport(PlaceId)
        end
    else
        TeleportService:Teleport(PlaceId)
    end
end

hopBtn.MouseButton1Click:Connect(trocarServidor)

execBtn.MouseButton1Click:Connect(function()
    local codigo = scriptInput.Text
    if codigo ~= "" then
        pcall(function() loadstring(codigo)() end)
    end
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

print("🔄 SERVER HOPPER CARREGADO!")
