local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local x_util = Core.x_util
local log = Core.Log

-- 指令表配置
local set_value_beacon = settings.startup["x-custom-game-beacon-performance-multiplier"].value
local set_value_module = settings.startup["x-custom-game-module-performance-multiplier"].value
local set_value_module_slots = settings.startup["x-custom-game-module-slots-multiplier"].value
local set_value_module_slots_allowed_flag = settings.startup["x-custom-game-module-slot-all-type-allowed-flag"].value
local instructions_module = {
    {
        type = "beacon", -- 插件效果分享塔
        name = { "*" },
        exclude_names = {},
        operations = {
            distribution_effectivity = { type = "multiply", value = set_value_beacon, max_value = 3 },                         -- 模块效果的乘数，当在邻居之间共享时
            distribution_effectivity_bonus_per_quality_level = { type = "multiply", value = set_value_beacon, max_value = 3 }, -- 模块效果的乘数，当在邻居之间共享时
            energy_usage = { type = "multiply", value = set_value_beacon },                                                    -- 耗能
            module_slots = { type = "multiply", value = set_value_beacon, max_value = 30 },                                    -- 模块槽位数量
            supply_area_distance = { type = "multiply", value = set_value_beacon, max_value = 64 },                            -- 效果分享范围
        }
    },
    {
        type = "module", -- 插件-速度
        name = { "speed-module", "speed-module-2", "speed-module-3" },
        exclude_names = {},
        operations = {
            ["effect.consumption"] = { type = "multiply", value = set_value_module, min_value = 0.25 }, -- 效果-耗能增加
            ["effect.quality"] = { type = "division", value = set_value_module },                       -- 效果-品质减小
            ["effect.speed"] = { type = "multiply", value = set_value_module },                         -- 效果-速度增加
        }
    },
    {
        type = "module", -- 插件-节能
        name = { "efficiency-module", "efficiency-module-2", "efficiency-module-3", },
        exclude_names = {},
        operations = {
            ["effect.consumption"] = { type = "multiply", value = set_value_module, max_value = 0.8 }, -- 效果-耗能减少
        }
    },
    {
        type = "module", -- 插件-产能
        name = { "productivity-module", "productivity-module-2", "productivity-module-3" },
        exclude_names = {},
        operations = {
            ["effect.consumption"] = { type = "multiply", value = set_value_module, min_value = 0.2 }, -- 效果-耗能增加
            ["effect.pollution"] = { type = "division", value = set_value_module, min_value = 0.01 },  -- 效果-污染增加
            ["effect.productivity"] = { type = "multiply", value = set_value_module },                 -- 效果-产能增加
            ["effect.speed"] = { type = "division", value = set_value_module, min_value = -0.025 },    -- 效果-速度减小
        }
    },
    {
        type = "module", -- 插件-品质
        name = { "quality-module", "quality-module-2", "quality-module-3" },
        exclude_names = {},
        operations = {
            ["effect.quality"] = { type = "multiply", value = set_value_module },                   -- 效果-品质增加
            ["effect.speed"] = { type = "division", value = set_value_module, min_value = -0.025 }, -- 效果-速度减小
        }
    }
}


-- 查找含有module_slots的原型
local function filter_module_slots(tbl)
    return tbl.module_slots ~= nil
end
local data_raw_module_slots = x_util.find_with_filter(data.raw, filter_module_slots)
-- log("\ndata_raw_module_slots:\n" .. Core:serpent_block(data_raw_module_slots))

-- 组装修改module_slots属性的指令
for prototype, protonames in pairs(data_raw_module_slots) do
    for _, protoname in ipairs(protonames) do
        local instructions_template = {}
        instructions_template["type"] = prototype
        instructions_template["name"] = { protoname }
        instructions_template["operations"] = {
            module_slots = { type = "multiply", value = set_value_module_slots, max_value = 20 }, -- 模块槽位数量
        }

        table.insert(instructions_module, instructions_template)
    end
end
-- log("\ninstructions_module:\n" .. Core:serpent_block(instructions_module))

if set_value_module_slots_allowed_flag then
    -- 查找含有allowed_effects的原型
    local function filter_allowed_effects(tbl)
        return tbl.allowed_effects ~= nil
    end
    local data_raw_allowed_effects = x_util.find_with_filter(data.raw, filter_allowed_effects)
    -- log("\ndata_raw_allowed_effects:\n" .. Core:serpent_block(data_raw_allowed_effects))

    -- 组装修改allowed_effects属性的指令
    for prototype, protonames in pairs(data_raw_allowed_effects) do
        for _, protoname in ipairs(protonames) do
            local instructions_template = {}
            instructions_template["type"] = prototype
            instructions_template["name"] = { protoname }
            instructions_template["operations"] = {
                allowed_effects = { type = "set", value = { "speed", "productivity", "consumption", "pollution", "quality" } }, -- 允许所有类型的插件
            }

            table.insert(instructions_module, instructions_template)
        end
    end
    -- log("\ninstructions_module:\n" .. Core:serpent_block(instructions_module))
end

-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_module)
log("instructions_module modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not X_CUSTOM_GAME_MODIFIED_TYPE[prototype] then
            X_CUSTOM_GAME_MODIFIED_TYPE[prototype] = true
        end
    end
end
