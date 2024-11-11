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

return XString