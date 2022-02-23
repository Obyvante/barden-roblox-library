local class = {}
-- IMPORTS
local Interface = require(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Interface"):WaitForChild("Interface"))
-- STARTS


-- VARIABLES
local _addons = {}


-- Saves addon.
-- @param _instance Instance(Module Script) to save.
function class.saveAddon(_instance : Instance)
    -- Object nil checks.
    assert(_instance ~= nil, "Instance to search in cannot be null")
    assert(_addons[_instance.Name] == nil, "More than one module script is using the name: " .. _instance.Name)
    assert(_instance:IsA("ModuleScript"), "Tried to save not module script addon(" .. _instance.Name .. ")")

    -- Saves instance(addon) to distionary.
    _addons[_instance.Name] = _instance
end

-- Saves addons inside of the instance.
-- @param _instance Instance to search in.
function class.saveAddons(_instance : Instance)
    -- Object nil checks.
    assert(_instance ~= nil, "Instance to search in cannot be null")

    for _, descendant in ipairs(_instance:GetDescendants()) do
        if not descendant:IsA("ModuleScript") then continue end
        -- Saves addon.
        class.saveAddon(descendant)
    end
end

-- Gets addon by its name.
-- @param _name Addon name.
-- @return Addon. [CLASS]
function class.getAddon(_name : string)
    -- Object nil checks.
    assert(_name ~= nil, "Addon name cannot be null")
	assert(_addons[_name], "Invalid addon name: " .. _name)
	return require(_addons[_name])
end


----------
-- INITIALIZATION
----------

class.saveAddons(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Interface"):WaitForChild("Addons"))


----------
-- API CALLS
----------

-- Creates an interface.
-- @param _id Interface id.
-- @param _viewport Interface viewport. (BASED ON)
-- @return Created interface.
function class.create(_id : string, _viewport : Vector2)
    return Interface.create(_id, _viewport)
end


-- ENDS
return class