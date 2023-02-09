local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.Log

-- 手雷
local data_raw_grenade_catalog = {
    projectile = { -- 雷
        orig = {
            "grenade", -- 标准手雷
            "cluster-grenade", -- 集束手雷
            "cliff-explosives", -- 悬崖炸药
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-grenade-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "acceleration" } -- 加速度
            },
            {
                path = { "action", 1, "action_delivery", "target_effects", 4, "radius" } -- 半径
            },
            {
                path = { "action", 2, "action_delivery", "target_effects", 1, "damage", "amount" } -- 伤害
            },
            {
                path = { "action", 2, "radius" } -- 爆炸半径
            },
            {
                path = { "action", 2, "action_delivery", "starting_speed" } -- 起始速度
            },
            {
                path = { "action", 2, "action_delivery", "starting_speed_deviation" }, -- 起始速度偏差
                operation = "Division"
            },
            {
                path = { "action", 2, "cluster_count" }, -- 集群数量
                max_value = 64
            },
            {
                path = { "action", 2, "distance" } -- 距离
            },
            {
                path = { "action", 2, "distance_deviation" } -- 距离偏差
            }
        }
    }
}

-- 胶囊（需要进一步修改烟雾伤害["trivial-smoke"]["poison-capsule-smoke"]）
local data_raw_capsule_catalog = {
    projectile = { -- 胶囊
        orig = {
            "poison-capsule", -- 剧毒胶囊
            "slowdown-capsule", -- 减速胶囊
            "defender-capsule", -- 防御无人机胶囊-defender
            "destroyer-capsule", -- 进攻无人机胶囊-destroyer
            "distractor-capsule", -- 掩护无人机胶囊-distractor
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-capsule-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "acceleration" } -- 加速度
            }
        }
    }
}

-- 战斗机器人
local data_raw_combat_robot_catalog = {
    ["combat-robot"] = { -- 战斗机器人
        orig = {
            "defender", -- 防御无人机
            "destroyer", -- 进攻无人机
            "distractor", -- 掩护无人机
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-combat-robot-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "attack_parameters", "ammo_type", "action", "action_delivery", "target_effects", 2, "damage",
                    "amount" } -- 伤害
            },
            {
                path = { "attack_parameters", "cooldown" }, -- 冷却时间
                operation = "Division"
            },
            {
                path = { "attack_parameters", "cooldown_deviation" }, -- 冷却时间偏差
                operation = "Division"
            },
            {
                path = { "attack_parameters", "projectile_creation_distance" }, -- 抛射物创建距离
            },
            {
                path = { "attack_parameters", "range" }, -- 范围
            },
            {
                path = { "max_health" }, -- 最大生命值
            },
            {
                path = { "range_from_player" }, -- 距离玩家范围
                max_value = 32
            },
            {
                path = { "speed" }, -- 速度
            },
            {
                path = { "time_to_live" }, -- 存活时间
            },
            {
                path = { "attack_parameters", "ammo_type", "action", "action_delivery", "duration" }, -- 持续时间
            },
            {
                path = { "attack_parameters", "ammo_type", "action", "action_delivery", "max_length" }, -- 最大长度
            },
            {
                path = { "attack_parameters", "damage_modifier" }, -- 伤害修正
            }
        }
    }
}

-- 激光
local data_raw_laser_catalog = {
    projectile = { -- 激光
        orig = {
            "laser",
            "blue-laser"
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-ammo-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "acceleration" } -- 加速度
            },
            {
                path = { "action", "action_delivery", "target_effects", 2, "damage", "amount" } -- 伤害
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------抛射物 start------------------\n\n\n")

common_data_raw:execute_modify(data_raw_grenade_catalog)
common_data_raw:execute_modify(data_raw_capsule_catalog)
common_data_raw:execute_modify(data_raw_combat_robot_catalog)
common_data_raw:execute_modify(data_raw_laser_catalog)

log("\n\n\n------------------抛射物 end------------------\n\n\n")
