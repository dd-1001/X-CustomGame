local common_core = require("common/core")

local log = common_core.lib_logger("x-custom-game-data_raw.lua")

local Data_raw = {
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
X_CUSTOM_GAME_TAB_RECORD = {}

function Data_raw:record(data_type, data_name)
    if data_type == nil or data_name == nil then
        return
    end

    if X_CUSTOM_GAME_TAB_RECORD[data_type] == nil then
        X_CUSTOM_GAME_TAB_RECORD[data_type] = {}
    end

    if X_CUSTOM_GAME_TAB_RECORD[data_type][data_name] == nil then
        X_CUSTOM_GAME_TAB_RECORD[data_type][data_name] = true
    end

end

-- check_type == "data.raw" or check_type == "record"
function Data_raw:check_not_in_record(check_type)
    local not_in_record = {}

    if check_type == "data.raw" then
        for data_type, _ in pairs(data.raw) do
            for data_name, _ in pairs(data.raw[data_type]) do
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
            for data_name, _ in pairs(data.raw[data_type]) do
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

function Data_raw:insert_data_raw_field_value(field_path, value)

    if not field_path or not value then
        return false
    end

    local path_count = #field_path
    local tmp_pos = data.raw

    -- field_path = {"mining-drill", "burner-mining-drill", "module_specification", "module_slots"}
    for i = 1, path_count - 1, 1 do

        if type(tmp_pos[field_path[i]]) ~= "nil" then -- 字段存在
            tmp_pos = tmp_pos[field_path[i]]
        else -- 字段不存在
            -- 当field_path[i] == "_" 插入一个空表
            if field_path[i] ~= "_" then
                tmp_pos[field_path[i]] = {}
                tmp_pos = tmp_pos[field_path[i]]
            else
                tmp_pos[#tmp_pos + 1] = {}
                tmp_pos = tmp_pos[#tmp_pos]
            end
        end

    end

    tmp_pos[field_path[path_count]] = value

    return true

end

function Data_raw:set_data_raw_field_value(field_path, new_value)

    if not field_path or not new_value then
        return nil
    end

    local path_count = #field_path
    local tmp_pos = data.raw

    -- field_path = {"boiler", "boiler", "energy_source", "emissions_per_minute"}
    for i = 1, path_count - 1, 1 do
        if type(tmp_pos) ~= "table" then
            return nil
        end

        tmp_pos = tmp_pos[field_path[i]]
        -- i = 1; tmp_pos = data.raw["boiler"]
        -- i = 2; tmp_pos = data.raw["boiler"]["boiler"]
        -- i = 3; tmp_pos = data.raw["boiler"]["boiler"]["energy_source"]

    end

    local old_value = tmp_pos[field_path[path_count]]

    if old_value then
        -- data.raw["boiler"]["boiler"]["energy_source"]["emissions_per_minute"] = new_value
        tmp_pos[field_path[path_count]] = new_value
    end

    return old_value

end

function Data_raw:get_data_raw_field_value(field_path)

    local tmp_pos = data.raw

    -- field_path = {"boiler", "boiler", "energy_source", "emissions_per_minute"}
    for i = 1, #field_path, 1 do
        if type(tmp_pos) ~= "table" then
            return nil
        end

        tmp_pos = tmp_pos[field_path[i]]
        -- i = 1; tmp_pos = data.raw["boiler"]
        -- i = 2; tmp_pos = data.raw["boiler"]["boiler"]
        -- i = 3; tmp_pos = data.raw["boiler"]["boiler"]["energy_source"]
        -- i = 4; tmp_pos = data.raw["boiler"]["boiler"]["energy_source"]["emissions_per_minute"]
    end

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
        local is_moded = false
        ::MOD::
        for _, prot_name in ipairs(prot_name_tab) do
            -- prot_name = 原型名字："boiler"...

            -- 做记录
            self:record(prot_type, prot_name)

            for _, single_modify_param in ipairs(prot_modify_param.modify_parameter) do
                -- single_modify_param 单个修改参数

                -- 组装修改字段路径
                local modify_field_path = {}
                table.insert(modify_field_path, prot_type)
                table.insert(modify_field_path, prot_name)
                for _, value in ipairs(single_modify_param.path) do
                    table.insert(modify_field_path, value) -- modify_field_path = { "boiler", "boiler", "energy_source", "emissions_per_minute" }
                end

                local old_value = self:get_data_raw_field_value(modify_field_path)
                local new_value = nil

                if old_value then -- 存在相应字段

                    if single_modify_param.value == nil then -- 不存在指定设置的值

                        -- 获取原字段单位
                        local field_units
                        if type(old_value) == "string" then
                            _, field_units = old_value:match('([%-+]?[0-9]*%.?[0-9]+)([yzafpnumcdhkKJMGTPEZY]?)')
                            if string.len(field_units) ~= 0 then
                                -- 有单位，则获取单位
                                field_units = string.sub(old_value, -1)
                            end
                        end

                        old_value = self:exponent_number(old_value)

                        -- 如果mul == 0 不做修改
                        if prot_modify_param.mul == 0 or prot_modify_param.mul == 1 then
                            log(table.concat(modify_field_path, ".") .. " : mul = 0 or 1, Skip this config")
                            goto SET_NEW_VALUE_END
                        end

                        -- operation = nil : (默认值)做乘法
                        -- operation = Div : 做除法
                        if single_modify_param.operation == nil then
                            new_value = old_value * prot_modify_param.mul
                        elseif single_modify_param.operation == "Div" then
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
                    else -- 存在指定设置的值
                        new_value = single_modify_param.value
                    end

                    old_value = self:set_data_raw_field_value(modify_field_path, new_value)

                    -- 日志
                    if type(new_value) == "table" then
                        new_value = "{ " .. table.concat(new_value, ",") .. " }"
                    end
                    if type(old_value) == "table" then
                        old_value = "{ " .. table.concat(old_value, ",") .. " }"
                    end
                    log(table.concat(modify_field_path, ".") .. " : " .. old_value .. " ---> " .. new_value)

                    ::SET_NEW_VALUE_END::

                elseif single_modify_param.operation == "Extend" then -- 不存在相应字段，进行扩展字段
                    new_value = single_modify_param.value
                    self:insert_data_raw_field_value(modify_field_path, new_value)

                    -- 日志
                    if type(new_value) == "table" then
                        new_value = "{ " .. table.concat(new_value, ",") .. " }"
                    end
                    log(table.concat(modify_field_path, ".") .. " : insert value ---> " .. new_value)
                else -- 不存在相应字段
                    log(table.concat(modify_field_path, ".") .. " is nil")
                end
            end

            -- log(common_core:serialization_table(get_data_raw_field_value({prot_type, prot_name})))
        end

        -- 判断对mod进行处理
        if settings.startup["x-custom-game-effect-mod-flags"].value and
            not is_moded and
            prot_modify_param.mod then

            log("goto MOD lable")
            prot_name_tab = prot_modify_param.mod
            is_moded = true
            
            goto MOD
        end

    end

    return true
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
