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

#namespace zm_perk_sleight_of_hand;

// Namespace zm_perk_sleight_of_hand
// Params 0, eflags: 0x2
// Checksum 0xf46829, Offset: 0x348
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_perk_sleight_of_hand", &__init__, undefined, undefined);
}

// Namespace zm_perk_sleight_of_hand
// Params 0, eflags: 0x0
// Checksum 0xf7e84d3f, Offset: 0x388
// Size: 0x14
function __init__() {
    function_ec609c41();
}

// Namespace zm_perk_sleight_of_hand
// Params 0, eflags: 0x0
// Checksum 0x208cef83, Offset: 0x3a8
// Size: 0xf4
function function_ec609c41() {
    zm_perks::register_perk_basic_info("specialty_fastreload", "sleight", 3000, %ZOMBIE_PERK_FASTRELOAD, getweapon("zombie_perk_bottle_sleight"));
    zm_perks::register_perk_precache_func("specialty_fastreload", &function_1f07387f);
    zm_perks::register_perk_clientfields("specialty_fastreload", &function_1fff78dd, &function_86e1cb2a);
    zm_perks::register_perk_machine("specialty_fastreload", &function_2e78087c);
    zm_perks::register_perk_host_migration_params("specialty_fastreload", "vending_sleight", "sleight_light");
}

// Namespace zm_perk_sleight_of_hand
// Params 0, eflags: 0x0
// Checksum 0xa0df73ed, Offset: 0x4a8
// Size: 0xe0
function function_1f07387f() {
    if (isdefined(level.var_46bc5aab)) {
        [[ level.var_46bc5aab ]]();
        return;
    }
    level._effect["sleight_light"] = "zombie/fx_perk_sleight_of_hand_zmb";
    level.machine_assets["specialty_fastreload"] = spawnstruct();
    level.machine_assets["specialty_fastreload"].weapon = getweapon("zombie_perk_bottle_sleight");
    level.machine_assets["specialty_fastreload"].off_model = "p7_zm_vending_sleight";
    level.machine_assets["specialty_fastreload"].on_model = "p7_zm_vending_sleight";
}

// Namespace zm_perk_sleight_of_hand
// Params 0, eflags: 0x0
// Checksum 0x338e5b7c, Offset: 0x590
// Size: 0x34
function function_1fff78dd() {
    clientfield::register("clientuimodel", "hudItems.perks.sleight_of_hand", 1, 2, "int");
}

// Namespace zm_perk_sleight_of_hand
// Params 1, eflags: 0x0
// Checksum 0x84438de0, Offset: 0x5d0
// Size: 0x2c
function function_86e1cb2a(state) {
    self clientfield::set_player_uimodel("hudItems.perks.sleight_of_hand", state);
}

// Namespace zm_perk_sleight_of_hand
// Params 4, eflags: 0x0
// Checksum 0x2b7d63d0, Offset: 0x608
// Size: 0xbc
function function_2e78087c(use_trigger, perk_machine, bump_trigger, collision) {
    use_trigger.script_sound = "mus_perks_speed_jingle";
    use_trigger.script_string = "speedcola_perk";
    use_trigger.script_label = "mus_perks_speed_sting";
    use_trigger.target = "vending_sleight";
    perk_machine.script_string = "speedcola_perk";
    perk_machine.targetname = "vending_sleight";
    if (isdefined(bump_trigger)) {
        bump_trigger.script_string = "speedcola_perk";
    }
}

