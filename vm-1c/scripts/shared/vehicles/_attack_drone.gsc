#using scripts/codescripts/struct;
#using scripts/shared/math_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;

#namespace attack_drone;

// Namespace attack_drone
// Params 0, eflags: 0x2
// Checksum 0x61abf4e4, Offset: 0x1a0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("attack_drone", &__init__, undefined, undefined);
}

// Namespace attack_drone
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x1e0
// Size: 0x4
function __init__() {
    
}

