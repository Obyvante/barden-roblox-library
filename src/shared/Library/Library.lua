local class = {}
-- IMPORTS
local RunService = game:GetService("RunService")
-- STARTS


-- VARIABLES
local _services = {}
local _templates = {}

-- Loads services by its path.
-- @param _instance Instance to search in.
function loadService(_instance : Instance)
    -- Object nil checks.
    assert(_instance ~= nil, "Instance to search in cannot be null")

    -- Saves service into the 
    for _, descendant in ipairs(_instance:GetDescendants()) do
        if not descendant:IsA("ModuleScript") then continue end

        -- Checks if the module script is already registered or not.
        assert(_services[descendant.Name] == nil, "More than one module script is using the name: " .. descendant.Name)

        -- Saves descendant to distionary.
        _services[descendant.Name] = descendant
    end
end

-- Loads services by its path.
-- @param _instance Instance to search in.
function loadTemplate(_instance : Instance)
    -- Object nil checks.
    assert(_instance ~= nil, "Instance to search in cannot be null")

    -- Saves service into the 
    for _, descendant in ipairs(_instance:GetDescendants()) do
        if not descendant:IsA("ModuleScript") then continue end

        -- Checks if the module script is already registered or not.
        assert(_templates[descendant.Name] == nil, "More than one module script is using the name: " .. descendant.Name)

        -- Saves descendant to distionary.
        _templates[descendant.Name] = descendant
    end
end

-- Gets service by its name.
-- @param _name Service name.
-- @return Service. [CLASS]
function class.getService(_name : string)
    -- Object nil checks.
    assert(_name ~= nil, "Service name cannot be null")
	assert(_services[_name], "Invalid service name: " .. _name)
	return require(_services[_name])
end

-- Gets template by its name.
-- @param _name Template name.
-- @return Template. [CLASS]
function class.getTemplate(_name : string)
    -- Object nil checks.
    assert(_name ~= nil, "Template name cannot be null")
	assert(_templates[_name], "Invalid template name: " .. _name)
	return require(_templates[_name])
end

----------
-- INITIALIZATION
----------

-- Handles client and server side libraries.
if RunService:IsClient() then
    loadService(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Services"))
    loadTemplate(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Templates"))
elseif RunService:IsServer() then
    loadService(game.ReplicatedStorage.Library.Services)
    loadService(game.ServerScriptService.Library.Services)
    loadTemplate(game.ReplicatedStorage.Library.Templates)
    loadTemplate(game.ServerScriptService.Library.Templates)
end

-- Informs console that library has been loaded.
print("Barden Roblox Library(" .. (RunService:IsClient() and "client" or "server") .. ") has been initialized!")


-- ENDS
return class