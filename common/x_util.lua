local XUtil = {}

-- 检查表中是否包含指定值
function XUtil.table_contains(tbl, value)
    for _, v in pairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

-- 根据filter_function函数过滤，并返回结果表
function XUtil.find_with_filter(target_table, filter_function)
    local result = {}

    for key_type, type_data in pairs(target_table) do
        for key_name, name_data in pairs(type_data) do
            if filter_function(name_data) then
                result[key_type] = result[key_type] or {}
                table.insert(result[key_type], key_name)
            end
        end
    end

    return result
end


return XUtil
