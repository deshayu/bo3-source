#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
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

#namespace zm_perk_juggernaut;

// Namespace zm_perk_juggernaut
// Params 0, eflags: 0x2
// Checksum 0x38036258, Offset: 0x3a8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_perk_juggernaut", &__init__, undefined, undefined);
}

// Namespace zm_perk_juggernaut
// Params 0, eflags: 0x0
// Checksum 0x8b963af3, Offset: 0x3e8
// Size: 0x14
function __init__() {
    function_242d42bd();
}

// Namespace zm_perk_juggernaut
// Params 0, eflags: 0x0
// Checksum 0x3626e569, Offset: 0x408
// Size: 0x13c
function function_242d42bd() {
    zm_perks::register_perk_basic_info("specialty_armorvest", "juggernog", 2500, %ZOMBIE_PERK_JUGGERNAUT, getweapon("zombie_perk_bottle_jugg"));
    zm_perks::register_perk_precache_func("specialty_armorvest", &function_9e164b07);
    zm_perks::register_perk_clientfields("specialty_armorvest", &function_d361c845, &function_ea578652);
    zm_perks::register_perk_machine("specialty_armorvest", &function_d5821244, &init_juggernaut);
    zm_perks::register_perk_threads("specialty_armorvest", &function_c54b4a8c, &function_9c9dac0a);
    zm_perks::register_perk_host_migration_params("specialty_armorvest", "vending_jugg", "jugger_light");
}

// Namespace zm_perk_juggernaut
// Params 0, eflags: 0x0
// Checksum 0xcacd49a6, Offset: 0x550
// Size: 0x44
function init_juggernaut() {
    zombie_utility::set_zombie_var("zombie_perk_juggernaut_health", 100);
    zombie_utility::set_zombie_var("zombie_perk_juggernaut_health_upgrade", -106);
}

// Namespace zm_perk_juggernaut
// Params 0, eflags: 0x0
// Checksum 0x363a66ac, Offset: 0x5a0
// Size: 0xe0
function function_9e164b07() {
    if (isdefined(level.var_9cbce143)) {
        [[ level.var_9cbce143 ]]();
        return;
    }
    level._effect["jugger_light"] = "zombie/fx_perk_juggernaut_zmb";
    level.machine_assets["specialty_armorvest"] = spawnstruct();
    level.machine_assets["specialty_armorvest"].weapon = getweapon("zombie_perk_bottle_jugg");
    level.machine_assets["specialty_armorvest"].off_model = "p7_zm_vending_jugg";
    level.machine_assets["specialty_armorvest"].on_model = "p7_zm_vending_jugg";
}

// Namespace zm_perk_juggernaut
// Params 0, eflags: 0x0
// Checksum 0x7f7b6198, Offset: 0x688
// Size: 0x34
function function_d361c845() {
    clientfield::register("clientuimodel", "hudItems.perks.juggernaut", 1, 2, "int");
}

// Namespace zm_perk_juggernaut
// Params 1, eflags: 0x0
// Checksum 0x6745ff19, Offset: 0x6c8
// Size: 0x2c
function function_ea578652(state) {
    self clientfield::set_player_uimodel("hudItems.perks.juggernaut", state);
}

// Namespace zm_perk_juggernaut
// Params 4, eflags: 0x0
// Checksum 0x7a1d5d03, Offset: 0x700
// Size: 0xd0
function function_d5821244(use_trigger, perk_machine, bump_trigger, collision) {
    use_trigger.script_sound = "mus_perks_jugganog_jingle";
    use_trigger.script_string = "jugg_perk";
    use_trigger.script_label = "mus_perks_jugganog_sting";
    use_trigger.var_e1405ef7 = 1;
    use_trigger.target = "vending_jugg";
    perk_machine.script_string = "jugg_perk";
    perk_machine.targetname = "vending_jugg";
    if (isdefined(bump_trigger)) {
        bump_trigger.script_string = "jugg_perk";
    }
}

// Namespace zm_perk_juggernaut
// Params 0, eflags: 0x0
// Checksum 0xd0d1636d, Offset: 0x7d8
// Size: 0x24
function function_c54b4a8c() {
    self zm_perks::function_78f42790("specialty_armorvest", 1, 0);
}

// Namespace zm_perk_juggernaut
// Params 3, eflags: 0x0
// Checksum 0x9ca19136, Offset: 0x808
// Size: 0x44
function function_9c9dac0a(b_pause, str_perk, str_result) {
    self zm_perks::function_78f42790("health_reboot", 1, 1);
}

