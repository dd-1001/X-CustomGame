local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.lib_logger("x-custom-game-Defense.lua")

-- 墙、闸门
local data_raw_wall_catalog = {
    wall = { -- 墙
        orig = {
            "stone-wall", -- 石墙
        },
        mod = {
            "concrete-wall", -- aai-industry
            "steel-wall", -- aai-industry
        },
        mul = settings.startup["x-custom-game-wall-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "max_health" } -- 最大生命值
            }, {
                path = { "repair_speed_modifier" } -- 修复速度修正
            }, {
                path = { "resistances", 1, "decrease" } -- 物理抗性physical
            }, {
                path = { "resistances", 2, "decrease" } -- 冲击impact
            }, {
                path = { "resistances", 3, "decrease" } -- 爆炸抗性explosion
            }, {
                path = { "resistances", 4, "decrease" } -- 火抗性fire
            }, {
                path = { "resistances", 5, "decrease" } -- 酸抗性acid
            }, {
                path = { "resistances", 6, "decrease" } -- 激光laser
            }, {
                path = { "resistances", 1, "percent" } -- 物理抗性physical
            }, {
                path = { "resistances", 2, "percent" } -- 冲击impact
            }, {
                path = { "resistances", 3, "percent" } -- 爆炸抗性explosion
            }, {
                path = { "resistances", 4, "percent" } -- 火抗性fire
            }, {
                path = { "resistances", 5, "percent" } -- 酸抗性acid
            }, {
                path = { "resistances", 6, "percent" } -- 激光laser
            }
        }
    },
    gate = { -- 闸门
        orig = {
            "gate", -- 闸门
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-wall-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "max_health" } -- 最大生命值
            }, {
                path = { "resistances", 1, "decrease" } -- 物理抗性physical
            }, {
                path = { "resistances", 2, "decrease" } -- 冲击impact
            }, {
                path = { "resistances", 3, "decrease" } -- 爆炸抗性explosion
            }, {
                path = { "resistances", 4, "decrease" } -- 火抗性fire
            }, {
                path = { "resistances", 5, "decrease" } -- 酸抗性acid
            }, {
                path = { "resistances", 6, "decrease" } -- 激光laser
            }, {
                path = { "resistances", 1, "percent" } -- 物理抗性physical
            }, {
                path = { "resistances", 2, "percent" } -- 冲击impact
            }, {
                path = { "resistances", 3, "percent" } -- 爆炸抗性explosion
            }, {
                path = { "resistances", 4, "percent" } -- 火抗性fire
            }, {
                path = { "resistances", 5, "percent" } -- 酸抗性acid
            }, {
                path = { "resistances", 6, "percent" } -- 激光laser
            }
        }
    }
}

-- 机枪炮塔
local data_raw_ammo_turret_catalog = {
    ["ammo-turret"] = { -- 机枪炮塔
        orig = {
            "gun-turret", -- 机枪炮塔
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-ammo-turret-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "attack_parameters", "cooldown" }, -- 冷却时间
                operation = "Div"
            }, {
                path = { "attack_parameters", "range" }, -- 最大攻击距离
                max_value = 36
            }, {
                path = { "attacking_speed" }, -- 攻击速度
            }, {
                path = { "automated_ammo_count" }, -- 自动弹药数量
            }, {
                path = { "call_for_help_radius" }, -- 唤醒半径
                max_value = 72
            }, {
                path = { "max_health" }, -- 最大生命值
            }, {
                path = { "preparing_speed" }, -- 准备速度
            }, {
                path = { "rotation_speed" }, -- 旋转速度
            }
        }
    }
}

-- 激光炮塔
local data_raw_electric_turret_catalog = {
    ["electric-turret"] = { -- 电炮塔
        orig = {
            "laser-turret", -- 激光炮塔
        },
        mod = {
            "shield-projector", -- shield-projector
        },
        mul = settings.startup["x-custom-game-electric-turret-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "attack_parameters", "ammo_type", "action", "action_delivery", "duration" }, -- 持续时间
                operation = "Div"
            }, {
                path = { "attack_parameters", "ammo_type", "action", "action_delivery", "max_length" }, -- 最大距离
                max_value = 36
            }, {
                path = { "attack_parameters", "ammo_type", "energy_consumption" }, -- 能量消耗
                operation = "Div",
                min_value = 20000
            }, {
                path = { "attack_parameters", "cooldown" }, -- 冷却时间
                operation = "Div"
            }, {
                path = { "attack_parameters", "damage_modifier" }, -- 伤害修正
            }, {
                path = { "attack_parameters", "range" }, -- 最大攻击距离
                max_value = 36
            }, {
                path = { "call_for_help_radius" }, -- 唤醒半径
                max_value = 72
            }, {
                path = { "energy_source", "buffer_capacity" }, -- 电池容量
            }, {
                path = { "energy_source", "input_flow_limit" }, -- 输入限制
            }, {
                path = { "folding_speed" }, -- 最大生命值
            }, {
                path = { "max_health" }, -- 最大生命值
            }, {
                path = { "preparing_speed" }, -- 准备速度
            }, {
                path = { "rotation_speed" }, -- 旋转速度
            }
        }
    }
}

-- 流体炮塔
local data_raw_fluid_turret_catalog = {
    ["fluid-turret"] = { -- 流体炮塔
        orig = {
            "flamethrower-turret", -- 火焰炮塔
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-fluid-turret-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "activation_buffer_ratio" }, -- 激活的缓冲区比率
            }, {
                path = { "attack_parameters", "cooldown" }, -- 冷却时间
                operation = "Div"
            }, {
                path = { "attack_parameters", "fluid_consumption" }, -- 流体消耗
                operation = "Div",
                min_value = 0.05
            }, {
                path = { "attack_parameters", "range" }, -- 攻击距离
                max_value = 36
            }, {
                path = { "attack_parameters", "fluids", 1, "damage_modifier" }, -- 伤害修正
                operation = "Extend",
                value = 1
            }, {
                path = { "attack_parameters", "fluids", 1, "damage_modifier" }, -- 伤害修正
            }, {
                path = { "attack_parameters", "fluids", 2, "damage_modifier" }, -- 伤害修正
            }, {
                path = { "attack_parameters", "fluids", 3, "damage_modifier" }, -- 伤害修正
            }, {
                path = { "attacking_speed" }, -- 攻击速度
            }, {
                path = { "call_for_help_radius" }, -- 唤醒半径
                max_value = 72
            }, {
                path = { "fluid_box", "base_area" }, -- 液体箱
            }, {
                path = { "fluid_buffer_input_flow" }, -- 流体缓冲器的输入流量
            }, {
                path = { "fluid_buffer_size" }, -- 液体缓冲区大小
            }, {
                path = { "folding_speed" }, -- 折叠速度
            }, {
                path = { "max_health" }, -- 最大生命值
            }, {
                path = { "prepare_range" }, -- 预准备距离
                max_value = 36
            }, {
                path = { "preparing_speed" }, -- 预准备速度
            }, {
                path = { "rotation_speed" }, -- 旋转速度
            }


        }
    }
}

-- 重炮炮塔
local data_raw_artillery_turret_catalog = {
    ["artillery-turret"] = { -- 重炮炮塔
        orig = {
            "artillery-turret", -- 重炮炮塔
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-artillery-turret-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "ammo_stack_limit" }, -- 弹药堆积限额
            }, {
                path = { "automated_ammo_count" }, -- 自动弹药数量
            }, {
                path = { "manual_range_modifier" }, -- 手动范围修正
            }, {
                path = { "turn_after_shooting_cooldown" }, -- 射击后的转身_冷却时间
                operation = "Div"
            }, {
                path = { "turret_rotation_speed" }, -- 炮塔旋转速度
            }, {
                path = { "max_health" }, -- 最大生命值
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------防御 start------------------n\n\n")

common_data_raw:execute_modify(data_raw_wall_catalog)
common_data_raw:execute_modify(data_raw_ammo_turret_catalog)
common_data_raw:execute_modify(data_raw_electric_turret_catalog)
common_data_raw:execute_modify(data_raw_fluid_turret_catalog)
common_data_raw:execute_modify(data_raw_artillery_turret_catalog)

log("\n\n\n------------------防御 end------------------n\n\n")
