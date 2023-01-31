local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.lib_logger("x-custom-game-weapon.lua")

-- 枪
local data_raw_gun_catalog = {
    gun = { -- 枪
        orig = {
            "pistol", -- 手枪
            "submachine-gun", -- 冲锋枪
            "shotgun", -- 霰弹枪
            "combat-shotgun", -- 冲锋霰弹枪
            "rocket-launcher", -- 火箭筒
            "flamethrower", -- 火焰喷射器
            "artillery-wagon-cannon", -- 重炮车厢
            "tank-cannon", -- 坦克炮
            "tank-flamethrower", -- 车载喷火器
            "tank-machine-gun", -- 车载机枪
            "vehicle-machine-gun", -- 车载机枪
        },
        mod = {
            "impulse-rifle", -- Krastorio2
            "heavy-rocket-launcher",
            "anti-material-rifle", -- Krastorio2
        },
        mul = settings.startup["x-custom-game-gun-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "attack_parameters", "cooldown" }, -- 再次射击的冷却时间
                operation = "Div"
            }, {
                path = { "attack_parameters", "movement_slow_down_factor" }, -- 移动减速因子
                operation = "Div"
            },
            {
                path = { "attack_parameters", "range" } -- 范围
            }, {
                path = { "attack_parameters", "damage_modifier" } -- 伤害修正
            }
        }
    }
}

-- 蜘蛛机甲火箭筒
local data_raw_spidertron_rocket_launcher_catalog = {
    gun = { -- 枪
        orig = {
            "spidertron-rocket-launcher-1", -- 蜘蛛机甲火箭筒
            "spidertron-rocket-launcher-2", -- 蜘蛛机甲火箭筒
            "spidertron-rocket-launcher-3", -- 蜘蛛机甲火箭筒
            "spidertron-rocket-launcher-4", -- 蜘蛛机甲火箭筒
        },
        mod = {
            "dolphin-gun", -- Krastorio2
            "kr-accelerator",
            "advanced-tank-machine-gun",
            "advanced-tank-laser-cannon",
            "advanced-tank-cannon-a",
            "advanced-tank-cannon-b",
            "advanced-tank-cannon-c", -- Krastorio2
        },
        mul = settings.startup["x-custom-game-gun-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "attack_parameters", "cooldown" }, -- 再次射击的冷却时间
                operation = "Div"
            }, {
                path = { "attack_parameters", "range" }, -- 范围
                max_value = 160
            }, {
                path = { "attack_parameters", "damage_modifier" } -- 伤害修正
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
    ammo = { -- 弹匣
        orig = {
            "firearm-magazine", -- 标准弹匣
            "piercing-rounds-magazine", -- 穿甲弹匣
            "uranium-rounds-magazine", -- 贫铀弹匣
        },
        mod = {
            "impulse-rifle-ammo", -- Krastorio2
            "rifle-magazine",
            "armor-piercing-rifle-magazine",
            "uranium-rifle-magazine",
            "imersite-rifle-magazine",
            "anti-material-rifle-magazine",
            "armor-piercing-anti-material-rifle-magazine",
            "uranium-anti-material-rifle-magazine",
            "imersite-anti-material-rifle-magazine" -- Krastorio2
        },
        mul = settings.startup["x-custom-game-ammo-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "ammo_type", "action", 1, "action_delivery", 1, "target_effects", 2, "damage", "amount" } -- 标准弹匣伤害
            }, {
                path = { "ammo_type", "action", "action_delivery", "target_effects", 2, "damage", "amount" } -- 穿甲弹匣伤害
            }, {
                path = { "magazine_size" }, -- 弹药物品被消耗前的射击次数。必须是>=1。
                min_value = 1
            }
        }
    }
}

-- 霰弹
local data_raw_ammo_shotgun_shell_catalog = {
    ammo = { -- 霰弹
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

-- 霰弹 附加的抛射物效果
local data_raw_shotgun_additional_effects_catalog = {
    projectile = { -- 霰弹 附加效果
        orig = {
            "shotgun-pellet", -- 标准霰弹
            "piercing-shotgun-pellet", -- 穿甲霰弹
        },
        mul = settings.startup["x-custom-game-ammo-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "acceleration" } -- 加速度
            }, {
                path = { "action", "action_delivery", "target_effects", "damage", "amount" } -- 伤害
            }
        }
    }
}

-- 炮弹
local data_raw_ammo_cannon_shell_catalog = {
    ammo = { -- 炮弹
        orig = {
            "cannon-shell", -- 标准炮弹
            "explosive-cannon-shell", -- 爆破炮弹
            "uranium-cannon-shell", -- 贫铀炮弹
            "explosive-uranium-cannon-shell", -- 爆破贫铀炮弹
            "artillery-shell", -- 重炮炮弹
        },
        mod = {
            "antimatter-artillery-shell", -- Krastorio2
            "basic-railgun-shell",
            "explosion-railgun-shell",
            "antimatter-railgun-shell",
            "nuclear-artillery-shell",

        },
        mul = settings.startup["x-custom-game-ammo-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
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

-- 炮弹 附加的抛射物效果
local data_raw_shell_additional_effects_catalog = {
    projectile = { -- 炮弹 附加效果
        orig = {
            "cannon-projectile",
            "explosive-cannon-projectile",
            "uranium-cannon-projectile",
            "explosive-uranium-cannon-projectile",
        },
        mul = settings.startup["x-custom-game-ammo-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "acceleration" } -- 加速度
            }, {
                path = { "action", "action_delivery", "target_effects", 1, "damage", "amount" } -- physical伤害
            }, {
                path = { "action", "action_delivery", "target_effects", 2, "damage", "amount" } -- explosion伤害
            }, {
                path = { "piercing_damage" } -- 穿透伤害
            }, {
                path = { "final_action", "action_delivery", "target_effects", 2, "action", "action_delivery",
                    "target_effects", 1, "damage", "amount" } -- explosion伤害
            }
        }
    }
}

-- 火箭弹
local data_raw_ammo_atomic_bomb_catalog = {
    ammo = { -- 火箭弹
        orig = {
            "rocket", -- 标准火箭弹
            "explosive-rocket", -- 爆破火箭弹
            "atomic-bomb", -- 原子火箭弹
        },
        mod = {
            "heavy-rocket", -- Krastorio2
            "antimatter-rocket",
            "explosive-turret-rocket",
            "nuclear-turret-rocket",
            "antimatter-turret-rocket",

        },
        mul = settings.startup["x-custom-game-ammo-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
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

-- 火箭弹 附加的抛射物效果
local data_raw_rocket_additional_effects_catalog = {
    projectile = { -- 火箭弹 附加效果
        orig = {
            "rocket",
            "explosive-rocket",
            "atomic-rocket",
            "atomic-bomb-ground-zero-projectile",
            "atomic-bomb-wave",
            "atomic-bomb-wave-spawns-cluster-nuke-explosion",
            "atomic-bomb-wave-spawns-fire-smoke-explosion",
            "atomic-bomb-wave-spawns-nuclear-smoke",
            "atomic-bomb-wave-spawns-nuke-shockwave-explosion",

        },
        mul = settings.startup["x-custom-game-ammo-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "acceleration" } -- 加速度
            }, {
                path = { "action", 1, "action_delivery", "target_effects", "damage", "amount" } -- 伤害
            }, {
                path = { "action", 1, "action_delivery", "target_effects", "lower_damage_modifier" } -- 下限伤害修正
            }, {
                path = { "action", 1, "action_delivery", "target_effects", "upper_damage_modifier" } -- 上限伤害修正
            }, {
                path = { "action", 1, "action_delivery", "target_effects", "upper_distance_threshold" } -- 上限距离阈值
            }, {
                path = { "action", "action_delivery", "target_effects", 7, "damage", "amount" } -- 原子火箭弹-火箭 伤害
            }, {
                path = { "action", "action_delivery", "target_effects", 2, "damage", "amount" } -- 标准火箭弹-火箭 伤害
            }
            -- {
            --     path = { "action", 1, "radius" } -- 半径
            -- }
        }
    }
}

-- 油料储罐
local data_raw_ammo_flamethrower_catalog = {
    ammo = { -- 储罐
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
                path = { "ammo_type", 2, "consumption_modifier" }, -- 消耗量修正
                operation = "Div"
            }
        }
    }
}





-- 开始修改
log("\n\n\n------------------武器 start------------------n\n\n")

common_data_raw:execute_modify(data_raw_gun_catalog)
common_data_raw:execute_modify(data_raw_spidertron_rocket_launcher_catalog)
common_data_raw:execute_modify(data_raw_land_mine_catalog)

common_data_raw:execute_modify(data_raw_ammo_magazine_catalog)
common_data_raw:execute_modify(data_raw_ammo_shotgun_shell_catalog)
common_data_raw:execute_modify(data_raw_ammo_cannon_shell_catalog)
common_data_raw:execute_modify(data_raw_ammo_atomic_bomb_catalog)
common_data_raw:execute_modify(data_raw_ammo_flamethrower_catalog)

common_data_raw:execute_modify(data_raw_shotgun_additional_effects_catalog)
common_data_raw:execute_modify(data_raw_shell_additional_effects_catalog)
common_data_raw:execute_modify(data_raw_rocket_additional_effects_catalog)

log("\n\n\n------------------武器 end------------------n\n\n")
