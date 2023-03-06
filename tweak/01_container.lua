local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.Log

-- 容器
local data_raw_container_catalog = {
    container = { -- 箱子
        orig = {
            "wooden-chest", -- 木制箱
            "iron-chest", -- 铁制箱
            "steel-chest", -- 钢制箱
        },
        mod = {
            "se-cargo-rocket-cargo-pod", -- space-exploration
            "se-rocket-landing-pad",
            "se-rocket-launch-pad",
            "se-space-capsule",
            "se-space-capsule-scorched",
            "se-cartouche-chest",
            "se-delivery-cannon-chest", -- space-exploration
            "kr-medium-container", -- Krastorio2
            "kr-big-container", -- Krastorio2
            "aai-strongbox", -- aai-containers start
            "aai-storehouse",
            "aai-warehouse", -- aai-containers end
        },
        mul = settings.startup["x-custom-game-container-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "inventory_size" }, -- 库存大小
                max_value = 2000
            },
            {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    ["logistic-container"] = { -- 物流箱子
        orig = {
            "logistic-chest-active-provider", -- 主动供货箱(紫箱)
            "logistic-chest-buffer", -- 主动存货箱(绿箱)
            "logistic-chest-passive-provider", -- 被动供货箱(红箱)
            "logistic-chest-requester", -- 优先集货箱(蓝箱)
            "logistic-chest-storage", -- 被动存货箱(黄箱)
        },
        mod = {
            "kr-medium-active-provider-container", -- Krastorio2
            "kr-medium-buffer-container",
            "kr-medium-passive-provider-container",
            "kr-medium-requester-container",
            "kr-medium-storage-container",
            "kr-big-active-provider-container",
            "kr-big-buffer-container",
            "kr-big-passive-provider-container",
            "kr-big-requester-container",
            "kr-big-storage-container", -- Krastorio2
            "logistic-chest-passive-provider-2", -- boblogistics
            "logistic-chest-active-provider-2",
            "logistic-chest-storage-2",
            "logistic-chest-buffer-2",
            "logistic-chest-requester-2",
            "logistic-chest-passive-provider-3",
            "logistic-chest-active-provider-3",
            "logistic-chest-storage-3",
            "logistic-chest-buffer-3",
            "logistic-chest-requester-3", -- boblogistics
            "aai-strongbox-passive-provider", -- aai-containers start
            "aai-strongbox-active-provider",
            "aai-strongbox-storage",
            "aai-strongbox-buffer",
            "aai-strongbox-requester",
            "aai-storehouse-passive-provider",
            "aai-storehouse-active-provider",
            "aai-storehouse-storage",
            "aai-storehouse-buffer",
            "aai-storehouse-requester",
            "aai-warehouse-passive-provider",
            "aai-warehouse-active-provider",
            "aai-warehouse-storage",
            "aai-warehouse-buffer",
            "aai-warehouse-requester", -- aai-containers end
        },
        mul = settings.startup["x-custom-game-container-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "inventory_size" }, -- 库存大小
                max_value = 2000
            },
            {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    ["storage-tank"] = { -- 储液罐
        orig = {
            "storage-tank" -- 储液罐
        },
        mod = {
            "se-spaceship-rocket-booster-tank", -- space-exploration
            "se-spaceship-ion-booster-tank",
            "se-spaceship-antimatter-booster-tank",
            "se-space-pipe-long-j-3",
            "se-space-pipe-long-j-5",
            "se-space-pipe-long-j-7",
            "se-space-pipe-long-s-9",
            "se-space-pipe-long-s-15", -- space-exploration
            "kr-fluid-storage-1", -- Krastorio2
            "kr-fluid-storage-2", -- Krastorio2
            "storage-tank-2", -- boblogistics
            "storage-tank-3",
            "storage-tank-4",
            "bob-storage-tank-all-corners",
            "bob-storage-tank-all-corners-2",
            "bob-storage-tank-all-corners-3",
            "bob-storage-tank-all-corners-4",
            "bob-valve",
            "bob-overflow-valve",
            "bob-topup-valve", -- boblogistics
            "large-storage-tank-rampant-industry", -- RampantIndustry
        },
        mul = settings.startup["x-custom-game-storage-tank-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "fluid_box", "base_area" }, -- 流体箱的总流体容量为 base_area × height × 100
            },
            {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    ["cargo-wagon"] = { -- 货运车厢
        orig = {
            "cargo-wagon" -- 货运车厢
        },
        mod = {
            "cargo-wagon-immortal-mk2", -- fast_trans
            "cargo-wagon-immortal-mk3", -- fast_trans
            "bob-cargo-wagon-2", -- boblogistics
            "bob-cargo-wagon-3",
            "bob-armoured-cargo-wagon",
            "bob-armoured-cargo-wagon-2" -- boblogistics
        },
        mul = settings.startup["x-custom-game-locomotive-inventory-size-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "inventory_size" } -- 货车库存的大小
            },
            {
                path = { "max_speed" } -- 最大速度
            },
            {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    ["fluid-wagon"] = { -- 液罐车厢
        orig = {
            "fluid-wagon" -- 液罐车厢
        },
        mod = {
            "fluid-wagon-immortal-mk2", -- fast_trans
            "fluid-wagon-immortal-mk3", -- fast_trans
            "bob-fluid-wagon-2", -- boblogistics
            "bob-fluid-wagon-3",
            "bob-armoured-fluid-wagon",
            "bob-armoured-fluid-wagon-2" -- boblogistics
        },
        mul = settings.startup["x-custom-game-locomotive-inventory-size-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "capacity" } -- 容量
            },
            {
                path = { "max_speed" } -- 最大速度
            },
            {
                path = { "max_health" } -- 最大血量
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------容器 start------------------\n\n\n")

common_data_raw:execute_modify(data_raw_container_catalog)

log("\n\n\n------------------容器 end------------------\n\n\n")
