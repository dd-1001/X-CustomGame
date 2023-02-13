local common_core = require("common/core")
local log = common_core.Log

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
    log("x_on_chunk_generated:\n")
    local entity_list = event.surface.find_entities_filtered({ area = event.area, type = "resource" })
    for _, entity in pairs(entity_list) do
        x_resource.x_refill(entity)
    end
end

function x_resource.x_on_resource_depleted(event)
    log("x_on_resource_depleted:\n")
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
        log("x_refill: " .. entity.name .. ".amount: " .. old_value .. " ---> " .. entity.amount)
    else
        log("x_refill: " .. entity.name .. ".amount: " .. entity.amount .. " not need refill")
    end
end

log("\n\n\n------------------Control start------------------\n\n\n")

if settings.startup["x-custom-game-infinite-resources-flag"].value then
    -- 定时任务
    script.on_nth_tick(10 * x_resource.real_world_minute, x_resource.on_nth_tick)
    -- 资源块生成时
    script.on_event(defines.events.on_chunk_generated, x_resource.x_on_chunk_generated)
    -- 资源达到0或无限资源的最小产量时
    script.on_event(defines.events.on_resource_depleted, x_resource.x_on_resource_depleted)
end

log("\n\n\n------------------Control end------------------\n\n\n")
