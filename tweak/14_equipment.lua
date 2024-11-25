local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local x_util = Core.x_util
local log = Core.Log

-- 指令表配置
local set_value_equipment = settings.startup["x-custom-game-equipment-performance-multiplier"].value
local set_value_equipment_size_flag = settings.startup["x-custom-game-equipment-size-flag"].value
local instructions_equipment = {
    {
        type = "solar-panel-equipment", -- 太阳能模块
        name = { "*" },
        exclude_names = {},
        operations = {
            power = { type = "multiply", value = set_value_equipment }, -- 发电
        }
    },
    {
        type = "generator-equipment", -- 发电机设备
        name = { "*" },
        exclude_names = {},
        operations = {
            power = { type = "multiply", value = set_value_equipment }, -- 发电
        }
    },
    {
        type = "battery-equipment", -- 电池组模块
        name = { "*" },
        exclude_names = {},
        operations = {
            ["energy_source.buffer_capacity"] = { type = "multiply", value = set_value_equipment }, -- 容量
        }
    },
    {
        type = "belt-immunity-equipment", -- 锚定模块
        name = { "*" },
        exclude_names = {},
        operations = {
            -- energy_consumption = { type = "division", value = set_value_equipment }, -- 消耗
            ["energy_source.buffer_capacity"] = { type = "multiply", value = set_value_equipment },  -- 电池容量
            ["energy_source.input_flow_limit"] = { type = "multiply", value = set_value_equipment }, -- 输入限制
        }
    },
    {
        type = "movement-bonus-equipment", -- 外骨骼模块
        name = { "*" },
        exclude_names = {},
        operations = {
            -- energy_consumption = { type = "division", value = set_value_equipment }, -- 消耗
            movement_bonus = { type = "multiply", value = set_value_equipment, max_value = 2 }, -- 移动加成
        }
    },
    {
        type = "roboport-equipment", -- 机器人指令模块
        name = { "*" },
        exclude_names = {},
        operations = {
            charge_approach_distance = { type = "multiply", value = set_value_equipment, max_value = 5.2 },   -- 充电等待距离
            charging_distance = { type = "multiply", value = set_value_equipment, max_value = 3.2 },          -- 充电距离
            charging_energy = { type = "multiply", value = set_value_equipment },                             -- 充电功率
            charging_station_count = { type = "multiply", value = set_value_equipment, max_value = 8 },       -- 充电头个数
            charging_threshold_distance = { type = "multiply", value = set_value_equipment, max_value = 10 }, -- 充电阈值距离
            construction_radius = { type = "multiply", value = set_value_equipment, max_value = 64 },         -- 建设机器人施工半径
            robot_limit = { type = "multiply", value = set_value_equipment, max_value = 50 },                 -- 机器人个数限制
            ["energy_source.buffer_capacity"] = { type = "multiply", value = set_value_equipment },           -- 电池电量
            ["energy_source.input_flow_limit"] = { type = "multiply", value = set_value_equipment },          -- 电池输入限制
        }
    },
    {
        type = "night-vision-equipment", -- 夜视模块
        name = { "*" },
        exclude_names = {},
        operations = {
            color_lookup = { type = "set", value = { { 0.95, "__core__/graphics/color_luts/nightvision.png" } } }, -- 亮度
            -- energy_input = { type = "division", value = set_value_equipment }, -- 能量输入
            ["energy_source.buffer_capacity"] = { type = "multiply", value = set_value_equipment },  -- 电池电量
            ["energy_source.input_flow_limit"] = { type = "multiply", value = set_value_equipment }, -- 电池输入限制
        }
    },
    {
        type = "inventory-bonus-equipment", -- 工具带-设备
        name = { "*" },
        exclude_names = {},
        operations = {
            inventory_size_bonus = { type = "multiply", value = set_value_equipment, max_value = 20 }, -- 库存大小增益
        }
    },
    {
        type = "energy-shield-equipment", -- 能量盾模块
        name = { "*" },
        exclude_names = {},
        operations = {
            max_shield_value = { type = "multiply", value = set_value_equipment },                   -- 最大护盾值
            energy_per_shield = { type = "division", value = set_value_equipment },                  -- 消耗
            ["energy_source.buffer_capacity"] = { type = "multiply", value = set_value_equipment },  -- 电池电量
            ["energy_source.input_flow_limit"] = { type = "multiply", value = set_value_equipment }, -- 电池输入限制
        }
    },
    {
        type = "active-defense-equipment", -- 激光防御模块
        name = { "*" },
        exclude_names = {},
        operations = {
            ["energy_source.buffer_capacity"] = { type = "multiply", value = set_value_equipment },                                                       -- 电池电量
            ["attack_parameters.cooldown"] = { type = "division", value = set_value_equipment },                                                          -- 冷却时间
            ["attack_parameters.damage_modifier"] = { type = "multiply", value = set_value_equipment },                                                   -- 伤害修正
            ["attack_parameters.range"] = { type = "multiply", value = set_value_equipment, max_value = 36 },                                             -- 攻击范围
            ["attack_parameters.ammo_type.energy_consumption"] = { type = "division", value = set_value_equipment },                                      -- 消耗
            ["attack_parameters.ammo_type.action.action_delivery.duration"] = { type = "multiply", value = set_value_equipment, max_value = 80 },         -- 持续时间
            ["attack_parameters.ammo_type.action.action_delivery.max_length"] = { type = "multiply", value = set_value_equipment, max_value = 30 },       -- 最大长度
            ["attack_parameters.ammo_type.action[1].radius"] = { type = "multiply", value = set_value_equipment, max_value = 16 },                        -- 半径
            ["attack_parameters.ammo_type.action[1].action_delivery[2].duration"] = { type = "multiply", value = set_value_equipment, max_value = 30 },   -- 持续时间
            ["attack_parameters.ammo_type.action[1].action_delivery[2].max_length"] = { type = "multiply", value = set_value_equipment, max_value = 32 }, -- 最大长度
        }
    }
}

local instructions_equipment_size = {
    {
        type = "solar-panel-equipment", -- 太阳能模块
        name = { "*" },
        exclude_names = {},
        operations = {
            ["shape.height"] = { type = "set", value = 1 }, -- 高度
            ["shape.width"] = { type = "set", value = 1 },  -- 宽度
        }
    },
    {
        type = "generator-equipment", -- 发电机设备
        name = { "*" },
        exclude_names = {},
        operations = {
            ["shape.height"] = { type = "set", value = 1 }, -- 高度
            ["shape.width"] = { type = "set", value = 1 },  -- 宽度
        }
    },
    {
        type = "battery-equipment", -- 电池组模块
        name = { "*" },
        exclude_names = {},
        operations = {
            ["shape.height"] = { type = "set", value = 1 }, -- 高度
            ["shape.width"] = { type = "set", value = 1 },  -- 宽度
        }
    },
    {
        type = "belt-immunity-equipment", -- 锚定模块
        name = { "*" },
        exclude_names = {},
        operations = {
            ["shape.height"] = { type = "set", value = 1 }, -- 高度
            ["shape.width"] = { type = "set", value = 1 },  -- 宽度
        }
    },
    {
        type = "movement-bonus-equipment", -- 外骨骼模块
        name = { "*" },
        exclude_names = {},
        operations = {
            ["shape.height"] = { type = "set", value = 1 }, -- 高度
            ["shape.width"] = { type = "set", value = 1 },  -- 宽度
        }
    },
    {
        type = "roboport-equipment", -- 机器人指令模块
        name = { "*" },
        exclude_names = {},
        operations = {
            ["shape.height"] = { type = "set", value = 1 }, -- 高度
            ["shape.width"] = { type = "set", value = 1 },  -- 宽度
        }
    },
    {
        type = "night-vision-equipment", -- 夜视模块
        name = { "*" },
        exclude_names = {},
        operations = {
            ["shape.height"] = { type = "set", value = 1 }, -- 高度
            ["shape.width"] = { type = "set", value = 1 },  -- 宽度
        }
    },
    {
        type = "inventory-bonus-equipment", -- 工具带-设备
        name = { "*" },
        exclude_names = {},
        operations = {
            ["shape.height"] = { type = "set", value = 1 }, -- 高度
            ["shape.width"] = { type = "set", value = 1 },  -- 宽度
        }
    },
    {
        type = "energy-shield-equipment", -- 能量盾模块
        name = { "*" },
        exclude_names = {},
        operations = {
            ["shape.height"] = { type = "set", value = 1 }, -- 高度
            ["shape.width"] = { type = "set", value = 1 },  -- 宽度
        }
    },
    {
        type = "active-defense-equipment", -- 激光防御模块
        name = { "*" },
        exclude_names = {},
        operations = {
            ["shape.height"] = { type = "set", value = 1 }, -- 高度
            ["shape.width"] = { type = "set", value = 1 },  -- 宽度
        }
    }
}

-- 修改装备尺寸
if set_value_equipment_size_flag then
    for _, tbl in ipairs(instructions_equipment_size) do
        table.insert(instructions_equipment, tbl)
    end
end


-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_equipment)
log("instructions_equipment modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not X_CUSTOM_GAME_MODIFIED_TYPE[prototype] then
            X_CUSTOM_GAME_MODIFIED_TYPE[prototype] = true
        end
    end
end
