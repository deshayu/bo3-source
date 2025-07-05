#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/flagsys_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace squad_control;

// Namespace squad_control
// Params 0, eflags: 0x2
// Checksum 0x50e7ec9, Offset: 0x618
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("squad_control", &__init__, undefined, undefined);
}

// Namespace squad_control
// Params 0, eflags: 0x0
// Checksum 0xf4032903, Offset: 0x658
// Size: 0x39c
function __init__() {
    level.var_4895afd5 = [];
    for (i = 0; i < 4; i++) {
        str_name = "keyline_outline_p" + i;
        clientfield::register("actor", str_name, 1, 2, "int", &function_29cf4c66, 0, 0);
        clientfield::register("vehicle", str_name, 1, 2, "int", &function_29cf4c66, 0, 0);
        clientfield::register("scriptmover", str_name, 1, 3, "int", &function_29cf4c66, 0, 0);
        level.var_4895afd5[str_name] = i;
    }
    level._effect["squad_waypoint_base_client"] = "ui/fx_ui_flagbase_blue";
    level.var_e19a7b29 = [];
    for (i = 0; i < 4; i++) {
        str_name = "squad_indicator_p" + i;
        clientfield::register("actor", str_name, 1, 1, "int", &function_2636ef23, 0, 0);
        level.var_e19a7b29[str_name] = i;
    }
    duplicate_render::set_dr_filter_offscreen("sitrep_keyline_white", 25, "keyline_active_white", "keyfill_active_white", 2, "mc/hud_outline_model_z_white", 0);
    duplicate_render::set_dr_filter_offscreen("sitrep_keyline_red", 25, "keyline_active_red", "keyfill_active_red", 2, "mc/hud_outline_model_red", 0);
    duplicate_render::set_dr_filter_offscreen("sitrep_keyline_green", 25, "keyline_active_green", "keyfill_active_green", 2, "mc/hud_outline_model_green", 0);
    duplicate_render::set_dr_filter_offscreen("sitrep_keyline_white_through_walls", 25, "keyline_active_white_through_walls", "keyfill_active_white_through_walls", 2, "mc/hud_outline_model_white", 1);
    clientfield::register("actor", "robot_camo_shader", 1, 3, "int", &function_f532bd65, 0, 1);
    duplicate_render::set_dr_filter_framebuffer("camo_fr", 90, "gadget_camo_on,gadget_camo_friend", "gadget_camo_flicker,gadget_camo_break", 0, "mc/hud_outline_predator_camo_active_ally");
    duplicate_render::set_dr_filter_framebuffer("camo_fr_fl", 80, "gadget_camo_on,gadget_camo_flicker,gadget_camo_friend", "gadget_camo_break", 0, "mc/hud_outline_predator_camo_disruption_ally");
    duplicate_render::set_dr_filter_framebuffer("camo_brk", 70, "gadget_camo_on,gadget_camo_break", undefined, 0, "mc/hud_outline_predator_break");
}

// Namespace squad_control
// Params 7, eflags: 0x0
// Checksum 0x4eb77184, Offset: 0xa00
// Size: 0x27c
function function_29cf4c66(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    n_index = level.var_4895afd5[fieldname];
    e_player = getlocalplayer(localclientnum);
    if (!isdefined(e_player) || n_index != e_player getentitynumber()) {
        return;
    }
    assert(isdefined(self), "<dev string:x28>");
    level flagsys::wait_till("duplicaterender_registry_ready");
    assert(isdefined(self), "<dev string:x4e>");
    if (newval == 1) {
        self duplicate_render::change_dr_flags(localclientnum, "keyline_active_white", "keyfill_active_white");
        return;
    }
    if (newval == 2) {
        self duplicate_render::change_dr_flags(localclientnum, "keyline_active_red", "keyfill_active_red");
        return;
    }
    if (newval == 3) {
        self duplicate_render::change_dr_flags(localclientnum, "keyline_active_green", "keyfill_active_green");
        return;
    }
    if (newval == 4) {
        self duplicate_render::change_dr_flags(localclientnum, "keyline_active_white_through_walls", "keyfill_active_white_through_walls");
        return;
    }
    self duplicate_render::change_dr_flags(localclientnum, undefined, "keyline_active_white,keyfill_active_white");
    self duplicate_render::change_dr_flags(localclientnum, undefined, "keyline_active_red,keyfill_active_red");
    self duplicate_render::change_dr_flags(localclientnum, undefined, "keyline_active_green,keyfill_active_green");
    self duplicate_render::change_dr_flags(localclientnum, undefined, "keyline_active_white_through_walls,keyfill_active_white_through_walls");
}

// Namespace squad_control
// Params 7, eflags: 0x0
// Checksum 0x2c2f2c53, Offset: 0xc88
// Size: 0xcc
function function_f532bd65(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self duplicate_render::set_dr_flag("gadget_camo_flicker", newval == 2);
    self duplicate_render::set_dr_flag("gadget_camo_break", newval == 3);
    self duplicate_render::set_dr_flag("gadget_camo_on", newval != 0);
    self duplicate_render::change_dr_flags(local_client_num);
}

// Namespace squad_control
// Params 7, eflags: 0x0
// Checksum 0xc0dab579, Offset: 0xd60
// Size: 0xf4
function function_2636ef23(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    n_index = level.var_e19a7b29[fieldname];
    e_player = getlocalplayer(localclientnum);
    if (!isdefined(e_player) || n_index != e_player getentitynumber()) {
        return;
    }
    if (newval === 1) {
        self thread function_cffc9622(localclientnum);
        return;
    }
    if (newval === 0) {
        self thread function_50bf7fe9(localclientnum);
    }
}

// Namespace squad_control
// Params 1, eflags: 0x0
// Checksum 0xb5a6f6e3, Offset: 0xe60
// Size: 0xac
function function_cffc9622(localclientnum) {
    self.var_56f42b55 = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles + (-90, 0, 0));
    self.var_56f42b55 linkto(self);
    self.var_c8a562aa = playfxontag(localclientnum, level._effect["squad_waypoint_base_client"], self.var_56f42b55, "tag_origin");
}

// Namespace squad_control
// Params 1, eflags: 0x0
// Checksum 0xbcc6f4f8, Offset: 0xf18
// Size: 0x64
function function_50bf7fe9(localclientnum) {
    if (isdefined(self.var_c8a562aa)) {
        deletefx(localclientnum, self.var_c8a562aa, 1);
    }
    if (isdefined(self.var_56f42b55)) {
        self.var_56f42b55 delete();
    }
}

