local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.Log

-- 燃料的热值
local data_raw_fuel_catalog = {
    item = { -- 燃料的热值
        orig = {
            "wood", -- 木板
            "coal", -- 煤矿
            "solid-fuel", -- 固体燃料
            "rocket-fuel", -- 火箭燃料
            "nuclear-fuel", -- 核能燃料
            "uranium-fuel-cell" -- 铀燃料棒
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-fuel-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "fuel_value" } -- 热值
            }
        }
    },
    fluid = { -- 流体燃料
        orig = {
            "crude-oil", -- 原油
            "heavy-oil", -- 重油
            "light-oil", -- 轻油
            "petroleum-gas" -- 石油气
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-fuel-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "fuel_value" } -- 热值
            }
        }
    }
}

local data_raw_satellite_catalog = {
    item = { -- 卫星
        orig = {
            "satellite" -- 卫星
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-satellite-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "rocket_launch_product", 2 }, -- 火箭_发射_产品
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------Item start------------------\n\n\n")

common_data_raw:execute_modify(data_raw_fuel_catalog)
common_data_raw:execute_modify(data_raw_satellite_catalog)

log("\n\n\n------------------Item end------------------\n\n\n")
