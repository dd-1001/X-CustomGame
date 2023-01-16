local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.lib_logger("x-custom-game-weapon.lua")

-- data.raw修改目录
local data_raw_gun_catalog = {
    gun = { -- 枪
        orig = {
            "pistol", -- 手枪
            "submachine-gun", -- 冲锋枪
            "shotgun", -- 霰弹枪
            "combat-shotgun", -- 冲锋霰弹枪
            "rocket-launcher", -- 火箭筒
            "flamethrower", -- 火焰喷射器
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-gun-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "attack_parameters", "cooldown" }, -- 再次射击的冷却时间
                operation = "Div"
            }, {
                path = { "attack_parameters", "movement_slow_down_factor" }, -- 移动减速因子
                operation = "Div"
            }, {
                path = { "attack_parameters", "projectile_creation_distance" } -- 投射物创建距离
            }, {
                path = { "attack_parameters", "range" } -- 范围
            }
        }
    }
}

-- 地雷
local data_raw_land_mine_catalog = {
    ["land-mine"] = { -- 地雷
        orig = {
            "land-mine", -- 地雷
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-land-mine-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "action", "action_delivery", "source_effects", 1, "action", "action_delivery", "target_effects",
                    1, "damage", "amount" } -- 爆炸伤害
            }, {
                path = { "action", "action_delivery", "source_effects", 1, "action", "radius" } -- 爆炸范围
            }, {
                path = { "trigger_radius" } -- 触发半径
            }
        }
    }
}

-- 弹匣
local data_raw_ammo_magazine_catalog = {
    ["ammo"] = { -- 弹药
        orig = {
            "firearm-magazine", -- 标准弹匣
            "piercing-rounds-magazine", -- 穿甲弹匣
            "uranium-rounds-magazine", -- 贫铀弹匣
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-ammo-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "ammo_type", "action", 1, "action_delivery", 1, "target_effects", 2, "damage", "amount" } -- 弹匣伤害
            }, {
                path = { "magazine_size" }, -- 弹药物品被消耗前的射击次数。必须是>=1。
                min_value = 1
            }
        }
    }
}

-- 霰弹
local data_raw_ammo_shotgun_shell_catalog = {
    ["ammo"] = { -- 弹药
        orig = {
            "shotgun-shell", -- 标准霰弹
            "piercing-shotgun-shell", -- 穿甲霰弹
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-ammo-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "magazine_size" }, -- 弹药物品被消耗前的射击次数。必须是>=1。
                min_value = 1
            }, {
                path = { "ammo_type", "action", 2, "action_delivery", "direction_deviation" }, -- 方向偏离度
                operation = "Div"
            }, {
                path = { "ammo_type", "action", 2, "action_delivery", "max_range" }, -- 范围
            }, {
                path = { "ammo_type", "action", 2, "action_delivery", "range_deviation" }, -- 范围偏离度
                operation = "Div"
            }, {
                path = { "ammo_type", "action", 2, "action_delivery", "starting_speed" } -- 开始速度
            }, {
                path = { "ammo_type", "action", 2, "action_delivery", "starting_speed_deviation" }, -- 开始速度偏离度
                operation = "Div"
            }, {
                path = { "ammo_type", "action", 2, "repeat_count" } -- 重复次数
            }
        }
    }
}

-- 炮弹
local data_raw_ammo_cannon_shell_catalog = {
    ["ammo"] = { -- 弹药
        orig = {
            "cannon-shell", -- 标准炮弹
            "explosive-cannon-shell", -- 爆破炮弹
            "uranium-cannon-shell", -- 贫铀炮弹
            "explosive-uranium-cannon-shell", -- 爆破贫铀炮弹
            "artillery-shell", -- 重炮炮弹
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-ammo-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "magazine_size" }, -- 弹药物品被消耗前的射击次数。必须是>=1。
                min_value = 1
            }, {
                path = { "ammo_type", "action", "action_delivery", "direction_deviation" }, -- 方向偏离度
                operation = "Div"
            }, {
                path = { "ammo_type", "action", "action_delivery", "max_range" }, -- 范围
            }, {
                path = { "ammo_type", "action", "action_delivery", "range_deviation" }, -- 范围偏离度
                operation = "Div"
            }, {
                path = { "ammo_type", "action", "action_delivery", "starting_speed" } -- 开始速度
            }
        }
    }
}

-- 火箭弹
local data_raw_ammo_atomic_bomb_catalog = {
    ["ammo"] = { -- 弹药
        orig = {
            "atomic-bomb", -- 原子火箭弹
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-ammo-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "magazine_size" }, -- 弹药物品被消耗前的射击次数。必须是>=1。
                min_value = 1
            }, {
                path = { "ammo_type", "action", "action_delivery", "starting_speed" } -- 开始速度
            }, {
                path = { "ammo_type", "cooldown_modifier" }, -- 冷却修正
                operation = "Div"
            }, {
                path = { "ammo_type", "range_modifier" } -- 范围修正
            }
        }
    }
}

-- 油料储罐
local data_raw_ammo_flamethrower_catalog = {
    ["ammo"] = { -- 弹药
        orig = {
            "flamethrower-ammo", -- 油料储罐
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-ammo-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "magazine_size" }, -- 弹药物品被消耗前的射击次数。必须是>=1。
                min_value = 1
            }, {
                path = { "ammo_type",2, "consumption_modifier" }, -- 消耗量修正
                operation = "Div"
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------武器 start------------------n\n\n")

common_data_raw:execute_modify(data_raw_gun_catalog)
common_data_raw:execute_modify(data_raw_land_mine_catalog)

common_data_raw:execute_modify(data_raw_ammo_magazine_catalog)
common_data_raw:execute_modify(data_raw_ammo_shotgun_shell_catalog)
common_data_raw:execute_modify(data_raw_ammo_cannon_shell_catalog)
common_data_raw:execute_modify(data_raw_ammo_atomic_bomb_catalog)
common_data_raw:execute_modify(data_raw_ammo_flamethrower_catalog)

log("\n\n\n------------------武器 end------------------n\n\n")
