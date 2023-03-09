local common_core = require("common/core")
local common_data_raw = require("common/data_raw")
local x_database = require("tweak.99_database")

local log = common_core.Log

if not X_CUSTOM_GAME_IS_DEBUG then
    return
end


log("\n\n\n------------------test start------------------\n\n\n")

-- log("x_database: \n" .. common_core:serpent_block(x_database))

-- log("data.raw:\n" .. common_core:serpent_block(data.raw))
-- log("settings:\n" .. common_core:serpent_block(settings))

-- log("Moded List: \n" .. common_core:serpent_block(X_CUSTOM_GAME_TAB_RECORD))

local unmod_list = common_data_raw:check_not_in_record("source")
-- local tab_list = common_data_raw:check_not_in_record("record")

-- 排除
local exclude_info = {}
local possible_exclude_list = {}
local check_record_exclude_type = x_database.check_record_exclude_type
for prot_type, _ in pairs(unmod_list) do
    if check_record_exclude_type[prot_type] then
        exclude_info[prot_type] = unmod_list[prot_type]
        unmod_list[prot_type] = nil
    else
        possible_exclude_list[prot_type] = true
    end
end

-- local all_prot_type = {}
-- for prot_type, _ in pairs(data.raw) do
--     all_prot_type[prot_type] = true
-- end
-- log("all_prot_type: \n" .. common_core:serpent_block(all_prot_type))

-- 打印日志
log("possible_exclude_list: \n" .. common_core:serpent_block(possible_exclude_list))
log("exclude_info: \n" .. common_core:serpent_block(exclude_info))
log("unmod_list: \n" .. common_core:serpent_block(unmod_list))
-- 打印原型定义
if false then
    for prot_type, prot_type_data in pairs(unmod_list) do
        for _, prot_name in ipairs(prot_type_data) do
            log("unmod_prototype_definition: \n" ..
                prot_type .. "." .. prot_name .. " = \n" .. common_core:serpent_block(data.raw[prot_type][prot_name]))
        end
    end
end

-- 搜索
-- local tab_list = {}
-- for recipe_name, _ in pairs(data.raw.recipe) do
--     if string.find(recipe_name, "-catalogue-", 1, true) then
--         table.insert(tab_list, recipe_name)
--     end
-- end
-- log("catalogue List: \n" .. common_core:serpent_block(tab_list))

log("\n\n\n------------------test end------------------\n\n\n")
