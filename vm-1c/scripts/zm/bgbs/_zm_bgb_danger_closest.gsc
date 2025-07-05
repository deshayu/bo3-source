#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_danger_closest;

// Namespace zm_bgb_danger_closest
// Params 0, eflags: 0x2
// Checksum 0x52c49cbc, Offset: 0x168
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_bgb_danger_closest", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_danger_closest
// Params 0, eflags: 0x0
// Checksum 0x717020c3, Offset: 0x1a8
// Size: 0x44
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_danger_closest", "rounds", 3, undefined, undefined, undefined);
}

