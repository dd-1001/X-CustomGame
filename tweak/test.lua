local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.lib_logger("x-custom-game-test.lua")



log("\n\n\n------------------test start------------------\n\n\n")


log(common_core:serialization_table(data.raw["heat-pipe"]["heat-pipe"]))

log("\n\n\n------------------test end------------------\n\n\n")
