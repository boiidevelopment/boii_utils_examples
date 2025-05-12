# BOII Development – Utility Library Examples

A minimal set of scripts that show how to work with **boii_utils**:

* Creating *return‑based* Lua modules.
* Splitting code between **shared / client / server** contexts.
* Loading modules with `exports.boii_utils:require` / `:get`.
* Running quick slash commands to see everything in action.

---

## 1 - Resource Structure

```
boii_utils_examples/
├─ fxmanifest.lua           # declares dependency on boii_utils
├─ modules/
│   └─ hello.lua            # demo module (shared + context split)
├─ function_examples.lua    # shows utils function calls
├─ module_examples.lua      # shows module loader calls
└─ README.md                # this file
```

All files are shipped to both client and server via the `shared_scripts { … }` entry in *fxmanifest.lua*.

---

## 2 - Return‑based modules in a nutshell

### Pattern A – literal (good for tiny helpers)

```lua
return {
    greet = function(name)
        return ("Hello, %s!"):format(name or "world")
    end
}
```

### Pattern B – build, then return (used in *hello.lua*)

```lua
local hello = {}

function hello.greet(name)
    return ("Hello, %s!"):format(name or "world")
end

return hello
```
---

## 3 - Client / Server / Shared Context

FiveM scripts run in three contexts:

* **shared** code runs on both sides.
* **server‑only** sections are guarded with `if IsDuplicityVersion()`.
* **client‑only** sections live in the `else` branch.

See *modules/hello.lua* for a real example.

When creating modules you should consider this.
Homogenous functions that can handle either context are fine to go in a shared location. 
However client/server functions may have specifics that require the correct context.

Ways to split modules:

1. Separate files:
- core/modules/hello_shared.lua
- core/modules/hello_client.lua
- core/modules/hello_server.lua

Only the needed file is shipped to each side.
This way your server code is protected in cases of client dumps.

2. Single file:
```lua
function some_shared_function()
    print("This is a shared function")
end

if IsDuplicityVersion() then
    -- server‑only

    function some_server_function()
        print("This is a server function")
    end
else
    -- client‑only
    function some_client_function()
        print("This is a client function")
    end
end
```

Simpler during development, but the full file is sent to clients if someone dumps your server.
`boii_utils` uses option 2 throughout for convenience; pick the layout that fits your security and workflow.  

---

## 4 - Loading a module

Module loading for utils or internal modules works the same way however we split by `"resource_name:path.to.file"`.
If `resource_name:` is not provided the `get`/`require` function defaults to utils modules.

### Utils Modules
```lua
-- shared, server, or client
local CORE <const> = exports.boii_utils:require("modules.core")
```

### Internal Modules
```lua
-- shared, server, or client
local require = exports.boii_utils.require
local HELLO <const> = require("boii_utils_examples:modules.hello")
```

*Replace `boii_utils_examples` with any resource name to fetch from other resources.*

---

## 5 - Trying the examples in‑game / console

After starting the server with both **boii\_utils** and this resource
ensured, test commands are available:

| Command               | Runs on        | What it does                 |
| --------------------- | -------------- | ---------------------------- |
| `/test_hello_shared`  | both           | Calls `HELLO.greet`          |
| `/test_hello_server`  | server console | Calls `HELLO.greet_server`   |
| `/test_hello_client`  | client F8      | Calls `HELLO.greet_client`   |
| `/test_fw_identity_*` | see source     | Shows framework‑bridge usage |

*(Commands are defined in the two example Lua files in the root.)*

---

That’s all. Clone, tweak, and use these snippets as a starting point for your own scripts.
