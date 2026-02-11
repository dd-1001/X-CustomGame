local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local x_util = Core.x_util
local log = Core.Log

-- 指令表配置
local set_value_recipe_productivity = settings.startup["x-custom-game-recipe-productivity-limit-multiplier"].value
local set_value_module_slots_allow_productivity_flag = settings.startup
    ["x-custom-game-module-slot-allow-productivity-flag"].value
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

if set_value_module_slots_allow_productivity_flag then
    -- 查找 type 为 recipe 且没有 allow_productivity 字段的原型
    local function filter_recipe_without_allow_productivity(tbl)
        return tbl.type == "recipe" and tbl.allow_productivity == nil and tbl.hidden == nil and tbl.results ~= nil and
            next(tbl.results) ~= nil
    end
    local data_raw_recipe_without_allow_productivity = x_util.find_with_filter(data.raw,
        filter_recipe_without_allow_productivity)
    -- log("\ndata_raw_recipe_without_allow_productivity:\n" ..
        -- Core:serpent_block(data_raw_recipe_without_allow_productivity))

    -- 组装插入 allow_productivity 属性的指令
    for prototype, protonames in pairs(data_raw_recipe_without_allow_productivity) do
        for _, protoname in ipairs(protonames) do
            local instructions_template = {}
            instructions_template["type"] = prototype
            instructions_template["name"] = { protoname }
            instructions_template["operations"] = {
                -- 对缺少该字段的配方插入 allow_productivity = true
                allow_productivity = { type = "insert", value = true },
            }

            table.insert(instructions_recipe, instructions_template)
        end
    end
    -- log("\ninstructions_recipe:\n" .. Core:serpent_block(instructions_recipe))
end

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
