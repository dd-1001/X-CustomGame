local x_database = {}

-- item最大生命值修改类型
x_database.modify_item_health_type = {
    "accumulator",
    "agricultural-tower",
    "ammo-turret",
    "arithmetic-combinator",
    "artillery-turret",
    "artillery-wagon",
    "assembling-machine",
    "asteroid",
    "asteroid-collector",
    "beacon",
    "boiler",
    "burner-generator",
    "capture-robot",
    "car",
    "cargo-bay",
    "cargo-landing-pad",
    "cargo-wagon",
    "character",
    "combat-robot",
    "constant-combinator",
    "construction-robot",
    "container",
    "curved-rail-a",
    "curved-rail-b",
    "decider-combinator",
    "display-panel",
    "electric-energy-interface",
    "electric-pole",
    "electric-turret",
    "elevated-curved-rail-a",
    "elevated-curved-rail-b",
    "elevated-half-diagonal-rail",
    "elevated-straight-rail",
    "fish",
    "fluid-turret",
    "fluid-wagon",
    "furnace",
    "fusion-generator",
    "fusion-reactor",
    "gate",
    "generator",
    "half-diagonal-rail",
    "heat-interface",
    "heat-pipe",
    "infinity-container",
    "infinity-pipe",
    "inserter",
    "lab",
    "lamp",
    "land-mine",
    "lane-splitter",
    "legacy-curved-rail",
    "legacy-straight-rail",
    "lightning-attractor",
    "linked-belt",
    "linked-container",
    "loader",
    "loader-1x1",
    "locomotive",
    "logistic-container",
    "logistic-robot",
    "market",
    "mining-drill",
    "offshore-pump",
    "pipe",
    "pipe-to-ground",
    "plant",
    "power-switch",
    "programmable-speaker",
    "pump",
    "radar",
    "rail-chain-signal",
    "rail-ramp",
    "rail-signal",
    "rail-support",
    "reactor",
    "roboport",
    "rocket-silo",
    "selector-combinator",
    "simple-entity",
    "simple-entity-with-force",
    "simple-entity-with-owner",
    "solar-panel",
    "space-platform-hub",
    "spider-leg",
    "spider-unit",
    "spider-vehicle",
    "splitter",
    "storage-tank",
    "straight-rail",
    "temporary-container",
    "thruster",
    "tile",
    "train-stop",
    "transport-belt",
    -- "tree",
    "underground-belt",
    "wall"
}

-- enemy最大生命值修改类型
x_database.modify_enemy_health_type = {
    "unit",           -- 虫子
    "unit-spawner",   -- 虫巢
    "turret",         -- 沙虫
    "segment",        -- 撼地虫
    "segmented-unit", -- 撼地虫
}

-- 游戏开局物品
x_database.game_start_bonus_items = {
    -- 物流
    { name = "steel-chest",                        count = 1000 },  -- 钢制箱
    { name = "logistic-chest-active-provider",     count = 1000 },  -- 优先供货箱(紫箱)
    { name = "logistic-chest-requester",           count = 1000 },  -- 优先集货箱(蓝箱)
    { name = "aai-strongbox-requester",            count = 1000 },  -- aai-containers 优先集货柜
    { name = "aai-storehouse-requester",           count = 1000 },  -- aai-containers 优先集货库
    { name = "aai-warehouse-requester",            count = 1000 },  -- aai-containers 优先集货仓
    { name = "kr-fluid-storage-2",                 count = 1000 },  -- Krastorio2 巨型储液罐
    { name = "transport-belt",                     count = 2000 },  -- 基础传送带
    { name = "underground-belt",                   count = 2000 },  -- 基础地下传送带
    { name = "splitter",                           count = 2000 },  -- 分流器
    { name = "miniloader",                         count = 2000 },  -- miniloader 迷你装卸机
    { name = "filter-miniloader",                  count = 2000 },  -- miniloader 筛选迷你装卸机
    { name = "se-space-transport-belt",            count = 2000 },  -- space-exploration 太空传送带
    { name = "space-miniloader",                   count = 2000 },  -- miniloader 太空迷你装卸机
    { name = "space-filter-miniloader",            count = 2000 },  -- miniloader 太空筛选迷你装卸机
    { name = "kr-steel-pipe",                      count = 2000 },  -- Krastorio2 钢管
    { name = "kr-steel-pipe-to-ground",            count = 2000 },  -- Krastorio2 地下钢管
    { name = "se-space-pipe",                      count = 2000 },  -- space-exploration 太空管
    { name = "se-space-pipe-to-ground",            count = 2000 },  -- space-exploration 地下太空管
    { name = "storage-tank",                       count = 1000 },  -- 储液罐
    { name = "pump",                               count = 1000 },  -- 管道泵
    { name = "medium-electric-pole",               count = 1000 },  -- 中型电线杆
    { name = "substation",                         count = 1000 },  -- 广域配电站
    { name = "lighted-medium-electric-pole",       count = 1000 },  -- LightedPolesPlus 发光中型电线杆
    { name = "check-valve",                        count = 1000 },  -- Flow Control 单向阀
    { name = "overflow-valve",                     count = 1000 },  -- Flow Control 溢流阀
    { name = "logistic-robot",                     count = 1000 },  -- 物流机器人
    { name = "construction-robot",                 count = 1000 },  -- 建设机器人
    { name = "warehouse-basic",                    count = 1000 },  -- Warehousing 大仓库
    { name = "warehouse-storage",                  count = 1000 },  -- Warehousing 黄仓
    { name = "roboport",                           count = 1000 },  -- 机器人指令平台
    { name = "arithmetic-combinator",              count = 1000 },  -- 算术运算器
    { name = "decider-combinator",                 count = 1000 },  -- 判断运算器
    { name = "constant-combinator",                count = 1000 },  -- 常量运算器
    { name = "landfill",                           count = 10000 }, -- 填海料
    { name = "se-spaceship-console",               count = 1 },     -- space-exploration 飞船控制台
    { name = "se-spaceship-floor",                 count = 1000 },  -- space-exploration 飞船地板
    { name = "se-spaceship-wall",                  count = 1000 },  -- space-exploration 飞船外壳
    { name = "se-spaceship-gate",                  count = 1000 },  -- space-exploration 飞船舱门
    { name = "se-spaceship-rocket-engine",         count = 10 },    -- space-exploration 飞船火箭引擎
    { name = "se-spaceship-rocket-booster-tank",   count = 10 },    -- space-exploration 飞船火箭燃料罐
    -- 生产
    { name = "kr-wind-turbine",                    count = 2000 },  -- Krastorio2 风力发电机
    { name = "solar-panel",                        count = 2000 },  -- 太阳能板
    { name = "accumulator",                        count = 2000 },  -- 蓄电池
    { name = "stone-waterwell",                    count = 1000 },  -- StoneWaterWell 石水井
    { name = "se-core-miner",                      count = 1 },     -- space-exploration 星核钻机
    { name = "industrial-furnace",                 count = 1000 },  -- aai-industry 工业熔炉
    { name = "se-casting-machine",                 count = 1000 },  -- space-exploration 铸造机
    { name = "se-space-thermodynamics-laboratory", count = 1000 },  -- space-exploration 热力学实验室
    { name = "kr-greenhouse",                      count = 1 },     -- Krastorio2 温室
    { name = "kr-bio-lab",                         count = 1 },     -- Krastorio2 生物实验室
    { name = "kr-quantum-computer",                count = 1000 },  -- Krastorio2 高级研究服务器
    { name = "kr-fuel-refinery",                   count = 1000 },  -- Krastorio2 燃料精炼厂
    { name = "se-pulveriser",                      count = 1000 },  -- space-exploration 粉碎机
    { name = "flare-stack",                        count = 1000 },  -- Flare Stack 流体燃烧器
    { name = "electric-incinerator",               count = 1000 },  -- Flare Stack 物品焚烧器
    { name = "assembling-machine-3",               count = 1000 },  -- 组装机3
    { name = "kr-advanced-assembling-machine",     count = 1000 },  -- Krastorio2 高级装配机
    { name = "se-space-assembling-machine",        count = 1000 },  -- space-exploration 太空装配机
    -- { name = "se-space-manufactory",               count = 100 },   -- space-exploration 太空制造厂
    { name = "oil-refinery",                       count = 1000 },  -- 炼油厂
    { name = "chemical-plant",                     count = 1000 },  -- 化工厂
    { name = "centrifuge",                         count = 1000 },  -- 离心机
    { name = "se-space-radiator",                  count = 1000 },  -- space-exploration 散热器
    { name = "se-space-radiator-2",                count = 1000 },  -- space-exploration 散热器2
    { name = "se-space-hypercooler",               count = 1000 },  -- space-exploration 超级冷却器
    { name = "kr-singularity-lab",                 count = 2 },     -- Krastorio2 奇点研究中心
    -- 科技
    { name = "basic-tech-card",                    count = 2000 },  -- 基础科技卡
    { name = "automation-science-pack",            count = 2000 },  -- 自动化科技包
    { name = "logistic-science-pack",              count = 2000 },  -- 物流科技包
    { name = "military-science-pack",              count = 2000 },  -- 军事科技包
    { name = "chemical-science-pack",              count = 2000 },  -- 化工科技包
    { name = "space-science-pack",                 count = 2000 },  -- 太空科技包
    -- 装备
    { name = "repair-pack",                        count = 1000 },  -- 修理包
    { name = "modular-armor",                      count = 1 },     -- 模块装甲
    { name = "solar-panel-equipment",              count = 16 },    -- 太阳能模块
    { name = "battery-equipment",                  count = 16 },    -- 电池组模块
    { name = "belt-immunity-equipment",            count = 1 },     -- 锚定模块
    { name = "personal-roboport-equipment",        count = 2 },     -- 机器人指令模块
    { name = "shield-projector",                   count = 1000 },  -- shield-projector 护盾投射器
    { name = "gun-turret",                         count = 1000 },  -- 机枪炮塔
    { name = "laser-turret",                       count = 1000 },  -- 激光炮塔
}

return x_database
