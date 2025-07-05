#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_stock_option;

// Namespace zm_bgb_stock_option
// Params 0, eflags: 0x2
// Checksum 0xd7fbb720, Offset: 0x148
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_bgb_stock_option", &__init__, undefined, undefined);
}

// Namespace zm_bgb_stock_option
// Params 0, eflags: 0x0
// Checksum 0xcb4e9d3d, Offset: 0x188
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_stock_option", "time");
}

