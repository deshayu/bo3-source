#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_satchel_charge;

#namespace satchel_charge;

// Namespace satchel_charge
// Params 0, eflags: 0x2
// Checksum 0xbb2304f1, Offset: 0x148
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("satchel_charge", &__init__, undefined, undefined);
}

// Namespace satchel_charge
// Params 1, eflags: 0x0
// Checksum 0x94cdc0b0, Offset: 0x180
// Size: 0x1a
function __init__(localclientnum) {
    init_shared();
}

