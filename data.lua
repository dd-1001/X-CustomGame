local set_author_custom_balance = settings.startup["x-custom-game-author-custom-balance-flag"].value

-- 暂时不启用
set_author_custom_balance = false
if not set_author_custom_balance then
    return
end

-- 以下的代码的效果：1. 把火箭组件独立出来；2. 修改火箭发射井需要的火箭组件的品质
data:extend
({
    {
        allow_productivity = true,
        auto_recycle = true,
        category = "advanced-crafting",
        subgroup = "space-rocket",
        icon = "__base__/graphics/icons/rocket-part.png",
        enabled = false,
        energy_required = 3,
        hide_from_player_crafting = false,
        unlock_results = true,
        ingredients = {
            {
                amount = 1,
                name = "processing-unit",
                type = "item"
            },
            {
                amount = 1,
                name = "low-density-structure",
                type = "item"
            },
            {
                amount = 1,
                name = "rocket-fuel",
                type = "item"
            }
        },
        name = "rocket-part-quality",
        results = {
            {
                amount = 1,
                name = "rocket-part",
                type = "item"
            }
        },
        type = "recipe",
        main_product = "rocket-part"
    }
})

data.raw.recipe["rocket-part"].ingredients =
{
    {
        amount = 1,
        name = "rocket-part",
        type = "item"
    }
}

data.raw["rocket-silo"]["rocket-silo"].fixed_quality = "legendary"

table.insert(data.raw.technology["rocket-silo"].effects,
    {
        type = 'unlock-recipe',
        recipe = 'rocket-part-quality'
    }
)

table.insert(data.raw.technology["rocket-part-productivity"].effects,
    {
        change = 0.1,
        recipe = "rocket-part-quality",
        type = "change-recipe-productivity"
    }
)
