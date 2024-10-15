-- Roblox ImGui Style Menu Script

local library = {} -- Table for library functions and classes

-- Function to create the main window
function library:CreateWindow(title)
    local Window = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TitleBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    
    -- Properties
    Window.Name = "ExternalMenu"
    Window.Parent = game.CoreGui
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = Window
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Size = UDim2.new(0, 300, 0, 400)
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
    Title.Size = UDim2.new(0, 250, 0, 30)
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

-- Example of using the library
local window = library:CreateWindow("External Menu Example")
local mainFrame = window.MainFrame

-- Create the buttons for each tab (Aimbot is excluded since it's not needed for the RPG)
local visualsTab = library:CreateTab("Visuals", mainFrame)
visualsTab.Position = UDim2.new(0, 0, 0, 50)

local extrasTab = library:CreateTab("Extras", mainFrame)
extrasTab.Position = UDim2.new(0, 0, 0, 100)

-- Create toggles in Visuals Tab
local visualsToggle = library:CreateToggle("ESP", mainFrame, function(state)
    print("ESP Toggled: " .. tostring(state))
end)
visualsToggle.Position = UDim2.new(0, 0, 0, 150)

-- Create toggles in Extras Tab
local extrasToggle = library:CreateToggle("Auto Pickup", mainFrame, function(state)
    print("Auto Pickup Toggled: " .. tostring(state))
end)
extrasToggle.Position = UDim2.new(0, 0, 0, 200)

-- More tabs, sliders, buttons, and toggles can be added similarly
