local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local x_util = Core.x_util
local log = Core.Log

-- 指令表配置
local set_value_transport = settings.startup["x-custom-game-transport-performance-multiplier"].value
local set_value_locomotive = settings.startup["x-custom-game-locomotive-performance-multiplier"].value
local set_value_car = settings.startup["x-custom-game-car-performance-multiplier"].value
local set_value_spider_vehicle = settings.startup["x-custom-game-spider-vehicle-performance-multiplier"].value
local instructions_transport = {
    {
        type = "transport-belt", -- 传送带
        name = { "*" },
        exclude_names = {},
        operations = {
            speed = { type = "multiply", value = set_value_transport }
        }
    },
    {
        type = "underground-belt", -- 地下传送带
        name = { "*" },
        exclude_names = {},
        operations = {
            speed = { type = "multiply", value = set_value_transport },
            max_distance = { type = "multiply", value = set_value_transport, max_value = 81 }
        }
    },
    {
        type = "splitter", -- 分流器
        name = { "*" },
        exclude_names = {},
        operations = {
            speed = { type = "multiply", value = set_value_transport },
        }
    },
    {
        type = "loader", -- 装载机
        name = { "*" },
        exclude_names = {},
        operations = {
            speed = { type = "multiply", value = set_value_transport },
        }
    },
    {
        type = "loader-1x1", -- 装载机
        name = { "*" },
        exclude_names = {},
        operations = {
            speed = { type = "multiply", value = set_value_transport },
        }
    },
    {
        type = "locomotive", -- 内燃机车
        name = { "*" },
        exclude_names = {},
        operations = {
            ["energy_source.effectivity"] = { type = "multiply", value = set_value_locomotive },                                       -- 内燃机效率
            ["energy_source.fuel_inventory_size"] = { type = "multiply", value = set_value_locomotive, min_value = 1, max_value = 5 }, -- 燃料库存
            max_power = { type = "multiply", value = set_value_locomotive },                                                           -- 最大动力
            max_speed = { type = "multiply", value = set_value_locomotive },                                                           -- 最大速度
            braking_force = { type = "multiply", value = set_value_locomotive },                                                       -- 制动力
            reversing_power_modifier = { type = "multiply", value = set_value_locomotive },                                            -- 反向功率修正器（反向行驶）
        }
    },
    {
        type = "artillery-wagon", -- 重炮车厢
        name = { "*" },
        exclude_names = {},
        operations = {
            max_speed = { type = "multiply", value = set_value_locomotive },                                    -- 最大速度
            braking_force = { type = "multiply", value = set_value_locomotive },                                -- 制动力
            ammo_stack_limit = { type = "multiply", value = set_value_locomotive },                             -- 弹药堆叠限制
            inventory_size = { type = "multiply", value = set_value_locomotive, min_value = 1, max_value = 5 }, -- 库存大小
            manual_range_modifier = { type = "multiply", value = set_value_locomotive },                        -- 手动射程修正器
            turret_rotation_speed = { type = "multiply", value = set_value_locomotive, min_value = 0.001 },     -- 炮塔旋转速度
            turn_after_shooting_cooldown = { type = "division", value = set_value_locomotive },                 -- 射击后转向冷却时间
        }
    },
    {
        type = "car", -- 车、坦克
        name = { "*" },
        exclude_names = {},
        operations = {
            consumption = { type = "multiply", value = set_value_car },                                                         -- 能量消耗
            effectivity = { type = "multiply", value = set_value_car },                                                         -- 能量传递效率
            ["energy_source.effectivity"] = { type = "multiply", value = set_value_car },                                       -- 内燃机效率
            ["energy_source.fuel_inventory_size"] = { type = "multiply", value = set_value_car, min_value = 1, max_value = 5 }, -- 燃料库存
            inventory_size = { type = "multiply", value = set_value_car },                                                      -- 汽车库存大小
            -- rotation_speed = { type = "multiply", value = set_value_car },                                                      -- 旋转速度
            braking_power = { type = "multiply", value = set_value_car },                                                       -- 制动力
            turret_rotation_speed = { type = "multiply", value = set_value_car },                                               -- 炮塔旋转速度
            -- turret_return_timeout = { type = "division", value = set_value_car },                                               -- 炮塔回转超时
            trash_inventory_size = { type = "multiply", value = set_value_car },                                                -- 物流库存大小
            -- friction = { type = "multiply", value = set_value_car, min_value = 0.004, max_value = 0.01 },                       -- 摩擦力
        }
    },
    {
        type = "spider-vehicle", -- 蜘蛛机甲
        name = { "*" },
        exclude_names = {},
        operations = {
            chunk_exploration_radius = { type = "multiply", value = set_value_spider_vehicle, min_value = 3, max_value = 9 }, -- 探索半径
            inventory_size = { type = "multiply", value = set_value_spider_vehicle },                                         -- 库存
            movement_energy_consumption = { type = "division", value = set_value_spider_vehicle },                            -- 移动能量消耗
            trash_inventory_size = { type = "multiply", value = set_value_spider_vehicle },                                   -- 物流库存大小
            torso_rotation_speed = { type = "multiply", value = set_value_spider_vehicle },                                   -- 躯干旋转速度
            braking_force = { type = "multiply", value = set_value_spider_vehicle },                                          -- 制动力
            chain_shooting_cooldown_modifier = { type = "multiply", value = set_value_spider_vehicle },                       -- 连环射击冷却修改器
        }
    }
}



-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_transport)
log("instructions_transport modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not X_CUSTOM_GAME_MODIFIED_TYPE[prototype] then
            X_CUSTOM_GAME_MODIFIED_TYPE[prototype] = true
        end
    end
end
