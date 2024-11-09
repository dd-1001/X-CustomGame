local instructions = {
    -- 泛型修改
    {
        type = "type_any",
        name = "*",
        exclude_names = { "name_1", "name_2" }, --排除列表
        operations = {
            -- 直接属性修改
            parameter_1 = { type = "multiply", value = 2 },                 -- 将原值乘以2
            parameter_2 = { type = "division", value = 2 },                 -- 将原值除以2
            parameter_3 = { type = "multiply", value = 2, max_value = 64 }, -- 将原值乘以2，且新值的最大值是64
            parameter_4 = { type = "division", value = 2, min_value = 1 },  -- 将原值除以2，且新值的最小值是1

            -- 嵌套属性修改
            ["parameters.parameter_1"] = { type = "multiply", value = 2 },
            ["parameters.parameter_1.parameter_2"] = { type = "multiply", value = 2 },
        }
    },
    -- 个例修改
    {
        type = "type_any",
        name = "name_any",
        operations = {
            -- 直接属性修改
            parameter_1 = { type = "multiply", value = 2 },                 -- 将原值乘以2
            parameter_2 = { type = "division", value = 2 },                 -- 将原值除以2
            parameter_3 = { type = "multiply", value = 2, max_value = 64 }, -- 将原值乘以2，且新值的最大值是64
            parameter_4 = { type = "division", value = 2, min_value = 1 },  -- 将原值除以2，且新值的最小值是1

            -- 嵌套属性修改
            ["parameters.parameter_1"] = { type = "multiply", value = 2 },
            ["parameters.parameter_1.parameter_2"] = { type = "multiply", value = 2 },
        }
    }
}
