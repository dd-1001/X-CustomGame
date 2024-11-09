local Core = require("core") -- 引入Core模块
local log = Core.Log

local DataTweaker = {}

setmetatable(DataTweaker, DataTweaker)

-- 单位转换字典
local exponent_multipliers = {
    ['y'] = 1e-24,
    ['z'] = 1e-21,
    ['a'] = 1e-18,
    ['f'] = 1e-15,
    ['p'] = 1e-12,
    ['n'] = 1e-9,
    ['u'] = 1e-6,
    ['m'] = 1e-3,
    ['c'] = 1e-2,
    ['d'] = 1e-1,
    [' '] = 1,
    ['h'] = 1e2,
    ['k'] = 1e3,
    ['K'] = 1e3,
    ['M'] = 1e6,
    ['G'] = 1e9,
    ['T'] = 1e12,
    ['P'] = 1e15,
    ['E'] = 1e18,
    ['Z'] = 1e21,
    ['Y'] = 1e24
}

-- 将单位字符串转换为数值和基本单位
function DataTweaker:exponent_number(str)
    if type(str) == 'string' then
        -- 提取数值、前缀和基本单位
        local value, prefix, basic_unit = str:match('([%-+]?[0-9]*%.?[0-9]+)([yzafpnumcdhkKMGTPEZY]?)(%a*)$')

        prefix = prefix or ' '        -- 若没有前缀，默认为 1 倍
        basic_unit = basic_unit or '' -- 如果没有基本单位，默认设为空字符串

        if value then
            -- 返回标准化的数值和基本单位
            return tonumber(value) * (exponent_multipliers[prefix] or 1), basic_unit
        else
            error("Invalid string format: " .. tostring(str))
        end
    elseif type(str) == 'number' then
        return str, "" -- 如果输入是数字，直接返回数值和空单位
    end
    error("Expected a string or number, got: " .. tostring(str))
end

-- 帮助函数：检查一个表是否包含特定值
function DataTweaker.table_contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

-- 主函数：根据指令表修改目标数据表
function DataTweaker.modify_data(target_table, instructions)
    local modified_items = {} -- 用于保存修改过的项目

    for _, instruction in pairs(instructions) do
        local target_type = instruction.type
        local exclude_names = instruction.exclude_names or {}

        for name, prototype in pairs(target_table[target_type] or {}) do
            if (instruction.name == "*" or instruction.name == name) and not DataTweaker.table_contains(exclude_names, name) then
                for field, operation in pairs(instruction.operations) do
                    -- 使用路径解析修改嵌套属性
                    local value = prototype
                    local fields = {}
                    for field_part in field:gmatch("[^.]+") do
                        table.insert(fields, field_part)
                    end

                    for i, field_part in ipairs(fields) do
                        if i == #fields then
                            if value[field_part] then
                                local old_value = value[field_part]
                                -- 处理单位
                                local original_value, unit = DataTweaker:exponent_number(value[field_part])

                                -- 执行修改
                                if operation.type == "set" then
                                    original_value = operation.value
                                elseif operation.type == "division" then
                                    original_value = original_value / operation.value
                                elseif operation.type == "multiply" then
                                    original_value = original_value * operation.value
                                end

                                -- 应用最大值和最小值约束
                                if operation.max_value then
                                    original_value = math.min(original_value, operation.max_value)
                                end
                                if operation.min_value then
                                    original_value = math.max(original_value, operation.min_value)
                                end

                                -- 记录修改后的值
                                if unit == "" then
                                    value[field_part] = original_value                   -- 没有单位的情况下直接存为数值
                                else
                                    value[field_part] = tostring(original_value) .. unit -- 含有单位则存为字符串
                                end

                                -- 记录修改过的项
                                modified_items[target_type] = modified_items[target_type] or {}
                                if not DataTweaker.table_contains(modified_items[target_type], name) then
                                    table.insert(modified_items[target_type], name)
                                end

                                -- 打印调试日志
                                log(string.format("%s.%s.%s: %s --> %s", target_type, name, field, old_value,
                                    value[field_part]))
                            else
                                log(string.format("Warn: %s.%s.%s: Not exist", target_type, name, field))
                            end
                        else
                            value = value[field_part]
                            if not value then break end
                        end
                    end
                end
            end
        end
    end

    return modified_items -- 返回修改过的项
end

return DataTweaker
