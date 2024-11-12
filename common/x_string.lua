local XString = {}

-- 单位转换字典
local exponent_multipliers = {
    ['y'] = 1e-24,
    ['z'] = 1e-21,
    ['a'] = 1e-18,
    ['f'] = 1e-15,
    ['p'] = 1e-12,
    ['n'] = 1e-9,
    ['u'] = 1e-6,
    ['m'] = 1e-3,
    ['c'] = 1e-2,
    ['d'] = 1e-1,
    [' '] = 1,
    ['h'] = 1e2,
    ['k'] = 1e3,
    ['K'] = 1e3,
    ['M'] = 1e6,
    ['G'] = 1e9,
    ['T'] = 1e12,
    ['P'] = 1e15,
    ['E'] = 1e18,
    ['Z'] = 1e21,
    ['Y'] = 1e24
}

-- 将单位字符串转换为数值和基本单位
function XString.exponent_number(str)
    if type(str) == 'string' then
        -- 提取数值、前缀和基本单位
        local value, prefix, basic_unit = str:match('([%-+]?[0-9]*%.?[0-9]+)([yzafpnumcdhkKMGTPEZY]?)(%a*)$')

        prefix = prefix or ' '        -- 若没有前缀，默认为 1 倍
        basic_unit = basic_unit or '' -- 如果没有基本单位，默认设为空字符串

        if value then
            -- 返回标准化的数值和基本单位
            return tonumber(value) * (exponent_multipliers[prefix] or 1), basic_unit
        else
            error("Invalid string format: " .. tostring(str))
        end
    elseif type(str) == 'number' then
        return str, "" -- 如果输入是数字，直接返回数值和空单位
    end
    error("Expected a string or number, got: " .. tostring(str))
end

-- 将数值转换为标准化单位字符串
function XString.number_to_exponent_string(value, unit)
    -- 计算数值的数量级，并将其调整为最接近的3的倍数
    local exponent = math.floor(math.log(math.abs(value)) / math.log(10) / 3) * 3
    -- 将数值缩放到适当范围
    local scaled_value = value / 10 ^ exponent
    local prefix = ""

    -- 查找与数量级相匹配的单位前缀
    for k, v in pairs(exponent_multipliers) do
        if math.abs(v - 10 ^ exponent) < 1e-10 then
            prefix = k
            break
        end
    end

    -- 格式化数值到字符串，保留两位小数，并添加单位前缀和基本单位
    return string.format("%.2f%s%s", scaled_value, prefix, unit)
end

return XString
