#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace _zm_weap_octobomb;

// Namespace _zm_weap_octobomb
// Params 0, eflags: 0x2
// Checksum 0x517eedfb, Offset: 0x4d0
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_weap_octobomb", &__init__, &__main__, undefined);
}

// Namespace _zm_weap_octobomb
// Params 0, eflags: 0x0
// Checksum 0x6ee8ce99, Offset: 0x518
// Size: 0x25c
function __init__() {
    clientfield::register("scriptmover", "octobomb_fx", 1, 2, "int", &octobomb_fx, 1, 0);
    clientfield::register("actor", "octobomb_spores_fx", 1, 2, "int", &octobomb_spores_fx, 1, 0);
    clientfield::register("actor", "octobomb_tentacle_hit_fx", 1, 1, "int", &octobomb_tentacle_hit_fx, 1, 0);
    clientfield::register("actor", "zombie_explode_fx", 1, 1, "counter", &octobomb_zombie_explode_fx, 1, 0);
    clientfield::register("actor", "zombie_explode_fx", -8000, 1, "counter", &octobomb_zombie_explode_fx, 1, 0);
    clientfield::register("actor", "octobomb_zombie_explode_fx", 8000, 1, "counter", &octobomb_zombie_explode_fx, 1, 0);
    clientfield::register("missile", "octobomb_spit_fx", 1, 2, "int", &octobomb_spit_fx, 1, 0);
    clientfield::register("toplayer", "octobomb_state", 1, 3, "int", undefined, 0, 1);
    setupclientfieldcodecallbacks("toplayer", 1, "octobomb_state");
}

// Namespace _zm_weap_octobomb
// Params 0, eflags: 0x0
// Checksum 0x3267a05e, Offset: 0x780
// Size: 0x162
function __main__() {
    if (!zm_weapons::is_weapon_included(getweapon("octobomb"))) {
        return;
    }
    level._effect["octobomb_explode_fx"] = "zombie/fx_octobomb_explo_death_zod_zmb";
    level._effect["octobomb_spores"] = "zombie/fx_octobomb_sporesplosion_zod_zmb";
    level._effect["octobomb_spores_spine"] = "zombie/fx_octobomb_spore_burn_torso_zod_zmb";
    level._effect["octobomb_spores_legs"] = "zombie/fx_octobomb_spore_burn_leg_zod_zmb";
    level._effect["octobomb_sporesplosion"] = "zombie/fx_octobomb_sporesplosion_tell_zod_zmb";
    level._effect["octobomb_ug_spores"] = "zombie/fx_octobomb_sporesplosion_ee_zod_zmb";
    level._effect["octobomb_ug_spores_spine"] = "zombie/fx_octobomb_spore_burn_torso_ee_zod_zmb";
    level._effect["octobomb_ug_spores_legs"] = "zombie/fx_octobomb_spore_burn_leg_zod_zmb";
    level._effect["octobomb_ug_sporesplosion"] = "zombie/fx_octobomb_sporesplosion_tell_ee_zod_zmb";
    level._effect["octobomb_tentacle_hit"] = "impacts/fx_flesh_hit_knife_lg_zmb";
    level._effect["zombie_explode"] = "zombie/fx_bmode_attack_grapple_zod_zmb";
}

// Namespace _zm_weap_octobomb
// Params 7, eflags: 0x0
// Checksum 0x8d171363, Offset: 0x8f0
// Size: 0xb6
function octobomb_tentacle_hit_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_39b71bae = playfxontag(localclientnum, level._effect["octobomb_tentacle_hit"], self, "j_spineupper");
        return;
    }
    if (isdefined(self.var_39b71bae)) {
        stopfx(localclientnum, self.var_39b71bae);
        self.var_39b71bae = undefined;
    }
}

// Namespace _zm_weap_octobomb
// Params 7, eflags: 0x0
// Checksum 0x7b8b94c4, Offset: 0x9b0
// Size: 0x13e
function octobomb_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 3:
        playfx(localclientnum, level._effect["octobomb_explode_fx"], self.origin, anglestoup(self.angles));
        break;
    case 2:
        var_474c093 = level._effect["octobomb_ug_spores"];
        playfxontag(localclientnum, var_474c093, self, "tag_origin");
        break;
    default:
        var_474c093 = level._effect["octobomb_spores"];
        playfxontag(localclientnum, var_474c093, self, "tag_origin");
        break;
    }
}

// Namespace _zm_weap_octobomb
// Params 7, eflags: 0x0
// Checksum 0xc4a9f8a2, Offset: 0xaf8
// Size: 0x64
function octobomb_spores_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread function_f9535d61(localclientnum, newval);
    }
}

// Namespace _zm_weap_octobomb
// Params 2, eflags: 0x0
// Checksum 0x3066f8be, Offset: 0xb68
// Size: 0x19c
function function_f9535d61(localclientnum, var_a1e9c985) {
    self endon(#"entityshutdown");
    if (var_a1e9c985 == 2) {
        var_be0d4b67 = level._effect["octobomb_ug_spores_spine"];
        var_e2f51105 = level._effect["octobomb_ug_spores_legs"];
    } else {
        var_be0d4b67 = level._effect["octobomb_spores_spine"];
        var_e2f51105 = level._effect["octobomb_spores_legs"];
    }
    self.var_7974ff00 = playfxontag(localclientnum, var_be0d4b67, self, "j_spine4");
    wait 3.5;
    self.var_7c893fb = playfxontag(localclientnum, var_e2f51105, self, "j_hip_ri");
    self.var_cd151d3d = playfxontag(localclientnum, var_e2f51105, self, "j_hip_le");
    wait 3.5;
    stopfx(localclientnum, self.var_7974ff00);
    stopfx(localclientnum, self.var_7c893fb);
    stopfx(localclientnum, self.var_cd151d3d);
}

// Namespace _zm_weap_octobomb
// Params 7, eflags: 0x0
// Checksum 0xf54ca7df, Offset: 0xd10
// Size: 0x9c
function octobomb_zombie_explode_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (util::is_mature() && !util::is_gib_restricted_build()) {
        playfxontag(localclientnum, level._effect["zombie_explode"], self, "j_spinelower");
    }
}

// Namespace _zm_weap_octobomb
// Params 7, eflags: 0x0
// Checksum 0x4f11cf14, Offset: 0xdb8
// Size: 0xb4
function octobomb_spit_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 2) {
        var_9ee6a794 = level._effect["octobomb_ug_sporesplosion"];
    } else {
        var_9ee6a794 = level._effect["octobomb_sporesplosion"];
    }
    level thread function_a034a6b1(localclientnum, self.origin, self.angles, var_9ee6a794);
}

// Namespace _zm_weap_octobomb
// Params 4, eflags: 0x0
// Checksum 0xa2293d04, Offset: 0xe78
// Size: 0x84
function function_a034a6b1(localclientnum, v_origin, v_angles, var_9ee6a794) {
    fx_id = playfx(localclientnum, var_9ee6a794, v_origin, anglestoup(v_angles));
    wait 3.41668;
    stopfx(localclientnum, fx_id);
}

