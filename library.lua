local library = {}

-- Main library class
function library:CreateWindow(title)
    local window = {}
    window.title = title
    window.tabs = {}

    -- Create a new tab inside the window
    function window:CreateTab(name)
        local tab = {}
        tab.name = name
        tab.elements = {}

        -- Create a dropdown
        function tab:CreateDropdown(label, options, callback)
            local dropdown = {}
            dropdown.label = label
            dropdown.options = options
            dropdown.selected = options[1]
            dropdown.callback = callback
            table.insert(tab.elements, dropdown)

            function dropdown:Select(option)
                self.selected = option
                self.callback(option)
            end

            return dropdown
        end

        -- Create a slider
        function tab:CreateSlider(label, min, max, callback)
            local slider = {}
            slider.label = label
            slider.min = min
            slider.max = max
            slider.value = min
            slider.callback = callback
            table.insert(tab.elements, slider)

            function slider:Set(value)
                self.value = math.clamp(value, self.min, self.max)
                self.callback(self.value)
            end

            return slider
        end

        -- Create a toggle switch
        function tab:CreateToggle(label, callback)
            local toggle = {}
            toggle.label = label
            toggle.state = false
            toggle.callback = callback
            table.insert(tab.elements, toggle)

            -- Simulate toggle action
            function toggle:Toggle()
                self.state = not self.state
                self.callback(self.state)
            end

            return toggle
        end

        -- Create a checkbox
        function tab:CreateCheckbox(label, callback)
            local checkbox = {}
            checkbox.label = label
            checkbox.checked = false
            checkbox.callback = callback
            table.insert(tab.elements, checkbox)

            function checkbox:Check()
                self.checked = not self.checked
                self.callback(self.checked)
            end

            return checkbox
        end

        -- Create a button
        function tab:CreateButton(label, callback)
            local button = {}
            button.label = label
            button.callback = callback
            table.insert(tab.elements, button)

            function button:Press()
                self.callback()
            end

            return button
        end

        -- Add the tab to the window
        table.insert(window.tabs, tab)
        return tab
    end

    -- Add a close button
    function window:AddCloseButton(callback)
        local closeButton = {}
        closeButton.callback = callback
        window.closeButton = closeButton
    end

    -- Show the window
    function window:Show()
        print("Showing window:", self.title)
    end

    -- Hide the window
    function window:Hide()
        print("Hiding window:", self.title)
    end

    return window
end

-- Class handling actions inside toggles, checkboxes, etc.
local switchactions = {}

-- Triggering actions
function switchactions:trigger(action)
    print("Triggered action:", action)
end

-- Set a particular action
function switchactions:Set(action, state)
    print("Setting action:", action, "State:", state)
end

-- Create toggle for cheats
function switchactions:CreateToggle(label, callback)
    local toggle = {}
    toggle.label = label
    toggle.state = false
    toggle.callback = callback

    function toggle:Toggle()
        self.state = not self.state
        self.callback(self.state)
    end

    return toggle
end

-- Trigger cheat (used with buttons or toggles)
function switchactions:triggercheat(cheatname, state)
    print("Cheat triggered:", cheatname, "State:", state)
end

return library
