local x_database = {}

-- 游戏开局物品
x_database.game_start_bonus_items = {
	{ name = "power-armor",                 count = 1 }, --能量装甲
	{ name = "solar-panel-equipment",       count = 5 }, --太阳能模块
	{ name = "battery-equipment",           count = 2 }, --电池组模块
	{ name = "belt-immunity-equipment",     count = 1 }, --锚定模块
	{ name = "exoskeleton-equipment",       count = 1 }, --外骨骼模块
	{ name = "personal-roboport-equipment", count = 1 }, --机器人指令模块
	{ name = "night-vision-equipment",      count = 1 }, --夜视模块
	{ name = "energy-shield-equipment",     count = 1 }, --能量盾模块
	{ name = "roboport",                    count = 10 }, --机器人指令平台
	{ name = "logistic-robot",              count = 100 }, --物流机器人
	{ name = "construction-robot",          count = 50 }, --建设机器人
	{ name = "offshore-pump",               count = 10 }, --抽取机
	{ name = "boiler",                      count = 10 }, --锅炉
	{ name = "steam-engine",                count = 10 }, --蒸汽机
	{ name = "pipe",                        count = 1000 }, --管道
	{ name = "pipe-to-ground",              count = 1000 }, --地下管道
	{ name = "solar-panel",                 count = 10 }, --太阳能板
	{ name = "accumulator",                 count = 10 }, --蓄电器
	{ name = "small-electric-pole",         count = 10 }, --小型电线杆
	{ name = "transport-belt",              count = 1000 }, --基础传送带
	{ name = "underground-belt",            count = 1000 }, --基础地下传送带
	{ name = "splitter",                    count = 1000 }, --基础分流器
	{ name = "inserter",                    count = 100 }, --电力机械臂
	{ name = "electric-mining-drill",       count = 200 }, --电力采矿机
	{ name = "burner-mining-drill",         count = 10 }, --热能采矿机
	{ name = "stone-furnace",               count = 100 }, --石炉
	{ name = "iron-chest",                  count = 100 }, --铁箱
	{ name = "active-provider-chest",       count = 100 }, --主动供货箱（紫箱）
	{ name = "passive-provider-chest",      count = 100 }, --被动供货箱（红箱）
	{ name = "storage-chest",               count = 100 }, --被动存货箱（黄箱）
	{ name = "buffer-chest",                count = 100 }, --主动存货箱（绿箱）
	{ name = "requester-chest",             count = 100 }, --优先集货箱（蓝箱）
}

-- item最大生命值修改类型
x_database.modify_item_health_type = {
	["accumulator"] = true,
	["agricultural-tower"] = true,
	["ammo-turret"] = true,
	["arithmetic-combinator"] = true,
	["artillery-turret"] = true,
	["artillery-wagon"] = true,
	["assembling-machine"] = true,
	["asteroid"] = true,
	["asteroid-collector"] = true,
	["beacon"] = true,
	["boiler"] = true,
	["burner-generator"] = true,
	["capture-robot"] = true,
	["car"] = true,
	["cargo-bay"] = true,
	["cargo-landing-pad"] = true,
	["cargo-wagon"] = true,
	["character"] = true,
	["combat-robot"] = true,
	["constant-combinator"] = true,
	["construction-robot"] = true,
	["container"] = true,
	["curved-rail-a"] = true,
	["curved-rail-b"] = true,
	["decider-combinator"] = true,
	["display-panel"] = true,
	["electric-energy-interface"] = true,
	["electric-pole"] = true,
	["electric-turret"] = true,
	["elevated-curved-rail-a"] = true,
	["elevated-curved-rail-b"] = true,
	["elevated-half-diagonal-rail"] = true,
	["elevated-straight-rail"] = true,
	["fish"] = true,
	["fluid-turret"] = true,
	["fluid-wagon"] = true,
	["furnace"] = true,
	["fusion-generator"] = true,
	["fusion-reactor"] = true,
	["gate"] = true,
	["generator"] = true,
	["half-diagonal-rail"] = true,
	["heat-interface"] = true,
	["heat-pipe"] = true,
	["infinity-container"] = true,
	["infinity-pipe"] = true,
	["inserter"] = true,
	["lab"] = true,
	["lamp"] = true,
	["land-mine"] = true,
	["lane-splitter"] = true,
	["legacy-curved-rail"] = true,
	["legacy-straight-rail"] = true,
	["lightning-attractor"] = true,
	["linked-belt"] = true,
	["linked-container"] = true,
	["loader"] = true,
	["loader-1x1"] = true,
	["locomotive"] = true,
	["logistic-container"] = true,
	["logistic-robot"] = true,
	["market"] = true,
	["mining-drill"] = true,
	["offshore-pump"] = true,
	["pipe"] = true,
	["pipe-to-ground"] = true,
	["plant"] = true,
	["power-switch"] = true,
	["programmable-speaker"] = true,
	["pump"] = true,
	["radar"] = true,
	["rail-chain-signal"] = true,
	["rail-ramp"] = true,
	["rail-signal"] = true,
	["rail-support"] = true,
	["reactor"] = true,
	["roboport"] = true,
	["rocket-silo"] = true,
	["selector-combinator"] = true,
	["simple-entity"] = true,
	["simple-entity-with-force"] = true,
	["simple-entity-with-owner"] = true,
	["solar-panel"] = true,
	["space-platform-hub"] = true,
	["spider-leg"] = true,
	["spider-unit"] = true,
	["spider-vehicle"] = true,
	["splitter"] = true,
	["storage-tank"] = true,
	["straight-rail"] = true,
	["temporary-container"] = true,
	["thruster"] = true,
	["tile"] = true,
	["train-stop"] = true,
	["transport-belt"] = true,
	-- ["tree"] = true,
	["underground-belt"] = true,
	["wall"] = true
}

-- enemy最大生命值修改类型
x_database.modify_enemy_health_type = {
	["unit"] = true,        -- 虫子
	["unit-spawner"] = true, -- 虫巢
	["turret"] = true,      -- 沙虫
	["segment"] = true,     -- 撼地虫
	["segmented-unit"] = true, -- 撼地虫
}

-- 2.0.20版本 前修改过的类型
x_database.modified_type = {
	accumulator = true,
	["active-defense-equipment"] = true,
	["agricultural-tower"] = true,
	ammo = true,
	["ammo-turret"] = true,
	["arithmetic-combinator"] = true,
	armor = true,
	["artillery-projectile"] = true,
	["artillery-turret"] = true,
	["artillery-wagon"] = true,
	["assembling-machine"] = true,
	asteroid = true,
	["asteroid-collector"] = true,
	["battery-equipment"] = true,
	beacon = true,
	["belt-immunity-equipment"] = true,
	boiler = true,
	["burner-generator"] = true,
	capsule = true,
	["capture-robot"] = true,
	car = true,
	["cargo-bay"] = true,
	["cargo-landing-pad"] = true,
	["cargo-wagon"] = true,
	character = true,
	["combat-robot"] = true,
	["constant-combinator"] = true,
	["construction-robot"] = true,
	container = true,
	["curved-rail-a"] = true,
	["curved-rail-b"] = true,
	["decider-combinator"] = true,
	["display-panel"] = true,
	["electric-energy-interface"] = true,
	["electric-pole"] = true,
	["electric-turret"] = true,
	["elevated-curved-rail-a"] = true,
	["elevated-curved-rail-b"] = true,
	["elevated-half-diagonal-rail"] = true,
	["elevated-straight-rail"] = true,
	["energy-shield-equipment"] = true,
	["equipment-grid"] = true,
	fish = true,
	fluid = true,
	["fluid-turret"] = true,
	["fluid-wagon"] = true,
	furnace = true,
	["fusion-generator"] = true,
	["fusion-reactor"] = true,
	gate = true,
	generator = true,
	["generator-equipment"] = true,
	gun = true,
	["half-diagonal-rail"] = true,
	["heat-interface"] = true,
	["heat-pipe"] = true,
	["infinity-container"] = true,
	["infinity-pipe"] = true,
	inserter = true,
	["inventory-bonus-equipment"] = true,
	item = true,
	["item-with-entity-data"] = true,
	lab = true,
	lamp = true,
	["land-mine"] = true,
	["lane-splitter"] = true,
	["legacy-curved-rail"] = true,
	["legacy-straight-rail"] = true,
	["lightning-attractor"] = true,
	["linked-belt"] = true,
	["linked-container"] = true,
	loader = true,
	["loader-1x1"] = true,
	locomotive = true,
	["logistic-container"] = true,
	["logistic-robot"] = true,
	market = true,
	["mining-drill"] = true,
	module = true,
	["movement-bonus-equipment"] = true,
	["night-vision-equipment"] = true,
	["offshore-pump"] = true,
	pipe = true,
	["pipe-to-ground"] = true,
	plant = true,
	["power-switch"] = true,
	["programmable-speaker"] = true,
	projectile = true,
	pump = true,
	radar = true,
	["rail-chain-signal"] = true,
	["rail-planner"] = true,
	["rail-ramp"] = true,
	["rail-signal"] = true,
	["rail-support"] = true,
	reactor = true,
	["repair-tool"] = true,
	resource = true,
	roboport = true,
	["roboport-equipment"] = true,
	["rocket-silo"] = true,
	segment = true,
	["segmented-unit"] = true,
	["selector-combinator"] = true,
	["simple-entity"] = true,
	["simple-entity-with-force"] = true,
	["simple-entity-with-owner"] = true,
	["solar-panel"] = true,
	["solar-panel-equipment"] = true,
	["space-platform-hub"] = true,
	["space-platform-starter-pack"] = true,
	["spider-leg"] = true,
	["spider-unit"] = true,
	["spider-vehicle"] = true,
	splitter = true,
	["storage-tank"] = true,
	["straight-rail"] = true,
	technology = true,
	["temporary-container"] = true,
	thruster = true,
	tile = true,
	tool = true,
	["train-stop"] = true,
	["transport-belt"] = true,
	turret = true,
	["underground-belt"] = true,
	unit = true,
	["unit-spawner"] = true,
	wall = true
}

-- 2.0.20版本 未修改过的类型
x_database.unModified_type = {
	achievement = true,
	["airborne-pollutant"] = true,
	["ambient-sound"] = true,
	["ammo-category"] = true,
	arrow = true,
	["artillery-flare"] = true,
	["asteroid-chunk"] = true,
	["autoplace-control"] = true,
	beam = true,
	blueprint = true,
	["blueprint-book"] = true,
	["build-entity-achievement"] = true,
	["burner-usage"] = true,
	["cargo-pod"] = true,
	["chain-active-trigger"] = true,
	["change-surface-achievement"] = true,
	["character-corpse"] = true,
	cliff = true,
	["collision-layer"] = true,
	["combat-robot-count-achievement"] = true,
	["complete-objective-achievement"] = true,
	["construct-with-robots-achievement"] = true,
	["copy-paste-tool"] = true,
	corpse = true,
	["create-platform-achievement"] = true,
	["custom-input"] = true,
	["damage-type"] = true,
	["deconstruct-with-robots-achievement"] = true,
	["deconstructible-tile-proxy"] = true,
	["deconstruction-item"] = true,
	["delayed-active-trigger"] = true,
	["deliver-by-robots-achievement"] = true,
	["deliver-category"] = true,
	["deliver-impact-combination"] = true,
	["deplete-resource-achievement"] = true,
	["destroy-cliff-achievement"] = true,
	["dont-build-entity-achievement"] = true,
	["dont-craft-manually-achievement"] = true,
	["dont-kill-manually-achievement"] = true,
	["dont-research-before-researching-achievement"] = true,
	["dont-use-entity-in-energy-production-achievement"] = true,
	["editor-controller"] = true,
	["entity-ghost"] = true,
	["equip-armor-achievement"] = true,
	["equipment-category"] = true,
	["equipment-ghost"] = true,
	explosion = true,
	fire = true,
	font = true,
	["fuel-category"] = true,
	["god-controller"] = true,
	["group-attack-achievement"] = true,
	["gui-style"] = true,
	["highlight-box"] = true,
	["impact-category"] = true,
	["item-entity"] = true,
	["item-group"] = true,
	["item-request-proxy"] = true,
	["item-subgroup"] = true,
	["kill-achievement"] = true,
	lightning = true,
	["map-gen-presets"] = true,
	["map-settings"] = true,
	["module-category"] = true,
	["module-transfer-achievement"] = true,
	["mouse-cursor"] = true,
	["noise-expression"] = true,
	["noise-function"] = true,
	["optimized-decorative"] = true,
	["optimized-particle"] = true,
	["particle-source"] = true,
	["place-equipment-achievement"] = true,
	planet = true,
	["player-damaged-achievement"] = true,
	procession = true,
	["procession-layer-inheritance-group"] = true,
	["produce-achievement"] = true,
	["produce-per-hour-achievement"] = true,
	quality = true,
	["rail-remnants"] = true,
	recipe = true,
	["recipe-category"] = true,
	["remote-controller"] = true,
	["research-achievement"] = true,
	["research-with-science-pack-achievement"] = true,
	["resource-category"] = true,
	["rocket-silo-rocket"] = true,
	["rocket-silo-rocket-shadow"] = true,
	["selection-tool"] = true,
	["shoot-achievement"] = true,
	shortcut = true,
	["smoke-with-trigger"] = true,
	["space-connection"] = true,
	["space-connection-distance-traveled-achievement"] = true,
	["space-location"] = true,
	["spectator-controller"] = true,
	["speech-bubble"] = true,
	["spidertron-remote"] = true,
	sprite = true,
	sticker = true,
	stream = true,
	surface = true,
	["surface-property"] = true,
	["tile-effect"] = true,
	["tile-ghost"] = true,
	["tips-and-tricks-item"] = true,
	["tips-and-tricks-item-category"] = true,
	["train-path-achievement"] = true,
	tree = true,
	["trigger-target-type"] = true,
	["trivial-smoke"] = true,
	tutorial = true,
	["upgrade-item"] = true,
	["use-entity-in-energy-production-achievement"] = true,
	["use-item-achievement"] = true,
	["utility-constants"] = true,
	["utility-sounds"] = true,
	["utility-sprites"] = true,
	["virtual-signal"] = true
}

return x_database
