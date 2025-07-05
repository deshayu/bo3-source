#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/zm/_zm_grappler;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/zm_genesis_flingers;
#using scripts/zm/zm_genesis_util;
#using scripts/zm/zm_genesis_vo;

#namespace namespace_3ddd867f;

// Namespace namespace_3ddd867f
// Params 0, eflags: 0x2
// Checksum 0x37fbbdd6, Offset: 0x5f8
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_genesis_pap_quest", &__init__, &__main__, undefined);
}

// Namespace namespace_3ddd867f
// Params 0, eflags: 0x0
// Checksum 0x761e948e, Offset: 0x640
// Size: 0x17c
function __init__() {
    level.var_e1ee8457 = 0;
    level.pack_a_punch.custom_power_think = &function_23a5b653;
    level.zombiemode_reusing_pack_a_punch = 1;
    scene::add_scene_func("p7_fxanim_zm_gen_apoth_pap_sac_arm_lft_bundle", &function_d2b266ee, "init");
    scene::add_scene_func("p7_fxanim_zm_gen_apoth_pap_sac_arm_cnt_bundle", &function_d2b266ee, "init");
    scene::add_scene_func("p7_fxanim_zm_gen_apoth_pap_sac_arm_rt_bundle", &function_d2b266ee, "init");
    scene::add_scene_func("p7_fxanim_zm_gen_apoth_pap_sac_bundle", &function_dc681bed, "init");
    level thread scene::init("p7_fxanim_zm_gen_apoth_pap_sac_arm_lft_bundle");
    level thread scene::init("p7_fxanim_zm_gen_apoth_pap_sac_arm_cnt_bundle");
    level thread scene::init("p7_fxanim_zm_gen_apoth_pap_sac_arm_rt_bundle");
    level thread scene::init("p7_fxanim_zm_gen_apoth_pap_sac_bundle");
}

// Namespace namespace_3ddd867f
// Params 0, eflags: 0x0
// Checksum 0xd1f43254, Offset: 0x7c8
// Size: 0x44
function __main__() {
    level flag::init("pap_power_on");
    level flag::init("apotho_pack_freed");
}

// Namespace namespace_3ddd867f
// Params 1, eflags: 0x0
// Checksum 0x27896673, Offset: 0x818
// Size: 0xec
function function_23a5b653(powered_on) {
    if (!powered_on) {
        self.zbarrier set_pap_zbarrier_state("initial");
        level flag::wait_till_all(array("power_on1", "power_on2", "power_on3", "power_on4"));
        self thread function_e488a6a8();
    }
    for (;;) {
        self.zbarrier set_pap_zbarrier_state("power_on");
        level waittill(#"pack_a_punch_off");
        self.zbarrier set_pap_zbarrier_state("power_off");
        level waittill(#"pack_a_punch_on");
    }
}

// Namespace namespace_3ddd867f
// Params 1, eflags: 0x0
// Checksum 0xc8327104, Offset: 0x910
// Size: 0x80
function set_pap_zbarrier_state(state) {
    for (i = 0; i < self getnumzbarrierpieces(); i++) {
        self hidezbarrierpiece(i);
    }
    self notify(#"zbarrier_state_change");
    self [[ level.pap_zbarrier_state_func ]](state);
}

// Namespace namespace_3ddd867f
// Params 0, eflags: 0x0
// Checksum 0x9b9675d9, Offset: 0x998
// Size: 0x54
function function_8d5c3682() {
    var_d1f5ed14 = getvehiclenodearray("pap_travel_spline", "targetname");
    array::thread_all(var_d1f5ed14, &function_21d887cd);
}

// Namespace namespace_3ddd867f
// Params 0, eflags: 0x0
// Checksum 0xf2dc44aa, Offset: 0x9f8
// Size: 0xd4
function function_21d887cd() {
    assert(ispointonnavmesh(self.origin), "<dev string:x28>" + self.origin + "<dev string:x48>");
    s_stub = level zm_genesis_util::function_d095318(self.origin, 256, undefined, &function_f8c1234b);
    while (true) {
        s_stub waittill(#"trigger", e_player);
        e_player thread function_4ab898f4(self);
        level.var_6fe80781 = gettime();
    }
}

// Namespace namespace_3ddd867f
// Params 1, eflags: 0x0
// Checksum 0x4c310d41, Offset: 0xad8
// Size: 0x12
function function_f8c1234b(e_player) {
    return "";
}

// Namespace namespace_3ddd867f
// Params 0, eflags: 0x0
// Checksum 0x853238e0, Offset: 0xaf8
// Size: 0x14c
function function_e8ef758e() {
    if (!isdefined(level.apothicon_grapple_source)) {
        level.apothicon_grapple_source = struct::get("apothicon_grapple_source");
    }
    if (!isdefined(level.apothicon_grapple_source)) {
        level.apothicon_grapple_source = spawnstruct();
        level.apothicon_grapple_source.origin = (1894, -438, -127);
        level.apothicon_grapple_source.angles = (0, 180, 0);
        level.apothicon_grapple_source.targetname = "apothicon_grapple_source";
    }
    if (isdefined(level.apothicon_grapple_source)) {
        e_player = self;
        e_player.grapple_tag = "j_spine4";
        if (!(isdefined(e_player.var_1533bb11) && e_player.var_1533bb11)) {
            e_player.var_1533bb11 = 1;
            zm_grappler::start_grapple(level.apothicon_grapple_source, e_player, 2, 3300);
            e_player.var_1533bb11 = 0;
        }
    }
}

// Namespace namespace_3ddd867f
// Params 1, eflags: 0x0
// Checksum 0x6288f18e, Offset: 0xc50
// Size: 0x5fc
function function_4ab898f4(nd_start) {
    self endon(#"death");
    if (isdefined(self.is_flung) && self.is_flung) {
        return;
    }
    self.is_flung = 1;
    self.var_a393601c = 1;
    self function_e8ef758e();
    self.b_invulnerable = self enableinvulnerability();
    self allowcrouch(0);
    self allowprone(0);
    self freezecontrols(1);
    self notsolid();
    if (self getstance() != "stand") {
        self setstance("stand");
        wait 1;
    }
    var_413ea50f = vehicle::spawn(undefined, "player_vehicle", "flinger_vehicle", nd_start.origin, nd_start.angles);
    var_116e109f = struct::get(nd_start.target);
    var_f28a4a19 = var_116e109f function_fc804fdd();
    self playerlinktodelta(var_413ea50f);
    self playrumbleonentity("zm_castle_flinger_launch");
    self clientfield::set_to_player("apothicon_entry_postfx", 1);
    self thread zm_genesis_flingers::function_c1f1756a();
    var_6a7beeb2 = zm_genesis_flingers::function_cbac68fe(self);
    var_6a7beeb2 linkto(var_413ea50f);
    w_current = self.currentweapon;
    var_f5434f17 = zm_utility::spawn_buildkit_weapon_model(self, w_current, undefined, var_6a7beeb2 gettagorigin("tag_weapon_right"), var_6a7beeb2 gettagangles("tag_weapon_right"));
    var_f5434f17 linkto(var_6a7beeb2, "tag_weapon_right");
    var_f5434f17 setowner(self);
    var_6a7beeb2 thread scene::play("cin_zm_dlc1_jump_pad_air_loop", var_6a7beeb2);
    var_6a7beeb2 clientfield::set("player_visibility", 1);
    var_f5434f17 clientfield::set("player_visibility", 1);
    self ghost();
    var_413ea50f setignorepauseworld(1);
    var_413ea50f vehicle::get_on_and_go_path(nd_start);
    while (positionwouldtelefrag(var_f28a4a19.origin)) {
        wait 0.05;
    }
    var_413ea50f vehicle::get_on_and_go_path(var_f28a4a19);
    self thread function_3298b25f();
    self thread zm_genesis_flingers::function_29c06608();
    self playrumbleonentity("zm_castle_flinger_land");
    self clientfield::set_to_player("apothicon_entry_postfx", 0);
    var_6a7beeb2 clientfield::set("player_visibility", 0);
    var_f5434f17 clientfield::set("player_visibility", 0);
    var_6a7beeb2 thread scene::stop("cin_zm_dlc1_jump_pad_air_loop");
    var_f5434f17 delete();
    self show();
    self solid();
    self thread zm_genesis_flingers::function_9f131b98();
    var_6a7beeb2 hide();
    util::wait_network_frame();
    var_6a7beeb2 delete();
    self thread function_10171438();
    self.is_flung = undefined;
    self thread function_2c36a1ea(var_413ea50f);
    wait 2;
    self allowcrouch(1);
    self allowprone(1);
    self freezecontrols(0);
}

// Namespace namespace_3ddd867f
// Params 1, eflags: 0x0
// Checksum 0xfb0d69ca, Offset: 0x1258
// Size: 0x64
function function_2c36a1ea(var_413ea50f) {
    while (true) {
        if (isdefined(self.var_3298b25f) && (!isdefined(self) || self.var_3298b25f)) {
            break;
        }
        util::wait_network_frame();
    }
    var_413ea50f delete();
}

// Namespace namespace_3ddd867f
// Params 0, eflags: 0x0
// Checksum 0x84510305, Offset: 0x12c8
// Size: 0x2c
function function_10171438() {
    self endon(#"death");
    self endon(#"disconnect");
    wait 3;
    self.var_a393601c = 0;
}

// Namespace namespace_3ddd867f
// Params 1, eflags: 0x0
// Checksum 0x9a878f7e, Offset: 0x1300
// Size: 0x104
function function_fc804fdd(var_16caea3d) {
    var_62a30970 = getvehiclenodearray(self.target, "targetname");
    foreach (nd_spline in var_62a30970) {
        if (nd_spline.script_noteworthy === var_16caea3d) {
            return nd_spline;
        }
    }
    assert(isdefined(nd_spline), "<dev string:x5c>" + var_16caea3d + "<dev string:x67>" + self.origin + "<dev string:x80>");
}

// Namespace namespace_3ddd867f
// Params 0, eflags: 0x0
// Checksum 0x2c909673, Offset: 0x1410
// Size: 0x168
function function_3298b25f() {
    self.var_3298b25f = 0;
    var_6b138e28 = groundtrace(self.origin, self.origin + (0, 0, -10000), 0, undefined)["position"];
    for (var_16f5c370 = var_6b138e28; positionwouldtelefrag(var_16f5c370) || !ispointonnavmesh(var_16f5c370); var_16f5c370 = var_6b138e28 + (randomfloatrange(-96, 96), randomfloatrange(-96, 96), 0)) {
        util::wait_network_frame();
    }
    self unlink();
    self setorigin(var_16f5c370);
    self clientfield::increment_to_player("flinger_land_smash");
    self thread zm_genesis_vo::function_e1bf753b();
    self.var_3298b25f = 1;
}

// Namespace namespace_3ddd867f
// Params 0, eflags: 0x0
// Checksum 0x983122dc, Offset: 0x1580
// Size: 0x1cc
function function_e488a6a8() {
    level flag::set("pap_power_on");
    level notify(#"pack_a_punch_on");
    self.origin += (0, 0, 500);
    self.clip.origin += (0, 0, 500);
    self.pap_machine.origin -= (0, 0, 500);
    for (var_9748d143 = 0; var_9748d143 < 3; var_9748d143++) {
        level waittill(#"hash_80f97945");
    }
    level scene::play("p7_fxanim_zm_gen_apoth_pap_sac_bundle");
    playsoundatposition("evt_pap_freed", (873, 110, -3239));
    self.pap_machine.origin += (0, 0, 500);
    level flag::set("apotho_pack_freed");
    self.origin -= (0, 0, 500);
    self.clip.origin -= (0, 0, 500);
}

// Namespace namespace_3ddd867f
// Params 1, eflags: 0x0
// Checksum 0xb9810e04, Offset: 0x1758
// Size: 0x1f4
function function_9278bc8a(var_181e2689) {
    self setcandamage(1);
    self.health = 6000;
    self.n_damage = 0;
    while (true) {
        self waittill(#"damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags);
        playfx(level._effect["pap_cord_impact"], point, (0, 0, -1));
        self.n_damage -= damage;
        self.health += damage;
        if (self.n_damage <= 1000) {
            playsoundatposition("evt_pap_cord_burst", self.origin);
            self setcandamage(0);
            break;
        }
    }
    level notify(#"hash_80f97945");
    if (isplayer(attacker)) {
        attacker thread zm_genesis_vo::function_57f3d77();
    }
    exploder::exploder("fxexp_" + 106 + var_181e2689);
    level thread scene::play(self.current_scene);
}

// Namespace namespace_3ddd867f
// Params 1, eflags: 0x0
// Checksum 0x5352fbbb, Offset: 0x1958
// Size: 0xe6
function function_d2b266ee(a_ents) {
    a_str_keys = getarraykeys(a_ents);
    str_key = a_str_keys[0];
    var_9f585353 = a_ents[str_key];
    switch (str_key) {
    case "pap_sac_lft_arm":
        var_9f585353 thread function_9278bc8a(1);
        break;
    case "pap_sac_cnt_arm":
        var_9f585353 thread function_9278bc8a(2);
        break;
    case "pap_sac_rt_arm":
        var_9f585353 thread function_9278bc8a(3);
        break;
    }
}

// Namespace namespace_3ddd867f
// Params 1, eflags: 0x0
// Checksum 0xb8151441, Offset: 0x1a48
// Size: 0x54
function function_dc681bed(a_ents) {
    mdl_pap = a_ents["pap_sac_vending"];
    level waittill(#"apotho_pack_freed");
    wait 0.2;
    mdl_pap delete();
}

