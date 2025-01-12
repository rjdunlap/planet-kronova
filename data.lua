--data.lua
local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")

--START MAP GEN
function MapGen_Kronova()
    --Naivus based generation
    local map_gen_setting = table.deepcopy(data.raw.planet.nauvis.map_gen_settings)

    map_gen_setting.property_expression_names.temperature = "aquilo_temperature"
    map_gen_setting.property_expression_names.moisture = "moisture_basic"
    
    map_gen_setting.autoplace_controls = {
        
        ["enemy-base"] = { frequency = 1, size = 1, richness = 1},
        ["stone"] = { frequency = 2, size = 2, richness = 2},
        ["iron-ore"] = { frequency = 2, size = 1, richness = 2},
        ["coal"] = { frequency = 2.5, size = 2, richness = 2.5},
        ["copper-ore"] = { frequency = 2, size = 1, richness = 2},
        ["crude-oil"] = { frequency = 2, size = 2, richness = 3},
        ["trees"] = { frequency = 3, size = 2, richness = 1 },
        ["water"] = { frequency = 2, size = 2, richness = 2 },
    }

    map_gen_setting.autoplace_settings["tile"] =
    {
        settings =
        {
            ["grass-1"] = {},
            ["grass-2"] = {},
            ["grass-3"] = {},
            ["grass-4"] = {},
            ["dry-dirt"] = {},
            ["dirt-1"] = {},
            ["dirt-2"] = {},
            ["dirt-3"] = {},
            ["dirt-4"] = {},
            ["dirt-5"] = {},
            ["dirt-6"] = {},
            ["dirt-7"] = {},
            ["sand-1"] = {},
            ["sand-2"] = {},
            ["sand-3"] = {},
            ["red-desert-0"] = {},
            ["red-desert-1"] = {},
            ["red-desert-2"] = {},
            ["red-desert-3"] = {},
            ["water"] = {},
            ["deepwater"] = {},

            ["snow-flat"] = {},
            ["snow-crests"] = {},
            ["snow-lumpy"] = {},
            ["snow-patchy"] = {},
            ["ice-rough"] = {},
            ["ice-smooth"] = {},
            ["brash-ice"] = {},
            ["ammoniacal-ocean"] = {},
            ["ammoniacal-ocean-2"] = {}
        }
    }

    map_gen_setting.autoplace_settings["decorative"] =
    {
      settings =
      {
        -- nauvis decoratives
        ["v-brown-carpet-grass"] = {},
        ["v-green-hairy-grass"] = {},
        ["v-brown-hairy-grass"] = {},
        ["v-red-pita"] = {},
        -- end of nauvis
        ["lithium-iceberg-medium"] = {},
          ["lithium-iceberg-small"] = {},
          ["lithium-iceberg-tiny"] = {},
          ["floating-iceberg-large"] = {},
          ["floating-iceberg-small"] = {},
          ["aqulio-ice-decal-blue"] = {},
          ["aqulio-snowy-decal"] = {},
          ["snow-drift-decal"] = {}
      }
    }

    map_gen_setting.autoplace_settings["entity"] =  { 
        settings =
        {
        ["iron-ore"] = {},
        ["copper-ore"] = {},
        ["stone"] = {},
        ["coal"] = {},
        ["crude-oil"] = {},
        ["lithium-iceberg-huge"] = {},
        ["lithium-iceberg-big"] = {}
        }
    }
     

    return map_gen_setting
end
-- increse stone patch size in start area
-- data.raw["resource"]["stone"]["autoplace"]["starting_area_size"] = 5500 * (0.005 / 3)

--END MAP GEN

local nauvis = data.raw["planet"]["nauvis"]
local planet_lib = require("__PlanetsLib__.lib.planet")

local kronova = 
{
    type = "planet",
    name = "kronova", 
    solar_power_in_space = nauvis.solar_power_in_space,
    icon = "__planet-kronova__/graphics/planet-kronova.png",
    icon_size = 512,
    label_orientation = 0.55,
    starmap_icon = "__planet-kronova__/graphics/planet-kronova.png",
    starmap_icon_size = 512,
    magnitude = nauvis.magnitude,
    surface_properties = {
        ["solar-power"] = 50,
        ["pressure"] = nauvis.surface_properties["pressure"],
        ["magnetic-field"] = nauvis.surface_properties["magnetic-field"],
        ["day-night-cycle"] = nauvis.surface_properties["day-night-cycle"],
    },
    map_gen_settings = MapGen_Kronova()
}

kronova.orbit = {
    parent = {
        type = "space-location",
        name = "star",
    },
    distance = 2.66,
    orientation = 0.19
}

local kronova_connection = {
    type = "space-connection",
    name = "nauvis-kronova",
    from = "nauvis",
    to = "kronova",
    subgroup = data.raw["space-connection"]["nauvis-vulcanus"].subgroup,
    length = 15000,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus),
  }

PlanetsLib:extend({kronova})

data:extend{kronova_connection}

data:extend {{
    type = "technology",
    name = "planet-discovery-kronova",
    icons = util.technology_icon_constant_planet("__planet-kronova__/graphics/planet-kronova.png"),
    icon_size = 256,
    essential = true,
    localised_description = {"space-location-description.kronova"},
    effects = {
        {
            type = "unlock-space-location",
            space_location = "kronova",
            use_icon_overlay_constant = true
        },
    },
    prerequisites = {
        "space-science-pack",
    },
    unit = {
        count = 200,
        ingredients = {
            {"automation-science-pack",      1},
            {"logistic-science-pack",        1},
            {"chemical-science-pack",        1},
            {"space-science-pack",           1}
        },
        time = 60,
    },
    order = "ea[kronova]",
}}


APS.add_planet{name = "kronova", filename = "__planet-kronova__/kronova.lua", technology = "planet-discovery-kronova"}