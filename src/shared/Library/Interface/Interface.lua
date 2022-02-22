local class = {}
class.__index = class
-- IMPORTS
local InterfaceElement = require(script.Parent:WaitForChild("InterfaceElement"))
-- STARTS

-------------
-- TODO: will add static dictionary.
-- with this, we can get by its id and garbage collector
-- will not touch it since it'll have a reference.
-------------

-- Creates an interface.
-- @param _id Interface id.
-- @return Created interface.
function class.create(_id : string)
    -- Object nil checks.
    assert(_id ~= nil, "Interface id cannot be null")

    local _screen = Instance.new("ScreenGui")
    _screen.Name = _id
    _screen.IgnoreGuiInset = true
    _screen.ResetOnSpawn = false

    -- Sets metatable then returns it.
    return setmetatable({
        ["id"] = _id,
        ["screen"] = _screen,
        ["elements"] = {}
    }, class)
end

-- Gets interface metadata.
-- @return Metadata.
function class:getMetadata()
    if not self.metadata then
        self.metadata = require(script.Parent.Parent:WaitForChild("Templates"):WaitForChild("Metadata")).new()
    end
    return self.metadata
end

-- Gets interface id.
-- @return Interface id.
function class:getId()
    return self.id
end

-- Gets interface screen.
-- @return Interface screen. (Screen Gui)
function class:getScreen()
    return self.screen
end

-- Gets interface element by its id.
-- @param _id Interface element id.
-- @return Interface element. (NULLABLE)
function class:getElement(_id : string)
    -- Object nil checks.
    assert(_id ~= nil, "Interface element id cannot be null")
    return self.elements[_id]
end

-- Adds an interface element to the screen.
-- @param _id Interface element id.
-- @param _properties Properties of interface element.
-- @return Created interface element.
function class:addElement(_data : string)
    -- Object nil checks.
    assert(_data ~= nil, "Interface element data cannot be null")

    local _id = _data.Name
    if self.elements[_id] ~= nil then error("Tried to create an interface(" .. self.id .. ") element with same id of " .. _id) end

    local element = InterfaceElement.new(self, _data)
    self.elements[_id] = element

    return element
end

-- Builds interface for declared instance.
-- @param instance Instance to build in.
function class:build(instance : Instance)
    -- Object nil checks.
    assert(instance ~= nil, "Interface(" .. self.id .. ") instance cannot be null")
    self.screen.Parent = instance
end


-- ENDS
return class