local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local x_util = Core.x_util
local log = Core.Log

-- 指令表配置
local instructions_resource = {}
local set_value_infinite_resource = settings.startup["x_custom_game_infinite_resource"].value
local instructions_infinite_resource = {
    {
        type = "resource", -- 资源
        name = { "*" },
        exclude_names = {},
        operations = {
            infinite                  = { type = "insert", value = true }, -- 插入无限属性
            minimum                   = { type = "insert", value = 100 },  -- 插入最小值
            normal                    = { type = "insert", value = 100 },  -- 插入普通值
            infinite_depletion_amount = { type = "insert", value = 0 },    -- 插入无限减少值
        }
    },
    {
        type = "resource", -- 资源
        name = { "*" },
        exclude_names = {},
        operations = {
            infinite                  = { type = "set", value = true },  -- 设置无限属性
            minimum                   = { type = "set", value = 100 },   -- 设置最小值
            normal                    = { type = "set", value = 100 },   -- 设置普通值
            infinite_depletion_amount = { type = "set", value = 0 },     -- 设置无限减少值
            stage_counts              = { type = "set", value = { 0 } }, -- 设置stage_counts
        }
    }
}

if set_value_infinite_resource then
    for _, instruction in ipairs(instructions_infinite_resource) do
        table.insert(instructions_resource, instruction)
    end
end


-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_resource)
log("instructions_resource modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not X_CUSTOM_GAME_MODIFIED_TYPE[prototype] then
            X_CUSTOM_GAME_MODIFIED_TYPE[prototype] = true
        end
    end
end
