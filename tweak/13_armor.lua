local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local x_util = Core.x_util
local log = Core.Log

-- 指令表配置
local set_value_armor = settings.startup["x-custom-game-armor-performance-multiplier"].value
local set_value_equipment_grid = settings.startup["x-custom-game-equipment-grid-performance-multiplier"].value
local instructions_armor = {
    {
        type = "armor", -- 护甲
        name = { "*" },
        exclude_names = {},
        operations = {
            ["resistances[1].decrease"] = { type = "multiply", value = set_value_armor }, -- 减伤
            ["resistances[1].percent"] = { type = "multiply", value = set_value_armor },  -- 减伤
            ["resistances[2].decrease"] = { type = "multiply", value = set_value_armor }, -- 减伤
            ["resistances[2].percent"] = { type = "multiply", value = set_value_armor },  -- 减伤
            ["resistances[3].decrease"] = { type = "multiply", value = set_value_armor }, -- 减伤
            ["resistances[3].percent"] = { type = "multiply", value = set_value_armor },  -- 减伤
            ["resistances[4].decrease"] = { type = "multiply", value = set_value_armor }, -- 减伤
            ["resistances[4].percent"] = { type = "multiply", value = set_value_armor },  -- 减伤
            inventory_size_bonus = { type = "multiply", value = set_value_armor },        -- 库存大小增益
        }
    },
    {
        type = "equipment-grid", -- 装备网格
        name = { "*" },
        exclude_names = {},
        operations = {
            height = { type = "multiply", value = set_value_equipment_grid, max_value = 16 }, -- 高度
            width = { type = "multiply", value = set_value_equipment_grid, max_value = 16 },  -- 宽度
        }
    }
}



-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_armor)
log("instructions_armor modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not x_util.table_contains(X_CUSTOM_GAME_MODIFIED_TYPE, prototype) then
            table.insert(X_CUSTOM_GAME_MODIFIED_TYPE, prototype)
        end
    end
end
