#using scripts/codescripts/struct;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/beam_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;
#using scripts/zm/zm_genesis_util;

#using_animtree("zm_genesis");

#namespace zm_genesis_boss;

// Namespace zm_genesis_boss
// Params 0, eflags: 0x2
// Checksum 0xbce2bc2f, Offset: 0x688
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_genesis_boss", &__init__, undefined, undefined);
}

// Namespace zm_genesis_boss
// Params 0, eflags: 0x0
// Checksum 0xb30dc8b1, Offset: 0x6c8
// Size: 0x12c
function __init__() {
    level._effect["boss_shield"] = "zombie/fx_ee_shadowman_shield_loop_zod";
    level._effect["powerup_column"] = "dlc4/genesis/fx_darkarena_powerup_pillar";
    clientfield::register("scriptmover", "boss_clone_fx", 15000, getminbitcountfornum(3), "int", &boss_clone_fx, 0, 0);
    clientfield::register("world", "sophia_state", 15000, getminbitcountfornum(4), "int", &sophia_state, 0, 1);
    clientfield::register("world", "boss_beam_state", 15000, 1, "int", &boss_beam_state, 0, 1);
}

// Namespace zm_genesis_boss
// Params 7, eflags: 0x0
// Checksum 0x94b90d76, Offset: 0x800
// Size: 0x25e
function boss_clone_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_83ba4dad)) {
        stopfx(localclientnum, self.var_83ba4dad);
    }
    if (isdefined(self.var_b0063e15)) {
        stopfx(localclientnum, self.var_b0063e15);
    }
    if (!isdefined(level.var_114bbd15)) {
        level.var_114bbd15 = 0;
    }
    switch (newval) {
    case 1:
        self.var_b0063e15 = playfxontag(localclientnum, level._effect["shadowman_shield_glow_off"], self, "tag_origin");
        if (level.var_114bbd15 != 1) {
            self playsound(0, "zmb_finalfight_shadowman_shield_down");
            self.var_af44f4d3 = self playloopsound("zmb_finalfight_shadowman_shield_down_lp", 2);
            level.var_114bbd15 = 1;
        }
        break;
    case 2:
        if (level.var_114bbd15 != 2) {
            self playsound(0, "zmb_finalfight_shadowman_shield_up");
            self.var_af44f4d3 = self playloopsound("zmb_finalfight_shadowman_shield_up_lp", 2);
            level.var_114bbd15 = 2;
        }
        self.var_83ba4dad = playfxontag(localclientnum, level._effect["boss_shield"], self, "j_spineupper");
        setfxignorepause(localclientnum, self.var_83ba4dad, 1);
        self.var_b0063e15 = playfxontag(localclientnum, level._effect["shadowman_shield_glow_on"], self, "tag_origin");
        break;
    }
}

// Namespace zm_genesis_boss
// Params 7, eflags: 0x0
// Checksum 0x9d9e9a45, Offset: 0xa68
// Size: 0x50e
function sophia_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level notify(#"sophia_state");
    level endon(#"sophia_state");
    function_eec997a(localclientnum);
    level.var_f0444f1b[localclientnum] util::waittill_dobj(localclientnum);
    var_b19b9bc4 = struct::get("boss_sophia_hover", "targetname");
    var_76fc2b6f = struct::get("boss_sophia_ground", "targetname");
    switch (newval) {
    case 0:
        level.var_f0444f1b[localclientnum] hide();
        break;
    case 1:
        level.var_f0444f1b[localclientnum] setmodel("p7_zm_gen_dark_arena_sphere_metal");
        level.var_f0444f1b[localclientnum].origin = var_b19b9bc4.origin;
        level.var_f0444f1b[localclientnum] show();
        level.var_f0444f1b[localclientnum] thread animation::play("ai_zm_dlc4_sophia_idle_loop");
        level.var_f0444f1b[localclientnum] playsound(0, "zmb_finafight_sophia_materialize");
        level.var_f0444f1b[localclientnum].var_5ad6cc0c = level.var_f0444f1b[localclientnum] playloopsound("zmb_finafight_sophia_materialized_lp", 2);
        break;
    case 2:
        level.var_f0444f1b[localclientnum] setmodel("p7_zm_gen_dark_arena_sphere");
        level.var_f0444f1b[localclientnum].origin = var_b19b9bc4.origin;
        level.var_f0444f1b[localclientnum] show();
        level.var_f0444f1b[localclientnum] playsound(0, "zmb_finafight_sophia_downed");
        level.var_f0444f1b[localclientnum].var_5ad6cc0c = level.var_f0444f1b[localclientnum] playloopsound("zmb_finafight_sophia_ghost_lp", 2);
        level.var_f0444f1b[localclientnum] animation::play("ai_zm_dlc4_sophia_down");
        level.var_f0444f1b[localclientnum] thread animation::play("ai_zm_dlc4_sophia_down_idle");
        break;
    case 3:
        level.var_f0444f1b[localclientnum] thread sophia_transition_fx(localclientnum);
        level.var_f0444f1b[localclientnum] setmodel("p7_zm_gen_dark_arena_sphere_metal");
        level.var_f0444f1b[localclientnum].origin = var_b19b9bc4.origin;
        level.var_f0444f1b[localclientnum] show();
        level.var_f0444f1b[localclientnum] playsound(0, "zmb_finafight_sophia_powerup");
        level.var_f0444f1b[localclientnum].var_5ad6cc0c = level.var_f0444f1b[localclientnum] playloopsound("zmb_finafight_sophia_materialized_lp", 2);
        level.var_f0444f1b[localclientnum] thread function_24b59946(localclientnum);
        level.var_f0444f1b[localclientnum] animation::play("ai_zm_dlc4_sophia_attack");
        level.var_f0444f1b[localclientnum] thread animation::play("ai_zm_dlc4_sophia_idle_loop");
        break;
    }
}

// Namespace zm_genesis_boss
// Params 1, eflags: 0x0
// Checksum 0xc446d7ba, Offset: 0xf80
// Size: 0x74
function sophia_transition_fx(localclientnum) {
    var_c6f38611 = playfxontag(localclientnum, level._effect["sophia_transition"], self, "tag_origin");
    wait 1.8;
    if (isdefined(var_c6f38611)) {
        deletefx(localclientnum, var_c6f38611, 0);
    }
}

// Namespace zm_genesis_boss
// Params 1, eflags: 0x0
// Checksum 0x95bbebf7, Offset: 0x1000
// Size: 0x184
function function_24b59946(localclientnum) {
    s_loc = struct::get("boss_shadowman_4");
    var_f929ecf4 = util::spawn_model(localclientnum, "tag_origin", s_loc.origin + (0, 0, 54));
    level beam::launch(self, "tag_beam", var_f929ecf4, "tag_origin", "dlc4_skull_turret_beam");
    self playsound(0, "zmb_finafight_sophia_laser_start");
    self.var_36ffe62d = self playloopsound("zmb_finafight_sophia_laser_lp", 0.25);
    wait 2;
    self playsound(0, "zmb_finafight_sophia_laser_end");
    self stoploopsound(self.var_36ffe62d);
    level beam::kill(self, "tag_beam", var_f929ecf4, "tag_origin", "dlc4_skull_turret_beam");
    var_f929ecf4 delete();
}

// Namespace zm_genesis_boss
// Params 7, eflags: 0x0
// Checksum 0xc117e575, Offset: 0x1190
// Size: 0x26c
function boss_beam_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        s_start = struct::get("ee_book_arena", "targetname");
        level.var_7e52585c = util::spawn_model(localclientnum, "tag_origin", s_start.origin);
        s_end = struct::get("boss_shadowman_4_12");
        level.var_f929ecf4 = util::spawn_model(localclientnum, "tag_origin", s_end.origin);
        level.var_7e52585c playsound(0, "zmb_finafight_book_laser_start");
        level.var_7e52585c.var_36ffe62d = level.var_7e52585c playloopsound("zmb_finafight_book_laser_lp", 0.25);
        level beam::launch(level.var_7e52585c, "tag_origin", level.var_f929ecf4, "tag_origin", "dlc4_skull_turret_beam");
        return;
    }
    if (isdefined(level.var_7e52585c) && isdefined(level.var_f929ecf4)) {
        level.var_7e52585c playsound(0, "zmb_finafight_book_laser_end");
        level.var_7e52585c stoploopsound(level.var_7e52585c.var_36ffe62d);
        level beam::kill(level.var_7e52585c, "tag_beam", level.var_f929ecf4, "tag_origin", "dlc4_skull_turret_beam");
        level.var_7e52585c delete();
        level.var_f929ecf4 delete();
    }
}

// Namespace zm_genesis_boss
// Params 1, eflags: 0x0
// Checksum 0x4d9719b2, Offset: 0x1408
// Size: 0x120
function function_eec997a(localclientnum) {
    s_loc = struct::get("boss_sophia_hover", "targetname");
    if (!isdefined(level.var_f0444f1b)) {
        level.var_f0444f1b = [];
    }
    if (!isdefined(level.var_f0444f1b[localclientnum])) {
        level.var_f0444f1b[localclientnum] = spawn(localclientnum, s_loc.origin, "script_model");
        level.var_f0444f1b[localclientnum].angles = s_loc.angles;
        level.var_f0444f1b[localclientnum] setmodel("p7_zm_gen_dark_arena_sphere");
        level.var_f0444f1b[localclientnum] useanimtree(#zm_genesis);
    }
    return level.var_f0444f1b[localclientnum];
}

// Namespace zm_genesis_boss
// Params 2, eflags: 0x0
// Checksum 0x1ee5d344, Offset: 0x1530
// Size: 0x3c
function function_f9eb885e(localclientnum, var_55518655) {
    if (isdefined(var_55518655)) {
        stopfx(localclientnum, var_55518655);
    }
}

