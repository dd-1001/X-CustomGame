local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local x_util = Core.x_util
local log = Core.Log

-- 指令表配置
local set_value_technology_cost = settings.startup["x-custom-game-technology-cost-multiplier"].value
local set_value_modify_flag = settings.startup["x-custom-game-modify-infinite-technology-flag"].value
local set_value_count_formula = settings.startup["x-custom-game-infinite-technology-count-formula"].value
local instructions_technology = {
    {
        type = "technology", -- 技术
        name = { "*" },
        exclude_names = {},
        operations = {
            ["research_trigger.count"] = { type = "multiply", value = set_value_technology_cost,min_value = 1 },
            ["unit.count"] = { type = "multiply", value = set_value_technology_cost,min_value = 1 },
            ["unit.time"] = { type = "multiply", value = set_value_technology_cost,min_value = 1 },
        }
    }
}

if set_value_modify_flag then
    -- 查找max_level = "infinite"的原型
    local function filter_max_level_infinite(tbl)
        return tbl.max_level ~= nil and tbl.max_level == "infinite"
    end
    local data_raw_max_level_infinite = x_util.find_with_filter(data.raw, filter_max_level_infinite)
    -- log("\ndata_raw_max_level_infinite:\n" .. Core:serpent_block(data_raw_max_level_infinite))

    -- 组装修改count_formula属性的指令
    for prototype, protonames in pairs(data_raw_max_level_infinite) do
        for _, protoname in ipairs(protonames) do
            local instructions_template = {}
            instructions_template["type"] = prototype
            instructions_template["name"] = { protoname }
            instructions_template["operations"] = {
                ["unit.count_formula"] = { type = "set", value = set_value_count_formula }, -- 公式
            }

            table.insert(instructions_technology, instructions_template)
        end
    end
    -- log("\ninstructions_technology:\n" .. Core:serpent_block(instructions_technology))
end


-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_technology)
log("instructions_technology modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not X_CUSTOM_GAME_MODIFIED_TYPE[prototype] then
            X_CUSTOM_GAME_MODIFIED_TYPE[prototype] = true
        end
    end
end
