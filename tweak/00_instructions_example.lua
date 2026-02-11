-- IMPORTANT: 使用 `name = { "*"} ` 通配符时请谨慎。它会影响所有匹配类型下的原型，可能导致意外行为。
-- 建议尽可能通过 `exclude_names` 进行精确控制，或在测试环境中充分验证。

local instructions = {
    -- 全部修改
    {
        type = "type_any",
        name = { "*" },
        exclude_names = { "name_1", "name_2" }, --排除列表
        operations = {
            -- 直接属性修改
            parameter_1 = { type = "multiply", value = 2 },                 -- 将parameter_1的值乘以2
            parameter_2 = { type = "division", value = 2 },                 -- 将parameter_2的值除以2
            parameter_3 = { type = "multiply", value = 2, max_value = 64 }, -- 将parameter_3的值乘以2，且新值的最大值是64
            parameter_4 = { type = "division", value = 2, min_value = 1 },  -- 将parameter_4的值除以2，且新值的最小值是1
            parameter_5 = { type = "set", value = 2 },                      -- 将parameter_5的值更新为2(type = "set", 原值必须存在)
            parameter_6 = { type = "set", value = nil },                    -- 将parameter_x的值设置为nil。注意：某些Factorio原型字段设置为nil可能导致默认行为或错误。
            parameter_7 = { type = "set", value = { key = 1001 } },         -- 将parameter_6的值更新为{ key = 1001}。

            -- 插入新值
            parameter_8 = { type = "insert", value = 16 }, -- parameter_7 = 16(type = "insert", 原值必须不存在)

            -- 嵌套属性修改
            ["parameters.parameter_1"] = { type = "multiply", value = 2 },
            ["parameters.parameter_1[2].parameter_2"] = { type = "division", value = 2 },
            ["parameters.parameter_1[3].parameter_3"] = { type = "insert", value = { key = 16 } }, -- 插入新键值对：["parameters.parameter_1[3].parameter_3"] = {  key = 16 }。
        }
    },
    -- 特定个例修改
    {
        type = "type_any",
        name = { "name_1", "name_2", "name_3", "name_n" },
        operations = {
            -- 同上
        }
    },
    -- 删除/移除列表元素 (通过设置为nil)
    {
        type = "furnace", -- 假设对熔炉进行修改
        name = { "stone-furnace" },
        operations = {
            -- 示例：移除特定燃料类别的燃料（如果API支持设置为nil来移除）
            ["fuel_categories[1]"] = { type = "set", value = nil },
        }
    },
    -- 修改列表项中的特定属性
    {
        type = "burner-mining-drill", -- 假设对采矿机进行修改
        name = { "burner-mining-drill" },
        operations = {
            -- 示例：修改特定流体盒子（fluid_box）的连接类型
            ["fluid_box.pipe_connections[1].connection_type"] = { type = "set", value = "input" },
            ["fluid_box.pipe_connections[1].position[1]"] = { type = "set", value = -1.5 },
        }
    },
    -- 修改字符串设置 (例如，自定义无限科技公式)
    {
        type = "string-setting",
        name = { "x-custom-game-infinite-technology-count-formula" },
        operations = {
            ["default_value"] = { type = "set", value = "L*200 + 500" },
        }
    },
    -- 通配符与排除结合的复杂示例
    {
        type = "assembling-machine", -- 组装机
        name = { "*" }, -- 匹配所有组装机
        exclude_names = { "assembling-machine-1", "assembling-machine-2" }, -- 排除特定组装机
        operations = {
            ["crafting_speed"] = { type = "multiply", value = 1.5 }, -- 将排除列表之外的所有组装机制造速度提高1.5倍
        }
    }
}
