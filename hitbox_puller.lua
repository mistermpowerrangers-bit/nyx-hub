local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local puxarAtivo = false
local arrastando = false
local posicaoInicial
local gui = Instance.new("ScreenGui")
gui.Name = "HitboxPuller"
gui.Parent = game:GetService("CoreGui")
local botao = Instance.new("TextButton")
botao.Size = UDim2.new(0, 60, 0, 60)
botao.Position = UDim2.new(0, 100, 0, 100)
botao.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
botao.TextColor3 = Color3.fromRGB(255, 255, 255)
botao.Text = "PUXAR\nOFF"
botao.Font = Enum.Font.SourceSansBold
botao.TextSize = 14
botao.TextScaled = true
botao.Parent = gui
Instance.new("UICorner", botao).CornerRadius = UDim.new(1, 0)
local stroke = Instance.new("UIStroke", botao)
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Thickness = 2
botao.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        arrastando = true
        posicaoInicial = input.Position - botao.AbsolutePosition
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then arrastando = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if arrastando and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local novaPosicao = input.Position - posicaoInicial
        botao.Position = UDim2.new(0, novaPosicao.X, 0, novaPosicao.Y)
    end
end)
local function puxarHitboxes()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            if character then
                local hrp = character:FindFirstChild("HumanoidRootPart")
                local humanoid = character:FindFirstChild("Humanoid")
                if hrp and humanoid and humanoid.Health > 0 then
                    local meuChar = LocalPlayer.Character
                    if meuChar then
                        local minhaRoot = meuChar:FindFirstChild("HumanoidRootPart")
                        if minhaRoot then
                            pcall(function()
                                local direcao = (minhaRoot.CFrame.LookVector * 5)
                                local novaPosicao = minhaRoot.Position + direcao + Vector3.new(0, 3, 0)
                                hrp.CFrame = CFrame.new(novaPosicao)
                                hrp.Velocity = Vector3.new(0, 0, 0)
                                hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                            end)
                        end
                    end
                end
            end
        end
    end
end
RunService.Heartbeat:Connect(function()
    if puxarAtivo then puxarHitboxes() end
end)
botao.MouseButton1Click:Connect(function()
    puxarAtivo = not puxarAtivo
    if puxarAtivo then
        botao.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        botao.Text = "PUXAR\nON"
    else
        botao.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        botao.Text = "PUXAR\nOFF"
    end
end)
print("Hitbox Puller carregado!")
