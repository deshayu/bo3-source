#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_pers_upgrades;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_pers_upgrades_system;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;

#namespace zm_perk_deadshot;

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x2
// Checksum 0xd39e8ff, Offset: 0x350
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("zm_perk_deadshot", &__init__, undefined, undefined);
}

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0x9c6e8528, Offset: 0x388
// Size: 0x12
function __init__() {
    enable_deadshot_perk_for_level();
}

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0xec90ba57, Offset: 0x3a8
// Size: 0x12a
function enable_deadshot_perk_for_level() {
    zm_perks::register_perk_basic_info("specialty_deadshot", "deadshot", 1500, %ZOMBIE_PERK_DEADSHOT, getweapon("zombie_perk_bottle_deadshot"));
    zm_perks::register_perk_precache_func("specialty_deadshot", &deadshot_precache);
    zm_perks::register_perk_clientfields("specialty_deadshot", &deadshot_register_clientfield, &deadshot_set_clientfield);
    zm_perks::register_perk_machine("specialty_deadshot", &deadshot_perk_machine_setup);
    zm_perks::register_perk_threads("specialty_deadshot", &give_deadshot_perk, &take_deadshot_perk);
    zm_perks::register_perk_host_migration_params("specialty_deadshot", "vending_deadshot", "deadshot_light");
}

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0x445545c3, Offset: 0x4e0
// Size: 0xc2
function deadshot_precache() {
    if (isdefined(level.var_72a62e0d)) {
        [[ level.var_72a62e0d ]]();
        return;
    }
    level._effect["deadshot_light"] = "_t6/misc/fx_zombie_cola_dtap_on";
    level.machine_assets["specialty_deadshot"] = spawnstruct();
    level.machine_assets["specialty_deadshot"].weapon = getweapon("zombie_perk_bottle_deadshot");
    level.machine_assets["specialty_deadshot"].off_model = "p7_zm_vending_ads";
    level.machine_assets["specialty_deadshot"].on_model = "p7_zm_vending_ads";
}

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0x4fc77ac4, Offset: 0x5b0
// Size: 0x52
function deadshot_register_clientfield() {
    clientfield::register("toplayer", "deadshot_perk", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.perks.dead_shot", 1, 2, "int");
}

// Namespace zm_perk_deadshot
// Params 1, eflags: 0x0
// Checksum 0xeda71017, Offset: 0x610
// Size: 0x22
function deadshot_set_clientfield(state) {
    self clientfield::set_player_uimodel("hudItems.perks.dead_shot", state);
}

// Namespace zm_perk_deadshot
// Params 4, eflags: 0x0
// Checksum 0x25e2badc, Offset: 0x640
// Size: 0x9a
function deadshot_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
    use_trigger.script_sound = "mus_perks_deadshot_jingle";
    use_trigger.script_string = "deadshot_perk";
    use_trigger.script_label = "mus_perks_deadshot_sting";
    use_trigger.target = "vending_deadshot";
    perk_machine.script_string = "deadshot_vending";
    perk_machine.targetname = "vending_deadshot";
    if (isdefined(bump_trigger)) {
        bump_trigger.script_string = "deadshot_vending";
    }
}

// Namespace zm_perk_deadshot
// Params 0, eflags: 0x0
// Checksum 0xe4bbc9ca, Offset: 0x6e8
// Size: 0x1a
function give_deadshot_perk() {
    self clientfield::set_to_player("deadshot_perk", 1);
}

// Namespace zm_perk_deadshot
// Params 3, eflags: 0x0
// Checksum 0x5b6e4c5d, Offset: 0x710
// Size: 0x32
function take_deadshot_perk(b_pause, str_perk, str_result) {
    self clientfield::set_to_player("deadshot_perk", 0);
}

