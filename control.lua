local common_core = require("common/core")
local log = common_core.Log
local lib_string = common_core.lib_string

-- local game = game -- 这是个主要对象，大部分的API都是通过它来访问的。
local script = script -- 提供一个注册事件处理程序的接口
local defines = defines -- 包含整个API中使用的符号常数

local x_resource = {
    real_world_second = 60, -- 1秒 == 60 tick
    real_world_minute = 3600, -- 1分钟 == 60 * second == 3600 tick
    real_world_hour = 86400, -- 1小时 = 60 * hour == 216000 tick
    real_world_day = 5184000, -- 1天 = 24 * hour == 5184000 tick
    game_day = 25000, -- 1天 = 25000 tick == 416.66秒
}
x_resource.__index = x_resource
setmetatable(x_resource, x_resource)

-- 固体资源
x_resource.resource_solid_catalog = {
    orig = {
        "coal", -- 煤矿
        "iron-ore", -- 铁矿
        "copper-ore", -- 铜矿
        "stone", -- 石矿
        "uranium-ore", -- 铀矿
    },
    mod = {
        "imersite", -- Krastorio2
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
    min_amount = 100, -- entity.amount
    max_amount = 1001 -- entity.amount
}

-- 液体资源
x_resource.resource_fluid_catalog = {
    orig = {
        "crude-oil", -- 原油
    },
    mod = {
        "mineral-water", -- Krastorio2
    },
    min_amount = 10000, -- entity.amount
    max_amount = 100100 -- entity.amount
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
    { name = "modular-armor",                count = 1 }, -- 模块装甲
    { name = "solar-panel-equipment",        count = 8 }, -- 太阳能模块
    { name = "battery-equipment",            count = 8 }, -- 电池组模块
    { name = "fusion-reactor-equipment",     count = 1 }, -- 聚变堆模块
    { name = "belt-immunity-equipment",      count = 1 }, -- 锚定模块
    { name = "personal-roboport-equipment",  count = 2 }, -- 机器人指令模块
    { name = "logistic-robot",               count = 100 }, -- 物流机器人
    { name = "construction-robot",           count = 100 }, -- 建设机器人
    { name = "roboport",                     count = 100 }, -- 机器人指令平台
    { name = "steel-chest",                  count = 1000 }, -- 钢制箱
    { name = "logistic-chest-storage",       count = 1000 }, -- 被动存货箱(黄箱)
    { name = "logistic-chest-requester",     count = 1000 }, -- 优先集货箱(蓝箱)
    { name = "transport-belt",               count = 1000 }, -- 基础传送带
    { name = "underground-belt",             count = 1000 }, -- 基础地下传送带
    { name = "splitter",                     count = 1000 }, -- 分流器
    { name = "electric-furnace",             count = 1000 }, -- 电炉
    { name = "assembling-machine-1",         count = 1000 }, -- 组装机1型
    { name = "oil-refinery",                 count = 1000 }, -- 炼油厂
    { name = "chemical-plant",               count = 1000 }, -- 化工厂
    { name = "lab",                          count = 1 }, -- 电力研究中心
    { name = "automation-science-pack",      count = 2000 }, -- 自动化科技包
    { name = "logistic-science-pack",        count = 2000 }, -- 物流科技包
    { name = "chemical-science-pack",        count = 2000 }, -- 化工科技包
    { name = "lighted-medium-electric-pole", count = 1000 }, -- LightedPolesPlus发光中型电线杆
    { name = "check-valve",                  count = 1000 }, -- Flow Control单向阀
    { name = "overflow-valve",               count = 1000 }, -- Flow Control溢流阀
    { name = "small-portable-generator",     count = 1 }, -- Krastorio2小型便携式发电机
    { name = "kr-wind-turbine",              count = 1000 }, -- Krastorio2风力发电机
    { name = "kr-steel-pipe",                count = 2000 }, -- Krastorio2钢管道
    { name = "kr-steel-pipe-to-ground",      count = 2000 }, -- Krastorio2钢地下管道
    { name = "basic-tech-card",              count = 2000 }, -- 基础科技卡
    { name = "se-rtg-equipment",             count = 1 }, -- space-exploration便携式RTG
    { name = "se-core-miner",                count = 1 }, -- space-exploration星核钻机
    { name = "se-pulveriser",                count = 1 }, -- space-exploration粉碎机
    { name = "miniloader",                   count = 1000 }, -- miniloader迷你装卸机
    { name = "filter-miniloader",            count = 1000 }, -- miniloader筛选迷你装卸机
    { name = "warehouse-basic",              count = 1000 }, -- Warehousing大仓库
    { name = "warehouse-storage",            count = 1000 }, -- Warehousing黄仓
    { name = "aai-strongbox-requester",      count = 1000 }, -- aai-containers优先集货柜
    { name = "aai-storehouse-requester",     count = 1000 }, -- aai-containers优先集货库
    { name = "aai-warehouse-requester",      count = 1000 }, -- aai-containers优先集货仓
    { name = "flare-stack",                  count = 1000 }, -- Flare Stack流体燃烧器
    { name = "electric-incinerator",         count = 1000 }, -- Flare Stack物品焚烧器
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
