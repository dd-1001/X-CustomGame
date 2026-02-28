local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local x_util = Core.x_util
local log = Core.Log

-- 指令表配置
local set_author_custom_balance = settings.startup["x-custom-game-author-custom-balance-flag"].value

if not set_author_custom_balance then
    return
end

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
            color_lookup = { type = "set", value = { { 0.98, "__core__/graphics/color_luts/lut-sunset.png" } } }, -- 亮度
        }
    },
    {
        type = "logistic-robot", -- 物流机器人
        name = { "*" },
        exclude_names = {},
        operations = {
            max_payload_size = { type = "set", value = 97 }, -- 机器人货物承载
        }
    },
    {
        type = "construction-robot", -- 建设机器人
        name = { "*" },
        exclude_names = {},
        operations = {
            max_payload_size = { type = "set", value = 97 }, -- 机器人货物承载
        }
    },
    {
        type = "item", -- 填埋材料
        name = { "artificial-yumako-soil", "overgrowth-yumako-soil", "artificial-jellynut-soil", "overgrowth-jellynut-soil" },
        exclude_names = {},
        operations = {
            ["place_as_tile.tile_condition"] = { type = "set", value = nil }, -- 去掉放置地形限制
        }
    },
    {
        type = "recipe", -- 配方
        name = { "yumako-processing", "jellynut-processing" },
        exclude_names = {},
        operations = {
            ["results[1].probability"] = { type = "set", value = 0.75 }, -- 种子生成概率
        }
    },
    -- {
    --     type = "tool", -- 科技包
    --     name = { "agricultural-science-pack" },
    --     exclude_names = {},
    --     operations = {
    --         spoil_ticks = { type = "set", value = nil },                          -- 变质时间
    --         spoil_result = { type = "set", value = "agricultural-science-pack" }, -- 变质结果
    --     }
    -- },
    -- {
    --     type = "thruster", -- 火箭推进器
    --     name = { "*" },
    --     exclude_names = {},
    --     operations = {
    --         ["fuel_fluid_box.pipe_connections[1]"] = {
    --             type = "set",
    --             value = { direction = 12, enable_working_visualisations = { "pipe-4" }, flow_direction = "input-output", position = { -1.5, -2 } }
    --         }, -- 燃料接口位置
    --         ["fuel_fluid_box.pipe_connections[2]"] = {
    --             type = "set",
    --             value = { direction = 4, enable_working_visualisations = { "pipe-1" }, flow_direction = "input-output", position = { 1.5, -2 } }
    --         }, -- 燃料接口位置
    --         ["oxidizer_fluid_box.pipe_connections[1]"] = {
    --             type = "set",
    --             value = { direction = 12, enable_working_visualisations = { "pipe-3" }, flow_direction = "input-output", position = { -1.5, 0 } }
    --         }, -- 氧化剂接口位置
    --         ["oxidizer_fluid_box.pipe_connections[2]"] = {
    --             type = "set",
    --             value = { direction = 4, enable_working_visualisations = { "pipe-2" }, flow_direction = "input-output", position = { 1.5, 0 } }
    --         }, -- 氧化剂接口位置
    --     }
    -- },
}

-- 查找 type 为 recipe 且有 surface_conditions 字段的原型
local function filter_recipe_with_surface_conditions(tbl)
    return tbl.type == "recipe" and tbl.surface_conditions ~= nil and tbl.hidden == nil and tbl.results ~= nil and
        next(tbl.results) ~= nil
end
local data_raw_recipe_with_surface_conditions = x_util.find_with_filter(data.raw,
    filter_recipe_with_surface_conditions)
-- log("\ndata_raw_recipe_with_surface_conditions:\n" ..
-- Core:serpent_block(data_raw_recipe_with_surface_conditions))

-- 组装插入 surface_conditions 属性的指令
for prototype, protonames in pairs(data_raw_recipe_with_surface_conditions) do
    for _, protoname in ipairs(protonames) do
        local instructions_template = {}
        instructions_template["type"] = prototype
        instructions_template["name"] = { protoname }
        instructions_template["operations"] = {
            surface_conditions = { type = "set", value = nil },
        }

        table.insert(instructions_custom_balance, instructions_template)
    end
end
-- log("\ninstructions_custom_balance:\n" .. Core:serpent_block(instructions_custom_balance))

-- 查找有 spoil_ticks 字段的原型
local function filter_recipe_with_spoil_ticks(tbl)
    return tbl.spoil_ticks ~= nil
end
local data_raw_recipe_with_spoil_ticks = x_util.find_with_filter(data.raw,
    filter_recipe_with_spoil_ticks)
-- log("\ndata_raw_recipe_with_spoil_ticks:\n" ..
-- Core:serpent_block(data_raw_recipe_with_spoil_ticks))

-- 组装删除 spoil_ticks 属性的指令
for prototype, protonames in pairs(data_raw_recipe_with_spoil_ticks) do
    for _, protoname in ipairs(protonames) do
        local instructions_template = {}
        instructions_template["type"] = prototype
        instructions_template["name"] = { protoname }
        instructions_template["operations"] = {
            spoil_ticks = { type = "set", value = nil },
        }

        table.insert(instructions_custom_balance, instructions_template)
    end
end
-- log("\ninstructions_custom_balance:\n" .. Core:serpent_block(instructions_custom_balance))


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
