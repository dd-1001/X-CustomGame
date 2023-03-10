local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.Log

local set_value = settings.startup["x-custom-game-infinite-technology-cost-formula"].value
local function modify_infinite_technology_cost_formula()
    for _, tech in pairs(data.raw.technology) do
        if tech.max_level and tech.max_level == "infinite" then
            local old_value = tech.unit.count_formula
            tech.unit.count_formula = set_value
            log(tech.name .. ".count_formula: " .. old_value .. " ---> " .. tech.unit.count_formula)
        end
    end
end

local mul = settings.startup["x-custom-game-technology-cost-multiplier"].value
local function modify_technology_cost()
    for _, tech in pairs(data.raw.technology) do
        if tech.unit.count then
            local tmp_count = tech.unit.count * mul
            if tmp_count < 1 then
                tmp_count = 1
            end
            local old_value = tech.unit.count
            tech.unit.count = tmp_count
            log(tech.name .. ".count: " .. old_value .. " ---> " .. tech.unit.count)
        elseif tech.unit.count_formula then
            local old_value = tech.unit.count_formula
            tech.unit.count_formula = "(" .. tech.unit.count_formula .. ")*" .. tostring(mul)
            log(tech.name .. ".count_formula: " .. old_value .. " ---> " .. tech.unit.count_formula)
        end

        if tech.unit.time then
            local tmp_time = tech.unit.time * mul
            if tmp_time < 1 then
                tmp_time = 1
            end
            local old_value = tech.unit.time
            tech.unit.time = tmp_time
            log(tech.name .. ".time: " .. old_value .. " ---> " .. tech.unit.time)
        end
    end
end

-- space-exploration
local data_raw_technology_se_spaceship_catalog = {
    technology = {
        mod = {
            "se-spaceship", -- 飞船
            "se-spaceship-integrity-1", -- 结构强度1
            "se-spaceship-integrity-2", -- 结构强度2
            "se-spaceship-integrity-3", -- 结构强度3
            -- "se-factory-spaceship-1", -- 工厂飞船1
        },
        modify_parameter = { -- 修改参数
            {
                path = { "unit", "ingredients" },
                value = {
                    {
                        "automation-science-pack",
                        1
                    },
                    {
                        "logistic-science-pack",
                        1
                    },
                    {
                        "chemical-science-pack",
                        1
                    }
                }
            },
            {
                path = { "prerequisites" },
                value = "nil"
            }
        }
    }
}

-- Krastorio2
local data_raw_technology_kr_enriched_ores_catalog = {
    technology = {
        mod = {
            "kr-enriched-ores", -- 富化矿石
        },
        modify_parameter = { -- 修改参数
            {
                path = { "effects" },
                value = "nil"
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------Technology start------------------\n\n\n")

if settings.startup["x-custom-game-infinite-technology-flags"].value then
    modify_infinite_technology_cost_formula()
end

if settings.startup["x-custom-game-technology-cost-multiplier"].value ~= 1 and
    settings.startup["x-custom-game-technology-cost-multiplier"].value ~= 0 then
    modify_technology_cost()
end

if settings.startup["x-custom-game-author-custom-balance-flags"].value then
    -- space-exploration
    if mods["space-exploration"] then
        common_data_raw:execute_modify(data_raw_technology_se_spaceship_catalog)
    end

    -- Krastorio2
    if mods["Krastorio2"] then
        common_data_raw:execute_modify(data_raw_technology_kr_enriched_ores_catalog)
    end
end

log("\n\n\n------------------Technology end------------------\n\n\n")
