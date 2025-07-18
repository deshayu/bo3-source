#using scripts/codescripts/struct;
#using scripts/shared/animation_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#using_animtree("generic");

#namespace zm_zod_portals;

// Namespace zm_zod_portals
// Params 0, eflags: 0x2
// Checksum 0xdf0b9bb6, Offset: 0x6c8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_zod_portals", &__init__, undefined, undefined);
}

// Namespace zm_zod_portals
// Params 0, eflags: 0x0
// Checksum 0x82d2d98f, Offset: 0x708
// Size: 0x424
function __init__() {
    visionset_mgr::register_overlay_info_style_transported("zm_zod", 1, 15, 2);
    level._effect["portal_shortcut_closed"] = "zombie/fx_quest_portal_tear_zod_zmb";
    level._effect["portal_shortcut_open_border"] = "zombie/fx_quest_portal_edge_zod_zmb";
    level._effect["portal_shortcut_ambient"] = "zombie/fx_quest_portal_ambient_zod_zmb";
    level._effect["portal_shortcut_pulse"] = "zombie/fx_quest_portal_edge_flash_zod_zmb";
    level._effect["portal_shortcut_opening"] = "zombie/fx_quest_portal_expand_zod_zmb";
    level._effect["portal_shortcut_closed_base"] = "zombie/fx_quest_portal_closed_zod_zmb";
    level._effect["portal_shortcut_ending"] = "zombie/fx_quest_portal_close_igc_zod_zmb";
    n_bits = getminbitcountfornum(3);
    clientfield::register("toplayer", "player_stargate_fx", 1, 1, "int", &player_stargate_fx, 0, 0);
    clientfield::register("world", "portal_state_canal", 1, n_bits, "int", &portal_state_canal, 0, 1);
    clientfield::register("world", "portal_state_slums", 1, n_bits, "int", &portal_state_slums, 0, 1);
    clientfield::register("world", "portal_state_theater", 1, n_bits, "int", &portal_state_theater, 0, 1);
    clientfield::register("world", "portal_state_ending", 1, 1, "int", &portal_state_ending, 0, 0);
    clientfield::register("world", "pulse_canal_portal_top", 1, 1, "counter", &function_4bc7c0a1, 0, 0);
    clientfield::register("world", "pulse_canal_portal_bottom", 1, 1, "counter", &function_bd6fa919, 0, 0);
    clientfield::register("world", "pulse_slums_portal_top", 1, 1, "counter", &function_e66eb44e, 0, 0);
    clientfield::register("world", "pulse_slums_portal_bottom", 1, 1, "counter", &function_9be42b84, 0, 0);
    clientfield::register("world", "pulse_theater_portal_top", 1, 1, "counter", &function_7acc82f, 0, 0);
    clientfield::register("world", "pulse_theater_portal_bottom", 1, 1, "counter", &function_8fbd3c13, 0, 0);
}

// Namespace zm_zod_portals
// Params 7, eflags: 0x0
// Checksum 0x584e3d2f, Offset: 0xb38
// Size: 0xde
function player_stargate_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"player_stargate_fx");
    self endon(#"player_stargate_fx");
    if (newval == 1) {
        if (isdemoplaying() && demoisanyfreemovecamera()) {
            return;
        }
        self thread function_e7a8756e(localclientnum);
        self thread postfx::playpostfxbundle("pstfx_zm_wormhole");
        return;
    }
    self notify(#"player_portal_complete");
}

// Namespace zm_zod_portals
// Params 1, eflags: 0x0
// Checksum 0x13ca61a2, Offset: 0xc20
// Size: 0x4c
function function_e7a8756e(localclientnum) {
    self util::waittill_any("player_stargate_fx", "player_portal_complete");
    self postfx::exitpostfxbundle();
}

// Namespace zm_zod_portals
// Params 7, eflags: 0x0
// Checksum 0x3b5ec4ad, Offset: 0xc78
// Size: 0xac
function portal_3p(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    if (newval == 1) {
        self.var_e4e89382 = playfxontag(localclientnum, level._effect["portal_3p"], self, "j_spineupper");
        return;
    }
    function_f9eb885e(localclientnum, self.var_e4e89382);
}

// Namespace zm_zod_portals
// Params 7, eflags: 0x0
// Checksum 0x4b357997, Offset: 0xd30
// Size: 0x5c
function portal_state_canal(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_35d5bf67(localclientnum, "canal", newval);
}

// Namespace zm_zod_portals
// Params 7, eflags: 0x0
// Checksum 0x8244dd64, Offset: 0xd98
// Size: 0x5c
function portal_state_slums(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_35d5bf67(localclientnum, "slums", newval);
}

// Namespace zm_zod_portals
// Params 7, eflags: 0x0
// Checksum 0xb3b5ef43, Offset: 0xe00
// Size: 0x5c
function portal_state_theater(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_35d5bf67(localclientnum, "theater", newval);
}

// Namespace zm_zod_portals
// Params 3, eflags: 0x0
// Checksum 0x241e96ef, Offset: 0xe68
// Size: 0x2ae
function function_35d5bf67(localclientnum, var_d42f02cf, newval) {
    var_eed93042 = function_227344a6("teleport_effect_origin", var_d42f02cf, 1);
    var_2a948ed5 = function_227344a6("teleport_effect_origin", var_d42f02cf, 0);
    switch (newval) {
    case 0:
        level thread function_c0c1771a(localclientnum, var_eed93042, 0, 0);
        level thread function_c0c1771a(localclientnum, var_2a948ed5, 0, 1);
        level thread function_a2d0d0e4(var_eed93042.origin, var_2a948ed5.origin, "amb_teleporter_off_lp", "amb_teleporter_on_lp");
        exploder::stop_exploder("lgt_portal_" + var_d42f02cf);
        break;
    case 1:
        level thread function_c0c1771a(localclientnum, var_eed93042, 1, 0);
        level thread function_c0c1771a(localclientnum, var_2a948ed5, 1, 1);
        level thread function_a2d0d0e4(var_eed93042.origin, var_2a948ed5.origin, "amb_teleporter_on_lp", "amb_teleporter_off_lp", "amb_teleporter_activate");
        exploder::exploder("lgt_portal_" + var_d42f02cf);
        break;
    case 2:
        level thread function_c0c1771a(localclientnum, var_eed93042, 1, 0);
        level thread function_c0c1771a(localclientnum, var_2a948ed5, 1, 1);
        level thread function_a2d0d0e4(var_eed93042.origin, var_2a948ed5.origin, "amb_teleporter_on_lp", "amb_teleporter_off_lp", "amb_teleporter_activate");
        exploder::exploder("lgt_portal_" + var_d42f02cf);
        break;
    }
}

// Namespace zm_zod_portals
// Params 7, eflags: 0x0
// Checksum 0x5665c2d9, Offset: 0x1120
// Size: 0x334
function portal_state_ending(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    s_loc = struct::get("ending_igc_portal", "targetname");
    v_fwd = anglestoforward(s_loc.angles);
    if (newval) {
        level.var_92f13ff4 = spawn(localclientnum, s_loc.origin, "script_model");
        level.var_92f13ff4.angles = s_loc.angles;
        level.var_92f13ff4 setmodel("p7_zm_zod_keeper_portal_01");
        level.var_120797a1 = [];
        for (i = 1; i < 25; i++) {
            fx_id = playfxontag(localclientnum, level._effect["portal_shortcut_open_border"], level.var_92f13ff4, "tag_fx_ring_" + i);
            if (!isdefined(level.var_120797a1)) {
                level.var_120797a1 = [];
            } else if (!isarray(level.var_120797a1)) {
                level.var_120797a1 = array(level.var_120797a1);
            }
            level.var_120797a1[level.var_120797a1.size] = fx_id;
        }
        level thread function_c968dcbc(s_loc.origin, "zmb_teleporter_igc_lp", "zmb_teleporter_igc_start", 1);
        return;
    }
    foreach (fx_id in level.var_120797a1) {
        stopfx(localclientnum, fx_id);
    }
    playfx(localclientnum, level._effect["portal_shortcut_ending"], s_loc.origin, v_fwd);
    level.var_92f13ff4 delete();
    level thread function_c968dcbc(s_loc.origin, "zmb_teleporter_igc_lp", "zmb_teleporter_igc_end");
}

// Namespace zm_zod_portals
// Params 7, eflags: 0x0
// Checksum 0x7c78ef5c, Offset: 0x1460
// Size: 0x5c
function function_4bc7c0a1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_11ac3c33(localclientnum, "canal", 1);
}

// Namespace zm_zod_portals
// Params 7, eflags: 0x0
// Checksum 0xede0996a, Offset: 0x14c8
// Size: 0x5c
function function_bd6fa919(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_11ac3c33(localclientnum, "canal", 0);
}

// Namespace zm_zod_portals
// Params 7, eflags: 0x0
// Checksum 0x6366097d, Offset: 0x1530
// Size: 0x5c
function function_e66eb44e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_11ac3c33(localclientnum, "slums", 1);
}

// Namespace zm_zod_portals
// Params 7, eflags: 0x0
// Checksum 0x6fff9f4f, Offset: 0x1598
// Size: 0x5c
function function_9be42b84(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_11ac3c33(localclientnum, "slums", 0);
}

// Namespace zm_zod_portals
// Params 7, eflags: 0x0
// Checksum 0x2db0b5a, Offset: 0x1600
// Size: 0x5c
function function_7acc82f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_11ac3c33(localclientnum, "theater", 1);
}

// Namespace zm_zod_portals
// Params 7, eflags: 0x0
// Checksum 0x62b501c8, Offset: 0x1668
// Size: 0x5c
function function_8fbd3c13(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_11ac3c33(localclientnum, "theater", 0);
}

// Namespace zm_zod_portals
// Params 3, eflags: 0x0
// Checksum 0xe0374e4e, Offset: 0x16d0
// Size: 0xe6
function function_11ac3c33(localclientnum, var_d42f02cf, var_a5e295bc) {
    s_loc = function_227344a6("teleport_effect_origin", var_d42f02cf, var_a5e295bc);
    mdl_portal = function_86743484(localclientnum, s_loc);
    for (i = 1; i < 25; i++) {
        if (i % 5 === 0) {
            playfxontag(localclientnum, level._effect["portal_shortcut_pulse"], mdl_portal, "tag_fx_ring_" + i);
        }
    }
}

// Namespace zm_zod_portals
// Params 4, eflags: 0x0
// Checksum 0x86ad7e6d, Offset: 0x17c0
// Size: 0x3c6
function function_c0c1771a(localclientnum, s_loc, b_open, var_9c9cfb54) {
    if (!isdefined(var_9c9cfb54)) {
        var_9c9cfb54 = 0;
    }
    v_fwd = anglestoforward(s_loc.angles);
    if (!isdefined(s_loc.var_7c0ed442)) {
        s_loc.var_7c0ed442 = [];
    }
    if (!isdefined(s_loc.var_20dc3b64)) {
        s_loc.var_20dc3b64 = [];
    }
    if (!isdefined(s_loc.var_1db71ac6)) {
        s_loc.var_1db71ac6 = [];
    }
    function_f9eb885e(localclientnum, s_loc.var_7c0ed442[localclientnum]);
    function_f9eb885e(localclientnum, s_loc.var_20dc3b64[localclientnum]);
    if (isdefined(b_open) && b_open) {
        s_loc.var_1db71ac6[localclientnum] = playfx(localclientnum, level._effect["portal_shortcut_opening"], s_loc.origin, v_fwd);
    }
    mdl_portal = function_86743484(localclientnum, s_loc);
    mdl_portal hidepart(localclientnum, "tag_portal_open");
    if (b_open) {
        wait 1.3;
        mdl_portal showpart(localclientnum, "tag_portal_open");
        for (i = 1; i < 25; i++) {
            playfxontag(localclientnum, level._effect["portal_shortcut_open_border"], mdl_portal, "tag_fx_ring_" + i);
        }
    } else {
        mdl_portal hidepart(localclientnum, "tag_portal_open");
    }
    function_f9eb885e(localclientnum, s_loc.var_1db71ac6[localclientnum]);
    if (isdefined(b_open) && b_open) {
        s_loc.var_7c0ed442[localclientnum] = playfx(localclientnum, level._effect["portal_shortcut_ambient"], s_loc.origin, v_fwd);
        return;
    }
    if (var_9c9cfb54) {
        s_loc.var_20dc3b64[localclientnum] = playfx(localclientnum, level._effect["portal_shortcut_closed_base"], s_loc.origin - (0, 0, 48), v_fwd);
        return;
    }
    s_loc.var_7c0ed442[localclientnum] = playfx(localclientnum, level._effect["portal_shortcut_closed"], s_loc.origin, v_fwd);
}

// Namespace zm_zod_portals
// Params 2, eflags: 0x0
// Checksum 0xaf1f3b38, Offset: 0x1b90
// Size: 0x24e
function function_86743484(localclientnum, s_loc) {
    if (!isdefined(level.var_ef51ee6d)) {
        level.var_ef51ee6d = [];
    }
    if (!isdefined(level.var_ef51ee6d[localclientnum])) {
        level.var_ef51ee6d[localclientnum] = [];
    }
    str_name = s_loc.script_noteworthy;
    if (isdefined(level.var_ef51ee6d[localclientnum][str_name])) {
        return level.var_ef51ee6d[localclientnum][str_name].mdl_portal;
    }
    level.var_ef51ee6d[localclientnum][str_name] = spawnstruct();
    level.var_ef51ee6d[localclientnum][str_name].mdl_portal = spawn(localclientnum, s_loc.origin, "script_model");
    level.var_ef51ee6d[localclientnum][str_name].mdl_portal.angles = s_loc.angles;
    level.var_ef51ee6d[localclientnum][str_name].mdl_portal setmodel("p7_zm_zod_keeper_portal_01");
    level.var_ef51ee6d[localclientnum][str_name].mdl_base = spawn(localclientnum, s_loc.origin - (0, 0, 48), "script_model");
    level.var_ef51ee6d[localclientnum][str_name].mdl_base.angles = s_loc.angles;
    level.var_ef51ee6d[localclientnum][str_name].mdl_base setmodel("p7_zm_zod_keeper_portal_base");
    return level.var_ef51ee6d[localclientnum][str_name].mdl_portal;
}

// Namespace zm_zod_portals
// Params 3, eflags: 0x0
// Checksum 0x904fdaef, Offset: 0x1de8
// Size: 0x13c
function function_227344a6(str_targetname, var_d42f02cf, var_a5e295bc) {
    var_3842f06d = struct::get_array(str_targetname, "targetname");
    var_216e113e = undefined;
    var_a889df54 = undefined;
    if (isdefined(var_a5e295bc) && var_a5e295bc) {
        var_a889df54 = "top";
    } else {
        var_a889df54 = "bottom";
    }
    foreach (s_portal_loc in var_3842f06d) {
        if (s_portal_loc.script_noteworthy === var_d42f02cf + "_portal_" + var_a889df54) {
            var_216e113e = s_portal_loc;
        }
    }
    return var_216e113e;
}

// Namespace zm_zod_portals
// Params 2, eflags: 0x0
// Checksum 0xf0426a88, Offset: 0x1f30
// Size: 0x3c
function function_f9eb885e(localclientnum, var_55518655) {
    if (isdefined(var_55518655)) {
        stopfx(localclientnum, var_55518655);
    }
}

// Namespace zm_zod_portals
// Params 5, eflags: 0x0
// Checksum 0x703bcbc, Offset: 0x1f78
// Size: 0xe4
function function_a2d0d0e4(origin1, origin2, var_4358f968, var_2978dbc6, activation) {
    audio::playloopat(var_4358f968, origin1);
    audio::stoploopat(var_2978dbc6, origin1);
    if (isdefined(activation)) {
        playsound(0, activation, origin1);
    }
    wait 0.05;
    audio::playloopat(var_4358f968, origin2);
    audio::stoploopat(var_2978dbc6, origin2);
    if (isdefined(activation)) {
        playsound(0, activation, origin2);
    }
}

// Namespace zm_zod_portals
// Params 4, eflags: 0x0
// Checksum 0xde250584, Offset: 0x2068
// Size: 0xa4
function function_c968dcbc(origin1, var_4358f968, oneshot, activate) {
    if (!isdefined(activate)) {
        activate = 0;
    }
    if (isdefined(activate) && activate) {
        audio::playloopat(var_4358f968, origin1);
    } else {
        audio::stoploopat(var_4358f968, origin1);
    }
    playsound(0, oneshot, origin1);
}

