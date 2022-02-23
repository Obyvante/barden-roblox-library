local class = {}
-- STARTS


-- Creates empty default table.
function class.empty(_name : string, _size : Vector2, _position : Vector2, _aspect_ratio : boolean)
    local frame = {
        Type = "Frame",
        Name = _name,
        Properties = {
            Custom = {
                Size = _size,
                Position = _position
            },
            
            AnchorPoint = Vector2.new(0.5, 0.5),
            BorderSizePixel = 0,

            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 1
        }
    }

    if _aspect_ratio then
        frame.BuildWith = {
            "AspectRatio"
        }
    end

    return frame
end


-- ENDS
return class