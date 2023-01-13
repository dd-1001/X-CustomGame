local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.lib_logger("x-custom-game-machine.lua")

-- data.raw修改目录
local data_raw_machine_catalog = {
    ["mining-drill"] = { -- 采矿-钻探
        orig = {
            "burner-mining-drill", -- 热能采矿机
            "electric-mining-drill", -- 电力采矿机
            "pumpjack" -- 抽油机
        },
        mod = {
        },
        mul = settings.startup["x-custom-game-mining-drill-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "energy_source", "effectivity" } -- 能源利用效率
            }, {
                path = { "energy_source", "emissions_per_minute" }, -- 每分钟产生污染量
                operation = "Div"
            }, {
                path = { "energy_usage" } -- 能源消耗量
            }, {
                path = { "mining_speed" } -- 采矿速度
            }, {
                path = { "output_fluid_box", "base_area" }, -- 流体箱的总流体容量：base_area × height × 100
                max_value = 100
            }, {
                path = { "input_fluid_box", "height" }, -- 流体箱的总流体容量：base_area × height × 100
                max_value = 10
            }, {
                path = { "module_specification", "module_slots" }, -- 模块插槽数
                value = 20
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------生产机器 start------------------n\n\n")

common_data_raw:execute_modify(data_raw_machine_catalog)

log("\n\n\n------------------生产机器 end------------------n\n\n")
