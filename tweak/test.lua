local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.lib_logger("x-custom-game-test.lua")



log("\n\n\n------------------test start------------------n\n\n")

-- log(common_core:serialization_table(data.raw))

log("Modified Directory: ")
log(common_core:serialization_table(X_CUSTOM_GAME_TAB_RECORD))

-- log("Unmodified Directory(data.raw): ")
-- log(common_core:serialization_table(common_data_raw:check_not_in_record("data.raw")))

log("Unmodified Directory(record): ")
log(common_core:serialization_table(common_data_raw:check_not_in_record("record")))


log("\n\n\n------------------test end------------------n\n\n")
