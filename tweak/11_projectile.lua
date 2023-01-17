local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.lib_logger("x-custom-game-projectile.lua")

-- 手雷
local data_raw_grenade_catalog = {
    projectile = { -- 抛射物
        orig = {
            "grenade", -- 标准手雷
            "cluster-grenade", -- 集束手雷
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-grenade-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "action", 1, "action_delivery", "target_effects", 3, "repeat_count" } -- 重复次数
            }, {
                path = { "action", 1, "action_delivery", "target_effects", 4, "radius" } -- 半径
            }, {
                path = { "action", 2, "action_delivery", "target_effects", 1, "damage", "amount" } -- 伤害
            }, {
                path = { "action", 2, "radius" } -- 爆炸半径
            }, {
                path = { "action", 2, "action_delivery", "starting_speed" } -- 起始速度
            }, {
                path = { "action", 2, "action_delivery", "starting_speed_deviation" }, -- 起始速度偏差
                operation = "Div"
            }, {
                path = { "action", 2, "cluster_count" } -- 集群数量
            }, {
                path = { "action", 2, "distance" } -- 距离
            }, {
                path = { "action", 2, "distance_deviation" } -- 距离
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
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-grenade-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "action", 1, "action_delivery", "target_effects", 2, "repeat_count" } -- 重复次数
            }, {
                path = { "action", 1, "action_delivery", "target_effects", 2, "speed_from_center" }
            }, {
                path = { "action", 1, "action_delivery", "target_effects", 2, "speed_from_center_deviation" }
            }, {
                path = { "smoke", 1, "frequency" } -- 频次
            }, {
                path = { "smoke", 1, "starting_frame" } -- 起始框架
            }, {
                path = { "smoke", 1, "starting_frame_deviation" } -- 起始框架
            }, {
                path = { "smoke", 1, "starting_frame_speed_deviation" } -- 起始框架
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------抛射物 start------------------n\n\n")

common_data_raw:execute_modify(data_raw_grenade_catalog)
common_data_raw:execute_modify(data_raw_capsule_catalog)

log("\n\n\n------------------抛射物 end------------------n\n\n")
