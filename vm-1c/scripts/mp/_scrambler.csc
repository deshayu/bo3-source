#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/clientfield_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_scrambler;

#namespace scrambler;

// Namespace scrambler
// Params 0, eflags: 0x2
// Checksum 0xde05843b, Offset: 0x158
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("scrambler", &__init__, undefined, undefined);
}

// Namespace scrambler
// Params 0, eflags: 0x0
// Checksum 0xf57eac54, Offset: 0x198
// Size: 0x14
function __init__() {
    init_shared();
}

