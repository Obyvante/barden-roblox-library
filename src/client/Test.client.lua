local Library = require(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Library"))
-- SERVICES
local LoaderService = Library.getService("LoaderService")
local TableService = Library.getService("TableService")
local StringService = Library.getService("StringService")
local ModuleService = Library.getService("ModuleService")
local TaskService = Library.getService("TaskService")
local SignalService = Library.getService("SignalService")
-- TEMPLATES
local MetadataTemplate = Library.getTemplate("Metadata")

local Interface = require(game.ReplicatedStorage.Library.Interface.Interface)



Interface.create("Challanage_1"):addElement({
    Type = "Frame",
    Name = "frame",
    Properties = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(0.5, 0, 0.5, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.5
    }
}):addElement({
    Type = "TextLabel",
    Name = "text",
    Properties = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(0.5, 0, 0.2, 0),
        Position = UDim2.new(0.5, 0, 0.1, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Text = "Test Title!",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 50
    }
}):getParent():addElement({
    Type = "TextButton",
    Name = "button",
    Properties = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(0.5, 0, 0.3, 0),
        Position = UDim2.new(0.5, 0, 0.75, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.5,
        Text = "Click Me",
        TextSize = 50
    },
    Events = {
        {
            Name = "mouse_left_1",
            Type = "MouseButton1Down",
            Consumer = function(_data)
                print("Clicked!")

                _data.element:getMetadata():set("animation", TaskService.createRepeating(0.1, function(_task)
                    _data.element:updateProperties({
                        BackgroundColor3 = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)),
                    })
                end):run())
            end
        }
    }
}):bindEvent({
    Name = "mouse_right_1",
    Type = "MouseButton2Down",
    Consumer = function(_data)
        _data.element:unbindEvent("mouse_left_1")

        _data.element:getMetadata():get("animation"):cancel()
        _data.element:getMetadata():remove("animation")
    end
})
:getInterface():build(game.Players.LocalPlayer)