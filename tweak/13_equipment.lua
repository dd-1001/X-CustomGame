local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.lib_logger("x-custom-game-equipment.lua")

-- 装备模块
local data_raw_equipment_catalog = {
    ["solar-panel-equipment"] = { -- 太阳能模块
        orig = {
            "solar-panel-equipment", -- 太阳能模块
        },
        mod = {
            "big-solar-panel-equipment", -- Krastorio2
            "imersite-solar-panel-equipment",
            "big-imersite-solar-panel-equipment" -- Krastorio2
        },
        mul = settings.startup["x-custom-game-equipment-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "power" } -- 能量
            }
        }
    },
    ["generator-equipment"] = { -- 聚变堆模块
        orig = {
            "fusion-reactor-equipment", -- 聚变堆模块
        },
        mod = {
            "small-portable-generator", -- Krastorio2
            "portable-generator",
            "nuclear-reactor-equipment",
            "antimatter-reactor-equipment",
            "cyber-potato-equipment", -- Krastorio2
        },
        mul = settings.startup["x-custom-game-equipment-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "power" } -- 能量
            }
        }
    },
    ["battery-equipment"] = { -- 电池组模块
        orig = {
            "battery-equipment", -- 电池组模块
            "battery-mk2-equipment", -- 电池组模块MK2
        },
        mod = {
            "battery-mk3-equipment", -- Krastorio2
            "big-battery-equipment",
            "big-battery-mk2-equipment",
            "big-battery-mk3-equipment",
            "energy-absorber", -- Krastorio2
        },
        mul = settings.startup["x-custom-game-equipment-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "energy_source", "buffer_capacity" } -- 容量
            }
        }
    },
    ["belt-immunity-equipment"] = { -- 锚定模块
        orig = {
            "belt-immunity-equipment", -- 锚定模块
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-equipment-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "energy_consumption" }, -- 能量消耗
                operation = "Div"
            }, {
                path = { "energy_source", "buffer_capacity" } -- 容量
            }, {
                path = { "energy_source", "input_flow_limit" } -- 输入限制
            }
        }
    },
    ["movement-bonus-equipment"] = { -- 外骨骼模块
        orig = {
            "exoskeleton-equipment", -- 外骨骼模块
        },
        mod = {
            "advanced-exoskeleton-equipment", -- Krastorio2
            "superior-exoskeleton-equipment",
            "additional-engine",
            "advanced-additional-engine" -- Krastorio2
        },
        mul = settings.startup["x-custom-game-equipment-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "energy_consumption" }, -- 能量消耗
                operation = "Div"
            }, {
                path = { "movement_bonus" }, -- 移动加成
                max_value = 2-- 默认值为 0.3
            }
        }
    },
    ["roboport-equipment"] = { -- 机器人指令模块
        orig = {
            "personal-roboport-equipment", -- 机器人指令模块
            "personal-roboport-mk2-equipment", -- 机器人指令模块MK2
        },
        mod = {
            "vehicle-roboport", -- Krastorio2
        },
        mul = settings.startup["x-custom-game-equipment-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "charging_distance" }, -- 充电距离
                max_value = 5
            }, {
                path = { "charging_energy" }, -- 充电能量
            }, {
                path = { "charging_station_count" }, -- 充电点个数
                max_value = 16
            }, {
                path = { "construction_radius" }, -- 施工半径
                max_value = 64
            }, {
                path = { "energy_source", "buffer_capacity" }, -- 电池容量
            }, {
                path = { "energy_source", "input_flow_limit" }, -- 输入限制
            }, {
                path = { "robot_limit" }, -- 机器人个数限制
                max_value = 64
            }
        }
    },
    ["night-vision-equipment"] = { -- 夜视模块
        orig = {
            "night-vision-equipment", -- 夜视模块
        },
        mod = {
            "imersite-night-vision-equipment", -- Krastorio2
        },
        mul = settings.startup["x-custom-game-equipment-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "energy_input" }, -- 能量输入
                operation = "Div"
            }, {
                path = { "energy_source", "buffer_capacity" }, -- 电池容量
            }, {
                path = { "energy_source", "input_flow_limit" }, -- 输入限制
            }
        }
    },
    ["energy-shield-equipment"] = { -- 能量盾模块
        orig = {
            "energy-shield-equipment", -- 能量盾模块
            "energy-shield-mk2-equipment", -- 能量盾模块MK2
        },
        mod = {
            "energy-shield-mk3-equipment", -- Krastorio2
            "energy-shield-mk4-equipment", -- Krastorio2
        },
        mul = settings.startup["x-custom-game-equipment-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            -- {
            --     path = { "energy_per_shield" }, -- 每点护盾值消耗能量，改了太变态，故保持不变
            --     operation = "Div"
            -- },
            {
                path = { "energy_source", "buffer_capacity" }, -- 电池容量
            }, {
                path = { "energy_source", "input_flow_limit" }, -- 能量盾模块MK2
            }, {
                path = { "max_shield_value" }, -- 最大护盾值
            }
        }
    },
    ["active-defense-equipment"] = { -- 激光防御模块
        orig = {
            "personal-laser-defense-equipment", -- 激光防御模块
            "discharge-defense-equipment", -- 放电防御模块
        },
        mod = {
            "personal-laser-defense-mk2-equipment", -- Krastorio2
            "personal-laser-defense-mk3-equipment",
            "personal-laser-defense-mk4-equipment",
            "personal-submachine-laser-defense-mk1-equipment",
            "personal-submachine-laser-defense-mk2-equipment",
            "personal-submachine-laser-defense-mk3-equipment",
            "personal-submachine-laser-defense-mk4-equipment" -- Krastorio2
        },
        mul = settings.startup["x-custom-game-equipment-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "attack_parameters", "ammo_type", "action", 1, "action_delivery", 1, "target_effects", 2,
                    "distance" }, -- 推后距离
                max_value = 32
            }, {
                path = { "attack_parameters", "ammo_type", "action", 2, "duration" }, -- 持续时间
            }, {
                path = { "attack_parameters", "ammo_type", "action", 2, "max_length" }, -- 最大长度
            }, {
                path = { "attack_parameters", "ammo_type", "action", 1, "radius" }, -- 半径
                max_value = 32
            }, {
                path = { "attack_parameters", "ammo_type", "energy_consumption" }, -- 能量消耗
                min_value = 20000,
                operation = "Div"
            }, {
                path = { "attack_parameters", "cooldown" }, -- 冷却时间
                operation = "Div"
            }, {
                path = { "attack_parameters", "damage_modifier" }, -- 伤害修正
            }, {
                path = { "attack_parameters", "projectile_creation_distance" }, -- 抛射物创建距离
            }, {
                path = { "attack_parameters", "range" }, -- 距离
                max_value = 64
            }, {
                path = { "attack_parameters", "ammo_type", "action", "action_delivery", "duration" }, -- 持续时间
                max_value = 64
            }, {
                path = { "attack_parameters", "ammo_type", "action", "action_delivery", "max_length" }, -- 距离
                max_value = 64
            }, {
                path = { "attack_parameters", "ammo_type", "energy_consumption" }, -- 能量消耗
                operation = "Div",
                min_value = 20000
            }, {
                path = { "energy_source", "buffer_capacity" }, -- 电池容量
            }
        }
    }
}

-- 装备形状大小
local data_raw_equipment_shape_size_catalog = {
    ["solar-panel-equipment"] = { -- 太阳能模块
        orig = {
            "solar-panel-equipment", -- 太阳能模块
        },
        mod = {
            "big-solar-panel-equipment", -- Krastorio2
            "imersite-solar-panel-equipment",
            "big-imersite-solar-panel-equipment" -- Krastorio2
        },
        modify_parameter = { -- 修改参数
            {
                path = { "shape", "height" }, -- 高度
                value = 1
            }, {
                path = { "shape", "width" }, -- 宽度
                value = 1
            }
        }
    },
    ["generator-equipment"] = { -- 聚变堆模块
        orig = {
            "fusion-reactor-equipment", -- 聚变堆模块
        },
        mod = {
            "small-portable-generator", -- Krastorio2
            "portable-generator",
            "nuclear-reactor-equipment",
            "antimatter-reactor-equipment",
            "cyber-potato-equipment", -- Krastorio2
        },
        modify_parameter = { -- 修改参数
            {
                path = { "shape", "height" }, -- 高度
                value = 1
            }, {
                path = { "shape", "width" }, -- 宽度
                value = 1
            }
        }
    },
    ["battery-equipment"] = { -- 电池组模块
        orig = {
            "battery-equipment", -- 电池组模块
            "battery-mk2-equipment", -- 电池组模块MK2
        },
        mod = {
            "battery-mk3-equipment", -- Krastorio2
            "big-battery-equipment",
            "big-battery-mk2-equipment",
            "big-battery-mk3-equipment",
            "energy-absorber", -- Krastorio2
            "jetpack-1", -- jetpack start
            "jetpack-2",
            "jetpack-3",
            "jetpack-4", -- jetpack end
        },
        modify_parameter = { -- 修改参数
            {
                path = { "shape", "height" }, -- 高度
                value = 1
            }, {
                path = { "shape", "width" }, -- 宽度
                value = 1
            }
        }
    },
    ["belt-immunity-equipment"] = { -- 锚定模块
        orig = {
            "belt-immunity-equipment", -- 锚定模块
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-equipment-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "shape", "height" }, -- 高度
                value = 1
            }, {
                path = { "shape", "width" }, -- 宽度
                value = 1
            }
        }
    },
    ["movement-bonus-equipment"] = { -- 外骨骼模块
        orig = {
            "exoskeleton-equipment", -- 外骨骼模块
        },
        mod = {
            "advanced-exoskeleton-equipment", -- Krastorio2
            "superior-exoskeleton-equipment",
            "additional-engine",
            "advanced-additional-engine" -- Krastorio2
        },
        modify_parameter = { -- 修改参数
            {
                path = { "shape", "height" }, -- 高度
                value = 1
            }, {
                path = { "shape", "width" }, -- 宽度
                value = 1
            }
        }
    },
    ["roboport-equipment"] = { -- 机器人指令模块
        orig = {
            "personal-roboport-equipment", -- 机器人指令模块
            "personal-roboport-mk2-equipment", -- 机器人指令模块MK2
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-equipment-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "shape", "height" }, -- 高度
                value = 1
            }, {
                path = { "shape", "width" }, -- 宽度
                value = 1
            }
        }
    },
    ["night-vision-equipment"] = { -- 夜视模块
        orig = {
            "night-vision-equipment", -- 夜视模块
        },
        mod = {
            "imersite-night-vision-equipment", -- Krastorio2
        },
        modify_parameter = { -- 修改参数
            {
                path = { "shape", "height" }, -- 高度
                value = 1
            }, {
                path = { "shape", "width" }, -- 宽度
                value = 1
            }
        }
    },
    ["energy-shield-equipment"] = { -- 能量盾模块
        orig = {
            "energy-shield-equipment", -- 能量盾模块
            "energy-shield-mk2-equipment", -- 能量盾模块MK2
        },
        mod = {
            "energy-shield-mk3-equipment", -- Krastorio2
            "energy-shield-mk4-equipment", -- Krastorio2
        },
        mul = settings.startup["x-custom-game-equipment-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "shape", "height" }, -- 高度
                value = 1
            }, {
                path = { "shape", "width" }, -- 宽度
                value = 1
            }
        }
    },
    ["active-defense-equipment"] = { -- 激光防御模块
        orig = {
            "personal-laser-defense-equipment", -- 激光防御模块
            "discharge-defense-equipment", -- 放电防御模块
        },
        mod = {
            "personal-laser-defense-mk2-equipment", -- Krastorio2
            "personal-laser-defense-mk3-equipment",
            "personal-laser-defense-mk4-equipment",
            "personal-submachine-laser-defense-mk1-equipment",
            "personal-submachine-laser-defense-mk2-equipment",
            "personal-submachine-laser-defense-mk3-equipment",
            "personal-submachine-laser-defense-mk4-equipment" -- Krastorio2
        },
        mul = settings.startup["x-custom-game-equipment-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "shape", "height" }, -- 高度
                value = 1
            }, {
                path = { "shape", "width" }, -- 宽度
                value = 1
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------装备 start------------------n\n\n")

common_data_raw:execute_modify(data_raw_equipment_catalog)
if settings.startup["x-custom-game-equipment-size-flags"].value then
    common_data_raw:execute_modify(data_raw_equipment_shape_size_catalog)
end

log("\n\n\n------------------装备 end------------------n\n\n")
