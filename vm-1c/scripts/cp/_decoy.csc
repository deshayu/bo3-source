#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/weapons/_decoy;

#namespace decoy;

// Namespace decoy
// Params 0, eflags: 0x2
// Checksum 0x97231fa3, Offset: 0xf8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("decoy", &__init__, undefined, undefined);
}

// Namespace decoy
// Params 0, eflags: 0x0
// Checksum 0x3f9426b7, Offset: 0x138
// Size: 0x14
function __init__() {
    init_shared();
}

