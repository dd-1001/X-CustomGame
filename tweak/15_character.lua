local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.lib_logger("x-custom-game-character.lua")

-- character
local data_raw_distance_catalog = {
    character = { -- 角色
        orig = {
            "character", -- 角色
        },
        mul = settings.startup["x-custom-game-fuel-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "fuel_value" } -- 热值
            }
        }
    }
}



-- 开始修改
log("\n\n\n------------------Character start------------------n\n\n")

common_data_raw:execute_modify(data_raw_distance_catalog)

log("\n\n\n------------------Character end------------------n\n\n")
