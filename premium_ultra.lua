local Config = { ModoMira = "ELITE", HitboxAtiva = true, ESP = true, Predict = 0.12, EliteSmooth = 1.05, ForcaManual = 2.5, HeadSize = 12 }
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "V015_Premium_Ultra"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 380, 0, 280)
Main.Position = UDim2.new(0.5, -190, 0.4, -140)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main)
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 50, 0, 50); OpenBtn.Position = UDim2.new(0, 20, 0.5, -25)
OpenBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0); OpenBtn.Text = "V015"; OpenBtn.TextColor3 = Color3.new(1,1,1)
OpenBtn.Visible = false; OpenBtn.Draggable = true; OpenBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(1, 0)
local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Size = UDim2.new(0, 35, 0, 35); CloseBtn.Position = UDim2.new(1, -40, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); CloseBtn.Text = "X"; CloseBtn.TextColor3 = Color3.new(1,0,0)
Instance.new("UICorner", CloseBtn)
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false; OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() Main.Visible = true; OpenBtn.Visible = false end)
local Grid = Instance.new("Frame", Main)
Grid.Position = UDim2.new(0, 10, 0, 50); Grid.Size = UDim2.new(1, -20, 1, -60); Grid.BackgroundTransparency = 1
local Layout = Instance.new("UIGridLayout", Grid)
Layout.CellSize = UDim2.new(0, 170, 0, 45); Layout.CellPadding = UDim2.new(0, 10, 0, 10)
local function NewBtn(text, color)
    local b = Instance.new("TextButton", Grid)
    b.Text = text; b.BackgroundColor3 = color; b.TextColor3 = Color3.new(1, 1, 1); b.Font = Enum.Font.GothamBold; b.TextSize = 13
    Instance.new("UICorner", b); return b
end
local bMira = NewBtn("MIRA: ELITE", Color3.fromRGB(60, 0, 150))
local bHitbox = NewBtn("CABEÇA FANTASMA: ON", Color3.fromRGB(180, 0, 0))
local bESP = NewBtn("ESP BRILHO: ON", Color3.fromRGB(0, 100, 200))
local bStatus = NewBtn("STATUS: SUPREMO", Color3.fromRGB(20, 20, 20))
bMira.MouseButton1Click:Connect(function()
    Config.ModoMira = (Config.ModoMira == "ELITE") and "OFF" or "ELITE"
    bMira.Text = "MIRA: " .. Config.ModoMira
    bMira.BackgroundColor3 = (Config.ModoMira == "ELITE") and Color3.fromRGB(60, 0, 150) or Color3.fromRGB(150, 0, 0)
end)
bHitbox.MouseButton1Click:Connect(function()
    Config.HitboxAtiva = not Config.HitboxAtiva
    bHitbox.Text = "CABEÇA FANTASMA: " .. (Config.HitboxAtiva and "ON" or "OFF")
    bHitbox.BackgroundColor3 = Config.HitboxAtiva and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(40, 40, 40)
end)
bESP.MouseButton1Click:Connect(function()
    Config.ESP = not Config.ESP
    bESP.Text = "ESP BRILHO: " .. (Config.ESP and "ON" or "OFF")
    bESP.BackgroundColor3 = Config.ESP and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(40, 40, 40)
end)
bStatus.MouseButton1Click:Connect(function()
    bStatus.Text = "STATUS: ATIVO 🔥"
    task.delay(1, function() bStatus.Text = "STATUS: SUPREMO" end)
end)
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
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local head = char:FindFirstChild("Head")
            local humanoid = char:FindFirstChild("Humanoid")
            if head and humanoid and humanoid.Health > 0 then
                local hl = char:FindFirstChild("V015_ESP") or Instance.new("Highlight", char)
                hl.Name = "V015_ESP"; hl.Enabled = Config.ESP
                hl.FillColor = Color3.fromRGB(0, 120, 255); hl.FillTransparency = 0.5
                hl.OutlineColor = Color3.fromRGB(255, 255, 255); hl.OutlineTransparency = 0.3
                local vHead = head:FindFirstChild("VisualHead")
                if Config.HitboxAtiva then
                    if not vHead then
                        vHead = Instance.new("Part", head); vHead.Name = "VisualHead"
                        vHead.Shape = Enum.PartType.Ball; vHead.CanCollide = false; vHead.Massless = true
                        vHead.Transparency = 0.8; vHead.Color = Color3.new(1, 0, 0); vHead.Material = Enum.Material.Neon
                        local weld = Instance.new("Weld", vHead); weld.Part0 = vHead; weld.Part1 = head
                    end
                    vHead.Size = Vector3.new(Config.HeadSize, Config.HeadSize, Config.HeadSize)
                else
                    if vHead then vHead:Destroy() end
                end
                local _, naTela = Camera:WorldToViewportPoint(head.Position)
                if naTela and EstaVisivel(head) then
                    local distancia = (head.Position - Camera.CFrame.Position).Magnitude
                    if distancia < menorDistancia then menorDistancia = distancia; alvoMaisProximo = head end
                end
            end
        end
    end
    local atirando = UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or UIS:IsMouseButtonPressed(Enum.UserInputType.Touch)
    if Config.ModoMira == "ELITE" and atirando and alvoMaisProximo then
        local delta = UIS:GetMouseDelta().Magnitude
        if delta < (Config.ForcaManual * 20) then
            local root = alvoMaisProximo.Parent.HumanoidRootPart
            local posAlvo = alvoMaisProximo.Position + Vector3.new(0, 0.25, 0) + (root.Velocity * Config.Predict)
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, posAlvo), 1 / Config.EliteSmooth)
        end
    end
end)
print("🔥 V015 PREMIUM ULTRA carregada!")
