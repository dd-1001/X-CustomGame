local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local log = Core.Log

-- 指令表配置
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

if not set_value_infinite_resource then
    return
end


-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_infinite_resource)
log("instructions_infinite_resource modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not DataTweaker.table_contains(X_CUSTOM_GAME_MODIFIED_TYPE, prototype) then
            table.insert(X_CUSTOM_GAME_MODIFIED_TYPE, prototype)
        end
    end
end
