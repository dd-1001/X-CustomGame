local Core = {
    lib_serpent = require("common/serpent"),
    -- lib_serpent = require("__stdlib__/stdlib/vendor/serpent"),
    lib_logger = require("__stdlib__/stdlib/misc/logger"),
    -- lib_string = require("__stdlib__/stdlib/utils/string"),
    serialization_format = { indent = "\t", comment = false, maxlevel = 3 }
    -- serialization_format = { indent = "\t", comment = false}
}

setmetatable(Core, Core)

function Core:serialization_table(tab)
    return self.lib_serpent.block(tab, self.serialization_format)
end

return Core
