#using scripts/codescripts/struct;
#using scripts/shared/system_shared;
#using scripts/zm/_zm_melee_weapon;
#using scripts/zm/_zm_weapons;

#namespace _zm_weap_plunger;

// Namespace _zm_weap_plunger
// Params 0, eflags: 0x2
// Checksum 0x48175b48, Offset: 0x158
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("plunger_knife", &__init__, &__main__, undefined);
}

// Namespace _zm_weap_plunger
// Params 0, eflags: 0x4
// Checksum 0x99ec1590, Offset: 0x1a0
// Size: 0x4
function private __init__() {
    
}

// Namespace _zm_weap_plunger
// Params 0, eflags: 0x4
// Checksum 0x2b654610, Offset: 0x1b0
// Size: 0x7c
function private __main__() {
    cost = 3000;
    zm_melee_weapon::init("knife_plunger", "zombie_plunger_flourish", undefined, undefined, cost, "bowie_upgrade", %ZMWEAPON_NONE, "plunger", undefined);
    zm_melee_weapon::set_fallback_weapon("knife_plunger", "zombie_fists_plunger");
}

// Namespace _zm_weap_plunger
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x238
// Size: 0x4
function init() {
    
}

