local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local log = Core.Log

-- 指令表配置
local set_value_transport = settings.startup["x-custom-game-transport-performance-multiplier"].value
local instructions_transport = {
    {
        type = "transport-belt", -- 传送带
        name = "*",
        exclude_names = {},
        operations = {
            speed = { type = "multiply", value = set_value_transport }
        }
    },
    {
        type = "underground-belt", -- 地下传送带
        name = "*",
        exclude_names = {},
        operations = {
            speed = { type = "multiply", value = set_value_transport },
            max_distance = { type = "multiply", value = set_value_transport, max_value = 81 }
        }
    },
    {
        type = "splitter", -- 分流器
        name = "*",
        exclude_names = {},
        operations = {
            speed = { type = "multiply", value = set_value_transport },
        }
    }
}



-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_transport)
log("instructions_transport modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not DataTweaker.table_contains(X_CUSTOM_GAME_MODIFIED_TYPE, prototype) then
            table.insert(X_CUSTOM_GAME_MODIFIED_TYPE, prototype)
        end
    end
end
