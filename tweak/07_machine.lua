local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local log = Core.Log

-- 指令表配置
local set_value_mining_drill = settings.startup["x-custom-game-mining-drill-performance-multiplier"].value
local set_value_furnace = settings.startup["x-custom-game-furnace-performance-multiplier"].value
local set_value_assembling_machine = settings.startup["x-custom-game-assembling-machine-performance-multiplier"].value
local instructions_machine = {
    {
        type = "mining-drill", -- 采矿机
        name = "*",
        exclude_names = {},
        operations = {
            ["energy_source.effectivity"] = { type = "multiply", value = set_value_mining_drill },                    -- 燃烧室效率
            ["energy_source.emissions_per_minute.pollution"] = { type = "division", value = set_value_mining_drill }, -- 燃烧室污染
            ["energy_source.fuel_inventory_size"] = { type = "multiply", value = set_value_mining_drill },            -- 燃烧室燃料库存
            energy_usage = { type = "division", value = set_value_mining_drill },                                     -- 能量消耗
            mining_speed = { type = "multiply", value = set_value_mining_drill },                                     -- 钻头速度
            -- resource_searching_radius = { type = "multiply", value = set_value_mining_drill },                        -- 钻机采矿半径
            ["input_fluid_box.volume"] = { type = "multiply", value = set_value_mining_drill },                       -- 输入流体体积
            ["output_fluid_box.volume"] = { type = "multiply", value = set_value_mining_drill },                      -- 输出流体体积

        }
    },
    {
        type = "furnace", -- 熔炉
        name = "*",
        exclude_names = {},
        operations = {
            -- source_inventory_size = { type = "multiply", value = set_value_furnace, max_value = 3 }, -- 输入槽的数量
            -- result_inventory_size = { type = "multiply", value = set_value_furnace, max_value = 3 }, -- 输出槽的数量
            crafting_speed = { type = "multiply", value = set_value_furnace },                                   -- 制作速度
            ["energy_source.effectivity"] = { type = "multiply", value = set_value_furnace },                    -- 燃烧室效率
            ["energy_source.emissions_per_minute.pollution"] = { type = "division", value = set_value_furnace }, -- 燃烧室污染
            ["energy_source.fuel_inventory_size"] = { type = "multiply", value = set_value_furnace },            -- 燃烧室燃料库存
            energy_usage = { type = "division", value = set_value_furnace },                                     -- 能量消耗
        }
    },
    {
        type = "assembling-machine", -- 组装机
        name = "*",
        exclude_names = {},
        operations = {
            crafting_speed = { type = "multiply", value = set_value_assembling_machine },                                   -- 制作速度
            ["energy_source.effectivity"] = { type = "multiply", value = set_value_assembling_machine },                    -- 燃烧室效率
            ["energy_source.emissions_per_minute.pollution"] = { type = "division", value = set_value_assembling_machine }, -- 燃烧室污染
            ["energy_source.fuel_inventory_size"] = { type = "multiply", value = set_value_assembling_machine },            -- 燃烧室燃料库存
            energy_usage = { type = "division", value = set_value_assembling_machine },                                     -- 能量消耗
        }
    }
}



-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_machine)
log("instructions_machine modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not DataTweaker.table_contains(X_CUSTOM_GAME_MODIFIED_TYPE, prototype) then
            table.insert(X_CUSTOM_GAME_MODIFIED_TYPE, prototype)
        end
    end
end
