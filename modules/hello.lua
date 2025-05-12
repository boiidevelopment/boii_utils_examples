--- @module hello
--- A quick example on "return based lua modules" and how to split them shared/client/server side.

-- Pattern B implementation
local hello = {}

--- @section Shared Functions

--- Returns the input name or world.
--- @param name string|nil
--- @return string "Hello, <name>!"
function hello.greet(name)
    return ("Hello, %s!"):format(name or "world")
end

if IsDuplicityVersion() then
    --- @section Server Functions

    function hello.greet_server(name)
        return ("Hello from the server, %s!"):format(name or "world")
    end

else
    --- @section Client Functions

    function hello.greet_client(name)
        return ("Hello from the client, %s!"):format(name or "world")
    end

end


return hello