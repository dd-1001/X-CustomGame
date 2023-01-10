local core = require("common/core")
local lib_serpent = core.lib_serpent
local lib_string = core.lib_string
local log = core.lib_logger("x-custom-game-data_raw.lua")

local Data_raw = {
    prot_type = nil, -- 原型类型
    prot_name = nil, -- 原型名字
    prot_args = {}, -- 原型其他参数
    data_table = nil -- data.raw
}

setmetatable(Data_raw, Data_raw)

function Data_raw:new(prot_type, prot_name, ...)

    local arg_count = 0
    if prot_type then
        
        self.prot_type = lib_string.trim(prot_type)
        if string.len(self.prot_type) == 0 then self.prot_type = nil end

        if self.prot_type and prot_name then
            self.prot_name = lib_string.trim(prot_name)
            if string.len(self.prot_name) == 0 then self.prot_name = nil end
        end

        arg_count = #{ ... }
        if self.prot_type and self.prot_name and arg_count > 0 then
            for i = 1, 9, 1 do
                table.insert(self.prot_args, (...)[i])
            end
        end

    end


    if arg_count > 0 then

        local tmp_table = data.raw[self.prot_type][self.prot_name]
        if tmp_table == nil then
            goto ends
        end

        if arg_count == 1 then
            self.data_table = tmp_table[self.prot_args[1]]
        elseif arg_count == 2 then
            self.data_table = tmp_table[self.prot_args[1]][self.prot_args[2]]
        elseif arg_count == 3 then
            self.data_table = tmp_table[self.prot_args[1]][self.prot_args[2]][self.prot_args[3]]
        elseif arg_count == 4 then
            self.data_table = tmp_table[self.prot_args[1]][self.prot_args[2]][self.prot_args[3]][self.prot_args[4]]
        elseif arg_count == 5 then
            self.data_table = tmp_table[self.prot_args[1]][self.prot_args[2]][self.prot_args[3]][self.prot_args[4]][
                self.prot_args[5]]
        elseif arg_count == 6 then
            self.data_table = tmp_table[self.prot_args[1]][self.prot_args[2]][self.prot_args[3]][self.prot_args[4]][
                self.prot_args[5]][self.prot_args[6]]
        elseif arg_count == 7 then
            self.data_table = tmp_table[self.prot_args[1]][self.prot_args[2]][self.prot_args[3]][self.prot_args[4]][
                self.prot_args[5]][self.prot_args[6]][self.prot_args[7]]
        elseif arg_count == 8 then
            self.data_table = tmp_table[self.prot_args[1]][self.prot_args[2]][self.prot_args[3]][self.prot_args[4]][
                self.prot_args[5]][self.prot_args[6]][self.prot_args[7]][self.prot_args[8]]
        elseif arg_count == 9 then
            self.data_table = tmp_table[self.prot_args[1]][self.prot_args[2]][self.prot_args[3]][self.prot_args[4]][
                self.prot_args[5]][self.prot_args[6]][self.prot_args[7]][self.prot_args[8]][self.prot_args[9]]
        end
    elseif self.prot_name then
        self.data_table = data.raw[self.prot_type][self.prot_name]
    elseif self.prot_type then
        self.data_table = data.raw[self.prot_type]
    else
        self.data_table = data.raw
    end

    ::ends::
    if self.data_table == nil then
        log("Data_raw.new not found")
        return nil
    end

    return self

end

Data_raw.__call = Data_raw.new

function Data_raw:show()
    log(lib_serpent.block(self.data_table, core.serialization_format))
end

return Data_raw
