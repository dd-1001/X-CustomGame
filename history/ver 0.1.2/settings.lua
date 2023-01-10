data:extend({{
    type = "double-setting",
    name = "x-custom-game-boiler-performance-multiplier", -- 锅炉
    setting_type = "startup",
    default_value = 10,
    minimum_value = 1,
    maximum_value = 1000,
    order = "electricity-1001"
}, {
    type = "double-setting",
    name = "x-custom-game-steam-engine-performance-multiplier", -- 蒸汽机
    setting_type = "startup",
    default_value = 10,
    minimum_value = 1,
    maximum_value = 1000,
    order = "electricity-1002"
}, {
    type = "double-setting",
    name = "x-custom-game-solar-panel-performance-multiplier", -- 太阳能板
    setting_type = "startup",
    default_value = 1,
    minimum_value = 1,
    maximum_value = 1000,
    order = "electricity-1003"
}, {
    type = "double-setting",
    name = "x-custom-game-accumulator-performance-multiplier", -- 蓄电池
    setting_type = "startup",
    default_value = 100,
    minimum_value = 1,
    maximum_value = 1000,
    order = "electricity-1004"
}, {
    type = "double-setting",
    name = "x-custom-game-nuclear-reactor-performance-multiplier", -- 核反应堆
    setting_type = "startup",
    default_value = 10,
    minimum_value = 1,
    maximum_value = 1000,
    order = "electricity-1005"
}, {
    type = "double-setting",
    name = "x-custom-game-heat-pipe-performance-multiplier", -- 热管
    setting_type = "startup",
    default_value = 10,
    minimum_value = 1,
    maximum_value = 1000,
    order = "electricity-1006"
}, {
    type = "double-setting",
    name = "x-custom-game-heat-exchanger-performance-multiplier", -- 换热器
    setting_type = "startup",
    default_value = 10,
    minimum_value = 1,
    maximum_value = 1000,
    order = "electricity-1007"
}, {
    type = "double-setting",
    name = "x-custom-game-steam-turbine-performance-multiplier", -- 汽轮机
    setting_type = "startup",
    default_value = 10,
    minimum_value = 1,
    maximum_value = 1000,
    order = "electricity-1008"
}
})

--[[ 测试
data:extend(
{
    type = "bool-setting",
    name = "x-custom-game-test-setting1",
    setting_type = "startup",
    default_value = true,
    order = "1001"
}, {
    type = "int-setting",
    name = "x-custom-game-test-setting2",
    setting_type = "startup",
    default_value = 1,
    minimum_value = 0,
    maximum_value = 100,
    order = "1002"
}, {
    type = "double-setting",
    name = "x-custom-game-test-setting3",
    setting_type = "startup",
    default_value = 1.0,
    minimum_value = 0.0,
    maximum_value = 100.0,
    order = "1003"
}, {
    type = "string-setting",
    name = "x-custom-game-test-setting4",
    setting_type = "startup",
    default_value = "option-02",
    allowed_values = {"option-01", "option-02", "option-03"},
    order = "1004"
})
]]
