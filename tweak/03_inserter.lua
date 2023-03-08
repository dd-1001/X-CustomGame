local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.Log

-- 机械臂
local data_raw_inserter_catalog = {
    inserter = { -- 机械臂
        orig = {
            "burner-inserter", -- 热能机械臂
            "inserter", -- 电力机械臂
            "long-handed-inserter", -- 加长机械臂
            "stack-filter-inserter", -- 集装筛选机械臂
            "stack-inserter", -- 集装机械臂
            "fast-inserter", -- 高速机械臂
            "filter-inserter" -- 筛选机械臂
        },
        mod = {
            "space-miniloader-inserter", -- space-exploration
            "space-filter-miniloader-inserter",
            "deep-space-miniloader-inserter",
            "deep-space-filter-miniloader-inserter", -- space-exploration
            "miniloader-inserter", -- miniloader
            "filter-miniloader-inserter",
            "fast-miniloader-inserter",
            "fast-filter-miniloader-inserter",
            "express-miniloader-inserter",
            "express-filter-miniloader-inserter",
            "basic-miniloader-inserter",
            "basic-filter-miniloader-inserter",
            "turbo-miniloader-inserter",
            "turbo-filter-miniloader-inserter",
            "ultimate-miniloader-inserter",
            "ultimate-filter-miniloader-inserter",
            "chute-miniloader-inserter", -- miniloader
            "kr-superior-inserter", -- Krastorio2
            "kr-superior-long-inserter",
            "kr-superior-filter-inserter",
            "kr-superior-long-filter-inserter",
            "kr-advanced-miniloader-inserter",
            "kr-advanced-filter-miniloader-inserter",
            "kr-superior-miniloader-inserter",
            "kr-superior-filter-miniloader-inserter", -- Krastorio2
            "steam-inserter", -- boblogistics
            "express-inserter",
            "express-filter-inserter",
            "express-stack-inserter",
            "express-stack-filter-inserter",
            "yellow-filter-inserter",
            "red-inserter",
            "red-filter-inserter",
            "red-stack-inserter",
            "red-stack-filter-inserter",
            "turbo-inserter",
            "turbo-filter-inserter",
            "turbo-stack-inserter",
            "turbo-stack-filter-inserter" -- boblogistics
        },
        mul = settings.startup["x-custom-game-inserter-performance-multiplier"].value,
        modify_parameter = { -- 修改参数
            {
                path = { "energy_source", "effectivity" } -- 能源利用效率
            },
            {
                path = { "energy_per_movement" }, -- 每次动消耗能量
                operation = "Division"
            },
            {
                path = { "energy_per_rotation" }, -- 每次旋转耗能量
                operation = "Division"
            },
            {
                path = { "stack_size_bonus" }, -- 固有的堆栈大小奖励
                operation = "Extend",
                value = settings.startup["x-custom-game-inserter-performance-multiplier"].value
            },
            {
                path = { "extension_speed" } -- 延伸速度
            },
            {
                path = { "rotation_speed" } -- 旋转速度
            },
            {
                path = { "max_health" } -- 最大血量
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------机械臂 start------------------\n\n\n")

if settings.startup["x-custom-game-affects-other-untested-mod-flags"].value then
    common_data_raw:add_other_untested_list(data_raw_inserter_catalog)
end
common_data_raw:execute_modify(data_raw_inserter_catalog)

log("\n\n\n------------------机械臂 end------------------\n\n\n")
