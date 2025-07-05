#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_eye_candy;

// Namespace zm_bgb_eye_candy
// Params 0, eflags: 0x2
// Checksum 0xa8463548, Offset: 0x300
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_bgb_eye_candy", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_eye_candy
// Params 0, eflags: 0x0
// Checksum 0xfd7be37, Offset: 0x340
// Size: 0x3fc
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_eye_candy", "activated", 5, undefined, undefined, &validation, &activation);
    if (!isdefined(level.var_36ca82ce)) {
        level.var_36ca82ce = 113;
    }
    visionset_mgr::register_info("visionset", "zm_bgb_eye_candy_vs_1", 21000, level.var_36ca82ce, 31, 1);
    if (!isdefined(level.var_b23820a6)) {
        level.var_b23820a6 = 113;
    }
    visionset_mgr::register_info("overlay", "zm_bgb_eye_candy_vs_1", 21000, level.var_b23820a6, 1, 1);
    if (!isdefined(level.var_10c80865)) {
        level.var_10c80865 = 114;
    }
    visionset_mgr::register_info("visionset", "zm_bgb_eye_candy_vs_2", 21000, level.var_10c80865, 31, 1);
    if (!isdefined(level.var_8c35a63d)) {
        level.var_8c35a63d = 114;
    }
    visionset_mgr::register_info("overlay", "zm_bgb_eye_candy_vs_2", 21000, level.var_8c35a63d, 1, 1);
    if (!isdefined(level.var_eac58dfc)) {
        level.var_eac58dfc = 115;
    }
    visionset_mgr::register_info("visionset", "zm_bgb_eye_candy_vs_3", 21000, level.var_eac58dfc, 31, 1);
    if (!isdefined(level.var_66332bd4)) {
        level.var_66332bd4 = 115;
    }
    visionset_mgr::register_info("overlay", "zm_bgb_eye_candy_vs_3", 21000, level.var_66332bd4, 1, 1);
    if (!isdefined(level.var_c4c31393)) {
        level.var_c4c31393 = 116;
    }
    visionset_mgr::register_info("visionset", "zm_bgb_eye_candy_vs_4", 21000, level.var_c4c31393, 31, 1);
    if (!isdefined(level.var_4030b16b)) {
        level.var_4030b16b = 116;
    }
    visionset_mgr::register_info("overlay", "zm_bgb_eye_candy_vs_4", 21000, level.var_4030b16b, 1, 1);
    level.var_29cebda6 = array("zm_bgb_eye_candy_vs_1", "zm_bgb_eye_candy_vs_2", "zm_bgb_eye_candy_vs_3", "zm_bgb_eye_candy_vs_4");
    n_bits = getminbitcountfornum(5);
    clientfield::register("toplayer", "eye_candy_render", 21000, n_bits, "int");
    clientfield::register("actor", "eye_candy_active", 21000, 1, "int");
    clientfield::register("vehicle", "eye_candy_active", 21000, 1, "int");
    spawner::add_global_spawn_function("axis", &function_b390826f);
}

// Namespace zm_bgb_eye_candy
// Params 0, eflags: 0x0
// Checksum 0x3b229375, Offset: 0x748
// Size: 0x34
function validation() {
    return !(isdefined(self bgb::get_active()) && self bgb::get_active());
}

// Namespace zm_bgb_eye_candy
// Params 0, eflags: 0x0
// Checksum 0xc12d5e34, Offset: 0x788
// Size: 0x1ec
function activation() {
    self endon(#"disconnect");
    if (!isdefined(self.var_e20073c4)) {
        self.var_e20073c4 = 0;
        self.var_29cebda6 = arraycopy(level.var_29cebda6);
        self.var_29cebda6 = array::randomize(self.var_29cebda6);
    } else {
        wait 0.05;
        self.var_e20073c4++;
    }
    self notify(#"bgb_eye_candy_activation");
    if (self.var_e20073c4 >= 4) {
        return;
    }
    self playsoundtoplayer("zmb_bgb_eyecandy_" + self.var_e20073c4, self);
    visionset_mgr::activate("visionset", self.var_29cebda6[self.var_e20073c4], self);
    visionset_mgr::activate("overlay", self.var_29cebda6[self.var_e20073c4], self);
    var_78f89ecc = 0;
    switch (self.var_29cebda6[self.var_e20073c4]) {
    case "zm_bgb_eye_candy_vs_1":
        var_78f89ecc = 1;
        break;
    case "zm_bgb_eye_candy_vs_2":
        var_78f89ecc = 2;
        break;
    case "zm_bgb_eye_candy_vs_3":
        var_78f89ecc = 3;
        break;
    case "zm_bgb_eye_candy_vs_4":
        var_78f89ecc = 4;
        break;
    }
    self thread clientfield::set_to_player("eye_candy_render", var_78f89ecc);
    self thread function_48adddeb(self.var_29cebda6[self.var_e20073c4]);
}

// Namespace zm_bgb_eye_candy
// Params 1, eflags: 0x0
// Checksum 0xb6f58f6f, Offset: 0x980
// Size: 0x124
function function_48adddeb(str_vision) {
    str_return = self util::waittill_any_return("bgb_eye_candy_activation", "end_game", "bgb_gumball_anim_give", "disconnect", "bled_out");
    visionset_mgr::deactivate("visionset", str_vision, self);
    visionset_mgr::deactivate("overlay", str_vision, self);
    if (str_return !== "bgb_eye_candy_activation" || self.var_e20073c4 >= 4) {
        self playsoundtoplayer("zmb_bgb_eyecandy_deactivate", self);
        self.var_e20073c4 = undefined;
        self thread clientfield::set_to_player("eye_candy_render", 0);
        return;
    }
    if (self.var_e20073c4 == 3) {
        bgb::function_650ca64(6);
    }
}

// Namespace zm_bgb_eye_candy
// Params 0, eflags: 0x0
// Checksum 0xbdff86a5, Offset: 0xab0
// Size: 0x3c
function function_b390826f() {
    self clientfield::set("eye_candy_active", 1);
    self thread function_3b5b1f1e();
}

// Namespace zm_bgb_eye_candy
// Params 0, eflags: 0x0
// Checksum 0xf4f368b9, Offset: 0xaf8
// Size: 0x3c
function function_3b5b1f1e() {
    self endon(#"hash_67d0cc9f");
    self waittill(#"death");
    if (isdefined(self)) {
        self function_67d0cc9f();
    }
}

// Namespace zm_bgb_eye_candy
// Params 0, eflags: 0x0
// Checksum 0xeb50c618, Offset: 0xb40
// Size: 0x32
function function_67d0cc9f() {
    self clientfield::set("eye_candy_active", 0);
    self notify(#"hash_67d0cc9f");
}

