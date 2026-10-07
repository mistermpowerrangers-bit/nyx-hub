local Elite_Config = { Speed = 16, Jump = 50, InfJump = false, Noclip = false, TPAtivo = false }
local LP = game.Players.LocalPlayer
local Mouse = LP:GetMouse()
local RS = game:GetService("RunService")
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 400, 0, 280); Main.Position = UDim2.new(0.5, -200, 0.5, -140)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local Title = Instance.new("TextLabel", Main); Title.Text = "CONFIGURAÇÕES ELITE V015"; Title.Size = UDim2.new(1, 0, 0, 40); Title.TextColor3 = Color3.new(1,1,1); Title.BackgroundTransparency = 1; Title.Font = "GothamBold"
local CloseX = Instance.new("TextButton", Main); CloseX.Text = "X"; CloseX.Size = UDim2.new(0, 30, 0, 30); CloseX.Position = UDim2.new(1, -35, 0, 5); CloseX.BackgroundColor3 = Color3.fromRGB(200, 0, 0); CloseX.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", CloseX)
local Bolinha = Instance.new("TextButton", ScreenGui); Bolinha.Size = UDim2.new(0, 50, 0, 50); Bolinha.Position = UDim2.new(0, 10, 0.5, 0); Bolinha.Text = "V015"; Bolinha.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Bolinha.TextColor3 = Color3.fromRGB(0, 150, 255); Bolinha.Visible = false; Bolinha.Draggable = true; Instance.new("UICorner", Bolinha).CornerRadius = UDim.new(1, 0)
local function CriarBotao(txt, cor, pos)
    local btn = Instance.new("TextButton", Main); btn.Size = UDim2.new(0, 180, 0, 45); btn.Position = pos; btn.BackgroundColor3 = cor; btn.Text = txt; btn.TextColor3 = Color3.new(1,1,1); btn.Font = "GothamBold"; btn.TextSize = 12; Instance.new("UICorner", btn)
    return btn
end
local JumpBtn = CriarBotao("JUMP: 50", Color3.fromRGB(80, 0, 150), UDim2.new(0.05, 0, 0.2, 0))
local InfJumpBtn = CriarBotao("PULO INFINITO: OFF", Color3.fromRGB(0, 50, 200), UDim2.new(0.05, 0, 0.4, 0))
local SpeedBtn = CriarBotao("SPEED: 16", Color3.fromRGB(40, 40, 40), UDim2.new(0.05, 0, 0.6, 0))
local NoclipBtn = CriarBotao("NOCLIP: OFF", Color3.fromRGB(0, 100, 100), UDim2.new(0.52, 0, 0.2, 0))
local TPToolBtn = CriarBotao("TP TOOL: OFF", Color3.fromRGB(0, 120, 0), UDim2.new(0.52, 0, 0.4, 0))
local DesligarBtn = CriarBotao("DESLIGAR TUDO", Color3.fromRGB(180, 0, 0), UDim2.new(0.52, 0, 0.6, 0))
local GlitchColors = {Color3.new(0,0,0), Color3.new(1,0,0), Color3.new(0,1,0), Color3.new(0,0,1), Color3.new(1,1,0), Color3.new(0,1,1), Color3.new(1,0,1)}
local function SpawnGlitchParticles(pos)
    task.spawn(function()
        for i = 1, 15 do
            local p = Instance.new("Part", workspace)
            p.Anchored = true; p.CanCollide = false; p.Material = Enum.Material.Neon
            p.Size = Vector3.new(math.random(5,20)/10, math.random(5,20)/10, math.random(5,20)/10)
            p.CFrame = CFrame.new(pos + Vector3.new(math.random(-3,3), math.random(0,4), math.random(-3,3)))
            p.Color = GlitchColors[math.random(1, #GlitchColors)]
            task.spawn(function()
                for j = 1, 8 do
                    p.Transparency = math.random(0,5)/10
                    p.CFrame = p.CFrame * CFrame.new(math.random(-1,1)/5, math.random(-1,1)/5, math.random(-1,1)/5)
                    p.Color = GlitchColors[math.random(1, #GlitchColors)]
                    task.wait(0.05)
                end
                p:Destroy()
            end)
        end
    end)
end
local function ToggleTP()
    local toolName = "V015_GLITCH_TP"
    local tool = LP.Backpack:FindFirstChild(toolName) or (LP.Character and LP.Character:FindFirstChild(toolName))
    if tool then
        tool:Destroy(); Elite_Config.TPAtivo = false
        TPToolBtn.Text = "TP TOOL: OFF"; TPToolBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
    else
        local newTool = Instance.new("Tool")
        newTool.Name = toolName; newTool.RequiresHandle = false; newTool.Parent = LP.Backpack
        newTool.Activated:Connect(function()
            local target = Mouse.Hit.p
            local charPos = LP.Character.HumanoidRootPart.Position
            SpawnGlitchParticles(charPos)
            LP.Character.HumanoidRootPart.CFrame = CFrame.new(target + Vector3.new(0,3,0))
            SpawnGlitchParticles(target)
        end)
        Elite_Config.TPAtivo = true
        TPToolBtn.Text = "TP TOOL: ON"; TPToolBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    end
end
JumpBtn.MouseButton1Click:Connect(function() Elite_Config.Jump = (Elite_Config.Jump >= 200) and 50 or Elite_Config.Jump + 25; JumpBtn.Text = "JUMP: " .. Elite_Config.Jump end)
SpeedBtn.MouseButton1Click:Connect(function() Elite_Config.Speed = (Elite_Config.Speed >= 200) and 16 or Elite_Config.Speed + 20; SpeedBtn.Text = "SPEED: " .. Elite_Config.Speed end)
NoclipBtn.MouseButton1Click:Connect(function() Elite_Config.Noclip = not Elite_Config.Noclip; NoclipBtn.Text = "NOCLIP: " .. (Elite_Config.Noclip and "ON" or "OFF") end)
InfJumpBtn.MouseButton1Click:Connect(function() Elite_Config.InfJump = not Elite_Config.InfJump; InfJumpBtn.Text = "PULO INFINITO: " .. (Elite_Config.InfJump and "ON" or "OFF") end)
TPToolBtn.MouseButton1Click:Connect(ToggleTP)
RS.Stepped:Connect(function()
    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid.WalkSpeed = Elite_Config.Speed; LP.Character.Humanoid.JumpPower = Elite_Config.Jump
        if Elite_Config.Noclip then for _, v in pairs(LP.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
    end
end)
game:GetService("UserInputService").JumpRequest:Connect(function() if Elite_Config.InfJump then LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end end)
CloseX.MouseButton1Click:Connect(function() Main.Visible = false; Bolinha.Visible = true end)
Bolinha.MouseButton1Click:Connect(function() Main.Visible = true; Bolinha.Visible = false end)
DesligarBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
print("Configurações Elite V015 carregadas!")
