local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local log = Core.Log

-- 指令表配置
local set_value_electric_pole = settings.startup["x-custom-game-electric-pole-performance-multiplier"].value
local set_value_boiler = settings.startup["x-custom-game-boiler-performance-multiplier"].value
local set_value_generator = settings.startup["x-custom-game-generator-performance-multiplier"].value
local set_value_solar_panel = settings.startup["x-custom-game-solar-panel-performance-multiplier"].value
local set_value_accumulator = settings.startup["x-custom-game-accumulator-performance-multiplier"].value
local instructions_electric = {
    {
        type = "electric-pole", -- 电线杆
        name = "*",
        exclude_names = {},
        operations = {
            maximum_wire_distance = { type = "multiply", value = set_value_electric_pole, max_value = 64 }, -- 最大连接距离，max：64
            supply_area_distance = { type = "multiply", value = set_value_electric_pole, max_value = 64 }   -- 供电半径，max：64
        }
    },
    {
        type = "boiler", -- 锅炉
        name = "*",
        exclude_names = {},
        operations = {
            target_temperature = { type = "multiply", value = set_value_boiler },                               -- 设定的目标温度
            energy_consumption = { type = "division", value = set_value_boiler },                               -- 能量消耗
            ["energy_source.effectivity"] = { type = "multiply", value = set_value_boiler },                    -- 效率
            ["energy_source.fuel_inventory_size"] = { type = "multiply", value = set_value_boiler },            -- 燃料库存大小
            ["energy_source.emissions_per_minute.pollution"] = { type = "division", value = set_value_boiler }, -- 污染
            ["fluid_box.volume"] = { type = "multiply", value = set_value_boiler },                             -- 体积
            ["energy_source.max_temperature"] = { type = "multiply", value = set_value_boiler },                -- 最大温度
            ["energy_source.max_transfer"] = { type = "multiply", value = set_value_boiler },                   -- 最大传输热量
            ["energy_source.specific_heat"] = { type = "division", value = set_value_boiler }                   -- 比热容
        }
    },
    {
        type = "generator", -- 蒸汽机
        name = "*",
        exclude_names = {},
        operations = {
            effectivity = { type = "multiply", value = set_value_generator },          -- 效率
            fluid_usage_per_tick = { type = "division", value = set_value_generator }, -- 流体消耗速率
            ["fluid_box.volume"] = { type = "multiply", value = set_value_generator }, -- 体积
        }
    },
    {
        type = "solar-panel", -- 太阳能板
        name = "*",
        exclude_names = {},
        operations = {
            production = { type = "multiply", value = set_value_solar_panel }, -- 发电功率
        }
    },
    {
        type = "accumulator", -- 蓄电池
        name = "*",
        exclude_names = {},
        operations = {
            ["energy_source.buffer_capacity"] = { type = "multiply", value = set_value_accumulator }, -- 电池容量
            ["energy_source.input_flow_limit"] = { type = "multiply", value = set_value_accumulator }, -- 输入限制
            ["energy_source.output_flow_limit"] = { type = "multiply", value = set_value_accumulator }, -- 输出限制
        }
    }
}



-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_electric)
log("instructions_electric modified_items: \n" .. Core:serpent_block(modified_items))
