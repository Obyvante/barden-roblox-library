local class = {}
-- IMPORTS
local Interface = require(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Interface"):WaitForChild("Interface"))
-- STARTS


-- VARIABLES
local _extensions = {}


-- Saves extension.
-- @param _instance Instance(Module Script) to save.
function class.saveExtension(_instance : Instance)
    -- Object nil checks.
    assert(_instance ~= nil, "Instance to search in cannot be null")
    assert(_extensions[_instance.Name] == nil, "More than one module script is using the name: " .. _instance.Name)
    assert(_instance:IsA("ModuleScript"), "Tried to save not module script extension(" .. _instance.Name .. ")")

    -- Saves instance(extension) to distionary.
    _extensions[_instance.Name] = _instance
end

-- Saves extensions inside of the instance.
-- @param _instance Instance to search in.
function class.saveExtensions(_instance : Instance)
    -- Object nil checks.
    assert(_instance ~= nil, "Instance to search in cannot be null")

    for _, descendant in ipairs(_instance:GetDescendants()) do
        if not descendant:IsA("ModuleScript") then continue end
        -- Saves extension.
        class.saveExtension(descendant)
    end
end

-- Gets extension by its name.
-- @param _name Extension name.
-- @return Extension. [CLASS]
function class.getExtension(_name : string)
    -- Object nil checks.
    assert(_name ~= nil, "Extension name cannot be null")
	assert(_extensions[_name], "Invalid extension name: " .. _name)
	return require(_extensions[_name])
end


----------
-- INITIALIZATION
----------

class.saveExtensions(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Interface"):WaitForChild("Extensions"))


----------
-- API CALLS
----------

-- Creates an interface.
-- @param _id Interface id.
-- @return Created interface.
function class.create(_id : string)
    return Interface.create(_id)
end


-- ENDS
return class