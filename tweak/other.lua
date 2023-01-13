local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.lib_logger("x-custom-game-other.lua")

-- data.raw修改目录
local data_raw_other_catalog = {
    locomotive = { -- 机车
        orig = {
            "locomotive" -- 内燃机车
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-locomotive-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "burner", "effectivity" } -- 内燃机效率
            }, {
                path = { "max_power" } -- 最大动力
            }, {
                path = { "max_speed" } -- 最大速度
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
            }
        }
    },
    ["repair-tool"] = { -- 修理工具
        orig = {
            "repair-pack" -- 修理包
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-repair-tool-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "durability" } -- 此工具的耐用性
            }, {
                path = { "speed" } -- 修理速度
            }
        }
    },
    container = { -- 箱子
        orig = {
            "wooden-chest", -- 木制箱
            "iron-chest", -- 铁制箱
            "steel-chest", -- 钢制箱
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-container-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "inventory_size" } -- 库存大小
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------其他 start------------------n\n\n")

common_data_raw:execute_modify(data_raw_other_catalog)

log("\n\n\n------------------其他 end------------------n\n\n")
