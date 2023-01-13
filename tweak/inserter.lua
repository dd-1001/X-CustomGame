local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.lib_logger("x-custom-game-inserter.lua")

-- data.raw修改目录
local data_raw_inserter_catalog = {
    inserter = { -- 机械臂
        orig = {
            "burner-inserter", -- 热能机械臂
            "inserter", -- 电力机械臂
            "long-handed-inserter", -- 加长机械臂
            "stack-filter-inserter", -- 集装筛选机械臂
            "stack-inserter", -- 集装机械臂
            "fast-inserter", -- 高速机械臂
            "filter-inserter" -- 筛选机械臂
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-inserter-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "energy_source", "effectivity" } -- 能源利用效率
            }, {
                path = { "extension_speed" } -- 延伸速度
            }, {
                path = { "rotation_speed" } -- 旋转速度
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------机械臂系统 start------------------n\n\n")

common_data_raw:execute_modify(data_raw_inserter_catalog)

log("\n\n\n------------------机械臂系统 end------------------n\n\n")