local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.lib_logger("x-custom-game-other.lua")

-- data.raw修改目录
local data_raw_other_catalog = {
    locomotive = { -- 机车
        orig = {
            "locomotive" -- 内燃机车
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-locomotive-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "burner", "effectivity" } -- 内燃机效率
            }, {
                path = { "max_power" } -- 最大动力
            }, {
                path = { "max_speed" } -- 最大速度
            }
        }
    },
    ["repair-tool"] = { -- 修理工具
        orig = {
            "repair-pack" -- 修理包
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-repair-tool-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "durability" } -- 此工具的耐用性
            }, {
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
        },
        mul = settings.startup["x-custom-game-car-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "braking_power" } -- 动力
            }, {
                path = { "consumption" } -- 消耗
            }, {
                path = { "effectivity" } -- 效率
            }, {
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
                operation = "Div"
            }, {
                path = { "max_health" } -- 最大血量
            }, {
                path = { "movement_energy_consumption" }, -- 移动能量消耗
                operation = "Div"
            }
        }
    },
    lab = { -- 研究中心
        orig = {
            "lab" -- 研究中心
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-lab-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "max_health" } -- 最大血量
            }, {
                path = { "module_specification", "module_slots" }, -- 模块插槽数
                value = settings.startup["x-custom-game-number-of-module-slots"].value
            }, {
                path = { "researching_speed" } -- 研究速度
            }
        }
    },
    beacon = { -- 插件效果分享塔
        orig = {
            "beacon" -- 研究中心
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-beacon-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "distribution_effectivity" } -- 共享时模块效果的乘数
            }, {
                path = { "supply_area_distance" }, -- 最大距离为 64
                max_value = 64,
                -- value = 64
            }, {
                path = { "energy_usage" }, -- 能量消耗
                operation = "Div"
            }, {
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
                path = { "active_energy_usage" } -- 激活时能耗
            }, {
                path = { "energy_usage" } -- 能耗
            }, {
                path = { "module_specification", "module_slots" }, -- 模块插槽数
                value = settings.startup["x-custom-game-number-of-module-slots"].value
            }, {
                path = { "crafting_speed" } -- 制造速度
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
                operation = "Div",
                -- value = 0
            }, {
                path = { "effect", "speed", "bonus" } -- 制作速度、研究速度等。最小可能的总和为 -80%。
            }, {
                path = { "effect", "productivity", "bonus" } -- 产能。最小可能的总和为 0%。
            }, {
                path = { "effect", "pollution", "bonus" }, -- 污染因子的乘数。最小可能的总和为 -80%。
                operation = "Div",
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
                operation = "Div",
            }, {
                path = { "effect", "speed", "bonus" }, -- 制作速度、研究速度等。最小可能的总和为 -80%。
                operation = "Div",
            }, {
                path = { "effect", "productivity", "bonus" } -- 产能。最小可能的总和为 0%。
            }, {
                path = { "effect", "pollution", "bonus" }, -- 污染因子的乘数。最小可能的总和为 -80%。
                operation = "Div",
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
            }, {
                path = { "effect", "speed", "bonus" } -- 制作速度、研究速度等。最小可能的总和为 -80%。
            }, {
                path = { "effect", "productivity", "bonus" } -- 产能。最小可能的总和为 0%。
            }, {
                path = { "effect", "pollution", "bonus" }, -- 污染因子的乘数。最小可能的总和为 -80%。
                operation = "Div",
                -- value = 0
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------其他 start------------------n\n\n")

common_data_raw:execute_modify(data_raw_other_catalog)
common_data_raw:execute_modify(data_raw_speed_module_catalog)
common_data_raw:execute_modify(data_raw_productivity_module_catalog)
common_data_raw:execute_modify(data_raw_effectivity_module_catalog)

log("\n\n\n------------------其他 end------------------n\n\n")
