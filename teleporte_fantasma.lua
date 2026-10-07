local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local playerList = {}
local currentIndex = 1
local ICON_ID = "rbxassetid://0"

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "AdvancedPanel"
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 420, 0, 320)
Main.Position = UDim2.new(0.1, 0, 0.2, 0)
Main.BackgroundColor3 = Color3.fromRGB(25,25,25)
Main.Active = true
Main.Draggable = true
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1,0,0,40)
TopBar.BackgroundColor3 = Color3.fromRGB(20,20,20)
local Close = Instance.new("TextButton", TopBar)
Close.Size = UDim2.new(0,40,1,0)
Close.Position = UDim2.new(1,-40,0,0)
Close.Text = "X"
Close.BackgroundColor3 = Color3.fromRGB(150,50,50)
local PlayersTab = Instance.new("TextButton", TopBar)
PlayersTab.Size = UDim2.new(0.5,-20,1,0)
PlayersTab.Text = "Jogadores"
local SpectateTab = Instance.new("TextButton", TopBar)
SpectateTab.Size = UDim2.new(0.5,-20,1,0)
SpectateTab.Position = UDim2.new(0.5,0,0,0)
SpectateTab.Text = "Spectador"
local PlayersFrame = Instance.new("Frame", Main)
PlayersFrame.Size = UDim2.new(1,0,1,-40)
PlayersFrame.Position = UDim2.new(0,0,0,40)
local SpectateFrame = PlayersFrame:Clone()
SpectateFrame.Parent = Main
SpectateFrame.Visible = false
local Scroll = Instance.new("ScrollingFrame", PlayersFrame)
Scroll.Size = UDim2.new(1,0,1,0)
local Layout = Instance.new("UIListLayout", Scroll)
PlayersTab.MouseButton1Click:Connect(function() PlayersFrame.Visible = true; SpectateFrame.Visible = false end)
SpectateTab.MouseButton1Click:Connect(function() PlayersFrame.Visible = false; SpectateFrame.Visible = true end)
local function createPlayerButton(player)
    if player == LocalPlayer then return end
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,40)
    btn.Text = player.DisplayName .. " (@" .. player.Name .. ")"
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Parent = Scroll
    btn.MouseButton1Click:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character:MoveTo(player.Character.HumanoidRootPart.Position)
        end
    end)
end
local function refreshPlayers()
    playerList = {}
    for _, v in pairs(Scroll:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(playerList, p)
            createPlayerButton(p)
        end
    end
    task.wait()
    Scroll.CanvasSize = UDim2.new(0,0,0,Layout.AbsoluteContentSize.Y)
end
local NameLabel = Instance.new("TextLabel", SpectateFrame)
NameLabel.Size = UDim2.new(1,0,0,50)
local Prev = Instance.new("TextButton", SpectateFrame)
Prev.Size = UDim2.new(0.3,0,0,50); Prev.Position = UDim2.new(0,0,0.5,0); Prev.Text = "<"
local Next = Instance.new("TextButton", SpectateFrame)
Next.Size = UDim2.new(0.3,0,0,50); Next.Position = UDim2.new(0.7,0,0.5,0); Next.Text = ">"
local Back = Instance.new("TextButton", SpectateFrame)
Back.Size = UDim2.new(1,0,0,40); Back.Position = UDim2.new(0,0,1,-40); Back.Text = "Voltar"
local function updateSpectate()
    if #playerList == 0 then return end
    local target = playerList[currentIndex]
    NameLabel.Text = target.DisplayName .. " (@" .. target.Name .. ")"
    if target.Character and target.Character:FindFirstChild("Humanoid") then
        workspace.CurrentCamera.CameraSubject = target.Character.Humanoid
    end
end
Prev.MouseButton1Click:Connect(function() if currentIndex > 1 then currentIndex -= 1; updateSpectate() end end)
Next.MouseButton1Click:Connect(function() if currentIndex < #playerList then currentIndex += 1; updateSpectate() end end)
Back.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
    end
end)
local Bubble = Instance.new("ImageButton", ScreenGui)
Bubble.Size = UDim2.new(0,60,0,60); Bubble.Position = UDim2.new(0.02,0,0.7,0); Bubble.Image = ICON_ID; Bubble.Visible = false
Instance.new("UICorner", Bubble).CornerRadius = UDim.new(1,0)
Close.MouseButton1Click:Connect(function() Main.Visible = false; Bubble.Visible = true end)
Bubble.MouseButton1Click:Connect(function() Main.Visible = true; Bubble.Visible = false end)
Players.PlayerAdded:Connect(refreshPlayers)
Players.PlayerRemoving:Connect(refreshPlayers)
refreshPlayers()
print("Teleporte Fantasma carregado!")
