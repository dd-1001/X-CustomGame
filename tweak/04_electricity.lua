local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.lib_logger("x-custom-game-electricity.lua")

-- 电力生产相关目录
local data_raw_production_catalog = {
    boiler = { -- 锅炉
        orig = {
            "boiler", -- 锅炉
            "heat-exchanger" -- 换热器
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-boiler-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "energy_consumption" } -- 能量消耗
            }, {
                path = { "energy_source", "effectivity" } -- 可选。1意味着100%的效果。必须大于0。 能量输出的乘数。
            }, {
                path = { "energy_source", "emissions_per_minute" }, -- 可选的。一个实体在全能量消耗下每分钟排放的污染。正是实体工具提示中显示的值。
                operation = "Div" -- Mul 做乘法， Div 做除法
            }, {
                path = { "energy_source", "max_transfer" } -- 最大传输量
            }, {
                path = { "energy_source", "specific_heat" }, -- 比热容。吸收能量的多少
                operation = "Div"
            }, {
                path = { "fluid_box", "height" } -- 必须大于0。液箱的总液体容量为base_area × height × 100
            }, {
                path = { "output_fluid_box", "height" } -- 必须大于0。液箱的总液体容量为base_area × height × 100
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    generator = { -- 发电机
        orig = {
            "steam-engine", -- 蒸汽机
            "steam-turbine" -- 汽轮机
        },
        mul = settings.startup["x-custom-game-generator-performance-multiplier"].value,
        modify_parameter = {
            {
                path = { "effectivity" } -- 效率
            }, {
                path = { "fluid_box", "height" }
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    ["burner-generator"] = { -- aai-industry 燃料发电机
        mod = {
            "burner-turbine", -- aai-industry
        },
        mul = settings.startup["x-custom-game-generator-performance-multiplier"].value,
        modify_parameter = {
            {
                path = { "burner", "effectivity" }
            }, {
                path = { "burner", "emissions_per_minute" },
                operation = "Div"
            }, {
                path = { "max_power_output" }
            }
        }
    },
    ["solar-panel"] = { -- 太阳能板
        orig             = {
            "solar-panel" -- 太阳能板
        },
        mod              = {
            "advanced-solar", -- Advanced-Electric-Revamped-v16 start
            "elite-solar",
            "ultimate-solar" -- Advanced-Electric-Revamped-v16 end
        },
        mul              = settings.startup["x-custom-game-solar-panel-performance-multiplier"].value,
        modify_parameter = {
            {
                path = { "production" } -- 发电量
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    accumulator = { -- 蓄电池
        orig             = {
            "accumulator" -- 蓄电池
        },
        mod              = {
            "advanced-accumulator", -- Advanced-Electric-Revamped-v16 start
            "elite-accumulator",
            "ultimate-accumulator", -- Advanced-Electric-Revamped-v16 end
            "se-space-accumulator",
            "se-space-accumulator-2",
        },
        mul              = settings.startup["x-custom-game-accumulator-performance-multiplier"].value,
        modify_parameter = {
            {
                path = { "energy_source", "buffer_capacity" } -- 电池容量
            }, {
                path = { "energy_source", "input_flow_limit" } -- 电池输入限制
            }, {
                path = { "energy_source", "output_flow_limit" } -- 电池输出限制
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    reactor = { -- 核反应堆
        orig             = {
            "nuclear-reactor" -- 核反应堆
        },
        mul              = settings.startup["x-custom-game-reactor-performance-multiplier"].value,
        modify_parameter = {
            {
                path = { "consumption" } -- 能量消耗量
            }, {
                path = { "energy_source", "effectivity" } -- 效率
            }, {
                path = { "heat_buffer", "max_temperature" } -- 最高温度
            }, {
                path = { "heat_buffer", "max_transfer" } -- 最大传输量
            }, {
                path = { "heat_buffer", "specific_heat" }, -- 比热容
                operation = "Div"
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    ["heat-pipe"] = { -- 热管
        orig             = {
            "heat-pipe" -- 核反应堆
        },
        mod              = {
        },
        mul              = settings.startup["x-custom-game-heat-pipe-performance-multiplier"].value,
        modify_parameter = {
            {
                path = { "heat_buffer", "max_temperature" } -- 最高温度
            }, {
                path = { "heat_buffer", "max_transfer" } -- 最大传输量
            }, {
                path = { "heat_buffer", "specific_heat" }, -- 比热容
                operation = "Div"
            }, {
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
            "small-iron-electric-pole", -- aai-industry
        },
        mul = settings.startup["x-custom-game-electricity-transmission-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "maximum_wire_distance" }, -- 电线最大距离。最大为64
                max_value = 64 -- 可设置的最大值
            }, {
                path = { "supply_area_distance" }, -- 供应区域距离。最大为64
                max_value = 64
            }, {
                path = { "max_health" } -- 最大血量
            }
        }
    }
}

-- 执行修改
log("\n\n\n------------------电力系统 start------------------n\n\n")

-- local data_raw = common_data_raw(data_raw_modifi_catalog)
-- data_raw:execute_modify()

common_data_raw:execute_modify(data_raw_production_catalog)
common_data_raw:execute_modify(data_raw_transmission_catalog)

log("\n\n\n------------------电力系统 end------------------n\n\n")
