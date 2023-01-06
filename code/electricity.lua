-- 电力 electricity
local lib_logger = require("__stdlib__/stdlib/misc/logger")
local lib_string = require("__stdlib__/stdlib/utils/string")

local log = lib_logger("x-custom-game-log")
local mul = nil -- 倍数
local prot_type = nil -- 原型的类型
local prot_name = nil -- 原型的名字
local old_value = nil -- 修改前的值
local new_value = nil -- 修改后的值
local max_level = 1

-- 遍历显示table
function show_data_raw(tab, level)
    if nil == level then
        level = 1
    end

    for key, value in pairs(tab) do
        if type(value) == "table" then
            if level > max_level then
                break
            end
            log("-------table-------lv-" .. level .. "---key: " .. key .. "---")
            show_data_raw(value, level + 1)
        else
            log(tostring(key) .. ": " .. tostring(value))
        end
    end
end

-- 获取data.raw字段的值
function get_data_raw_field_value(...)
    local args = {...}
    local args_len = #args

    if args_len < 3 or args_len > 9 then
        return nil
    elseif args_len == 3 then
        return data.raw[args[1]][args[2]][args[3]]
    elseif args_len == 4 then
        return data.raw[args[1]][args[2]][args[3]][args[4]]
    elseif args_len == 5 then
        return data.raw[args[1]][args[2]][args[3]][args[4]][args[5]]
    elseif args_len == 6 then
        return data.raw[args[1]][args[2]][args[3]][args[4]][args[5]][args[6]]
    elseif args_len == 7 then
        return data.raw[args[1]][args[2]][args[3]][args[4]][args[5]][args[6]][args[7]]
    elseif args_len == 8 then
        return data.raw[args[1]][args[2]][args[3]][args[4]][args[5]][args[6]][args[7]][args[8]]
    elseif args_len == 9 then
        return data.raw[args[1]][args[2]][args[3]][args[4]][args[5]][args[6]][args[7]][args[8]][args[9]]
    end

end

-- 设置data.raw字段的值
function set_data_raw_field_vale(...)
    local args = {...}
    local args_len = #args

    if args_len < 4 or args_len > 10 then
        return false
    elseif args_len == 4 then
        data.raw[args[1]][args[2]][args[3]] = args[4]
    elseif args_len == 5 then
        data.raw[args[1]][args[2]][args[3]][args[4]] = args[5]
    elseif args_len == 6 then
        data.raw[args[1]][args[2]][args[3]][args[4]][args[5]] = args[6]
    elseif args_len == 7 then
        data.raw[args[1]][args[2]][args[3]][args[4]][args[5]][args[6]] = args[7]
    elseif args_len == 8 then
        data.raw[args[1]][args[2]][args[3]][args[4]][args[5]][args[6]][args[7]] = args[8]
    elseif args_len == 9 then
        data.raw[args[1]][args[2]][args[3]][args[4]][args[5]][args[6]][args[7]][args[8]] = args[9]
    elseif args_len == 10 then
        data.raw[args[1]][args[2]][args[3]][args[4]][args[5]][args[6]][args[7]][args[8]][args[9]] = args[10]
    end

    return true
end

-- 锅炉性能
mul = settings.startup["x-custom-game-boiler-performance-multiplier"].value
prot_type = "boiler"
prot_name = "boiler"
if mul and data.raw[prot_type][prot_name] then

    old_value = get_data_raw_field_value(prot_type, prot_name, "energy_source", "emissions_per_minute")
    if old_value then
        new_value = old_value / mul
        set_data_raw_field_vale(prot_type, prot_name, "energy_source", "emissions_per_minute", new_value)
        log("锅炉污染: " .. old_value .. "/s --> " .. new_value .. "/s")
    end

    old_value = get_data_raw_field_value(prot_type, prot_name, "fluid_box", "base_area")
    if old_value then
        new_value = old_value * mul
        set_data_raw_field_vale(prot_type, prot_name, "fluid_box", "base_area", new_value)
        log("锅炉流体储存base_area: " .. old_value .. " * " .. mul .. " --> " .. new_value)
    end

    old_value = get_data_raw_field_value(prot_type, prot_name, "output_fluid_box", "base_area")
    if old_value then
        new_value = old_value * mul
        set_data_raw_field_vale(prot_type, prot_name, "output_fluid_box", "base_area", new_value)
        log("锅炉流体输出base_area: " .. old_value .. " * " .. mul .. " --> " .. new_value)
    end

    old_value = lib_string.exponent_number(get_data_raw_field_value(prot_type, prot_name, "energy_consumption"))
    if old_value then
        new_value = old_value * mul .. "W"
        set_data_raw_field_vale(prot_type, prot_name, "energy_consumption", new_value)
        log("锅炉能量消耗: " .. old_value .. "W * " .. mul .. " --> " .. new_value)
    end

    old_value = get_data_raw_field_value(prot_type, prot_name, "energy_source", "effectivity")
    if old_value then
        new_value = old_value * mul
        set_data_raw_field_vale(prot_type, prot_name, "energy_source", "effectivity", new_value)
        log("锅炉燃料效率: " .. old_value .. " * " .. mul .. " --> " .. new_value)
    end

end

-- 蒸汽机性能
mul = settings.startup["x-custom-game-steam-engine-performance-multiplier"].value
prot_type = "generator"
prot_name = "steam-engine"
if mul and data.raw[prot_type][prot_name] then

    -- show_data_raw(data.raw[prot_type][prot_name])

    old_value = get_data_raw_field_value(prot_type, prot_name, "effectivity")
    if old_value then
        new_value = old_value * mul
        set_data_raw_field_vale(prot_type, prot_name, "effectivity", new_value)
        log("蒸汽机效率: " .. old_value .. " * " .. mul .. " --> " .. new_value)
    end

    old_value = get_data_raw_field_value(prot_type, prot_name, "fluid_box", "base_area")
    if old_value then
        new_value = old_value * mul
        set_data_raw_field_vale(prot_type, prot_name, "fluid_box", "base_area", new_value)
        log("蒸汽机储存base_area: " .. old_value .. " * " .. mul .. " --> " .. new_value)
    end

    -- show_data_raw(data.raw[prot_type][prot_name])

end

-- 太阳能板性能
mul = settings.startup["x-custom-game-solar-panel-performance-multiplier"].value
prot_type = "solar-panel"
prot_name = "solar-panel"
if mul and data.raw[prot_type][prot_name] then

    -- show_data_raw(data.raw[prot_type][prot_name])

    old_value = lib_string.exponent_number(get_data_raw_field_value(prot_type, prot_name, "production"))
    if old_value then
        new_value = old_value * mul .. "J"
        set_data_raw_field_vale(prot_type, prot_name, "production", new_value)
        log("太阳能板输出: " .. old_value .. "J * " .. mul .. " --> " .. new_value)
    end

    -- show_data_raw(data.raw[prot_type][prot_name])

end

-- 蓄电池性能
mul = settings.startup["x-custom-game-accumulator-performance-multiplier"].value
prot_type = "accumulator"
prot_name = "accumulator"
if mul and data.raw[prot_type][prot_name] then

    -- show_data_raw(data.raw[prot_type][prot_name])

    old_value = lib_string.exponent_number(get_data_raw_field_value(prot_type, prot_name, "energy_source",
        "buffer_capacity"))
    if old_value then
        new_value = old_value * mul .. "J"
        set_data_raw_field_vale(prot_type, prot_name, "energy_source", "buffer_capacity", new_value)
        log("蓄电池容量: " .. old_value .. "J * " .. mul .. " --> " .. new_value)
    end

    old_value = lib_string.exponent_number(get_data_raw_field_value(prot_type, prot_name, "energy_source",
        "input_flow_limit"))
    if old_value then
        new_value = old_value * mul .. "W"
        set_data_raw_field_vale(prot_type, prot_name, "energy_source", "input_flow_limit", new_value)
        log("蓄电池输入: " .. old_value .. "W * " .. mul .. " --> " .. new_value)
    end

    old_value = lib_string.exponent_number(get_data_raw_field_value(prot_type, prot_name, "energy_source",
        "output_flow_limit"))
    if old_value then
        new_value = old_value * mul .. "W"
        set_data_raw_field_vale(prot_type, prot_name, "energy_source", "output_flow_limit", new_value)
        log("蓄电池输出: " .. old_value .. "W * " .. mul .. " --> " .. new_value)
    end

    -- show_data_raw(data.raw[prot_type][prot_name])

end

-- 核反应堆性能
mul = settings.startup["x-custom-game-nuclear-reactor-performance-multiplier"].value
prot_type = "reactor"
prot_name = "nuclear-reactor"
if mul and data.raw[prot_type][prot_name] then

    -- show_data_raw(data.raw[prot_type][prot_name])

    old_value = lib_string.exponent_number(get_data_raw_field_value(prot_type, prot_name, "consumption"))
    if old_value then
        new_value = old_value * mul .. "W"
        set_data_raw_field_vale(prot_type, prot_name, "consumption", new_value)
        log("核反应堆能量消耗: " .. old_value .. "W * " .. mul .. " --> " .. new_value)
    end

    old_value = get_data_raw_field_value(prot_type, prot_name, "energy_source", "effectivity")
    if old_value then
        new_value = old_value * mul
        set_data_raw_field_vale(prot_type, prot_name, "energy_source", "effectivity", new_value)
        log("核反应堆消耗燃料效率: " .. old_value .. " * " .. mul .. " --> " .. new_value)
    end

    old_value = get_data_raw_field_value(prot_type, prot_name, "heat_buffer", "max_temperature")
    if old_value then
        new_value = old_value * mul
        set_data_raw_field_vale(prot_type, prot_name, "heat_buffer", "max_temperature", new_value)
        log("核反应堆最大温度: " .. old_value .. " * " .. mul .. " --> " .. new_value)
    end

    old_value = lib_string.exponent_number(
        get_data_raw_field_value(prot_type, prot_name, "heat_buffer", "specific_heat"))
    if old_value then
        new_value = old_value / mul .. "J"
        set_data_raw_field_vale(prot_type, prot_name, "heat_buffer", "specific_heat", new_value)
        log("核反应堆specific_heat: " .. old_value .. "J / " .. mul .. " --> " .. new_value)
    end

    old_value =
        lib_string.exponent_number(get_data_raw_field_value(prot_type, prot_name, "heat_buffer", "max_transfer"))
    if old_value then
        new_value = old_value * mul .. "W"
        set_data_raw_field_vale(prot_type, prot_name, "heat_buffer", "max_transfer", new_value)
        log("核反应堆max_transfer: " .. old_value .. "W * " .. mul .. " --> " .. new_value)
    end

    -- (data.raw[prot_type][prot_name])

end

-- 热管性能
mul = settings.startup["x-custom-game-heat-pipe-performance-multiplier"].value
prot_type = "heat-pipe"
prot_name = "heat-pipe"
if mul and data.raw[prot_type][prot_name] then

    -- show_data_raw(data.raw[prot_type][prot_name])

    old_value = get_data_raw_field_value(prot_type, prot_name, "heat_buffer", "max_temperature")
    if old_value then
        new_value = old_value * mul
        set_data_raw_field_vale(prot_type, prot_name, "heat_buffer", "max_temperature", new_value)
        log("热管最大温度: " .. old_value .. " * " .. mul .. " --> " .. new_value)
    end

    old_value = lib_string.exponent_number(
        get_data_raw_field_value(prot_type, prot_name, "heat_buffer", "specific_heat"))
    if old_value then
        new_value = old_value / mul .. "J"
        set_data_raw_field_vale(prot_type, prot_name, "heat_buffer", "specific_heat", new_value)
        log("热管specific_heat: " .. old_value .. "J / " .. mul .. " --> " .. new_value)
    end

    old_value =
        lib_string.exponent_number(get_data_raw_field_value(prot_type, prot_name, "heat_buffer", "max_transfer"))
    if old_value then
        new_value = old_value * mul .. "W"
        set_data_raw_field_vale(prot_type, prot_name, "heat_buffer", "max_transfer", new_value)
        log("热管max_transfer: " .. old_value .. "W * " .. mul .. " --> " .. new_value)
    end

    -- show_data_raw(data.raw[prot_type][prot_name])

end

-- 换热器性能
mul = settings.startup["x-custom-game-heat-pipe-performance-multiplier"].value
prot_type = "boiler"
prot_name = "heat-exchanger"
if mul and data.raw[prot_type][prot_name] then

    --show_data_raw(data.raw[prot_type][prot_name])

    old_value = get_data_raw_field_value(prot_type, prot_name, "fluid_box", "base_area")
    if old_value then
        new_value = old_value * mul
        set_data_raw_field_vale(prot_type, prot_name, "fluid_box", "base_area", new_value)
        log("换热器储存base_area: " .. old_value .. " * " .. mul .. " --> " .. new_value)
    end

    old_value = get_data_raw_field_value(prot_type, prot_name, "output_fluid_box", "base_area")
    if old_value then
        new_value = old_value * mul
        set_data_raw_field_vale(prot_type, prot_name, "output_fluid_box", "base_area", new_value)
        log("换热器输出base_area: " .. old_value .. " * " .. mul .. " --> " .. new_value)
    end

    old_value = lib_string.exponent_number(get_data_raw_field_value(prot_type, prot_name, "energy_source",
        "specific_heat"))
    if old_value then
        new_value = old_value / mul .. "J"
        set_data_raw_field_vale(prot_type, prot_name, "energy_source", "specific_heat", new_value)
        log("换热器specific_heat: " .. old_value .. "J / " .. mul .. " --> " .. new_value)
    end

    old_value = lib_string.exponent_number(get_data_raw_field_value(prot_type, prot_name, "energy_consumption"))
    if old_value then
        new_value = old_value * mul .. "W"
        set_data_raw_field_vale(prot_type, prot_name, "energy_consumption", new_value)
        log("换热器能量消耗: " .. old_value .. "W * " .. mul .. " --> " .. new_value)
    end

    --show_data_raw(data.raw[prot_type][prot_name])

end

-- 汽轮机性能
mul = settings.startup["x-custom-game-steam-engine-performance-multiplier"].value
prot_type = "generator"
prot_name = "steam-turbine"
if mul and data.raw[prot_type][prot_name] then

    --show_data_raw(data.raw[prot_type][prot_name])

    old_value = get_data_raw_field_value(prot_type, prot_name, "effectivity")
    if old_value then
        new_value = old_value * mul
        set_data_raw_field_vale(prot_type, prot_name, "effectivity", new_value)
        log("汽轮机效率: " .. old_value .. " * " .. mul .. " --> " .. new_value)
    end

    old_value = get_data_raw_field_value(prot_type, prot_name, "fluid_box", "base_area")
    if old_value then
        new_value = old_value * mul
        set_data_raw_field_vale(prot_type, prot_name, "fluid_box", "base_area", new_value)
        log("汽轮机储存base_area: " .. old_value .. " * " .. mul .. " --> " .. new_value)
    end

    --show_data_raw(data.raw[prot_type][prot_name])

end
