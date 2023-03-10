local common_core = require("common/core")
local x_database = require("tweak.99_database")
local x_runtime_test = require("tweak.101_game_runtime_test")
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

    if settings.startup["x-custom-game-affect-mod-flags"].value and
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

local function set_game_start_bonus()
    if not remote.interfaces["freeplay"] then return end

    local created_items = remote.call("freeplay", "get_created_items")
    for _, item in pairs(x_database.game_start_bonus_items) do
        if game.item_prototypes[item.name] then
            created_items[item.name] = item.count
        end
    end
    remote.call("freeplay", "set_created_items", created_items)
end

local function on_init()
    x_runtime_test.on_init_test()

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
