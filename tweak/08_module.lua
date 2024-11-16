local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local x_util = Core.x_util
local log = Core.Log

-- 指令表配置
local set_value_beacon = settings.startup["x-custom-game-beacon-performance-multiplier"].value
local set_value_module = settings.startup["x-custom-game-module-performance-multiplier"].value
local instructions_module = {
    {
        type = "beacon", -- 插件效果分享塔
        name = { "*" },
        exclude_names = {},
        operations = {
            distribution_effectivity = { type = "multiply", value = set_value_beacon, max_value = 3 },                         -- 模块效果的乘数，当在邻居之间共享时
            distribution_effectivity_bonus_per_quality_level = { type = "multiply", value = set_value_beacon, max_value = 3 }, -- 模块效果的乘数，当在邻居之间共享时
            energy_usage = { type = "division", value = set_value_beacon },                                                    -- 耗能
            module_slots = { type = "multiply", value = set_value_beacon, max_value = 30 },                                    -- 模块槽位数量
            supply_area_distance = { type = "multiply", value = set_value_beacon, max_value = 64 },                            -- 效果分享范围
        }
    },
    {
        type = "module", -- 插件-速度
        name = { "speed-module", "speed-module-2", "speed-module-3" },
        exclude_names = {},
        operations = {
            ["effect.consumption"] = { type = "division", value = set_value_module, min_value = 0.25 }, -- 效果-耗能增加
            ["effect.quality"] = { type = "set", value = nil },                                         -- 效果-品质减小
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
            ["effect.consumption"] = { type = "division", value = set_value_module, min_value = 0.2 }, -- 效果-耗能增加
            ["effect.pollution"] = { type = "division", value = set_value_module, min_value = 0.01 },  -- 效果-污染增加
            ["effect.quality"] = { type = "multiply", value = set_value_module, max_value = 0.2 },     -- 效果-品质增加
            ["effect.speed"] = { type = "set", value = nil },                                          -- 效果-速度减小
        }
    },
    {
        type = "module", -- 插件-品质
        name = { "quality-module", "quality-module-2", "quality-module-3" },
        exclude_names = {},
        operations = {
            ["effect.quality"] = { type = "multiply", value = set_value_module }, -- 效果-品质增加
            ["effect.speed"] = { type = "set", value = nil },                     -- 效果-速度减小
        }
    }
}



-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_module)
log("instructions_module modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not x_util.table_contains(X_CUSTOM_GAME_MODIFIED_TYPE, prototype) then
            table.insert(X_CUSTOM_GAME_MODIFIED_TYPE, prototype)
        end
    end
end
