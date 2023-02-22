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
            -- "rocket-fuel", -- 火箭燃料(space-exploration会检测它的热值，这里不做修改。下面加入调试模式做修改)
            "nuclear-fuel", -- 核能燃料
            "uranium-fuel-cell" -- 铀燃料棒
        },
        mod = {
            "lighted-small-electric-pole", -- LightedPolesPlus
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
            "se-antimatter-canister", -- space-exploration
            "se-vitamelange",
            "se-vitamelange-nugget",
            "se-vitamelange-bloom",
            "se-vitamelange-spice",
            "se-vitamelange-extract",
            "se-vulcanite",
            "se-vulcanite-crushed",
            "se-vulcanite-enriched",
            "se-vulcanite-block", -- space-exploration
        },
        mul = settings.startup["x-custom-game-fuel-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "fuel_value" } -- 热值
            },
            {
                path = { "fuel_acceleration_multiplier" } -- 载具加速
            },
            {
                path = { "fuel_top_speed_multiplier" } -- 载具速度上限
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
            "se-liquid-rocket-fuel", -- space-exploration
            "se-antimatter-stream", -- space-exploration
        },
        mul = settings.startup["x-custom-game-fuel-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "fuel_value" } -- 热值
            }
        }
    }
}

-- 调试模式加入修改火箭燃料的热值（需修改space-exploration_0.6.101\scripts\essential.lua:Essential.detect_breaking_prototypes()，让它直接return）
if X_CUSTOM_GAME_IS_DEBUG or
    not mods["space-exploration"] then
    table.insert(data_raw_fuel_value_catalog.item.orig, "rocket-fuel")
end

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
                max_value = 60000
            }
        }
    }
}

-- 资源
local data_raw_resource_catalog = {
    resource = {
        orig = {
            "coal", -- 煤矿
            "iron-ore", -- 铁矿
            "copper-ore", -- 铜矿
            "stone", -- 石矿
            "uranium-ore", -- 铀矿
            "crude-oil", -- 原油
        },
        mod = {
            "mineral-water", -- Krastorio2
            "imersite", -- Krastorio2
            "se-water-ice", -- space-exploration
            "se-methane-ice",
            "se-beryllium-ore",
            "se-cryonite",
            "se-holmium-ore",
            "se-iridium-ore",
            "se-naquium-ore",
            "se-vulcanite",
            "se-vitamelange", -- space-exploration
        },
        modify_parameter = {
            -- {
            --     path = { "infinite" }, -- 无限开采
            --     operation = "Extend",
            --     value = true
            -- },
            -- {
            --     path = { "minimum" }, -- 当.infinite = true时，必须不是0
            --     operation = "Extend",
            --     value = 100
            -- },
            -- {
            --     path = { "normal" }, -- 当.infinite = true时，必须不是0
            --     operation = "Extend",
            --     value = 100
            -- },
            {
                path = { "infinite_depletion_amount" }, -- 无限资源的损耗量
                operation = "Extend",
                value = 0
            },
            {
                path = { "stage_counts" }, -- 阶段_计数
                value = { 0 },
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------Resource start------------------\n\n\n")

common_data_raw:execute_modify(data_raw_fuel_value_catalog)
common_data_raw:execute_modify(data_raw_satellite_catalog)

if settings.startup["x-custom-game-infinite-resources-flag"].value then
    common_data_raw:execute_modify(data_raw_resource_catalog)
end

if X_CUSTOM_GAME_IS_DEBUG then
    -- 找出含有热值，但没被修改的项目
    local item_with_fuel_value = common_data_raw:find_item_with_key_word("fuel_value")
    -- log("resource with fuel_value list: \n" .. common_core:serpent_block(item_with_fuel_value))

    local tab_record = common_data_raw:check_not_in_record("source", item_with_fuel_value)
    if table_size(tab_record) > 0 then
        log("Unmod resource with fuel_value list: \n" .. common_core:serpent_block(tab_record))
    end
end


log("\n\n\n------------------Resource end------------------\n\n\n")
