local Core = {
    lib_core_util = require("__core__/lualib/util"),
    lib_serpent = require("common/serpent"),
    x_string = require("common.x_string"),
    x_util = require("common.x_util"),
    -- serpent_block_format = { indent = "\t", comment = false, maxlevel = 2 },
    serpent_block_format = { indent = "\t", comment = false },
    serpent_line_format = { sortkeys = true, comment = false },
}

setmetatable(Core, Core)

-- 从 settings.lua 获取调试模式配置
Core.x_custom_game_debug = settings.startup["x_custom_game_debug"].value

-- Serpent 格式化方法
function Core:serpent_block(tab)
    return self.lib_serpent.block(tab, self.serpent_block_format)
end

function Core:serpent_line(tab)
    return self.lib_serpent.line(tab, self.serpent_line_format)
end

-- 日志辅助函数，处理值为表和简单值的情况
function Core.format_log_value(value)
    if type(value) == "table" then
        return Core:serpent_line(value)
    else
        return tostring(value)
    end
end

-- 日志记录函数
function Core.Log(msg)
    -- 检查是否在调试模式
    if not Core.x_custom_game_debug then
        return
    end

    -- 转换为字符串
    if type(msg) == "table" then
        msg = Core:serpent_block(msg) or "nil after serpent_block"
    end

    log(msg)
end

return Core
