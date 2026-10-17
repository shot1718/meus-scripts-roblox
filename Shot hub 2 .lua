-- ==========================================
-- SCRIPT DE FPS BOOST & PAINEL - NAGATORO UI
-- Compatível com Blox Fruits e Exploits Luau
-- ==========================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Evita duplicação caso o script seja executado mais de uma vez
if CoreGui:FindFirstChild("NagatoroFPSPanel") then
    CoreGui.NagatoroFPSPanel:Destroy()
end

-- Criação da ScreenGui principal no CoreGui (ou PlayerGui se CoreGui falhar)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NagatoroFPSPanel"
screenGui.ResetOnSpawn = false
pcall(function()
    screenGui.Parent = CoreGui
end)
if not screenGui.Parent then
    screenGui.Parent = playerGui
end

-- ==========================================
-- 1. BOTÃO FLUTUANTE (ESTRELINHA ⭐)
-- ==========================================
local floatButton = Instance.new("TextButton")
floatButton.Name = "FloatButton"
floatButton.Size = UDim2.new(0, 50, 0, 50)
floatButton.Position = UDim2.new(0, 30, 0, 200)
floatButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
floatButton.BackgroundTransparency = 0.3
floatButton.Text = "⭐"
floatButton.TextSize = 28
floatButton.Parent = screenGui

local floatCorner = Instance.new("UICorner")
floatCorner.CornerRadius = UDim.new(1, 0) -- Deixa perfeitamente redonda
floatCorner.Parent = floatButton

local floatStroke = Instance.new("UIStroke")
floatStroke.Color = Color3.fromRGB(255, 50, 50)
floatStroke.Thickness = 2
floatStroke.Parent = floatButton

-- ==========================================
-- 2. PAINEL PRINCIPAL
-- ==========================================
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 320, 0, 400)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BackgroundTransparency = 0.4 -- Fundo translúcido
mainFrame.Visible = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(255, 0, 0) -- Bordas vermelhas
mainStroke.Thickness = 3
mainStroke.Parent = mainFrame

-- Fundo com a Imagem da Nagatoro
local bgImage = Instance.new("ImageLabel")
bgImage.Name = "NagatoroBg"
bgImage.Size = UDim2.new(1, 0, 1, 0)
bgImage.BackgroundTransparency = 1
bgImage.Image = "rbxassetid://6915822135"
bgImage.ImageTransparency = 0.65 -- Deixa a imagem visível mas suave para não atrapalhar o texto
bgImage.ScaleType = Enum.ScaleType.Crop
bgImage.ZIndex = 0
bgImage.Parent = mainFrame

local bgCorner = Instance.new("UICorner")
bgCorner.CornerRadius = UDim.new(0, 12)
bgCorner.Parent = bgImage

-- ==========================================
-- 3. TOPO / BARRA DE TÍTULO
-- ==========================================
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 45)
topBar.BackgroundTransparency = 1
topBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -50, 1, 0)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "⭐ Nagatoro FPS Boost ⭐"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0.5, -15)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 14
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeButton

-- ==========================================
-- 4. CONTAINER DE BOTÕES (FPS BOOST)
-- ==========================================
local contentContainer = Instance.new("ScrollingFrame")
contentContainer.Size = UDim2.new(1, -20, 1, -60)
contentContainer.Position = UDim2.new(0, 10, 0, 50)
contentContainer.BackgroundTransparency = 1
contentContainer.CanvasSize = UDim2.new(0, 0, 0, 320)
contentContainer.ScrollBarThickness = 4
contentContainer.Parent = mainFrame

local uiLayout = Instance.new("UIListLayout")
uiLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiLayout.Padding = UDim.new(0, 10)
uiLayout.Parent = contentContainer

-- Função auxiliar para criar os botões de boost
local function createButton(name, color, order)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1, 0, 0, 45)
    btn.BackgroundColor3 = color
    btn.BackgroundTransparency = 0.3
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.LayoutOrder = order
    btn.Parent = contentContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Transparency = 0.5
    stroke.Parent = btn

    return btn
end

local btnNormal = createButton("🔹 NORMAL FPS", Color3.fromRGB(50, 120, 200), 1)
local btnMedium = createButton("🔸 MEDIUM FPS BOOST", Color3.fromRGB(200, 140, 40), 2)
local btnUltra = createButton("🚀 ULTRA FPS BOOST", Color3.fromRGB(200, 40, 40), 3)
local btnReset  = createButton("🔄 DESATIVAR TUDO", Color3.fromRGB(80, 80, 80), 4)

-- Status visual nos botões
local function updateButtonStates(activeName)
    for _, child in ipairs(contentContainer:GetChildren()) do
        if child:IsA("TextButton") then
            local stroke = child:FindFirstChildOfClass("UIStroke")
            if stroke then
                if child.Name == activeName then
                    stroke.Color = Color3.fromRGB(0, 255, 0)
                    stroke.Thickness = 2.5
                else
                    stroke.Color = Color3.fromRGB(255, 255, 255)
                    stroke.Thickness = 1
                end
            end
        end
    end
end

-- ==========================================
-- 5. LÓGICA DE ARRASTAR (DRAG & DROP)
-- ==========================================
local function makeDraggable(guiObject, dragTarget)
    dragTarget = dragTarget or guiObject
    local dragging, dragInput, dragStart, startPos

    dragTarget.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            guiObject.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

makeDraggable(mainFrame, topBar)      -- Permite arrastar o painel pela barra superior
makeDraggable(floatButton)            -- Permite arrastar a estrelinha livremente

-- ==========================================
-- 6. ABERTURA E FECHAMENTO DO PAINEL
-- ==========================================
floatButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- ==========================================
-- 7. FUNÇÕES DE FPS BOOST
-- ==========================================

-- Restaurar Configurações Originais (Desativar Tudo)
btnReset.MouseButton1Click:Connect(function()
    Lighting.GlobalShadows = true
    Lighting.Brightness = 2
    if Lighting:FindFirstChild("Atmosphere") then Lighting.Atmosphere.Density = 0.3 end
    if Lighting:FindFirstChild("Blur") then Lighting.Blur.Enabled = true end
    
    workspace.CurrentCamera.FieldOfView = 70

    for _, desc in ipairs(Workspace:GetDescendants()) do
        if desc:IsA("BasePart") then
            desc.Material = Enum.Material.SmoothPlastic -- Reseta o material padrão seguro
            desc.Reflectance = 0
        elseif desc:IsA("ParticleEmitter") or desc:IsA("Trail") or desc:IsA("Fire") or desc:IsA("Smoke") then
            desc.Enabled = true
        end
    end
    
    updateButtonStates("🔄 DESATIVAR TUDO")
    print("[Nagatoro FPS]: Todas as otimizações foram desativadas!")
end)

-- NORMAL FPS
btnNormal.MouseButton1Click:Connect(function()
    Lighting.GlobalShadows = false
    
    for _, desc in ipairs(Workspace:GetDescendants()) do
        if desc:IsA("ParticleEmitter") then
            desc.Rate = math.clamp(desc.Rate / 2, 1, 10)
        end
    end
    
    updateButtonStates("🔹 NORMAL FPS")
    print("[Nagatoro FPS]: Modo Normal ativado!")
end)

-- MEDIUM FPS BOOST
btnMedium.MouseButton1Click:Connect(function()
    Lighting.GlobalShadows = false
    Lighting.Brightness = 1
    
    for _, desc in ipairs(Workspace:GetDescendants()) do
        if desc:IsA("BasePart") then
            if desc.Size.Magnitude > 50 then
                desc.Transparency = 0.5 -- Opcional para objetos distantes muito grandes
            end
            desc.Material = Enum.Material.SmoothPlastic
            desc.Reflectance = 0
        elseif desc:IsA("ParticleEmitter") or desc:IsA("Trail") then
            desc.Enabled = false
        end
    end
    
    updateButtonStates("🔸 MEDIUM FPS BOOST")
    print("[Nagatoro FPS]: Modo Médio ativado!")
end)

-- ULTRA FPS BOOST (Ideal para Blox Fruits em ilhas pesadas)
btnUltra.MouseButton1Click:Connect(function()
    Lighting.GlobalShadows = false
    Lighting.Brightness = 0.5
    if Lighting:FindFirstChild("Atmosphere") then Lighting.Atmosphere.Density = 0 end
    if Lighting:FindFirstChild("Blur") then Lighting.Blur.Enabled = false end
    
    for _, desc in ipairs(Workspace:GetDescendants()) do
        if desc:IsA("BasePart") then
            desc.Material = Enum.Material.SmoothPlastic
            desc.Reflectance = 0
            desc.CastShadow = false
        elseif desc:IsA("ParticleEmitter") or desc:IsA("Trail") or desc:IsA("Fire") or desc:IsA("Smoke") or desc:IsA("Sparkles") then
            desc.Destroying:Connect(function() end)
            pcall(function() desc:Destroy() end) -- Remove totalmente partículas de frutas e espadas pesadas
        elseif desc:IsA("Decal") or desc:IsA("Texture") then
            desc.Transparency = 1
        end
    end
    
    updateButtonStates("🚀 ULTRA FPS BOOST")
    print("[Nagatoro FPS]: Modo Ultra ativado! Desempenho máximo aplicado.")
end)
