local n, v = "serpent", "0.303" -- (C) 2012-18 Paul Kulchenko; MIT License
local c, d = "Paul Kulchenko", "Lua serializer and pretty printer"
local snum = { [tostring(1 / 0)] = '1/0 --[[math.huge]]', [tostring(-1 / 0)] = '-1/0 --[[-math.huge]]',
    [tostring(0 / 0)] = '0/0' }
local badtype = { thread = true, userdata = true, cdata = true }
local getmetatable = debug and debug.getmetatable or getmetatable
local pairs = function(t) return next, t end -- avoid using __pairs in Lua 5.2+
local keyword, globals, G = {}, {}, (_G or _ENV)
for _, k in ipairs({ 'and', 'break', 'do', 'else', 'elseif', 'end', 'false',
    'for', 'function', 'goto', 'if', 'in', 'local', 'nil', 'not', 'or', 'repeat',
    'return', 'then', 'true', 'until', 'while' }) do keyword[k] = true end
for k, v in pairs(G) do globals[v] = k end -- build func to name mapping
for _, g in ipairs({ 'coroutine', 'debug', 'io', 'math', 'string', 'table', 'os' }) do
    for k, v in pairs(type(G[g]) == 'table' and G[g] or {}) do globals[v] = g .. '.' .. k end
end

local function s(t, opts)
    local name, indent, fatal, maxnum = opts.name, opts.indent, opts.fatal, opts.maxnum
    local sparse, custom, huge = opts.sparse, opts.custom, not opts.nohuge
    local space, maxl = (opts.compact and '' or ' '), (opts.maxlevel or math.huge)
    local maxlen, metatostring = tonumber(opts.maxlength), opts.metatostring
    local iname, comm = '_' .. (name or ''), opts.comment and (tonumber(opts.comment) or math.huge)
    local numformat = opts.numformat or "%.17g"
    local seen, sref, syms, symn = {}, { 'local ' .. iname .. '={}' }, {}, 0
    local function gensym(val) return '_' .. (tostring(tostring(val)):gsub("[^%w]", ""):gsub("(%d%w+)",
            -- tostring(val) is needed because __tostring may return a non-string value
            function(s) if not syms[s] then symn = symn + 1;
                    syms[s] = symn
                end
                return tostring(syms[s])
            end))
    end

    local function safestr(s) return type(s) == "number" and (huge and snum[tostring(s)] or numformat:format(s))
            or type(s) ~= "string" and tostring(s) -- escape NEWLINE/010 and EOF/026
            or ("%q"):format(s):gsub("\010", "n"):gsub("\026", "\\026")
    end

    -- handle radix changes in some locales
    if opts.fixradix and (".1f"):format(1.2) ~= "1.2" then
        local origsafestr = safestr
        safestr = function(s) return type(s) == "number"
                and (nohuge and snum[tostring(s)] or numformat:format(s):gsub(",", ".")) or origsafestr(s)
        end
    end
    local function comment(s, l) return comm and (l or 0) < comm and ' --[[' .. select(2, pcall(tostring, s)) .. ']]' or
            ''
    end

    local function globerr(s, l) return globals[s] and globals[s] .. comment(s, l) or not fatal
            and safestr(select(2, pcall(tostring, s))) or error("Can't serialize " .. tostring(s))
    end

    local function safename(path, name) -- generates foo.bar, foo[3], or foo['b a r']
        local n = name == nil and '' or name
        local plain = type(n) == "string" and n:match("^[%l%u_][%w_]*$") and not keyword[n]
        local safe = plain and n or '[' .. safestr(n) .. ']'
        return (path or '') .. (plain and path and '.' or '') .. safe, safe
    end

    local alphanumsort = type(opts.sortkeys) == 'function' and opts.sortkeys or
        function(k, o, n) -- k=keys, o=originaltable, n=padding
            local maxn, to = tonumber(n) or 12, { number = 'a', string = 'b' }
            local function padnum(d) return ("%0" .. tostring(maxn) .. "d"):format(tonumber(d)) end

            table.sort(k, function(a, b)
                -- sort numeric keys first: k[key] is not nil for numerical keys
                return (k[a] ~= nil and 0 or to[type(a)] or 'z') .. (tostring(a):gsub("%d+", padnum))
                    < (k[b] ~= nil and 0 or to[type(b)] or 'z') .. (tostring(b):gsub("%d+", padnum))
            end)
        end
    local function val2str(t, name, indent, insref, path, plainindex, level)
        local ttype, level, mt = type(t), (level or 0), getmetatable(t)
        local spath, sname = safename(path, name)
        local tag = plainindex and
            ((type(name) == "number") and '' or name .. space .. '=' .. space) or
            (name ~= nil and sname .. space .. '=' .. space or '')
        if seen[t] then -- already seen this element
            sref[#sref + 1] = spath .. space .. '=' .. space .. seen[t]
            return tag .. 'nil' .. comment('ref', level)
        end
        -- protect from those cases where __tostring may fail
        if type(mt) == 'table' and metatostring ~= false then
            local to, tr = pcall(function() return mt.__tostring(t) end)
            local so, sr = pcall(function() return mt.__serialize(t) end)
            if (to or so) then -- knows how to serialize itself
                seen[t] = insref or spath
                t = so and sr or tr
                ttype = type(t)
            end -- new value falls through to be serialized
        end
        if ttype == "table" then
            if level >= maxl then return tag .. '{}' .. comment('maxlvl', level) end
            seen[t] = insref or spath
            if next(t) == nil then return tag .. '{}' .. comment(t, level) end -- table empty
            if maxlen and maxlen < 0 then return tag .. '{}' .. comment('maxlen', level) end
            local maxn, o, out = math.min(#t, maxnum or #t), {}, {}
            for key = 1, maxn do o[key] = key end
            if not maxnum or #o < maxnum then
                local n = #o -- n = n + 1; o[n] is much faster than o[#o+1] on large tables
                for key in pairs(t) do
                    if o[key] ~= key then n = n + 1;
                        o[n] = key
                    end
                end
            end
            if maxnum and #o > maxnum then o[maxnum + 1] = nil end
            if opts.sortkeys and #o > maxn then alphanumsort(o, t, opts.sortkeys) end
            local sparse = sparse and #o > maxn -- disable sparsness if only numeric keys (shorter output)
            for n, key in ipairs(o) do
                local value, ktype, plainindex = t[key], type(key), n <= maxn and not sparse
                if opts.valignore and opts.valignore[value] -- skip ignored values; do nothing
                    or opts.keyallow and not opts.keyallow[key]
                    or opts.keyignore and opts.keyignore[key]
                    or opts.valtypeignore and opts.valtypeignore[type(value)] -- skipping ignored value types
                    or sparse and value == nil then -- skipping nils; do nothing
                elseif ktype == 'table' or ktype == 'function' or badtype[ktype] then
                    if not seen[key] and not globals[key] then
                        sref[#sref + 1] = 'placeholder'
                        local sname = safename(iname, gensym(key)) -- iname is table for local variables
                        sref[#sref] = val2str(key, sname, indent, sname, iname, true)
                    end
                    sref[#sref + 1] = 'placeholder'
                    local path = seen[t] .. '[' .. tostring(seen[key] or globals[key] or gensym(key)) .. ']'
                    sref[#sref] = path .. space .. '=' .. space ..
                        tostring(seen[value] or val2str(value, nil, indent, path))
                else
                    out[#out + 1] = val2str(value, key, indent, nil, seen[t], plainindex, level + 1)
                    if maxlen then
                        maxlen = maxlen - #out[#out]
                        if maxlen < 0 then break end
                    end
                end
            end
            local prefix = string.rep(indent or '', level)
            local head = indent and '{\n' .. prefix .. indent or '{'
            local body = table.concat(out, ',' .. (indent and '\n' .. prefix .. indent or space))
            local tail = indent and "\n" .. prefix .. '}' or '}'
            return (custom and custom(tag, head, body, tail, level) or tag .. head .. body .. tail) .. comment(t, level)
        elseif badtype[ttype] then
            seen[t] = insref or spath
            return tag .. globerr(t, level)
        elseif ttype == 'function' then
            seen[t] = insref or spath
            if opts.nocode then return tag .. "function() --[[..skipped..]] end" .. comment(t, level) end
            local ok, res = pcall(string.dump, t)
            local func = ok and "((loadstring or load)(" .. safestr(res) .. ",'@serialized'))" .. comment(t, level)
            return tag .. (func or globerr(t, level))
        else return tag .. safestr(t) end -- handle all other types
    end

    local sepr = indent and "\n" or ";" .. space
    local body = val2str(t, name, indent) -- this call also populates sref
    local tail = #sref > 1 and table.concat(sref, sepr) .. sepr or ''
    local warn = opts.comment and #sref > 1 and space .. "--[[incomplete output with shared/self-references skipped]]" or
        ''
    return not name and body .. warn or "do local " .. body .. sepr .. tail .. "return " .. name .. sepr .. "end"
end

local function deserialize(data, opts)
    local env = (opts and opts.safe == false) and G
        or setmetatable({}, {
            __index = function(t, k) return t end,
            __call = function(t, ...) error("cannot call functions") end
        })
    local f, res = (loadstring or load)('return ' .. data, nil, nil, env)
    if not f then f, res = (loadstring or load)(data, nil, nil, env) end
    if not f then return f, res end
    if setfenv then setfenv(f, env) end
    return pcall(f)
end

local function merge(a, b)
    if b then
        for k, v in pairs(b) do
            a[k] = v
        end
    end
    return a;
end

return {
    _NAME = n,
    _COPYRIGHT = c,
    _DESCRIPTION = d,
    _VERSION = v,
    serialize = s,
    load = deserialize,
    dump = function(a, opts) return s(a, merge({ name = '_', compact = true, sparse = true }, opts)) end,
    line = function(a, opts) return s(a, merge({ sortkeys = true, comment = true }, opts)) end,
    block = function(a, opts) return s(a, merge({ indent = '  ', sortkeys = true, comment = true }, opts)) end
}

-- Serpent提供了三个函数，它们是同一内部函数的快捷方式，但默认设置了不同的选项。
-- dump(a[, {...}]) -- 完全序列化。集合和选项：name compact sparse
-- line(a[, {...}]) -- 单行漂亮的打印，没有自述部分。集合和选项：sortkeys comment
-- block(a[, {...}]) -- 多行缩进的漂亮打印，没有自述部分。集合和选项：indent sortkeys comment
-- 虽然你可以使用或函数来加载序列化的片段，但Serpent也提供了增加安全检查的函数，如果片段中有任何可执行的代码，则报告错误。loadstring load load
-- ok, res = serpent.load(str[, {safe = true}]) -- 加载序列化的片段；如果你想关闭安全检查，你需要传递第二个值。{safe = false}
-- 和调用类似，返回状态作为第一个值，结果或错误信息作为第二个值。pcall loadstring load
-- indent (string) -- 缩进；触发长的多行输出。
-- comment (true/false/maxlevel) -- 在注释中提供字符串化的值（最多深度）.maxlevel
-- sortkeys (true/false/function) -- 排序键。
-- sparse (true/false) -- 强制进行稀疏编码（没有基于）.#t的nil填充。
-- compact (true/false) -- 删除空格。
-- fatal (true/false) -- 对不可交换的值提出致命的错误。
-- fixradix (true/False) -- 根据当地的情况，将小数点字符集改为十进制点。
-- nocode (true/False) -- 禁用字节码序列化以方便比较。
-- nohuge (true/False) -- 禁用对未定义和巨大数值的检查。
-- maxlevel (number) -- 指定扩展嵌套表的最大级别。
-- maxnum (number) -- 指定一个表格中元素的最大数量。
-- maxlength (number) -- 指定所有表元素的最大长度。
-- metatostring (True/false) -- 在序列化表的时候使用metamethod (v0.29); 设置为禁用，并按原样序列化表，即使存在。
-- numformat (string; "%.17g") -- 指定数值的格式为最短的可圆滑的双数(v0.30)。使用"%.16g "可以获得更好的可读性，使用"%.17g"（默认值）可以保留浮点精度。
-- valignore (table) -- 允许指定一个要忽略的值列表（作为键）。
-- keyallow (table) -- 允许指定要被序列化的键的列表。任何不在这个列表中的键都不包括在最终输出中（作为键）。
-- keyignore (table) -- 允许指定在序列化中忽略的键的列表。
-- valtypeignore (table) -- 允许指定一个要忽略的值类型列表（作为键）。
-- custom (function) -- 为表提供自定义输出。
-- name (string) -- 名称；触发带有自引用部分的完整序列化。
