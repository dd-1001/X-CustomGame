local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.lib_logger("x-custom-game-robot.lua")

-- data.raw修改目录
local data_raw_robot_catalog = {
    ["logistic-robot"] = { -- 物流机器人
        orig = {
            "logistic-robot", -- 物流机器人
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-robot-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "energy_per_move" }, -- 移动1米的能量消耗量
                operation = "Div"
            }, {
                path = { "energy_per_tick" }, -- 每秒消耗的能量
                operation = "Div"
            }, {
                path = { "max_energy" } -- 机器人电池存储最大能量
            }, {
                path = { "max_payload_size" } -- 最大负载量
            }, {
                path = { "speed" } -- 速度
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    ["construction-robot"] = { -- 建设机器人
        orig = {
            "construction-robot", -- 建设机器人
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-robot-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "energy_per_move" }, -- 移动1米的能量消耗量
                operation = "Div"
            }, {
                path = { "energy_per_tick" }, -- 每秒消耗的能量
                operation = "Div"
            }, {
                path = { "max_energy" } -- 机器人电池存储最大能量
            }, {
                path = { "max_payload_size" } -- 最大负载量
            }, {
                path = { "speed" } -- 速度
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    roboport = { -- 机器人指令平台
        orig = {
            "roboport" -- 机器人指令平台
        },
        mul = settings.startup["x-custom-game-roboport-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "charging_energy" } -- 充电站的最大功率
            }, {
                path = { "construction_radius" }, -- 建设区域半径
                max_value = 250
            }, {
                path = { "logistics_radius" }, -- 物流区域半径
                max_value = 125
            }, {
                path = { "energy_source", "buffer_capacity" } -- 缓冲区容量
            }, {
                path = { "energy_source", "input_flow_limit" } -- 输入限制
            }, {
                path = { "energy_usage" }, -- 能源消耗量
                operation = "Div"
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------机器人系统 start------------------n\n\n")

common_data_raw:execute_modify(data_raw_robot_catalog)

log("\n\n\n------------------机器人系统 end------------------n\n\n")
