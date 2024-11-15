local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local log = Core.Log

-- 指令表配置
local set_value_container = settings.startup["x-custom-game-container-performance-multiplier"].value
local set_value_storage_tank = settings.startup["x-custom-game-storage-tank-performance-multiplier"].value
local set_value_cargo_wagon = settings.startup["x-custom-game-cargo-wagon-performance-multiplier"].value
local set_value_fluid_wagon = settings.startup["x-custom-game-fluid-wagon-performance-multiplier"].value
local instructions_container = {
    {
        type = "container", -- 容器：箱子
        name = { "*" },
        exclude_names = {},
        operations = {
            inventory_size = { type = "multiply", value = set_value_container }
        }
    },
    {
        type = "logistic-container", -- 容器：物流箱子
        name = { "*" },
        exclude_names = {},
        operations = {
            inventory_size = { type = "multiply", value = set_value_container }
        }
    },
    {
        type = "storage-tank", -- 储液罐
        name = { "*" },
        exclude_names = {},
        operations = {
            flow_length_in_ticks = { type = "multiply", value = set_value_storage_tank }, -- 流速
            ["fluid_box.volume"] = { type = "multiply", value = set_value_storage_tank }  -- 体积
        }
    },
    {
        type = "cargo-wagon", -- 货运车厢
        name = { "*" },
        exclude_names = {},
        operations = {
            inventory_size = { type = "multiply", value = set_value_cargo_wagon }
        }
    },
    {
        type = "fluid-wagon", -- 液罐车厢
        name = { "*" },
        exclude_names = {},
        operations = {
            capacity = { type = "multiply", value = set_value_fluid_wagon } -- 体积
        }
    }
}



-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_container)
log("instructions_container modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not DataTweaker.table_contains(X_CUSTOM_GAME_MODIFIED_TYPE, prototype) then
            table.insert(X_CUSTOM_GAME_MODIFIED_TYPE, prototype)
        end
    end
end
