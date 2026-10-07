local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local cfg = { wallJump = false, gravidade = false, velocidade = 50 }

local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "WallJumper"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 200, 0, 160)
main.Position = UDim2.new(0.5, -100, 0.5, -80)
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
main.BorderSizePixel = 0; main.Visible = true; main.Active = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", main).Color = Color3.fromRGB(0, 255, 200)
Instance.new("UIStroke", main).Thickness = 2

local title = Instance.new("TextLabel", main)
title.Text = "WALL JUMPER + GRAV"; title.Size = UDim2.new(1, -30, 0, 25); title.Position = UDim2.new(0, 5, 0, 2)
title.BackgroundTransparency = 1; title.TextColor3 = Color3.fromRGB(0, 255, 200); title.Font = Enum.Font.GothamBold
title.TextSize = 12; title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 24, 0, 24); closeBtn.Position = UDim2.new(1, -26, 0, 2)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50); closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255); closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.GothamBold; closeBtn.TextSize = 12
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

local bolinha = Instance.new("TextButton", gui)
bolinha.Size = UDim2.new(0, 44, 0, 44); bolinha.Position = UDim2.new(0, 10, 0.1, 0)
bolinha.BackgroundColor3 = Color3.fromRGB(0, 0, 0); bolinha.TextColor3 = Color3.fromRGB(0, 255, 200); bolinha.Text = "WG"
bolinha.Font = Enum.Font.GothamBold; bolinha.TextSize = 14; bolinha.Visible = false
Instance.new("UICorner", bolinha).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", bolinha).Color = Color3.fromRGB(0, 255, 200)
Instance.new("UIStroke", bolinha).Thickness = 2

local btn1 = Instance.new("TextButton", main)
btn1.Size = UDim2.new(1, -10, 0, 35); btn1.Position = UDim2.new(0, 5, 0, 35)
btn1.BackgroundColor3 = Color3.fromRGB(200, 0, 0); btn1.TextColor3 = Color3.new(1,1,1)
btn1.Text = "WALL JUMP: OFF"; btn1.Font = Enum.Font.GothamBold; btn1.TextSize = 12
Instance.new("UICorner", btn1).CornerRadius = UDim.new(0, 6)
btn1.MouseButton1Click:Connect(function()
    cfg.wallJump = not cfg.wallJump
    btn1.Text = "WALL JUMP: " .. (cfg.wallJump and "ON" or "OFF")
    btn1.BackgroundColor3 = cfg.wallJump and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(200, 0, 0)
end)

local btn2 = Instance.new("TextButton", main)
btn2.Size = UDim2.new(1, -10, 0, 35); btn2.Position = UDim2.new(0, 5, 0, 78)
btn2.BackgroundColor3 = Color3.fromRGB(200, 0, 0); btn2.TextColor3 = Color3.new(1,1,1)
btn2.Text = "GRAVIDADE: OFF"; btn2.Font = Enum.Font.GothamBold; btn2.TextSize = 12
Instance.new("UICorner", btn2).CornerRadius = UDim.new(0, 6)
btn2.MouseButton1Click:Connect(function()
    cfg.gravidade = not cfg.gravidade
    btn2.Text = "GRAVIDADE: " .. (cfg.gravidade and "ON" or "OFF")
    btn2.BackgroundColor3 = cfg.gravidade and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(200, 0, 0)
end)

local speedBtn = Instance.new("TextButton", main)
speedBtn.Size = UDim2.new(1, -10, 0, 30); speedBtn.Position = UDim2.new(0, 5, 0, 120)
speedBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50); speedBtn.TextColor3 = Color3.new(1,1,1)
speedBtn.Text = "VEL: " .. cfg.velocidade; speedBtn.Font = Enum.Font.GothamBold; speedBtn.TextSize = 11
Instance.new("UICorner", speedBtn).CornerRadius = UDim.new(0, 6)
speedBtn.MouseButton1Click:Connect(function()
    cfg.velocidade = cfg.velocidade >= 200 and 10 or cfg.velocidade + 10
    speedBtn.Text = "VEL: " .. cfg.velocidade
end)

local function verificarParede()
    local char = LP.Character
    if not char then return false end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    local direcoes = {root.CFrame.RightVector, -root.CFrame.RightVector, root.CFrame.LookVector, -root.CFrame.LookVector}
    for _, dir in pairs(direcoes) do
        local ray = Ray.new(root.Position, dir * 3)
        local hit = Workspace:FindPartOnRay(ray, char)
        if hit then return true end
    end
    return false
end

RunService.Heartbeat:Connect(function()
    local char = LP.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    if cfg.wallJump and verificarParede() then
        root.Velocity = Vector3.new(root.Velocity.X, 50, root.Velocity.Z)
    end
    if cfg.gravidade then
        local bv = root:FindFirstChild("GravUp") or Instance.new("BodyVelocity", root)
        bv.Name = "GravUp"; bv.MaxForce = Vector3.new(0, math.huge, 0)
        bv.Velocity = Vector3.new(0, cfg.velocidade, 0)
    else
        local bv = root:FindFirstChild("GravUp")
        if bv then bv:Destroy() end
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

print("✅ WALL JUMPER CARREGADO!")
