local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.lib_logger("x-custom-game-armor.lua")

-- data.raw修改目录
local data_raw_armor_catalog = {
    armor = { -- 护甲
        orig = {
            "light-armor", -- 轻型护甲
            "heavy-armor", -- 重型护甲
            "modular-armor", -- 模块装甲
            "power-armor", -- 能量装甲
            "power-armor-mk2", -- 能量装甲MK2
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-armor-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "resistances", 1, "decrease" } -- 物理抗性physical
            }, {
                path = { "resistances", 2, "decrease" } -- 酸抗性acid
            }, {
                path = { "resistances", 3, "decrease" } -- 爆炸抗性explosion
            }, {
                path = { "resistances", 4, "decrease" } -- 火抗性fire
            }, {
                path = { "resistances", 1, "percent" } -- 物理抗性physical
            }, {
                path = { "resistances", 2, "percent" } -- 酸抗性acid
            }, {
                path = { "resistances", 3, "percent" } -- 爆炸抗性explosion
            }, {
                path = { "resistances", 4, "percent" } -- 火抗性fire
            }, {
                path = { "inventory_size_bonus" }, -- 增加库存大小
                max_value = 100
            }
        }
    }
}

-- 装备网格
local data_raw_equipment_grid_catalog = {
    ["equipment-grid"] = { -- 装备网格
        orig = {
            "small-equipment-grid", -- 小型装备网格
            "medium-equipment-grid", -- 中型装备网格
            "large-equipment-grid", -- 大型装备网格
            -- "spidertron-equipment-grid", -- 蜘蛛机甲装备网格
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-armor-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "height" }, -- 高度
                max_value = 16
            }, {
                path = { "width" }, -- 宽度
                max_value = 16
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------护甲 start------------------n\n\n")

common_data_raw:execute_modify(data_raw_armor_catalog)
common_data_raw:execute_modify(data_raw_equipment_grid_catalog)

log("\n\n\n------------------护甲 end------------------n\n\n")
