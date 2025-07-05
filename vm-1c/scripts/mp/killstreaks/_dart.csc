#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace dart;

// Namespace dart
// Params 0, eflags: 0x2
// Checksum 0xe544e108, Offset: 0x208
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("dart", &__init__, undefined, undefined);
}

// Namespace dart
// Params 0, eflags: 0x0
// Checksum 0xbbb97268, Offset: 0x248
// Size: 0x164
function __init__() {
    clientfield::register("toplayer", "dart_update_ammo", 1, 2, "int", &update_ammo, 0, 0);
    clientfield::register("toplayer", "fog_bank_3", 1, 1, "int", &fog_bank_3_callback, 0, 0);
    level.dartbundle = struct::get_script_bundle("killstreak", "killstreak_dart");
    vehicle::add_vehicletype_callback(level.dartbundle.var_d9038040, &spawned);
    visionset_mgr::register_visionset_info("dart_visionset", 1, 1, undefined, "mp_vehicles_dart");
    visionset_mgr::register_visionset_info("sentinel_visionset", 1, 1, undefined, "mp_vehicles_sentinel");
    visionset_mgr::register_visionset_info("remote_missile_visionset", 1, 1, undefined, "mp_hellstorm");
}

// Namespace dart
// Params 7, eflags: 0x0
// Checksum 0xd0347fa9, Offset: 0x3b8
// Size: 0x84
function update_ammo(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setuimodelvalue(getuimodel(getuimodelforcontroller(localclientnum), "vehicle.ammo"), newval);
}

// Namespace dart
// Params 1, eflags: 0x0
// Checksum 0xa9f51688, Offset: 0x448
// Size: 0x1c
function spawned(localclientnum) {
    self.killstreakbundle = level.dartbundle;
}

// Namespace dart
// Params 7, eflags: 0x0
// Checksum 0x6c32da11, Offset: 0x470
// Size: 0x94
function fog_bank_3_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval != newval) {
        if (newval == 1) {
            setworldfogactivebank(localclientnum, 4);
            return;
        }
        setworldfogactivebank(localclientnum, 1);
    }
}

