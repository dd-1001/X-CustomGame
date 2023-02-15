local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.Log

-- 电力生产相关目录
local data_raw_production_catalog = {
    boiler = { -- 锅炉
        orig = {
            "boiler", -- 锅炉
            "heat-exchanger" -- 换热器
        },
        mod = {
            "se-naquium-heat-pipe-long--+--", -- space-exploration
            "se-naquium-heat-pipe-long--+-----+--",
            "se-big-heat-exchanger",
            "se-energy-transmitter-chamber", -- space-exploration
            "boiler-2", -- bobpower
            "boiler-3",
            "boiler-4",
            "boiler-5",
            "oil-boiler",
            "oil-boiler-2",
            "oil-boiler-3",
            "oil-boiler-4",
            "heat-exchanger-2",
            "heat-exchanger-3",
            "heat-exchanger-4" -- bobpower
        },
        mul = settings.startup["x-custom-game-boiler-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "energy_consumption" } -- 能量消耗
            },
            {
                path = { "energy_source", "effectivity" } -- 可选。1意味着100%的效果。必须大于0。 能量输出的乘数。
            },
            {
                path = { "energy_source", "emissions_per_minute" }, -- 可选的。一个实体在全能量消耗下每分钟排放的污染。正是实体工具提示中显示的值。
                operation = "Division" -- Mul 做乘法， Division 做除法
            },
            {
                path = { "energy_source", "max_transfer" } -- 最大传输量
            },
            {
                path = { "energy_source", "specific_heat" }, -- 比热容。吸收能量的多少
                operation = "Division"
            },
            {
                path = { "fluid_box", "height" } -- 必须大于0。液箱的总液体容量为base_area × height × 100
            },
            {
                path = { "output_fluid_box", "height" } -- 必须大于0。液箱的总液体容量为base_area × height × 100
            },
            {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    generator = { -- 发电机
        orig = {
            "steam-engine", -- 蒸汽机
            "steam-turbine" -- 汽轮机
        },
        mod = {
            "se-condenser-turbine-generator", -- space-exploration
            "se-fluid-burner-generator",
            "se-big-turbine-generator-NW",
            "se-big-turbine-generator-SE", -- space-exploration
            "kr-advanced-steam-turbine", -- Krastorio2
            "kr-gas-power-station", -- Krastorio2
            "steam-engine-2", -- bobpower
            "steam-engine-3",
            "steam-engine-4",
            "steam-engine-5",
            "steam-turbine-2",
            "steam-turbine-3",
            "fluid-generator",
            "fluid-generator-2",
            "fluid-generator-3", -- bobpower
            "basic-fluid-generator-rampant-industry", -- RampantIndustry
        },
        mul = settings.startup["x-custom-game-generator-performance-multiplier"].value,
        modify_parameter = {
            {
                path = { "effectivity" } -- 效率
            },
            {
                path = { "fluid_box", "height" }
            },
            {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    ["burner-generator"] = { -- 燃料发电机
        mod = {
            "kr-antimatter-reactor", -- Krastorio2
            "bob-burner-generator", -- bobpower
            "burner-turbine", -- aai-industry
        },
        mul = settings.startup["x-custom-game-generator-performance-multiplier"].value,
        modify_parameter = {
            {
                path = { "burner", "effectivity" }
            },
            {
                path = { "burner", "emissions_per_minute" },
                operation = "Division"
            },
            {
                path = { "max_power_output" }
            }
        }
    },
    ["solar-panel"] = { -- 太阳能板
        orig             = {
            "solar-panel" -- 太阳能板
        },
        mod              = {
            "se-space-solar-panel", -- space-exploration
            "se-space-solar-panel-2",
            "se-space-solar-panel-3", -- space-exploration
            "kr-advanced-solar-panel", -- Krastorio2
            "solar-panel-small", -- bobpower
            "solar-panel-large",
            "solar-panel-small-2",
            "solar-panel-2",
            "solar-panel-large-2",
            "solar-panel-small-3",
            "solar-panel-3",
            "solar-panel-large-3", -- bobpower
            "advanced-solar", -- Advanced-Electric-Revamped-v16
            "elite-solar",
            "ultimate-solar", -- Advanced-Electric-Revamped-v16
            "advanced-solar-panel-rampant-industry", -- RampantIndustry
        },
        mul              = settings.startup["x-custom-game-solar-panel-performance-multiplier"].value,
        modify_parameter = {
            {
                path = { "production" } -- 发电量
            },
            {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    accumulator = { -- 蓄电池
        orig             = {
            "accumulator" -- 蓄电池
        },
        mod              = {
            "kr-energy-storage", -- Krastorio2
            "fast-accumulator", -- bobpower
            "slow-accumulator",
            "large-accumulator-2",
            "fast-accumulator-2",
            "slow-accumulator-2",
            "large-accumulator-3",
            "fast-accumulator-3",
            "slow-accumulator-3", -- bobpower
            "advanced-accumulator", -- Advanced-Electric-Revamped-v16
            "elite-accumulator",
            "ultimate-accumulator", -- Advanced-Electric-Revamped-v16
            "se-space-accumulator", -- space-exploration
            "se-space-accumulator-2", -- space-exploration
            "advanced-accumulator-rampant-industry", -- RampantIndustry
        },
        mul              = settings.startup["x-custom-game-accumulator-performance-multiplier"].value,
        modify_parameter = {
            {
                path = { "energy_source", "buffer_capacity" } -- 电池容量
            },
            {
                path = { "energy_source", "input_flow_limit" } -- 电池输入限制
            },
            {
                path = { "energy_source", "output_flow_limit" } -- 电池输出限制
            },
            {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    reactor = { -- 核反应堆
        orig             = {
            "nuclear-reactor" -- 核反应堆
        },
        mod              = {
            "se-antimatter-reactor", -- space-exploration
            "se-energy-transmitter-injector-reactor",
            "se-energy-receiver", -- space-exploration
            "burner-reactor", -- bobpower
            "burner-reactor-2",
            "fluid-reactor",
            "fluid-reactor-2",
            "nuclear-reactor-2",
            "nuclear-reactor-3" -- bobpower
        },
        mul              = settings.startup["x-custom-game-reactor-performance-multiplier"].value,
        modify_parameter = {
            {
                path = { "consumption" } -- 能量消耗量
            },
            {
                path = { "energy_source", "effectivity" } -- 效率
            },
            {
                path = { "heat_buffer", "max_temperature" } -- 最高温度
            },
            {
                path = { "heat_buffer", "max_transfer" } -- 最大传输量
            },
            {
                path = { "heat_buffer", "specific_heat" }, -- 比热容
                operation = "Division"
            },
            {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    ["heat-pipe"] = { -- 热管
        orig             = {
            "heat-pipe" -- 核反应堆
        },
        mod              = {
            "se-naquium-heat-pipe", -- space-exploration
            "heat-pipe-2", -- bobpower
            "heat-pipe-3",
            "heat-pipe-4" -- bobpower
        },
        mul              = settings.startup["x-custom-game-heat-pipe-performance-multiplier"].value,
        modify_parameter = {
            {
                path = { "heat_buffer", "max_temperature" } -- 最高温度
            },
            {
                path = { "heat_buffer", "max_transfer" } -- 最大传输量
            },
            {
                path = { "heat_buffer", "specific_heat" }, -- 比热容
                operation = "Division"
            },
            {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    ["electric-energy-interface"] = { -- 电能接口
        orig             = {
            "electric-energy-interface", -- 电能接口
            "hidden-electric-energy-interface" -- 隐藏电能接口
        },
        mod              = {
            "kr-wind-turbine", -- Krastorio2
            "kr-activated-intergalactic-transceiver",
            "kr-crash-site-generator",
            "kr-logo",
            "kr-shelter",
            "kr-shelter-plus",
            "kr-tesla-coil", -- Krastorio2
        },
        mul              = settings.startup["x-custom-game-electric-energy-interface-multiplier"].value,
        modify_parameter = {
            {
                path = { "energy_production" } -- 能源生产
            },
            {
                path = { "energy_source", "buffer_capacity" } -- 容量
            },
            {
                path = { "energy_source", "input_flow_limit" } -- 输入限制
            },
            {
                path = { "energy_source", "output_flow_limit" } -- 输出限制
            },
            {
                path = { "energy_usage" } -- 能量使用
            },
            {
                path = { "max_health" } -- 最大血量
            }
        }
    }
}

-- 电力输送相关目录
local data_raw_transmission_catalog = {
    ["electric-pole"] = { -- 电线杆
        orig = {
            "small-electric-pole", -- 小型电线杆
            "medium-electric-pole", -- 中型型电线杆
            "big-electric-pole", -- 大型电线杆
            "substation" -- 广域配电站
        },
        mod = {
            "se-addon-power-pole", -- space-exploration
            "se-pylon",
            "se-pylon-substation",
            "se-pylon-construction",
            "se-pylon-construction-radar",
            "se-spaceship-clamp-power-pole-internal",
            "se-spaceship-clamp-power-pole-external-west",
            "se-spaceship-clamp-power-pole-external-east",
            "se-space-elevator-energy-pole", -- space-exploration
            "kr-substation-mk2", -- Krastorio2
            "medium-electric-pole-2", -- bobpower
            "medium-electric-pole-3",
            "medium-electric-pole-4",
            "big-electric-pole-2",
            "big-electric-pole-3",
            "big-electric-pole-4",
            "substation-2",
            "substation-3",
            "substation-4", -- bobpower
            "small-iron-electric-pole", -- aai-industry
        },
        mul = settings.startup["x-custom-game-electricity-transmission-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "maximum_wire_distance" }, -- 电线最大距离。最大为64
                max_value = 64 -- 可设置的最大值
            },
            {
                path = { "supply_area_distance" }, -- 供应区域距离。最大为64
                max_value = 64
            },
            {
                path = { "max_health" } -- 最大血量
            }
        }
    }
}

-- 执行修改
log("\n\n\n------------------电力系统 start------------------\n\n\n")

-- local data_raw = common_data_raw(data_raw_modifi_catalog)
-- data_raw:execute_modify()

common_data_raw:execute_modify(data_raw_production_catalog)
common_data_raw:execute_modify(data_raw_transmission_catalog)

log("\n\n\n------------------电力系统 end------------------\n\n\n")
