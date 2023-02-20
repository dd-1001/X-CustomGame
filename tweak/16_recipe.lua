local common_core = require("common/core")
local common_data_raw = require("common/data_raw")

local log = common_core.Log

-- 铀浓缩处理
local data_raw_recipe_uranium_processing_catalog = {
    recipe = {
        orig = {
            "uranium-processing", -- 铀浓缩处理
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = { { "uranium-ore", 10 } }
            },
            {
                path = { "results" }, -- 产出
                value = {
                    {
                        amount = 1,
                        name = "uranium-235",
                        probability = 0.008
                    },
                    {
                        amount = 1,
                        name = "uranium-238",
                        probability = 0.992
                    }
                }
            }
        }
    }
}

-- 铀增值处理
local data_raw_recipe_kovarex_enrichment_process_catalog = {
    recipe = {
        orig = {
            "kovarex-enrichment-process", -- 铀增值处理
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = { { "uranium-235", 40 }, { "uranium-238", 5 } }
            },
            {
                path = { "results" }, -- 产出
                value = { { "uranium-235", 41 }, { "uranium-238", 2 } }
            }
        }
    }
}

-- 填海料
local data_raw_recipe_landfill_catalog = {
    recipe = {
        orig = {
            "landfill", -- 填海料
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = { { "stone", 20 } }
            }
        }
    }
}

-- 石油气
local data_raw_recipe_basic_oil_processing_catalog = {
    recipe = {
        orig = {
            "basic-oil-processing", -- 石油气
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        amount = 50,
                        name = "water",
                        type = "fluid"
                    },
                    {
                        amount = 100,
                        name = "crude-oil",
                        type = "fluid"
                    }
                }
            },
            {
                path = { "normal", "ingredients" }, -- 成分
                value = {
                    {
                        amount = 50,
                        name = "water",
                        type = "fluid"
                    },
                    {
                        amount = 100,
                        name = "crude-oil",
                        type = "fluid"
                    }
                }
            },
            {
                path = { "expensive", "ingredients" }, -- 成分
                value = {
                    {
                        amount = 50,
                        name = "water",
                        type = "fluid"
                    },
                    {
                        amount = 100,
                        name = "crude-oil",
                        type = "fluid"
                    }
                }
            },
            {
                path = { "results" }, -- 产出
                value = {
                    {
                        amount = 90,
                        name = "petroleum-gas",
                        type = "fluid"
                    }
                }
            },
            {
                path = { "normal", "results" }, -- 产出
                value = {
                    {
                        amount = 90,
                        name = "petroleum-gas",
                        type = "fluid"
                    }
                }
            },
            {
                path = { "expensive", "results" }, -- 产出
                value = {
                    {
                        amount = 90,
                        name = "petroleum-gas",
                        type = "fluid"
                    }
                }
            }

        }
    }
}

-- 高等原油处理
local data_raw_recipe_advanced_oil_processing_catalog = {
    recipe = {
        orig = {
            "advanced-oil-processing", -- 高等原油处理
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        amount = 50,
                        name = "water",
                        type = "fluid"
                    },
                    {
                        amount = 100,
                        name = "crude-oil",
                        type = "fluid"
                    }
                }
            },
            {
                path = { "normal", "ingredients" }, -- 成分
                value = {
                    {
                        amount = 50,
                        name = "water",
                        type = "fluid"
                    },
                    {
                        amount = 100,
                        name = "crude-oil",
                        type = "fluid"
                    }
                }
            },
            {
                path = { "expensive", "ingredients" }, -- 成分
                value = {
                    {
                        amount = 50,
                        name = "water",
                        type = "fluid"
                    },
                    {
                        amount = 100,
                        name = "crude-oil",
                        type = "fluid"
                    }
                }
            },
            {
                path = { "results" }, -- 产出
                value = {
                    {
                        amount = 90,
                        name = "light-oil",
                        type = "fluid"
                    },
                    {
                        amount = 90,
                        name = "heavy-oil",
                        type = "fluid"
                    }
                }
            },
            {
                path = { "normal", "results" }, -- 产出
                value = {
                    {
                        amount = 90,
                        name = "light-oil",
                        type = "fluid"
                    },
                    {
                        amount = 90,
                        name = "heavy-oil",
                        type = "fluid"
                    }
                }
            },
            {
                path = { "expensive", "results" }, -- 产出
                value = {
                    {
                        amount = 90,
                        name = "light-oil",
                        type = "fluid"
                    },
                    {
                        amount = 90,
                        name = "heavy-oil",
                        type = "fluid"
                    }
                }
            }
        }
    }
}

-- 基础分流器
local data_raw_recipe_splitter_catalog = {
    recipe = {
        orig = {
            "splitter",
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        "electronic-circuit",
                        1
                    },
                    {
                        "iron-plate",
                        2
                    },
                    {
                        "transport-belt",
                        2
                    }
                }
            },
            {
                path = { "normal", "ingredients" }, -- 成分
                value = {
                    {
                        "electronic-circuit",
                        1
                    },
                    {
                        "iron-plate",
                        2
                    },
                    {
                        "transport-belt",
                        2
                    }
                }
            },
            {
                path = { "expensive", "ingredients" }, -- 成分
                value = {
                    {
                        "electronic-circuit",
                        1
                    },
                    {
                        "iron-plate",
                        2
                    },
                    {
                        "transport-belt",
                        2
                    }
                }
            },
            {
                path = { "results" }, -- 产出
                value = {
                    {
                        amount = 1,
                        name = "splitter",
                        type = "item"
                    }
                }
            },
            {
                path = { "normal", "results" }, -- 产出
                value = {
                    {
                        amount = 1,
                        name = "splitter",
                        type = "item"
                    }
                }
            },
            {
                path = { "expensive", "results" }, -- 产出
                value = {
                    {
                        amount = 1,
                        name = "splitter",
                        type = "item"
                    }
                }
            }
        }
    }
}

-- ["advanced-solar"]
local data_raw_recipe_advanced_solar_catalog = {
    recipe = {
        orig = {
            "advanced-solar", -- Advanced-Electric-Revamped-v16
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = { { "steel-plate", 5 }, { "electronic-circuit", 5 }, { "solar-panel", 101 } }
            },
            {
                path = { "results" }, -- 产出
                value = { { "advanced-solar", 2 } }
            }
        }
    }
}

-- ["elite-solar"]
local data_raw_recipe_elite_solar_catalog = {
    recipe = {
        orig = {
            "elite-solar", -- Advanced-Electric-Revamped-v16
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = { { "steel-plate", 10 }, { "advanced-circuit", 10 }, { "advanced-solar", 101 } }
            },
            {
                path = { "results" }, -- 产出
                value = { { "elite-solar", 2 } }
            }
        }
    }
}

-- ["ultimate-solar"]
local data_raw_recipe_ultimate_solar_catalog = {
    recipe = {
        orig = {
            "ultimate-solar", -- Advanced-Electric-Revamped-v16
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = { { "steel-plate", 20 }, { "processing-unit", 20 }, { "elite-solar", 101 } }
            },
            {
                path = { "results" }, -- 产出
                value = { { "ultimate-solar", 2 } }
            }
        }
    }
}

-- ["advanced-accumulator"]
local data_raw_recipe_advanced_accumulator_catalog = {
    recipe = {
        orig = {
            "advanced-accumulator", -- Advanced-Electric-Revamped-v16
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = { { "accumulator", 101 }, { "iron-plate", 5 }, { "electronic-circuit", 5 } }
            },
            {
                path = { "results" }, -- 产出
                value = { { "advanced-accumulator", 2 } }
            }
        }
    }
}

-- ["elite-accumulator"]
local data_raw_recipe_elite_accumulator_catalog = {
    recipe = {
        orig = {
            "elite-accumulator", -- Advanced-Electric-Revamped-v16
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = { { "advanced-accumulator", 101 }, { "iron-plate", 10 }, { "advanced-circuit", 10 } }
            },
            {
                path = { "results" }, -- 产出
                value = { { "elite-accumulator", 2 } }
            }
        }
    }
}

-- ["ultimate-accumulator"]
local data_raw_recipe_ultimate_accumulator_catalog = {
    recipe = {
        orig = {
            "ultimate-accumulator", -- Advanced-Electric-Revamped-v16
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = { { "elite-accumulator", 101 }, { "steel-plate", 20 }, { "battery", 20 }, { "processing-unit", 5 } }
            },
            {
                path = { "results" }, -- 产出
                value = { { "ultimate-accumulator", 2 } }
            }
        }
    }
}

-- ["imersite-powder"]
local data_raw_recipe_imersite_powder_catalog = {
    recipe = {
        orig = {
            "imersite-powder", -- Krastorio2
        },
        modify_parameter = { -- 修改参数
            {
                path = { "results" }, -- 产出
                value = { { "imersite-powder", 3 } }
            }
        }
    }
}

-- ["se-cargo-rocket-section"]
local data_raw_recipe_se_cargo_rocket_section_catalog = {
    recipe = {
        orig = {
            "se-cargo-rocket-section", -- space-exploration
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        "se-heat-shielding",
                        4
                    },
                    {
                        "low-density-structure",
                        4
                    },
                    {
                        "rocket-control-unit",
                        4
                    }
                }
            }
        }
    }
}

-- 开始修改
log("\n\n\n------------------配方 start------------------\n\n\n")

if settings.startup["x-custom-game-author-custom-recipe-balance-flags"].value then
    if mods["space-exploration"] then
        common_data_raw:execute_modify(data_raw_recipe_se_cargo_rocket_section_catalog)
        -- 删除产出中的废料
        local moddify_list = common_data_raw:recipe_delete_results_by_name("se-scrap")
        log("recipe_delete_results_by_name [se-scrap]:\n" .. common_core:serpent_block(moddify_list))
    end

    if mods["Krastorio2"] then
        common_data_raw:execute_modify(data_raw_recipe_imersite_powder_catalog)
    end

    if mods["Advanced-Electric-Revamped-v16"] then
        common_data_raw:execute_modify(data_raw_recipe_advanced_accumulator_catalog)
        common_data_raw:execute_modify(data_raw_recipe_elite_accumulator_catalog)
        common_data_raw:execute_modify(data_raw_recipe_ultimate_accumulator_catalog)
        common_data_raw:execute_modify(data_raw_recipe_advanced_solar_catalog)
        common_data_raw:execute_modify(data_raw_recipe_elite_solar_catalog)
        common_data_raw:execute_modify(data_raw_recipe_ultimate_solar_catalog)
    end

    common_data_raw:execute_modify(data_raw_recipe_uranium_processing_catalog)
    common_data_raw:execute_modify(data_raw_recipe_kovarex_enrichment_process_catalog)
    common_data_raw:execute_modify(data_raw_recipe_landfill_catalog)
    common_data_raw:execute_modify(data_raw_recipe_basic_oil_processing_catalog)
    common_data_raw:execute_modify(data_raw_recipe_advanced_oil_processing_catalog)
    common_data_raw:execute_modify(data_raw_recipe_splitter_catalog)
end


log("\n\n\n------------------配方 end------------------\n\n\n")
