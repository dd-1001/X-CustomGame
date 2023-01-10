local Core = {
    lib_serpent = require("common/serpent"),
    lib_logger = require("__stdlib__/stdlib/misc/logger"),
    lib_string = require("__stdlib__/stdlib/utils/string"),
    serialization_format = { indent = "\t", comment = false, maxlevel = 2 }
}

setmetatable(Core, Core)

return Core