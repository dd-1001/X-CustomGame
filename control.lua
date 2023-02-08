local common_core = require("common/core")
local log = common_core.Log

local function on_init()
    log("\n\n\n------------------control start------------------\n\n\n")


    log(common_core:serialization_table(game.forces))


    log("\n\n\n------------------control end------------------\n\n\n")
end

script.on_init(on_init)