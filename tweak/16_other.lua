local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local x_database = require("tweak.99_database")
local x_util = Core.x_util
local log = Core.Log

-- 指令表配置
local set_value_wall = settings.startup["x-custom-game-wall-performance-multiplier"].value
local set_value_tool = settings.startup["x-custom-game-tool-performance-multiplier"].value
local set_value_item_health = settings.startup["x-custom-game-item-health-multiplier"].value
local set_value_enemy_health = settings.startup["x-custom-game-enemy-health-multiplier"].value
local instructions_other = {
    {
        type = "wall", -- 墙
        name = { "*" },
        exclude_names = {},
        operations = {
            repair_speed_modifier = { type = "multiply", value = set_value_wall }, -- 修复速度修正
        }
    },
    {
        type = "gate", -- 闸门
        name = { "*" },
        exclude_names = {},
        operations = {
            activation_distance = { type = "multiply", value = set_value_wall, min_value = 3, max_value = 5 }, -- 激活距离
        }
    },
    {
        type = "tool", -- 科技包
        name = { "*" },
        exclude_names = {},
        operations = {
            durability = { type = "multiply", value = set_value_tool }, -- 耐用性
        }
    }
}

-- 查找含有max_health的原型
local function filter_max_health(tbl)
    return tbl.max_health ~= nil
end
local data_raw_max_health = x_util.find_with_filter(data.raw, filter_max_health)
-- log("\ndata_raw_max_health:\n" .. Core:serpent_block(data_raw_max_health))

-- 组装修改max_health属性的指令
for prototype, protonames in pairs(data_raw_max_health) do
    if x_util.table_contains(x_database.modify_item_health_type, prototype) then
        -- item health
        for _, protoname in ipairs(protonames) do
            local instructions_template = {}
            instructions_template["type"] = prototype
            instructions_template["name"] = { protoname }
            instructions_template["operations"] = {
                max_health = { type = "multiply", value = set_value_item_health },     -- 最大生命值
            }

            table.insert(instructions_other, instructions_template)
        end
    elseif x_util.table_contains(x_database.modify_enemy_health_type, prototype) then
        -- enemy health
        for _, protoname in ipairs(protonames) do
            local instructions_template = {}
            instructions_template["type"] = prototype
            instructions_template["name"] = { protoname }
            instructions_template["operations"] = {
                max_health = { type = "multiply", value = set_value_enemy_health },           -- 最大生命值
                healing_per_tick = { type = "multiply", value = set_value_enemy_health },     -- 回复血量
            }

            table.insert(instructions_other, instructions_template)
        end
    end
end
-- log("\ninstructions_other:\n" .. Core:serpent_block(instructions_other))


-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_other)
log("instructions_other modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not x_util.table_contains(X_CUSTOM_GAME_MODIFIED_TYPE, prototype) then
            table.insert(X_CUSTOM_GAME_MODIFIED_TYPE, prototype)
        end
    end
end
