#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace zm_elemental_zombie;

// Namespace zm_elemental_zombie
// Params 0, eflags: 0x2
// Checksum 0xf94b5e8d, Offset: 0x460
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_elemental_zombie", &__init__, undefined, undefined);
}

// Namespace zm_elemental_zombie
// Params 0, eflags: 0x0
// Checksum 0x6ed37b1c, Offset: 0x4a0
// Size: 0x24
function __init__() {
    init_fx();
    register_clientfields();
}

// Namespace zm_elemental_zombie
// Params 0, eflags: 0x0
// Checksum 0x52286618, Offset: 0x4d0
// Size: 0xaa
function init_fx() {
    level._effect["elemental_zombie_sparky"] = "electric/fx_ability_elec_surge_short_robot_optim";
    level._effect["elemental_sparky_zombie_suicide"] = "explosions/fx_ability_exp_ravage_core_optim";
    level._effect["elemental_zombie_fire_damage"] = "fire/fx_embers_burst_optim";
    level._effect["elemental_napalm_zombie_suicide"] = "explosions/fx_exp_dest_barrel_concussion_sm_optim";
    level._effect["elemental_zombie_spark_light"] = "light/fx_light_spark_chest_zombie_optim";
    level._effect["elemental_electric_spark"] = "electric/fx_elec_sparks_burst_blue_optim";
}

// Namespace zm_elemental_zombie
// Params 0, eflags: 0x0
// Checksum 0x305769ef, Offset: 0x588
// Size: 0x1b4
function register_clientfields() {
    clientfield::register("actor", "sparky_zombie_spark_fx", 1, 1, "int", &function_de563d9b, 0, 0);
    clientfield::register("actor", "sparky_zombie_death_fx", 1, 1, "int", &function_d0886efe, 0, 0);
    clientfield::register("actor", "napalm_zombie_death_fx", 1, 1, "int", &function_56ad3a27, 0, 0);
    clientfield::register("actor", "sparky_damaged_fx", 1, 1, "counter", &function_86aaed61, 0, 0);
    clientfield::register("actor", "napalm_damaged_fx", 1, 1, "counter", &function_16467cb6, 0, 0);
    clientfield::register("actor", "napalm_sfx", 11000, 1, "int", &function_b542950d, 0, 0);
}

// Namespace zm_elemental_zombie
// Params 7, eflags: 0x0
// Checksum 0x8ed8958d, Offset: 0x748
// Size: 0xd4
function function_56ad3a27(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (oldval !== newval && newval === 1) {
        fx = playfxontag(localclientnum, level._effect["elemental_napalm_zombie_suicide"], self, "j_spineupper");
        self playsound(0, "zmb_elemental_zombie_explode_fire");
    }
}

// Namespace zm_elemental_zombie
// Params 7, eflags: 0x0
// Checksum 0x6ed3dfa, Offset: 0x828
// Size: 0x144
function function_16467cb6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        if (isdefined(level._effect["elemental_zombie_fire_damage"])) {
            playsound(localclientnum, "gdt_electro_bounce", self.origin);
            locs = array("j_wrist_le", "j_wrist_ri");
            fx = playfxontag(localclientnum, level._effect["elemental_zombie_fire_damage"], self, array::random(locs));
            setfxignorepause(localclientnum, fx, 1);
        }
    }
}

// Namespace zm_elemental_zombie
// Params 7, eflags: 0x0
// Checksum 0x6fa79339, Offset: 0x978
// Size: 0x84
function function_b542950d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (!isdefined(self.var_1f5b576b)) {
            self.var_1f5b576b = self playloopsound("zmb_elemental_zombie_loop_fire", 0.2);
        }
    }
}

// Namespace zm_elemental_zombie
// Params 7, eflags: 0x0
// Checksum 0xc7d0424f, Offset: 0xa08
// Size: 0x1bc
function function_de563d9b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(newval)) {
        return;
    }
    if (newval == 1) {
        if (!isdefined(self.var_e863c331)) {
            self.var_e863c331 = self playloopsound("zmb_electrozomb_lp", 0.2);
        }
        str_tag = "J_SpineUpper";
        if (isdefined(self.var_46d9c2ee)) {
            str_tag = self.var_46d9c2ee;
        }
        str_fx = level._effect["elemental_zombie_sparky"];
        if (isdefined(self.var_7abb4217)) {
            str_fx = self.var_7abb4217;
        }
        fx = playfxontag(localclientnum, str_fx, self, str_tag);
        setfxignorepause(localclientnum, fx, 1);
        var_4473cd0 = level._effect["elemental_zombie_spark_light"];
        if (isdefined(self.var_e22d3880)) {
            var_4473cd0 = self.var_e22d3880;
        }
        fx = playfxontag(localclientnum, var_4473cd0, self, str_tag);
        setfxignorepause(localclientnum, fx, 1);
    }
}

// Namespace zm_elemental_zombie
// Params 7, eflags: 0x0
// Checksum 0x5d70c624, Offset: 0xbd0
// Size: 0xb4
function function_d0886efe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (oldval !== newval && newval === 1) {
        fx = playfxontag(localclientnum, level._effect["elemental_sparky_zombie_suicide"], self, "j_spineupper");
        self playsound(0, "zmb_elemental_zombie_explode_elec");
    }
}

// Namespace zm_elemental_zombie
// Params 7, eflags: 0x0
// Checksum 0xf088265f, Offset: 0xc90
// Size: 0x12c
function function_86aaed61(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(newval)) {
        return;
    }
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval >= 1) {
        if (!isdefined(self.var_e863c331)) {
            self.var_e863c331 = self playloopsound("zmb_electrozomb_lp", 0.2);
        }
        fx = playfxontag(localclientnum, level._effect["elemental_electric_spark"], self, "J_SpineUpper");
        setfxignorepause(localclientnum, fx, 1);
    }
}

