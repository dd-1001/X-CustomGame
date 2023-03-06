local common_core = require("common/core")
local log = common_core.Log
local lib_string = common_core.lib_string

-- local game = game -- 这是个主要对象，大部分的API都是通过它来访问的。
local script = script   -- 提供一个注册事件处理程序的接口
local defines = defines -- 包含整个API中使用的符号常数

local x_resource = {
    real_world_second = 60,   -- 1秒 == 60 tick
    real_world_minute = 3600, -- 1分钟 == 60 * second == 3600 tick
    real_world_hour = 86400,  -- 1小时 = 60 * hour == 216000 tick
    real_world_day = 5184000, -- 1天 = 24 * hour == 5184000 tick
    game_day = 25000,         -- 1天 = 25000 tick == 416.66秒
}
x_resource.__index = x_resource
setmetatable(x_resource, x_resource)

-- 固体资源
x_resource.resource_solid_catalog = {
    orig = {
        "coal",        -- 煤矿
        "iron-ore",    -- 铁矿
        "copper-ore",  -- 铜矿
        "stone",       -- 石矿
        "uranium-ore", -- 铀矿
    },
    mod = {
        "imersite",     -- Krastorio2
        "se-water-ice", -- space-exploration
        "se-methane-ice",
        "se-beryllium-ore",
        "se-cryonite",
        "se-holmium-ore",
        "se-iridium-ore",
        "se-naquium-ore",
        "se-vulcanite",
        "se-vitamelange", -- space-exploration
    },
    min_amount = 100,     -- entity.amount
    max_amount = 1001     -- entity.amount
}

-- 液体资源
x_resource.resource_fluid_catalog = {
    orig = {
        "crude-oil", -- 原油
    },
    mod = {
        "mineral-water", -- Krastorio2
    },
    min_amount = 10000,  -- entity.amount
    max_amount = 100100  -- entity.amount
}

function x_resource.on_nth_tick(NthTickEventData)
    log("on_nth_tick: " .. common_core:serpent_line(NthTickEventData))

    if NthTickEventData.tick == 0 then
        -- 跳过游戏开局的定时任务
        return
    end

    for _, surface in pairs(game.surfaces) do
        log("game.surfaces.name: " .. surface.name)
        local entity_list = surface.find_entities_filtered({ type = "resource" })
        for _, entity in pairs(entity_list) do
            x_resource.x_refill(entity)
        end
    end
end

function x_resource.x_on_chunk_generated(event)
    log("x_on_chunk_generated: ---")
    local entity_list = event.surface.find_entities_filtered({ area = event.area, type = "resource" })
    for _, entity in pairs(entity_list) do
        x_resource.x_refill(entity)
    end
end

function x_resource.x_on_resource_depleted(event)
    log("x_on_resource_depleted: ---")
    x_resource.x_refill(event.entity)
end

function x_resource.x_refill(entity)
    local is_need_modify = false
    local is_finded = false

    local tmp_type = x_resource.resource_solid_catalog
    ::MATCH_RES::
    -- 匹配原版资源
    local tmp_tab = tmp_type.orig
    for _, res_name in pairs(tmp_tab) do
        if res_name == entity.name then
            is_need_modify = true
        end
    end

    if settings.startup["x-custom-game-effect-mod-flags"].value and
        not is_need_modify then
        -- 匹配mod资源
        tmp_tab = tmp_type.mod
        for _, res_name in pairs(tmp_tab) do
            if res_name == entity.name then
                is_need_modify = true
            end
        end
    end

    if not is_need_modify and
        not is_finded then
        -- 匹配液体资源
        tmp_type = x_resource.resource_fluid_catalog
        is_finded = true
        goto MATCH_RES
    end


    if is_need_modify and
        entity.amount < tmp_type.max_amount then
        --
        local old_value = entity.amount
        entity.amount = entity.amount +
            math.random(tmp_type.min_amount, tmp_type.max_amount)
        -- log("x_refill: " .. entity.name .. ".amount: " .. old_value .. " ---> " .. entity.amount)
    else
        -- log("x_refill: " .. entity.name .. ".amount: " .. entity.amount .. " not need refill")
    end
end

local game_start_bonus_items = {
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

local function set_game_start_bonus()
    if not remote.interfaces["freeplay"] then return end

    local created_items = remote.call("freeplay", "get_created_items")
    for _, item in pairs(game_start_bonus_items) do
        if game.item_prototypes[item.name] then
            created_items[item.name] = item.count
        end
    end
    remote.call("freeplay", "set_created_items", created_items)
end

local function on_init()
    if settings.player["x-custom-game-start-bouns-items-flag"].value then
        set_game_start_bonus()
    end
end

local function on_runtime_mod_setting_changed(event)
    -- log("on_runtime_mod_setting_changed: event.setting = " .. event.setting)

    if not remote.interfaces["freeplay"] then return end

    -- 获取玩家
    local player = game.players[event.player_index]
    if not (player and player.character) then
        return
    end

    if event.setting == "x-custom-game-get-items" then
        -- 整理物品列表
        local add_item_list = {}
        local set_value = settings.global["x-custom-game-get-items"].value
        local item_list = lib_string.split(lib_string.trim(set_value), ";")
        for _, item_info in ipairs(item_list) do
            local tmp_tab, tmp_tab2 = lib_string.split(lib_string.trim(item_info), ",")
            if #tmp_tab == 2 then
                tmp_tab2 = { name = lib_string.trim(tmp_tab[1]), count = tonumber(tmp_tab[2]) }
            elseif #tmp_tab == 1 then
                tmp_tab2 = { name = lib_string.trim(tmp_tab[1]), count = 1 }
            end

            if game.item_prototypes[tmp_tab2.name] then
                table.insert(add_item_list, tmp_tab2)
            end
        end

        -- 加入物品
        log("add_item_list: \n" .. common_core:serpent_block(add_item_list))
        for _, item in ipairs(add_item_list) do
            player.insert(item)
        end
    end
end

log("\n\n\n------------------Control start------------------\n\n\n")

script.on_init(on_init)
-- 配置改变时
script.on_event(defines.events.on_runtime_mod_setting_changed, on_runtime_mod_setting_changed)

if settings.startup["x-custom-game-infinite-resources-flag"].value then
    -- 定时任务
    -- script.on_nth_tick(15 * x_resource.real_world_minute, x_resource.on_nth_tick)
    -- 资源块生成时
    script.on_event(defines.events.on_chunk_generated, x_resource.x_on_chunk_generated)
    -- 资源达到0或无限资源的最小产量时
    script.on_event(defines.events.on_resource_depleted, x_resource.x_on_resource_depleted)
end

log("\n\n\n------------------Control end------------------\n\n\n")
