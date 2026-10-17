--[[
    Shot Hub 2 - FPS Boost & Otimizador (Blox Fruits / Universal)
    Atualizado com Painel Nagatoro, Modos de Desempenho e Painel de Status.
]]--

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

-- Remover interface anterior se já existir
if CoreGui:FindFirstChild("ShotHub2") then
    CoreGui.ShotHub2:Destroy()
end
if CoreGui:FindFirstChild("ShotHub2_Status") then
    CoreGui.ShotHub2_Status:Destroy()
end

-- GUI Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShotHub2"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Painel Principal (Tema Vermelho com Cantos Arredondados)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BackgroundTransparency = 0.2
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -210)
MainFrame.Size = UDim2.new(0, 350, 0, 420)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(220, 40, 40)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- Fundo da Nagatoro (ImageLabel com transparência suave)
local NagatoroBg = Instance.new("ImageLabel")
NagatoroBg.Name = "NagatoroBg"
NagatoroBg.Parent = MainFrame
NagatoroBg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NagatoroBg.BackgroundTransparency = 1.0
NagatoroBg.Position = UDim2.new(0, 0, 0, 0)
NagatoroBg.Size = UDim2.new(1, 0, 1, 0)
NagatoroBg.Image = "rbxassetid://6915822135"
NagatoroBg.ImageTransparency = 0.35 -- Transparência suave (entre 0.3 e 0.5)
NagatoroBg.ScaleType = Enum.ScaleType.Slice
NagatoroBg.ZIndex = 1

local NagatoroCorner = Instance.new("UICorner")
NagatoroCorner.CornerRadius = UDim.new(0, 12)
NagatoroCorner.Parent = NagatoroBg

-- Container interno para os elementos
local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Parent = MainFrame
Container.BackgroundTransparency = 1
Container.Size = UDim2.new(1, 0, 1, 0)
Container.ZIndex = 2

-- Cabeçalho
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Parent = Container
Header.BackgroundColor3 = Color3.fromRGB(180, 20, 20)
Header.BackgroundTransparency = 0.2
Header.Size = UDim2.new(1, 0, 0, 45)
Header.ZIndex = 2

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = Header
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "SHOT HUB 2 — FPS BOOST"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 3

local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = Header
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
CloseBtn.Position = UDim2.new(1, -35, 0, 10)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.ZIndex = 3

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    if CoreGui:FindFirstChild("ShotHub2_Status") then
        CoreGui.ShotHub2_Status:Destroy()
    end
end)

-- Layout dos Botões
local ButtonHolder = Instance.new("ScrollingFrame")
ButtonHolder.Name = "ButtonHolder"
ButtonHolder.Parent = Container
ButtonHolder.Active = true
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Position = UDim2.new(0, 15, 0, 55)
ButtonHolder.Size = UDim2.new(1, -30, 1, -65)
ButtonHolder.CanvasSize = UDim2.new(0, 0, 0, 310)
ButtonHolder.ScrollBarThickness = 4
ButtonHolder.ZIndex = 2

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ButtonHolder
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 12)

-- Função para criar botões com melhor espaçamento e sombras/bordas
local function createButton(name, text, color, order)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = ButtonHolder
    btn.BackgroundColor3 = color
    btn.BackgroundTransparency = 0.25
    btn.Size = UDim2.new(1, -10, 0, 50)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.ZIndex = 3
    btn.LayoutOrder = order

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Transparency = 0.6
    stroke.Thickness = 1
    stroke.Parent = btn

    return btn
end

local BtnNormal = createButton("BtnNormal", "🔹 NORMAL FPS", Color3.fromRGB(40, 130, 60), 1)
local BtnMedium = createButton("BtnMedium", "🔸 MEDIUM FPS BOOST", Color3.fromRGB(180, 130, 20), 2)
local BtnSuper = createButton("BtnSuper", "⚡ SUPER FPS BOOST", Color3.fromRGB(200, 40, 40), 3)
local BtnReset = createButton("BtnReset", "🔄 DESATIVAR TUDO", Color3.fromRGB(70, 70, 70), 4)

-- Configurações originais para restauração
local originalLighting = {
    GlobalShadows = Lighting.GlobalShadows,
    Brightness = Lighting.Brightness,
    FogEnd = Lighting.FogEnd
}

-- 🔹 NORMAL FPS
BtnNormal.MouseButton1Click:Connect(function()
    pcall(function()
        Lighting.GlobalShadows = true
        Lighting.Brightness = 2
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            end
        end
    end)
end)

-- 🔸 MEDIUM FPS BOOST
BtnMedium.MouseButton1Click:Connect(function()
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.Brightness = 1
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Sparkles") then
                v.Enabled = false
            end
        end
    end)
end)

-- ⚡ SUPER FPS BOOST
BtnSuper.MouseButton1Click:Connect(function()
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.Brightness = 1.5
        Lighting.FogEnd = 999999
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
                v.CastShadow = false
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Sparkles") or v:IsA("Smoke") then
                v.Enabled = false
            end
        end
    end)
end)

-- 🔄 DESATIVAR TUDO
BtnReset.MouseButton1Click:Connect(function()
    pcall(function()
        Lighting.GlobalShadows = originalLighting.GlobalShadows
        Lighting.Brightness = originalLighting.Brightness
        Lighting.FogEnd = originalLighting.FogEnd
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CastShadow = true
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 0
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Sparkles") or v:IsA("Smoke") then
                v.Enabled = true
            end
        end
    end)
end)

-- 📊 PAINEL DE STATUS NO CANTO SUPERIOR (Pequeno e Discreto)
local StatusGui = Instance.new("ScreenGui")
StatusGui.Name = "ShotHub2_Status"
StatusGui.Parent = CoreGui
StatusGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local StatusFrame = Instance.new("Frame")
StatusFrame.Name = "StatusFrame"
StatusFrame.Parent = StatusGui
StatusFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
StatusFrame.BackgroundTransparency = 0.3
StatusFrame.Position = UDim2.new(1, -170, 0, 10)
StatusFrame.Size = UDim2.new(0, 160, 0, 32)

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 8)
StatusCorner.Parent = StatusFrame

local StatusStroke = Instance.new("UIStroke")
StatusStroke.Color = Color3.fromRGB(220, 40, 40)
StatusStroke.Transparency = 0.5
StatusStroke.Thickness = 1
StatusStroke.Parent = StatusFrame

local StatusText = Instance.new("TextLabel")
StatusText.Name = "StatusText"
StatusText.Parent = StatusFrame
StatusText.BackgroundTransparency = 1
StatusText.Size = UDim2.new(1, 0, 1, 0)
StatusText.Font = Enum.Font.GothamBold
StatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusText.TextSize = 12
StatusText.Text = "FPS: 60 | Tempo: 00:00"

-- Contador de FPS e Tempo de Jogo
local startTime = tick()
local frameCount = 0
local fps = 60
local lastUpdate = tick()

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local now = tick()
    if now - lastUpdate >= 1 then
        fps = math.floor(frameCount / (now - lastUpdate))
        frameCount = 0
        lastUpdate = now
    end

    local elapsed = math.floor(now - startTime)
    local mins = math.floor(elapsed / 60)
    local secs = elapsed % 60
    local timeStr = string.format("%02d:%02d", mins, secs)

    StatusText.Text = string.format("FPS: %d | Tempo: %s", fps, timeStr)
end)
