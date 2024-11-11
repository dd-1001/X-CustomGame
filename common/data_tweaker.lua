local Core = require("core") -- 引入Core模块
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
                        -- 获取可能的索引（如 pipe_connections[2]）
                        local part, index = field_part:match("([%w_]+)%[(%d+)%]")

                        if part then
                            -- 存在索引的情况
                            value = value[part]
                            value = value[tonumber(index)]
                        else
                            -- 没有索引的情况
                            value = value[field_part]
                        end

                        -- 检查是否到达最终字段
                        if i == #fields then
                            if value then
                                local old_value = value
                                -- 处理单位
                                local original_value, unit = x_string.exponent_number(value)

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
                                    value = original_value                   -- 没有单位的情况下直接存为数值
                                else
                                    value = tostring(original_value) .. unit -- 含有单位则存为字符串
                                end

                                -- 记录修改过的项
                                modified_items[target_type] = modified_items[target_type] or {}
                                if not DataTweaker.table_contains(modified_items[target_type], name) then
                                    table.insert(modified_items[target_type], name)
                                end

                                -- 打印调试日志
                                log(string.format("%s.%s.%s: %s --> %s", target_type, name, field, old_value,
                                    value))
                            else
                                log(string.format("Warn: %s.%s.%s: Not exist", target_type, name, field))
                            end
                        end

                        -- 如果任何层级为空则退出
                        if not value then break end
                    end
                end
            end
        end
    end

    return modified_items -- 返回修改过的项
end

return DataTweaker
