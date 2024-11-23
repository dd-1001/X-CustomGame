local Core = require("common.core")
local x_database = require("tweak.99_database")
-- local log = Core.Log

local x_control = {
    is_seted_player_items = {} -- 是否设置过初始物品
}
setmetatable(x_control, x_control)

function x_control.init()
    -- 设置无限资源
    if settings.startup["x_custom_game_infinite_resource"].value then
        script.on_event(defines.events.on_chunk_generated, x_control.on_chunk_generated)
        script.on_event(defines.events.on_surface_created, x_control.on_surface_created)
    end
end

-- 补充资源
function x_control.refill_resource(surface, area)
    local resources = surface.find_entities_filtered { area = area, type = "resource" }
    for _, resource in pairs(resources) do
        if resource.prototype.infinite_resource then
            resource.initial_amount = resource.prototype.normal_resource_amount
            resource.amount = resource.prototype.normal_resource_amount
        end
    end
end

-- 当一个区块生成时
function x_control.on_chunk_generated(event)
    x_control.refill_resource(event.surface, event.area)
end

-- 当一个表面生成时
function x_control.on_surface_created(event)
    x_control.refill_resource(game.surfaces[event.surface_index])
end

-- 当玩家创建
function x_control.on_player_created(event)
    x_control.set_player_initial_items(event)
end

-- 当过场动画取消
function x_control.on_cutscene_cancelled(event)
    x_control.set_player_initial_items(event)
end

-- 设置玩家初始物品
function x_control.set_player_initial_items(event)
    local player = game.players[event.player_index]

    if x_control.is_seted_player_items[player.index] then
        return
    end

    local inserted = 0
    for _, item in pairs(x_database.game_start_bonus_items) do
        inserted = player.insert(item)
        game.print("Inserted item: " .. item.name .. ", Amount: " .. inserted)
    end

    if inserted > 0 then
        x_control.is_seted_player_items[player.index] = true
    end
end

-- 注册事件
script.on_init(x_control.init)
script.on_event(defines.events.on_player_created, x_control.on_player_created)
script.on_event(defines.events.on_cutscene_cancelled, x_control.on_cutscene_cancelled)

if x_database == nil then
    error("x_database is nil")
end
