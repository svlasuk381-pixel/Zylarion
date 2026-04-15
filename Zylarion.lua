local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- ОСНОВНОЙ GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Zylarion_Menu_V2"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Глобальный акцентный цвет
local ThemeColor = Color3.fromRGB(0, 255, 150)
local ThemeObjects = {} -- Сюда будем сохранять объекты, цвет которых нужно менять

-- ГЛАВНОЕ ОКНО
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainFrame.Position = UDim2.new(0.5, -200, 1.2, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(35, 35, 35)
MainStroke.Thickness = 1

-- ШАПКА
local Header = Instance.new("Frame", MainFrame)
Header.Name = "Header"
Header.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
Header.Size = UDim2.new(1, 0, 0, 35)
Header.BorderSizePixel = 0

-- Добавляем закругление самой шапке
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 8)

-- Заглушка, чтобы нижние углы шапки оставались прямыми и сливались с фоном MainFrame
local HeaderBottom = Instance.new("Frame", Header)
HeaderBottom.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
HeaderBottom.Size = UDim2.new(1, 0, 0, 8)
HeaderBottom.Position = UDim2.new(0, 0, 1, -8)
HeaderBottom.BorderSizePixel = 0

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Zylarion Menu"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left

local HideBtn = Instance.new("TextButton", Header)
HideBtn.BackgroundTransparency = 1
HideBtn.Position = UDim2.new(1, -35, 0, 0)
HideBtn.Size = UDim2.new(0, 35, 1, 0)
HideBtn.Text = "—"
HideBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
HideBtn.TextSize = 16
HideBtn.Font = Enum.Font.GothamBold

-- КОНТЕЙНЕР ВКЛАДОК (Изначально скрыт)
local TabsContainer = Instance.new("Frame", MainFrame)
TabsContainer.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
TabsContainer.Position = UDim2.new(0, 0, 0, 35)
TabsContainer.Size = UDim2.new(1, 0, 0, 35)
TabsContainer.BorderSizePixel = 0
TabsContainer.Visible = false

local TabList = Instance.new("UIListLayout", TabsContainer)
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Padding = UDim.new(0, 8)
TabList.VerticalAlignment = Enum.VerticalAlignment.Center
Instance.new("UIPadding", TabsContainer).PaddingLeft = UDim.new(0, 10)

local Pages = {} 
local TabButtons = {}

local function CreateTab(name, isDefault)
    local Tab = Instance.new("TextButton", TabsContainer)
    Tab.Size = UDim2.new(0, 75, 0, 24)
    Tab.Font = Enum.Font.GothamMedium
    Tab.Text = name
    Tab.TextSize = 11
    Tab.AutoButtonColor = false
    Tab.BackgroundColor3 = isDefault and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(25, 25, 25)
    Tab.TextColor3 = isDefault and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(120, 120, 120)
    Instance.new("UICorner", Tab).CornerRadius = UDim.new(0, 6)
    
    local Page = Instance.new("ScrollingFrame", MainFrame)
    Page.Name = name .. "Page"
    Page.BackgroundTransparency = 1
    Page.Position = UDim2.new(0, 10, 0, 78)
    Page.Size = UDim2.new(1, -20, 1, -108)
    Page.Visible = false -- Изначально все страницы скрыты из-за пароля
    Page.ScrollBarThickness = 0
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    local PageList = Instance.new("UIListLayout", Page)
    PageList.Padding = UDim.new(0, 5)
    
    Pages[name] = Page
    table.insert(TabButtons, {Button = Tab, Name = name})
    
    Tab.MouseButton1Click:Connect(function()
        for _, data in pairs(TabButtons) do
            local isThis = (data.Name == name)
            TweenService:Create(data.Button, TweenInfo.new(0.3), {
                BackgroundColor3 = isThis and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(25, 25, 25),
                TextColor3 = isThis and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(120, 120, 120)
            }):Play()
            Pages[data.Name].Visible = isThis
        end
    end)
    return Page
end

local PlayerPage = CreateTab("Player", true)
local ESPPage = CreateTab("ESP", false)
local SettingsPage = CreateTab("Settings", false)

-- РАЗДЕЛИТЕЛИ (Без обводки)
local TopSep = Instance.new("Frame", MainFrame)
TopSep.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TopSep.Position = UDim2.new(0, 10, 0, 70)
TopSep.Size = UDim2.new(1, -20, 0, 1)
TopSep.BorderSizePixel = 0
TopSep.Visible = false

local BottomSep = Instance.new("Frame", MainFrame)
BottomSep.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
BottomSep.Position = UDim2.new(0, 10, 1, -25)
BottomSep.Size = UDim2.new(1, -20, 0, 1)
BottomSep.BorderSizePixel = 0
BottomSep.Visible = false

-- ЭКРАН ПАРОЛЯ (Логин)
local LoginFrame = Instance.new("Frame", MainFrame)
LoginFrame.Size = UDim2.new(1, 0, 1, -35)
LoginFrame.Position = UDim2.new(0, 0, 0, 35)
LoginFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
LoginFrame.BorderSizePixel = 0

local PassInput = Instance.new("TextBox", LoginFrame)
PassInput.Size = UDim2.new(0, 200, 0, 35)
PassInput.Position = UDim2.new(0.5, -100, 0.4, -17)
PassInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
PassInput.TextColor3 = Color3.fromRGB(255, 255, 255)
PassInput.Font = Enum.Font.Gotham
PassInput.TextSize = 14
PassInput.PlaceholderText = "Enter Password..."
PassInput.Text = ""
Instance.new("UICorner", PassInput).CornerRadius = UDim.new(0, 6)

local SubmitBtn = Instance.new("TextButton", LoginFrame)
SubmitBtn.Size = UDim2.new(0, 100, 0, 30)
SubmitBtn.Position = UDim2.new(0.5, -50, 0.6, 0)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 12
SubmitBtn.Text = "LOGIN"
Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 6)

SubmitBtn.MouseButton1Click:Connect(function()
    if PassInput.Text == "12345" then
        TweenService:Create(LoginFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        TweenService:Create(PassInput, TweenInfo.new(0.3), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
        TweenService:Create(SubmitBtn, TweenInfo.new(0.3), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
        task.wait(0.5)
        LoginFrame.Visible = false
        
        -- Показываем интерфейс
        TabsContainer.Visible = true
        TopSep.Visible = true
        BottomSep.Visible = true
        Pages["Player"].Visible = true -- Открываем первую вкладку по умолчанию
    else
        PassInput.Text = ""
        PassInput.PlaceholderText = "Wrong Password!"
        task.wait(1.5)
        PassInput.PlaceholderText = "Enter Password..."
    end
end)

-- ВРЕМЯ И ИНФО
local DevInfo = Instance.new("TextLabel", MainFrame)
DevInfo.Size = UDim2.new(0.6, 0, 0, 20)
DevInfo.Position = UDim2.new(0, 15, 1, -22)
DevInfo.BackgroundTransparency = 1
DevInfo.Text = "Dev: Merti | Tg: ZylarionCheat"
DevInfo.Font = Enum.Font.Gotham
DevInfo.TextSize = 10
DevInfo.TextColor3 = Color3.fromRGB(100, 100, 100)
DevInfo.TextXAlignment = Enum.TextXAlignment.Left

local TimeLabel = Instance.new("TextLabel", MainFrame)
TimeLabel.Size = UDim2.new(0.4, -15, 0, 20)
TimeLabel.Position = UDim2.new(0.6, 0, 1, -22)
TimeLabel.BackgroundTransparency = 1
TimeLabel.Text = "00:00:00"
TimeLabel.Font = Enum.Font.Gotham
TimeLabel.TextSize = 10
TimeLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
TimeLabel.TextXAlignment = Enum.TextXAlignment.Right

task.spawn(function()
    while ScreenGui.Parent do 
        TimeLabel.Text = os.date("%H:%M:%S") 
        task.wait(1) 
    end
end)

-- НОВЫЙ ДИЗАЙН ТУМБЛЕРОВ
local function CreateToggle(parentPage, name, callback)
    local ToggleBtn = Instance.new("TextButton", parentPage)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ToggleBtn.Size = UDim2.new(1, 0, 0, 35)
    ToggleBtn.Text = ""
    ToggleBtn.AutoButtonColor = false
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)
    
    local Label = Instance.new("TextLabel", ToggleBtn)
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(180, 180, 180)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Фон тумблера (овал)
    local SwitchBg = Instance.new("Frame", ToggleBtn)
    SwitchBg.Size = UDim2.new(0, 34, 0, 18)
    SwitchBg.Position = UDim2.new(1, -44, 0.5, -9)
    SwitchBg.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Instance.new("UICorner", SwitchBg).CornerRadius = UDim.new(1, 0)
    
    -- Сам ползунок (круг)
    local Knob = Instance.new("Frame", SwitchBg)
    Knob.Size = UDim2.new(0, 14, 0, 14)
    Knob.Position = UDim2.new(0, 2, 0.5, -7)
    Knob.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)
    
    local active = false
    
    local function UpdateVisuals()
        local bgTarget = active and ThemeColor or Color3.fromRGB(45, 45, 45)
        local knobPosTarget = active and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
        local labelColorTarget = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
        
        TweenService:Create(SwitchBg, TweenInfo.new(0.25), {BackgroundColor3 = bgTarget}):Play()
        TweenService:Create(Knob, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = knobPosTarget}):Play()
        TweenService:Create(Label, TweenInfo.new(0.25), {TextColor3 = labelColorTarget}):Play()
    end

    table.insert(ThemeObjects, {element = SwitchBg, isToggle = true, getActive = function() return active end})

    ToggleBtn.MouseButton1Click:Connect(function()
        active = not active
        UpdateVisuals()
        if callback then callback(active) end
    end)
end

-- ПРИМЕРЫ ТУМБЛЕРОВ
CreateToggle(PlayerPage, "Example Player Feature", function(state)
    print("Player feature state:", state)
end)

CreateToggle(ESPPage, "Example ESP Feature", function(state)
    print("ESP feature state:", state)
end)

-- НАСТРОЙКИ (Кнопка закрытия и Цвета)
local UnloadBtn = Instance.new("TextButton", SettingsPage)
UnloadBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
UnloadBtn.Size = UDim2.new(1, 0, 0, 32)
UnloadBtn.Text = "UNLOAD SCRIPT"
UnloadBtn.Font = Enum.Font.GothamBold
UnloadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
UnloadBtn.TextSize = 12
Instance.new("UICorner", UnloadBtn).CornerRadius = UDim.new(0, 6)

UnloadBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local ColorLabel = Instance.new("TextLabel", SettingsPage)
ColorLabel.Size = UDim2.new(1, 0, 0, 20)
ColorLabel.BackgroundTransparency = 1
ColorLabel.Text = "Select Theme Color:"
ColorLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
ColorLabel.Font = Enum.Font.Gotham
ColorLabel.TextSize = 12
ColorLabel.TextXAlignment = Enum.TextXAlignment.Left

local ColorContainer = Instance.new("Frame", SettingsPage)
ColorContainer.Size = UDim2.new(1, 0, 0, 30)
ColorContainer.BackgroundTransparency = 1

local ColorList = Instance.new("UIListLayout", ColorContainer)
ColorList.FillDirection = Enum.FillDirection.Horizontal
ColorList.Padding = UDim.new(0, 10)

local function CreateColorBtn(color)
    local btn = Instance.new("TextButton", ColorContainer)
    btn.Size = UDim2.new(0, 30, 0, 30)
    btn.BackgroundColor3 = color
    btn.Text = ""
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    
    btn.MouseButton1Click:Connect(function()
        ThemeColor = color
        -- Обновляем цвета включенных тумблеров
        for _, obj in ipairs(ThemeObjects) do
            if obj.isToggle and obj.getActive() then
                TweenService:Create(obj.element, TweenInfo.new(0.3), {BackgroundColor3 = ThemeColor}):Play()
            end
        end
    end)
end

CreateColorBtn(Color3.fromRGB(0, 255, 150)) -- Green
CreateColorBtn(Color3.fromRGB(0, 150, 255)) -- Blue
CreateColorBtn(Color3.fromRGB(255, 50, 100)) -- Red
CreateColorBtn(Color3.fromRGB(200, 0, 255)) -- Purple

-- КНОПКА ОТКРЫТИЯ МЕНЮ
local OpenIsland = Instance.new("TextButton", ScreenGui)
OpenIsland.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
OpenIsland.Position = UDim2.new(0.5, -30, 1, -35)
OpenIsland.Size = UDim2.new(0, 60, 0, 22)
OpenIsland.Text = "OPEN"
OpenIsland.Font = Enum.Font.GothamBold
OpenIsland.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenIsland.TextSize = 9
OpenIsland.AutoButtonColor = false
Instance.new("UICorner", OpenIsland).CornerRadius = UDim.new(0, 8)

local IslandStroke = Instance.new("UIStroke", OpenIsland)
IslandStroke.Color = Color3.fromRGB(60, 60, 60)
IslandStroke.Thickness = 1

-- ЛОГИКА ОТКРЫТИЯ / ЗАКРЫТИЯ МЕНЮ
local menuOpen = false
local mainTweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

HideBtn.MouseButton1Click:Connect(function()
    menuOpen = false
    TweenService:Create(MainFrame, mainTweenInfo, {Position = UDim2.new(0.5, -200, 1.2, 0)}):Play()
    TweenService:Create(OpenIsland, mainTweenInfo, {Position = UDim2.new(0.5, -30, 1, -35)}):Play()
end)

OpenIsland.MouseButton1Click:Connect(function()
    if not menuOpen then
        menuOpen = true
        TweenService:Create(OpenIsland, mainTweenInfo, {Position = UDim2.new(0.5, -30, 1, 50)}):Play()
        TweenService:Create(MainFrame, mainTweenInfo, {Position = UDim2.new(0.5, -200, 0.5, -125)}):Play()
    end
end)

