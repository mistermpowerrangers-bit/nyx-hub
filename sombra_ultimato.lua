local Config = { ModoMira = "ELITE", HitboxAtiva = true, ESP = true, Predict = 0.12, EliteSmooth = 1.05, ForcaManual = 2.5, HeadSize = 12 }
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Sombra_V015_Ultimato"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 380, 0, 280); Main.Position = UDim2.new(0.5, -190, 0.4, -140)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main)
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 50, 0, 50); OpenBtn.Position = UDim2.new(0, 20, 0.5, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0); OpenBtn.Text = "V015"; OpenBtn.TextColor3 = Color3.new(1,1,1)
OpenBtn.Visible = false; OpenBtn.Draggable = true; OpenBtn.Font = "GothamBold"
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
    b.Text = text; b.BackgroundColor3 = color; b.TextColor3 = Color3.new(1, 1, 1); b.Font = "GothamBold"
    Instance.new("UICorner", b); return b
end
local bElite = NewBtn("MIRA: ELITE", Color3.fromRGB(60, 0, 150))
local bHit = NewBtn("CABEÇA FANTASMA: ON", Color3.fromRGB(180, 0, 0))
local bEsp = NewBtn("ESP BRILHO: ON", Color3.fromRGB(0, 100, 200))
local bStatus = NewBtn("STATUS: SUPREMO", Color3.fromRGB(20, 20, 20))
bElite.MouseButton1Click:Connect(function()
    Config.ModoMira = (Config.ModoMira == "OFF") and "ELITE" or "OFF"
    bElite.Text = "MIRA: " .. Config.ModoMira
    bElite.BackgroundColor3 = (Config.ModoMira == "ELITE") and Color3.fromRGB(60, 0, 150) or Color3.fromRGB(150, 0, 0)
end)
bHit.MouseButton1Click:Connect(function()
    Config.HitboxAtiva = not Config.HitboxAtiva
    bHit.Text = Config.HitboxAtiva and "CABEÇA FANTASMA: ON" or "CABEÇA FANTASMA: OFF"
end)
local function EstaVisivel(alvo)
    local params = RaycastParams.new(); params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {LocalPlayer.Character, alvo.Parent}
    local cast = workspace:Raycast(Camera.CFrame.Position, (alvo.Position - Camera.CFrame.Position), params)
    return cast == nil
end
RunService.RenderStepped:Connect(function()
    local alvoProx = nil; local menorDist = math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and p.Character.Humanoid.Health > 0 then
            local head = p.Character.Head
            local hl = p.Character:FindFirstChild("SombraESP") or Instance.new("Highlight", p.Character)
            hl.Name = "SombraESP"; hl.Enabled = Config.ESP; hl.FillColor = Color3.fromRGB(0, 120, 255)
            local vHead = head:FindFirstChild("VisualHead")
            if Config.HitboxAtiva then
                if not vHead then
                    vHead = Instance.new("Part", head); vHead.Name = "VisualHead"; vHead.Shape = "Ball"
                    vHead.CanCollide = false; vHead.Transparency = 0.8; vHead.Color = Color3.new(1,0,0); vHead.Material = "Neon"
                    local w = Instance.new("Weld", vHead); w.Part0 = vHead; w.Part1 = head
                end
                vHead.Size = Vector3.new(Config.HeadSize, Config.HeadSize, Config.HeadSize)
            elseif vHead then vHead:Destroy() end
            local _, vis = Camera:WorldToViewportPoint(head.Position)
            if vis and EstaVisivel(head) then
                local d = (head.Position - Camera.CFrame.Position).Magnitude
                if d < menorDist then menorDist = d; alvoProx = head end
            end
        end
    end
    local clicando = UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or UIS:IsMouseButtonPressed(Enum.UserInputType.Touch)
    if Config.ModoMira == "ELITE" and clicando and alvoProx then
        local delta = UIS:GetMouseDelta().Magnitude
        if delta < (Config.ForcaManual * 20) then
            local root = alvoProx.Parent.HumanoidRootPart
            local pPos = alvoProx.Position + Vector3.new(0, 0.2, 0) + (root.Velocity * Config.Predict)
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, pPos), 1/Config.EliteSmooth)
        end
    end
end)
print("🌑 ELITE HUB ULTIMATO SUPREMA V015")
