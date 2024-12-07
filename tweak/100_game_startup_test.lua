local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local x_database = require("99_database")
local x_util = Core.x_util
local log = Core.Log

log("\n\n\n100_game_startup_test start\n\n\n")

-- 打印原型
-- log("data.raw.recipe:\n" .. Core:serpent_block(data.raw.recipe) .. "\n")
-- for protype, _ in pairs(data.raw) do
--     log("data.raw." .. protype .. " = \n" .. Core:serpent_block(data.raw[protype]) .. "\n")
-- end

-- 检查未修改的类型
-- log("\nX_CUSTOM_GAME_MODIFIED_TYPE:\n" .. Core:serpent_block(X_CUSTOM_GAME_MODIFIED_TYPE))

-- local modified_type = {}
-- for _, protype in pairs(X_CUSTOM_GAME_MODIFIED_TYPE) do
--     modified_type[protype] = true
-- end
-- log("\nmodified_type:\n" .. Core:serpent_block(modified_type))

local unModified_type = {}
for protype, _ in pairs(data.raw) do
    if not X_CUSTOM_GAME_MODIFIED_TYPE[protype] then
        unModified_type[protype] = true
    end
end
-- log("\nunModified_type:\n" .. Core:serpent_block(unModified_type))

local new_unModified_type = {}
for protype, _ in pairs(unModified_type) do
    if not x_database.unModified_type[protype] then
        new_unModified_type[protype] = true
    end
end
log("\nnew_unModified_type:\n" .. Core:serpent_block(new_unModified_type))

-- 查找实例
-- local function filter(tbl)
--     if tbl.module_slots then
--         return true
--     else
--         return false
--     end
-- end
-- local data_raw_filter = x_util.find_with_filter(data.raw, filter)
-- log("\ndata_raw_filter:\n" .. Core:serpent_block(data_raw_filter))


log("\n\n\n100_game_startup_test end\n\n\n")
