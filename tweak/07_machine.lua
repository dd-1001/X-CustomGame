local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.Log

-- 采矿-钻探
local data_raw_machine_catalog = {
    ["mining-drill"] = { -- 采矿-钻探
        orig = {
            "burner-mining-drill", -- 热能采矿机
            "electric-mining-drill", -- 电力采矿机
            "pumpjack" -- 抽油机
        },
        mod = {
            "se-core-miner-drill", -- space-exploration
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
            },
            {
                path = { "energy_source", "emissions_per_minute" }, -- 每分钟产生污染量
                operation = "Division"
            },
            {
                path = { "energy_usage" }, -- 能源消耗量
                operation = "Division"
            },
            {
                path = { "mining_speed" } -- 采矿速度
            },
            {
                path = { "output_fluid_box", "base_area" }, -- 流体箱的总流体容量：base_area × height × 100
                max_value = 100
            },
            {
                path = { "input_fluid_box", "height" }, -- 流体箱的总流体容量：base_area × height × 100
                max_value = 10
            },
            {
                path = { "module_specification", "module_slots" }, -- 模块插槽数
                value = settings.startup["x-custom-game-number-of-module-slots"].value
            },
            {
                path = { "base_productivity" }, -- 基础产能加成
                operation = "Extend",
                value = settings.startup["x-custom-game-mining-drill-performance-multiplier"].value
            },
            {
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
            "se-condenser-turbine", -- space-exploration
            "se-big-turbine", -- space-exploration
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
            },
            {
                path = { "energy_source", "effectivity" } -- 能源使用效率
            },
            {
                path = { "energy_source", "emissions_per_minute" }, -- 每分钟产生污染量
                operation = "Division"
            },
            {
                path = { "energy_usage" }, -- 能源消耗量
                operation = "Division"
            },
            {
                path = { "module_specification", "module_slots" }, -- 模块插槽数
                value = settings.startup["x-custom-game-number-of-module-slots"].value
            },
            {
                path = { "base_productivity" }, -- 基础产能加成
                operation = "Extend",
                value = settings.startup["x-custom-game-furnace-performance-multiplier"].value
            },
            {
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
            "se-casting-machine", -- space-exploration
            "se-space-astrometrics-laboratory",
            "se-space-gravimetrics-laboratory",
            "se-space-decontamination-facility",
            "se-lifesupport-facility",
            "se-fuel-refinery",
            "se-space-genetics-laboratory",
            "se-space-growth-facility",
            "se-space-laser-laboratory",
            "se-space-radiation-laboratory",
            "se-space-thermodynamics-laboratory",
            "se-recycling-facility",
            "se-space-mechanical-laboratory",
            "se-pulveriser",
            "se-space-particle-accelerator",
            "se-space-particle-collider",
            "se-space-material-fabricator",
            "se-space-biochemical-laboratory",
            "se-space-electromagnetics-laboratory",
            "se-space-hypercooler",
            "se-space-assembling-machine",
            "se-space-manufactory",
            "se-space-plasma-generator",
            "se-space-radiator",
            "se-space-radiator-2",
            "se-space-supercomputer-1",
            "se-space-supercomputer-2",
            "se-space-supercomputer-3",
            "se-space-supercomputer-4",
            "se-space-telescope",
            "se-space-telescope-xray",
            "se-space-telescope-gammaray",
            "se-space-telescope-microwave",
            "se-space-telescope-radio",
            "se-delivery-cannon",
            "se-electric-boiler",
            "se-energy-transmitter-emitter",
            "se-energy-transmitter-injector",
            "se-nexus",
            "se-space-elevator",
            "kr-atmospheric-condenser-_-waterless",
            "se-space-decontamination-facility-grounded",
            "se-fuel-refinery-spaced",
            "se-space-laser-laboratory-grounded",
            "se-space-radiation-laboratory-grounded",
            "se-space-thermodynamics-laboratory-grounded",
            "se-space-mechanical-laboratory-grounded",
            "se-space-particle-accelerator-grounded",
            "se-space-biochemical-laboratory-grounded",
            "se-space-hypercooler-grounded",
            "se-space-assembling-machine-grounded",
            "se-space-manufactory-grounded",
            "se-space-radiator-grounded",
            "se-space-radiator-2-grounded",
            "se-space-supercomputer-1-grounded",
            "se-space-supercomputer-2-grounded",
            "se-space-supercomputer-3-grounded",
            "se-space-supercomputer-4-grounded", -- space-exploration
            "equipment-gantry", -- equipment-gantry
            "equipment-gantry-remover", -- equipment-gantry
            "kr-advanced-chemical-plant", -- Krastorio2
            "kr-advanced-furnace",
            "kr-atmospheric-condenser",
            "kr-bio-lab",
            "kr-electrolysis-plant",
            "kr-electrolysis-plant-spaced",
            "kr-filtration-plant",
            "kr-fuel-refinery",
            "kr-fuel-refinery-spaced",
            "kr-fusion-reactor",
            "kr-greenhouse",
            "kr-matter-assembler",
            "kr-matter-assembler-spaced",
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
            "industrial-furnace", -- aai-industry end
            "air-filter-rampant-industry", -- RampantIndustry
            "air-filter-2-rampant-industry",
            "advanced-oil-refinery-rampant-industry",
            "advanced-assembler-rampant-industry",
            "advanced-chemical-plant-rampant-industry",
            "advanced-furnace-rampant-industry",
            "advanced-electric-furnace-rampant-industry", -- RampantIndustry
        },
        mul = settings.startup["x-custom-game-assembling-machine-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "crafting_speed" } -- 制造速度
            },
            {
                path = { "energy_source", "emissions_per_minute" }, -- 每分钟产生污染量
                operation = "Division"
            },
            {
                path = { "energy_usage" }, -- 能源消耗量
                operation = "Division"
            },
            {
                path = { "module_specification", "module_slots" }, -- 模块插槽数
                value = settings.startup["x-custom-game-number-of-module-slots"].value
            },
            {
                path = { "base_productivity" }, -- 基础产能加成
                operation = "Extend",
                value = settings.startup["x-custom-game-assembling-machine-performance-multiplier"].value
            },
            {
                path = { "max_health" } -- 最大血量
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------生产机器 start------------------\n\n\n")

if settings.startup["x-custom-game-affects-other-untested-mod-flags"].value then
    common_data_raw:add_other_untested_list(data_raw_machine_catalog)
end
common_data_raw:execute_modify(data_raw_machine_catalog)

log("\n\n\n------------------生产机器 end------------------\n\n\n")
