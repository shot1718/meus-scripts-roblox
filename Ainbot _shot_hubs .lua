-- Carrega a LinoriaLib (Interface Moderna)
local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main'
local Library = loadstring(game:HttpGet(repo .. '/Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. '/addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. '/addons/SaveManager.lua'))()

-- Serviços necessários
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--------------------------------------------------------------------------------
-- BOTÃO FLUTUANTE (ESTRELA) PARA ABRIR/FECHAR O PAINEL
--------------------------------------------------------------------------------
local ToggleGui = Instance.new("ScreenGui")
ToggleGui.Name = "LinoriaToggleStar"
ToggleGui.Parent = CoreGui
ToggleGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local StarButton = Instance.new("TextButton")
StarButton.Name = "StarButton"
StarButton.Parent = ToggleGui
StarButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
StarButton.BorderColor3 = Color3.fromRGB(255, 215, 0)
StarButton.BorderSizePixel = 2
StarButton.Position = UDim2.new(0, 50, 0, 50)
StarButton.Size = UDim2.new(0, 45, 0, 45)
StarButton.Font = Enum.Font.SourceSansBold
StarButton.Text = "★"
StarButton.TextColor3 = Color3.fromRGB(255, 215, 0)
StarButton.TextSize = 28
StarButton.Active = true
StarButton.Draggable = true -- Torna o botão móvel em qualquer lugar da tela

-- Ação para abrir/fechar a janela principal da LinoriaLib ao clicar na estrela
local windowVisible = true
StarButton.MouseButton1Click:Connect(function()
    windowVisible = not windowVisible
    Library:Toggle() -- Função nativa da Linoria para esconder/mostrar o menu
end)

--------------------------------------------------------------------------------
-- CONFIGURAÇÃO DA JANELA PRINCIPAL
--------------------------------------------------------------------------------
local Window = Library:CreateWindow({
    Title = 'Universal Aimbot | Painel Principal',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab('Aimbot'),
    Settings = Window:AddTab('Configurações')
}

--------------------------------------------------------------------------------
-- SEÇÃO DE CONFIGURAÇÕES DO AIMBOT
--------------------------------------------------------------------------------
local AimbotSection = Tabs.Main:AddLeftGroupbox('Controles')

-- Variáveis de Configuração
getgenv().AimbotSettings = {
    Enabled = false,
    CameraLock = false,
    TargetPart = "Head", -- "Head" ou "HumanoidRootPart"
    Smoothness = 5,      -- 1 = Instantâneo, maior = mais suave
    TeamCheck = true     -- Evita mirar em aliados (se o jogo usar Team)
}

AimbotSection:AddToggle('AimbotEnabled', {
    Text = 'Ativar Aimbot',
    Default = false,
    Callback = function(Value)
        getgenv().AimbotSettings.Enabled = Value
    end
})

AimbotSection:AddToggle('CameraLockToggle', {
    Text = 'Camera Lock (Travar Visão)',
    Default = false,
    Callback = function(Value)
        getgenv().AimbotSettings.CameraLock = Value
    end
})

AimbotSection:AddToggle('TargetHead', {
    Text = 'Focar apenas na Cabeça',
    Default = true,
    Callback = function(Value)
        getgenv().AimbotSettings.TargetPart = Value and "Head" or "HumanoidRootPart"
    end
})

AimbotSection:AddToggle('TeamCheckToggle', {
    Text = 'Verificação de Equipe (TeamCheck)',
    Default = true,
    Callback = function(Value)
        getgenv().AimbotSettings.TeamCheck = Value
    end
})

AimbotSection:AddSlider('SmoothnessSlider', {
    Text = 'Potência / Suavização',
    Default = 5,
    Min = 1,
    Max = 20,
    Rounding = 0,
    Callback = function(Value)
        getgenv().AimbotSettings.Smoothness = Value
    end
})

--------------------------------------------------------------------------------
-- LÓGICA DO AIMBOT (ALVO MAIS PRÓXIMO + TROCA AUTOMÁTICA)
--------------------------------------------------------------------------------
local function GetClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            if character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
                
                -- Checagem de Time (se aplicável ao jogo)
                local isTeamMate = false
                if getgenv().AimbotSettings.TeamCheck and player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then
                    isTeamMate = true
                end

                if not isTeamMate then
                    local targetPart = character:FindFirstChild(getgenv().AimbotSettings.TargetPart)
                    if targetPart then
                        -- Calcula a distância da tela/câmera até o player
                        local screenPoint, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                        local mousePos = UserInputService:GetMouseLocation()
                        local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - mousePos).Magnitude

                        if distance < shortestDistance then
                            shortestDistance = distance
                            closestPlayer = character
                        end
                    end
                end
            end
        end
    end

    return closestPlayer
end

-- Loop principal de mira
RunService.RenderStepped:Connect(function()
    if not getgenv().AimbotSettings.Enabled then return end

    local targetCharacter = GetClosestPlayer()

    if targetCharacter then
        local targetPart = targetCharacter:FindFirstChild(getgenv().AimbotSettings.TargetPart)
        local humanoid = targetCharacter:FindFirstChild("Humanoid")

        -- Confirma se o alvo está vivo
        if targetPart and humanoid and humanoid.Health > 0 then
            if getgenv().AimbotSettings.CameraLock then
                -- Trava a câmera diretamente na parte escolhida (Cabeça/Torso)
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
            else
                -- Aplica suavização (Smoothness) para mover a câmera gradualmente
                local currentCFrame = Camera.CFrame
                local targetCFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
                local smoothness = math.max(getgenv().AimbotSettings.Smoothness, 1)
                
                Camera.CFrame = currentCFrame:Lerp(targetCFrame, 1 / smoothness)
            end
        end
    end
end)

--------------------------------------------------------------------------------
-- CONFIGURAÇÕES FINAIS DA UI
--------------------------------------------------------------------------------
Library:SetWatermark('Universal Aimbot v1.0')
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)
