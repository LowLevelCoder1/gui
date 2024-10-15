-- Roblox ImGui-Style Full Menu Script

local library = {} -- Table for library functions and classes

-- Function to create the main window
function library:CreateWindow(title)
    local Window = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TitleBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    
    -- Properties
    Window.Name = "FullMenu"
    Window.Parent = game.CoreGui
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = Window
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Size = UDim2.new(0, 400, 0, 500)
    MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
    MainFrame.BorderSizePixel = 0
    MainFrame.Draggable = true -- Makes the UI draggable
    MainFrame.Active = true
    
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.BorderSizePixel = 0
    
    Title.Name = "Title"
    Title.Parent = TitleBar
    Title.Text = title or "Menu"
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 18
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Size = UDim2.new(0, 350, 0, 30)
    Title.Position = UDim2.new(0, 10, 0, 0)
    
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TitleBar
    CloseButton.Text = "X"
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.TextSize = 18
    CloseButton.TextColor3 = Color3.fromRGB(255, 0, 0)
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    
    -- Close functionality
    CloseButton.MouseButton1Click:Connect(function()
        Window.Enabled = not Window.Enabled
    end)
    
    return {
        MainFrame = MainFrame,
        Window = Window
    }
end

-- Function to create tabs
function library:CreateTab(tabName, parent)
    local TabButton = Instance.new("TextButton")
    
    TabButton.Parent = parent
    TabButton.Text = tabName
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.TextSize = 18
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabButton.Size = UDim2.new(1, 0, 0, 40)
    TabButton.BorderSizePixel = 0
    TabButton.MouseButton1Click:Connect(function()
        print(tabName .. " Tab selected!")
    end)
    
    return TabButton
end

-- Function to create toggles
function library:CreateToggle(toggleName, parent, callback)
    local ToggleButton = Instance.new("TextButton")
    local isToggled = false
    
    ToggleButton.Parent = parent
    ToggleButton.Text = toggleName
    ToggleButton.Font = Enum.Font.SourceSansBold
    ToggleButton.TextSize = 18
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ToggleButton.Size = UDim2.new(1, 0, 0, 40)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        ToggleButton.BackgroundColor3 = isToggled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(50, 50, 50)
        callback(isToggled)
    end)
    
    return ToggleButton
end

-- Function to create sliders
function library:CreateSlider(sliderName, parent, min, max, callback)
    local SliderFrame = Instance.new("Frame")
    local SliderLabel = Instance.new("TextLabel")
    local Slider = Instance.new("TextButton")
    
    local value = min
    local dragging = false
    
    SliderFrame.Parent = parent
    SliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SliderFrame.Size = UDim2.new(1, 0, 0, 40)
    
    SliderLabel.Parent = SliderFrame
    SliderLabel.Text = sliderName .. ": " .. tostring(value)
    SliderLabel.Font = Enum.Font.SourceSansBold
    SliderLabel.TextSize = 18
    SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderLabel.Size = UDim2.new(0, 200, 0, 40)
    
    Slider.Parent = SliderFrame
    Slider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    Slider.Size = UDim2.new(0, 100, 0, 20)
    Slider.Position = UDim2.new(0.5, -50, 0.5, -10)
    
    Slider.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    Slider.MouseButton1Up:Connect(function()
        dragging = false
    end)
    
    parent.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = game.Players.LocalPlayer:GetMouse().X
            local sliderSize = SliderFrame.AbsoluteSize.X
            local posX = (mousePos - SliderFrame.AbsolutePosition.X) / sliderSize
            value = math.clamp(min + (max - min) * posX, min, max)
            Slider.Position = UDim2.new(posX, -50, 0.5, -10)
            SliderLabel.Text = sliderName .. ": " .. math.floor(value)
            callback(value)
        end
    end)
    
    return SliderFrame
end

-- Function to create buttons
function library:CreateButton(buttonName, parent, callback)
    local Button = Instance.new("TextButton")
    
    Button.Parent = parent
    Button.Text = buttonName
    Button.Font = Enum.Font.SourceSansBold
    Button.TextSize = 18
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.Size = UDim2.new(1, 0, 0, 40)
    Button.BorderSizePixel = 0
    Button.MouseButton1Click:Connect(function()
        callback()
    end)
    
    return Button
end

-- Function to create dropdowns
function library:CreateDropdown(dropdownName, parent, items, callback)
    local DropdownFrame = Instance.new("Frame")
    local DropdownButton = Instance.new("TextButton")
    local DropdownList = Instance.new("Frame")
    
    DropdownFrame.Parent = parent
    DropdownFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    DropdownFrame.Size = UDim2.new(1, 0, 0, 40)
    
    DropdownButton.Parent = DropdownFrame
    DropdownButton.Text = dropdownName
    DropdownButton.Font = Enum.Font.SourceSansBold
    DropdownButton.TextSize = 18
    DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    DropdownButton.Size = UDim2.new(1, 0, 0, 40)
    
    DropdownList.Parent = DropdownFrame
    DropdownList.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    DropdownList.Size = UDim2.new(1, 0, 0, #items * 30)
    DropdownList.Position = UDim2.new(0, 0, 1, 0)
    DropdownList.Visible = false
    
    for i, item in ipairs(items) do
        local ItemButton = Instance.new("TextButton")
        ItemButton.Parent = DropdownList
        ItemButton.Text = item
        ItemButton.Font = Enum.Font.SourceSansBold
        ItemButton.TextSize = 18
        ItemButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        ItemButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        ItemButton.Size = UDim2.new(1, 0, 0, 30)
        ItemButton.MouseButton1Click:Connect(function()
            callback(item)
            DropdownButton.Text = dropdownName .. ": " .. item
            DropdownList.Visible = false
        end)
    end
    
    DropdownButton.MouseButton1Click:Connect(function()
        DropdownList.Visible = not DropdownList.Visible
    end)
    
    return DropdownFrame
end

-- Example of using the expanded library
local window = library:CreateWindow("ShadowVis RPG Script Menu")
local mainFrame = window.MainFrame

-- Create Tabs
local visualsTab = library:CreateTab("Visuals", mainFrame)
visualsTab.Position = UDim2.new(0, 0, 0, 50)

local extrasTab = library:CreateTab("Extras", mainFrame)
extrasTab.Position = UDim2.new(0, 0, 0, 100)

-- Create toggles in Visuals Tab
local visualsToggle = library:CreateToggle("ESP", mainFrame, function(state)
    print("ESP Toggled: " .. tostring(state))
end)
visualsToggle.Position = UDim2.new(0, 0, 0, 150)

-- Create a slider in Extras Tab
local extrasSlider = library:CreateSlider("Walk Speed", mainFrame, 16, 100, function(value)
    print("Walk Speed Set To: " .. tostring(value))
end)
extrasSlider.Position = UDim2.new(0, 0, 0, 200)

-- Create a button in Extras Tab
local extrasButton = library:CreateButton("Reset Stats", mainFrame, function()
    print("Stats Reset!")
end)
extrasButton.Position = UDim2.new(0, 0, 0, 250)

-- Create a dropdown in Extras Tab
local dropdownItems = {"Item1", "Item2", "Item3"}
local extrasDropdown = library:CreateDropdown("Select Item", mainFrame, dropdownItems, function(selected)
    print("Selected: " .. selected)
end)
extrasDropdown.Position = UDim2.new(0, 0, 0, 300)

