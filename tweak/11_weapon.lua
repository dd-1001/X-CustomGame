local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local x_util = Core.x_util
local log = Core.Log

-- 指令表配置
local set_value_gun = settings.startup["x-custom-game-gun-performance-multiplier"].value
local set_value_ammo_turret = settings.startup["x-custom-game-ammo-turret-performance-multiplier"].value
local set_value_electric_turret = settings.startup["x-custom-game-electric-turret-performance-multiplier"].value
local set_value_fluid_turret = settings.startup["x-custom-game-fluid-turret-performance-multiplier"].value
local set_value_artillery_turret = settings.startup["x-custom-game-artillery-turret-performance-multiplier"].value
local instructions_weapon = {
    {
        type = "gun", -- 枪
        name = { "*" },
        exclude_names = {},
        operations = {
            ["attack_parameters.cooldown"] = { type = "division", value = set_value_gun },                  -- 射击冷却时间
            ["attack_parameters.range"] = { type = "multiply", value = set_value_gun },                     -- 射击范围
            ["attack_parameters.movement_slow_down_factor"] = { type = "division", value = set_value_gun }, -- 移动减速因子
            -- ["attack_parameters.projectile_creation_distance"] = { type = "multiply", value = set_value_gun }, -- 弹射物的创建距离
        }
    },
    {
        type = "ammo-turret", -- 机枪炮塔
        name = { "*" },
        exclude_names = {},
        operations = {
            ["attack_parameters.cooldown"] = { type = "division", value = set_value_ammo_turret },               -- 射击冷却时间
            ["attack_parameters.range"] = { type = "multiply", value = set_value_ammo_turret },                  -- 射击范围
            -- ["attack_parameters.projectile_creation_distance"] = { type = "multiply", value = set_value_ammo_turret }, -- 弹射物的创建距离
            attacking_speed = { type = "multiply", value = set_value_ammo_turret },                              -- 攻击速度
            automated_ammo_count = { type = "multiply", value = set_value_ammo_turret },                         -- 自动弹药数量
            call_for_help_radius = { type = "multiply", value = set_value_ammo_turret },                         -- 求助半径
            inventory_size = { type = "multiply", value = set_value_ammo_turret, min_value = 1, max_value = 3 }, -- 库存大小
            rotation_speed = { type = "multiply", value = set_value_ammo_turret },                               -- 旋转速度
            energy_per_shot = { type = "division", value = set_value_ammo_turret },                              -- 射击耗能
            ["energy_source.buffer_capacity"] = { type = "multiply", value = set_value_ammo_turret },            -- 缓存能量
            ["energy_source.input_flow_limit"] = { type = "multiply", value = set_value_ammo_turret },           -- 缓存能量输入
        }
    },
    {
        type = "electric-turret", -- 激光炮塔
        name = { "*" },
        exclude_names = {},
        operations = {
            ["attack_parameters.cooldown"] = { type = "division", value = set_value_electric_turret },                                                                             -- 射击冷却时间
            ["attack_parameters.range"] = { type = "multiply", value = set_value_electric_turret },                                                                                -- 射击范围
            ["attack_parameters.damage_modifier"] = { type = "multiply", value = set_value_electric_turret },                                                                      -- 伤害修正
            ["attack_parameters.ammo_type.energy_consumption"] = { type = "division", value = set_value_electric_turret },                                                         -- 激光能量消耗
            ["attack_parameters.ammo_type.action.action_delivery.max_length"] = { type = "multiply", value = set_value_electric_turret },                                          -- 激光最长距离
            ["attack_parameters.ammo_type.action.action_delivery.target_effects[2].action.action_delivery.max_length"] = { type = "multiply", value = set_value_electric_turret }, -- 激光最长距离
            call_for_help_radius = { type = "multiply", value = set_value_electric_turret },                                                                                       -- 求助半径
            rotation_speed = { type = "multiply", value = set_value_electric_turret },                                                                                             -- 旋转速度
            ["energy_source.buffer_capacity"] = { type = "multiply", value = set_value_electric_turret },                                                                          -- 缓存能量
            ["energy_source.drain"] = { type = "division", value = set_value_electric_turret },                                                                                    -- 最低消耗
            ["energy_source.input_flow_limit"] = { type = "multiply", value = set_value_electric_turret },                                                                         -- 缓存能量输入
        }
    },
    {
        type = "fluid-turret", -- 火焰炮塔
        name = { "*" },
        exclude_names = {},
        operations = {
            attacking_speed = { type = "multiply", value = set_value_fluid_turret },                         -- 攻击速度
            call_for_help_radius = { type = "multiply", value = set_value_fluid_turret },                    -- 求助半径
            fluid_buffer_input_flow = { type = "multiply", value = set_value_fluid_turret },                 -- 流体缓冲区输入限制
            fluid_buffer_size = { type = "multiply", value = set_value_fluid_turret },                       -- 流体缓冲区大小
            ["fluid_box.volume"] = { type = "multiply", value = set_value_fluid_turret, max_value = 1000 },  -- 流体缓冲区大小
            prepare_range = { type = "multiply", value = set_value_fluid_turret },                           -- 准备距离
            ["attack_parameters.cooldown"] = { type = "division", value = set_value_fluid_turret },          -- 射击冷却时间
            ["attack_parameters.fluid_consumption"] = { type = "division", value = set_value_fluid_turret }, -- 流体消耗
            ["attack_parameters.fire_penalty"] = { type = "multiply", value = set_value_fluid_turret },      -- 火焰伤害
            ["attack_parameters.range"] = { type = "multiply", value = set_value_fluid_turret },             -- 射击范围
        }
    },
    {
        type = "artillery-turret", -- 重炮炮塔
        name = { "*" },
        exclude_names = {},
        operations = {
            ammo_stack_limit = { type = "multiply", value = set_value_artillery_turret },                             -- 弹药堆限制
            automated_ammo_count = { type = "multiply", value = set_value_artillery_turret },                         -- 自动弹药数量
            inventory_size = { type = "multiply", value = set_value_artillery_turret, min_value = 1, max_value = 3 }, -- 库存大小
            manual_range_modifier = { type = "multiply", value = set_value_artillery_turret },                        -- 手动范围修正器
            turn_after_shooting_cooldown = { type = "division", value = set_value_artillery_turret },                 -- 射击冷却
            turret_rotation_speed = { type = "multiply", value = set_value_artillery_turret },                        -- 旋转速度
        }
    }
}



-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_weapon)
log("instructions_weapon modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not X_CUSTOM_GAME_MODIFIED_TYPE[prototype] then
            X_CUSTOM_GAME_MODIFIED_TYPE[prototype] = true
        end
    end
end
