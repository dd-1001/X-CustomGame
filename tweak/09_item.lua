local Core = require("common.core")
local DataTweaker = require("common.data_tweaker")
local x_util = Core.x_util
local log = Core.Log

-- 指令表配置
local set_value_stack_size = settings.startup["x-custom-game-stack-size-multiplier"].value
local set_value_fuel = settings.startup["x-custom-game-fuel-multiplier"].value
local set_value_lamp = settings.startup["x-custom-game-lamp-performance-multiplier"].value
local set_value_repair_tool = settings.startup["x-custom-game-repair-tool-performance-multiplier"].value
local set_value_radar = settings.startup["x-custom-game-radar-performance-multiplier"].value
local instructions_item = {
    {
        type = "lamp", --灯
        name = { "*" },
        exclude_names = {},
        operations = {
            energy_usage_per_tick = { type = "multiply", value = set_value_lamp },                                     -- 耗能
            ["light.intensity"] = { type = "multiply", value = set_value_lamp, min_value = 0.001, max_value = 0.999 }, -- 亮度
            ["light.size"] = { type = "multiply", value = set_value_lamp },                                            -- 光圈半径
        }
    },
    {
        type = "repair-tool", --修理包
        name = { "*" },
        exclude_names = {},
        operations = {
            speed = { type = "multiply", value = set_value_repair_tool },      -- 修理速度
            durability = { type = "multiply", value = set_value_repair_tool }, -- 耐久度
        }
    },
    {
        type = "radar", --雷达
        name = { "*" },
        exclude_names = {},
        operations = {
            energy_per_nearby_scan = { type = "multiply", value = set_value_radar },                                -- 扫描耗能
            energy_per_sector = { type = "multiply", value = set_value_radar },                                     -- 扫描扇区耗能
            energy_usage = { type = "multiply", value = set_value_radar },                                          -- 耗能
            max_distance_of_nearby_sector_revealed = { type = "multiply", value = set_value_radar, max_value = 9 }, -- 该雷达不断显示的区域半径
            max_distance_of_sector_revealed = { type = "multiply", value = set_value_radar, max_value = 36 },       -- 扫描扇区的最大距离
            rotation_speed = { type = "multiply", value = set_value_radar },                                        -- 旋转速度
        }
    }
}

-- 查找含有fuel_value属性的原型
local function filter_fuel_value(tbl)
    return tbl.fuel_value ~= nil
end
local data_raw_fuel_value = x_util.find_with_filter(data.raw, filter_fuel_value)
-- log("\ndata_raw_fuel_value:\n" .. Core:serpent_block(data_raw_fuel_value))

-- 组装修改fuel_value属性的指令
for prototype, protonames in pairs(data_raw_fuel_value) do
    for _, protoname in ipairs(protonames) do
        local instructions_template = {}
        instructions_template["type"] = prototype
        instructions_template["name"] = { protoname }
        instructions_template["operations"] = {
            fuel_acceleration_multiplier = { type = "multiply", value = set_value_fuel }, -- 燃料加速乘数
            fuel_top_speed_multiplier = { type = "multiply", value = set_value_fuel },    -- 燃料最高速度加成
            fuel_value = { type = "multiply", value = set_value_fuel },                   -- 燃料值
        }

        table.insert(instructions_item, instructions_template)
    end
end

-- 查找含有stack_size且（若有flags的原型，则该属性中不包含not-stackable）的原型
local function filter_stack_size_and_flags(tbl)
    return tbl.stack_size ~= nil and (not tbl.flags or not x_util.table_contains(tbl.flags, "not-stackable"))
end
local data_raw_stack_size = x_util.find_with_filter(data.raw, filter_stack_size_and_flags)
-- log("\ndata_raw_stack_size:\n" .. Core:serpent_block(data_raw_stack_size))

local stack_size_exclude_names = {
    "upgrade-planner",
    "deconstruction-planner",
    "blueprint-book",
    "modular-armor",
    "power-armor",
    "power-armor-mk2",
    "light-armor",
    "heavy-armor",
    "mech-armor"
}

-- 组装修改stack_size属性的指令
for prototype, protonames in pairs(data_raw_stack_size) do
    for _, protoname in ipairs(protonames) do
        if not x_util.table_contains(stack_size_exclude_names, protoname) then
            local instructions_template = {}
            instructions_template["type"] = prototype
            instructions_template["name"] = { protoname }
            instructions_template["operations"] = {
                stack_size = { type = "multiply", value = set_value_stack_size }, -- 堆叠大小
            }

            table.insert(instructions_item, instructions_template)
        end
    end
end
-- log("\ninstructions_item:\n" .. Core:serpent_block(instructions_item))


-- 调用修改数据函数
local modified_items = DataTweaker.modify_data(data.raw, instructions_item)
-- log("instructions_item modified_items: \n" .. Core:serpent_block(modified_items))

-- 记录已修改的类型
if (Core.x_custom_game_debug) then
    for prototype, _ in pairs(modified_items or {}) do
        if not X_CUSTOM_GAME_MODIFIED_TYPE[prototype] then
            X_CUSTOM_GAME_MODIFIED_TYPE[prototype] = true
        end
    end
end
