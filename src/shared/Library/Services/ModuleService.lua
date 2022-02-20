local class = {}
-- STARTS


-- VARIABLES
local _dictionary = {}


-- Creates new module.
-- @param _name Module name.
-- @return Created module.
function class.create(_name : string)
    -- Object nil checks.
    assert(_name ~= nil, "Module name cannot be null")

    _dictionary[_name] = {}
    return _dictionary[_name]
end

-- Gets module by its name.
-- @param _name Module name.
-- @return Module.
function class.get(_name : string)
    -- Object nil checks.
    assert(_name ~= nil, "Module name cannot be null")

    local result = _dictionary[_name]
    assert(result ~= nil, "Module named " .. _name .. " is not exist!")
    return result
end


-- ENDS
return class