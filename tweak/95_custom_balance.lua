local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local x_util = Core.x_util
local log = Core.Log

-- 指令表配置
local set_author_custom_balance = settings.startup["x-custom-game-author-custom-balance-flag"].value
local instructions_custom_balance = {
    {
        type = "module", -- 插件-速度
        name = { "speed-module", "speed-module-2", "speed-module-3" },
        exclude_names = {},
        operations = {
            ["effect.quality"] = { type = "set", value = nil }, -- 效果-品质减小
        }
    },
    {
        type = "module", -- 插件-产能
        name = { "productivity-module", "productivity-module-2", "productivity-module-3" },
        exclude_names = {},
        operations = {
            ["effect.speed"] = { type = "set", value = nil }, -- 效果-速度减小
        }
    },
    {
        type = "module", -- 插件-品质
        name = { "quality-module", "quality-module-2", "quality-module-3" },
        exclude_names = {},
        operations = {
            ["effect.speed"] = { type = "set", value = nil }, -- 效果-速度减小
        }
    },
    {
        type = "module", -- 插件-品质1
        name = { "quality-module" },
        exclude_names = {},
        operations = {
            ["effect.quality"] = { type = "set", value = 2.5 }, -- 效果-品质增加
        }
    },
    {
        type = "module", -- 插件-品质2
        name = { "quality-module-2" },
        exclude_names = {},
        operations = {
            ["effect.quality"] = { type = "set", value = 5 }, -- 效果-品质增加
        }
    },
    {
        type = "module", -- 插件-品质3
        name = { "quality-module-3" },
        exclude_names = {},
        operations = {
            ["effect.quality"] = { type = "set", value = 10 }, -- 效果-品质增加
        }
    },
    {
        type = "night-vision-equipment", -- 夜视模块
        name = { "*" },
        exclude_names = {},
        operations = {
            color_lookup = { type = "set", value = { { 0.96, "__core__/graphics/color_luts/lut-sunset.png" } } }, -- 亮度
        }
    },
}

if not set_author_custom_balance then
    return
end


-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_custom_balance)
log("instructions_custom_balance modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not X_CUSTOM_GAME_MODIFIED_TYPE[prototype] then
            X_CUSTOM_GAME_MODIFIED_TYPE[prototype] = true
        end
    end
end
