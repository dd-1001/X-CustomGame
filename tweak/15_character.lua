local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local x_util = Core.x_util
local log = Core.Log

-- 指令表配置
local set_value_character_distance = settings.startup["x-custom-game-character-distance-multiplier"].value
local set_value_character_mining_speed = settings.startup["x-custom-game-character-mining-speed-multiplier"].value
local set_value_character_running_speed = settings.startup["x-custom-game-character-running-speed-multiplier"].value
local set_value_character_health = settings.startup["x-custom-game-character-health-multiplier"].value
local set_value_character_inventory_size = settings.startup["x-custom-game-character-inventory-size-multiplier"].value
local set_value_character_collision_box = settings.startup["x-custom-game-character-collision-box-multiplier"].value
local instructions_character = {
    {
        type = "character", -- 角色属性
        name = { "*" },
        exclude_names = {},
        operations = {
            build_distance = { type = "multiply", value = set_value_character_distance },                                                                                                                                               -- 构建距离
            drop_item_distance = { type = "multiply", value = set_value_character_distance },                                                                                                                                           -- 放置物品距离
            item_pickup_distance = { type = "multiply", value = set_value_character_distance },                                                                                                                                         -- 取货距离
            loot_pickup_distance = { type = "multiply", value = set_value_character_distance },                                                                                                                                         -- 拾取战利品的距离
            reach_distance = { type = "multiply", value = set_value_character_distance },                                                                                                                                               -- 到达距离
            reach_resource_distance = { type = "multiply", value = set_value_character_distance },                                                                                                                                      -- 到达资源距离
            mining_speed = { type = "multiply", value = set_value_character_mining_speed },                                                                                                                                             -- 挖矿速度
            running_speed = { type = "multiply", value = set_value_character_running_speed },                                                                                                                                           -- 奔跑速度
            max_health = { type = "multiply", value = set_value_character_health },                                                                                                                                                     -- 最大血量
            healing_per_tick = { type = "multiply", value = set_value_character_health },                                                                                                                                               -- 血量恢复
            inventory_size = { type = "multiply", value = set_value_character_inventory_size },                                                                                                                                         -- 库存大小
            collision_box = { type = "set", value = { { -0.2 * set_value_character_collision_box, -0.2 * set_value_character_collision_box }, { 0.2 * set_value_character_collision_box, 0.2 * set_value_character_collision_box } } }, -- 碰撞箱
        }
    }
}



-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_character)
log("instructions_character modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not X_CUSTOM_GAME_MODIFIED_TYPE[prototype] then
            X_CUSTOM_GAME_MODIFIED_TYPE[prototype] = true
        end
    end
end
