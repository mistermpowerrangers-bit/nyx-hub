local LP = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local function CriarMarteloAdm()
    local Tool = Instance.new("Tool")
    Tool.Name = "🔨 ADMIN HAMMER (MAP DELETE)"
    Tool.RequiresHandle = true
    Tool.Parent = LP.Backpack
    local Handle = Instance.new("Part")
    Handle.Name = "Handle"; Handle.Size = Vector3.new(0.5, 4, 0.5)
    Handle.BrickColor = BrickColor.new("Dark stone grey"); Handle.Parent = Tool
    local Head = Instance.new("Part")
    Head.Name = "Head"; Head.Size = Vector3.new(2.5, 1.5, 1.5)
    Head.BrickColor = BrickColor.new("Really black"); Head.Material = Enum.Material.Neon; Head.Parent = Tool
    local Weld = Instance.new("Weld")
    Weld.Part0 = Handle; Weld.Part1 = Head; Weld.C0 = CFrame.new(0, 2, 0); Weld.Parent = Head
    Tool.Activated:Connect(function()
        local hum = LP.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://204328711"
            hum:LoadAnimation(anim):Play()
        end
        local mousePos = UIS:GetMouseLocation()
        local ray = workspace.CurrentCamera:ViewportPointToRay(mousePos.X, mousePos.Y)
        local target = workspace:FindPartOnRay(Ray.new(ray.Origin, ray.Direction * 200))
        if target and target.Parent then
            local exp = Instance.new("Explosion")
            exp.Position = target.Position; exp.BlastRadius = 0; exp.Visible = true; exp.Parent = workspace
            local char = target.Parent:FindFirstChildOfClass("Humanoid") and target.Parent
            if char and char.Name ~= LP.Name then
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("BANIDO! 🔨", "All")
                char:BreakJoints(); char:Destroy()
            else
                print("Objeto do mapa deletado: " .. target.Name)
                target:Destroy()
            end
        end
    end)
end
CriarMarteloAdm()
LP.CharacterAdded:Connect(CriarMarteloAdm)
print("🔨 MARTELO DE ADM CARREGADO!")
