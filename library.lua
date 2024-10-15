local library = {}

function library:CreateWindow(title)
    local window = {}
    window.title = title
    window.tabs = {}

    -- Function to create a new tab
    function window:CreateTab(name)
        local tab = {}
        tab.name = name
        tab.elements = {}

        -- Function to create a toggle switch
        function tab:CreateToggle(label, callback)
            local toggle = {}
            toggle.label = label
            toggle.state = false
            toggle.callback = callback
            table.insert(tab.elements, toggle)

            -- Simulating toggle action
            function toggle:Toggle()
                self.state = not self.state
                self.callback(self.state)
            end

            return toggle
        end

        -- Function to create a button
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

        -- Function to create a label
        function tab:CreateLabel(text)
            local label = {}
            label.text = text
            table.insert(tab.elements, label)
            return label
        end

        table.insert(window.tabs, tab)
        return tab
    end

    -- Add a close button
    function window:AddCloseButton(callback)
        local closeButton = {}
        closeButton.callback = callback
        window.closeButton = closeButton
    end

    -- Show/hide logic
    function window:Show()
        print("Showing window:", self.title)
    end

    function window:Hide()
        print("Hiding window:", self.title)
    end

    return window
end

return library
