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

    local inserted = x_control.insert_items_to_player(player, x_database.game_start_bonus_items)

    if inserted > 0 then
        x_control.is_seted_player_items[player.index] = true
    end
end

-- 给玩家插入物品
function x_control.insert_items_to_player(player, items)
    local total_inserted = 0

    for _, item in pairs(items) do
        if prototypes.item[item.name] then
            local inserted = player.insert(item)
            total_inserted = total_inserted + inserted
            game.print("Inserted item: " .. item.name .. ", Amount: " .. inserted)
        else
            game.print("Invalid item: " .. item.name .. " cannot be inserted.")
        end
    end

    return total_inserted
end

-- 解析配置字符串并返回物品列表
function x_control.parse_item_config(config_string)
    local items = {}
    for item_string in string.gmatch(config_string, "([^;]+)") do
        local name, count = string.match(item_string, "([^,]+),%s*(%d+)")
        if name and count then
            name = name:match("^%s*(.-)%s*$")
            table.insert(items, { name = name, count = tonumber(count) })
        end
    end
    return items
end

-- 处理配置改变事件
function x_control.on_runtime_mod_setting_changed(event)
    if event.setting == "x-custom-game-get-items" then
        local item_config = settings.global["x-custom-game-get-items"].value
        local items = x_control.parse_item_config(item_config)
        for _, player in pairs(game.players) do
            x_control.insert_items_to_player(player, items)
        end
    end
end

-- 注册事件
script.on_init(x_control.init)
script.on_event(defines.events.on_player_created, x_control.on_player_created)
script.on_event(defines.events.on_cutscene_cancelled, x_control.on_cutscene_cancelled)
script.on_event(defines.events.on_runtime_mod_setting_changed, x_control.on_runtime_mod_setting_changed)
