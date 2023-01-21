local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.lib_logger("x-custom-game-container.lua")

-- 容器
local data_raw_container_catalog = {
    container = { -- 箱子
        orig = {
            "wooden-chest", -- 木制箱
            "iron-chest", -- 铁制箱
            "steel-chest", -- 钢制箱
        },
        mod = {
            "aai-strongbox", -- aai-containers start
            "aai-storehouse",
            "aai-warehouse", -- aai-containers end
        },
        mul = settings.startup["x-custom-game-container-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "inventory_size" }, -- 库存大小
                max_value = 2000
            }, {
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
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    ["storage-tank"] = { -- 储液罐
        orig = {
            "storage-tank" -- 储液罐
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-storage-tank-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "fluid_box", "base_area" }, -- 流体箱的总流体容量为 base_area × height × 100
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    ["cargo-wagon"] = { -- 货运车厢
        orig = {
            "cargo-wagon" -- 货运车厢
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-locomotive-inventory-size-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "inventory_size" } -- 货车库存的大小
            }, {
                path = { "max_speed" } -- 最大速度
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    ["fluid-wagon"] = { -- 液罐车厢
        orig = {
            "fluid-wagon" -- 液罐车厢
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-locomotive-inventory-size-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "capacity" } -- 容量
            }, {
                path = { "max_speed" } -- 最大速度
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------容器 start------------------n\n\n")

common_data_raw:execute_modify(data_raw_container_catalog)

log("\n\n\n------------------容器 end------------------n\n\n")
