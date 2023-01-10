local core = require("common/core")
local data_raw = require("common/data_raw")

local log = core.lib_logger("x-custom-game-test.lua")



----------------------------------------------------------------

local data_table = data_raw("boiler", "boiler")
data_table:show()
