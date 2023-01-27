local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.lib_logger("x-custom-game-belt.lua")

-- 传送带
local data_raw_belt_transport_catalog = {
    ["transport-belt"] = { -- 传送带
        orig = {
            "transport-belt", -- 基础传送带
            "fast-transport-belt", -- 高速传送带
            "express-transport-belt" -- 极速传送带
        },
        mod = {
            "se-space-transport-belt", -- space-exploration
            "se-deep-space-transport-belt-black",
            "se-deep-space-transport-belt-white",
            "se-deep-space-transport-belt-red",
            "se-deep-space-transport-belt-magenta",
            "se-deep-space-transport-belt-blue",
            "se-deep-space-transport-belt-cyan",
            "se-deep-space-transport-belt-green",
            "se-deep-space-transport-belt-yellow" -- space-exploration
        },
        mul = settings.startup["x-custom-game-belt-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "speed" } -- 皮带的速度：speed × 480 = Items/second
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    ["underground-belt"] = { -- 地下传送带
        orig = {
            "underground-belt", -- 基础地下传送带
            "fast-underground-belt", -- 高速地下传送带
            "express-underground-belt" -- 极速地下传送带
        },
        mod = {
            "se-space-underground-belt", -- space-exploration
            "se-deep-space-underground-belt-black",
            "se-deep-space-underground-belt-white",
            "se-deep-space-underground-belt-red",
            "se-deep-space-underground-belt-magenta",
            "se-deep-space-underground-belt-blue",
            "se-deep-space-underground-belt-cyan",
            "se-deep-space-underground-belt-green",
            "se-deep-space-underground-belt-yellow" -- space-exploration
        },
        mul = settings.startup["x-custom-game-belt-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "speed" } -- 地下传送带的速度：speed × 480 = Items/second
            }, {
                path = { "max_distance" }, -- 地下传送带最大距离
                max_value = 81
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    splitter = { -- 分流器
        orig = {
            "splitter", -- 基础分流器
            "fast-splitter", -- 高速分流器
            "express-splitter" -- 极速分流器
        },
        mod = {
            "se-space-splitter", -- space-exploration
            "se-deep-space-splitter-black",
            "se-deep-space-splitter-white",
            "se-deep-space-splitter-red",
            "se-deep-space-splitter-magenta",
            "se-deep-space-splitter-blue",
            "se-deep-space-splitter-cyan",
            "se-deep-space-splitter-green",
            "se-deep-space-splitter-yellow" -- space-exploration
        },
        mul = settings.startup["x-custom-game-belt-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "speed" } -- 分流器的速度：speed × 480 = Items/second
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------传送带 start------------------n\n\n")

common_data_raw:execute_modify(data_raw_belt_transport_catalog)

log("\n\n\n------------------传送带 end------------------n\n\n")
