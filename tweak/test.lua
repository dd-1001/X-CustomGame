local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.Log

if not X_CUSTOM_GAME_IS_DEBUG then
    return
end


log("\n\n\n------------------test start------------------\n\n\n")

-- log(common_core:serpent_block(data.raw))

-- log("Moded List: \n" .. common_core:serpent_block(X_CUSTOM_GAME_TAB_RECORD))

-- local tab_record = common_data_raw:check_not_in_record("source")
local tab_record = common_data_raw:check_not_in_record("record")

log("Unmod List: \n" .. common_core:serpent_block(tab_record))




log("\n\n\n------------------test end------------------\n\n\n")
