local x_database = {}

-- item最大生命值修改类型
x_database.modify_item_health_type = {
    "accumulator",
    "agricultural-tower",
    "ammo-turret",
    "arithmetic-combinator",
    "artillery-turret",
    "artillery-wagon",
    "assembling-machine",
    "asteroid",
    "asteroid-collector",
    "beacon",
    "boiler",
    "burner-generator",
    "capture-robot",
    "car",
    "cargo-bay",
    "cargo-landing-pad",
    "cargo-wagon",
    "character",
    "combat-robot",
    "constant-combinator",
    "construction-robot",
    "container",
    "curved-rail-a",
    "curved-rail-b",
    "decider-combinator",
    "display-panel",
    "electric-energy-interface",
    "electric-pole",
    "electric-turret",
    "elevated-curved-rail-a",
    "elevated-curved-rail-b",
    "elevated-half-diagonal-rail",
    "elevated-straight-rail",
    "fish",
    "fluid-turret",
    "fluid-wagon",
    "furnace",
    "fusion-generator",
    "fusion-reactor",
    "gate",
    "generator",
    "half-diagonal-rail",
    "heat-interface",
    "heat-pipe",
    "infinity-container",
    "infinity-pipe",
    "inserter",
    "lab",
    "lamp",
    "land-mine",
    "lane-splitter",
    "legacy-curved-rail",
    "legacy-straight-rail",
    "lightning-attractor",
    "linked-belt",
    "linked-container",
    "loader",
    "loader-1x1",
    "locomotive",
    "logistic-container",
    "logistic-robot",
    "market",
    "mining-drill",
    "offshore-pump",
    "pipe",
    "pipe-to-ground",
    "plant",
    "power-switch",
    "programmable-speaker",
    "pump",
    "radar",
    "rail-chain-signal",
    "rail-ramp",
    "rail-signal",
    "rail-support",
    "reactor",
    "roboport",
    "rocket-silo",
    "selector-combinator",
    "simple-entity",
    "simple-entity-with-force",
    "simple-entity-with-owner",
    "solar-panel",
    "space-platform-hub",
    "spider-leg",
    "spider-unit",
    "spider-vehicle",
    "splitter",
    "storage-tank",
    "straight-rail",
    "temporary-container",
    "thruster",
    "tile",
    "train-stop",
    "transport-belt",
    -- "tree",
    "underground-belt",
    "wall"
}

-- enemy最大生命值修改类型
x_database.modify_enemy_health_type = {
    "unit",           -- 虫子
    "unit-spawner",   -- 虫巢
    "turret",         -- 沙虫
    "segment",        -- 撼地虫
    "segmented-unit", -- 撼地虫
}

-- 游戏开局物品
x_database.game_start_bonus_items = {
    { name = "iron-chest",          count = 100 },  --铁箱
    { name = "fast-transport-belt", count = 1000 }, -- 高速传送带
    { name = "inserter",            count = 1000 }, -- 电力机械臂
    { name = "wooden-chest",        count = 10 },   -- 木箱
}

return x_database
