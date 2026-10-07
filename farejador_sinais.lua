local Config = { Gravando = false, UltimoRemote = nil, UltimosArgs = nil }
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 350, 0, 200); Main.Position = UDim2.new(0.5, -175, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(5, 5, 5); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main)
local Title = Instance.new("TextLabel", Main)
Title.Text = "V015: CAPTURADOR DE ITENS"; Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.fromRGB(255, 0, 0); Title.BackgroundTransparency = 1; Title.Font = "GothamBold"
local StatusLbl = Instance.new("TextLabel", Main)
StatusLbl.Text = "AGUARDANDO AÇÃO..."; StatusLbl.Size = UDim2.new(1, 0, 0, 30); StatusLbl.Position = UDim2.new(0, 0, 0, 40)
StatusLbl.TextColor3 = Color3.new(0.7, 0.7, 0.7); StatusLbl.BackgroundTransparency = 1
local RecBtn = Instance.new("TextButton", Main)
RecBtn.Size = UDim2.new(0, 150, 0, 40); RecBtn.Position = UDim2.new(0, 15, 0, 80)
RecBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0); RecBtn.Text = "LIGAR GRAVADOR"
RecBtn.TextColor3 = Color3.new(1,1,1); RecBtn.Font = "GothamBold"
Instance.new("UICorner", RecBtn)
local ReplayBtn = Instance.new("TextButton", Main)
ReplayBtn.Size = UDim2.new(0, 150, 0, 40); ReplayBtn.Position = UDim2.new(1, -165, 0, 80)
ReplayBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50); ReplayBtn.Text = "DUPLICAR AÇÃO"
ReplayBtn.TextColor3 = Color3.new(1,1,1); ReplayBtn.Font = "GothamBold"
Instance.new("UICorner", ReplayBtn)
local LoopBtn = Instance.new("TextButton", Main)
LoopBtn.Size = UDim2.new(1, -30, 0, 40); LoopBtn.Position = UDim2.new(0, 15, 0, 140)
LoopBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 0); LoopBtn.Text = "SPAMMAR ITEM (AUTO)"
LoopBtn.TextColor3 = Color3.new(1,1,1); LoopBtn.Font = "GothamBold"
Instance.new("UICorner", LoopBtn)
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if Config.Gravando and (method == "FireServer" or method == "InvokeServer") then
        if self.Name ~= "CharacterSoundEvent" and self.Name ~= "MainEvent" then
            Config.UltimoRemote = self
            Config.UltimosArgs = args
            StatusLbl.Text = "CÓDIGO CAPTURADO: " .. self.Name
            StatusLbl.TextColor3 = Color3.new(0, 1, 0)
            ReplayBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 150)
            ReplayBtn.Text = "EXECUTAR CÓDIGO"
            Config.Gravando = false
            RecBtn.Text = "LIGAR GRAVADOR"
            RecBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
        end
    end
    return oldNamecall(self, ...)
end)
RecBtn.MouseButton1Click:Connect(function()
    Config.Gravando = not Config.Gravando
    RecBtn.Text = Config.Gravando and "GRAVANDO..." or "LIGAR GRAVADOR"
    RecBtn.BackgroundColor3 = Config.Gravando and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(0, 100, 0)
    StatusLbl.Text = Config.Gravando and "COMPRE O ITEM AGORA!" or "AGUARDANDO..."
end)
ReplayBtn.MouseButton1Click:Connect(function()
    if Config.UltimoRemote and Config.UltimosArgs then
        Config.UltimoRemote:FireServer(unpack(Config.UltimosArgs))
        print("V015: Sinal reenviado para " .. Config.UltimoRemote.Name)
    end
end)
local Spamming = false
LoopBtn.MouseButton1Click:Connect(function()
    Spamming = not Spamming
    LoopBtn.Text = Spamming and "PARAR SPAM" or "SPAMMAR ITEM (AUTO)"
    while Spamming and Config.UltimoRemote do
        Config.UltimoRemote:FireServer(unpack(Config.UltimosArgs))
        task.wait(0.1)
    end
end)
print("V015 Farejador de Sinais carregado!")
