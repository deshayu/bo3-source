#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_decoy;

#namespace decoy;

// Namespace decoy
// Params 0, eflags: 0x2
// Checksum 0x7e97b40f, Offset: 0x128
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("decoy", &__init__, undefined, undefined);
}

// Namespace decoy
// Params 0, eflags: 0x0
// Checksum 0xabfbc6fd, Offset: 0x168
// Size: 0x14
function __init__() {
    init_shared();
}

