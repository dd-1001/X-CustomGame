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
    skip_first_time = false
}
x_resource.__index = x_resource
setmetatable(x_resource, x_resource)

x_resource.resource_catalog = {
    orig = {
        "coal", -- 煤矿
        "iron-ore", -- 铁矿
        "copper-ore", -- 铜矿
        "stone", -- 石矿
        "uranium-ore", -- 铀矿
        "crude-oil", -- 原油
    },
    mod = {

    },
    min_amount = 1, -- entity.amount
    max_amount = 10 -- entity.amount
}

function x_resource.on_nth_tick(NthTickEventData)
    log("on_nth_tick: " .. common_core:serpent_line(NthTickEventData))

    if not x_resource.skip_first_time then
        x_resource.skip_first_time = true
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
    local tmp_tab = x_resource.resource_catalog.orig

    ::FIND_MOD::
    for _, res_name in pairs(tmp_tab) do
        if res_name == entity.name then
            is_need_modify = true
        end
    end

    if false and
        not is_need_modify and
        not is_finded then
        is_finded = true
        tmp_tab = x_resource.resource_catalog.mod
        goto FIND_MOD
    end

    log("x_refill: " .. entity.name)

    if is_need_modify and
        entity.amount < x_resource.resource_catalog.max_amount then
        --
        local old_value = entity.amount
        entity.amount = entity.amount +
            math.random(x_resource.resource_catalog.min_amount, x_resource.resource_catalog.max_amount)
        log("x_refill: " .. entity.name .. ".amount: " .. old_value .. " ---> " .. entity.amount)
    end
end

log("\n\n\n------------------Control start------------------\n\n\n")

if true then
    -- 定时任务
    script.on_nth_tick(0.5 * x_resource.real_world_hour, x_resource.on_nth_tick)
    -- 资源块生成时
    script.on_event(defines.events.on_chunk_generated, x_resource.x_on_chunk_generated)
    -- 资源达到0或无限资源的最小产量时
    script.on_event(defines.events.on_resource_depleted, x_resource.x_on_resource_depleted)
end

log("\n\n\n------------------Control end------------------\n\n\n")
