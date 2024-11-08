local instructions = {
    {
        type = "accumulator",
        name = "*",
        exclude_names = {},
        operations = {
            -- 直接属性修改
            energy_capacity = { type = "multiply", value = 2 },    -- 将能量容量加倍
            input_flow_limit = { type = "multiply", value = 10000 }, -- 将输入流量限制扩大10000倍

            -- 嵌套属性修改
            ["parameters.energy.capacity"] = { type = "multiply", value = 2 },    -- 将嵌套的能量容量加倍
            ["parameters.input_flow_limit"] = { type = "multiply", value = 10000 }, -- 将嵌套的输入流量限制扩大10000倍
        }
    },
    -- 针对个例进行单独修改
    {
        type = "accumulator",
        name = "basic-accumulator",
        operations = {
            recharge_minimum = { type = "set", value = 0.6 }   -- 设置最低充电量为0.6
        }
    }
}