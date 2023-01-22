local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.lib_logger("x-custom-game-pipe.lua")

-- 管道系统
local data_raw_pipe_catalog = {
    pipe = { -- 管道
        orig = {
            "pipe" -- 管道
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-pipe-system-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "fluid_box", "base_area" }, -- 流体箱的总流体容量为 base_area × height × 100
                max_value = 10
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    ["pipe-to-ground"] = { -- 地下管道
        orig = {
            "pipe-to-ground" -- 地下管道
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-pipe-system-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "fluid_box", "base_area" }, -- 流体箱的总流体容量为 base_area × height × 100
                max_value = 10
            }, {
                path = { "fluid_box", "pipe_connections", 2, "max_underground_distance" }, -- 最大地下距离
                max_value = 81
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    pump = { -- 管道泵
        orig = {
            "pump" -- 管道泵
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-pipe-system-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "fluid_box", "height" }, -- 流体箱的总流体容量为 base_area × height × 100
                max_value = 10
            }, {
                path = { "pumping_speed" } -- 泵送速度
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    ["offshore-pump"] = { -- 供水泵
        orig = {
            "offshore-pump" -- 供水泵
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-pipe-system-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "fluid_box", "base_area" }, -- 流体箱的总流体容量为 base_area × height × 100
                max_value = 10
            }, {
                path = { "pumping_speed" } -- 泵送速度
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------管道系统 start------------------n\n\n")

common_data_raw:execute_modify(data_raw_pipe_catalog)

log("\n\n\n------------------管道系统 end------------------n\n\n")
