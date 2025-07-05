#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace _gadget_speed_burst;

// Namespace _gadget_speed_burst
// Params 0, eflags: 0x2
// Checksum 0x820f1323, Offset: 0x248
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_speed_burst", &__init__, undefined, undefined);
}

// Namespace _gadget_speed_burst
// Params 0, eflags: 0x0
// Checksum 0xcc6c3066, Offset: 0x288
// Size: 0x94
function __init__() {
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    clientfield::register("toplayer", "speed_burst", 1, 1, "int", &function_d6b43cb, 0, 1);
    visionset_mgr::register_visionset_info("speed_burst", 1, 9, undefined, "speed_burst_initialize");
}

// Namespace _gadget_speed_burst
// Params 1, eflags: 0x0
// Checksum 0xb7e83340, Offset: 0x328
// Size: 0x54
function on_localplayer_spawned(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    filter::init_filter_speed_burst(self);
    filter::disable_filter_speed_burst(self, 3);
}

// Namespace _gadget_speed_burst
// Params 7, eflags: 0x0
// Checksum 0x5dac8861, Offset: 0x388
// Size: 0xbc
function function_d6b43cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (self == getlocalplayer(localclientnum)) {
            filter::enable_filter_speed_burst(self, 3);
        }
        return;
    }
    if (self == getlocalplayer(localclientnum)) {
        filter::disable_filter_speed_burst(self, 3);
    }
}

