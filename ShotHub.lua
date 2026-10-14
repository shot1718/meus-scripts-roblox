-- =============================================
-- 🔫 SHOT HUB — Auto Clicker
-- ⭐ Estrela: 1º clique = ABRIR | 2º clique = FECHAR
-- ✕ Botão X para fechar também
-- 📐 Botões de + e - para aumentar/diminuir o painel
-- 🖼️ Fundo transparente | Borda vermelha
-- ✅ 4 modos + Ligar/Desligar
-- =============================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Tween = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Configurações
local Config = {
    Modos = {
        ["Normal"] = 500,
        ["Super Fast"] = 200,
        ["Fast"] = 100,
        ["Super Flash"] = 30
    },
    ModoAtual = "Normal",
    Ativado = false,
    UltimoClique = 0,
    JanelaAberta = false,
    LarguraBase = 290,
    AlturaBase = 380,
    EscalaAtual = 1
}

-- Tela Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShotHub"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ⭐ ESTRELA FLUTUANTE (arrastável) — Abre e Fecha
local Estrela = Instance.new("ImageButton")
Estrela.Name = "BotaoEstrela"
Estrela.Size = UDim2.new(0, 50, 0, 50)
Estrela.Position = UDim2.new(0.05, 0, 0.5, 0)
Estrela.BackgroundTransparency = 1
Estrela.Image = "rbxassetid://10716887638"
Estrela.Active = true
Estrela.Draggable = true
Estrela.Parent = ScreenGui

-- 📦 PAINEL PRINCIPAL
local Painel = Instance.new("Frame")
Painel.Name = "PainelShotHub"
Painel.Size = UDim2.new(0, Config.LarguraBase, 0, Config.AlturaBase)
Painel.Position = UDim2.new(0.15, 0, 0.5, -Config.AlturaBase/2)
Painel.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Painel.BorderSizePixel = 3
Painel.BorderColor3 = Color3.fromRGB(200, 0, 0)
Painel.Visible = false
Painel.ClipsDescendants = true
Painel.Parent = ScreenGui

-- 🖼️ Fundo
local Fundo = Instance.new("UICorner")
Fundo.CornerRadius = UDim.new(0, 8)
Fundo.Parent = Painel

-- 🔴 Cabeçalho
local Cabecalho = Instance.new("Frame")
Cabecalho.Size = UDim2.new(1, 0, 0, 55)
Cabecalho.BackgroundColor3 = Color3.fromRGB(160, 0, 0)
Cabecalho.Parent = Painel

local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(1, -80, 0, 55)
Titulo.Position = UDim2.new(0, 0, 0, 0)
Titulo.BackgroundTransparency = 1
Titulo.Text = "🔫 SHOT HUB"
Titulo.TextColor3 = Color3.new(1, 1, 1)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 24
Titulo.Parent = Cabecalho

-- ✕ Botão Fechar
local BtnFechar = Instance.new("TextButton")
BtnFechar.Size = UDim2.new(0, 45, 0, 45)
BtnFechar.Position = UDim2.new(1, -50, 0, 5)
BtnFechar.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
BtnFechar.Text = "✕"
BtnFechar.TextColor3 = Color3.new(1, 1, 1)
BtnFechar.Font = Enum.Font.GothamBold
BtnFechar.TextSize = 22
BtnFechar.Parent = Cabecalho

local FecharCorner = Instance.new("UICorner")
FecharCorner.CornerRadius = UDim.new(0, 6)
FecharCorner.Parent = BtnFechar

-- 📐 Botões de Tamanho
local BtnMenos = Instance.new("TextButton")
BtnMenos.Size = UDim2.new(0, 35, 0, 35)
BtnMenos.Position = UDim2.new(0, 15, 0, 70)
BtnMenos.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BtnMenos.Text = "−"
BtnMenos.TextColor3 = Color3.new(1, 1, 1)
BtnMenos.Font = Enum.Font.GothamBold
BtnMenos.TextSize = 20
BtnMenos.Parent = Painel

local BtnMais = Instance.new("TextButton")
BtnMais.Size = UDim2.new(0, 35, 0, 35)
BtnMais.Position = UDim2.new(0, 55, 0, 70)
BtnMais.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BtnMais.Text = "+"
BtnMais.TextColor3 = Color3.new(1, 1, 1)
BtnMais.Font = Enum.Font.GothamBold
BtnMais.TextSize = 20
BtnMais.Parent = Painel

-- Função atualizar tamanho
local function AtualizarTamanho()
    local novaLargura = Config.LarguraBase * Config.EscalaAtual
    local novaAltura = Config.AlturaBase * Config.EscalaAtual
    Painel.Size = UDim2.new(0, novaLargura, 0, novaAltura)
end

-- Ações dos botões de tamanho
BtnMenos.MouseButton1Click:Connect(function()
    Config.EscalaAtual = math.max(0.6, Config.EscalaAtual - 0.1)
    AtualizarTamanho()
end)

BtnMais.MouseButton1Click:Connect(function()
    Config.EscalaAtual = math.min(1.5, Config.EscalaAtual + 0.1)
    AtualizarTamanho()
end)

-- 🎯 Função Abrir/Fechar Janela
local function AlternarJanela()
    Config.JanelaAberta = not Config.JanelaAberta
    Painel.Visible = Config.JanelaAberta
end

-- ⭐ Clique na Estrela = Alternar Janela
Estrela.MouseButton1Click:Connect(function()
    AlternarJanela()
end)

-- ✕ Clique no X = Fechar
BtnFechar.MouseButton1Click:Connect(function()
    Config.JanelaAberta = false
    Painel.Visible = false
end)

-- 🖱️ Auto Clicker Loop
local UltimoClick = 0
RunService.RenderStepped:Connect(function()
    if Config.Ativado then
        local intervalo = Config.Modos[Config.ModoAtual] / 1000
        local agora = os.clock()
        if agora - UltimoClick >= intervalo then
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, true, nil, 1)
            task.wait(0.01)
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, false, nil, 1)
            UltimoClick = agora
        end
    end
end)

-- 🔘 Criar botões dos Modos
local yPos = 110
for nome, _ in pairs(Config.Modos) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -30, 0, 40)
    btn.Position = UDim2.new(0, 15, 0, yPos)
    btn.BackgroundColor3 = nome == Config.ModoAtual and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(40, 40, 40)
    btn.Text = nome
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 16
    btn.Name = "Modo_"..nome
    btn.Parent = Painel
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        Config.ModoAtual = nome
        Config.Ativado = true
        for _, b in pairs(Painel:GetChildren()) do
            if b.Name:sub(1, 5) == "Modo_" then
                b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            end
        end
        btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    end)
    
    yPos += 50
end

-- ⭐ Botão Desligar
local BtnDesligar = Instance.new("TextButton")
BtnDesligar.Size = UDim2.new(1, -30, 0, 45)
BtnDesligar.Position = UDim2.new(0, 15, 0, yPos + 10)
BtnDesligar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
BtnDesligar.Text = "🔴 Desligar / Reset"
BtnDesligar.TextColor3 = Color3.new(1, 1, 1)
BtnDesligar.Font = Enum.Font.GothamBold
BtnDesligar.TextSize = 17
BtnDesligar.Parent = Painel

local DeslCorner = Instance.new("UICorner")
DeslCorner.CornerRadius = UDim.new(0, 6)
DeslCorner.Parent = BtnDesligar

BtnDesligar.MouseButton1Click:Connect(function()
    Config.Ativado = false
    Config.ModoAtual = "Normal"
    for _, b in pairs(Painel:GetChildren()) do
        if b.Name:sub(1, 5) == "Modo_" then
            b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end
    end
end)

print("✅ SHOT HUB carregado! ⭐ Clique na estrela para abrir/fechar")
