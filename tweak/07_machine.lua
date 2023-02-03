local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.lib_logger("x-custom-game-machine.lua")

-- 采矿-钻探
local data_raw_machine_catalog = {
    ["mining-drill"] = { -- 采矿-钻探
        orig = {
            "burner-mining-drill", -- 热能采矿机
            "electric-mining-drill", -- 电力采矿机
            "pumpjack" -- 抽油机
        },
        mod = {
            "kr-mineral-water-pumpjack", -- Krastorio2
            "kr-quarry-drill",
            "kr-electric-mining-drill-mk2",
            "kr-electric-mining-drill-mk3", -- Krastorio2
            "bob-mining-drill-1", -- bobmining
            "bob-mining-drill-2",
            "bob-mining-drill-3",
            "bob-mining-drill-4",
            "bob-area-mining-drill-1",
            "bob-area-mining-drill-2",
            "bob-area-mining-drill-3",
            "bob-area-mining-drill-4",
            "bob-pumpjack-1",
            "bob-pumpjack-2",
            "bob-pumpjack-3",
            "bob-pumpjack-4",
            "steam-mining-drill", -- bobmining
            "area-mining-drill", -- aai-industry
        },
        mul = settings.startup["x-custom-game-mining-drill-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "energy_source", "effectivity" } -- 能源利用效率
            }, {
                path = { "energy_source", "emissions_per_minute" }, -- 每分钟产生污染量
                operation = "Division"
            }, {
                path = { "energy_source", "fuel_inventory_size" } -- 燃料库存
            }, {
                path = { "energy_usage" }, -- 能源消耗量
                operation = "Division"
            }, {
                path = { "mining_speed" } -- 采矿速度
            }, {
                path = { "output_fluid_box", "base_area" }, -- 流体箱的总流体容量：base_area × height × 100
                max_value = 100
            }, {
                path = { "input_fluid_box", "height" }, -- 流体箱的总流体容量：base_area × height × 100
                max_value = 10
            }, {
                path = { "module_specification", "module_slots" }, -- 模块插槽数
                value = settings.startup["x-custom-game-number-of-module-slots"].value
            }, {
                path = { "base_productivity" }, -- 基础产能加成
                operation = "Extend",
                value = settings.startup["x-custom-game-mining-drill-performance-multiplier"].value
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    furnace = { -- 熔炉
        orig = {
            "stone-furnace", -- 石炉
            "steel-furnace", -- 钢炉
            "electric-furnace" -- 电炉
        },
        mod = {
            "flare-stack", -- Flare Stack
            "incinerator",
            "electric-incinerator",
            "vent-stack", -- Flare Stack
            "kr-crusher", -- Krastorio2
            "kr-fluid-burner",
            "kr-stabilizer-charging-station", -- Krastorio2
            "electric-furnace-2", -- bobassembly
            "electric-furnace-3",
            "fluid-furnace" -- bobassembly
        },
        mul = settings.startup["x-custom-game-furnace-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "crafting_speed" } -- 制造速度
            }, {
                path = { "energy_source", "effectivity" } -- 能源使用效率
            }, {
                path = { "energy_source", "emissions_per_minute" }, -- 每分钟产生污染量
                operation = "Division"
            }, {
                path = { "energy_source", "fuel_inventory_size" } -- 燃料库存
            }, {
                path = { "energy_usage" }, -- 能源消耗量
                operation = "Division"
            }, {
                path = { "module_specification", "module_slots" }, -- 模块插槽数
                value = settings.startup["x-custom-game-number-of-module-slots"].value
            }, {
                path = { "base_productivity" }, -- 基础产能加成
                operation = "Extend",
                value = settings.startup["x-custom-game-furnace-performance-multiplier"].value
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    ["assembling-machine"] = { -- 装配机
        orig = {
            "assembling-machine-1", -- 组装机1型
            "assembling-machine-2", -- 组装机2型
            "assembling-machine-3", -- 组装机3型
            "centrifuge", -- 离心机
            "chemical-plant", -- 化工厂
            "oil-refinery" -- 炼油厂
        },
        mod = {
            "kr-advanced-chemical-plant", -- Krastorio2
            "kr-advanced-furnace",
            "kr-atmospheric-condenser",
            "kr-bio-lab",
            "kr-electrolysis-plant",
            "kr-filtration-plant",
            "kr-fuel-refinery",
            "kr-fusion-reactor",
            "kr-greenhouse",
            "kr-matter-assembler",
            "kr-matter-plant",
            "kr-quantum-computer",
            "kr-research-server",
            "kr-advanced-assembling-machine",
            "stone-furnace",
            "electric-furnace",
            "electric-furnace-2",
            "electric-furnace-3",
            "steel-furnace",
            "fluid-furnace", -- Krastorio2
            "assembling-machine-4", -- bobassembly
            "assembling-machine-5",
            "assembling-machine-6",
            "electronics-machine-1",
            "electronics-machine-2",
            "electronics-machine-3",
            "steam-assembling-machine",
            "oil-refinery-2",
            "oil-refinery-3",
            "oil-refinery-4",
            "chemical-plant-2",
            "chemical-plant-3",
            "chemical-plant-4",
            "centrifuge-2",
            "centrifuge-3", -- bobassembly
            "burner-assembling-machine", -- aai-industry start
            "fuel-processor",
            "industrial-furnace" -- aai-industry end
        },
        mul = settings.startup["x-custom-game-assembling-machine-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "crafting_speed" } -- 制造速度
            }, {
                path = { "energy_source", "emissions_per_minute" }, -- 每分钟产生污染量
                operation = "Division"
            }, {
                path = { "energy_usage" }, -- 能源消耗量
                operation = "Division"
            }, {
                path = { "module_specification", "module_slots" }, -- 模块插槽数
                value = settings.startup["x-custom-game-number-of-module-slots"].value
            }, {
                path = { "base_productivity" }, -- 基础产能加成
                operation = "Extend",
                value = settings.startup["x-custom-game-assembling-machine-performance-multiplier"].value
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------生产机器 start------------------n\n\n")

common_data_raw:execute_modify(data_raw_machine_catalog)

log("\n\n\n------------------生产机器 end------------------n\n\n")
