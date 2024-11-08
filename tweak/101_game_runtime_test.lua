local common_core = require("common/core")
local common_data_raw = require("common/data_raw")
local x_database = require("tweak.99_database")

local log = common_core.Log

local x_runtime_test = {}
x_runtime_test.__index = x_runtime_test
setmetatable(x_runtime_test, x_runtime_test)

function x_runtime_test.on_init_test()
    if not X_CUSTOM_GAME_DEBUG then
        return
    end

    -- start
    log("\n\n\n------------------on_init_test start------------------\n\n\n")
    log("\n\n\n------------------on_init_test end------------------\n\n\n")
end

return x_runtime_test
