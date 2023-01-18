data:extend({
    {
        type = "bool-setting",
        name = "x-custom-game-effect-mod-flags",
        setting_type = "startup",
        default_value = false,
        order = "1001"
    }, {
        type = "double-setting",
        name = "x-custom-game-container-performance-multiplier", -- 箱子
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-1001"
    }, {
        type = "double-setting",
        name = "x-custom-game-storage-tank-performance-multiplier", -- 储液罐
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.01,
        maximum_value = 1000,
        order = "x-custom-game-1003"
    }, {
        type = "double-setting",
        name = "x-custom-game-locomotive-inventory-size-multiplier", -- 机车车厢库存
        setting_type = "startup",
        default_value = 5,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-1005"
    }, {
        type = "double-setting",
        name = "x-custom-game-belt-performance-multiplier", -- 传送带
        setting_type = "startup",
        default_value = 4,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-1007"
    }, {
        type = "double-setting",
        name = "x-custom-game-inserter-performance-multiplier", -- 机械臂
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-1009"
    }, {
        type = "double-setting",
        name = "x-custom-game-electricity-transmission-performance-multiplier", -- 电力输送：电线杆
        setting_type = "startup",
        default_value = 5,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-1011"
    }, {
        type = "double-setting",
        name = "x-custom-game-boiler-performance-multiplier", -- 锅炉
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-1013"
    }, {
        type = "double-setting",
        name = "x-custom-game-generator-performance-multiplier", -- 发电机
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-1015"
    }, {
        type = "double-setting",
        name = "x-custom-game-solar-panel-performance-multiplier", -- 太阳能板
        setting_type = "startup",
        default_value = 1,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-1017"
    }, {
        type = "double-setting",
        name = "x-custom-game-accumulator-performance-multiplier", -- 蓄电池
        setting_type = "startup",
        default_value = 100,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-1019"
    }, {
        type = "double-setting",
        name = "x-custom-game-reactor-performance-multiplier", -- 核反应堆
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-1021"
    }, {
        type = "double-setting",
        name = "x-custom-game-heat-pipe-performance-multiplier", -- 热管
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-1023"
    }, {
        type = "double-setting",
        name = "x-custom-game-pipe-system-performance-multiplier", -- 管道系统
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.2,
        maximum_value = 5,
        order = "x-custom-game-1025"
    }, {
        type = "double-setting",
        name = "x-custom-game-robot-performance-multiplier", -- 机器人
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-1027"
    }, {
        type = "double-setting",
        name = "x-custom-game-roboport-performance-multiplier", -- 机器人指令平台
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.1,
        maximum_value = 100,
        order = "x-custom-game-1029"
    }, {
        type = "double-setting",
        name = "x-custom-game-mining-drill-performance-multiplier", -- 采矿-钻探
        setting_type = "startup",
        default_value = 6,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-1031"
    }, {
        type = "double-setting",
        name = "x-custom-game-furnace-performance-multiplier", -- 熔炉
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-1033"
    }, {
        type = "double-setting",
        name = "x-custom-game-assembling-machine-performance-multiplier", -- 装配机
        setting_type = "startup",
        default_value = 5,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-1035"
    }, {
        type = "double-setting",
        name = "x-custom-game-fuel-performance-multiplier", -- 燃料：木板、煤矿、核能燃料等
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-1037"
    }, {
        type = "double-setting",
        name = "x-custom-game-locomotive-performance-multiplier", -- 机车
        setting_type = "startup",
        default_value = 0.5,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-1039"
    }, {
        type = "double-setting",
        name = "x-custom-game-repair-tool-performance-multiplier", -- 修理工具
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-1041"
    }, {
        type = "double-setting",
        name = "x-custom-game-car-performance-multiplier", -- 车(包括坦克)
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-1043"
    }, {
        type = "double-setting",
        name = "x-custom-game-spider-vehicle-performance-multiplier", -- 蜘蛛机甲
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-1045"
    }, {
        type = "double-setting",
        name = "x-custom-game-lab-performance-multiplier", -- 研究中心
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-1047"
    }, {
        type = "int-setting",
        name = "x-custom-game-number-of-module-slots", -- 插槽数量
        setting_type = "startup",
        default_value = 30,
        minimum_value = 1,
        maximum_value = 30,
        order = "x-custom-game-1049"
    }, {
        type = "double-setting",
        name = "x-custom-game-beacon-performance-multiplier", -- 插件效果分享塔
        setting_type = "startup",
        default_value = 5,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-1051"
    }, {
        type = "double-setting",
        name = "x-custom-game-module-performance-multiplier", -- 插件
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-1053"
    }, {
        type = "double-setting",
        name = "x-custom-game-rocket-silo-performance-multiplier", -- 火箭发射井
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-1055"
    }, {
        type = "double-setting",
        name = "x-custom-game-satellite-performance-multiplier", -- 卫星
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-1057"
    }, {
        type = "double-setting",
        name = "x-custom-game-gun-performance-multiplier", -- 枪
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.01,
        maximum_value = 10,
        order = "x-custom-game-1059"
    }, {
        type = "double-setting",
        name = "x-custom-game-land-mine-performance-multiplier", -- 地雷
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.01,
        maximum_value = 10,
        order = "x-custom-game-1061"
    }, {
        type = "double-setting",
        name = "x-custom-game-ammo-performance-multiplier", -- 弹药
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.01,
        maximum_value = 10,
        order = "x-custom-game-1063"
    }, {
        type = "double-setting",
        name = "x-custom-game-grenade-performance-multiplier", -- 手雷
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.01,
        maximum_value = 10,
        order = "x-custom-game-1065"
    }, {
        type = "double-setting",
        name = "x-custom-game-armor-performance-multiplier", -- 护甲
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.01,
        maximum_value = 10,
        order = "x-custom-game-1067"
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
