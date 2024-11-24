local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local x_util = Core.x_util
local log = Core.Log

-- 指令表配置
local set_value_pipe_system = settings.startup["x-custom-game-pipe-system-performance-multiplier"].value
local instructions_pipe_system = {
    {
        type = "pipe", -- 管道
        name = { "*" },
        exclude_names = {},
        operations = {
            ["fluid_box.volume"] = { type = "multiply", value = set_value_pipe_system }, -- 体积
        }
    },
    {
        type = "pipe-to-ground", -- 地下管道
        name = { "*" },
        exclude_names = {},
        operations = {
            ["fluid_box.volume"] = { type = "multiply", value = set_value_pipe_system },                                                       -- 体积
            ["fluid_box.pipe_connections[2].max_underground_distance"] = { type = "multiply", value = set_value_pipe_system, max_value = 81 }, -- 连接距离
        }
    },
    {
        type = "pump", -- 管道泵
        name = { "*" },
        exclude_names = {},
        operations = {
            energy_usage = { type = "division", value = set_value_pipe_system },         -- 耗能
            pumping_speed = { type = "multiply", value = set_value_pipe_system },        -- 泵速
            ["fluid_box.volume"] = { type = "multiply", value = set_value_pipe_system }, -- 体积
        }
    },
    {
        type = "offshore-pump", -- 供水泵
        name = { "*" },
        exclude_names = {},
        operations = {
            energy_usage = { type = "division", value = set_value_pipe_system },         -- 耗能
            pumping_speed = { type = "multiply", value = set_value_pipe_system },        -- 泵速
            ["fluid_box.volume"] = { type = "multiply", value = set_value_pipe_system }, -- 体积
        }
    }
}



-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_pipe_system)
log("instructions_pipe_system modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not X_CUSTOM_GAME_MODIFIED_TYPE[prototype] then
            X_CUSTOM_GAME_MODIFIED_TYPE[prototype] = true
        end
    end
end
