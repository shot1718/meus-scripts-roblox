-- [[ NAGATORO_FPS_BOOST_(BY_SHOT) ]] --

local Players = game:GetService("Players")
local RunService =GetService("RunService") if not RunService then RunService = game:GetService("RunService") end
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Evita duplicatas se o script for executado mais de uma vez
if CoreGui:FindFirstChild("NagatoroFPSBoost") then
    CoreGui.NagatoroFPSBoost:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NagatoroFPSBoost"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ==========================================
-- 1. ESTRELA FLUTUANTE (Botão para abrir o painel)
-- ==========================================
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "FloatingStar"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
ToggleButton.Position = UDim2.new(0.05, 0, 0.15, 0)
ToggleButton.Size = UDim2.new(0, 55, 0, 55)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "★"
ToggleButton.TextColor3 = Color3.fromRGB(255, 215, 0)
ToggleButton.TextSize = 32

local CornerStar = Instance.new("UICorner")
CornerStar.CornerRadius = UDim.new(1, 0)
CornerStar.Parent = ToggleButton

local StrokeStar = Instance.new("UIStroke")
StrokeStar.Color = Color3.fromRGB(255, 105, 180) -- Rosa Nagatoro
StrokeStar.Thickness = 2
StrokeStar.Parent = ToggleButton

-- Torna a estrela arrastável na tela
local dragging, dragInput, dragStart, startPos
ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ToggleButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        ToggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ==========================================
-- 2. PAINEL PRINCIPAL (Bonito e Estilizado)
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
MainFrame.Size = UDim2.new(0, 350, 0, 240)
MainFrame.Visible = false
MainFrame.ClipsDescendants = true

local CornerMain = Instance.new("UICorner")
CornerMain.CornerRadius = UDim.new(0, 12)
CornerMain.Parent = MainFrame

local StrokeMain = Instance.new("UIStroke")
StrokeMain.Color = Color3.fromRGB(255, 105, 180)
StrokeMain.Thickness = 2
StrokeMain.Parent = MainFrame

-- TopBar (Título e Fechar)
local TopBar = Instance.new("Frame")
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
TopBar.Size = UDim2.new(1, 0, 0, 45)

local CornerTop = Instance.new("UICorner")
CornerTop.CornerRadius = UDim.new(0, 12)
CornerTop.Parent = TopBar

-- Imagem solicitada (rbxassetid://509926048)
local IconImage = Instance.new("ImageLabel")
IconImage.Parent = TopBar
IconImage.BackgroundTransparency = 1
IconImage.Position = UDim2.new(0, 10, 0.5, -14)
IconImage.Size = UDim2.new(0, 28, 0, 28)
IconImage.Image = "rbxassetid://509926048"

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 48, 0, 0)
Title.Size = UDim2.new(0, 240, 1, 0)
Title.Font = Enum.Font.FredokaOne -- Fonte estilizada e bonita
Title.Text = "NAGATORO FPS BOOST"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TopBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.Size = UDim2.new(0, 35, 1, 0)
CloseButton.Font = Enum.Font.FredokaOne
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 105, 180)
CloseButton.TextSize = 16

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- ==========================================
-- 3. CONTEÚDO DO PAINEL (Botão de Boost)
-- ==========================================
local Container = Instance.new("Frame")
Container.Parent = MainFrame
Container.BackgroundTransparency = 1
Container.Position = UDim2.new(0, 0, 0, 45)
Container.Size = UDim2.new(1, 0, 1, -45)

local DescLabel = Instance.new("TextLabel")
DescLabel.Parent = Container
DescLabel.BackgroundTransparency = 1
DescLabel.Position = UDim2.new(0, 20, 0, 15)
DescLabel.Size = UDim2.new(1, -40, 0, 40)
DescLabel.Font = Enum.Font.GothamMedium
DescLabel.Text = "Otimize o Blox Fruits para obter o máximo de FPS e remover o lag do Sea."
DescLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
DescLabel.TextSize = 13
DescLabel.TextWrapped = true
DescLabel.TextXAlignment = Enum.TextXAlignment.Center

-- Botão de Ativar FPS Boost
local BoostButton = Instance.new("TextButton")
BoostButton.Name = "BoostButton"
BoostButton.Parent = Container
BoostButton.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
BoostButton.Position = UDim2.new(0.5, -135, 0, 75)
BoostButton.Size = UDim2.new(0, 270, 0, 45)
BoostButton.Font = Enum.Font.FredokaOne
BoostButton.Text = "ATIVAR FPS BOOST"
BoostButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BoostButton.TextSize = 16

local CornerBtn = Instance.new("UICorner")
CornerBtn.CornerRadius = UDim.new(0, 8)
CornerBtn.Parent = BoostButton

local Credits = Instance.new("TextLabel")
Credits.Parent = Container
Credits.BackgroundTransparency = 1
Credits.Position = UDim2.new(0, 0, 1, -30)
Credits.Size = UDim2.new(1, 0, 0, 20)
Credits.Font = Enum.Font.Gotham
Credits.Text = "By Shot | Nagatoro Hub"
Credits.TextColor3 = Color3.fromRGB(120, 120, 140)
Credits.TextSize = 11

-- ==========================================
-- 4. LÓGICA DO FPS BOOST (Otimizações reais)
-- ==========================================
BoostButton.MouseButton1Click:Connect(function()
    BoostButton.Text = "OTIMIZANDO..."
    BoostButton.BackgroundColor3 = Color3.fromRGB(46, 139, 87) -- Verde sucesso

    -- Desativa texturas, sombras e efeitos pesados do jogo
    task.spawn(function()
        local lighting = game:GetService("Lighting")
        lighting.GlobalShadows = false
        lighting.FogEnd = 9e9
        
        for _, v in ipairs(lighting:GetChildren()) do
            if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then
                v:Destroy()
            end
        end

        -- Otimiza itens visuais do workspace (partículas, texturas e partes transparentes desnecessárias)
        for _, descendant in ipairs(workspace:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.Material = Enum.Material.SmoothPlastic
                descendant.Reflectance = 0
            elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") or descendant:IsA("Fire") or descendant:IsA("Smoke") then
                descendant.Enabled = false
            end
        end

        task.wait(1)
        BoostButton.Text = "FPS BOOST ATIVADO!"
    end)
end)
