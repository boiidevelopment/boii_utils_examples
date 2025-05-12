--- @script function_examples
--- Some quick examples of how to use utils module functions.
--- All utils modules are coded in a shared context so they can be loaded either side.

--- @section Framework Bridge

--- Here we get/require the framework bridge module from boii_utils using the "core" name tag.
--- You can label CORE whatever you want -- I get asked this a lot..
local CORE <const> = exports.boii_utils:require("modules.core") 

--- To access the functions in the bridge you should do this in either context you require.
--- For this example we will use a shared space split by duplicity.

--- @section Shared Context

--- Test command to use CORE.get_identity() in a shared space
--- Works on both client and server.
RegisterCommand("test_fw_identity_shared", function(source)
    local identity = IsDuplicityVersion() and CORE.get_identity(source) or CORE.get_identity()
    print("Identity:", json.encode(identity))
end)

--- @section Duplicity Mode Splitting

--- Spliting the file by duplicity version.
--- This is not recommended for any code you want to keep "secure".
--- Anything in a shared file can be dumped by the client.

if IsDuplicityVersion() then
    --- Will work on server side
    RegisterCommand("test_fw_identity_server", function(source)
        local identity = CORE.get_identity(source)
        print("Identity:", json.encode(identity))
    end)
else
    --- Will work on client side
    RegisterCommand("test_fw_identity_client", function()
        local identity = CORE.get_identity()
        print("Identity:", json.encode(identity))
    end)
end