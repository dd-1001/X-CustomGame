local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.Log

-- data.raw修改目录
local data_raw_other_catalog = {
    locomotive = { -- 机车
        orig = {
            "locomotive" -- 内燃机车
        },
        mod = {
            "fast-one", -- fast_trans
            "fast-one-mk2",
            "fast-one-mk3", -- fast_trans
            "kr-nuclear-locomotive", -- Krastorio2
            "bob-locomotive-2", -- boblogistics
            "bob-locomotive-3",
            "bob-armoured-locomotive",
            "bob-armoured-locomotive-2" -- boblogistics
        },
        mul = settings.startup["x-custom-game-locomotive-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "burner", "effectivity" } -- 内燃机效率
            },
            {
                path = { "max_power" } -- 最大动力
            },
            {
                path = { "max_speed" } -- 最大速度
            },
            {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    ["repair-tool"] = { -- 修理工具
        orig = {
            "repair-pack" -- 修理包
        },
        mod = {
            "repair-pack-2", -- boblogistics
            "repair-pack-3",
            "repair-pack-4",
            "repair-pack-5", -- boblogistics
            "advanced-repair-pack-rampant-industry", -- RampantIndustry
        },
        mul = settings.startup["x-custom-game-repair-tool-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "durability" } -- 此工具的耐用性
            },
            {
                path = { "speed" } -- 修理速度
            }
        }
    },
    car = { -- 车(包括坦克)
        orig = {
            "car", -- 汽车
            "tank" -- 坦克
        },
        mod = {
            "kr-advanced-tank", -- Krastorio2
        },
        mul = settings.startup["x-custom-game-car-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "braking_power" } -- 动力
            },
            {
                path = { "burner", "effectivity" } -- 效率
            },
            {
                path = { "consumption" } -- 消耗
            },
            {
                path = { "effectivity" } -- 效率
            },
            {
                path = { "max_health" } -- 最大血量
            }
        }
    },
    ["spider-vehicle"] = { -- 蜘蛛机甲
        orig = {
            "spidertron" -- 蜘蛛机甲
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-spider-vehicle-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "chain_shooting_cooldown_modifier" }, -- 剩余射击冷却时间的乘数(可以为0)：automatic_weapon_cycling | cooldown = (remaining_cooldown × chain_shooting_cooldown_modifier)
                operation = "Division"
            },
            {
                path = { "max_health" } -- 最大血量
            },
            {
                path = { "movement_energy_consumption" }, -- 移动能量消耗
                operation = "Division"
            }
        }
    },
    lab = { -- 研究中心
        orig = {
            "lab" -- 研究中心
        },
        mod = {
            "biusart-lab", -- Krastorio2
            "kr-singularity-lab", -- Krastorio2
            "burner-lab", -- aai-industry
            "advanced-lab-rampant-industry", -- RampantIndustry
        },
        mul = settings.startup["x-custom-game-lab-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "max_health" } -- 最大血量
            },
            {
                path = { "module_specification", "module_slots" }, -- 模块插槽数
                value = settings.startup["x-custom-game-number-of-module-slots"].value
            },
            {
                path = { "researching_speed" } -- 研究速度
            }
        }
    },
    beacon = { -- 插件效果分享塔
        orig = {
            "beacon" -- 研究中心
        },
        mod = {
            "kr-singularity-beacon", -- Krastorio2
        },
        mul = settings.startup["x-custom-game-beacon-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "distribution_effectivity" } -- 共享时模块效果的乘数
            },
            {
                path = { "supply_area_distance" }, -- 最大距离为 64
                max_value = 64,
                -- value = 64
            },
            {
                path = { "energy_usage" }, -- 能量消耗
                operation = "Division"
            },
            {
                path = { "module_specification", "module_slots" }, -- 模块插槽数
                value = settings.startup["x-custom-game-number-of-module-slots"].value
            }
        }
    },
    ["rocket-silo"] = { -- 火箭发射井
        orig = {
            "rocket-silo" -- 火箭发射井
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-rocket-silo-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "active_energy_usage" }, -- 激活时能耗
                operation = "Division"
            },
            {
                path = { "energy_usage" } -- 能耗
            },
            {
                path = { "module_specification", "module_slots" }, -- 模块插槽数
                value = settings.startup["x-custom-game-number-of-module-slots"].value
            },
            {
                path = { "crafting_speed" } -- 制造速度
            }
        }
    },
    radar = { -- 雷达
        orig = {
            "radar" -- 雷达
        },
        mod = {
            "kr-sentinel", -- Krastorio2
            "advanced-radar", -- Krastorio2
        },
        mul = settings.startup["x-custom-game-radar-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "energy_per_nearby_scan" }, -- 每一个近距离扫描的能耗
                operation = "Division"
            },
            {
                path = { "energy_per_sector" }, -- 扫描扇区所需的能量
                operation = "Division"
            },
            {
                path = { "energy_usage" }, -- 雷达使用的能量
                operation = "Division"
            },
            {
                path = { "max_distance_of_nearby_sector_revealed" }, -- 该雷达不断显示的区域半径，以块为单位。
                max_value = 8
            },
            {
                path = { "max_distance_of_sector_revealed" }, -- 雷达可以绘制的区域半径，以块为单位。
                max_value = 16
            },
            {
                path = { "rotation_speed" }, -- 旋转速度
                max_value = 0.05
            }
        }
    },
    lamp = {
        orig = {
            "small-lamp", -- 灯
        },
        mod = {
            "balloon-light", -- AfraidOfTheDark
            "short-balloon-light", -- AfraidOfTheDark
        },
        mul = settings.startup["x-custom-game-lamp-performance-multiplier"].value,
        modify_parameter = {
            {
                path = { "energy_usage_per_tick" }, -- 能量消耗
                operation = "Division"
            },
            {
                path = { "light", "size" } -- 灯光范围
            }
        }
    }
}

-- 蜘蛛机甲 装备网格
local data_raw_spidertron_equipment_grid_catalog = {
    ["equipment-grid"] = { -- 装备网格
        orig = {
            "spidertron-equipment-grid", -- 蜘蛛机甲装备网格
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-spider-vehicle-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "height" }, -- 高度
                max_value = 16
            },
            {
                path = { "width" }, -- 宽度
                max_value = 16
            }
        }
    }
}

-- 速度插件
local data_raw_speed_module_catalog = {
    module = { -- 插件
        orig = {
            "speed-module", -- 速度插件 1
            "speed-module-2", -- 速度插件 2
            "speed-module-3", -- 速度插件 3
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-module-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "effect", "consumption", "bonus" }, -- 能耗的乘数（非空闲/排水使用）。最小可能的总和为 -80%。
                operation = "Division",
                -- value = 0
            },
            {
                path = { "effect", "speed", "bonus" } -- 制作速度、研究速度等。最小可能的总和为 -80%。
            },
            {
                path = { "effect", "productivity", "bonus" } -- 产能。最小可能的总和为 0%。
            },
            {
                path = { "effect", "pollution", "bonus" }, -- 污染因子的乘数。最小可能的总和为 -80%。
                operation = "Division",
                -- value = 0
            }
        }
    }
}

-- 产能插件
local data_raw_productivity_module_catalog = {
    module = { -- 插件
        orig = {
            "productivity-module", -- 产能插件 1
            "productivity-module-2", -- 产能插件 1
            "productivity-module-3", -- 产能插件 3
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-module-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "effect", "consumption", "bonus" }, -- 能耗的乘数（非空闲/排水使用）。最小可能的总和为 -80%。
                operation = "Division",
            },
            {
                path = { "effect", "speed", "bonus" }, -- 制作速度、研究速度等。最小可能的总和为 -80%。
                operation = "Division",
            },
            {
                path = { "effect", "productivity", "bonus" } -- 产能。最小可能的总和为 0%。
            },
            {
                path = { "effect", "pollution", "bonus" }, -- 污染因子的乘数。最小可能的总和为 -80%。
                operation = "Division",
                -- value = 0
            }
        }
    }
}

-- 节能插件
local data_raw_effectivity_module_catalog = {
    module = { -- 插件
        orig = {
            "effectivity-module", -- 节能插件 1
            "effectivity-module-2", -- 节能插件 2
            "effectivity-module-3", -- 节能插件 3
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-module-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "effect", "consumption", "bonus" }, -- 能耗的乘数（非空闲/排水使用）。最小可能的总和为 -80%。
            },
            {
                path = { "effect", "speed", "bonus" } -- 制作速度、研究速度等。最小可能的总和为 -80%。
            },
            {
                path = { "effect", "productivity", "bonus" } -- 产能。最小可能的总和为 0%。
            },
            {
                path = { "effect", "pollution", "bonus" }, -- 污染因子的乘数。最小可能的总和为 -80%。
                operation = "Division",
                -- value = 0
            }
        }
    }
}

-- 插件槽允许所有类型
local data_raw_module_slot_all_type_allowed_catalog = {
    ["mining-drill"] = { -- 采矿-钻探
        orig = {
            "burner-mining-drill", -- 热能采矿机
            "electric-mining-drill", -- 电力采矿机
            "pumpjack" -- 抽油机
        },
        mod = {
            "kr-mineral-water-pumpjack", -- Krastorio2
            "kr-quarry-drill",
            "kr-electric-mining-drill-mk2",
            "kr-electric-mining-drill-mk3", -- Krastorio2
            "bob-mining-drill-1", -- bobmining
            "bob-mining-drill-2",
            "bob-mining-drill-3",
            "bob-mining-drill-4",
            "bob-area-mining-drill-1",
            "bob-area-mining-drill-2",
            "bob-area-mining-drill-3",
            "bob-area-mining-drill-4",
            "bob-pumpjack-1",
            "bob-pumpjack-2",
            "bob-pumpjack-3",
            "bob-pumpjack-4",
            "steam-mining-drill", -- bobmining
            "area-mining-drill", -- aai-industry
        },
        modify_parameter = {
            {
                path = { "allowed_effects" }, -- 允许插件类型
                value = { "speed", "productivity", "consumption", "pollution" },
                operation = "Extend"
            }
        }
    },
    furnace = { -- 熔炉
        orig = {
            "stone-furnace", -- 石炉
            "steel-furnace", -- 钢炉
            "electric-furnace" -- 电炉
        },
        mod = {
            "flare-stack", -- Flare Stack
            "incinerator",
            "electric-incinerator",
            "vent-stack", -- Flare Stack
            "kr-crusher", -- Krastorio2
            "kr-fluid-burner",
            "kr-stabilizer-charging-station", -- Krastorio2
            "electric-furnace-2", -- bobassembly
            "electric-furnace-3",
            "fluid-furnace" -- bobassembly
        },
        modify_parameter = {
            {
                path = { "allowed_effects" }, -- 允许插件类型
                value = { "speed", "productivity", "consumption", "pollution" },
                operation = "Extend"
            }
        }
    },
    ["assembling-machine"] = { -- 装配机
        orig = {
            "assembling-machine-1", -- 组装机1型
            "assembling-machine-2", -- 组装机2型
            "assembling-machine-3", -- 组装机3型
            "centrifuge", -- 离心机
            "chemical-plant", -- 化工厂
            "oil-refinery" -- 炼油厂
        },
        mod = {
            "kr-advanced-chemical-plant", -- Krastorio2
            "kr-advanced-furnace",
            "kr-atmospheric-condenser",
            "kr-bio-lab",
            "kr-electrolysis-plant",
            "kr-filtration-plant",
            "kr-fuel-refinery",
            "kr-fusion-reactor",
            "kr-greenhouse",
            "kr-matter-assembler",
            "kr-matter-plant",
            "kr-quantum-computer",
            "kr-research-server",
            "kr-advanced-assembling-machine",
            "stone-furnace",
            "electric-furnace",
            "electric-furnace-2",
            "electric-furnace-3",
            "steel-furnace",
            "fluid-furnace", -- Krastorio2
            "assembling-machine-4", -- bobassembly
            "assembling-machine-5",
            "assembling-machine-6",
            "electronics-machine-1",
            "electronics-machine-2",
            "electronics-machine-3",
            "steam-assembling-machine",
            "oil-refinery-2",
            "oil-refinery-3",
            "oil-refinery-4",
            "chemical-plant-2",
            "chemical-plant-3",
            "chemical-plant-4",
            "centrifuge-2",
            "centrifuge-3", -- bobassembly
            "burner-assembling-machine", -- aai-industry start
            "fuel-processor",
            "industrial-furnace", -- aai-industry end
            "air-filter-rampant-industry", -- RampantIndustry
            "air-filter-2-rampant-industry",
            "advanced-oil-refinery-rampant-industry",
            "advanced-assembler-rampant-industry",
            "advanced-chemical-plant-rampant-industry",
            "advanced-furnace-rampant-industry",
            "advanced-electric-furnace-rampant-industry", -- RampantIndustry
        },
        modify_parameter = {
            {
                path = { "allowed_effects" }, -- 允许插件类型
                value = { "speed", "productivity", "consumption", "pollution" },
                operation = "Extend"
            }
        }
    },
    lab = { -- 研究中心
        orig = {
            "lab" -- 研究中心
        },
        mod = {
            "biusart-lab", -- Krastorio2
            "kr-singularity-lab", -- Krastorio2
            "burner-lab", -- aai-industry
            "advanced-lab-rampant-industry", -- RampantIndustry
        },
        modify_parameter = {
            {
                path = { "allowed_effects" }, -- 允许插件类型
                value = { "speed", "productivity", "consumption", "pollution" },
                operation = "Extend"
            }
        }
    },
    beacon = { -- 插件效果分享塔
        orig = {
            "beacon" -- 研究中心
        },
        mod = {
            "kr-singularity-beacon", -- Krastorio2
        },
        modify_parameter = {
            {
                path = { "allowed_effects" }, -- 允许插件类型
                value = { "speed", "productivity", "consumption", "pollution" },
                operation = "Extend"
            }
        }
    },
    ["rocket-silo"] = { -- 火箭发射井
        orig = {
            "rocket-silo" -- 火箭发射井
        },
        modify_parameter = {
            {
                path = { "allowed_effects" }, -- 允许插件类型
                value = { "speed", "productivity", "consumption", "pollution" },
                operation = "Extend"
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------其他 start------------------\n\n\n")

common_data_raw:execute_modify(data_raw_other_catalog)
common_data_raw:execute_modify(data_raw_spidertron_equipment_grid_catalog)
common_data_raw:execute_modify(data_raw_speed_module_catalog)
common_data_raw:execute_modify(data_raw_productivity_module_catalog)
common_data_raw:execute_modify(data_raw_effectivity_module_catalog)

if settings.startup["x-custom-game-module-slot-all-type-allowed-flags"].value then
    common_data_raw:execute_modify(data_raw_module_slot_all_type_allowed_catalog)
end

log("\n\n\n------------------其他 end------------------\n\n\n")
