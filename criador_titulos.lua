local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")

local cfg = { texto = "Nyx", cor = Color3.fromRGB(255, 255, 255), tamanho = 18 }
local billboard = nil

local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "CriadorTitulos"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 260, 0, 220)
main.Position = UDim2.new(0.5, -130, 0.5, -110)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
main.BorderSizePixel = 0; main.Active = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", main).Color = Color3.fromRGB(255, 150, 0)
Instance.new("UIStroke", main).Thickness = 1.5

local title = Instance.new("TextLabel", main)
title.Text = "🏷️ CRIADOR DE TÍTULOS"; title.Size = UDim2.new(1, -35, 0, 30); title.Position = UDim2.new(0, 5, 0, 5)
title.BackgroundTransparency = 1; title.TextColor3 = Color3.fromRGB(255, 150, 0); title.Font = Enum.Font.GothamBold; title.TextSize = 14

local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 28, 0, 28); closeBtn.Position = UDim2.new(1, -32, 0, 4)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50); closeBtn.TextColor3 = Color3.new(1,1,1); closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.GothamBold; closeBtn.TextSize = 14
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

local bolinha = Instance.new("TextButton", gui)
bolinha.Size = UDim2.new(0, 44, 0, 44); bolinha.Position = UDim2.new(0, 10, 0.1, 0)
bolinha.BackgroundColor3 = Color3.fromRGB(15, 15, 20); bolinha.TextColor3 = Color3.fromRGB(255, 150, 0); bolinha.Text = "🏷️"
bolinha.Font = Enum.Font.GothamBold; bolinha.TextSize = 18; bolinha.Visible = false
Instance.new("UICorner", bolinha).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", bolinha).Color = Color3.fromRGB(255, 150, 0)
Instance.new("UIStroke", bolinha).Thickness = 2

local textoLabel = Instance.new("TextLabel", main)
textoLabel.Text = "📝 Texto do título:"; textoLabel.Size = UDim2.new(1, -20, 0, 18); textoLabel.Position = UDim2.new(0, 10, 0, 42)
textoLabel.BackgroundTransparency = 1; textoLabel.TextColor3 = Color3.fromRGB(200, 200, 200); textoLabel.Font = Enum.Font.SourceSans; textoLabel.TextSize = 11
textoLabel.TextXAlignment = Enum.TextXAlignment.Left

local textoInput = Instance.new("TextBox", main)
textoInput.Size = UDim2.new(1, -20, 0, 30); textoInput.Position = UDim2.new(0, 10, 0, 62)
textoInput.BackgroundColor3 = Color3.fromRGB(10, 10, 12); textoInput.TextColor3 = Color3.new(1,1,1)
textoInput.Text = "Nyx"; textoInput.Font = Enum.Font.SourceSans; textoInput.TextSize = 14
Instance.new("UICorner", textoInput).CornerRadius = UDim.new(0, 6)

local coresFrame = Instance.new("Frame", main)
coresFrame.Size = UDim2.new(1, -20, 0, 30); coresFrame.Position = UDim2.new(0, 10, 0, 100)
coresFrame.BackgroundTransparency = 1

local cores = {
    {cor = Color3.fromRGB(255, 255, 255)}, {cor = Color3.fromRGB(255, 50, 50)},
    {cor = Color3.fromRGB(50, 255, 50)}, {cor = Color3.fromRGB(50, 50, 255)},
    {cor = Color3.fromRGB(255, 255, 0)}, {cor = Color3.fromRGB(255, 0, 255)}
}

for i, corData in ipairs(cores) do
    local corBtn = Instance.new("TextButton", coresFrame)
    corBtn.Size = UDim2.new(0, 36, 0, 28); corBtn.Position = UDim2.new(0, (i-1)*38, 0, 0)
    corBtn.BackgroundColor3 = corData.cor; corBtn.Text = ""; corBtn.BorderSizePixel = 0
    Instance.new("UICorner", corBtn).CornerRadius = UDim.new(0, 4)
    corBtn.MouseButton1Click:Connect(function() cfg.cor = corData.cor; atualizarTitulo() end)
end

local tamanhoLabel = Instance.new("TextLabel", main)
tamanhoLabel.Text = "📏 Tamanho: 18"; tamanhoLabel.Size = UDim2.new(1, -20, 0, 18); tamanhoLabel.Position = UDim2.new(0, 10, 0, 138)
tamanhoLabel.BackgroundTransparency = 1; tamanhoLabel.TextColor3 = Color3.fromRGB(200, 200, 200); tamanhoLabel.Font = Enum.Font.SourceSans
tamanhoLabel.TextSize = 11; tamanhoLabel.TextXAlignment = Enum.TextXAlignment.Left

local tamanhoSlider = Instance.new("TextButton", main)
tamanhoSlider.Size = UDim2.new(1, -20, 0, 22); tamanhoSlider.Position = UDim2.new(0, 10, 0, 156)
tamanhoSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 45); tamanhoSlider.BorderSizePixel = 0
tamanhoSlider.Text = "Clique para aumentar"; tamanhoSlider.TextColor3 = Color3.fromRGB(200, 200, 200)
tamanhoSlider.Font = Enum.Font.SourceSans; tamanhoSlider.TextSize = 11
Instance.new("UICorner", tamanhoSlider).CornerRadius = UDim.new(0, 6)
tamanhoSlider.MouseButton1Click:Connect(function()
    cfg.tamanho = cfg.tamanho >= 48 and 8 or cfg.tamanho + 2
    tamanhoLabel.Text = "📏 Tamanho: " .. cfg.tamanho
    atualizarTitulo()
end)

local function atualizarTitulo()
    local char = LP.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end
    if billboard then billboard:Destroy(); billboard = nil end
    billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 250, 0, 40); billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true; billboard.MaxDistance = 500; billboard.Parent = head
    local label = Instance.new("TextLabel", billboard)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundColor3 = Color3.fromRGB(0, 0, 0); label.BackgroundTransparency = 1
    label.TextColor3 = cfg.cor; label.Text = cfg.texto; label.Font = Enum.Font.GothamBold
    label.TextSize = cfg.tamanho; label.TextStrokeTransparency = 0.5; label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
end

local aplicarBtn = Instance.new("TextButton", main)
aplicarBtn.Size = UDim2.new(1, -20, 0, 28); aplicarBtn.Position = UDim2.new(0, 10, 0, 186)
aplicarBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0); aplicarBtn.TextColor3 = Color3.new(1,1,1)
aplicarBtn.Text = "✅ APLICAR TÍTULO"; aplicarBtn.Font = Enum.Font.GothamBold; aplicarBtn.TextSize = 12
Instance.new("UICorner", aplicarBtn).CornerRadius = UDim.new(0, 6)
aplicarBtn.MouseButton1Click:Connect(function() cfg.texto = textoInput.Text; atualizarTitulo() end)

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

LP.CharacterAdded:Connect(function(char)
    if cfg.texto ~= "" then task.wait(0.5); atualizarTitulo() end
end)

print("🏷️ CRIADOR DE TÍTULOS CARREGADO!")
