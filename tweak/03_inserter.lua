local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local log = Core.Log

-- 指令表配置
local set_value_inserter = settings.startup["x-custom-game-inserter-performance-multiplier"].value
local instructions_inserter = {
    {
        type = "inserter",        -- 机械臂
        name = "burner-inserter", -- 热能机械臂
        exclude_names = {},
        operations = {
            extension_speed = { type = "multiply", value = set_value_inserter },                      -- 延展速度
            rotation_speed = { type = "multiply", value = set_value_inserter },                       -- 旋转速度
            energy_per_movement = { type = "division", value = set_value_inserter },                  -- 每次移动的能量
            energy_per_rotation = { type = "division", value = set_value_inserter },                  -- 每次旋转的能量
            ["energy_source.effectivity"] = { type = "multiply", value = set_value_inserter },        -- 能量效率
            ["energy_source.fuel_inventory_size"] = { type = "multiply", value = set_value_inserter } -- 燃料物品库存
        }
    },
    {
        type = "inserter", -- 机械臂
        name = "*",
        exclude_names = {
            "burner-inserter" -- 热能机械臂
        },
        operations = {
            extension_speed = { type = "multiply", value = set_value_inserter },         -- 延展速度
            rotation_speed = { type = "multiply", value = set_value_inserter },          -- 旋转速度
            heating_energy = { type = "division", value = set_value_inserter },          -- 加热能量
            energy_per_movement = { type = "division", value = set_value_inserter },     -- 每次移动的能量
            energy_per_rotation = { type = "division", value = set_value_inserter },     -- 每次旋转的能量
            ["energy_source.drain"] = { type = "division", value = set_value_inserter }, -- 耗电
        }
    }
}



-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_inserter)
log("instructions_inserter modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not DataTweaker.table_contains(X_CUSTOM_GAME_MODIFIED_TYPE, prototype) then
            table.insert(X_CUSTOM_GAME_MODIFIED_TYPE, prototype)
        end
    end
end
