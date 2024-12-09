local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local x_util = Core.x_util
local log = Core.Log

-- 指令表配置
local set_value_ammo = settings.startup["x-custom-game-ammo-performance-multiplier"].value
local set_value_projectile = settings.startup["x-custom-game-projectile-performance-multiplier"].value
local set_value_land_mine = settings.startup["x-custom-game-land-mine-performance-multiplier"].value
local instructions_ammunition = {
    {
        type = "ammo", -- 弹药
        name = { "*" },
        exclude_names = {},
        operations = {
            magazine_size = { type = "multiply", value = set_value_ammo, min_value = 1 },                                                             -- 弹匣大小
            ["ammo_type.action[1].action_delivery[1].target_effects[2].damage.amount"] = { type = "multiply", value = set_value_ammo },               -- 弹匣.伤害
            ["ammo_type.action.action_delivery.target_effects[2].damage.amount"] = { type = "multiply", value = set_value_ammo },               -- 弹匣.伤害
            ["ammo_type.action[2].repeat_count"] = { type = "multiply", value = set_value_ammo, min_value = 1 },                                      -- 霰弹.重复次数
            ["ammo_type.action[2].action_delivery.max_range"] = { type = "multiply", value = set_value_ammo },                                        -- 霰弹.最大距离
            ["ammo_type.action[2].action_delivery.starting_speed"] = { type = "multiply", value = set_value_ammo },                                   -- 霰弹.起始速度
            ["ammo_type.range_modifier"] = { type = "multiply", value = set_value_ammo },                                                             -- 炮弹.范围修正
            ["ammo_type.action.action_delivery.max_range"] = { type = "multiply", value = set_value_ammo },                                           -- 炮弹.范围修正
            ["ammo_type.action.action_delivery.starting_speed"] = { type = "multiply", value = set_value_ammo },                                      -- 炮弹.起始速度
            ["ammo_type.cooldown_modifier"] = { type = "multiply", value = set_value_ammo },                                                          -- 原子火箭弹.冷却修正
            ["ammo_type.action.range"] = { type = "multiply", value = set_value_ammo },                                                               -- 轨道炮弹.范围
            ["ammo_type.action.width"] = { type = "multiply", value = set_value_ammo },                                                               -- 轨道炮弹.宽度
            ["ammo_type.action.action_delivery.target_effects.damage.amount"] = { type = "multiply", value = set_value_ammo },                        -- 轨道炮弹.伤害
            ["ammo_type.action.action_delivery.target_effects[2].action.action_delivery.duration"] = { type = "multiply", value = set_value_ammo },   -- 特斯拉炮弹.持续时间
            ["ammo_type.action.action_delivery.target_effects[2].action.action_delivery.max_length"] = { type = "multiply", value = set_value_ammo }, -- 特斯拉炮弹.最大长度
        }
    },
    {
        type = "projectile", -- 抛射弹药
        name = { "*" },
        exclude_names = {},
        operations = {
            acceleration = { type = "multiply", value = set_value_projectile },                                                          -- 加速度
            ["action[2].radius"] = { type = "multiply", value = set_value_projectile },                                                  -- 手雷.半径
            ["action[2].action_delivery.target_effects[1].damage.amount"] = { type = "multiply", value = set_value_projectile },         -- 手雷.伤害
            ["action[2].cluster_count"] = { type = "multiply", value = set_value_projectile },                                           -- 集束手雷.集群数量
            ["action[1].radius"] = { type = "multiply", value = set_value_projectile },                                                  -- 原子弹.半径
            ["action[1].action_delivery.target_effects.damage.amount"] = { type = "multiply", value = set_value_projectile },            -- 原子弹.伤害
            ["action[1].action_delivery.target_effects.lower_damage_modifier"] = { type = "multiply", value = set_value_projectile },    -- 原子弹.下限伤害修正
            ["action[1].action_delivery.target_effects.upper_damage_modifier"] = { type = "multiply", value = set_value_projectile },    -- 原子弹.上限伤害修正
            ["action[1].action_delivery.target_effects.upper_distance_threshold"] = { type = "multiply", value = set_value_projectile }, -- 原子弹.上限距离阈值
            ["action.action_delivery.target_effects[2].damage.amount"] = { type = "multiply", value = set_value_projectile },            -- 火箭弹.伤害
            -- 还有其他属性，不想弄了，累了！！！
        }
    },
    {
        type = "artillery-projectile", -- 抛射弹药
        name = { "*" },
        exclude_names = {},
        operations = {
            ["action.action_delivery.target_effects[1].action.action_delivery.target_effects[1].damage.amount"] = { type = "multiply", value = set_value_projectile }, -- 伤害
            ["action.action_delivery.target_effects[1].action.action_delivery.target_effects[2].damage.amount"] = { type = "multiply", value = set_value_projectile }, -- 伤害
            ["action.action_delivery.target_effects[2].max_radius"] = { type = "multiply", value = set_value_projectile },                                             -- 最大半径
            ["action.action_delivery.target_effects[4].scale"] = { type = "multiply", value = set_value_projectile },                                                  -- 规模
        }
    },
    {
        type = "combat-robot", -- 胶囊战斗机器人
        name = { "*" },
        exclude_names = {},
        operations = {
            range_from_player = { type = "multiply", value = set_value_projectile },                                                                      -- 离玩家距离
            speed = { type = "multiply", value = set_value_projectile },                                                                                  -- 速度
            time_to_live = { type = "multiply", value = set_value_projectile },                                                                           -- 存活时间
            ["attack_parameters.cooldown"] = { type = "multiply", value = set_value_projectile },                                                         -- 冷却时间
            ["attack_parameters.range"] = { type = "multiply", value = set_value_projectile },                                                            -- 距离
            ["attack_parameters.ammo_type.action.action_delivery.target_effects[2].damage.amount"] = { type = "multiply", value = set_value_projectile }, -- 伤害
            ["attack_parameters.damage_modifier"] = { type = "multiply", value = set_value_projectile },                                                  -- 伤害修正
            ["attack_parameters.ammo_type.action.action_delivery.duration"] = { type = "multiply", value = set_value_projectile },                        -- 持续时间
            ["attack_parameters.ammo_type.action.action_delivery.max_length"] = { type = "multiply", value = set_value_projectile },                      -- 最大长度
        }
    },
    {
        type = "land-mine", -- 地雷
        name = { "*" },
        exclude_names = {},
        operations = {
            ["action.action_delivery.source_effects[1].action.radius"] = { type = "multiply", value = set_value_land_mine },                                          -- 半径
            ["action.action_delivery.source_effects[1].action.action_delivery.target_effects[1].damage.amount"] = { type = "multiply", value = set_value_land_mine }, -- 伤害
            ["action.action_delivery.source_effects[3].damage.amount"] = { type = "multiply", value = set_value_land_mine },                                          -- 伤害
        }
    }
}

-- "smoke-with-trigger" 剧毒胶囊烟雾伤害属性


-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_ammunition)
log("instructions_ammunition modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not X_CUSTOM_GAME_MODIFIED_TYPE[prototype] then
            X_CUSTOM_GAME_MODIFIED_TYPE[prototype] = true
        end
    end
end
