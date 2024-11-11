local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local log = Core.Log

log("\n\n\n100_game_startup_test start\n\n\n")

-- 测试DataTweaker:exponent_number
-- local value, unit = DataTweaker:exponent_number("100MJ")
-- log("value = " .. value .. ", type = " .. type(value))
-- log("unit = " .. unit .. ", type = " .. type(unit))


-- 打印原型
-- for protype, _ in pairs(data.raw) do
--     log("data.raw." .. protype .. " = \n" .. Core:serpent_block(data.raw[protype]) .. "\n")
-- end

-- 检查未修改的类型
-- log("\nX_CUSTOM_GAME_MODIFIED_TYPE:\n" .. Core:serpent_block(X_CUSTOM_GAME_MODIFIED_TYPE))
local unModified_type = {}
for protype, _ in pairs(data.raw) do
    table.insert(unModified_type, protype)
end
-- log("\ndata.raw all type:\n" .. Core:serpent_block(unModified_type))
for _, protype in pairs(X_CUSTOM_GAME_MODIFIED_TYPE) do
    for index = #unModified_type, 1, -1 do
        if unModified_type[index] == protype then
            table.remove(unModified_type, index)
            break
        end
    end
end
log("\nNot modified type:\n" .. Core:serpent_block(unModified_type))



log("\n\n\n100_game_startup_test end\n\n\n")
