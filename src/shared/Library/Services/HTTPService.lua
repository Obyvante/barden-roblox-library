local class = {}
-- IMPORTS
local HttpService = game:GetService("HttpService")
-- STARTS


-- Sends 'GET' request to the target URL.
-- @param _url URL to send request.
-- @param _metadata Information to pass with request.
-- @return Response. (TABLE)
function class.GET(_url : string, _metadata : table)
    -- Object nil checks.
    assert(_url ~= nil, "URL cannot be null")

    -- Creates request table.
    local request = {
        Url = _url,
        Method = "GET",
        Headers = {
			["Content-Type"] = "application/json"
		}
    }

    -- Handles request metadata.
    if _metadata then
        for key, value in pairs(_metadata) do
            request.Headers[key] = value
        end
    end

    -- Sends and return request response.
    return HttpService:RequestAsync(request)
end

-- Sends 'POST' request to the target URL.
-- @param _url URL to send request.
-- @param _metadata Information to pass with request.
-- @param _body Body to send with request. (JSON STRING)
-- @return Response. (TABLE)
function class.POST(_url : string, _body : string, _metadata : table)
    -- Object nil checks.
    assert(_url ~= nil, "URL cannot be null")
    assert(_body ~= nil, "Body cannot be null")

    -- Creates request table.
    local request = {
        Url = _url,
        Method = "POST",
        Headers = {
			["Content-Type"] = "application/json"
		},
        Body = _body
    }

    -- Handles request metadata.
    if _metadata then
        for key, value in pairs(_metadata) do
            request.Headers[key] = value
        end
    end

    -- Sends and return request response.
    return HttpService:RequestAsync(request)
end


-- ENDS
return class