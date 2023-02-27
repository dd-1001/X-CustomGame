local Core = {
    lib_core_util = require("__core__/lualib/util"),
    lib_serpent = require("common/serpent"),
    -- lib_serpent = require("__stdlib__/stdlib/vendor/serpent"),
    -- lib_logger = require("__stdlib__/stdlib/misc/logger"),
    lib_string = require("common/string"),
    -- lib_string = require("__stdlib__/stdlib/utils/string"),
    -- serpent_block_format = { indent = "\t", comment = false, maxlevel = 3 }
    serpent_block_format = { indent = "\t", comment = false },
    serpent_line_format = { sortkeys = true, comment = false }
}

-- 确定调试模式
-- true 为调试模式；false 为非调试模式
-- X_CUSTOM_GAME_IS_DEBUG = false
X_CUSTOM_GAME_IS_DEBUG = true

setmetatable(Core, Core)

function Core:serpent_block(tab)
    return self.lib_serpent.block(tab, self.serpent_block_format)
end

function Core:serpent_line(tab)
    return self.lib_serpent.line(tab, self.serpent_line_format)
end

function Core.Log(msg)
    -- 非调试模式不打印日志
    if not X_CUSTOM_GAME_IS_DEBUG then
        return
    end

    if type(msg) == "table" then
        msg = Core:serpent_block(msg)
    end

    log(msg)
end

return Core
