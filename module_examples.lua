--- @script module_examples
--- Example file for how to use modules through `boii_utils` safe get/require functions.

--- Accessing the "hello" module.
--- This file is a shared script so it will load all functions in the module depending on context it is called from.
local HELLO <const> = exports.boii_utils:require("boii_utils_examples:modules.hello")

--- @section Shared Context

--- Test command to use hello.greet() in a shared space
--- Works on both client and server.
RegisterCommand("test_hello_shared", function(source)
    local name = IsDuplicityVersion() and GetPlayerName(source) or GetPlayerName(PlayerId())
    print(HELLO.greet(name))
end)

--- @section Duplicity Mode Splitting

--- Spliting the file by duplicity version.
--- This is not recommended for any code you want to keep "secure".
--- Anything in a shared file can be dumped by the client.

if IsDuplicityVersion() then
    --- Will work on client side
    RegisterCommand("test_hello_server", function(source)
        local name = GetPlayerName(source)
        print(HELLO.greet_server(name))
    end)

else
    --- Will work on client side
    RegisterCommand("test_hello_client", function()
        local name = GetPlayerName(PlayerId())
        print(HELLO.greet_client(name))
    end)
end