data:extend({
    {
        type = "bool-setting",
        name = "x_custom_game_debug",
        setting_type = "startup",
        default_value = true,
        hidden = false,
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
        type = "bool-setting",
        name = "x-custom-game-some-container-build-on-spaceplatform-flag", -- 部分箱子可以建在太空
        setting_type = "startup",
        default_value = false,
        order = "x-custom-game-101002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-storage-tank-performance-multiplier", -- 储液罐
        setting_type = "startup",
        default_value = 20,
        minimum_value = 0.01,
        maximum_value = 1000,
        order = "x-custom-game-101003"
    },
    {
        type = "double-setting",
        name = "x-custom-game-cargo-wagon-performance-multiplier", -- 货运车厢
        setting_type = "startup",
        default_value = 5,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-101004"
    },
    {
        type = "double-setting",
        name = "x-custom-game-fluid-wagon-performance-multiplier", -- 液罐车厢
        setting_type = "startup",
        default_value = 20,
        minimum_value = 0.01,
        maximum_value = 1000,
        order = "x-custom-game-101005"
    },
    {
        type = "double-setting",
        name = "x-custom-game-transport-performance-multiplier", -- 传送带、分流器
        setting_type = "startup",
        default_value = 4,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-102001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-locomotive-performance-multiplier", -- 内燃机车
        setting_type = "startup",
        default_value = 1.5,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-102002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-car-performance-multiplier", -- 车
        setting_type = "startup",
        default_value = 1.5,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-102003"
    },
    {
        type = "double-setting",
        name = "x-custom-game-spider-vehicle-performance-multiplier", -- 蜘蛛机甲
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-102004"
    },
    {
        type = "double-setting",
        name = "x-custom-game-inserter-performance-multiplier", -- 机械臂
        setting_type = "startup",
        default_value = 4,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-103001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-electric-pole-performance-multiplier", -- 电线杆
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.1,
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
        name = "x-custom-game-generator-performance-multiplier", -- 蒸汽机
        setting_type = "startup",
        default_value = 4,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-104003"
    },
    {
        type = "double-setting",
        name = "x-custom-game-solar-panel-performance-multiplier", -- 太阳能板
        setting_type = "startup",
        default_value = 10,
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
        name = "x-custom-game-fusion-reactor-performance-multiplier", -- 聚变反应堆
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-104008"
    },
    {
        type = "double-setting",
        name = "x-custom-game-fusion-generator-performance-multiplier", -- 聚变发电机
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-104009"
    },
    {
        type = "double-setting",
        name = "x-custom-game-pipe-system-performance-multiplier", -- 管道系统
        setting_type = "startup",
        default_value = 3,
        minimum_value = 0.5,
        maximum_value = 5,
        order = "x-custom-game-105001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-robot-performance-multiplier", -- 机器人
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.1,
        maximum_value = 20,
        order = "x-custom-game-106001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-roboport-performance-multiplier", -- 机器人指令平台
        setting_type = "startup",
        default_value = 20,
        minimum_value = 0.1,
        maximum_value = 100,
        order = "x-custom-game-106002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-mining-drill-performance-multiplier", -- 采矿机
        setting_type = "startup",
        default_value = 8,
        minimum_value = 0.1,
        maximum_value = 32,
        order = "x-custom-game-107001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-furnace-performance-multiplier", -- 熔炉
        setting_type = "startup",
        default_value = 8,
        minimum_value = 0.1,
        maximum_value = 32,
        order = "x-custom-game-107002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-assembling-machine-performance-multiplier", -- 组装机
        setting_type = "startup",
        default_value = 8,
        minimum_value = 0.1,
        maximum_value = 32,
        order = "x-custom-game-107003"
    },
    {
        type = "double-setting",
        name = "x-custom-game-agricultural-tower-performance-multiplier", -- 农业塔
        setting_type = "startup",
        default_value = 8,
        minimum_value = 0.1,
        maximum_value = 32,
        order = "x-custom-game-107004"
    },
    {
        type = "double-setting",
        name = "x-custom-game-lab-performance-multiplier", -- 研究中心
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.1,
        maximum_value = 100,
        order = "x-custom-game-107005"
    },
    {
        type = "double-setting",
        name = "x-custom-game-lightning-attractor-performance-multiplier", -- 避雷针
        setting_type = "startup",
        default_value = 20,
        minimum_value = 0.1,
        maximum_value = 100,
        order = "x-custom-game-107006"
    },
    {
        type = "double-setting",
        name = "x-custom-game-rocket-silo-performance-multiplier", -- 火箭发射井
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.1,
        maximum_value = 100,
        order = "x-custom-game-107007"
    },
    {
        type = "double-setting",
        name = "x-custom-game-cargo-landing-pad-performance-multiplier", -- 物流接驳站
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.1,
        maximum_value = 100,
        order = "x-custom-game-107007"
    },
    {
        type = "double-setting",
        name = "x-custom-game-cargo-bay-performance-multiplier", -- 货舱
        setting_type = "startup",
        default_value = 3,
        minimum_value = 0.5,
        maximum_value = 10,
        order = "x-custom-game-107008"
    },
    {
        type = "double-setting",
        name = "x-custom-game-asteroid-collector-performance-multiplier", -- 星岩抓取臂
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-107009"
    },
    {
        type = "double-setting",
        name = "x-custom-game-thruster-performance-multiplier", -- 推进器
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.5,
        maximum_value = 10,
        order = "x-custom-game-107010"
    },
    {
        type = "double-setting",
        name = "x-custom-game-space-platform-hub-performance-multiplier", -- 太空平台枢纽
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.5,
        maximum_value = 100,
        order = "x-custom-game-107011"
    },
    {
        type = "double-setting",
        name = "x-custom-game-beacon-performance-multiplier", -- 插件效果分享塔
        setting_type = "startup",
        default_value = 20,
        minimum_value = 0.1,
        maximum_value = 100,
        order = "x-custom-game-108001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-module-performance-multiplier", -- 插件
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-108002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-module-slots-multiplier", -- 插件槽数量
        setting_type = "startup",
        default_value = 20,
        minimum_value = 1,
        maximum_value = 20,
        order = "x-custom-game-108004"
    },
    {
        type = "bool-setting",
        name = "x-custom-game-module-slot-all-type-allowed-flag", -- 插件槽允许所有类型的插件
        setting_type = "startup",
        default_value = false,
        order = "x-custom-game-108005"
    },
    {
        type = "double-setting",
        name = "x-custom-game-stack-size-multiplier", -- 堆叠大小
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.1,
        maximum_value = 20,
        order = "x-custom-game-109001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-fuel-multiplier", -- 燃料乘数
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.1,
        maximum_value = 100,
        order = "x-custom-game-109002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-lamp-performance-multiplier", -- 灯
        setting_type = "startup",
        default_value = 3,
        minimum_value = 0.5,
        maximum_value = 10,
        order = "x-custom-game-109003"
    },
    {
        type = "double-setting",
        name = "x-custom-game-repair-tool-performance-multiplier", -- 修理包
        setting_type = "startup",
        default_value = 3,
        minimum_value = 0.5,
        maximum_value = 10,
        order = "x-custom-game-109004"
    },
    {
        type = "double-setting",
        name = "x-custom-game-radar-performance-multiplier", -- 雷达
        setting_type = "startup",
        default_value = 5,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-109005"
    },
    {
        type = "bool-setting",
        name = "x_custom_game_infinite_resource", -- 无限矿石
        setting_type = "startup",
        default_value = true,
        order = "x-custom-game-110001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-gun-performance-multiplier", -- 枪
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-111001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-ammo-turret-performance-multiplier", -- 机枪炮塔
        setting_type = "startup",
        default_value = 3,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-111002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-electric-turret-performance-multiplier", -- 激光炮塔
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-111003"
    },
    {
        type = "double-setting",
        name = "x-custom-game-fluid-turret-performance-multiplier", -- 火焰炮塔
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-111004"
    },
    {
        type = "double-setting",
        name = "x-custom-game-artillery-turret-performance-multiplier", -- 重炮炮塔
        setting_type = "startup",
        default_value = 3,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-111005"
    },
    {
        type = "double-setting",
        name = "x-custom-game-ammo-performance-multiplier", -- 弹药
        setting_type = "startup",
        default_value = 3,
        minimum_value = 0.1,
        maximum_value = 100,
        order = "x-custom-game-112001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-projectile-performance-multiplier", -- 抛射弹药(手雷、胶囊、抛射弹药)
        setting_type = "startup",
        default_value = 3,
        minimum_value = 0.1,
        maximum_value = 100,
        order = "x-custom-game-112002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-land-mine-performance-multiplier", -- 地雷
        setting_type = "startup",
        default_value = 3,
        minimum_value = 0.1,
        maximum_value = 100,
        order = "x-custom-game-112003"
    },
    {
        type = "double-setting",
        name = "x-custom-game-armor-performance-multiplier", -- 护甲
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-113001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-equipment-grid-performance-multiplier", -- 装备网格
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.1,
        maximum_value = 10,
        order = "x-custom-game-113002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-equipment-performance-multiplier", -- 装备模块
        setting_type = "startup",
        default_value = 100,
        minimum_value = 0.1,
        maximum_value = 1000,
        order = "x-custom-game-114001"
    },
    {
        type = "bool-setting",
        name = "x-custom-game-equipment-size-flag", -- 装备尺寸为1*1
        setting_type = "startup",
        default_value = true,
        order = "x-custom-game-114002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-character-distance-multiplier", -- 角色距离相关
        setting_type = "startup",
        default_value = 10,
        minimum_value = 1,
        maximum_value = 1000,
        order = "x-custom-game-115001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-character-mining-speed-multiplier", -- 角色采矿速度
        setting_type = "startup",
        default_value = 10,
        minimum_value = 1,
        maximum_value = 1000,
        order = "x-custom-game-115002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-character-running-speed-multiplier", -- 角色奔跑速度
        setting_type = "startup",
        default_value = 2,
        minimum_value = 1,
        maximum_value = 100,
        order = "x-custom-game-115003"
    },
    {
        type = "double-setting",
        name = "x-custom-game-character-health-multiplier", -- 角色血量
        setting_type = "startup",
        default_value = 10,
        minimum_value = 1,
        maximum_value = 100,
        order = "x-custom-game-115004"
    },
    {
        type = "double-setting",
        name = "x-custom-game-character-inventory-size-multiplier", -- 角色库存
        setting_type = "startup",
        default_value = 2,
        minimum_value = 1,
        maximum_value = 10,
        order = "x-custom-game-115005"
    },
    {
        type = "double-setting",
        name = "x-custom-game-character-collision-box-multiplier", -- 角色碰撞盒子
        setting_type = "startup",
        default_value = 0.33,
        minimum_value = 0,
        maximum_value = 1,
        order = "x-custom-game-115006"
    },
    {
        type = "double-setting",
        name = "x-custom-game-wall-performance-multiplier", -- 墙
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.1,
        maximum_value = 1000,
        order = "x-custom-game-116001"
    },
    {
        type = "double-setting",
        name = "x-custom-game-tool-performance-multiplier", -- tool
        setting_type = "startup",
        default_value = 0.25,
        minimum_value = 0.1,
        maximum_value = 100,
        order = "x-custom-game-116002"
    },
    {
        type = "double-setting",
        name = "x-custom-game-rocket-lift-weight-multiplier", -- 火箭升力重量
        setting_type = "startup",
        default_value = 10,
        minimum_value = 0.1,
        maximum_value = 100,
        order = "x-custom-game-116003"
    },
    {
        type = "double-setting",
        name = "x-custom-game-item-health-multiplier", -- 物品生命值
        setting_type = "startup",
        default_value = 4,
        minimum_value = 0.1,
        maximum_value = 100,
        order = "x-custom-game-116004"
    },
    {
        type = "double-setting",
        name = "x-custom-game-enemy-health-multiplier", -- 敌方生命值
        setting_type = "startup",
        default_value = 1.5,
        minimum_value = 0.1,
        maximum_value = 100,
        order = "x-custom-game-116005"
    },
    {
        type = "double-setting",
        name = "x-custom-game-technology-cost-multiplier", -- 科技花费
        setting_type = "startup",
        default_value = 1,
        minimum_value = 0.01,
        maximum_value = 1000,
        order = "x-custom-game-117001"
    },
    {
        type = "bool-setting",
        name = "x-custom-game-modify-infinite-technology-flag", -- 是否启用-无限科技花费公式
        setting_type = "startup",
        default_value = false,
        order = "x-custom-game-117002"
    },
    {
        type = "string-setting",
        name = "x-custom-game-infinite-technology-count-formula", -- 无限科技花费公式
        setting_type = "startup",
        default_value = "L*100",
        order = "x-custom-game-117003"
    },
    {
        type = "double-setting",
        name = "x-custom-game-recipe-productivity-limit-multiplier", -- 配方产能限制
        setting_type = "startup",
        default_value = 2,
        minimum_value = 0.01,
        maximum_value = 100,
        order = "x-custom-game-118001"
    },
    {
        type = "bool-setting",
        name = "x-custom-game-start-bouns-items-flag", -- 开局物品
        setting_type = "runtime-per-user",
        default_value = true,
        order = "x-custom-game-120001"
    },
    {
        type = "string-setting",
        name = "x-custom-game-get-items", -- 游戏中获得物品
        setting_type = "runtime-global",
        default_value = "transport-belt, 200; underground-belt, 200;",
        order = "x-custom-game-120002"
    },
    {
        type = "bool-setting",
        name = "x-custom-game-author-custom-balance-flag", -- 作者自定义平衡
        setting_type = "startup",
        default_value = false,
        order = "x-custom-game-195001"
    }

})
