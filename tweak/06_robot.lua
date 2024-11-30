local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local x_util = Core.x_util
local log = Core.Log

-- 指令表配置
local set_value_robot = settings.startup["x-custom-game-robot-performance-multiplier"].value
local set_value_roboport = settings.startup["x-custom-game-roboport-performance-multiplier"].value
local instructions_robot = {
    {
        type = "logistic-robot", -- 物流机器人
        name = { "*" },
        exclude_names = {},
        operations = {
            speed = { type = "multiply", value = set_value_robot },                                                -- 飞行速度
            speed_multiplier_when_out_of_energy = { type = "multiply", value = set_value_robot, max_value = 0.6 }, -- 耗光能量的飞行速度
            energy_per_move = { type = "division", value = set_value_robot },                                      -- 移动1图格耗能
            energy_per_tick = { type = "division", value = set_value_robot },                                      -- 飞行1刻耗能
            max_energy = { type = "multiply", value = set_value_robot },                                           -- 电池最大容量
            max_payload_size = { type = "multiply", value = set_value_robot },                                     -- 机器人货物承载
        }
    },
    {
        type = "construction-robot", -- 建设机器人
        name = { "*" },
        exclude_names = {},
        operations = {
            speed = { type = "multiply", value = set_value_robot },                                                -- 飞行速度
            speed_multiplier_when_out_of_energy = { type = "multiply", value = set_value_robot, max_value = 0.6 }, -- 耗光能量的飞行速度
            energy_per_move = { type = "division", value = set_value_robot },                                      -- 移动1图格耗能
            energy_per_tick = { type = "division", value = set_value_robot },                                      -- 飞行1刻耗能
            max_energy = { type = "multiply", value = set_value_robot },                                           -- 电池最大容量
            max_payload_size = { type = "multiply", value = set_value_robot },                                     -- 机器人货物承载
        }
    },
    {
        type = "roboport", -- 机器人指令平台
        name = { "*" },
        exclude_names = {
            "repair-turret",       -- mod
            "aai-signal-sender",   -- mod
            "aai-signal-receiver", -- mod
        },
        operations = {
            charge_approach_distance = { type = "multiply", value = set_value_roboport },             -- 充电距离
            charging_energy = { type = "multiply", value = set_value_roboport },                      -- 充电最大功率
            ["energy_source.buffer_capacity"] = { type = "multiply", value = set_value_roboport },    -- 充电站缓存电量
            ["energy_source.input_flow_limit"] = { type = "multiply", value = set_value_roboport },   -- 充电站电量输入限制
            construction_radius = { type = "multiply", value = set_value_roboport, max_value = 256 }, -- 建设机器人施工半径
            logistics_radius = { type = "multiply", value = set_value_roboport, max_value = 128 },    -- 物流机器人物流半径
            material_slots_count = { type = "multiply", value = set_value_roboport, max_value = 30 }, -- 修理包槽位数量
            robot_slots_count = { type = "multiply", value = set_value_roboport, max_value = 30 },    -- 机器人槽位数量
            charging_station_count = { type = "insert", value = 16 },                                 -- 平台充电口数量
        }
    }
}



-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_robot)
log("instructions_robot modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not X_CUSTOM_GAME_MODIFIED_TYPE[prototype] then
            X_CUSTOM_GAME_MODIFIED_TYPE[prototype] = true
        end
    end
end
