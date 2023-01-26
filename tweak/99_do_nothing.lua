local common_data_raw = require("common/data_raw")

-- 什么都不做修改，仅做记录
local data_raw_do_nothing_catalog = {
    ["burner-generator"] = {
        mod = {
            "burner-generator", -- aai-industry
        }
    },
    pump = {
        mod = {
            "offshore-pump-output", -- aai-industry
        }
    }
}

common_data_raw:execute_modify(data_raw_do_nothing_catalog, false)
