local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local lib_string = common_core.lib_string
local log = common_core.lib_logger("x-custom-game-electricity.lua")

-- 各类型的修改参数
local field_path_type = {
    boiler = {
        {
            path = { "energy_consumption" } -- 能量消耗
        }, {
            path = { "energy_source", "effectivity" } -- 可选。1意味着100%的效果。必须大于0。 能量输出的乘数。
        }, {
            path = { "energy_source", "emissions_per_minute" }, -- 可选的。一个实体在全能量消耗下每分钟排放的污染。正是实体工具提示中显示的值。
            operation = "Div" -- Mul 做乘法， Div 做除法
        }, {
            path = { "energy_source", "specific_heat" }, -- 比热容。吸收能量的多少
            operation = "Div"
        }, {
            path = { "fluid_box", "base_area" } -- 必须大于0。液箱的总液体容量为base_area × height × 100
        }, {
            path = { "output_fluid_box", "base_area" } -- 必须大于0。液箱的总液体容量为base_area × height × 100
        }
    },
    generator = {
        {
            path = { "effectivity" } -- 效率
        }, {
            path = { "fluid_box", "base_area" }
        }
    },
    ["solar-panel"] = {
        {
            path = { "production" } -- 发电量
        }
    },
    accumulator = {
        {
            path = { "energy_source", "buffer_capacity" } -- 电池容量
        }, {
            path = { "energy_source", "input_flow_limit" } -- 电池输入限制
        }, {
            path = { "energy_source", "output_flow_limit" } -- 电池输出限制
        }
    },
    reactor = {
        {
            path = { "consumption" } -- 能量消耗量
        }, {
            path = { "energy_source", "effectivity" } -- 效率
        }, {
            path = { "heat_buffer", "max_temperature" } -- 最高温度
        }, {
            path = { "heat_buffer", "max_transfer" } -- 最大传输量
        }, {
            path = { "heat_buffer", "specific_heat" }, -- 比热容
            operation = "Div"
        }
    },
    ["heat-pipe"] = {
        {
            path = { "heat_buffer", "max_temperature" } -- 最高温度
        }, {
            path = { "heat_buffer", "max_transfer" } -- 最大传输量
        }, {
            path = { "heat_buffer", "specific_heat" }, -- 比热容
            operation = "Div"
        }
    }
}

-- 可修改的类型
local prot_type = {
    boiler = { -- 锅炉
        orig = {
            "boiler", -- 锅炉
            "heat-exchanger" -- 换热器
        },
        mod = {
        }
    },
    generator = { -- 发电机
        orig = {
            "steam-engine", -- 蒸汽机
            "steam-turbine" -- 汽轮机
        },
        mod = {
        }
    },
    ["solar-panel"] = { -- 太阳能板
        orig = {
            "solar-panel" -- 太阳能板
        },
        mod = {
            "advanced-solar", -- 高级太阳能板
            "elite-solar", -- 精英太阳能板
            "ultimate-solar" -- 终极太阳能板
        }
    },
    accumulator = { -- 蓄电池
        orig = {
            "accumulator" -- 蓄电池
        },
        mod = {
            "advanced-accumulator", -- 高级蓄电池
            "elite-accumulator", -- 精英蓄电池
            "ultimate-accumulator" -- 终极蓄电池
        }
    },
    reactor = { -- 核反应堆
        orig = {
            "nuclear-reactor" -- 核反应堆
        },
        mod = {
        }
    },
    ["heat-pipe"] = { -- 热管
        orig = {
            "heat-pipe" -- 核反应堆
        },
        mod = {
        }
    }
}

-- 修改倍数
local mul_table = {
    boiler = settings.startup["x-custom-game-boiler-performance-multiplier"].value,
    generator = settings.startup["x-custom-game-generator-performance-multiplier"].value,
    ["solar-panel"] = settings.startup["x-custom-game-solar-panel-performance-multiplier"].value,
    accumulator = settings.startup["x-custom-game-accumulator-performance-multiplier"].value,
    reactor = settings.startup["x-custom-game-reactor-performance-multiplier"].value,
    ["heat-pipe"] = settings.startup["x-custom-game-heat-pipe-performance-multiplier"].value

}

-- 开始修改
-- log("\n\n\n------------------electricity start------------------\n\n\n")

for tmp_prot_type, tmp_table in pairs(prot_type) do
    -- tmp_prot_type = 原型类型："boiler", ...
    -- tmp_table = { orig = { "boiler" }, mod = { }}

    local prot_name = tmp_table.orig
    local is_moded = false
    ::MOD::
    for _, tmp_prot_name in ipairs(prot_name) do
        -- tmp_prot_name = 原型名字："boiler"...

        -- log(common_core:serialization_table(common_data_raw:get_data_raw_field_value({tmp_prot_type, tmp_prot_name})))

        for i, field_path in ipairs(field_path_type[tmp_prot_type]) do
            -- field_path = 字段路径: { "energy_source", "effectivity" }

            local tmp_field_path = {}
            table.insert(tmp_field_path, tmp_prot_type)
            table.insert(tmp_field_path, tmp_prot_name)
            for _, value in ipairs(field_path.path) do
                table.insert(tmp_field_path, value) -- tmp_field_path = { "boiler", "boiler", "energy_source", "emissions_per_minute" }
            end

            -- 设置new_value
            local old_value = common_data_raw:get_data_raw_field_value(tmp_field_path)
            if old_value and mul_table[tmp_prot_type] then

                -- 判断单位
                local field_units
                if type(old_value) == "string" then
                    _, field_units = old_value:match('([%-+]?[0-9]*%.?[0-9]+)([yzafpnumcdhkJMGTPEZY]?)')
                    if string.len(field_units) ~= 0 then
                        -- 有单位，则获取单位
                        field_units = string.sub(old_value, -1)
                    end
                end

                old_value = lib_string.exponent_number(old_value)

                local new_value

                -- 做除法
                if field_path.operation == "Div" then
                    new_value = old_value / mul_table[tmp_prot_type]
                else -- 做乘法
                    new_value = old_value * mul_table[tmp_prot_type]
                end

                -- 添加单位
                if field_units then
                    new_value = new_value .. field_units
                end

                old_value = common_data_raw:set_data_raw_field_value(tmp_field_path, new_value)

                log(table.concat(tmp_field_path, ".") .. " : " .. old_value .. " ---> " .. new_value)
            else
                log(table.concat(tmp_field_path, ".") .. " is nil, or mul is nil")
            end
        end

        -- log(common_core:serialization_table(common_data_raw:get_data_raw_field_value({tmp_prot_type, tmp_prot_name})))
    end

    if not is_moded and settings.startup["x-custom-game-effect-mod-flags"].value then
    -- if not is_moded and false then
        log("goto MOD lable")
        prot_name = tmp_table.mod
        is_moded = true
        goto MOD
    end

end

-- log("\n\n\n------------------electricity end------------------\n\n\n")
