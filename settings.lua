data:extend({
    {
        type = "bool-setting",
        name = "x-custom-game-effect-mod-flags",
        setting_type = "startup",
        default_value = true,
        order = "1001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-container-performance-multiplier", -- 箱子
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-101001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-storage-tank-performance-multiplier", -- 储液罐
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.01,
        maximum_value = 1000,
        order = "x-custom-game-101002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-locomotive-inventory-size-multiplier", -- 机车车厢库存
        setting_type = "startup",
        default_value = 5,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-101003"
    },
    {
        type = "double-setting",
        name = "x-custom-game-belt-performance-multiplier", -- 传送带
        setting_type = "startup",
        default_value = 4,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-102001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-inserter-performance-multiplier", -- 机械臂
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-103001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-electricity-transmission-performance-multiplier", -- 电力输送：电线杆
        setting_type = "startup",
        default_value = 5,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-104001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-boiler-performance-multiplier", -- 锅炉
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-104002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-generator-performance-multiplier", -- 发电机
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-104003"
    },
    {
        type = "double-setting",
        name = "x-custom-game-solar-panel-performance-multiplier", -- 太阳能板
        setting_type = "startup",
        default_value = 1,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-104004"
    },
    {
        type = "double-setting",
        name = "x-custom-game-accumulator-performance-multiplier", -- 蓄电池
        setting_type = "startup",
        default_value = 100,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-104005"
    },
    {
        type = "double-setting",
        name = "x-custom-game-reactor-performance-multiplier", -- 核反应堆
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-104006"
    },
    {
        type = "double-setting",
        name = "x-custom-game-heat-pipe-performance-multiplier", -- 热管
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-104007"
    },
    {
        type = "double-setting",
        name = "x-custom-game-pipe-system-performance-multiplier", -- 管道系统
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.2,
        maximum_value = 5,
        order = "x-custom-game-105001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-robot-performance-multiplier", -- 机器人
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-106001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-roboport-performance-multiplier", -- 机器人指令平台
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.1,
        maximum_value = 100,
        order = "x-custom-game-106002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-mining-drill-performance-multiplier", -- 采矿-钻探
        setting_type = "startup",
        default_value = 3,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-107001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-furnace-performance-multiplier", -- 熔炉
        setting_type = "startup",
        default_value = 3,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-107002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-assembling-machine-performance-multiplier", -- 装配机
        setting_type = "startup",
        default_value = 3,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-107003"
    },
    {
        type = "double-setting",
        name = "x-custom-game-fuel-performance-multiplier", -- 燃料：木板、煤矿、核能燃料等
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-108001"
    },
    {
        type = "bool-setting",
        name = "x-custom-game-infinite-resources-flag", -- 无限资源
        setting_type = "startup",
        default_value = true,
        order = "x-custom-game-108002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-locomotive-performance-multiplier", -- 机车
        setting_type = "startup",
        default_value = 0.5,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-109001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-repair-tool-performance-multiplier", -- 修理工具
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-109002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-car-performance-multiplier", -- 车(包括坦克)
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-109003"
    },
    {
        type = "double-setting",
        name = "x-custom-game-spider-vehicle-performance-multiplier", -- 蜘蛛机甲
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-109004"
    },
    {
        type = "double-setting",
        name = "x-custom-game-lab-performance-multiplier", -- 研究中心
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-109005"
    },
    {
        type = "int-setting",
        name = "x-custom-game-number-of-module-slots", -- 插槽数量
        setting_type = "startup",
        default_value = 30,
        minimum_value = 1,
        maximum_value = 30,
        order = "x-custom-game-109006"
    },
    {
        type = "double-setting",
        name = "x-custom-game-beacon-performance-multiplier", -- 插件效果分享塔
        setting_type = "startup",
        default_value = 5,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-109007"
    },
    {
        type = "double-setting",
        name = "x-custom-game-module-performance-multiplier", -- 插件
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-109008"
    },
    {
        type = "bool-setting",
        name = "x-custom-game-module-slot-all-type-allowed-flags", -- 插件槽允许所有类型的插件
        setting_type = "startup",
        default_value = true,
        order = "x-custom-game-109009"
    },
    {
        type = "double-setting",
        name = "x-custom-game-rocket-silo-performance-multiplier", -- 火箭发射井
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-109010"
    },
    {
        type = "double-setting",
        name = "x-custom-game-satellite-performance-multiplier", -- 卫星
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-109011"
    },
    {
        type = "double-setting",
        name = "x-custom-game-radar-performance-multiplier", -- 雷达
        setting_type = "startup",
        default_value = 5,
        minimum_value = 0.01,
        maximum_value = 10,
        order = "x-custom-game-109012"
    },
    {
        type = "double-setting",
        name = "x-custom-game-lamp-performance-multiplier", -- 灯
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.5,
        maximum_value = 10,
        order = "x-custom-game-109013"
    },
    {
        type = "double-setting",
        name = "x-custom-game-gun-performance-multiplier", -- 枪
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.01,
        maximum_value = 10,
        order = "x-custom-game-110001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-land-mine-performance-multiplier", -- 地雷
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.01,
        maximum_value = 10,
        order = "x-custom-game-110002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-ammo-performance-multiplier", -- 弹药
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.01,
        maximum_value = 10,
        order = "x-custom-game-110003"
    },
    {
        type = "double-setting",
        name = "x-custom-game-grenade-performance-multiplier", -- 手雷
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.01,
        maximum_value = 10,
        order = "x-custom-game-111001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-capsule-performance-multiplier", -- 胶囊
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.01,
        maximum_value = 10,
        order = "x-custom-game-111002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-combat-robot-performance-multiplier", -- 战斗机器人
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.01,
        maximum_value = 10,
        order = "x-custom-game-111003"
    },
    {
        type = "double-setting",
        name = "x-custom-game-armor-performance-multiplier", -- 护甲
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.01,
        maximum_value = 10,
        order = "x-custom-game-112001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-equipment-performance-multiplier", -- 装备模块
        setting_type = "startup",
        default_value = 100,
        minimum_value = 0.01,
        maximum_value = 1000,
        order = "x-custom-game-113001"
    },
    {
        type = "bool-setting",
        name = "x-custom-game-equipment-size-flags", -- 装备尺寸为1*1
        setting_type = "startup",
        default_value = true,
        order = "x-custom-game-113002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-wall-performance-multiplier", -- 墙
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.01,
        maximum_value = 10,
        order = "x-custom-game-114001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-ammo-turret-performance-multiplier", -- 弹药炮塔
        setting_type = "startup",
        default_value = 5,
        minimum_value = 0.01,
        maximum_value = 10,
        order = "x-custom-game-114002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-electric-turret-performance-multiplier", -- 电炮塔
        setting_type = "startup",
        default_value = 5,
        minimum_value = 0.01,
        maximum_value = 10,
        order = "x-custom-game-114003"
    },
    {
        type = "double-setting",
        name = "x-custom-game-fluid-turret-performance-multiplier", -- 流体炮塔
        setting_type = "startup",
        default_value = 5,
        minimum_value = 0.01,
        maximum_value = 10,
        order = "x-custom-game-114004"
    },
    {
        type = "double-setting",
        name = "x-custom-game-artillery-turret-performance-multiplier", -- 重炮炮塔
        setting_type = "startup",
        default_value = 5,
        minimum_value = 0.01,
        maximum_value = 10,
        order = "x-custom-game-114005"
    },
    {
        type = "double-setting",
        name = "x-custom-game-character-distance-multiplier", -- 角色距离相关
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.5,
        maximum_value = 100,
        order = "x-custom-game-115001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-character-mining-speed-multiplier", -- 角色采矿速度
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.5,
        maximum_value = 100,
        order = "x-custom-game-115002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-character-running-speed-multiplier", -- 角色奔跑速度
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.5,
        maximum_value = 100,
        order = "x-custom-game-115003"
    },
    {
        type = "double-setting",
        name = "x-custom-game-character-health-multiplier", -- 角色血量
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.5,
        maximum_value = 100,
        order = "x-custom-game-115004"
    },
    {
        type = "double-setting",
        name = "x-custom-game-character-inventory-size-multiplier", -- 角色库存
        setting_type = "startup",
        default_value = 1.5,
        minimum_value = 0.5,
        maximum_value = 10,
        order = "x-custom-game-115005"
    },
    {
        type = "string-setting",
        name = "x-custom-game-character-collision-box-multiplier", -- 角色碰撞盒子
        setting_type = "startup",
        default_value = "25%",
        allowed_values = { "100%", "75%", "50%", "25%", "0%" },
        order = "x-custom-game-115006"
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
},
{
    type = "int-setting",
    name = "x-custom-game-test-setting2",
    setting_type = "startup",
    default_value = 1,
    minimum_value = 0,
    maximum_value = 100,
    order = "1002"
},
{
    type = "double-setting",
    name = "x-custom-game-test-setting3",
    setting_type = "startup",
    default_value = 1.0,
    minimum_value = 0.0,
    maximum_value = 100.0,
    order = "1003"
},
{
    type = "string-setting",
    name = "x-custom-game-test-setting4",
    setting_type = "startup",
    default_value = "option-02",
    allowed_values = {"option-01", "option-02", "option-03"},
    order = "1004"
})
]]
