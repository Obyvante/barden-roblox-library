local Library = require(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Library"))
-- SERVICES
local LoaderService = Library.getService("LoaderService")
local TableService = Library.getService("TableService")
local StringService = Library.getService("StringService")
local ModuleService = Library.getService("ModuleService")
local TaskService = Library.getService("TaskService")
local SignalService = Library.getService("SignalService")
local InterfaceService = Library.getService("InterfaceService")
-- TEMPLATES
local MetadataTemplate = Library.getTemplate("Metadata")


local interface = InterfaceService.create("Challanage-1")

local frame = interface:addElement({
    Type = "Frame",
    Name = "frame",
    Properties = {
        AnchorPoint = Vector2.new(0.5, 0.5),

        Size = UDim2.fromScale(0.75, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        BorderSizePixel = 0,

        BackgroundColor3 = Color3.fromRGB(255, 0, 0),
        BackgroundTransparency = 0.5
    },
    BuildWith = {
        "AspectRatio"
    }
})
:getInterface():build(game.Players.LocalPlayer.PlayerGui)