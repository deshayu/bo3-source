#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/shared/weapons/_flashgrenades;

#namespace flashgrenades;

// Namespace flashgrenades
// Params 0, eflags: 0x2
// Checksum 0xb8bc3ebe, Offset: 0x120
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("flashgrenades", &__init__, undefined, undefined);
}

// Namespace flashgrenades
// Params 0, eflags: 0x0
// Checksum 0x109f6123, Offset: 0x160
// Size: 0x14
function __init__() {
    init_shared();
}

