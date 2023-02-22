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
                        probability = 0.01
                    },
                    {
                        amount = 1,
                        name = "uranium-238",
                        probability = 0.99
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
                value = { { "uranium-235", 42 } }
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
                        amount = 200,
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

-- 插件1
local data_raw_recipe_speed_productivity_effectivity_module_1_catalog = {
    recipe = {
        orig = {
            "speed-module",
            "productivity-module",
            "effectivity-module"
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        "advanced-circuit",
                        1
                    },
                    {
                        "electronic-circuit",
                        1
                    }
                }
            }
        }
    }
}

-- 插件2
local data_raw_recipe_speed_productivity_effectivity_module_2_catalog = {
    recipe = {
        orig = {
            "speed-module-2",
            "productivity-module-2",
            "effectivity-module-2"
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        "advanced-circuit",
                        2
                    },
                    {
                        "electronic-circuit",
                        2
                    }
                }
            }
        }
    }
}

-- 插件3
local data_raw_recipe_speed_productivity_effectivity_module_3_catalog = {
    recipe = {
        orig = {
            "speed-module-3",
            "productivity-module-3",
            "effectivity-module-3"
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        "advanced-circuit",
                        3
                    },
                    {
                        "electronic-circuit",
                        3
                    }
                }
            }
        }
    }
}

-- 插件4
local data_raw_recipe_speed_productivity_effectivity_module_4_catalog = {
    recipe = {
        orig = {
            "speed-module-4",
            "productivity-module-4",
            "effectivity-module-4"
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        "advanced-circuit",
                        4
                    },
                    {
                        "electronic-circuit",
                        4
                    }
                }
            }
        }
    }
}

-- 插件5
local data_raw_recipe_speed_productivity_effectivity_module_5_catalog = {
    recipe = {
        orig = {
            "speed-module-5",
            "productivity-module-5",
            "effectivity-module-5"
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        "advanced-circuit",
                        5
                    },
                    {
                        "electronic-circuit",
                        5
                    },
                    {
                        "processing-unit",
                        1
                    }
                }
            }
        }
    }
}

-- 插件6
local data_raw_recipe_speed_productivity_effectivity_module_6_catalog = {
    recipe = {
        orig = {
            "speed-module-6",
            "productivity-module-6",
            "effectivity-module-6"
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        "advanced-circuit",
                        6
                    },
                    {
                        "electronic-circuit",
                        6
                    },
                    {
                        "processing-unit",
                        2
                    }
                }
            }
        }
    }
}

-- 插件7
local data_raw_recipe_speed_productivity_effectivity_module_7_catalog = {
    recipe = {
        orig = {
            "speed-module-7",
            "productivity-module-7",
            "effectivity-module-7"
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        "advanced-circuit",
                        7
                    },
                    {
                        "electronic-circuit",
                        7
                    },
                    {
                        "processing-unit",
                        3
                    }
                }
            }
        }
    }
}

-- 插件8
local data_raw_recipe_speed_productivity_effectivity_module_8_catalog = {
    recipe = {
        orig = {
            "speed-module-8",
            "productivity-module-8",
            "effectivity-module-8"
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        "advanced-circuit",
                        8
                    },
                    {
                        "electronic-circuit",
                        8
                    },
                    {
                        "processing-unit",
                        4
                    }
                }
            }
        }
    }
}

-- 插件9
local data_raw_recipe_speed_productivity_effectivity_module_9_catalog = {
    recipe = {
        orig = {
            "speed-module-9",
            "productivity-module-9",
            "effectivity-module-9"
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        "advanced-circuit",
                        9
                    },
                    {
                        "electronic-circuit",
                        9
                    },
                    {
                        "processing-unit",
                        4
                    }
                }
            }
        }
    }
}

-- ["advanced-solar"]
local data_raw_recipe_advanced_solar_catalog = {
    recipe = {
        mod = {
            "advanced-solar", -- Advanced-Electric-Revamped-v16
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = { { "steel-plate", 5 }, { "electronic-circuit", 5 }, { "solar-panel", 101 } }
            }
        }
    }
}

-- ["elite-solar"]
local data_raw_recipe_elite_solar_catalog = {
    recipe = {
        mod = {
            "elite-solar", -- Advanced-Electric-Revamped-v16
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = { { "steel-plate", 10 }, { "advanced-circuit", 10 }, { "advanced-solar", 101 } }
            }
        }
    }
}

-- ["ultimate-solar"]
local data_raw_recipe_ultimate_solar_catalog = {
    recipe = {
        mod = {
            "ultimate-solar", -- Advanced-Electric-Revamped-v16
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = { { "steel-plate", 20 }, { "processing-unit", 20 }, { "elite-solar", 101 } }
            }
        }
    }
}

-- ["advanced-accumulator"]
local data_raw_recipe_advanced_accumulator_catalog = {
    recipe = {
        mod = {
            "advanced-accumulator", -- Advanced-Electric-Revamped-v16
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = { { "accumulator", 101 }, { "iron-plate", 5 }, { "electronic-circuit", 5 } }
            }
        }
    }
}

-- ["elite-accumulator"]
local data_raw_recipe_elite_accumulator_catalog = {
    recipe = {
        mod = {
            "elite-accumulator", -- Advanced-Electric-Revamped-v16
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = { { "advanced-accumulator", 101 }, { "iron-plate", 10 }, { "advanced-circuit", 10 } }
            }
        }
    }
}

-- ["ultimate-accumulator"]
local data_raw_recipe_ultimate_accumulator_catalog = {
    recipe = {
        mod = {
            "ultimate-accumulator", -- Advanced-Electric-Revamped-v16
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = { { "elite-accumulator", 101 }, { "steel-plate", 20 }, { "battery", 20 }, { "processing-unit", 5 } }
            }
        }
    }
}

-- ["imersium-plate"]
local data_raw_recipe_imersium_plate_catalog = {
    recipe = {
        mod = {
            "imersium-plate", -- Krastorio2
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        amount = 32,
                        name = "se-kr-fine-imersite-powder",
                        type = "item"
                    }
                }
            },
            {
                path = { "results" }, -- 产出
                value = {
                    {
                        amount = 8,
                        name = "imersium-plate",
                        type = "item"
                    }
                }
            }
        }
    }
}

-- ["imersite-crystal"]
local data_raw_recipe_imersite_crystal_catalog = {
    recipe = {
        mod = {
            "imersite-crystal", -- Krastorio2
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        amount = 40,
                        name = "se-kr-imersium-sulfide",
                        type = "fluid"
                    },
                    {
                        amount = 8,
                        name = "se-kr-fine-imersite-powder",
                        type = "item"
                    }
                }
            },
            {
                path = { "results" }, -- 产出
                value = {
                    {
                        amount = 12,
                        name = "imersite-crystal",
                        type = "item"
                    }
                }
            }
        }
    }
}

-- ["se-cargo-rocket-section"]
local data_raw_recipe_se_cargo_rocket_section_catalog = {
    recipe = {
        mod = {
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

-- ["se-delivery-cannon-capsule"]
local data_raw_recipe_se_delivery_cannon_capsule_catalog = {
    recipe = {
        mod = {
            "se-delivery-cannon-capsule", -- space-exploration
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        "low-density-structure",
                        1
                    },
                    {
                        "se-heat-shielding",
                        1
                    },
                    {
                        "copper-cable",
                        5
                    }
                }
            }
        }
    }
}

-- ["se-kr-fine-imersite-powder"]
local data_raw_recipe_se_kr_fine_imersite_powder_catalog = {
    recipe = {
        mod = {
            "se-kr-fine-imersite-powder", -- space-exploration
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        amount = 16,
                        name = "se-kr-imersium-sulfide",
                        type = "fluid"
                    }
                }
            },
            {
                path = { "results" }, -- 产出
                value = {
                    {
                        amount = 16,
                        name = "se-kr-fine-imersite-powder"
                    }
                }
            }
        }
    }
}

-- ["se-iron-ingot"]
local data_raw_recipe_se_iron_ingot_catalog = {
    recipe = {
        mod = {
            "se-iron-ingot", -- space-exploration
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        amount = 5,
                        name = "iron-plate",
                        type = "item"
                    }
                }
            },
            {
                path = { "results" }, -- 产出
                value = {
                    {
                        amount = 1,
                        name = "se-iron-ingot"
                    }
                }
            }
        }
    }
}

-- ["se-steel-ingot"]
local data_raw_recipe_se_steel_ingot_catalog = {
    recipe = {
        mod = {
            "se-steel-ingot", -- space-exploration
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        amount = 5,
                        name = "steel-plate",
                        type = "item"
                    }
                }
            },
            {
                path = { "results" }, -- 产出
                value = {
                    {
                        amount = 1,
                        name = "se-steel-ingot"
                    }
                }
            }
        }
    }
}

-- ["se-copper-ingot"]
local data_raw_recipe_se_copper_ingot_catalog = {
    recipe = {
        mod = {
            "se-copper-ingot", -- space-exploration
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        amount = 5,
                        name = "copper-plate",
                        type = "item"
                    }
                }
            },
            {
                path = { "results" }, -- 产出
                value = {
                    {
                        amount = 1,
                        name = "se-copper-ingot"
                    }
                }
            }
        }
    }
}

-- ["se-plasma-stream"]
local data_raw_recipe_se_plasma_stream_catalog = {
    recipe = {
        mod = {
            "se-plasma-stream", -- space-exploration
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        amount = 100,
                        name = "water",
                        type = "fluid"
                    },
                    {
                        amount = 2,
                        name = "lithium",
                        type = "item"
                    }
                }
            },
            {
                path = { "results" }, -- 产出
                value = {
                    {
                        amount = 100,
                        name = "se-plasma-stream",
                        type = "fluid"
                    }
                }
            }
        }
    }
}

-- ["space-science-pack"]
local data_raw_recipe_space_science_pack_catalog = {
    recipe = {
        mod = {
            "space-science-pack", -- space-exploration
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        "se-space-transport-belt",
                        2
                    },
                    {
                        "processing-unit",
                        1
                    }
                }
            },
            {
                path = { "normal", "ingredients" }, -- 成分
                value = {
                    {
                        "se-space-transport-belt",
                        2
                    },
                    {
                        "processing-unit",
                        1
                    }
                }
            },
            {
                path = { "expensive", "ingredients" }, -- 成分
                value = {
                    {
                        "se-space-transport-belt",
                        2
                    },
                    {
                        "processing-unit",
                        1
                    }
                }
            },
            {
                path = { "results" }, -- 产出
                value = {
                    {
                        "space-science-pack",
                        10
                    }
                }
            },
            {
                path = { "normal", "results" }, -- 产出
                value = {
                    {
                        "space-science-pack",
                        10
                    }
                }
            },
            {
                path = { "expensive", "results" }, -- 产出
                value = {
                    {
                        "space-science-pack",
                        10
                    }
                }
            }
        }
    }
}

-- ["production-science-pack"]
local data_raw_recipe_production_science_pack_catalog = {
    recipe = {
        mod = {
            "production-science-pack", -- space-exploration
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        amount = 2,
                        name = "uranium-238"
                    },
                    {
                        amount = 4,
                        name = "se-vulcanite-block"
                    },
                    {
                        amount = 8,
                        name = "se-iron-ingot"
                    },
                    {
                        amount = 100,
                        name = "se-plasma-stream",
                        type = "fluid"
                    }
                }
            },
            {
                path = { "results" }, -- 产出
                value = {
                    {
                        "production-science-pack",
                        6
                    }
                }
            }
        }
    }
}

-- ["utility-science-pack"]
local data_raw_recipe_utility_science_pack_catalog = {
    recipe = {
        mod = {
            "utility-science-pack", -- space-exploration
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        amount = 1,
                        name = "se-space-transport-belt"
                    },
                    {
                        amount = 1,
                        name = "processing-unit"
                    },
                    {
                        amount = 6,
                        name = "se-cryonite-rod"
                    },
                    {
                        amount = 20,
                        name = "se-space-coolant-warm",
                        type = "fluid"
                    }
                }
            },
            {
                path = { "results" }, -- 产出
                value = {
                    {
                        "utility-science-pack",
                        8
                    }
                }
            }
        }
    }
}

-- ["space-research-data"]
local data_raw_recipe_space_research_data_catalog = {
    recipe = {
        mod = {
            "space-research-data", -- space-exploration
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        amount = 2,
                        name = "imersite-crystal"
                    },
                    {
                        amount = 3,
                        name = "imersium-plate"
                    },
                    {
                        amount = 100,
                        name = "lubricant",
                        type = "fluid"
                    }
                }
            },
            {
                path = { "normal", "ingredients" }, -- 成分
                value = {
                    {
                        amount = 2,
                        name = "imersite-crystal"
                    },
                    {
                        amount = 3,
                        name = "imersium-plate"
                    },
                    {
                        amount = 100,
                        name = "lubricant",
                        type = "fluid"
                    }
                }
            },
            {
                path = { "expensive", "ingredients" }, -- 成分
                value = {
                    {
                        amount = 2,
                        name = "imersite-crystal"
                    },
                    {
                        amount = 3,
                        name = "imersium-plate"
                    },
                    {
                        amount = 100,
                        name = "lubricant",
                        type = "fluid"
                    }
                }
            },
            {
                path = { "results" }, -- 产出
                value = {
                    {
                        "space-research-data",
                        10
                    }
                }
            },
            {
                path = { "normal", "results" }, -- 产出
                value = {
                    {
                        "space-research-data",
                        10
                    }
                }
            },
            {
                path = { "expensive", "results" }, -- 产出
                value = {
                    {
                        "space-research-data",
                        10
                    }
                }
            }

        }
    }
}

-- ["se-vulcanite-crushed"]
local data_raw_recipe_se_vulcanite_crushed_catalog = {
    recipe = {
        mod = {
            "se-vulcanite-crushed", -- space-exploration
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        amount = 3,
                        name = "se-vulcanite"
                    }
                }
            },
            {
                path = { "results" }, -- 产出
                value = {
                    {
                        amount = 6,
                        name = "se-vulcanite-crushed"
                    }
                }
            }

        }
    }
}

-- ["se-vulcanite-block"]
local data_raw_recipe_se_vulcanite_block_catalog = {
    recipe = {
        mod = {
            "se-vulcanite-block", -- space-exploration
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        amount = 10,
                        name = "se-pyroflux",
                        type = "fluid"
                    }
                }
            },
            {
                path = { "results" }, -- 产出
                value = {
                    {
                        amount = 5,
                        name = "se-vulcanite-block"
                    }
                }
            }

        }
    }
}

-- ["se-pyroflux"]
local data_raw_recipe_se_pyroflux_catalog = {
    recipe = {
        mod = {
            "se-pyroflux", -- space-exploration
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        amount = 10,
                        name = "se-vulcanite-crushed"
                    }
                }
            },
            {
                path = { "results" }, -- 产出
                value = {
                    {
                        amount = 20,
                        name = "se-pyroflux",
                        type = "fluid"
                    }
                }
            }

        }
    }
}

-- ["se-vulcanite-ion-exchange-beads"]
local data_raw_recipe_se_vulcanite_ion_exchange_beads_catalog = {
    recipe = {
        mod = {
            "se-vulcanite-ion-exchange-beads", -- space-exploration
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        amount = 1,
                        name = "se-vulcanite-block"
                    },
                    {
                        amount = 1,
                        name = "plastic-bar"
                    }
                }
            },
            {
                path = { "results" }, -- 产出
                value = {
                    {
                        amount = 10,
                        name = "se-vulcanite-ion-exchange-beads"
                    }
                }
            }

        }
    }
}

-- ["se-space-coolant"]
local data_raw_recipe_se_space_coolant_catalog = {
    recipe = {
        mod = {
            "se-space-coolant", -- space-exploration
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        amount = 10,
                        name = "heavy-oil",
                        type = "fluid"
                    },
                    {
                        amount = 1,
                        name = "copper-plate"
                    },
                    {
                        amount = 1,
                        name = "iron-plate"
                    },
                    {
                        amount = 1,
                        name = "sulfur"
                    }
                }
            },
            {
                path = { "results" }, -- 产出
                value = {
                    {
                        amount = 10,
                        name = "se-space-coolant-hot",
                        type = "fluid"
                    }
                }
            }

        }
    }
}

-- ["se-cryonite-rod"]
local data_raw_recipe_se_cryonite_rod_catalog = {
    recipe = {
        mod = {
            "se-cryonite-rod", -- space-exploration
        },
        modify_parameter = { -- 修改参数
            {
                path = { "ingredients" }, -- 成分
                value = {
                    {
                        amount = 2,
                        name = "se-cryonite-powder"
                    }
                }
            },
            {
                path = { "results" }, -- 产出
                value = {
                    {
                        amount = 1,
                        name = "se-cryonite-rod"
                    }
                }
            }

        }
    }
}


-- 开始修改
log("\n\n\n------------------配方 start------------------\n\n\n")

if settings.startup["x-custom-game-author-custom-recipe-balance-flags"].value then
    -- 原始游戏配方修改
    common_data_raw:execute_modify(data_raw_recipe_uranium_processing_catalog)
    common_data_raw:execute_modify(data_raw_recipe_kovarex_enrichment_process_catalog)
    common_data_raw:execute_modify(data_raw_recipe_landfill_catalog)
    common_data_raw:execute_modify(data_raw_recipe_basic_oil_processing_catalog)
    common_data_raw:execute_modify(data_raw_recipe_advanced_oil_processing_catalog)
    common_data_raw:execute_modify(data_raw_recipe_splitter_catalog)
    common_data_raw:execute_modify(data_raw_recipe_speed_productivity_effectivity_module_1_catalog)
    common_data_raw:execute_modify(data_raw_recipe_speed_productivity_effectivity_module_2_catalog)
    common_data_raw:execute_modify(data_raw_recipe_speed_productivity_effectivity_module_3_catalog)

    if mods["space-exploration"] then
        -- 删除产出中的废料
        local moddify_list = common_data_raw:recipe_delete_by_name("results", "se-scrap")
        log("recipe_delete_by_name.results [se-scrap]:\n" .. common_core:serpent_block(moddify_list))
        -- 删除产出中的垃圾数据卡
        moddify_list = common_data_raw:recipe_delete_by_name("results", "se-junk-data")
        log("recipe_delete_by_name.results [se-junk-data]:\n" .. common_core:serpent_block(moddify_list))
        -- 删除产出中的25°的冷却导热液
        moddify_list = common_data_raw:recipe_delete_by_name("results", "se-space-coolant-hot")
        log("recipe_delete_by_name.results [se-space-coolant-hot]:\n" .. common_core:serpent_block(moddify_list))
        -- 删除产出中的沙子
        moddify_list = common_data_raw:recipe_delete_by_name("results", "sand")
        log("recipe_delete_by_name.results [sand]:\n" .. common_core:serpent_block(moddify_list))
        common_data_raw:execute_modify(data_raw_recipe_se_cargo_rocket_section_catalog)
        common_data_raw:execute_modify(data_raw_recipe_se_delivery_cannon_capsule_catalog)
        common_data_raw:execute_modify(data_raw_recipe_se_kr_fine_imersite_powder_catalog)
        common_data_raw:execute_modify(data_raw_recipe_se_iron_ingot_catalog)
        common_data_raw:execute_modify(data_raw_recipe_se_steel_ingot_catalog)
        common_data_raw:execute_modify(data_raw_recipe_se_copper_ingot_catalog)
        common_data_raw:execute_modify(data_raw_recipe_se_plasma_stream_catalog)
        common_data_raw:execute_modify(data_raw_recipe_space_science_pack_catalog)
        common_data_raw:execute_modify(data_raw_recipe_production_science_pack_catalog)
        common_data_raw:execute_modify(data_raw_recipe_utility_science_pack_catalog)
        common_data_raw:execute_modify(data_raw_recipe_space_research_data_catalog)
        common_data_raw:execute_modify(data_raw_recipe_se_vulcanite_crushed_catalog)
        common_data_raw:execute_modify(data_raw_recipe_se_vulcanite_block_catalog)
        common_data_raw:execute_modify(data_raw_recipe_se_pyroflux_catalog)
        common_data_raw:execute_modify(data_raw_recipe_se_vulcanite_ion_exchange_beads_catalog)
        common_data_raw:execute_modify(data_raw_recipe_se_space_coolant_catalog)
        common_data_raw:execute_modify(data_raw_recipe_se_cryonite_rod_catalog)
        common_data_raw:execute_modify(data_raw_recipe_speed_productivity_effectivity_module_4_catalog)
        common_data_raw:execute_modify(data_raw_recipe_speed_productivity_effectivity_module_5_catalog)
        common_data_raw:execute_modify(data_raw_recipe_speed_productivity_effectivity_module_6_catalog)
        common_data_raw:execute_modify(data_raw_recipe_speed_productivity_effectivity_module_7_catalog)
        common_data_raw:execute_modify(data_raw_recipe_speed_productivity_effectivity_module_8_catalog)
        common_data_raw:execute_modify(data_raw_recipe_speed_productivity_effectivity_module_9_catalog)
    end

    if mods["Krastorio2"] then
        common_data_raw:execute_modify(data_raw_recipe_imersium_plate_catalog)
        common_data_raw:execute_modify(data_raw_recipe_imersite_crystal_catalog)
    end

    if mods["Advanced-Electric-Revamped-v16"] then
        common_data_raw:execute_modify(data_raw_recipe_advanced_accumulator_catalog)
        common_data_raw:execute_modify(data_raw_recipe_elite_accumulator_catalog)
        common_data_raw:execute_modify(data_raw_recipe_ultimate_accumulator_catalog)
        common_data_raw:execute_modify(data_raw_recipe_advanced_solar_catalog)
        common_data_raw:execute_modify(data_raw_recipe_elite_solar_catalog)
        common_data_raw:execute_modify(data_raw_recipe_ultimate_solar_catalog)
    end
end


log("\n\n\n------------------配方 end------------------\n\n\n")
