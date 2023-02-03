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
            "bob-logistic-robot-2", -- boblogistics
            "bob-logistic-robot-3",
            "bob-logistic-robot-4",
            "bob-logistic-robot-5" -- boblogistics
        },
        mul = settings.startup["x-custom-game-robot-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "energy_per_move" }, -- 移动1米的能量消耗量
                operation = "Division"
            }, {
                path = { "energy_per_tick" }, -- 每秒消耗的能量
                operation = "Division"
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
            "bob-construction-robot-2", -- boblogistics
            "bob-construction-robot-3",
            "bob-construction-robot-4",
            "bob-construction-robot-5" -- boblogistics
        },
        mul = settings.startup["x-custom-game-robot-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "energy_per_move" }, -- 移动1米的能量消耗量
                operation = "Division"
            }, {
                path = { "energy_per_tick" }, -- 每秒消耗的能量
                operation = "Division"
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
        mod = {
            "kr-small-roboport", -- Krastorio2
            "kr-small-roboport-logistic-mode",
            "kr-small-roboport-construction-mode",
            "kr-large-roboport",
            "kr-large-roboport-logistic-mode",
            "kr-large-roboport-construction-mode",
            "roboport-logistic-mode",
            "roboport-construction-mode", -- Krastorio2
            "bob-roboport-2", -- boblogistics
            "bob-roboport-3",
            "bob-roboport-4",
            "bob-robochest",
            "bob-robochest-2",
            "bob-robochest-3",
            "bob-robochest-4",
            "bob-logistic-zone-expander",
            "bob-logistic-zone-expander-2",
            "bob-logistic-zone-expander-3",
            "bob-logistic-zone-expander-4",
            "bob-robo-charge-port",
            "bob-robo-charge-port-2",
            "bob-robo-charge-port-3",
            "bob-robo-charge-port-4",
            "bob-robo-charge-port-large",
            "bob-robo-charge-port-large-2",
            "bob-robo-charge-port-large-3",
            "bob-robo-charge-port-large-4", -- boblogistics
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
                operation = "Division"
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
