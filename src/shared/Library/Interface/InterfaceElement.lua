local class = {}
class.__index = class
-- IMPORTS
local TableService = require(script.Parent.Parent:WaitForChild("Services"):WaitForChild("TableService"))
local Metadata = require(script.Parent.Parent:WaitForChild("Templates"):WaitForChild("Metadata"))
-- STARTS


-- Creates an interface element.
-- @param _interface Interface.
-- @param _id Interface element id.
-- @param _data Interface instance data.
-- @param _parent Interface element parent.
-- @return Created interface element.
function class.new(_interface : ModuleScript, _data : table, _parent : Folder)
    -- Object nil checks.
    assert(_interface ~= nil, "Interface cannot be null")
    assert(_data ~= nil, "Interface element data cannot be null")

    -- Creates an interface element table.
    local _element = setmetatable({}, class)
    _element["interface"] = _interface
    _element["parent"] = _parent
    _element["id"] = _data.Name
    _element["events"] = {}
    _element["elements"] = {}

    -- Creates an instance based on interface element type.
    local instance = Instance.new(_data.Type)
    instance.Parent = if not _parent then _interface:getScreen() else _parent:getInstance()
    instance.Name = _data.Name
    _element["instance"] = instance

    -- Adds properties to the created instance.
    if _data.Properties then
        _element:updateProperties(_data.Properties)
    end

    -- Adds events to the created instance.
    if _data.Events then
        for _, _event in ipairs(_data.Events) do
            _element:bindEvent(_event)
        end
    end

    -- Adds builds to the created instance.
    if _data.BuildWith then
        for _, _build in ipairs(_data.BuildWith) do
            if _build == "AspectRatio" then
                _element:addAspectRatio()
            else
                warn(_element:getLogPrefix() .. " build with(" .. _build .. ") is not exsist")
            end
        end
    end

    return _element
end

-- Gets interface element metadata.
-- @return Metadata.
function class:getMetadata()
    if not self.metadata then
        self.metadata = require(script.Parent.Parent:WaitForChild("Templates"):WaitForChild("Metadata")).new()
    end
    return self.metadata
end

-- Gets log prefix.
-- @return Log prefix. (STRING)
function class:getLogPrefix()
    return "Interface(" .. self.interface:getId() .. ") element(" .. self.id .. ")"
end

-- Gets interface.
-- @return Interface.
function class:getInterface()
    return self.interface
end

-- Gets parent of the interface element.
-- @return Interface element. (NULLABLE)
function class:getParent()
    return self.parent
end

-- Gets interface element id.
-- @return Interface element id.
function class:getId()
    return self.id
end

-- Gets interface element instance.
-- @return Instance.
function class:getInstance()
    return self.instance
end

-- Gets interface element properties.
-- @return Interface element properties.
function class:getProperties()
    return self.properties
end

-- Updates interface element instance.
-- @param _properties Interface element instance properties.
-- @return Interface element. (BUILDER)
function class:updateProperties(_properties : table)
    -- Object nil checks.
    assert(_properties ~= nil, self:getLogPrefix() .. " properties cannot be null[update properties]")
    self.properties = TableService.deepCopy(_properties)

    -- Saves properties to the instance.
    for key, value in pairs(_properties) do
        -- If it is custom property, no need to continue.
        if key == "Custom" then continue end

        self.instance[key] = value
    end

    -- Handls custom properties.
    if _properties.Custom then
        -- Declares required fields.
        local viewport = self.interface:getViewport()
        local anchor_point = _properties.AnchorPoint
        local should_calculate_anchor = anchor_point ~= nil and (anchor_point.X ~= 0 or anchor_point.Y ~= 0)
        local has_parent = self.parent ~= nil
        local parent_properties, parent_properties_custom
        if has_parent then
            parent_properties = self.parent:getProperties()
            parent_properties_custom = parent_properties.Custom
        end

        -- Handles custom size.
        if _properties.Custom.Size then
            local _data = _properties.Custom.Size
            local X, Y

            if has_parent then
                local parent_size = parent_properties_custom.Size

                X = _data.X / parent_size.X
                Y = _data.Y / parent_size.Y
            else
                X = _data.X / viewport.X
                Y = _data.Y / viewport.Y
            end

            self.instance.Size = UDim2.fromScale(X, Y)
        end
        

        -- Handles custom size.
        if _properties.Custom.Position then
            local _data = _properties.Custom.Position
            local X, Y
                
            if has_parent then
                local parent_size = parent_properties_custom.Size

                if should_calculate_anchor then
                    X = _data.X + (_properties.Custom.Size.X * anchor_point.X)
                    Y = _data.Y + (_properties.Custom.Size.Y * anchor_point.Y)

                    X = X / parent_size.X
                    Y = Y / parent_size.Y
                else
                    X = _data.X / parent_size.X
                    Y = _data.Y / parent_size.Y
                end
            else
                if should_calculate_anchor then
                    X = _data.X + (_properties.Custom.Size.X * anchor_point.X)
                    Y = _data.Y + (_properties.Custom.Size.Y * anchor_point.Y)

                    X = X / viewport.X
                    Y = Y / viewport.Y
                else
                    X = _data.X / viewport.X
                    Y = _data.Y / viewport.Y
                end
            end

            self.instance.Position = UDim2.fromScale(X, Y)
        end
    end

    return self
end

-- Gets event by its id.
-- @param _id Event id.
-- @return Interface element event.
function class:getEvent(_id : string)
    -- Object nil checks.
    assert(_id ~= nil, self:getLogPrefix() .. " event id cannot be null[get event]")
    return self.events[_id]
end

-- Creates an event and binds to the interface element.
-- @param _event Event data.
-- @return Interface element. (BUILDER)
function class:bindEvent(_event : table)
    -- Object nil checks.
    assert(_event ~= nil, self:getLogPrefix() .. " event data cannot be null")
    assert(self.events[_event.Name] == nil, self:getLogPrefix() .. " event(" .. _event.Name .. ") is already exsist[bind]")

    -- Connects an event to the interface element.
    self.events[_event.Name] = self.instance[_event.Type]:Connect(function(...)
        -- Creates event data to pass as argument.
        local data = {
            element = self
        }
        -- Runs declared consumer(function) with declared arguments.
        _event.Consumer(data, ...)
    end)
    return self
end

-- Unbinds target event.
-- @param _id Event id.
-- @return Interface element. (BUILDER)
function class:unbindEvent(_id : string)
    -- Object nil checks.
    assert(_id ~= nil, self:getLogPrefix() .. " event id cannot be null")
    assert(self.events[_id] ~= nil, self:getLogPrefix() .. " event(" .. _id .. ") is not exsist[unbind]")

    self:getEvent(_id):Disconnect()
    self.events[_id] = nil

    return self
end

-- Gets interface elements.
-- @return Interface elements.
function class:getElements()
    return self.elements
end

-- Gets interface element by its id.
-- @param _id Interface element id.
-- @return Interface element. (NULLABLE)
function class:getElement(_id : string)
    -- Object nil checks.
    assert(_id ~= nil, self:getLogPrefix() .. " id cannot be null")
    return self.elements[_id]
end

-- Adds an interface element to the screen.
-- @param _id Interface element id.
-- @param _properties Properties of interface element.
-- @return Created interface element.
function class:addElement(_data : string)
    -- Object nil checks.
    assert(_data ~= nil, self:getLogPrefix() .. " data cannot be null")

    local _id = _data.Name
    if self.elements[_id] ~= nil then error("Tried to create an interface(" .. self.interface:getId() .. ") element with same id of " .. _id) end

    local element = class.new(self.interface, _data, self)
    self.elements[_id] = element

    return element
end

-- Adds configured aspect ratio to interface element.
-- @return Interface element. (BUILDER)
function class:addAspectRatio()
    -- Gets abosule sizes as default.
    local X = self.instance.AbsoluteSize.X
    local Y = self.instance.AbsoluteSize.Y

    -- If there are custom sizes, declares it.
    if self.properties.Custom then
        X = self.properties.Custom.Size.X
        Y = self.properties.Custom.Size.Y
    end

    -- Adds an element to the list with calculated properties.
    self:addElement({
        Type = "UIAspectRatioConstraint",
        Name = "AspectRatio",
        Properties = {
            AspectRatio = X / Y,
            AspectType = "FitWithinMaxSize",
            DominantAxis = "Width"
        }
    })
    return self
end

-- Destroys interface element.
function class:destroy()
    if self.metadata then self.metadata:reset() end

    for _, value in pairs(self.events) do value:Disconnect() end
    self.instance:Destroy()

    -- Removes interface element from the parent elements list.
    self:getParent():getElements()[self.id] = nil
end


-- ENDS
return class