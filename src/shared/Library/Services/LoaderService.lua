local class = {}
-- STARTS


-- Gets and waits child by dot notation.
--
-- WARNING: This function is using Roblox's 'WaitForChild' method
-- to handle calls. It'll freeze the main thread.
--
-- @param _instance Instance to search in.
-- @param _path Path.
-- @param shouldRequire (OPTIONAL) Should require child or not. Default is 'false'.
-- @return Target child.
function class.waitChild(_instance : Instance, _path : string, shouldRequire : boolean)
    -- Object nil checks.
    assert(_instance ~= nil, "Instance to search in cannot be nil")
    assert(_path ~= nil, "Path cannot be nil")

    -- If 'shouldRequire' is nil, converts it to 'false' as default.
    if shouldRequire == nil then shouldRequire = false end

	-- Splits path.
	local paths = string.gmatch(_path, "([^.]+)")

	-- Loops through path keys.
	for key in paths do
		-- Waits for next child. (YIELDS!)
		_instance = _instance:WaitForChild(key)
	end

	return shouldRequire and require(_instance) or _instance
end


-- ENDS
return class