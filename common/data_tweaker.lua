local Core = require("core")
local deepcopy = Core.lib_core_util.table.deepcopy
local x_string = Core.x_string
local log = Core.Log

local DataTweaker = {}

setmetatable(DataTweaker, DataTweaker)

-- 帮助函数：检查一个表是否包含特定值
function DataTweaker.table_contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

-- 辅助函数：解析嵌套字段路径
local function resolve_nested_field(table, path)
    local current_value = table
    local parent, last_field

    for part in path:gmatch("[^.]+") do
        local field, index = part:match("([%w_]+)%[(%d+)%]")

        if field then
            -- 处理带索引的字段（如 `some_field[2]`）
            current_value = current_value[field]
            index = tonumber(index)
            parent, last_field = current_value, index
            current_value = current_value[index]
        else
            -- 普通字段（不带索引的部分，如 `field_name`）
            parent, last_field = current_value, part
            current_value = current_value[part]
        end

        -- 如果字段不存在，提前退出
        if current_value == nil then
            break
        end
    end

    -- 返回最后一级字段的父表和字段名称
    return parent, last_field
end

-- 主函数：根据指令表修改目标数据表
function DataTweaker.modify_data(target_table, instructions)
    local modified_items = {} -- 用于保存修改过的项目

    for _, instruction in pairs(instructions) do
        local target_type = instruction.type
        local exclude_names = instruction.exclude_names or {}

        for _, target_name in pairs(instruction.name) do
            for name_in_table, prototype in pairs(target_table[target_type] or {}) do
                if (target_name == "*" or target_name == name_in_table) and not DataTweaker.table_contains(exclude_names, name_in_table) then
                    for field, operation in pairs(instruction.operations) do
                        local parent, last_field = resolve_nested_field(prototype, field)

                        if parent and operation.type == "insert" then
                            -- 如果已存在，则跳过
                            if parent[last_field] then
                                log(string.format("Warn: %s.%s.%s: Is existed --> %s", target_type, name_in_table, field,
                                    Core.format_log_value(parent[last_field])))
                            else
                                parent[last_field] = deepcopy(operation.value)
                                log(string.format("%s.%s.%s: inserted --> %s", target_type, name_in_table, field,
                                    Core.format_log_value(operation.value)))
                            end
                        elseif parent and parent[last_field] then
                            local old_value = deepcopy(parent[last_field])

                            -- 处理单位
                            local original_value, unit = x_string.exponent_number(old_value)
                            local modified_value = original_value

                            -- 执行修改
                            if operation.type == "set" then
                                modified_value = operation.value
                            elseif operation.type == "division" then
                                modified_value = original_value / operation.value
                            elseif operation.type == "multiply" then
                                modified_value = original_value * operation.value
                            end

                            if operation.type ~= "set" then
                                -- 应用最大值和最小值约束
                                if operation.max_value then
                                    modified_value = math.min(modified_value, operation.max_value)
                                end
                                if operation.min_value then
                                    modified_value = math.max(modified_value, operation.min_value)
                                end
                            end

                            -- 将修改后的值更新到原始位置
                            if unit == "" then
                                parent[last_field] = deepcopy(modified_value)
                            else
                                parent[last_field] = x_string.number_to_exponent_string(modified_value, unit)
                            end

                            -- 记录修改过的项
                            modified_items[target_type] = modified_items[target_type] or {}
                            if not DataTweaker.table_contains(modified_items[target_type], name_in_table) then
                                table.insert(modified_items[target_type], name_in_table)
                            end

                            -- 打印调试日志
                            log(string.format("%s.%s.%s: %s --> %s", target_type, name_in_table, field,
                                Core.format_log_value(old_value), Core.format_log_value(parent[last_field])))
                        else
                            log(string.format("Warn: %s.%s.%s: Not exist", target_type, name_in_table, field))
                        end
                    end
                end
            end
        end
    end

    return modified_items -- 返回修改过的项
end

return DataTweaker
