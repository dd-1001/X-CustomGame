local instructions = {
    -- 泛型修改
    {
        type = "type_any",
        name = "*",
        exclude_names = { "name_1", "name_2" }, --排除列表
        operations = {
            -- 直接属性修改
            parameter_1 = { type = "multiply", value = 2 },                 -- 将parameter_1的值乘以2
            parameter_2 = { type = "division", value = 2 },                 -- 将parameter_2的值除以2
            parameter_3 = { type = "multiply", value = 2, max_value = 64 }, -- 将parameter_3的值乘以2，且新值的最大值是64
            parameter_4 = { type = "division", value = 2, min_value = 1 },  -- 将parameter_4的值除以2，且新值的最小值是1
            parameter_5 = { type = "set", value = 2 },                      -- 将parameter_5的值更新为2
            parameter_6 = { type = "set", value = { key = 1001 } },         -- 将parameter_6的值更新为{ key = 1001}

            -- 插入新值
            parameter_7 = { type = "insert", value = 16 }, -- parameter_7 = 16

            -- 嵌套属性修改
            ["parameters.parameter_1"] = { type = "multiply", value = 2 },
            ["parameters.parameter_1[2].parameter_2"] = { type = "division", value = 2 },
            ["parameters.parameter_1[3].parameter_3"] = { type = "insert", value = { key = 16 } }, -- 插入新键值对：["parameters.parameter_1[3].parameter_3"] = {  key = 16 }
        }
    },
    -- 个例修改
    {
        type = "type_any",
        name = "name_any",
        operations = {
            -- 同上
        }
    }
}
