local Config = { ModoMira = "OFF", HitboxAtiva = true, CorpoAzul = true, Velocidade = 16, HeadSize = 10, Predict = 0.12, EliteSmooth = 1.5, ForcaManual = 0.5 }
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "Elite_V38_Ultra"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 360, 0, 300); MainFrame.Position = UDim2.new(0.5, -180, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10); MainFrame.Active = true; MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

local Grid = Instance.new("Frame", MainFrame)
Grid.Position = UDim2.new(0, 10, 0, 50); Grid.Size = UDim2.new(1, -20, 1, -60); Grid.BackgroundTransparency = 1
local Layout = Instance.new("UIGridLayout", Grid)
Layout.CellSize = UDim2.new(0, 165, 0, 45); Layout.CellPadding = UDim2.new(0, 10, 0, 10)

local function NewBtn(text, color)
    local b = Instance.new("TextButton", Grid)
    b.Text = text; b.BackgroundColor3 = color; b.TextColor3 = Color3.new(1, 1, 1); b.Font = Enum.Font.GothamBold
    Instance.new("UICorner", b); return b
end

local bElite = NewBtn("MIRA: ELITE", Color3.fromRGB(40, 40, 40))
local bOff = NewBtn("MIRA: OFF", Color3.fromRGB(150, 0, 0))
local bHit = NewBtn("HITBOX HEAD: ON", Color3.fromRGB(180, 0, 0))
local bEsp = NewBtn("ESP: ON", Color3.fromRGB(0, 0, 180))

bElite.MouseButton1Click:Connect(function() Config.ModoMira = "ELITE" end)
bOff.MouseButton1Click:Connect(function() Config.ModoMira = "OFF" end)
bHit.MouseButton1Click:Connect(function() Config.HitboxAtiva = not Config.HitboxAtiva end)
bEsp.MouseButton1Click:Connect(function() Config.CorpoAzul = not Config.CorpoAzul end)

local function EstaVisivel(alvo)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {LocalPlayer.Character, alvo.Parent}
    local cast = workspace:Raycast(Camera.CFrame.Position, (alvo.Position - Camera.CFrame.Position), params)
    return cast == nil
end

RunService.RenderStepped:Connect(function()
    local alvoMaisProximo = nil
    local menorDistancia = math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") then
            local char = p.Character
            local head = char.Head
            if char.Humanoid.Health > 0 then
                if Config.HitboxAtiva then
                    local vHead = head:FindFirstChild("VisualHead") or Instance.new("Part", head)
                    if vHead.Name ~= "VisualHead" then
                        vHead.Name = "VisualHead"; vHead.Shape = "Ball"; vHead.CanCollide = false
                        vHead.CanQuery = false; vHead.Massless = true; vHead.Transparency = 0.8
                        vHead.Color = Color3.new(1,0,0); vHead.Material = "Neon"
                        Instance.new("Weld", vHead).Part0 = vHead; vHead.Weld.Part1 = head
                    end
                    vHead.Size = Vector3.new(Config.HeadSize, Config.HeadSize, Config.HeadSize)
                end
                local _, visivel = Camera:WorldToViewportPoint(head.Position)
                if visivel and EstaVisivel(head) then
                    local dist = (head.Position - Camera.CFrame.Position).Magnitude
                    if dist < menorDistancia then menorDistancia = dist; alvoMaisProximo = head end
                end
            end
        end
    end
    local clicando = UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or UIS:IsMouseButtonPressed(Enum.UserInputType.Touch)
    if Config.ModoMira == "ELITE" and clicando and alvoMaisProximo then
        local delta = UIS:GetMouseDelta().Magnitude
        if delta < (Config.ForcaManual * 25) then
            local pPos = alvoMaisProximo.Position + Vector3.new(0, 0.25, 0) + (alvoMaisProximo.Parent.HumanoidRootPart.Velocity * Config.Predict)
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, pPos), 1/Config.EliteSmooth)
        end
    end
end)

local Close = NewBtn("X", Color3.new(0.5,0,0)); Close.Parent = MainFrame; Close.Position = UDim2.new(1,-35,0,5); Close.Size = UDim2.new(0,30,0,30)
Close.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

print("✅ ELITE HUB V38 ULTRA CARREGADO!")
