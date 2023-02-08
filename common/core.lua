local Core = {
    lib_serpent = require("common/serpent"),
    -- lib_serpent = require("__stdlib__/stdlib/vendor/serpent"),
    -- lib_logger = require("__stdlib__/stdlib/misc/logger"),
    -- lib_string = require("__stdlib__/stdlib/utils/string"),
    -- serialization_format = { indent = "\t", comment = false, maxlevel = 3 }
    serialization_format = { indent = "\t", comment = false }
}

-- 确定调试模式 
-- true 为调试模式；false 为非调试模式
X_CUSTOM_GAME_IS_DEBUG = true
-- X_CUSTOM_GAME_IS_DEBUG = false

setmetatable(Core, Core)

function Core:serialization_table(tab)
    return self.lib_serpent.block(tab, self.serialization_format)
end

function Core.Log(msg)
    -- 非调试模式不打印日志
    if not X_CUSTOM_GAME_IS_DEBUG then
        return
    end

    if type(msg) == "table" then
        msg = Core:serialization_table(msg)
    end

    log(msg)

end

return Core
