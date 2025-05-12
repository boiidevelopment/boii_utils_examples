--[[
---------------------------
  ____   ____ _____ _____ 
 |  _ \ / __ \_   _|_   _|
 | |_) | |  | || |   | |  
 |  _ <| |  | || |   | |  
 | |_) | |__| || |_ _| |_ 
 |____/ \____/_____|_____|
                                                    
---------------------------                                              
      Utils Examples
          V1.0.0              
---------------------------
]]

fx_version "cerulean"
games { "gta5", "rdr3" }

name "boii_utils"
version "1.0.0"
description "Developer Utility Library - Examples."
author "boiidevelopment"
repository "https://github.com/boiidevelopment/boii_utils_examples"
lua54 "yes"

fx_version "cerulean"
game "gta5"

shared_scripts {
    "modules/*.lua",
    "module_examples.lua", 
    "function_examples.lua" 
}

dependency "boii_utils"