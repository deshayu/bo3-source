#using scripts/codescripts/struct;
#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace zm_traps;

// Namespace zm_traps
// Params 0, eflags: 0x2
// Checksum 0x2088e50d, Offset: 0xe8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_traps", &__init__, undefined, undefined);
}

// Namespace zm_traps
// Params 0, eflags: 0x0
// Checksum 0x1c521a67, Offset: 0x128
// Size: 0xf4
function __init__() {
    s_traps_array = struct::get_array("zm_traps", "targetname");
    a_registered_traps = [];
    foreach (trap in s_traps_array) {
        if (isdefined(trap.script_noteworthy)) {
            if (!trap is_trap_registered(a_registered_traps)) {
                a_registered_traps[trap.script_noteworthy] = 1;
            }
        }
    }
}

// Namespace zm_traps
// Params 1, eflags: 0x0
// Checksum 0x883cae0, Offset: 0x228
// Size: 0x1a
function is_trap_registered(a_registered_traps) {
    return isdefined(a_registered_traps[self.script_noteworthy]);
}

