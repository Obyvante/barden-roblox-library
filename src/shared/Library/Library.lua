local class = {}
-- IMPORTS
local RunService = game:GetService("RunService")
-- STARTS


-- VARIABLES
local _dictionary = {}
local _initialized = false


-- Loads services by its path.
-- @param _instance Instance to search in.
function loadService(_instance : Instance)
    -- Object nil checks.
    assert(_instance ~= nil, "Instance to search in cannot be null")

    -- Saves service into the 
    for _, descendant in ipairs(_instance:GetDescendants()) do
        if not descendant:IsA("ModuleScript") then continue end

        -- Checks if the module script is already registered or not.
        assert(_dictionary[descendant.Name] == nil, "More than one module script is using the name: " .. descendant.Name)

        -- Saves descendant to distionary.
        _dictionary[descendant.Name] = descendant
    end
end

-- If library is not initialized, initializes library.
if not _initialized then
    -- Loads services.
    if RunService:IsClient() then
        loadService(game:GetService("ReplicatedStorage"):WaitForChild("Library"):WaitForChild("Services"))
    elseif RunService:IsServer() then
        loadService(game.ReplicatedStorage.Library.Services)
        loadService(game.ServerScriptService.Library.Services)
    end

    -- Marks as initialized to prevent infinte loop.
    _initialized = true

    -- Informs console that library has been loaded.
    print("Barden Roblox Library(" .. (RunService:IsClient() and "client" or "server") .. ") has been initialized!")
end

-- Gets service.
-- @param _name Service name.
-- @return Service. [CLASS]
function class.getService(_name : string)
    -- Object nil checks.
    assert(_name ~= nil, "Service name cannot be null")
	assert(_dictionary[_name], "Invalid service name: " .. _name)
    
	return require(_dictionary[_name])
end


-- ENDS
return class