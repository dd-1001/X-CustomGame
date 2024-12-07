local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local x_util = Core.x_util
local log = Core.Log

-- 指令表配置
local set_value_recipe_productivity = settings.startup["x-custom-game-recipe-productivity-limit-multiplier"].value
local instructions_recipe = {
    {
        type = "recipe", -- 配方
        name = { "*" },
        exclude_names = {},
        operations = {
            maximum_productivity = { type = "insert", value = 3.0 * set_value_recipe_productivity }, -- 最大产能
        }
    }
}

-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_recipe)
-- log("instructions_recipe modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not X_CUSTOM_GAME_MODIFIED_TYPE[prototype] then
            X_CUSTOM_GAME_MODIFIED_TYPE[prototype] = true
        end
    end
end
