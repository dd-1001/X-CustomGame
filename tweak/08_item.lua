local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local log = Core.Log

-- 指令表配置
local set_value_stack_size = settings.startup["x-custom-game-stack-size-multiplier"].value
local set_value_fuel = settings.startup["x-custom-game-fuel-multiplier"].value
local instructions_item = {
    {
        type = "item", -- 中间产品
        name = "*",
        exclude_names = {
            "red-wire",
            "green-wire",
            "copper-wire",
            "empty-module-slot"
        },
        operations = {
            stack_size = { type = "multiply", value = set_value_stack_size },             -- 堆叠大小
            fuel_acceleration_multiplier = { type = "multiply", value = set_value_fuel }, -- 燃料加速乘数
            fuel_top_speed_multiplier = { type = "multiply", value = set_value_fuel },    -- 燃料最高速度倍增
            fuel_value = { type = "multiply", value = set_value_fuel },                   -- 燃料值
        }
    }
}



-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_item)
log("instructions_item modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not DataTweaker.table_contains(X_CUSTOM_GAME_MODIFIED_TYPE, prototype) then
            table.insert(X_CUSTOM_GAME_MODIFIED_TYPE, prototype)
        end
    end
end
