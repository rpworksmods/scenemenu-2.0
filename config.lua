Config = {}
BootPresets = {}

Config.MenuKey = "F1" -- Change the key used to open the main menu

Config.Props = { -- A list of the spawnable props
    { Display = "Small Road Cone", Prop = "prop_roadcone02c", stopPeds = true}, -- 1
    { Display = "Large Road Cone", Prop = "prop_roadcone01a", stopPeds = true}, -- 2
    { Display = "Road Closed", Prop = "prop_barrier_work05", stopPeds = true}, -- 3
    { Display = "Scene Light", Prop = "prop_worklight_04d", stopPeds = false} -- 4
}

Config.Anims = { -- The animations that may be played on peds stopped at cordons.

    {Dict = "rcmepsilonism8", Anim = "base_carrier"},
    {Dict = "oddjobs@assassinate@construction@", Anim = "unarmed_fold_arms"},
    {Dict = "missfbi_s4mop", Anim = "guard_idle_a"},
    {Dict = "amb@world_human_smoking@male@male_a@base", Anim = "base"},
    {Dict = "amb@world_human_stand_mobile@male@standing@call@base", Anim = "base"},
    {Dict = "amb@world_human_stand_impatient@male@no_sign@base", Anim = "base"}

} 