local common_core = require("common/core")

local log = common_core.Log
local deepcopy = common_core.lib_core_util.table.deepcopy

local Data_raw = {
    is_log = true,
    data_raw_modifi_catalog = nil -- data.raw修改目录
}

Data_raw.__index = Data_raw
setmetatable(Data_raw, Data_raw)

function Data_raw:new(data_raw_modifi_catalog)
    self.data_raw_modifi_catalog = data_raw_modifi_catalog
    return self
end

Data_raw.__call = Data_raw.new

-- 已做修改的类型+名字
-- X_CUSTOM_GAME_IS_RECORD = false
X_CUSTOM_GAME_IS_RECORD = true
X_CUSTOM_GAME_TAB_RECORD = {}

function Data_raw:record(data_type, data_name)
    if not X_CUSTOM_GAME_IS_RECORD then
        return
    end

    if X_CUSTOM_GAME_TAB_RECORD[data_type] == nil then
        X_CUSTOM_GAME_TAB_RECORD[data_type] = {}
    end

    if X_CUSTOM_GAME_TAB_RECORD[data_type][data_name] == nil then
        X_CUSTOM_GAME_TAB_RECORD[data_type][data_name] = true
    end
end

-- check_type == "source" or check_type == "record";
-- 当source_table为nil，source_table=data.raw
function Data_raw:check_not_in_record(check_type, source_table)
    local not_in_record = {}

    if source_table == nil then
        source_table = data.raw
    end

    if check_type == "source" then
        for data_type, _ in pairs(source_table) do
            for data_name, _ in pairs(source_table[data_type]) do
                if X_CUSTOM_GAME_TAB_RECORD[data_type] == nil then
                    -- 没有这个类型
                    if not_in_record[data_type] == nil then
                        not_in_record[data_type] = {}
                    end
                    table.insert(not_in_record[data_type], data_name)
                elseif X_CUSTOM_GAME_TAB_RECORD[data_type][data_name] == nil then
                    -- 没有这个名字
                    if not_in_record[data_type] == nil then
                        not_in_record[data_type] = {}
                    end
                    table.insert(not_in_record[data_type], data_name)
                end
            end
        end
    elseif check_type == "record" then
        for data_type, tab_name in pairs(X_CUSTOM_GAME_TAB_RECORD) do
            for data_name, _ in pairs(source_table[data_type]) do
                -- 不存在名字
                if tab_name[data_name] == nil then
                    if not_in_record[data_type] == nil then
                        not_in_record[data_type] = {}
                    end
                    table.insert(not_in_record[data_type], data_name)
                end
            end
        end
    end

    return not_in_record
end

-- 在data.raw中找出含有keyword的条目
function Data_raw:find_item_with_key_word(keyword)
    local item_with_keyword = {}

    for prot_type, prot_type_data in pairs(data.raw) do
        for prot_name, prot_name_data in pairs(prot_type_data) do
            -- 有keyword
            if prot_name_data[keyword] then
                if item_with_keyword[prot_type] == nil then
                    item_with_keyword[prot_type] = {}
                end

                if item_with_keyword[prot_type][prot_name] == nil then
                    item_with_keyword[prot_type][prot_name] = "Have " .. keyword
                end
            end
        end
    end

    return item_with_keyword
end

-- 删除配方中指定的项目
-- mod_type: results or ingredients
-- exclude_list: 排除列表
function Data_raw:recipe_delete_by_name(mod_type, keyword, exclude_list)
    if not exclude_list then
        exclude_list = {}
    end

    local modify_list = {}

    for recipe_name, recipe_data in pairs(data.raw.recipe) do
        local moded = false
        if not exclude_list[recipe_name] and
            recipe_data[mod_type] and
            table_size(recipe_data[mod_type]) > 1 then
            for index, result in ipairs(recipe_data[mod_type]) do
                if result[1] == keyword or
                    result.name == keyword then
                    table.remove(recipe_data[mod_type], index)
                    moded = true
                end
            end
        end

        if not exclude_list[recipe_name] and
            recipe_data.normal and
            recipe_data.normal[mod_type] and
            table_size(recipe_data.normal[mod_type]) > 1 then
            for index, result in ipairs(recipe_data.normal[mod_type]) do
                if result[1] == keyword or
                    result.name == keyword then
                    table.remove(recipe_data.normal[mod_type], index)
                    moded = true
                end
            end
        end

        if not exclude_list[recipe_name] and
            recipe_data.expensive and
            recipe_data.expensive[mod_type] and
            table_size(recipe_data.expensive[mod_type]) > 1 then
            for index, result in ipairs(recipe_data.expensive[mod_type]) do
                if result[1] == keyword or
                    result.name == keyword then
                    table.remove(recipe_data.expensive[mod_type], index)
                    moded = true
                end
            end
        end

        if moded then
            table.insert(modify_list, recipe_name)
        end
    end


    return modify_list
end

function Data_raw:insert_data_raw_field_value(field_path, value)
    if not field_path then
        return false
    end

    local path_count = table_size(field_path)
    local tmp_pos = data.raw

    -- field_path = {"mining-drill", "burner-mining-drill", "module_specification", "module_slots"}
    for i = 1, path_count - 1, 1 do
        if type(tmp_pos[field_path[i]]) ~= "nil" then -- 字段存在
            tmp_pos = tmp_pos[field_path[i]]
        else                                          -- 字段不存在
            -- 当field_path[i] == "_" 插入一个空表
            if field_path[i] ~= "_" then
                tmp_pos[field_path[i]] = {}
                tmp_pos = tmp_pos[field_path[i]]
            else
                local tmp_count = table_size(tmp_pos)
                tmp_pos[tmp_count + 1] = {}
                tmp_pos = tmp_pos[tmp_count]
            end
        end
    end

    tmp_pos[field_path[path_count]] = value

    return true
end

function Data_raw:set_data_raw_field_value(field_path, new_value)
    if not field_path then
        return nil
    end

    local path_count = table_size(field_path)
    local tmp_pos = data.raw

    -- field_path = {"module", "speed-module", "limitation"}
    for i = 1, path_count - 1, 1 do
        if type(tmp_pos) ~= "table" then
            return nil
        end

        tmp_pos = tmp_pos[field_path[i]]
        -- i = 1; tmp_pos = data.raw["module"]
        -- i = 2; tmp_pos = data.raw["module"]["speed-module"]
    end

    local old_value = deepcopy(tmp_pos[field_path[path_count]])

    if old_value then
        -- data.raw["module"]["speed-module"]["limitation"] = new_value
        tmp_pos[field_path[path_count]] = new_value
    end

    return old_value
end

function Data_raw:get_data_raw_field_value(field_path)
    local tmp_pos = data.raw

    -- field_path = {"module", "speed-module", "limitation"}
    for i = 1, table_size(field_path), 1 do
        if type(tmp_pos) ~= "table" then
            return nil
        end

        tmp_pos = tmp_pos[field_path[i]]
        -- i = 1; tmp_pos = data.raw["module"]
        -- i = 2; tmp_pos = data.raw["module"]["speed-module"]
        -- i = 3; tmp_pos = data.raw["module"]["speed-module"]["limitation"]
    end

    -- return deepcopy(tmp_pos)
    return tmp_pos
end

function Data_raw:execute_modify(data_raw_modifi_catalog)
    if data_raw_modifi_catalog then
        self.data_raw_modifi_catalog = data_raw_modifi_catalog
    end

    if self.data_raw_modifi_catalog == nil then
        return false
    end

    for prot_type, prot_modify_param in pairs(self.data_raw_modifi_catalog) do
        -- prot_type = 原型类型："boiler", "generator"...
        -- prot_modify_param = 修改参数：{ orig = { "boiler" }, mod = { }, mul = value, modify_parameter = {}...}

        local prot_name_tab = prot_modify_param.orig
        local is_moded, is_other = false, false

        if prot_name_tab == nil then
            goto JUDG_MOD
        end

        ::PROCESS_PROT_NAME::
        for _, prot_name in ipairs(prot_name_tab) do
            -- 没有修改参数则跳过此名字
            if prot_modify_param.modify_parameter == nil then
                goto NEXT_PROT_NAME
            end

            -- mul == 0 or 1 跳过此名字
            if prot_modify_param.mul == 0 or prot_modify_param.mul == 1 then
                if self.is_log then
                    log(prot_type .. "." .. prot_name .. " : mul = " .. prot_modify_param.mul .. ", Skip this config")
                end

                goto NEXT_PROT_NAME
            end

            for _, single_modify_param in ipairs(prot_modify_param.modify_parameter) do
                -- 组装修改字段路径
                local modify_field_path = {}
                table.insert(modify_field_path, prot_type)
                table.insert(modify_field_path, prot_name)
                for _, value in ipairs(single_modify_param.path) do
                    table.insert(modify_field_path, value) -- modify_field_path = { "boiler", "boiler", "energy_source", "emissions_per_minute" }
                end

                local old_value = self:get_data_raw_field_value(modify_field_path)
                local new_value = nil

                if old_value then                         -- 存在相应字段
                    if not single_modify_param.value then -- 不存在指定设置的值
                        -- 获取原字段单位
                        local field_units
                        if type(old_value) == "string" then
                            _, field_units = old_value:match('([%-+]?[0-9]*%.?[0-9]+)([yzafpnumcdhkKMGTPEZYJW]?)')
                            if string.len(field_units) ~= 0 then
                                -- 有单位，则获取单位
                                field_units = string.sub(old_value, -1)
                            end
                        end

                        old_value = self:exponent_number(old_value)

                        -- operation = nil : (默认值)做乘法
                        -- operation = Div : 做除法
                        if single_modify_param.operation == nil then
                            new_value = old_value * prot_modify_param.mul
                        elseif single_modify_param.operation == "Division" then
                            new_value = old_value / prot_modify_param.mul
                        end

                        -- max_value ~= nil : new_value = max_value
                        if single_modify_param.max_value then
                            if new_value > single_modify_param.max_value then
                                new_value = single_modify_param.max_value
                            end
                        end

                        -- min_value ~= nil : new_value = min_value
                        if single_modify_param.min_value then
                            if new_value < single_modify_param.min_value then
                                new_value = single_modify_param.min_value
                            end
                        end

                        -- 添加单位
                        if field_units then
                            new_value = new_value .. field_units
                        end
                    elseif single_modify_param.value == "nil" then   -- 存在指定设置的值 nil
                        new_value = nil
                    elseif single_modify_param.value == "false" then -- 存在指定设置的值 false
                        new_value = false
                    else                                             -- 存在指定设置的值
                        new_value = single_modify_param.value
                    end

                    old_value = self:set_data_raw_field_value(modify_field_path, new_value)

                    -- 日志
                    if self.is_log then
                        if type(new_value) == "table" then
                            new_value = common_core:serpent_line(new_value)
                        end

                        if type(old_value) == "table" then
                            old_value = common_core:serpent_line(old_value)
                        end
                        log(table.concat(modify_field_path, ".") ..
                            " : " .. tostring(old_value) .. " ---> " .. tostring(new_value))
                    end

                    -- 做记录
                    self:record(prot_type, prot_name)
                    --
                elseif single_modify_param.operation == "Extend" then -- 不存在相应字段，进行扩展字段
                    -- 校验是否存在相应的实体
                    if self:get_data_raw_field_value({ prot_type, prot_name }) == nil then
                        goto NEXT_MODIFY_PARAM
                    end

                    new_value = single_modify_param.value
                    self:insert_data_raw_field_value(modify_field_path, new_value)

                    -- 日志
                    if self.is_log then
                        if type(new_value) == "table" then
                            new_value = common_core:serpent_line(new_value)
                        end
                        log(table.concat(modify_field_path, ".") .. " : insert value ---> " .. tostring(new_value))
                    end

                    -- 做记录
                    self:record(prot_type, prot_name)
                    --
                else -- 不存在相应字段
                    if self.is_log then
                        log(table.concat(modify_field_path, ".") .. " is nil")
                    end
                end

                ::NEXT_MODIFY_PARAM::
            end

            ::NEXT_PROT_NAME::
        end

        -- 判断对mod进行处理
        ::JUDG_MOD::
        if settings.startup["x-custom-game-affect-mod-flags"].value and
            not is_moded and
            prot_modify_param.mod then
            prot_name_tab = prot_modify_param.mod
            is_moded = true

            goto PROCESS_PROT_NAME
        end

        if settings.startup["x-custom-game-affects-other-untested-mod-flags"].value and
            not is_other and
            prot_modify_param.other then
            prot_name_tab = prot_modify_param.other
            is_other = true
            goto PROCESS_PROT_NAME
        end
    end

    return true
end

function Data_raw:add_other_untested_list(source_table)
    local moded_list = {}
    for prot_type, prot_type_data in pairs(source_table) do
        if not moded_list[prot_type] then
            moded_list[prot_type] = {}
        end

        if prot_type_data.orig then
            for _, prot_name in ipairs(prot_type_data.orig) do
                moded_list[prot_type][prot_name] = true
            end
        end

        if prot_type_data.mod then
            for _, prot_name in ipairs(prot_type_data.mod) do
                moded_list[prot_type][prot_name] = true
            end
        end
    end

    for source_prot_type, _ in pairs(source_table) do
        local other_untested_list = {}

        for prot_name, _ in pairs(data.raw[source_prot_type]) do
            if not moded_list[source_prot_type][prot_name] then
                table.insert(other_untested_list, prot_name)
            end
        end

        if table_size(other_untested_list) > 0 then
            source_table[source_prot_type].other = other_untested_list
            log(source_prot_type ..
                ".other_untested_list: \n" .. common_core:serpent_block(source_table[source_prot_type].other))
        end
    end
end

-- from __stdlib__/stdlib/utils/string，增加一个大写 K
local exponent_multipliers = {
    ['y'] = 0.000000000000000000000001,
    ['z'] = 0.000000000000000000001,
    ['a'] = 0.000000000000000001,
    ['f'] = 0.000000000000001,
    ['p'] = 0.000000000001,
    ['n'] = 0.000000001,
    ['u'] = 0.000001,
    ['m'] = 0.001,
    ['c'] = 0.01,
    ['d'] = 0.1,
    [' '] = 1,
    ['h'] = 100,
    ['k'] = 1000,
    ['K'] = 1000,
    ['M'] = 1000000,
    ['G'] = 1000000000,
    ['T'] = 1000000000000,
    ['P'] = 1000000000000000,
    ['E'] = 1000000000000000000,
    ['Z'] = 1000000000000000000000,
    ['Y'] = 1000000000000000000000000
}

-- from __stdlib__/stdlib/utils/string，增加一个大写 K
--- Convert a metric string prefix to a number value.
-- @tparam string str
-- @treturn float
function Data_raw:exponent_number(str)
    if type(str) == 'string' then
        local value, exp = str:match('([%-+]?[0-9]*%.?[0-9]+)([yzafpnumcdhkKMGTPEZY]?)') -- 增加一个大写 K
        exp = exp or ' '
        value = (value or 0) * (exponent_multipliers[exp] or 1)
        return value
    elseif type(str) == 'number' then
        return str
    end
    return 0
end

return Data_raw
