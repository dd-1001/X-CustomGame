local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.Log

-- 燃料
local data_raw_fuel_value_catalog = {
    item = { -- 固体燃料
        orig = {
            "wood", -- 木板
            "coal", -- 煤矿
            "solid-fuel", -- 固体燃料
            "rocket-fuel", -- 火箭燃料
            "nuclear-fuel", -- 核能燃料
            "uranium-fuel-cell" -- 铀燃料棒
        },
        mod = {
            "processed-fuel", -- aai-industry
            "giga-fuel", -- fast_trans
            "giga-fuel-mk2",
            "giga-fuel-mk3", -- fast_trans
            "wooden-chest", -- Krastorio2
            "small-electric-pole",
            "biomass",
            "coke",
            "fuel",
            "bio-fuel",
            "advanced-fuel",
            "dt-fuel",
            "charged-antimatter-fuel-cell", -- Krastorio2
        },
        mul = settings.startup["x-custom-game-fuel-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "fuel_value" } -- 热值
            }
        }
    },
    fluid = { -- 流体燃料
        mod = {
            "crude-oil", -- 原油
            "heavy-oil", -- 重油
            "light-oil", -- 轻油
            "petroleum-gas", -- 石油气
            "biomethanol", -- Krastorio2
        },
        mul = settings.startup["x-custom-game-fuel-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "fuel_value" } -- 热值
            }
        }
    }
}

-- 发射卫星带回的资源
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
log("\n\n\n------------------Resource start------------------\n\n\n")

common_data_raw:execute_modify(data_raw_fuel_value_catalog)
common_data_raw:execute_modify(data_raw_satellite_catalog)

if X_CUSTOM_GAME_IS_DEBUG then
    -- 找出含有热值，但没被修改的项目
    local item_with_fuel_value = common_data_raw:find_item_with_key_word("fuel_value")
    -- log("resource with fuel_value list: \n" .. common_core:serpent_block(item_with_fuel_value))

    local tab_record = common_data_raw:check_not_in_record("source", item_with_fuel_value)
    log("Unmod resource with fuel_value list: \n" .. common_core:serpent_block(tab_record))
end


log("\n\n\n------------------Resource end------------------\n\n\n")
