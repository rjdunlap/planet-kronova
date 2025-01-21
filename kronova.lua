local utils = require("__any-planet-start__/utils")
utils.set_prerequisites("steel-processing", nil)
utils.add_recipes("steel-processing", {"medium-electric-pole", "iron-stick"})
utils.set_prerequisites("concrete", {"automation-science-pack"})
utils.set_prerequisites("heating-tower", {"concrete"})

utils.set_unit("concrete", {
    count = 25,
    ingredients = {{"automation-science-pack", 2}},
    time = 15,
})

utils.set_unit("heating-tower", {
    count = 50,
    ingredients = {{"automation-science-pack", 2}},
    time = 15,
})