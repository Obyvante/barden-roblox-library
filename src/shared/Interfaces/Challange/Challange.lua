local class = {}
-- IMPORTS
local Library = require(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Library"))
local ViewportService = Library.getService("ViewportService")
local InterfaceService = Library.getService("InterfaceService")
local FrameAddon = InterfaceService.getAddon("Frame")
-- STARTS


function createBody(_ui : ModuleScript)
    return _ui:addElement({
        Type = "Frame",
        Name = "body",
        Properties = {
            Custom = {
                Size = Vector2.new(2735, 1628),
                Position = Vector2.new(553, 266)
            },
            
            AnchorPoint = Vector2.new(0.5, 0.5),
            BorderSizePixel = 0,

            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 0.5
        },
        BuildWith = {
            "AspectRatio"
        }
    })
end

function createBorder(_ui : ModuleScript, _id : string, _position : Vector2)
    return _ui:addElement({
        Type = "Frame",
        Name = _id,
        Properties = {
            Custom = {
                Size = Vector2.new(2735, 338),
                Position = _position
            },
            
            AnchorPoint = Vector2.new(0.5, 0.5),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        }
    })
end

function createBox1(_ui : ModuleScript, _id : string, _position : Vector2)
    return _ui:addElement({
        Type = "Frame",
        Name = _id,
        Properties = {
            Custom = {
                Size = Vector2.new(278, 239),
                Position = _position
            },
            
            AnchorPoint = Vector2.new(0.5, 0.5),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        },
        Events = {
            {
                Name = "mouse1",
                Type = "InputBegan",
                Consumer = function(_data, _type)
                    if _type.UserInputType ~= Enum.UserInputType.MouseButton1 then return end

                    print("You clicked -> ", _id)
                    _data.element:destroy()
                end
            }
        }
    })
end

function createBox2(_ui : ModuleScript, _id : string, _position : Vector2)
    return _ui:addElement({
        Type = "Frame",
        Name = _id,
        Properties = {
            Custom = {
                Size = Vector2.new(611, 674),
                Position = _position
            },
            
            AnchorPoint = Vector2.new(0.5, 0.5),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        }
    })
end

function createBox3(_ui : ModuleScript, _id : string, _position : Vector2)
    return _ui:addElement({
        Type = "Frame",
        Name = _id,
        Properties = {
            Custom = {
                Size = Vector2.new(275, 294),
                Position = _position
            },
            
            AnchorPoint = Vector2.new(0.5, 0.5),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(0, 26, 255)
        }
    })
end

function createBox4(_ui : ModuleScript, _id : string, _position : Vector2)
    return _ui:addElement({
        Type = "Frame",
        Name = _id,
        Properties = {
            Custom = {
                Size = Vector2.new(611, 289),
                Position = _position
            },
            
            AnchorPoint = Vector2.new(0.5, 0.5),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        }
    })
end

-- Creates challange ui.
function class.create(_player : Player)
    -- Object nil checks.
    assert(_player ~= nil, "Player cannot be null")

    -- Creates an interface.
    local ui = InterfaceService.create("Challange", Vector2.new(3840, 2160))
    local body = createBody(ui)

    --HEADER
    local border_header = createBorder(body, "border1", Vector2.new(0, 0))
    createBox1(border_header, "box1", Vector2.new(50, 50))
    createBox1(border_header, "box2", Vector2.new(1229, 50))
    createBox1(border_header, "box3", Vector2.new(2408, 50))


    -- MIDDLE
    
    local middle_box1 = createBox2(body, "middle_box1", Vector2.new(328, 477))
    createBox3(middle_box1, "middle_box_inside", Vector2.new(171, 187))

    createBox4(body, "middle_box", Vector2.new(1062, 669))

    local middle_box2 = createBox2(body, "middle_box2", Vector2.new(1794, 477))
    createBox3(middle_box2, "middle_box_inside", Vector2.new(171, 187))


    -- FOOTER
    local border_footer = createBorder(body, "border2", Vector2.new(0, 1290))

    print(ui:getViewport())

    -- Builds interface for player.
    ui:build(_player.PlayerGui)
end


-- ENDS
return class