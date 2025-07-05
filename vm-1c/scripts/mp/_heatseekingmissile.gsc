#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_heatseekingmissile;

#namespace heatseekingmissile;

// Namespace heatseekingmissile
// Params 0, eflags: 0x2
// Checksum 0x518bb9c5, Offset: 0x178
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("heatseekingmissile", &__init__, undefined, undefined);
}

// Namespace heatseekingmissile
// Params 0, eflags: 0x0
// Checksum 0x5ae182cf, Offset: 0x1b8
// Size: 0x2c
function __init__() {
    level.lockoncloserange = -36;
    level.lockoncloseradiusscaler = 1;
    init_shared();
}

