local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local x_util = Core.x_util
local log = Core.Log

-- 指令表配置
local set_value_mining_drill = settings.startup["x-custom-game-mining-drill-performance-multiplier"].value
local set_value_furnace = settings.startup["x-custom-game-furnace-performance-multiplier"].value
local set_value_assembling_machine = settings.startup["x-custom-game-assembling-machine-performance-multiplier"].value
local set_value_agricultural_tower = settings.startup["x-custom-game-agricultural-tower-performance-multiplier"].value
local set_value_lab = settings.startup["x-custom-game-lab-performance-multiplier"].value
local set_value_lightning_attractor = settings.startup["x-custom-game-lightning-attractor-performance-multiplier"].value
local set_value_rocket_silo = settings.startup["x-custom-game-rocket-silo-performance-multiplier"].value
local set_value_cargo_landing_pad = settings.startup["x-custom-game-cargo-landing-pad-performance-multiplier"].value
local set_value_cargo_bay = settings.startup["x-custom-game-cargo-bay-performance-multiplier"].value
local set_value_asteroid_collector = settings.startup["x-custom-game-asteroid-collector-performance-multiplier"].value
local set_value_thruster = settings.startup["x-custom-game-thruster-performance-multiplier"].value
local set_value_space_platform_hub = settings.startup["x-custom-game-space-platform-hub-performance-multiplier"].value
local instructions_machine = {
    {
        type = "mining-drill", -- 采矿机
        name = { "*" },
        exclude_names = {},
        operations = {
            ["energy_source.effectivity"] = { type = "multiply", value = set_value_mining_drill },                    -- 燃烧室效率
            ["energy_source.emissions_per_minute.pollution"] = { type = "division", value = set_value_mining_drill }, -- 燃烧室污染
            ["energy_source.fuel_inventory_size"] = { type = "multiply", value = set_value_mining_drill },            -- 燃烧室燃料库存
            energy_usage = { type = "division", value = set_value_mining_drill },                                     -- 能量消耗
            mining_speed = { type = "multiply", value = set_value_mining_drill },                                     -- 钻头速度
            -- resource_searching_radius = { type = "multiply", value = set_value_mining_drill },                        -- 钻机采矿半径
            ["input_fluid_box.volume"] = { type = "multiply", value = set_value_mining_drill },                       -- 输入流体体积
            ["output_fluid_box.volume"] = { type = "multiply", value = set_value_mining_drill },                      -- 输出流体体积

        }
    },
    {
        type = "furnace", -- 熔炉
        name = { "*" },
        exclude_names = {},
        operations = {
            -- source_inventory_size = { type = "multiply", value = set_value_furnace, max_value = 3 }, -- 输入槽的数量
            -- result_inventory_size = { type = "multiply", value = set_value_furnace, max_value = 3 }, -- 输出槽的数量
            crafting_speed = { type = "multiply", value = set_value_furnace },                                   -- 制作速度
            ["energy_source.effectivity"] = { type = "multiply", value = set_value_furnace },                    -- 燃烧室效率
            ["energy_source.emissions_per_minute.pollution"] = { type = "division", value = set_value_furnace }, -- 燃烧室污染
            ["energy_source.fuel_inventory_size"] = { type = "multiply", value = set_value_furnace },            -- 燃烧室燃料库存
            energy_usage = { type = "division", value = set_value_furnace },                                     -- 能量消耗
        }
    },
    {
        type = "assembling-machine", -- 组装机
        name = { "*" },
        exclude_names = {},
        operations = {
            crafting_speed = { type = "multiply", value = set_value_assembling_machine },                                   -- 制作速度
            ["energy_source.effectivity"] = { type = "multiply", value = set_value_assembling_machine },                    -- 燃烧室效率
            ["energy_source.emissions_per_minute.pollution"] = { type = "division", value = set_value_assembling_machine }, -- 燃烧室污染
            ["energy_source.fuel_inventory_size"] = { type = "multiply", value = set_value_assembling_machine },            -- 燃烧室燃料库存
            energy_usage = { type = "division", value = set_value_assembling_machine },                                     -- 能量消耗
        }
    },
    {
        type = "agricultural-tower", -- 农业塔
        name = { "*" },
        exclude_names = {},
        operations = {
            ["crane.speed.arm.extension_speed"] = { type = "multiply", value = set_value_agricultural_tower },           -- 起重机手臂延展速度
            ["crane.speed.arm.turn_rate"] = { type = "multiply", value = set_value_agricultural_tower },                 -- 起重机手臂转速
            ["crane.speed.grappler.extension_speed"] = { type = "multiply", value = set_value_agricultural_tower },      -- 起重机抓取器延展速度
            ["crane.speed.grappler.horizontal_turn_rate"] = { type = "multiply", value = set_value_agricultural_tower }, -- 起重机抓取器水平转速
            ["crane.speed.grappler.vertical_turn_rate"] = { type = "multiply", value = set_value_agricultural_tower },   -- 起重机抓取器垂直转速
            ["crane.telescope_default_extention"] = { type = "multiply", value = set_value_agricultural_tower },         -- 起重机伸展长度
            crane_energy_usage = { type = "division", value = set_value_agricultural_tower },                            -- 起重机能量消耗
            energy_usage = { type = "division", value = set_value_agricultural_tower },                                  -- 能量消耗
            ["energy_source.emissions_per_minute.spores"] = { type = "division", value = set_value_agricultural_tower }, -- 污染
            input_inventory_size = { type = "multiply", value = set_value_agricultural_tower },                          -- 输入库存大小
            radius = { type = "multiply", value = set_value_agricultural_tower, max_value = 5 },                         -- 半径
        }
    },
    {
        type = "lab", -- 研究中心
        name = { "*" },
        exclude_names = {},
        operations = {
            ["energy_source.emissions_per_minute.pollution"] = { type = "division", value = set_value_lab }, -- 污染
            energy_usage = { type = "division", value = set_value_lab },                                     -- 能量消耗
            researching_speed = { type = "multiply", value = set_value_lab },                                -- 研究速度
            science_pack_drain_rate_percent = { type = "division", value = set_value_lab },                  -- 科学包消耗率百分比
        }
    },
    {
        type = "lightning-attractor", -- 避雷针
        name = { "*" },
        exclude_names = {},
        operations = {
            efficiency = { type = "multiply", value = set_value_lightning_attractor },                          -- 效率
            ["energy_source.buffer_capacity"] = { type = "multiply", value = set_value_lightning_attractor },   -- 缓冲容量
            ["energy_source.drain"] = { type = "multiply", value = set_value_lightning_attractor },             -- 单位时间排放能量
            ["energy_source.output_flow_limit"] = { type = "multiply", value = set_value_lightning_attractor }, -- 输出能量限制
            range_elongation = { type = "multiply", value = set_value_lightning_attractor },                    -- 范围延长
        }
    },
    {
        type = "rocket-silo", -- 火箭发射井
        name = { "*" },
        exclude_names = {},
        operations = {
            active_energy_usage = { type = "division", value = set_value_rocket_silo },                                                     -- 激活时耗能
            energy_usage = { type = "division", value = set_value_rocket_silo },                                                            -- 耗能
            crafting_speed = { type = "multiply", value = set_value_rocket_silo },                                                          -- 制作速度
            logistic_trash_inventory_size = { type = "multiply", value = set_value_rocket_silo, min_value = 10, max_value = 80 },           -- 物流回收库存大小
            to_be_inserted_to_rocket_inventory_size = { type = "multiply", value = set_value_rocket_silo, min_value = 10, max_value = 80 }, -- 运载仓库存大小
        }
    },
    {
        type = "cargo-landing-pad", -- 物流接驳站
        name = { "*" },
        exclude_names = {},
        operations = {
            inventory_size = { type = "multiply", value = set_value_cargo_landing_pad, min_value = 40, max_value = 200 },      -- 库存大小
            radar_range = { type = "multiply", value = set_value_cargo_landing_pad, min_value = 4, max_value = 9 },            -- 雷达范围
            trash_inventory_size = { type = "multiply", value = set_value_cargo_landing_pad, min_value = 10, max_value = 80 }, -- 物流库存大小
        }
    },
    {
        type = "cargo-bay", -- 货舱
        name = { "*" },
        exclude_names = {},
        operations = {
            inventory_size_bonus = { type = "multiply", value = set_value_cargo_bay, min_value = 10, max_value = 60 }, -- 库存大小
        }
    },
    {
        type = "asteroid-collector", -- 星岩抓取臂
        name = { "*" },
        exclude_names = {},
        operations = {
            arm_angular_speed_cap_base = { type = "multiply", value = set_value_asteroid_collector, min_value = 0.1, max_value = 2 },               -- 臂式角速度上限
            arm_angular_speed_cap_quality_scaling = { type = "multiply", value = set_value_asteroid_collector, min_value = 0.01, max_value = 0.5 }, -- 臂式角速度品质缩放比例
            arm_count_base = { type = "multiply", value = set_value_asteroid_collector, min_value = 1, max_value = 9 },                             -- 臂数量
            arm_count_quality_scaling = { type = "multiply", value = set_value_asteroid_collector, min_value = 1, max_value = 6 },                  -- 臂数量品质缩放比例
            arm_energy_usage = { type = "division", value = set_value_asteroid_collector },                                                         -- 臂能量消耗
            arm_inventory_size = { type = "multiply", value = set_value_asteroid_collector, min_value = 1, max_value = 10 },                        -- 臂库存大小
            arm_slow_energy_usage = { type = "division", value = set_value_asteroid_collector },                                                    -- 臂低能耗耗能
            arm_speed_base = { type = "multiply", value = set_value_asteroid_collector, min_value = 1, max_value = 2 },                             -- 臂速度
            arm_speed_quality_scaling = { type = "multiply", value = set_value_asteroid_collector, min_value = 0.01, max_value = 0.5 },             -- 臂速度品质缩放比例
            collection_radius = { type = "multiply", value = set_value_asteroid_collector, min_value = 7.5, max_value = 30 },                       -- 收集半径
            deposit_radius = { type = "multiply", value = set_value_asteroid_collector, min_value = 1.5, max_value = 6 },                           -- 存入半径
            energy_usage_quality_scaling = { type = "multiply", value = set_value_asteroid_collector, min_value = 0.05, max_value = 1 },            -- 耗能品质缩放比例
            head_collection_radius = { type = "multiply", value = set_value_asteroid_collector, min_value = 0.6, max_value = 2.4 },                 -- 头部采集半径
            inventory_size = { type = "multiply", value = set_value_asteroid_collector },                                                           -- 库存大小
            inventory_size_quality_increase = { type = "multiply", value = set_value_asteroid_collector, min_value = 1, max_value = 10 },           -- 库存大小品质增加
            passive_energy_usage = { type = "division", value = set_value_asteroid_collector },                                                     -- 被动能量消耗
        }
    },
    {
        type = "thruster", -- 推进器
        name = { "*" },
        exclude_names = {},
        operations = {
            ["fuel_fluid_box.volume"] = { type = "multiply", value = set_value_thruster },        -- 燃料库存
            ["max_performance.effectivity"] = { type = "multiply", value = set_value_thruster },  -- 最大性能.效率
            ["max_performance.fluid_usage"] = { type = "division", value = set_value_thruster },  -- 最大性能.燃料用量
            ["max_performance.fluid_volume"] = { type = "division", value = set_value_thruster }, -- 最大性能.燃料体积
            ["min_performance.effectivity"] = { type = "multiply", value = set_value_thruster },  -- 最小性能.效率
            ["min_performance.fluid_usage"] = { type = "division", value = set_value_thruster },  -- 最小性能.燃料用量
            ["min_performance.fluid_volume"] = { type = "division", value = set_value_thruster }, -- 最小性能.燃料体积
        }
    },
    {
        type = "space-platform-hub", -- 太空平台枢纽
        name = { "*" },
        exclude_names = {},
        operations = {
            inventory_size = { type = "multiply", value = set_value_space_platform_hub },                 -- 库存大小
            platform_repair_speed_modifier = { type = "multiply", value = set_value_space_platform_hub }, -- 平台修复速度
        }
    }
}



-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_machine)
log("instructions_machine modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not X_CUSTOM_GAME_MODIFIED_TYPE[prototype] then
            X_CUSTOM_GAME_MODIFIED_TYPE[prototype] = true
        end
    end
end
