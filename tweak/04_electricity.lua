local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local x_util = Core.x_util
local log = Core.Log

-- 指令表配置
local set_value_electric_pole = settings.startup["x-custom-game-electric-pole-performance-multiplier"].value
local set_value_boiler = settings.startup["x-custom-game-boiler-performance-multiplier"].value
local set_value_generator = settings.startup["x-custom-game-generator-performance-multiplier"].value
local set_value_solar_panel = settings.startup["x-custom-game-solar-panel-performance-multiplier"].value
local set_value_accumulator = settings.startup["x-custom-game-accumulator-performance-multiplier"].value
local set_value_reactor = settings.startup["x-custom-game-reactor-performance-multiplier"].value
local set_value_heat_pipe = settings.startup["x-custom-game-heat-pipe-performance-multiplier"].value
local set_value_fusion_reactor = settings.startup["x-custom-game-fusion-reactor-performance-multiplier"].value
local set_value_fusion_generator = settings.startup["x-custom-game-fusion-generator-performance-multiplier"].value
local instructions_electric = {
    {
        type = "electric-pole", -- 电线杆
        name = { "*" },
        exclude_names = {},
        operations = {
            maximum_wire_distance = { type = "multiply", value = set_value_electric_pole, max_value = 64 }, -- 最大连接距离，max：64
            supply_area_distance = { type = "multiply", value = set_value_electric_pole, max_value = 64 }   -- 供电半径，max：64
        }
    },
    {
        type = "boiler", -- 锅炉
        name = { "*" },
        exclude_names = {},
        operations = {
            -- target_temperature = { type = "multiply", value = set_value_boiler },                               -- 设定的目标温度
            energy_consumption = { type = "multiply", value = set_value_boiler },                               -- 能量消耗
            ["energy_source.effectivity"] = { type = "multiply", value = set_value_boiler },                    -- 效率
            -- ["energy_source.fuel_inventory_size"] = { type = "multiply", value = set_value_boiler },            -- 燃料库存大小
            ["energy_source.emissions_per_minute.pollution"] = { type = "division", value = set_value_boiler }, -- 污染
            ["fluid_box.volume"] = { type = "multiply", value = set_value_boiler, max_value = 1000 },           -- 水体积
            ["output_fluid_box.volume"] = { type = "multiply", value = set_value_boiler, max_value = 2000 },    -- 输出蒸汽体积
            ["energy_source.max_temperature"] = { type = "multiply", value = set_value_boiler },                -- 最大温度
            ["energy_source.max_transfer"] = { type = "multiply", value = set_value_boiler },                   -- 最大传输热量
            ["energy_source.specific_heat"] = { type = "division", value = set_value_boiler }                   -- 比热容
        }
    },
    {
        type = "generator", -- 蒸汽机
        name = { "*" },
        exclude_names = {},
        operations = {
            effectivity = { type = "multiply", value = set_value_generator },                            -- 效率
            fluid_usage_per_tick = { type = "multiply", value = set_value_generator },                   -- 流体消耗速率
            ["fluid_box.volume"] = { type = "multiply", value = set_value_generator, max_value = 1000 }, -- 体积
        }
    },
    {
        type = "solar-panel", -- 太阳能板
        name = { "*" },
        exclude_names = {},
        operations = {
            production = { type = "multiply", value = set_value_solar_panel }, -- 发电功率
        }
    },
    {
        type = "accumulator", -- 蓄电池
        name = { "*" },
        exclude_names = {},
        operations = {
            ["energy_source.buffer_capacity"] = { type = "multiply", value = set_value_accumulator },   -- 电池容量
            ["energy_source.input_flow_limit"] = { type = "multiply", value = set_value_accumulator },  -- 输入限制
            ["energy_source.output_flow_limit"] = { type = "multiply", value = set_value_accumulator }, -- 输出限制
        }
    },
    {
        type = "reactor", -- 反应堆
        name = { "*" },
        exclude_names = {},
        operations = {
            consumption = { type = "division", value = set_value_reactor },                   -- 消耗能量
            ["energy_source.effectivity"] = { type = "multiply", value = set_value_reactor }, -- 效率
            -- ["energy_source.burnt_inventory_size"] = { type = "multiply", value = set_value_reactor },           -- 燃料库存大小
            -- ["energy_source.fuel_inventory_size"] = { type = "multiply", value = set_value_reactor },            -- 燃料库存大小
            ["energy_source.emissions_per_minute.pollution"] = { type = "division", value = set_value_reactor }, -- 污染
            ["heat_buffer.max_temperature"] = { type = "multiply", value = set_value_reactor },                  -- 最大温度
            ["heat_buffer.max_transfer"] = { type = "multiply", value = set_value_reactor },                     -- 最大传输热量
            ["heat_buffer.specific_heat"] = { type = "division", value = set_value_reactor },                    -- 比热容
        }
    },
    {
        type = "heat-pipe", -- 热管
        name = { "*" },
        exclude_names = {},
        operations = {
            ["heat_buffer.max_temperature"] = { type = "multiply", value = set_value_heat_pipe }, -- 最大温度
            ["heat_buffer.max_transfer"] = { type = "multiply", value = set_value_heat_pipe },    -- 最大传输热量
            ["heat_buffer.specific_heat"] = { type = "division", value = set_value_heat_pipe },   -- 比热容
        }
    },
    {
        type = "fusion-reactor", -- 聚变反应堆
        name = { "*" },
        exclude_names = {},
        operations = {
            ["burner.effectivity"] = { type = "multiply", value = set_value_fusion_reactor },                        -- 燃烧室效率
            -- ["burner.fuel_inventory_size"] = { type = "multiply", value = set_value_fusion_reactor }, -- 燃烧室燃料库存
            ["input_fluid_box.volume"] = { type = "multiply", value = set_value_fusion_reactor, max_value = 1000 },  -- 输入流体体积
            ["output_fluid_box.volume"] = { type = "multiply", value = set_value_fusion_reactor, max_value = 1000 }, -- 输出流体体积
            max_fluid_usage = { type = "division", value = set_value_fusion_reactor },                               -- 单位时间流体使用量
            power_input = { type = "division", value = set_value_fusion_reactor },                                   -- 输入能量消耗
        }
    },
    {
        type = "fusion-generator", -- 聚变发电机
        name = { "*" },
        exclude_names = {},
        operations = {
            ["energy_source.output_flow_limit"] = { type = "multiply", value = set_value_fusion_generator },           -- 发电量
            ["input_fluid_box.volume"] = { type = "multiply", value = set_value_fusion_generator, max_value = 1000 },  -- 输入流体体积
            ["output_fluid_box.volume"] = { type = "multiply", value = set_value_fusion_generator, max_value = 1000 }, -- 输出流体体积
            max_fluid_usage = { type = "division", value = set_value_fusion_generator },                               -- 单位时间流体使用量
        }
    }
}



-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_electric)
log("instructions_electric modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not X_CUSTOM_GAME_MODIFIED_TYPE[prototype] then
            X_CUSTOM_GAME_MODIFIED_TYPE[prototype] = true
        end
    end
end
