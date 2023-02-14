local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.Log

-- character distance
local data_raw_character_distance_catalog = {
    character = { -- 角色
        orig = {
            "character", -- 角色
        },
        mod = {
            "se-spaceship-enemy-proxy", -- space-exploration
            "se-spaceship-enemy-proxy-jetpack", -- space-exploration
            "character-jetpack", -- jetpack
        },
        mul = settings.startup["x-custom-game-character-distance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "build_distance" } -- 建造距离
            },
            {
                path = { "drop_item_distance" } -- 掉落物品距离
            },
            {
                path = { "item_pickup_distance" } -- 物品提取距离
            },
            {
                path = { "loot_pickup_distance" } -- 捡拾战利品的距离
            },
            {
                path = { "reach_distance" } -- 够到距离
            },
            {
                path = { "reach_resource_distance" } -- 够到资源距离
            }
        }
    }
}

-- character mining speed
local data_raw_character_mining_speed_catalog = {
    character = { -- 角色
        orig = {
            "character", -- 角色
        },
        mod = {
            "se-spaceship-enemy-proxy", -- space-exploration
            "se-spaceship-enemy-proxy-jetpack", -- space-exploration
            "character-jetpack", -- jetpack
        },
        mul = settings.startup["x-custom-game-character-mining-speed-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "mining_speed" } -- 采矿速度
            }
        }
    }
}

-- character running speed
local data_raw_character_running_speed_catalog = {
    character = { -- 角色
        orig = {
            "character", -- 角色
        },
        mod = {
            "se-spaceship-enemy-proxy", -- space-exploration
            "se-spaceship-enemy-proxy-jetpack", -- space-exploration
            "character-jetpack", -- jetpack
        },
        mul = settings.startup["x-custom-game-character-running-speed-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "running_speed" } -- 奔跑速度
            }
        }
    }
}

-- character health
local data_raw_character_health_catalog = {
    character = { -- 角色
        orig = {
            "character", -- 角色
        },
        mod = {
            "se-spaceship-enemy-proxy", -- space-exploration
            "se-spaceship-enemy-proxy-jetpack", -- space-exploration
            "character-jetpack", -- jetpack
        },
        mul = settings.startup["x-custom-game-character-health-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "max_health" }, -- 最大血量
                max_value = 5000
            },
            {
                path = { "healing_per_tick" } -- 血量恢复
            }
        }
    }
}

-- character inventory_size
local data_raw_character_inventory_size_catalog = {
    character = { -- 角色
        orig = {
            "character", -- 角色
        },
        mod = {
            "se-spaceship-enemy-proxy", -- space-exploration
            "se-spaceship-enemy-proxy-jetpack", -- space-exploration
            "character-jetpack", -- jetpack
        },
        mul = settings.startup["x-custom-game-character-inventory-size-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "inventory_size" } -- 角色库存
            }
        }
    }
}

-- character collision_box
local setting_value = settings.startup["x-custom-game-character-collision-box-multiplier"].value
-- local setting_value = "50%"
local function get_collision_box()
    local mul = 1.0
    if setting_value == "100%" then
        mul = 1.0
    elseif setting_value == "75%" then
        mul = 0.75
    elseif setting_value == "50%" then
        mul = 0.5
    elseif setting_value == "25%" then
        mul = 0.25
    elseif setting_value == "0%" then
        mul = 0.0
    end

    local box = data.raw["character"]["character"]["collision_box"]
    return { { box[1][1] * mul, box[1][2] * mul },
        { box[2][1] * mul, box[2][2] * mul } }
end

local new_collision_box = get_collision_box()
local data_raw_character_collision_box_catalog = {
    character = { -- 角色
        orig = {
            "character", -- 角色
        },
        mod = {
            "se-spaceship-enemy-proxy", -- space-exploration
            "se-spaceship-enemy-proxy-jetpack", -- space-exploration
            "character-jetpack", -- jetpack
        },
        modify_parameter = { -- 修改参数
            {
                path = { "collision_box" }, -- 碰撞盒子
                value = new_collision_box
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------Character start------------------\n\n\n")

common_data_raw:execute_modify(data_raw_character_distance_catalog)
common_data_raw:execute_modify(data_raw_character_mining_speed_catalog)
common_data_raw:execute_modify(data_raw_character_running_speed_catalog)
common_data_raw:execute_modify(data_raw_character_health_catalog)
common_data_raw:execute_modify(data_raw_character_inventory_size_catalog)
common_data_raw:execute_modify(data_raw_character_collision_box_catalog)

log("\n\n\n------------------Character end------------------\n\n\n")
