local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local WS = game:GetService("Workspace")

local ativo = false
local plataformas = {}
local MAX_PLATAFORMAS = 5
local intervalo_criacao = 0.05

local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "PlataformasMagicas"

local container = Instance.new("Frame", gui)
container.Size = UDim2.new(0, 100, 0, 100)
container.Position = UDim2.new(0, 100, 0, 100)
container.BackgroundTransparency = 1
container.Active = true

local botao = Instance.new("TextButton", container)
botao.Size = UDim2.new(0, 65, 0, 65)
botao.Position = UDim2.new(0.5, -32.5, 0.5, -32.5)
botao.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
botao.TextColor3 = Color3.fromRGB(255, 255, 255)
botao.Text = "SUBIR\nOFF"
botao.Font = Enum.Font.GothamBold
botao.TextSize = 13
botao.TextScaled = true
Instance.new("UICorner", botao).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", botao).Color = Color3.fromRGB(200, 100, 255)
Instance.new("UIStroke", botao).Thickness = 2

local arrastando = false
local posicaoInicial
container.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        arrastando = true
        posicaoInicial = input.Position - container.AbsolutePosition
    end
end)
UIS.InputChanged:Connect(function(input)
    if arrastando and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local novaPos = input.Position - posicaoInicial
        container.Position = UDim2.new(0, novaPos.X, 0, novaPos.Y)
    end
end)
UIS.InputEnded:Connect(function() arrastando = false end)

local function criarPlataforma()
    local char = LP.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local plataforma = Instance.new("Part")
    plataforma.Size = Vector3.new(5, 0.5, 5)
    plataforma.Anchored = true
    plataforma.CanCollide = true
    plataforma.BrickColor = BrickColor.new("Deep purple")
    plataforma.Material = Enum.Material.Neon
    plataforma.Transparency = 0.2
    plataforma.Position = root.Position - Vector3.new(0, 3, 0)
    plataforma.Parent = WS
    table.insert(plataformas, plataforma)
    return plataforma
end

local function loopSubir()
    while ativo do
        pcall(function()
            criarPlataforma()
            while #plataformas > MAX_PLATAFORMAS do
                local plat = table.remove(plataformas, 1)
                if plat and plat.Parent then plat:Destroy() end
                task.wait(0.001)
            end
        end)
        task.wait(intervalo_criacao)
    end
end

botao.MouseButton1Click:Connect(function()
    ativo = not ativo
    if ativo then
        botao.Text = "SUBIR\nON"
        botao.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
        task.spawn(loopSubir)
    else
        botao.Text = "SUBIR\nOFF"
        botao.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
    end
end)

print("🟣 CRIADOR DE PLATAFORMAS MÁGICAS CARREGADO!")
