local class = {}
-- STARTS


-- VARIABLES
local DEFAULTS = {
    PC = {
        X = 3840,
        Y = 2160
    },
    MOBILE = {
        X = 1366,
        Y = 1024
    }
}


-- Gets device sizes.
-- @return Device sizes.
function class.getSizes()
    return DEFAULTS
end

-- Gets pc sizes.
-- @return PC sizes.
function class.getPCSize()
    return DEFAULTS.PC
end

-- Gets mobile sizes.
-- @return Mobile sizes.
function class.getMobileSize()
    return DEFAULTS.MOBILE
end

-- Converts declared size to ratio by its type.
-- @param _device Device.
-- @param _size Size to convert.
-- @return Converted size. (RATIO)
function class.toRatio(_device : string, _size : table)
    -- Object nil checks.
    assert(_device ~= nil, "Device cannot be null")
    assert(_size ~= nil, "Size cannot be null")
    return {
        X = _size.X / DEFAULTS[_device].X,
        Y = _size.Y / DEFAULTS[_device].Y
    }
end

-- Converts declared X-axis size to ratio by its type.
-- @param _device Device.
-- @param _size X-axis size to convert.
-- @return Converted size. (RATIO)
function class.toRatioX(_device : string, _size : number)
    -- Object nil checks.
    assert(_device ~= nil, "Device cannot be null")
    assert(_size ~= nil, "Size cannot be null")
    return _size / DEFAULTS[_device].X
end

-- Converts declared Y-axis size to ratio by its type.
-- @param _device Device.
-- @param _size YX-axis size to convert.
-- @return Converted size. (RATIO)
function class.toRatioY(_device : string, _size : number)
    -- Object nil checks.
    assert(_device ~= nil, "Device cannot be null")
    assert(_size ~= nil, "Size cannot be null")
    return _size / DEFAULTS[_device].Y
end

function class.ScaleToOffset(Scale)
	local ViewPortSize = workspace.Camera.ViewportSize
	return ({ViewPortSize.X * Scale[1],ViewPortSize.Y * Scale[2]})
end

function class.OffsetToScale(Offset)
	local ViewPortSize = workspace.Camera.ViewportSize
	return ({Offset[1] / ViewPortSize.X, Offset[2] / ViewPortSize.Y})
end


-- ENDS
return class