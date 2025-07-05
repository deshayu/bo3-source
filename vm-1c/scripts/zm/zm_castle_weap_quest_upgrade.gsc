#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_powerup_castle_demonic_rune;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_elemental_bow;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_castle_vo;
#using scripts/zm/zm_castle_weap_quest;

#namespace zm_castle_weap_quest_upgrade;

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x2
// Checksum 0xbf54efbd, Offset: 0x2948
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_castle_weap_quest_upgrade", &__init__, &__main__, undefined);
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xc3c7de1, Offset: 0x2990
// Size: 0xbb4
function __init__() {
    level.var_427e7668 = [];
    level._effect["rocket_side_blast"] = "fire/fx_fire_side_lrg";
    clientfield::register("scriptmover", "fossil_reveal", 5000, 2, "int");
    clientfield::register("scriptmover", "fossil_collect_fx", 5000, 1, "int");
    clientfield::register("scriptmover", "demonic_circle_reveal", 5000, 1, "int");
    clientfield::register("scriptmover", "init_demongate_fossil", 5000, 2, "int");
    clientfield::register("scriptmover", "urn_impact_fx", 5000, 1, "counter");
    clientfield::register("scriptmover", "demongate_fossil_frenzy", 5000, 1, "int");
    clientfield::register("scriptmover", "demongate_fossil_outro", 5000, 1, "int");
    clientfield::register("world", "demongate_client_cleanup", 5000, 1, "int");
    clientfield::register("scriptmover", "demongate_quest_portal", 5000, 1, "int");
    clientfield::register("toplayer", "demon_vo_release", 8000, 1, "counter");
    clientfield::register("toplayer", "demon_vo_return", 8000, 1, "counter");
    clientfield::register("toplayer", "demon_vo_souls", 8000, 1, "counter");
    clientfield::register("toplayer", "demon_vo_name", 8000, 1, "counter");
    clientfield::register("toplayer", "demon_vo_ask_name", 8000, 1, "counter");
    clientfield::register("toplayer", "demon_vo_name_correct", 8000, 1, "counter");
    clientfield::register("toplayer", "demon_vo_name_incorrect", 8000, 1, "counter");
    clientfield::register("toplayer", "demon_vo_door", 8000, 1, "counter");
    clientfield::register("toplayer", "demon_vo_horn", 8000, 1, "counter");
    clientfield::register("toplayer", "demon_vo_heart", 8000, 1, "counter");
    clientfield::register("toplayer", "demon_vo_griffon", 8000, 1, "counter");
    clientfield::register("toplayer", "demon_vo_crown", 8000, 1, "counter");
    clientfield::register("toplayer", "demon_vo_stag", 8000, 1, "counter");
    clientfield::register("scriptmover", "tower_break_fx", 5000, 1, "int");
    clientfield::register("scriptmover", "beacon_fx", 5000, 2, "int");
    clientfield::register("scriptmover", "wallrun_fx", 5000, 2, "int");
    clientfield::register("scriptmover", "battery_fx", 5000, 2, "int");
    clientfield::register("scriptmover", "lightning_fx", 5000, 1, "int");
    clientfield::register("scriptmover", "tornado_fx", 5000, 1, "int");
    clientfield::register("toplayer", "arrow_charge_fx", 5000, 1, "int");
    clientfield::register("world", "storm_variable_cleanup", 5000, 1, "int");
    clientfield::register("scriptmover", "obelisk_magma_reveal", 5000, 1, "int");
    clientfield::register("scriptmover", "obelisk_runes_reveal", 5000, 1, "int");
    clientfield::register("scriptmover", "obelisk_runes_drain", 5000, 1, "int");
    clientfield::register("scriptmover", "runic_circle_reveal", 5000, 1, "int");
    clientfield::register("scriptmover", "runic_circle_fx", 5000, 1, "int");
    clientfield::register("scriptmover", "runic_circle_death_fx", 5000, 1, "counter");
    clientfield::register("toplayer", "anchor_point_postfx", 5000, 1, "int");
    clientfield::register("world", "orb_sanim_cleanup", 5000, 1, "counter");
    clientfield::register("scriptmover", "painting_symbol_reveal", 5000, 1, "int");
    clientfield::register("scriptmover", "painting_symbol_blink", 5000, 1, "counter");
    clientfield::register("scriptmover", "wolf_howl_bone_fx", 5000, 1, "int");
    clientfield::register("actor", "wolf_trail_fx", 5000, 2, "int");
    clientfield::register("actor", "wolf_footprint_fx", 5000, 1, "int");
    clientfield::register("actor", "wolf_ghost_shader", 5000, 1, "int");
    clientfield::register("scriptmover", "zombie_soul_demon_fx", 5000, 1, "int");
    clientfield::register("scriptmover", "zombie_soul_rune_fx", 5000, 1, "int");
    clientfield::register("scriptmover", "zombie_soul_storm_fx", 5000, 1, "int");
    clientfield::register("scriptmover", "zombie_soul_wolf_fx", 5000, 1, "int");
    clientfield::register("scriptmover", "arrow_charge_wolf_fx", 5000, 1, "int");
    clientfield::register("world", "quest_state_demon", 5000, 3, "int");
    clientfield::register("world", "quest_state_rune", 5000, 3, "int");
    clientfield::register("world", "quest_state_storm", 5000, 3, "int");
    clientfield::register("world", "quest_state_wolf", 5000, 3, "int");
    clientfield::register("world", "quest_owner_demon", 5000, 3, "int");
    clientfield::register("world", "quest_owner_rune", 5000, 3, "int");
    clientfield::register("world", "quest_owner_storm", 5000, 3, "int");
    clientfield::register("world", "quest_owner_wolf", 5000, 3, "int");
    clientfield::register("clientuimodel", "zmInventory.widget_weap_quest_storm", 1, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.widget_weap_quest_rune", 1, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.widget_weap_quest_wolf", 1, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.widget_weap_quest_demon", 1, 1, "int");
    /#
        level thread function_952cba55();
    #/
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x91ecf4d0, Offset: 0x3550
// Size: 0x64
function __main__() {
    level thread rune_prison();
    level thread demon_gate();
    level thread wolf_howl();
    level thread elemental_storm();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x4
// Checksum 0x15d721bf, Offset: 0x35c0
// Size: 0x7c
function private function_8c52805(var_86a3391a) {
    self endon(#"disconnect");
    self thread clientfield::set_player_uimodel(var_86a3391a, 1);
    level util::function_183e3618(3.5, "widget_ui_override", self, "disconnect");
    self thread clientfield::set_player_uimodel(var_86a3391a, 0);
}

// Namespace zm_castle_weap_quest_upgrade
// Params 2, eflags: 0x4
// Checksum 0xde1c7fd3, Offset: 0x3648
// Size: 0x9c
function private function_f5e9876(var_1493eda1, var_a5fe74e4) {
    var_78cede1 = "quest_state_" + var_1493eda1;
    var_86a3391a = "zmInventory.widget_weap_quest_" + var_1493eda1;
    level clientfield::set(var_78cede1, var_a5fe74e4);
    level notify(#"widget_ui_override");
    array::thread_all(level.players, &function_8c52805, var_86a3391a);
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x7720f0c4, Offset: 0x36f0
// Size: 0x2f4
function rune_prison() {
    /#
        level flag::init("<dev string:x28>");
        level flag::init("<dev string:x3c>");
        level flag::init("<dev string:x50>");
        level flag::init("<dev string:x62>");
        level flag::init("<dev string:x73>");
        level flag::init("<dev string:x8b>");
        level flag::init("<dev string:xa1>");
        level flag::init("<dev string:xbc>");
    #/
    level function_e43ddafb();
    level function_29c80ce1();
    /#
        level flag::set("<dev string:x28>");
    #/
    level function_f5e9876("rune", 1);
    level rune_prison_obelisk();
    /#
        level flag::set("<dev string:x3c>");
    #/
    level function_f5e9876("rune", 2);
    level function_292ad7f1();
    /#
        level flag::set("<dev string:x50>");
    #/
    level function_f5e9876("rune", 3);
    level function_fd254a35();
    /#
        level flag::set("<dev string:x62>");
    #/
    level function_f5e9876("rune", 4);
    level rune_prison_magma_ball();
    /#
        level flag::set("<dev string:x73>");
    #/
    var_28eeb81a = struct::get("upgraded_bow_struct_rune_prison", "targetname");
    var_28eeb81a function_14dd5ea5();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x15082317, Offset: 0x39f0
// Size: 0x38c
function function_e43ddafb() {
    level flag::init("rune_prison_obelisk");
    level flag::init("rune_prison_obelisk_magma_enabled");
    level flag::init("rune_prison_magma_ball");
    level flag::init("rune_prison_golf");
    level flag::init("rune_prison_repaired");
    level flag::init("rune_prison_placed");
    level flag::init("rune_prison_upgraded");
    level flag::init("rune_prison_spawned");
    level scene::init("p7_fxanim_zm_castle_quest_rune_clock_wall_bundle");
    level scene::init("p7_fxanim_zm_castle_quest_rune_clock_bundle");
    var_9877e371 = getent("aq_rp_magma_ball_tag", "targetname");
    var_9877e371 flag::init("magma_ball_move_done");
    wait 0.05;
    var_94f11108 = getent("aq_rp_obelisk_top", "targetname");
    var_94f11108 clientfield::set("obelisk_magma_reveal", 1);
    var_8b1b34fc = getent("aq_rp_obelisk_reveal", "targetname");
    var_8b1b34fc clientfield::set("obelisk_runes_reveal", 1);
    var_ca72ca5f = getent("aq_rp_obelisk_drain", "targetname");
    var_ca72ca5f clientfield::set("obelisk_runes_drain", 1);
    var_42d1b62e = getentarray("aq_rp_runic_circle_symbol", "script_noteworthy");
    foreach (var_9c1f46d7 in var_42d1b62e) {
        var_9c1f46d7 clientfield::set("runic_circle_reveal", 0);
    }
    var_808f0823 = getentarray("aq_rp_clock_wheel_rune", "script_noteworthy");
    array::run_all(var_808f0823, &hide);
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x7723c058, Offset: 0x3d88
// Size: 0x1ba
function function_29c80ce1() {
    /#
        level endon(#"hash_c272bd2a");
        if (level flag::get("<dev string:x28>")) {
            return;
        }
    #/
    var_3c91152b = getent("aq_rp_clock_wall_trig", "targetname");
    while (true) {
        var_3c91152b waittill(#"damage", amount, attacker, direction, point, mod, tagname, modelname, partname, weapon);
        if (function_51a90202(weapon, 1, point, var_3c91152b)) {
            level.var_714fae39 = 1;
            playrumbleonposition("zm_castle_quest_rune_prison_clock_wall_rumble", point);
            level scene::play("p7_fxanim_zm_castle_quest_rune_clock_wall_bundle");
            level.var_2b11065e = getent("quest_rune_clock_wall_arrow", "targetname");
            s_arrow = struct::get("quest_start_rune_prison");
            s_arrow function_f708e6b2();
            return;
        }
    }
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0xd47ed924, Offset: 0x3f50
    // Size: 0x80
    function function_7a965585() {
        if (!isdefined(level.var_714fae39)) {
            level.var_714fae39 = 0;
        }
        if (level.var_714fae39) {
            level thread scene::init("<dev string:xcb>");
            level.var_714fae39 = 0;
            return;
        }
        level thread scene::play("<dev string:xcb>");
        level.var_714fae39 = 1;
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x2748d2b1, Offset: 0x3fd8
    // Size: 0x15c
    function function_c272bd2a() {
        if (level flag::get("<dev string:x28>")) {
            return;
        }
        level thread zm_castle_weap_quest::function_a01a53de();
        level.var_c62829c7 = level.players[0];
        level clientfield::set("<dev string:xfc>", function_85bfa3fd(level.var_c62829c7.characterindex));
        level.var_427e7668[level.var_427e7668.size] = level.players[0];
        if (!(isdefined(level.var_714fae39) && level.var_714fae39)) {
            level thread scene::play("<dev string:xcb>");
            level.var_714fae39 = 1;
        }
        level thread function_ab3e9362();
        s_arrow = struct::get("<dev string:x10d>");
        zm_unitrigger::unregister_unitrigger(s_arrow.var_67b5dd94);
        level flag::set("<dev string:x28>");
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x6858b24, Offset: 0x4140
    // Size: 0x4c
    function function_ab3e9362() {
        wait 8;
        level.var_2b11065e = getent("<dev string:x125>", "<dev string:x141>");
        level.var_2b11065e hide();
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x95b8112a, Offset: 0x4198
// Size: 0x254
function rune_prison_obelisk() {
    /#
        level endon(#"hash_6c9ecb6");
        if (level flag::get("<dev string:x3c>")) {
            return;
        }
    #/
    level thread function_d13d5192();
    var_b4df6e91 = getent("aq_rp_obelisk_magma_trig", "targetname");
    while (!level flag::get("rune_prison_obelisk")) {
        var_b4df6e91 waittill(#"damage", amount, attacker, direction, point, mod, tagname, modelname, partname, weapon);
        if (level flag::get("rune_prison_obelisk_magma_enabled") && function_51a90202(weapon, 1, point, var_b4df6e91) && attacker === level.var_c62829c7) {
            playrumbleonposition("zm_castle_quest_rune_prison_obelisk_rumble", point);
            level flag::set("rune_prison_obelisk");
        }
    }
    exploder::stop_exploder("fxexp_500");
    exploder::stop_exploder("fxexp_501");
    var_a717e964 = getentarray("aq_rp_obelisk", "script_noteworthy");
    array::run_all(var_a717e964, &delete);
    var_b4df6e91 delete();
    level thread function_bc213d43();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x5b8f7355, Offset: 0x43f8
// Size: 0x1f8
function function_d13d5192() {
    level endon(#"rune_prison_obelisk");
    var_94f11108 = getent("aq_rp_obelisk_top", "targetname");
    var_8b1b34fc = getent("aq_rp_obelisk_reveal", "targetname");
    var_ca72ca5f = getent("aq_rp_obelisk_drain", "targetname");
    while (true) {
        level flag::wait_till("rune_prison_obelisk_magma_enabled");
        var_94f11108 clientfield::set("obelisk_magma_reveal", 0);
        exploder::exploder("fxexp_500");
        wait 1;
        var_8b1b34fc clientfield::set("obelisk_runes_reveal", 0);
        exploder::exploder("fxexp_501");
        level flag::wait_till_clear("rune_prison_obelisk_magma_enabled");
        exploder::stop_exploder("fxexp_500");
        var_ca72ca5f clientfield::set("obelisk_runes_drain", 0);
        var_94f11108 clientfield::set("obelisk_magma_reveal", 1);
        wait 30;
        var_8b1b34fc clientfield::set("obelisk_runes_reveal", 1);
        var_ca72ca5f clientfield::set("obelisk_runes_drain", 1);
    }
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0xe5efa6e3, Offset: 0x45f8
    // Size: 0x21c
    function function_3d19bfe5() {
        level notify(#"hash_407883d6");
        level endon(#"hash_407883d6");
        level endon(#"rune_prison_obelisk");
        var_94f11108 = getent("<dev string:x14c>", "<dev string:x141>");
        var_8b1b34fc = getent("<dev string:x15e>", "<dev string:x141>");
        var_ca72ca5f = getent("<dev string:x173>", "<dev string:x141>");
        if (!isdefined(var_94f11108) || !isdefined(var_8b1b34fc) || !isdefined(var_ca72ca5f)) {
            return;
        }
        var_94f11108 clientfield::set("<dev string:x187>", 1);
        var_8b1b34fc clientfield::set("<dev string:x19c>", 1);
        var_ca72ca5f clientfield::set("<dev string:x1b1>", 1);
        wait 0.05;
        var_94f11108 clientfield::set("<dev string:x187>", 0);
        exploder::exploder("<dev string:x1c5>");
        wait 1;
        var_8b1b34fc clientfield::set("<dev string:x19c>", 0);
        exploder::exploder("<dev string:x1cf>");
        wait 7.5;
        exploder::stop_exploder("<dev string:x1c5>");
        var_ca72ca5f clientfield::set("<dev string:x1b1>", 0);
        var_94f11108 clientfield::set("<dev string:x187>", 1);
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x10618a6c, Offset: 0x4820
// Size: 0x7c
function function_bc213d43() {
    /#
        level.var_8162c08d = 1;
    #/
    level thread scene::play("p7_fxanim_zm_castle_quest_rune_orb_trail_bundle");
    level waittill(#"hash_e81f26f8");
    level scene::play("p7_fxanim_zm_castle_quest_rune_orb_bundle");
    level flag::set("rune_prison_magma_ball");
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0xe6fd52bb, Offset: 0x48a8
    // Size: 0x16c
    function function_d326a001() {
        var_a717e964 = getentarray("<dev string:x1d9>", "<dev string:x1e7>");
        foreach (var_dab58e04 in var_a717e964) {
            if (isdefined(var_dab58e04)) {
                var_dab58e04 delete();
            }
        }
        var_9877e371 = getent("<dev string:x1f9>", "<dev string:x141>");
        if (isdefined(var_9877e371)) {
            var_9877e371 moveto((-46, 1920, 1532), 0.5);
        }
        level scene::play("<dev string:x20e>");
        level scene::play("<dev string:x23e>");
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x31260f35, Offset: 0x4a20
    // Size: 0x21c
    function function_6c9ecb6() {
        if (level flag::get("<dev string:x3c>")) {
            return;
        }
        if (!level flag::get("<dev string:x28>")) {
            level function_c272bd2a();
        }
        level flag::set("<dev string:x268>");
        if (!(isdefined(level.var_8162c08d) && level.var_8162c08d)) {
            level scene::skipto_end("<dev string:x20e>");
            level thread scene::play("<dev string:x23e>");
        }
        level flag::set("<dev string:x27c>");
        level flag::set("<dev string:x3c>");
        var_a717e964 = getentarray("<dev string:x1d9>", "<dev string:x1e7>");
        foreach (var_dab58e04 in var_a717e964) {
            if (isdefined(var_dab58e04)) {
                var_dab58e04 delete();
            }
        }
        var_b4df6e91 = getent("<dev string:x293>", "<dev string:x141>");
        if (isdefined(var_b4df6e91)) {
            var_b4df6e91 delete();
        }
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x7105efcc, Offset: 0x4c48
// Size: 0x214
function function_292ad7f1() {
    /#
        level endon(#"hash_6de95813");
        if (level flag::get("<dev string:x50>")) {
            return;
        }
    #/
    level flag::wait_till("rune_prison_magma_ball");
    var_effd0eae = getentarray("aq_rp_runic_circle_volume", "script_noteworthy");
    foreach (var_6f4e5e57 in var_effd0eae) {
        /#
            if (level flag::get("<dev string:xa1>")) {
                break;
            }
        #/
        var_6f4e5e57 function_eca3cc8a();
        var_6f4e5e57 thread function_1d529530();
    }
    array::thread_all(var_effd0eae, &function_2ead3d64);
    level.var_bf08cf2d = &function_eba39b3c;
    level.var_c62829c7 thread function_8e83c9ed();
    array::flag_wait_any(var_effd0eae, "runic_circle_activated");
    zm_spawner::register_zombie_death_event_callback(&function_2da80856);
    array::wait_till(var_effd0eae, "runic_circle_charged");
    zm_spawner::deregister_zombie_death_event_callback(&function_2da80856);
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x6518172f, Offset: 0x4e68
// Size: 0x44
function function_eca3cc8a() {
    self flag::init("runic_circle_activated");
    self flag::init("runic_circle_charged");
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x5bb845e8, Offset: 0x4eb8
// Size: 0x1ec
function function_1d529530() {
    /#
        level endon(#"hash_6de95813");
        if (level flag::get("<dev string:xa1>")) {
            return;
        }
    #/
    var_9c1f46d7 = getent(self.target, "targetname");
    b_visible = 0;
    while (!self flag::get("runic_circle_activated")) {
        if (isdefined(level.var_c62829c7.is_flung) && !b_visible && isdefined(level.var_c62829c7) && level.var_c62829c7.is_flung) {
            var_9c1f46d7 clientfield::set("runic_circle_reveal", 1);
            var_9c1f46d7 clientfield::set("runic_circle_fx", 1);
            b_visible = 1;
        } else if (b_visible && isdefined(level.var_c62829c7) && !(isdefined(level.var_c62829c7.is_flung) && level.var_c62829c7.is_flung)) {
            var_9c1f46d7 clientfield::set("runic_circle_reveal", 0);
            var_9c1f46d7 clientfield::set("runic_circle_fx", 0);
            b_visible = 0;
        }
        wait 0.1;
    }
    var_9c1f46d7 clientfield::set("runic_circle_reveal", 1);
    var_9c1f46d7 clientfield::set("runic_circle_fx", 1);
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xa8f5b935, Offset: 0x50b0
// Size: 0x1f2
function function_2ead3d64() {
    /#
        level endon(#"hash_6de95813");
    #/
    self function_f9027a91();
    var_408c2634 = 0;
    n_rune = 1;
    var_9c1f46d7 = getent(self.target, "targetname");
    while (true) {
        self waittill(#"killed");
        var_408c2634++;
        if (var_408c2634 % 3 == 0) {
            var_dacee572 = var_9c1f46d7.target + "_" + n_rune;
            var_7b98b639 = getent(var_dacee572, "targetname");
            var_7b98b639 clientfield::set("runic_circle_reveal", 1);
            n_rune++;
            if (var_408c2634 >= 9) {
                self flag::set("runic_circle_charged");
                switch (self.script_label) {
                case "rampart":
                    exploder::exploder("fxexp_518");
                    break;
                case "roof":
                    exploder::exploder("fxexp_519");
                    break;
                case "road":
                    exploder::exploder("fxexp_520");
                    break;
                }
                var_9c1f46d7 clientfield::set("runic_circle_fx", 0);
                return;
            }
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x358c21, Offset: 0x52b0
// Size: 0x1a8
function function_f9027a91() {
    /#
        level endon(#"hash_6de95813");
        level endon(#"hash_35cccade");
    #/
    var_c749603c = getent(self.target + "_trig", "targetname");
    while (!self flag::get("runic_circle_activated")) {
        var_c749603c waittill(#"damage", amount, attacker, direction, point, mod, tagname, modelname, partname, weapon);
        if (isdefined(level.var_c62829c7.is_flung) && function_51a90202(weapon, 1, point, var_c749603c) && attacker === level.var_c62829c7 && level.var_c62829c7.is_flung) {
            self flag::set("runic_circle_activated");
            self playsound("evt_cirlce_rune_hit");
            var_c749603c delete();
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x87c99c60, Offset: 0x5460
// Size: 0x24
function function_2da80856(e_attacker) {
    self thread function_dc6aa565();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xb109112d, Offset: 0x5490
// Size: 0x1a4
function function_dc6aa565() {
    var_effd0eae = getentarray("aq_rp_runic_circle_volume", "script_noteworthy");
    if (self function_ab623d34(level.var_c62829c7)) {
        a_e_touching = level.var_c62829c7 array::get_touching(var_effd0eae);
        if (isdefined(a_e_touching) && a_e_touching.size > 0) {
            if (a_e_touching[0] flag::get("runic_circle_activated") && !a_e_touching[0] flag::get("runic_circle_charged")) {
                var_fb62adc1 = getent(a_e_touching[0].target, "targetname");
                a_e_touching[0] function_55c48922(self.origin, var_fb62adc1.origin, "rune", isdefined(self.missinglegs) && self.missinglegs);
                a_e_touching[0] util::delay_notify(0.05, "killed");
                var_fb62adc1 clientfield::increment("runic_circle_death_fx");
            }
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xa3db789, Offset: 0x5640
// Size: 0x1c
function function_eba39b3c() {
    level.var_c62829c7 thread function_8e83c9ed();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xc47cca56, Offset: 0x5668
// Size: 0x188
function function_8e83c9ed() {
    /#
        level.var_c62829c7 endon(#"hash_3c5d2ca5");
    #/
    level endon(#"hash_40e6d9e7");
    self endon(#"death");
    self endon(#"quest_swap");
    var_effd0eae = getentarray("aq_rp_runic_circle_volume", "script_noteworthy");
    var_8ed504dc = 0;
    while (true) {
        a_e_touching = self array::get_touching(var_effd0eae);
        if (!var_8ed504dc && isdefined(a_e_touching[0]) && a_e_touching[0] flag::get("runic_circle_activated") && !a_e_touching[0] flag::get("runic_circle_charged")) {
            self clientfield::set_to_player("anchor_point_postfx", 1);
            var_8ed504dc = 1;
        } else if (var_8ed504dc && !isdefined(a_e_touching[0])) {
            self clientfield::set_to_player("anchor_point_postfx", 0);
            var_8ed504dc = 0;
        }
        wait 0.5;
    }
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0xd615a82b, Offset: 0x57f8
    // Size: 0x16c
    function function_35cccade() {
        if (level flag::get("<dev string:xa1>") || level flag::get("<dev string:x50>")) {
            return;
        }
        var_effd0eae = getentarray("<dev string:x2ac>", "<dev string:x1e7>");
        foreach (var_6f4e5e57 in var_effd0eae) {
            if (!level flag::get("<dev string:x3c>")) {
                var_6f4e5e57 function_eca3cc8a();
                var_6f4e5e57 thread function_1d529530();
            }
            var_6f4e5e57 flag::set("<dev string:x2c6>");
        }
        level flag::set("<dev string:xa1>");
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x2666ab94, Offset: 0x5970
    // Size: 0x54
    function function_23e77c95() {
        exploder::exploder("<dev string:x2dd>");
        exploder::exploder("<dev string:x2e7>");
        exploder::exploder("<dev string:x2f1>");
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x29a8b7fa, Offset: 0x59d0
    // Size: 0x234
    function function_6de95813() {
        if (level flag::get("<dev string:x50>")) {
            return;
        }
        if (!level flag::get("<dev string:x3c>")) {
            level function_6c9ecb6();
        }
        zm_spawner::deregister_zombie_death_event_callback(&function_2da80856);
        var_42d1b62e = getentarray("<dev string:x2fb>", "<dev string:x1e7>");
        foreach (var_9c1f46d7 in var_42d1b62e) {
            var_9c1f46d7 clientfield::set("<dev string:x30e>", 1);
            var_9c1f46d7 clientfield::set("<dev string:x322>", 0);
        }
        var_11307e05 = getentarray("<dev string:x332>", "<dev string:x1e7>");
        foreach (var_92fe416a in var_11307e05) {
            var_92fe416a clientfield::set("<dev string:x30e>", 1);
        }
        level flag::set("<dev string:x50>");
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x228b1c29, Offset: 0x5c10
// Size: 0x302
function function_fd254a35() {
    /#
        level endon(#"hash_e09edb0");
        if (level flag::get("<dev string:x62>")) {
            return;
        }
    #/
    if (isdefined(level.var_c62829c7)) {
        level.var_c62829c7 thread zm_castle_vo::function_21c9c75b();
    }
    var_3955eb87 = struct::get("aq_rp_clock_use_struct", "targetname");
    var_7a76a496 = var_3955eb87 function_88082ccd();
    var_9877e371 = getent("aq_rp_magma_ball_tag", "targetname");
    var_9877e371 thread function_5f8f4823();
    level.var_ebaeb24a = var_7a76a496;
    level.var_bf08cf2d = &function_830f5cf3;
    level thread rune_prison_golf(var_7a76a496);
    level flag::wait_till("rune_prison_golf");
    var_7f680434 = var_7a76a496.var_336f1366;
    var_7a76a496 delete();
    var_7f680434 function_e198b188(1);
    var_7f680434 function_3313abd5();
    while (true) {
        var_7f680434.var_67b5dd94 waittill(#"trigger", e_who);
        if (e_who === level.var_c62829c7) {
            zm_unitrigger::unregister_unitrigger(var_7f680434.var_67b5dd94);
            playsoundatposition("zmb_fireplace_interact", var_7f680434.origin);
            e_who playrumbleonentity("zm_castle_quest_interact_rumble");
            e_who thread zm_audio::create_and_play_dialog("quest", "fireplace");
            var_7f680434 function_e198b188(0);
            var_9877e371 notify(#"final");
            var_808f0823 = getentarray("aq_rp_clock_wheel_rune", "script_noteworthy");
            array::run_all(var_808f0823, &delete);
            var_9877e371 flag::wait_till("magma_ball_move_done");
            return;
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xafa2fc7d, Offset: 0x5f20
// Size: 0x438
function function_88082ccd() {
    /#
        level endon(#"hash_e09edb0");
    #/
    self function_3313abd5();
    while (true) {
        self.var_67b5dd94 waittill(#"trigger", e_who);
        if (e_who === level.var_c62829c7) {
            zm_unitrigger::unregister_unitrigger(self.var_67b5dd94);
            break;
        }
    }
    e_who playrumbleonentity("zm_castle_quest_interact_rumble");
    level.var_bf08cf2d = undefined;
    level notify(#"hash_40e6d9e7");
    /#
        level flag::set("<dev string:xbc>");
    #/
    a_s_fireplaces = struct::get_array("aq_rp_fireplace_struct", "targetname");
    var_7f680434 = array::random(a_s_fireplaces);
    level function_16248b25(var_7f680434.script_int);
    var_235830d3 = var_7f680434.script_noteworthy;
    var_42d1b62e = getentarray("aq_rp_runic_circle", "script_noteworthy");
    foreach (var_9c1f46d7 in var_42d1b62e) {
        if (var_9c1f46d7.script_label != var_235830d3) {
            var_9c1f46d7 thread function_aea90ad4();
        }
    }
    var_11307e05 = getentarray("aq_rp_runic_circle_symbol", "script_noteworthy");
    foreach (var_92fe416a in var_11307e05) {
        if (var_92fe416a.script_label != var_235830d3) {
            var_92fe416a thread function_561d0d99();
        }
    }
    var_faf17913 = getentarray("aq_rp_runic_circle_volume", "script_noteworthy");
    foreach (var_9ea56658 in var_faf17913) {
        if (var_9ea56658.script_label != var_235830d3) {
            var_9ea56658 delete();
            continue;
        }
        var_7a76a496 = var_9ea56658;
    }
    var_7a76a496.var_336f1366 = var_7f680434;
    var_9c1f46d7 = getent(var_7a76a496.target, "targetname");
    var_9c1f46d7 clientfield::set("runic_circle_fx", 1);
    return var_7a76a496;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0xe9670566, Offset: 0x6360
// Size: 0x140
function function_16248b25(n_index) {
    var_e35d5b6e = struct::get("aq_rp_clock_rune_struct", "targetname");
    var_e2195897 = n_index * 120 + -16;
    level thread scene::play("p7_fxanim_zm_castle_quest_rune_clock_bundle");
    var_5ef42a75 = getent("aq_rp_clock_wheel", "targetname");
    playrumbleonposition("zm_castle_quest_rune_prison_clock_gear_rumble", var_5ef42a75.origin);
    var_5ef42a75 rotatepitch(var_e2195897, 4, 1, 2);
    var_5ef42a75 waittill(#"rotatedone");
    var_e35d5b6e.var_7b98b639 = util::spawn_model("p7_zm_ctl_rune_prison_clock_wheel_glow_0" + n_index, var_e35d5b6e.origin, var_e35d5b6e.angles);
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x51444b24, Offset: 0x64a8
// Size: 0x5c
function function_aea90ad4() {
    self clientfield::set("runic_circle_reveal", 0);
    self clientfield::set("runic_circle_fx", 0);
    wait 1;
    self delete();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xaac43c58, Offset: 0x6510
// Size: 0x3c
function function_561d0d99() {
    self clientfield::set("runic_circle_reveal", 0);
    wait 1;
    self delete();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x1173bf90, Offset: 0x6558
// Size: 0x508
function rune_prison_golf(var_7a76a496) {
    /#
        level endon(#"hash_e09edb0");
        level endon(#"hash_e7cc5223");
        level.var_c62829c7 endon(#"hash_3c5d2ca5");
    #/
    level.var_c62829c7 endon(#"death");
    level.var_c62829c7 endon(#"quest_swap");
    var_eae04066 = 0;
    level.var_2e55cb98 = var_7a76a496;
    level.var_c62829c7 thread function_592f1ad2();
    level thread function_2e904288(var_7a76a496);
    while (!level flag::get("rune_prison_golf")) {
        level.var_c62829c7 waittill(#"missile_fire", projectile, weapon);
        if (level.var_c62829c7 istouching(level.var_2e55cb98) && function_51a90202(weapon)) {
            var_d59b9592 = projectile function_1ae3933d(var_eae04066, var_7a76a496.var_336f1366);
            if (!isdefined(var_d59b9592)) {
                continue;
            }
            var_eae04066++;
            if (var_eae04066 == 1) {
                var_9c1f46d7 = getent(var_7a76a496.target, "targetname");
                var_9c1f46d7 clientfield::set("runic_circle_fx", 0);
            }
            if (var_eae04066 > 1) {
                level thread function_a78192b2(level.var_2e55cb98.var_41f52afd);
                level.var_2e55cb98 delete();
            }
            if (var_eae04066 == 2) {
                level.var_c62829c7 thread function_c22c33e2();
            }
            if (var_eae04066 == 4) {
                level thread function_a78192b2(var_d59b9592.var_41f52afd);
                var_d59b9592 delete();
                var_9877e371 = getent("aq_rp_magma_ball_tag", "targetname");
                var_9877e371 notify(#"reset");
                var_eae04066 = 0;
                if (isdefined(level.var_c62829c7)) {
                    playsoundatposition("zmb_demon_runes_deny", level.var_c62829c7.origin);
                }
                level waittill(#"between_round_over");
                level.var_2e55cb98 = var_7a76a496;
                var_9c1f46d7 = getent(var_7a76a496.target, "targetname");
                var_9c1f46d7 clientfield::set("runic_circle_fx", 1);
                continue;
            }
            level.var_2e55cb98 = var_d59b9592;
        }
    }
    level.var_ebaeb24a = undefined;
    level.var_bf08cf2d = undefined;
    if (isdefined(level.var_2e55cb98.var_41f52afd)) {
        level thread function_a78192b2(level.var_2e55cb98.var_41f52afd);
    }
    if (level.var_2e55cb98 != var_7a76a496) {
        level.var_2e55cb98 delete();
    }
    var_42d1b62e = getentarray("aq_rp_runic_circle", "script_noteworthy");
    array::thread_all(var_42d1b62e, &function_aea90ad4);
    var_11307e05 = getentarray("aq_rp_runic_circle_symbol", "script_noteworthy");
    array::thread_all(var_11307e05, &function_561d0d99);
    var_e35d5b6e = struct::get("aq_rp_clock_rune_struct", "targetname");
    if (isdefined(var_e35d5b6e.var_7b98b639)) {
        var_e35d5b6e.var_7b98b639 delete();
    }
    level.var_c62829c7.var_77447dc2 = 1;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xb3ccb23e, Offset: 0x6a68
// Size: 0x24
function function_830f5cf3() {
    level thread rune_prison_golf(level.var_ebaeb24a);
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x5b3f8edf, Offset: 0x6a98
// Size: 0x50
function function_c22c33e2() {
    wait 1;
    if (!(isdefined(self.var_77447dc2) && self.var_77447dc2)) {
        self thread zm_audio::create_and_play_dialog("quest", "clock");
        self.var_77447dc2 = 1;
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xc72a5325, Offset: 0x6af0
// Size: 0x16c
function function_592f1ad2() {
    /#
        level endon(#"hash_e09edb0");
        level.var_c62829c7 endon(#"hash_3c5d2ca5");
    #/
    self endon(#"death");
    self endon(#"quest_swap");
    var_8ed504dc = 0;
    while (!level flag::get("rune_prison_golf")) {
        if (isdefined(level.var_2e55cb98)) {
            if (var_8ed504dc && !self istouching(level.var_2e55cb98)) {
                self clientfield::set_to_player("anchor_point_postfx", 0);
                var_8ed504dc = 0;
            } else if (!var_8ed504dc && self istouching(level.var_2e55cb98)) {
                self clientfield::set_to_player("anchor_point_postfx", 1);
                var_8ed504dc = 1;
            }
        } else {
            self clientfield::set_to_player("anchor_point_postfx", 0);
        }
        wait 0.5;
    }
    level.var_c62829c7 clientfield::set_to_player("anchor_point_postfx", 0);
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x2a15bd92, Offset: 0x6c68
// Size: 0xac
function function_2e904288(var_7a76a496) {
    level endon(#"rune_prison_golf");
    level.var_c62829c7 util::waittill_either("death", "quest_swap");
    if (isdefined(level.var_2e55cb98)) {
        if (isdefined(level.var_2e55cb98.var_41f52afd)) {
            level thread function_a78192b2(level.var_2e55cb98.var_41f52afd);
        }
        if (level.var_2e55cb98 != var_7a76a496) {
            level.var_2e55cb98 delete();
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 2, eflags: 0x0
// Checksum 0xfd216a1, Offset: 0x6d20
// Size: 0x2c8
function function_1ae3933d(var_eae04066, s_fireplace) {
    /#
        level.var_c62829c7 endon(#"hash_3c5d2ca5");
    #/
    level.var_c62829c7 endon(#"death");
    level.var_c62829c7 endon(#"quest_swap");
    var_2f3895e7 = getent(s_fireplace.target, "targetname");
    var_a7b8686c = undefined;
    do {
        level.var_c62829c7 waittill(#"projectile_impact", weapon, v_position, radius, e_projectile, normal);
        if (self != e_projectile) {
            if (!level.var_c62829c7 istouching(level.var_2e55cb98) || !function_51a90202(weapon)) {
                return undefined;
            }
        }
        if (level function_afda729a(var_eae04066, var_2f3895e7, v_position)) {
            level flag::set("rune_prison_golf");
            level util::delay_notify(2, "rune_prison_postfx_end");
            return undefined;
        }
        var_a7b8686c = level.var_c62829c7 zm_weap_elemental_bow::function_866906f(v_position, "elemental_bow_rune_prison", e_projectile, 32);
        if (isdefined(var_a7b8686c) && !zm_utility::check_point_in_enabled_zone(var_a7b8686c)) {
            var_a7b8686c = undefined;
        }
    } while (!isdefined(var_a7b8686c));
    var_9877e371 = getent("aq_rp_magma_ball_tag", "targetname");
    mdl_anchor = util::spawn_model("tag_origin", var_a7b8686c);
    mdl_anchor clientfield::set("runeprison_rock_fx", 1);
    var_d59b9592 = spawn("trigger_radius", var_a7b8686c, 0, 100, -106);
    var_d59b9592.var_41f52afd = mdl_anchor;
    var_9877e371 notify(#"drop");
    return var_d59b9592;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 3, eflags: 0x0
// Checksum 0x6856ce0b, Offset: 0x6ff0
// Size: 0x106
function function_afda729a(var_eae04066, var_2f3895e7, var_20d7ea40) {
    var_64deb4b = spawn("script_origin", var_20d7ea40);
    if (var_64deb4b istouching(var_2f3895e7)) {
        var_64deb4b delete();
        if (var_eae04066 < 3) {
            s_powerup = struct::get(var_2f3895e7.target, "targetname");
            level thread zm_powerups::specific_powerup_drop("full_ammo", s_powerup.origin);
        }
        return true;
    }
    var_64deb4b delete();
    return false;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x2b3b8aa4, Offset: 0x7100
// Size: 0x4c
function function_a78192b2(mdl_anchor) {
    mdl_anchor clientfield::set("runeprison_rock_fx", 0);
    wait 6;
    mdl_anchor delete();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x627562c, Offset: 0x7158
// Size: 0x20e
function function_e198b188(var_931bac44) {
    if (!var_931bac44) {
        var_197f1988 = util::spawn_model("tag_origin", self.origin + (36, 88, 12));
        var_197f1988 thread scene::play("p7_fxanim_zm_castle_quest_rune_fireplace_arrow_bundle");
        wait 3;
        var_197f1988 scene::stop("p7_fxanim_zm_castle_quest_rune_fireplace_arrow_bundle");
        var_197f1988 delete();
    }
    switch (self.script_noteworthy) {
    case "rampart":
        if (var_931bac44) {
            exploder::exploder("fxexp_513");
        } else {
            exploder::stop_exploder("fxexp_513");
            wait 0.05;
            exploder::exploder("fxexp_514");
        }
        break;
    case "road":
        if (var_931bac44) {
            exploder::exploder("fxexp_511");
        } else {
            exploder::stop_exploder("fxexp_511");
            wait 0.05;
            exploder::exploder("fxexp_512");
        }
        break;
    case "roof":
        if (var_931bac44) {
            exploder::exploder("fxexp_515");
        } else {
            exploder::stop_exploder("fxexp_515");
            wait 0.05;
            exploder::exploder("fxexp_516");
        }
        break;
    }
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x7306e966, Offset: 0x7370
    // Size: 0x2c0
    function function_455e5c02() {
        a_s_fireplaces = struct::get_array("<dev string:x34c>", "<dev string:x141>");
        if (isdefined(level.var_ca9bb3ac) && level.var_ca9bb3ac) {
            foreach (s_fireplace in a_s_fireplaces) {
                s_fireplace.var_197f1988 scene::stop("<dev string:x363>");
            }
            exploder::stop_exploder("<dev string:x399>");
            exploder::stop_exploder("<dev string:x3a3>");
            exploder::stop_exploder("<dev string:x3ad>");
            wait 0.05;
            exploder::exploder("<dev string:x3b7>");
            exploder::exploder("<dev string:x3c1>");
            exploder::exploder("<dev string:x3cb>");
            level.var_ca9bb3ac = undefined;
            return;
        }
        foreach (s_fireplace in a_s_fireplaces) {
            if (!isdefined(s_fireplace.var_197f1988)) {
                s_fireplace.var_197f1988 = util::spawn_model("<dev string:x3d5>", s_fireplace.origin + (36, 88, 12));
            }
            s_fireplace.var_197f1988 thread scene::play("<dev string:x363>");
        }
        exploder::exploder("<dev string:x399>");
        exploder::exploder("<dev string:x3a3>");
        exploder::exploder("<dev string:x3ad>");
        level.var_ca9bb3ac = 1;
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x646b6031, Offset: 0x7638
    // Size: 0x74
    function function_e7cc5223() {
        if (!level flag::get("<dev string:xbc>") || level flag::get("<dev string:x3e0>")) {
            return;
        }
        level notify(#"hash_e7cc5223");
        level flag::set("<dev string:x3e0>");
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xa032b968, Offset: 0x76b8
// Size: 0x19c
function function_5f8f4823() {
    /#
        level endon(#"hash_e09edb0");
    #/
    v_start_position = self.origin;
    var_f36eb41b = self.origin + (0, 0, -464);
    while (true) {
        str_notify = util::waittill_any_return("drop", "reset", "final");
        if (str_notify == "drop") {
            self moveto(self.origin + (0, 0, -120), 3, 0.05, 0.05);
        } else if (str_notify == "reset") {
            self moveto(v_start_position, 3, 0.05, 0.05);
        } else {
            self moveto(var_f36eb41b, 2, 0.05, 0.05);
            self waittill(#"movedone");
            level function_a5e1cdff();
            break;
        }
        self waittill(#"movedone");
    }
    self flag::set("magma_ball_move_done");
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x23ed99e1, Offset: 0x7860
// Size: 0x6c
function function_a5e1cdff() {
    level scene::play("p7_fxanim_zm_castle_quest_rune_orb_scale_down_bundle");
    level scene::init("p7_fxanim_zm_castle_quest_rune_orb_crust_bundle");
    wait 0.4;
    level clientfield::increment("orb_sanim_cleanup");
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0xa4e8a3c0, Offset: 0x78d8
    // Size: 0xa6
    function function_798d8c4d() {
        var_9877e371 = getent("<dev string:x1f9>", "<dev string:x141>");
        if (isdefined(var_9877e371)) {
            var_9877e371 moveto((-46, 1920, 1068), 3, 0.05, 0.05);
            var_9877e371 waittill(#"movedone");
        }
        level function_a5e1cdff();
        level.var_1e2db323 = undefined;
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0xf5aadbe2, Offset: 0x7988
    // Size: 0x1fc
    function function_e09edb0() {
        if (level flag::get("<dev string:x62>")) {
            return;
        }
        if (!level flag::get("<dev string:x50>")) {
            level function_6de95813();
        }
        level notify(#"hash_40e6d9e7");
        var_42d1b62e = getentarray("<dev string:x2fb>", "<dev string:x1e7>");
        array::thread_all(var_42d1b62e, &function_aea90ad4);
        var_11307e05 = getentarray("<dev string:x332>", "<dev string:x1e7>");
        array::thread_all(var_11307e05, &function_561d0d99);
        var_e92aafe5 = getentarray("<dev string:x2ac>", "<dev string:x1e7>");
        array::run_all(var_e92aafe5, &delete);
        var_e35d5b6e = struct::get("<dev string:x3f1>", "<dev string:x141>");
        if (isdefined(var_e35d5b6e.var_7b98b639)) {
            var_e35d5b6e.var_7b98b639 delete();
        }
        level function_a5e1cdff();
        level.var_bf08cf2d = undefined;
        level flag::set("<dev string:x62>");
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xf5f7222f, Offset: 0x7b90
// Size: 0x404
function rune_prison_magma_ball() {
    /#
        level endon(#"hash_57edd5aa");
        if (level flag::get("<dev string:x73>")) {
            return;
        }
    #/
    var_605e43a9 = struct::get("quest_reforge_rune_prison", "targetname");
    var_605e43a9 function_3313abd5(undefined, undefined, var_605e43a9.origin + (0, 0, 30), -128);
    while (true) {
        var_605e43a9.var_67b5dd94 waittill(#"trigger", e_who);
        if (e_who === level.var_c62829c7) {
            level notify(#"hash_d2306a6e");
            e_who playrumbleonentity("zm_castle_quest_interact_rumble");
            var_9877e371 = getent("aq_rp_magma_ball_tag", "targetname");
            var_9877e371 delete();
            level thread scene::play("p7_fxanim_zm_castle_quest_rune_orb_crust_bundle");
            level waittill(#"hash_79d94608");
            /#
                level.var_1e2db323 = 1;
            #/
            break;
        }
    }
    var_605e43a9.var_67b5dd94.prompt_and_visibility_func = &function_8c1fd619;
    var_605e43a9.var_67b5dd94 function_c1947ff7();
    while (true) {
        var_605e43a9.var_67b5dd94 waittill(#"trigger", e_who);
        if (isdefined(level.var_c62829c7)) {
            if (e_who == level.var_c62829c7) {
                break;
            }
            continue;
        }
        if (!array::contains(level.var_427e7668, e_who)) {
            level.var_c62829c7 = e_who;
            level.var_427e7668[level.var_427e7668.size] = e_who;
            level clientfield::set("quest_owner_rune", function_85bfa3fd(e_who.characterindex));
            break;
        }
        e_who notify(#"quest_swap");
        level function_7910311b(e_who);
        level.var_c62829c7 = e_who;
        level clientfield::set("quest_owner_rune", function_85bfa3fd(e_who.characterindex));
        break;
    }
    e_who playsound("zmb_arrow_reforged");
    e_who playrumbleonentity("zm_castle_quest_interact_rumble");
    zm_unitrigger::unregister_unitrigger(var_605e43a9.var_67b5dd94);
    var_605e43a9 thread function_42084ad5(level.var_c62829c7);
    level flag::set("rune_prison_repaired");
    level.var_2b11065e delete();
    level.var_2b11065e = getent("rune_orb_arrow", "targetname");
    level.var_2b11065e hide();
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x185687eb, Offset: 0x7fa0
    // Size: 0xf6
    function function_e83bfb3() {
        if (!(isdefined(level.var_1e2db323) && level.var_1e2db323)) {
            var_9dc11e80 = getent("<dev string:x409>", "<dev string:x141>");
            var_9dc11e80 show();
            level thread scene::play("<dev string:x41e>");
            level.var_1e2db323 = 1;
            return;
        }
        level scene::init("<dev string:x41e>");
        wait 0.05;
        var_9dc11e80 = getent("<dev string:x409>", "<dev string:x141>");
        var_9dc11e80 hide();
        level.var_1e2db323 = undefined;
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0xa88d3767, Offset: 0x80a0
    // Size: 0x124
    function function_57edd5aa() {
        if (level flag::get("<dev string:x73>")) {
            return;
        }
        if (!level flag::get("<dev string:x62>")) {
            level function_e09edb0();
        }
        level flag::set("<dev string:x73>");
        level flag::set("<dev string:x44e>");
        var_9877e371 = getent("<dev string:x1f9>", "<dev string:x141>");
        if (isdefined(var_9877e371)) {
            var_9877e371 delete();
        }
        level scene::skipto_end("<dev string:x41e>");
        level thread function_d4533e0c();
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x3d894863, Offset: 0x81d0
    // Size: 0x4c
    function function_d4533e0c() {
        wait 2;
        var_5669be5f = getent("<dev string:x463>", "<dev string:x141>");
        var_5669be5f delete();
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x6ed70a08, Offset: 0x8228
// Size: 0x24
function function_d04d2c23(e_attacker) {
    self thread function_293189ba();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xe2b8058d, Offset: 0x8258
// Size: 0x174
function function_293189ba() {
    e_volume = getent("aq_statue_volume", "targetname");
    if (self function_ab623d34(level.var_c62829c7, e_volume)) {
        var_74b0d14a = struct::get("upgraded_bow_struct_rune_prison", "targetname");
        level function_55c48922(self.origin, var_74b0d14a.origin, "rune", isdefined(self.missinglegs) && self.missinglegs);
        var_74b0d14a.var_ce58f456++;
        if (var_74b0d14a.var_ce58f456 >= 20) {
            level flag::set("rune_prison_upgraded");
            mdl_arrow = getent("pedestal_rune_bow_place", "targetname");
            mdl_arrow playsound("evt_arrow_souls_ready");
            mdl_arrow thread function_bf26d3fb("arrow_charge_wolf_fx");
        }
    }
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x4f95e148, Offset: 0x83d8
    // Size: 0x2b4
    function function_44605b46() {
        if (level flag::get("<dev string:x472>")) {
            return;
        }
        if (!level flag::get("<dev string:x73>")) {
            level function_57edd5aa();
        }
        level flag::set("<dev string:x8b>");
        zm_spawner::deregister_zombie_death_event_callback(&function_d04d2c23);
        var_28eeb81a = struct::get("<dev string:x487>", "<dev string:x141>");
        if (isdefined(var_28eeb81a.var_67b5dd94)) {
            zm_unitrigger::unregister_unitrigger(var_28eeb81a.var_67b5dd94);
        }
        if (!(isdefined(level.var_e46b89a6) && level.var_e46b89a6)) {
            level scene::play("<dev string:x4a7>");
        }
        level scene::play("<dev string:x4dd>");
        level flag::set("<dev string:x472>");
        arrayremovevalue(level.var_427e7668, level.var_c62829c7);
        level.var_c62829c7 = undefined;
        level clientfield::set("<dev string:xfc>", 0);
        level function_f5e9876("<dev string:x512>", 6);
        if (!isdefined(level.var_e8a6b6f7)) {
            level.var_e8a6b6f7 = [];
            array::thread_all(level.players, &function_b584c1e);
            callback::on_connect(&function_7c48f9d8);
        }
        level flag::set("<dev string:x517>");
        var_28eeb81a.var_d4a62e6b = getent("<dev string:x52b>", "<dev string:x141>");
        var_28eeb81a thread function_fb704679();
        level function_2c1c1d3e("<dev string:x548>");
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x7e391ec6, Offset: 0x8698
// Size: 0x2d4
function demon_gate() {
    /#
        level flag::init("<dev string:x554>");
        level flag::init("<dev string:x565>");
        level flag::init("<dev string:x579>");
        level flag::init("<dev string:x58e>");
        level flag::init("<dev string:x5a0>");
        level flag::init("<dev string:x5b3>");
        level flag::init("<dev string:x5cc>");
    #/
    level function_89870276();
    level function_d47f8f22();
    /#
        level flag::set("<dev string:x554>");
    #/
    level function_f5e9876("demon", 1);
    level demon_gate_seal();
    /#
        level flag::set("<dev string:x565>");
    #/
    level function_f5e9876("demon", 2);
    level function_5170090a();
    /#
        level flag::set("<dev string:x579>");
    #/
    level function_f5e9876("demon", 3);
    level demon_gate_crawlers();
    /#
        level flag::set("<dev string:x58e>");
    #/
    level function_f5e9876("demon", 4);
    level demon_gate_runes();
    /#
        level flag::set("<dev string:x5b3>");
    #/
    var_dfd1c443 = struct::get("upgraded_bow_struct_demon_gate", "targetname");
    var_dfd1c443 function_14dd5ea5();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x724e8a8d, Offset: 0x8978
// Size: 0x1ca
function function_89870276() {
    level flag::init("demon_gate_seal");
    level flag::init("demon_gate_crawlers");
    level flag::init("demon_gate_runes");
    level flag::init("rune_sequence_failed");
    level flag::init("demon_gate_repaired");
    level flag::init("demon_gate_placed");
    level flag::init("demon_gate_upgraded");
    level flag::init("demon_gate_spawned");
    wait 0.05;
    var_14733f98 = getentarray("aq_dg_fossil", "script_noteworthy");
    foreach (var_8ab1dc51 in var_14733f98) {
        var_8ab1dc51 clientfield::set("fossil_reveal", 2);
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x83f49f7, Offset: 0x8b50
// Size: 0x21a
function function_d47f8f22() {
    /#
        level endon(#"hash_4e281784");
    #/
    var_e88abb1 = getent("aq_dg_gatehouse_symbol_trig", "targetname");
    while (true) {
        var_e88abb1 waittill(#"damage", amount, attacker, direction, point, mod, tagname, modelname, partname, weapon);
        if (function_51a90202(weapon, 1, point, var_e88abb1)) {
            playrumbleonposition("zm_castle_quest_demon_gate_gatehouse_rumble", point);
            level thread scene::play("p7_fxanim_zm_castle_quest_demongate_ceiling_bundle");
            level scene::init("p7_fxanim_zm_castle_quest_demon_arrow_broken_bundle");
            level waittill(#"hash_c8347a07");
            /#
                level.var_67c3233f = 1;
            #/
            level thread scene::play("p7_fxanim_zm_castle_quest_demon_arrow_broken_bundle");
            level.var_72a6d56b = getent("quest_demongate_arrow_broken", "targetname");
            s_arrow = struct::get("quest_start_demon_gate");
            s_arrow function_f708e6b2();
            var_e88abb1 zm_castle_vo::function_f0b775a3("release");
            var_e88abb1 delete();
            return;
        }
    }
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x593a625b, Offset: 0x8d78
    // Size: 0x90
    function function_4cb8f913() {
        if (isdefined(level.var_67c3233f) && level.var_67c3233f) {
            level thread scene::init("<dev string:x5e3>");
            level.var_67c3233f = undefined;
            return;
        }
        level thread scene::init("<dev string:x616>");
        level thread scene::play("<dev string:x5e3>");
        level.var_67c3233f = 1;
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0xa7d23bb1, Offset: 0x8e10
    // Size: 0x174
    function function_4e281784() {
        if (level flag::get("<dev string:x554>")) {
            return;
        }
        if (!(isdefined(level.var_67c3233f) && level.var_67c3233f)) {
            level thread scene::play("<dev string:x616>");
            level thread scene::play("<dev string:x5e3>");
            level.var_67c3233f = 1;
            wait 0.05;
            level.var_72a6d56b = getent("<dev string:x64a>", "<dev string:x141>");
            level.var_72a6d56b hide();
        }
        level thread zm_castle_weap_quest::function_a01a53de();
        level.var_6e68c0d8 = level.players[0];
        level clientfield::set("<dev string:x667>", function_85bfa3fd(level.var_6e68c0d8.characterindex));
        level.var_427e7668[level.var_427e7668.size] = level.players[0];
        level flag::set("<dev string:x554>");
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x78c55860, Offset: 0x8f90
// Size: 0x18c
function demon_gate_seal() {
    /#
        level endon(#"hash_ff914e7a");
        if (level flag::get("<dev string:x565>")) {
            return;
        }
    #/
    var_a3bb3065 = getent("aq_dg_flagstone_seal_trig", "targetname");
    exploder::exploder("fxexp_300");
    zm_spawner::register_zombie_death_event_callback(&function_c58a0fe3);
    level flag::wait_till("demon_gate_seal");
    zm_spawner::deregister_zombie_death_event_callback(&function_c58a0fe3);
    exploder::stop_exploder("fxexp_300");
    exploder::exploder("fxexp_301");
    playrumbleonposition("zm_castle_quest_demon_gate_seal_rumble", var_a3bb3065.origin);
    level scene::init("p7_fxanim_zm_castle_quest_demongate_urn_bundle");
    level scene::play("p7_fxanim_zm_castle_quest_demongate_flagstones_bundle");
    level function_bb59b66c();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0xf6cec56b, Offset: 0x9128
// Size: 0xdc
function function_c58a0fe3(e_attacker) {
    if (self function_ab623d34(level.var_6e68c0d8)) {
        var_a3bb3065 = getent("aq_dg_flagstone_seal_trig", "targetname");
        if (self istouching(var_a3bb3065) && self.damagemod == "MOD_MELEE") {
            self zombie_utility::gib_random_parts();
            gibserverutils::annihilate(self);
            level flag::set("demon_gate_seal");
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x21ba1f48, Offset: 0x9210
// Size: 0x16a
function function_bb59b66c() {
    /#
        level endon(#"hash_ff914e7a");
        if (level flag::get("<dev string:x565>")) {
            return;
        }
    #/
    s_urn = struct::get("aq_dg_urn_struct", "targetname");
    s_urn function_3313abd5();
    while (true) {
        s_urn.var_67b5dd94 waittill(#"trigger", e_who);
        if (e_who === level.var_6e68c0d8) {
            e_who playrumbleonentity("zm_castle_quest_interact_rumble");
            level thread scene::play("p7_fxanim_zm_castle_quest_demongate_urn_bundle");
            /#
                level.var_cbef6be5 = 1;
            #/
            zm_unitrigger::unregister_unitrigger(s_urn.var_67b5dd94);
            var_cd45655b = getent("aq_dg_urn_position", "targetname");
            var_cd45655b zm_castle_vo::function_f0b775a3("return");
            return;
        }
    }
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x3cdfc996, Offset: 0x9388
    // Size: 0x90
    function function_c0165d14() {
        if (!isdefined(level.var_8ead83b4)) {
            level.var_8ead83b4 = level flag::get("<dev string:x554>");
        }
        if (level.var_8ead83b4) {
            exploder::stop_exploder("<dev string:x679>");
            level.var_8ead83b4 = 0;
            return;
        }
        exploder::exploder("<dev string:x679>");
        level.var_8ead83b4 = 1;
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x5061e556, Offset: 0x9420
    // Size: 0x1b2
    function function_ff914e7a() {
        if (level flag::get("<dev string:x565>")) {
            return;
        }
        if (!level flag::get("<dev string:x554>")) {
            level function_4e281784();
        }
        exploder::exploder_stop("<dev string:x679>");
        exploder::exploder("<dev string:x683>");
        s_urn = struct::get("<dev string:x68d>", "<dev string:x141>");
        if (isdefined(s_urn.var_67b5dd94)) {
            zm_unitrigger::unregister_unitrigger(s_urn.var_67b5dd94);
        }
        level flag::set("<dev string:x565>");
        level flag::set("<dev string:x69e>");
        zm_spawner::deregister_zombie_death_event_callback(&function_c58a0fe3);
        if (!(isdefined(level.var_243b71b9) && level.var_243b71b9)) {
            level thread scene::play("<dev string:x6ae>");
        }
        if (!(isdefined(level.var_cbef6be5) && level.var_cbef6be5)) {
            level thread scene::play("<dev string:x6e4>");
            wait 1;
        }
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xdbc3c60d, Offset: 0x95e0
// Size: 0xcc
function function_5170090a() {
    /#
        level endon(#"hash_de755a0");
        if (level flag::get("<dev string:x579>")) {
            return;
        }
    #/
    var_fc5fd994 = getentarray("aq_dg_fossil", "script_noteworthy");
    array::thread_all(var_fc5fd994, &function_1353f9e3);
    array::wait_till(var_fc5fd994, "returned");
    wait 2;
    array::run_all(var_fc5fd994, &delete);
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xc8803ce2, Offset: 0x96b8
// Size: 0x212
function function_1353f9e3() {
    /#
        level endon(#"hash_de755a0");
        if (level flag::get("<dev string:x579>")) {
            return;
        }
    #/
    self function_3313abd5();
    while (true) {
        self.var_67b5dd94 waittill(#"trigger", e_who);
        if (e_who === level.var_6e68c0d8) {
            self clientfield::set("fossil_collect_fx", 1);
            self clientfield::set("fossil_reveal", 0);
            self notify(#"returned");
            self playsound("zmb_fossil_pickup");
            e_who playrumbleonentity("zm_castle_quest_interact_rumble");
            var_26a19747 = getent(self.target, "targetname");
            if (var_26a19747.script_label == "o_zm_dlc1_chomper_demongate_swarm_trophy_room_solo_idle") {
                var_26a19747 clientfield::set("init_demongate_fossil", 1);
                util::wait_network_frame();
                var_26a19747 clientfield::set("fossil_reveal", 2);
            } else {
                var_26a19747 clientfield::set("init_demongate_fossil", 2);
                util::wait_network_frame();
                var_26a19747 clientfield::set("fossil_reveal", 2);
            }
            zm_unitrigger::unregister_unitrigger(self.var_67b5dd94);
            return;
        }
    }
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x3f6a1047, Offset: 0x98d8
    // Size: 0x25a
    function function_de755a0() {
        if (level flag::get("<dev string:x579>")) {
            return;
        }
        if (!level flag::get("<dev string:x565>")) {
            level function_ff914e7a();
        }
        level flag::set("<dev string:x579>");
        var_fc5fd994 = getentarray("<dev string:x713>", "<dev string:x1e7>");
        foreach (var_2c4603e5 in var_fc5fd994) {
            var_f93034eb = getent(var_2c4603e5.target, "<dev string:x141>");
            if (var_f93034eb.script_label == "<dev string:x720>") {
                var_f93034eb clientfield::set("<dev string:x758>", 1);
                util::wait_network_frame();
                var_f93034eb clientfield::set("<dev string:x76e>", 2);
            } else {
                var_f93034eb clientfield::set("<dev string:x758>", 2);
                util::wait_network_frame();
                var_f93034eb clientfield::set("<dev string:x76e>", 2);
            }
            zm_unitrigger::unregister_unitrigger(var_2c4603e5.var_67b5dd94);
            var_2c4603e5 delete();
            wait randomfloat(2);
        }
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x61bfcdec, Offset: 0x9b40
// Size: 0x180
function demon_gate_crawlers() {
    /#
        level endon(#"hash_2d151482");
        if (level flag::get("<dev string:x58e>")) {
            return;
        }
    #/
    level thread function_10033c3();
    level.var_f4c7c18 = getentarray("aq_dg_fossil_align", "script_noteworthy");
    var_90cbeda9 = getent("aq_dg_demonic_circle", "targetname");
    var_90cbeda9 clientfield::set("demonic_circle_reveal", 1);
    var_83e3ae42 = getent("aq_dg_demonic_circle_volume", "targetname");
    var_83e3ae42.var_e1f456ae = 0;
    array::thread_all(level.var_f4c7c18, &function_f836dce1);
    /#
        level.var_2114a01 = 1;
    #/
    zm_spawner::register_zombie_death_event_callback(&function_561017d8);
    level flag::wait_till("demon_gate_crawlers");
    level.var_f4c7c18 = [];
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x67be9332, Offset: 0x9cc8
// Size: 0xec
function function_10033c3() {
    /#
        level endon(#"hash_2d151482");
        if (level flag::get("<dev string:x58e>")) {
            return;
        }
    #/
    var_c199072a = getent("aq_dg_trophy_room_trig", "targetname");
    while (true) {
        var_c199072a waittill(#"trigger", e_who);
        if (e_who === level.var_6e68c0d8) {
            break;
        }
        wait 0.5;
    }
    var_cd45655b = getent("aq_dg_urn_position", "targetname");
    var_cd45655b thread zm_castle_vo::function_f0b775a3("souls");
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x390f6244, Offset: 0x9dc0
// Size: 0x2e8
function function_f836dce1() {
    /#
        level endon(#"hash_2d151482");
        if (level flag::get("<dev string:x58e>")) {
            return;
        }
    #/
    var_83e3ae42 = getent("aq_dg_demonic_circle_volume", "targetname");
    while (true) {
        a_ai_enemies = getaiteamarray(level.zombie_team);
        var_f8df884a = var_83e3ae42 array::get_touching(a_ai_enemies);
        var_aba3cf25 = array::filter(var_f8df884a, 0, &function_4cefb6e2);
        var_5a05fe58 = randomfloat(2.5);
        wait var_5a05fe58;
        foreach (ai_crawler in var_aba3cf25) {
            if (isalive(ai_crawler) && !(isdefined(ai_crawler.var_cb2fc89f) && ai_crawler.var_cb2fc89f)) {
                ai_crawler.var_cb2fc89f = 1;
                self clientfield::set("fossil_reveal", 0);
                var_8ab1dc51 = util::spawn_model("c_zom_chomper_demongate");
                var_8ab1dc51 clientfield::set("fossil_reveal", 1);
                ai_crawler scene::play("ai_zm_dlc1_zombie_demongate_fossil_attack_crawler", array(ai_crawler, var_8ab1dc51));
                level thread function_b4c4b5dd(ai_crawler.origin);
                ai_crawler dodamage(ai_crawler.health, ai_crawler.origin);
                return;
            }
        }
        if (var_5a05fe58 < 0.1) {
            wait 0.1;
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0xa4b3b95e, Offset: 0xa0b0
// Size: 0x78
function function_4cefb6e2(ai_enemy) {
    if (isdefined(ai_enemy.missinglegs) && isalive(ai_enemy) && ai_enemy.missinglegs && !(isdefined(ai_enemy.var_cb2fc89f) && ai_enemy.var_cb2fc89f)) {
        return true;
    }
    return false;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0xb6bc00d5, Offset: 0xa130
// Size: 0xfc
function function_b4c4b5dd(v_start) {
    var_cd45655b = getent("aq_dg_urn_position", "targetname");
    level function_55c48922(v_start, var_cd45655b.origin, "demon", 1);
    var_cd45655b clientfield::increment("urn_impact_fx");
    var_83e3ae42 = getent("aq_dg_demonic_circle_volume", "targetname");
    var_83e3ae42.var_e1f456ae++;
    if (var_83e3ae42.var_e1f456ae >= 6) {
        level flag::set("demon_gate_crawlers");
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x4e548fa9, Offset: 0xa238
// Size: 0xa4
function function_561017d8() {
    var_83e3ae42 = getent("aq_dg_demonic_circle_volume", "targetname");
    if (isdefined(self) && !self.isdog && self.archetype != "mechz" && self istouching(var_83e3ae42)) {
        self zombie_utility::gib_random_parts();
        gibserverutils::annihilate(self);
    }
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x4bd2f1b9, Offset: 0xa2e8
    // Size: 0x1dc
    function function_2d151482() {
        if (level flag::get("<dev string:x58e>")) {
            return;
        }
        if (!level flag::get("<dev string:x579>")) {
            level function_de755a0();
        }
        var_90cbeda9 = getent("<dev string:x77c>", "<dev string:x141>");
        var_90cbeda9 clientfield::set("<dev string:x791>", 1);
        if (!(isdefined(level.var_2114a01) && level.var_2114a01)) {
            zm_spawner::register_zombie_death_event_callback(&function_561017d8);
        }
        var_de75cc7c = getentarray("<dev string:x7a7>", "<dev string:x1e7>");
        foreach (var_7119a95d in var_de75cc7c) {
            var_7119a95d clientfield::set("<dev string:x758>", 3);
        }
        level flag::set("<dev string:x7ba>");
        level flag::set("<dev string:x58e>");
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x1190e6b5, Offset: 0xa4d0
// Size: 0x28e
function demon_gate_runes() {
    level.var_ca3b8551 = 1;
    level thread function_f3eb4a12();
    var_6b525fd2 = getentarray("aq_dg_circle_rune_outline", "script_noteworthy");
    foreach (var_1b7f8ea6 in var_6b525fd2) {
        var_1b7f8ea6 clientfield::set("demonic_circle_reveal", 1);
    }
    level.var_234807d9 = array("demonic_rune_lor", "demonic_rune_ulla", "demonic_rune_oth", "demonic_rune_zor", "demonic_rune_mar", "demonic_rune_uja");
    level.var_234807d9 = array::randomize(level.var_234807d9);
    level.var_289ae31d = [];
    level function_8700782f();
    level thread function_dc9521bc();
    level thread function_686645ab();
    while (!isdefined(level.var_6e68c0d8)) {
        wait 0.5;
    }
    level.var_6e68c0d8 function_3520622d(1);
    level thread function_cf05b763();
    level flag::wait_till("demon_gate_runes");
    if (isdefined(level.var_6e68c0d8)) {
        level.var_6e68c0d8.var_c3f90c95 = undefined;
        level.var_6e68c0d8.var_a53f437d = undefined;
    }
    level function_b9fe51c7();
    /#
        level flag::set("<dev string:x5a0>");
    #/
    level function_695d82fd();
    level.var_ca3b8551 = undefined;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xb404fc3, Offset: 0xa768
// Size: 0x132
function function_f3eb4a12() {
    /#
        level endon(#"hash_e896a88d");
        if (level flag::get("<dev string:x5a0>")) {
            return;
        }
    #/
    var_de75cc7c = getentarray("aq_dg_fossil_align", "script_noteworthy");
    foreach (var_7119a95d in var_de75cc7c) {
        var_7119a95d clientfield::set("fossil_reveal", 1);
        wait 1;
        var_7119a95d clientfield::set("init_demongate_fossil", 3);
        wait randomfloat(2);
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x9700ac31, Offset: 0xa8a8
// Size: 0x2f6
function function_8700782f() {
    /#
        level endon(#"hash_e896a88d");
        if (level flag::get("<dev string:x5a0>")) {
            return;
        }
    #/
    var_579f5f7 = getentarray("aq_dg_circle_rune_trig", "targetname");
    var_579f5f7 = array::randomize(var_579f5f7);
    var_49f8925e = struct::get_array("aq_dg_armor_rune_struct", "targetname");
    var_49f8925e = array::randomize(var_49f8925e);
    for (i = 1; i < 4; i++) {
        var_49f8925e[i].n_index = i;
        if (!isdefined(level.var_289ae31d)) {
            level.var_289ae31d = [];
        } else if (!isarray(level.var_289ae31d)) {
            level.var_289ae31d = array(level.var_289ae31d);
        }
        level.var_289ae31d[level.var_289ae31d.size] = var_49f8925e[i].script_noteworthy;
    }
    for (i = 0; i < 6; i++) {
        var_25b51f6b = var_579f5f7[i].script_noteworthy;
        var_5a2492d5 = var_579f5f7[i].script_label;
        var_49f8925e[i] thread function_f20a422b(var_25b51f6b, var_5a2492d5);
        if (isdefined(var_49f8925e[i].n_index)) {
            var_e046f594 = struct::get("aq_dg_rune_sequence_0" + var_49f8925e[i].n_index, "targetname");
            var_e046f594.var_a991b2d8 = var_25b51f6b;
        }
        var_579f5f7[i].var_483af51d = "fxexp_" + var_579f5f7[i].script_int;
        var_ca33ca2e = var_579f5f7[i].script_int + 1;
        var_579f5f7[i].var_6a1fa689 = "fxexp_" + var_ca33ca2e;
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x9a0158f3, Offset: 0xaba8
// Size: 0x17c
function function_3520622d(b_wait) {
    if (!isdefined(b_wait)) {
        b_wait = 1;
    }
    self endon(#"death");
    /#
        self endon(#"hash_3c5d2ca5");
    #/
    var_cd45655b = getent("aq_dg_urn_position", "targetname");
    foreach (var_300b5632 in level.var_289ae31d) {
        b_played = var_cd45655b zm_castle_vo::function_7c63dd65(var_300b5632, b_wait);
        if (!b_wait && !b_played) {
            return;
        }
    }
    var_ed01584 = 0;
    if (!(isdefined(self.var_c3f90c95) && self.var_c3f90c95)) {
        self.var_c3f90c95 = 1;
        var_ed01584 = 1;
    }
    var_cd45655b zm_castle_vo::function_f0b775a3("name", var_ed01584, b_wait);
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x10c931c9, Offset: 0xad30
// Size: 0x180
function function_cf05b763() {
    /#
        level endon(#"hash_e896a88d");
        if (level flag::get("<dev string:x5a0>")) {
            return;
        }
    #/
    level endon(#"demon_gate_runes");
    var_42ba5d5d = getent("aq_dg_urn_damage_trig", "targetname");
    while (true) {
        var_42ba5d5d waittill(#"damage", amount, attacker, direction, point, mod, tagname, modelname, partname, weapon);
        if (function_51a90202(weapon, 1, point, var_42ba5d5d) && attacker === level.var_6e68c0d8 && !level flag::get("rune_sequence_failed") && !(isdefined(level.var_f00f53e6) && level.var_f00f53e6)) {
            wait 1;
            level.var_6e68c0d8 function_3520622d(0);
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 2, eflags: 0x0
// Checksum 0xb7f7c4c3, Offset: 0xaeb8
// Size: 0x158
function function_f20a422b(var_25b51f6b, var_5a2492d5) {
    level endon(#"demon_gate_runes");
    self function_3313abd5();
    self.var_25b51f6b = var_25b51f6b;
    while (true) {
        self.var_67b5dd94 waittill(#"trigger", e_who);
        if (e_who === level.var_6e68c0d8) {
            e_who playrumbleonentity("zm_castle_quest_interact_rumble");
            level notify(#"hash_b24bc9eb");
            var_7b98b639 = util::spawn_model(var_25b51f6b, self.origin, self.angles);
            var_7b98b639 clientfield::set("demonic_rune_fx", 1);
            var_7b98b639 playsound("zmb_rune_armor");
            var_7b98b639 zm_castle_vo::function_ebc3d584(var_5a2492d5);
            wait 2;
            var_7b98b639 delete();
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xdae698ad, Offset: 0xb018
// Size: 0xf0
function function_686645ab() {
    level endon(#"demon_gate_runes");
    var_c199072a = getent("aq_dg_trophy_room_trig", "targetname");
    var_cd45655b = getent("aq_dg_urn_position", "targetname");
    while (true) {
        level waittill(#"hash_b24bc9eb");
        var_c199072a waittill(#"trigger", e_who);
        if (e_who === level.var_6e68c0d8) {
            var_cd45655b thread zm_castle_vo::function_c123b81c("ask_name", "vox_arro_demongate_ask_name_0");
            var_cd45655b zm_castle_vo::vo_say("vox_arro_demongate_ask_name_0");
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x3a347eb4, Offset: 0xb110
// Size: 0x5c
function function_dc9521bc() {
    zm_spawner::register_zombie_death_event_callback(&function_80d54dff);
    level function_afa0928d();
    zm_spawner::deregister_zombie_death_event_callback(&function_80d54dff);
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x4bad499d, Offset: 0xb178
// Size: 0x2d8
function function_afa0928d() {
    /#
        level endon(#"hash_e896a88d");
        if (level flag::get("<dev string:x5a0>")) {
            return;
        }
    #/
    level endon(#"demon_gate_runes");
    while (true) {
        str_notify = level util::waittill_any_return("demon_gate_runes", "demonic_rune_grabbed", "demonic_rune_timed_out");
        if (str_notify == "demonic_rune_grabbed") {
            /#
                if (isdefined(level.var_bb00a6cd)) {
                    if (!array::contains(level.var_234807d9, level.var_bb00a6cd)) {
                        continue;
                    }
                    arrayremovevalue(level.var_234807d9, level.var_bb00a6cd);
                    array::push_front(level.var_234807d9, level.var_bb00a6cd);
                    level.var_bb00a6cd = undefined;
                }
            #/
            var_29c3c8d1 = array::pop_front(level.var_234807d9, 0);
            var_579f5f7 = getentarray("aq_dg_circle_rune_trig", "targetname");
            foreach (var_8b67f364 in var_579f5f7) {
                var_f77214c2 = "demonic_rune_" + var_8b67f364.script_label;
                if (var_f77214c2 === var_29c3c8d1) {
                    var_8b67f364 thread function_b08d39a1();
                    var_7b98b639 = getent("aq_dg_circle_rune_" + var_8b67f364.script_label, "targetname");
                    var_7b98b639 clientfield::set("demonic_circle_reveal", 1);
                    exploder::exploder(var_8b67f364.var_483af51d);
                }
            }
            if (level.var_234807d9.size == 0) {
                return;
            }
            continue;
        }
        level.var_234807d9 = array::randomize(level.var_234807d9);
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0xbdbc50e7, Offset: 0xb458
// Size: 0x11e
function function_80d54dff(e_attacker) {
    if (!level flag::get("demonic_rune_dropped")) {
        if (self function_ab623d34(level.var_6e68c0d8)) {
            if (level.var_234807d9.size > 0 && randomfloat(1) <= 0.1) {
                self.no_powerups = 1;
                var_50ef61f9 = level.var_234807d9[0];
                level flag::set("demonic_rune_dropped");
                level._powerup_timeout_override = &zm_powerup_demonic_rune::function_5b767c2;
                level thread zm_powerups::specific_powerup_drop(var_50ef61f9, self.origin, undefined, undefined, undefined, level.var_6e68c0d8);
                level._powerup_timeout_override = undefined;
            }
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x16214f39, Offset: 0xb580
// Size: 0x1b8
function function_b08d39a1() {
    level endon(#"demon_gate_runes");
    while (true) {
        self waittill(#"damage", amount, attacker, direction, point, mod, tagname, modelname, partname, weapon);
        if (function_51a90202(weapon, 1, point, self) && attacker === level.var_6e68c0d8 && !level flag::get("rune_sequence_failed") && level.var_ca3b8551 < 4) {
            exploder::stop_exploder(self.var_483af51d);
            wait 0.05;
            exploder::exploder(self.var_6a1fa689);
            var_1430507e = "aq_dg_rune_sequence_0" + level.var_ca3b8551;
            var_8ab343c9 = struct::get(var_1430507e, "targetname");
            self thread function_ee73a771();
            var_8ab343c9 function_c85b7e17(self.script_noteworthy, self.script_label);
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x7500d0e1, Offset: 0xb740
// Size: 0x84
function function_ee73a771() {
    level endon(#"demon_gate_runes");
    level flag::wait_till("rune_sequence_failed");
    level flag::wait_till_clear("rune_sequence_failed");
    exploder::stop_exploder(self.var_6a1fa689);
    wait 0.05;
    exploder::exploder(self.var_483af51d);
}

// Namespace zm_castle_weap_quest_upgrade
// Params 2, eflags: 0x0
// Checksum 0x3e15aadd, Offset: 0xb7d0
// Size: 0x2b4
function function_c85b7e17(var_25b51f6b, var_5a2492d5) {
    level endon(#"demon_gate_runes");
    var_7b98b639 = util::spawn_model(var_25b51f6b, self.origin, self.angles);
    playsoundatposition("zmb_demon_runes_pop", var_7b98b639.origin);
    var_7b98b639 clientfield::set("demonic_rune_fx", 1);
    self.var_372cc5bb = var_7b98b639;
    if (self.var_a991b2d8 == var_25b51f6b) {
        playsoundatposition("zmb_demon_runes_confirm", var_7b98b639.origin);
    }
    var_cd45655b = getent("aq_dg_urn_position", "targetname");
    level.var_ca3b8551++;
    var_1fe3b628 = level.var_ca3b8551;
    if (!isdefined(level.var_4e2e87e9)) {
        level.var_4e2e87e9 = [];
    }
    if (isdefined(level.var_f00f53e6) && level.var_f00f53e6 || level.var_4e2e87e9.size > 0) {
        level.var_4e2e87e9[level.var_4e2e87e9.size] = var_5a2492d5;
    } else {
        level.var_f00f53e6 = 1;
        var_cd45655b zm_castle_vo::function_ebc3d584(var_5a2492d5, 1);
        if (level.var_ca3b8551 < 3) {
            if (isdefined(level.var_4e2e87e9) && level.var_4e2e87e9.size > 0) {
                foreach (var_cf6c6acd in level.var_4e2e87e9) {
                    var_cd45655b zm_castle_vo::function_ebc3d584(var_5a2492d5, 1);
                }
            }
        }
        level.var_f00f53e6 = undefined;
    }
    if (var_1fe3b628 > 3) {
        level thread function_9fc90424();
    }
    level flag::wait_till("rune_sequence_failed");
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xda816b73, Offset: 0xba90
// Size: 0x3c2
function function_9fc90424() {
    /#
        level endon(#"hash_32d99404");
    #/
    var_e4c7ad11 = 1;
    var_e488e3fa = struct::get_array("aq_dg_rune_sequence_struct", "script_noteworthy");
    foreach (var_e20408bb in var_e488e3fa) {
        if (var_e20408bb.var_372cc5bb.model != var_e20408bb.var_a991b2d8) {
            var_e4c7ad11 = 0;
            break;
        }
    }
    var_cd45655b = getent("aq_dg_urn_position", "targetname");
    if (isdefined(level.var_f00f53e6) && level.var_f00f53e6) {
        wait 0.5;
    }
    if (isdefined(level.var_4e2e87e9) && level.var_4e2e87e9.size > 0) {
        foreach (var_cf6c6acd in level.var_4e2e87e9) {
            var_cd45655b zm_castle_vo::function_ebc3d584(var_cf6c6acd, 1);
        }
        level.var_4e2e87e9 = undefined;
        level.var_f00f53e6 = undefined;
    }
    var_cd45655b zm_castle_vo::function_56c65986(var_e4c7ad11);
    if (var_e4c7ad11) {
        level flag::set("demon_gate_runes");
        playsoundatposition("zmb_demon_runes_complete", (-660, 1292, 565));
    } else {
        level flag::set("rune_sequence_failed");
        playsoundatposition("zmb_demon_runes_deny", (-660, 1292, 565));
        playrumbleonposition("zm_castle_quest_demon_gate_rune_fail_rumble", (-660, 1292, 565));
        level.var_ca3b8551 = 1;
        level function_bbc0c85c();
        level flag::clear("rune_sequence_failed");
    }
    playsoundatposition("zmb_demon_runes_reset", (-660, 1292, 565));
    foreach (var_e20408bb in var_e488e3fa) {
        var_e20408bb.var_372cc5bb delete();
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x22d4f3f3, Offset: 0xbe60
// Size: 0x92
function function_bbc0c85c() {
    var_9d162495 = getent("aq_dg_frenzy_align", "targetname");
    var_9d162495 clientfield::set("demongate_fossil_frenzy", 1);
    wait 24;
    var_9d162495 clientfield::set("demongate_fossil_frenzy", 0);
    wait 6;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x8a927f80, Offset: 0xbf00
// Size: 0x284
function function_b9fe51c7() {
    var_cd45655b = getent("aq_dg_urn_position", "targetname");
    var_cd45655b delete();
    var_579f5f7 = getentarray("aq_dg_circle_rune_trig", "targetname");
    foreach (var_8b67f364 in var_579f5f7) {
        exploder::stop_exploder(var_8b67f364.var_6a1fa689);
        exploder::stop_exploder(var_8b67f364.var_483af51d);
        var_8b67f364 delete();
    }
    var_6401348e = getentarray("aq_dg_demonic_circle_hurt_trigger", "script_noteworthy");
    array::run_all(var_6401348e, &delete);
    var_49f8925e = struct::get_array("aq_dg_armor_rune_struct", "targetname");
    foreach (var_4dc0df47 in var_49f8925e) {
        level zm_unitrigger::unregister_unitrigger(var_4dc0df47.var_67b5dd94);
    }
    var_c199072a = getent("aq_dg_trophy_room_trig", "targetname");
    var_c199072a delete();
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x62ffb49c, Offset: 0xc190
    // Size: 0x5c
    function function_b2f7fb48() {
        if (!level flag::get("<dev string:x58e>") || level flag::get("<dev string:x7ce>")) {
            return;
        }
        level function_bbc0c85c();
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x5e8b5ddc, Offset: 0xc1f8
    // Size: 0x162
    function function_8d7d2896() {
        if (!level flag::get("<dev string:x58e>") || level flag::get("<dev string:x5a0>") || level flag::get("<dev string:x7df>")) {
            return;
        }
        level flag::set("<dev string:x7ce>");
        level notify(#"hash_32d99404");
        var_e488e3fa = struct::get_array("<dev string:x7f4>", "<dev string:x1e7>");
        foreach (var_e20408bb in var_e488e3fa) {
            if (isdefined(var_e20408bb.var_372cc5bb)) {
                var_e20408bb.var_372cc5bb delete();
            }
        }
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0xbe6d5b2, Offset: 0xc368
    // Size: 0xbc
    function function_e896a88d() {
        if (level flag::get("<dev string:x5a0>")) {
            return;
        }
        if (!level flag::get("<dev string:x58e>")) {
            level function_2d151482();
        }
        exploder::exploder("<dev string:x80f>");
        wait 0.05;
        level flag::set("<dev string:x7ce>");
        level flag::set("<dev string:x5a0>");
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x7488cfca, Offset: 0xc430
// Size: 0x67c
function function_695d82fd() {
    /#
        level endon(#"hash_dc66bbef");
        if (level flag::get("<dev string:x5b3>")) {
            return;
        }
        level.var_b0d821dd = 1;
    #/
    var_7d849b98 = getent("aq_dg_outro_align", "targetname");
    var_7d849b98 clientfield::set("demongate_fossil_outro", 1);
    var_e1f8771e = getent("quest_demongate_urn", "targetname");
    var_e1f8771e scene::play("p7_fxanim_zm_castle_quest_demongate_urn_destroy_bundle");
    var_605e43a9 = struct::get("quest_reforge_demon_gate", "targetname");
    var_884470ed = var_605e43a9.angles + (0, 90, 0);
    var_884470ed *= (0, 1, 0);
    var_e8294063 = var_605e43a9.origin + (0, 0, -42);
    var_12ddc0c7 = spawn("script_origin", var_e8294063);
    var_12ddc0c7 playloopsound("zmb_demon_runes_portal", 1);
    mdl_anchor = util::spawn_model("tag_origin", var_e8294063, var_884470ed);
    mdl_anchor clientfield::set("demongate_quest_portal", 1);
    /#
        level.var_a81ca85 = mdl_anchor;
    #/
    var_605e43a9 function_3313abd5();
    while (true) {
        var_605e43a9.var_67b5dd94 waittill(#"trigger", e_who);
        if (e_who === level.var_6e68c0d8) {
            level notify(#"hash_768bea1d");
            var_12ddc0c7 stoploopsound(10);
            var_12ddc0c7 playsound("zmb_broken_arrow_pieces");
            e_who playrumbleonentity("zm_castle_quest_interact_rumble");
            level scene::play("p7_fxanim_zm_castle_quest_demon_arrow_broken_reform_bundle");
            mdl_anchor clientfield::set("demongate_quest_portal", 0);
            level scene::init("p7_fxanim_zm_castle_quest_demon_arrow_whole_reform_bundle");
            exploder::exploder("lgt_Demon_Gate");
            var_12ddc0c7 playsound("zmb_demon_runes_portal_vanish");
            level waittill(#"hash_66b2458c");
            var_12ddc0c7 delete();
            level thread scene::play("p7_fxanim_zm_castle_quest_demon_arrow_whole_reform_bundle");
            break;
        }
    }
    var_605e43a9.var_67b5dd94.prompt_and_visibility_func = &function_8c1fd619;
    var_605e43a9.var_67b5dd94 function_c1947ff7();
    while (true) {
        var_605e43a9.var_67b5dd94 waittill(#"trigger", e_who);
        if (isdefined(level.var_6e68c0d8)) {
            if (e_who == level.var_6e68c0d8) {
                break;
            }
            continue;
        }
        if (!array::contains(level.var_427e7668, e_who)) {
            level.var_6e68c0d8 = e_who;
            level.var_427e7668[level.var_427e7668.size] = e_who;
            level clientfield::set("quest_owner_demon", function_85bfa3fd(e_who.characterindex));
            break;
        }
        e_who notify(#"quest_swap");
        level function_7910311b(e_who);
        level.var_6e68c0d8 = e_who;
        level clientfield::set("quest_owner_demon", function_85bfa3fd(e_who.characterindex));
        break;
    }
    e_who playsound("zmb_arrow_reforged");
    e_who playrumbleonentity("zm_castle_quest_interact_rumble");
    zm_unitrigger::unregister_unitrigger(var_605e43a9.var_67b5dd94);
    var_605e43a9 thread function_42084ad5(level.var_6e68c0d8);
    level flag::set("demon_gate_repaired");
    level.var_72a6d56b delete();
    level.var_72a6d56b = getent("quest_demongate_arrow_whole_reform", "targetname");
    level.var_72a6d56b hide();
    level thread function_15894f24(mdl_anchor);
    exploder::stop_exploder("fxexp_301");
    exploder::stop_exploder("lgt_Demon_Gate");
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x502c6357, Offset: 0xcab8
// Size: 0x404
function function_15894f24(var_2f975510) {
    /#
        level endon(#"hash_dc66bbef");
    #/
    level clientfield::set("demongate_client_cleanup", 1);
    var_4da6e012 = getent("aq_dg_flagstone_seal", "targetname");
    var_4da6e012 moveto(var_4da6e012.origin + (0, 0, 48), 3, 0, 1);
    var_9d162495 = getent("aq_dg_frenzy_align", "targetname");
    var_9d162495 delete();
    var_7d849b98 = getent("aq_dg_outro_align", "targetname");
    var_7d849b98 delete();
    var_d8107c7c = getent("aq_dg_urn_damage_trig", "targetname");
    var_d8107c7c delete();
    var_f91a2b6a = getentarray("aq_dg_fossil_align", "script_noteworthy");
    array::run_all(var_f91a2b6a, &delete);
    zm_spawner::deregister_zombie_death_event_callback(&function_561017d8);
    var_5b00744f = getentarray("aq_dg_circle_rune", "script_noteworthy");
    foreach (var_93bfc42c in var_5b00744f) {
        var_93bfc42c clientfield::set("demonic_circle_reveal", 0);
    }
    var_6b525fd2 = getentarray("aq_dg_circle_rune_outline", "script_noteworthy");
    foreach (var_1edecb83 in var_6b525fd2) {
        var_1edecb83 clientfield::set("demonic_circle_reveal", 0);
    }
    var_90cbeda9 = getent("aq_dg_demonic_circle", "targetname");
    var_90cbeda9 clientfield::set("demonic_circle_reveal", 0);
    wait 5;
    var_2f975510 delete();
    var_90cbeda9 delete();
    array::run_all(var_6b525fd2, &delete);
    array::run_all(var_5b00744f, &delete);
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0xeeae1144, Offset: 0xcec8
    // Size: 0x41c
    function function_dc66bbef() {
        if (level flag::get("<dev string:x5b3>")) {
            return;
        }
        if (!level flag::get("<dev string:x5a0>")) {
            level function_e896a88d();
        }
        level flag::set("<dev string:x5b3>");
        level flag::set("<dev string:x819>");
        exploder::stop_exploder("<dev string:x683>");
        if (!(isdefined(level.var_b0d821dd) && level.var_b0d821dd)) {
            var_7d849b98 = getent("<dev string:x82d>", "<dev string:x141>");
            var_7d849b98 clientfield::set("<dev string:x83f>", 1);
            var_e1f8771e = getent("<dev string:x856>", "<dev string:x141>");
            var_e1f8771e scene::skipto_end("<dev string:x86a>");
        }
        if (isdefined(level.var_a81ca85)) {
            level.var_a81ca85 clientfield::set("<dev string:x8a1>", 0);
            wait 0.05;
            level.var_a81ca85 delete();
        }
        s_urn = struct::get("<dev string:x68d>", "<dev string:x141>");
        if (isdefined(s_urn.var_67b5dd94)) {
            zm_unitrigger::unregister_unitrigger(s_urn.var_67b5dd94);
        }
        var_90cbeda9 = getent("<dev string:x77c>", "<dev string:x141>");
        var_90cbeda9 delete();
        var_9d162495 = getent("<dev string:x8b8>", "<dev string:x141>");
        var_9d162495 delete();
        var_7d849b98 = getent("<dev string:x82d>", "<dev string:x141>");
        var_7d849b98 delete();
        var_d8107c7c = getent("<dev string:x8cb>", "<dev string:x141>");
        var_d8107c7c delete();
        var_f91a2b6a = getentarray("<dev string:x7a7>", "<dev string:x1e7>");
        array::run_all(var_f91a2b6a, &delete);
        var_5b00744f = getentarray("<dev string:x8e1>", "<dev string:x1e7>");
        array::run_all(var_5b00744f, &delete);
        var_6b525fd2 = getentarray("<dev string:x8f3>", "<dev string:x1e7>");
        array::run_all(var_6b525fd2, &delete);
        zm_spawner::deregister_zombie_death_event_callback(&function_561017d8);
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x3a7d5f6f, Offset: 0xd2f0
// Size: 0x24
function function_983083c(e_attacker) {
    self thread function_894eef8b();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x6d0ed36c, Offset: 0xd320
// Size: 0x18c
function function_894eef8b() {
    e_volume = getent("aq_statue_volume", "targetname");
    if (isdefined(self) && self istouching(e_volume) && self.attacker === level.var_6e68c0d8) {
        var_30554f8f = struct::get("upgraded_bow_struct_demon_gate", "targetname");
        level function_55c48922(self.origin, var_30554f8f.origin, "demon", isdefined(self.missinglegs) && self.missinglegs);
        var_30554f8f.var_ce58f456++;
        if (var_30554f8f.var_ce58f456 >= 20) {
            level flag::set("demon_gate_upgraded");
            mdl_arrow = getent("pedestal_demon_bow_place", "targetname");
            mdl_arrow playsound("evt_arrow_souls_ready");
            mdl_arrow thread function_bf26d3fb("arrow_charge_wolf_fx");
        }
    }
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x172eeb45, Offset: 0xd4b8
    // Size: 0x2d4
    function function_8c23a1c7() {
        if (level flag::get("<dev string:x90d>")) {
            return;
        }
        if (!level flag::get("<dev string:x5b3>")) {
            level function_dc66bbef();
        }
        level flag::set("<dev string:x5cc>");
        zm_spawner::deregister_zombie_death_event_callback(&function_983083c);
        var_dfd1c443 = struct::get("<dev string:x921>", "<dev string:x141>");
        if (isdefined(var_dfd1c443.var_67b5dd94)) {
            zm_unitrigger::unregister_unitrigger(var_dfd1c443.var_67b5dd94);
        }
        if (!(isdefined(level.var_3adad02d) && level.var_3adad02d)) {
            level scene::play("<dev string:x940>");
        }
        level scene::play("<dev string:x975>");
        level flag::set("<dev string:x90d>");
        arrayremovevalue(level.var_427e7668, level.var_6e68c0d8);
        level.var_6e68c0d8 = undefined;
        level clientfield::set("<dev string:x667>", 0);
        level function_f5e9876("<dev string:x9a9>", 6);
        if (!isdefined(level.var_e8a6b6f7)) {
            level.var_e8a6b6f7 = [];
            array::thread_all(level.players, &function_b584c1e);
            callback::on_connect(&function_7c48f9d8);
        }
        level flag::set("<dev string:x9af>");
        var_dfd1c443.var_d4a62e6b = getent("<dev string:x9c2>", "<dev string:x141>");
        var_dfd1c443 thread function_fb704679();
        level clientfield::set("<dev string:x9e0>", 1);
        level function_2c1c1d3e("<dev string:x9f9>");
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x2f4d4f5b, Offset: 0xd798
// Size: 0x23c
function wolf_howl() {
    /#
        level flag::init("<dev string:xa04>");
        level flag::init("<dev string:xa16>");
        level flag::init("<dev string:xa29>");
        level flag::init("<dev string:xa3c>");
        level flag::init("<dev string:xa54>");
        level flag::init("<dev string:xa6a>");
    #/
    level function_8d77e4c4();
    level wolf_howl_paintings();
    /#
        level flag::set("<dev string:xa04>");
    #/
    level function_f5e9876("wolf", 1);
    level function_37acbc24();
    /#
        level flag::set("<dev string:xa16>");
    #/
    level wolf_howl_escort();
    /#
        level flag::set("<dev string:xa29>");
    #/
    level function_f5e9876("wolf", 4);
    level function_47f43d75();
    /#
        level flag::set("<dev string:xa3c>");
    #/
    var_afd26121 = struct::get("upgraded_bow_struct_wolf_howl", "targetname");
    var_afd26121 function_14dd5ea5();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xc16b8590, Offset: 0xd9e0
// Size: 0x194
function function_8d77e4c4() {
    level flag::init("wolf_howl_paintings");
    level flag::init("wolf_howl_escort");
    level flag::init("wolf_howl_repaired");
    level flag::init("wolf_howl_placed");
    level flag::init("wolf_howl_upgraded");
    level flag::init("wolf_howl_spawned");
    level.var_f1193c94 = 0;
    var_cc64ecfb = getent("aq_wh_skadi_skull", "targetname");
    var_cc64ecfb hide();
    var_dddbfe51 = getent("aq_wh_ledge_collision", "targetname");
    var_dddbfe51 notsolid();
    var_d29c128e = getent("aq_wh_burial_chamber_symbol", "targetname");
    var_d29c128e hide();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x8a465743, Offset: 0xdb80
// Size: 0x36c
function wolf_howl_paintings() {
    /#
        level endon(#"hash_2a8e7fe2");
    #/
    var_da042480 = array("p7_zm_ctl_kings_painting_01", "p7_zm_ctl_kings_painting_02", "p7_zm_ctl_kings_painting_03", "p7_zm_ctl_kings_painting_04");
    var_18f50dca = struct::get_array("aq_wh_painting_struct", "script_noteworthy");
    var_18f50dca = array::randomize(var_18f50dca);
    for (i = 0; i < 4; i++) {
        var_18f50dca[i] function_3313abd5(&function_47b1e30a);
        var_18f50dca[i] thread function_2601ae75(i, var_18f50dca);
        var_18f50dca[i].var_b5b31795 = util::spawn_model(var_da042480[i], var_18f50dca[i].origin, var_18f50dca[i].angles);
    }
    level flag::wait_till("wolf_howl_paintings");
    foreach (var_48c991cb in var_18f50dca) {
        zm_unitrigger::unregister_unitrigger(var_48c991cb.var_67b5dd94);
    }
    s_arrow = struct::get("quest_start_wolf_howl");
    s_arrow function_5e09adfd();
    /#
        level.var_e921c50c = 1;
    #/
    level thread scene::play("p7_fxanim_zm_castle_quest_wolf_wall_explode_bundle");
    level thread scene::play("p7_fxanim_zm_castle_quest_wolf_arrow_broken_reveal_bundle");
    level waittill(#"hash_44c83018");
    foreach (e_player in level.activeplayers) {
        e_player.var_b89ed4e5 = undefined;
    }
    level.var_eee1576 = getent("quest_wolf_arrow_broken_reveal", "targetname");
    s_arrow function_f708e6b2();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 2, eflags: 0x0
// Checksum 0x741ca08b, Offset: 0xdef8
// Size: 0x254
function function_2601ae75(var_c37a8358, var_18f50dca) {
    /#
        level endon(#"hash_2a8e7fe2");
    #/
    level endon(#"wolf_howl_paintings");
    var_e1041201 = getweapon("elemental_bow");
    while (true) {
        self.var_67b5dd94 waittill(#"trigger", e_who);
        if (e_who hasweapon(var_e1041201) || e_who function_fae23b43()) {
            if (level.var_f1193c94 == var_c37a8358) {
                e_who playrumbleonentity("zm_castle_quest_interact_rumble");
                self.var_b5b31795 clientfield::set("painting_symbol_reveal", 1);
                playsoundatposition("zmb_painting_correct", self.origin);
                e_who thread zm_castle_vo::function_5fa306b6(var_c37a8358 + 1);
                if (var_c37a8358 == 3) {
                    level flag::set("wolf_howl_paintings");
                }
                level.var_f1193c94++;
                continue;
            }
            if (level.var_f1193c94 != var_c37a8358 + 1) {
                e_who playrumbleonentity("zm_castle_quest_interact_rumble");
                for (i = 0; i < level.var_f1193c94; i++) {
                    var_18f50dca[i].var_b5b31795 clientfield::set("painting_symbol_reveal", 0);
                }
                self.var_b5b31795 clientfield::increment("painting_symbol_blink");
                playsoundatposition("zmb_painting_wrong", self.origin);
                level.var_f1193c94 = 0;
            }
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x22cfe14f, Offset: 0xe158
// Size: 0x1a4
function function_5e09adfd() {
    playsoundatposition("zmb_painting_complete", (-830, 2312, 1276));
    s_unitrigger = spawnstruct();
    s_unitrigger.origin = self.origin + (-12, -72, 0);
    s_unitrigger.angles = self.angles;
    s_unitrigger.script_unitrigger_type = "unitrigger_box";
    s_unitrigger.cursor_hint = "HINT_NOICON";
    s_unitrigger.require_look_at = 0;
    s_unitrigger.script_length = 384;
    s_unitrigger.script_width = 312;
    s_unitrigger.script_height = 120;
    s_unitrigger.prompt_and_visibility_func = &function_47b1e30a;
    zm_unitrigger::register_static_unitrigger(s_unitrigger, &function_573ca470);
    s_unitrigger waittill(#"trigger", e_who);
    playsoundatposition("zmb_wolf_arrow_grab", (-1176, 2206, 547));
    e_who thread function_4bc49ad0();
    zm_unitrigger::unregister_unitrigger(s_unitrigger);
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xba31c72b, Offset: 0xe308
// Size: 0x34
function function_4bc49ad0() {
    wait 1.5;
    self zm_audio::create_and_play_dialog("quest", "painting");
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0xba727e44, Offset: 0xe348
    // Size: 0xec
    function function_2bac97b4() {
        var_18f50dca = struct::get_array("<dev string:xa7a>", "<dev string:x1e7>");
        foreach (var_48c991cb in var_18f50dca) {
            var_48c991cb.var_b5b31795 clientfield::set("<dev string:xa90>", 1);
        }
        level flag::set("<dev string:xaa7>");
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0xb3445d84, Offset: 0xe440
    // Size: 0xb0
    function function_64b2bde9() {
        if (isdefined(level.var_e921c50c) && level.var_e921c50c) {
            level scene::init("<dev string:xabb>");
            level scene::init("<dev string:xaee>");
            level.var_e921c50c = undefined;
            return;
        }
        level thread scene::play("<dev string:xabb>");
        level thread scene::play("<dev string:xaee>");
        level.var_e921c50c = 1;
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0xc89a5456, Offset: 0xe4f8
    // Size: 0x204
    function function_2a8e7fe2() {
        if (level flag::get("<dev string:xa04>")) {
            return;
        }
        level thread zm_castle_weap_quest::function_a01a53de();
        level.var_52978d72 = level.players[0];
        level clientfield::set("<dev string:xb28>", function_85bfa3fd(level.var_52978d72.characterindex));
        level.var_427e7668[level.var_427e7668.size] = level.players[0];
        var_18f50dca = struct::get_array("<dev string:xa7a>", "<dev string:x1e7>");
        foreach (var_48c991cb in var_18f50dca) {
            if (isdefined(var_48c991cb.var_67b5dd94)) {
                zm_unitrigger::unregister_unitrigger(var_48c991cb.var_67b5dd94);
            }
        }
        if (!(isdefined(level.var_e921c50c) && level.var_e921c50c)) {
            level thread scene::skipto_end("<dev string:xabb>");
            level thread scene::skipto_end("<dev string:xaee>");
            level thread function_15f112ea();
        }
        level flag::set("<dev string:xa04>");
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x227fa370, Offset: 0xe708
    // Size: 0x4c
    function function_15f112ea() {
        wait 1;
        level.var_eee1576 = getent("<dev string:xb39>", "<dev string:x141>");
        level.var_eee1576 hide();
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x718372c2, Offset: 0xe760
// Size: 0x68
function function_37acbc24() {
    /#
        level endon(#"hash_5643d04b");
        if (level flag::get("<dev string:xa16>")) {
            return;
        }
    #/
    level.var_a1e95710 = &function_15a6ff6a;
    level thread function_15a6ff6a();
    level waittill(#"hash_88b82583");
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x874a667a, Offset: 0xe7d0
// Size: 0x1ba
function function_15a6ff6a() {
    /#
        level endon(#"hash_5643d04b");
        level.var_52978d72 endon(#"hash_3c5d2ca5");
        if (level flag::get("<dev string:xa16>")) {
            return;
        }
    #/
    level.var_52978d72 endon(#"death");
    level.var_52978d72 endon(#"quest_swap");
    level.var_52978d72 thread function_d62aa556();
    var_f7019ef = getent("aq_wh_skull_shrine_trig", "targetname");
    while (true) {
        level.var_52978d72 waittill(#"projectile_impact", weapon, point, radius, attacker, normal);
        if (function_51a90202(weapon, 1, point, var_f7019ef)) {
            playsoundatposition("zmb_wolf_shrine_location", (5350, -1659, -1135));
            mdl_skull = getent("wolf_skull_roll_down", "targetname");
            mdl_skull thread function_262d06db();
            level function_f5e9876("wolf", 2);
            return;
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xd8a082bd, Offset: 0xe998
// Size: 0x314
function function_d62aa556() {
    /#
        level endon(#"hash_5643d04b");
        self endon(#"hash_3c5d2ca5");
        if (level flag::get("<dev string:xa16>")) {
            return;
        }
    #/
    self endon(#"bleed_out");
    self endon(#"death");
    self endon(#"quest_swap");
    level endon(#"hash_80b27882");
    var_c068b13 = getent("aq_wh_shrine_rumble_volume", "targetname");
    var_55b8fc1d = getent("aq_wh_skull_shrine_trig", "targetname");
    var_9fc43621 = var_55b8fc1d.origin;
    var_4a166ae5 = 0.7;
    while (true) {
        if (self istouching(var_c068b13)) {
            var_ac3d0ec3 = 1;
            var_b9f3ddcc = self getplayercamerapos();
            var_bff77cb5 = anglestoforward(self getplayerangles());
            var_744d3805 = vectornormalize(var_9fc43621 - var_b9f3ddcc);
            n_dot = vectordot(var_744d3805, var_bff77cb5);
            if (n_dot > 0.9) {
                var_ac3d0ec3 = 0.3;
                n_scale = 1;
                str_rumble = "zm_castle_quest_wolf_howl_shrine_heavy_rumble";
            } else if (n_dot <= 0.5) {
                n_dot = 0.5;
                n_scale = n_dot / 0.9;
                var_f6b0cbe4 = n_scale * var_4a166ae5;
                var_ac3d0ec3 = 0.3 + var_f6b0cbe4;
                str_rumble = "zm_castle_quest_wolf_howl_shrine_light_rumble";
            } else {
                n_scale = n_dot / 0.9;
                var_f6b0cbe4 = n_scale * var_4a166ae5;
                var_ac3d0ec3 = 0.3 + var_f6b0cbe4;
                str_rumble = "zm_castle_quest_wolf_howl_shrine_light_rumble";
            }
        } else {
            var_ac3d0ec3 = undefined;
        }
        if (isdefined(var_ac3d0ec3)) {
            wait var_ac3d0ec3;
            self playrumbleonentity(str_rumble);
            continue;
        }
        wait 0.05;
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xc89e94d0, Offset: 0xecb8
// Size: 0x160
function function_262d06db() {
    /#
        level endon(#"hash_5643d04b");
        if (level flag::get("<dev string:xa16>")) {
            return;
        }
    #/
    level notify(#"hash_80b27882");
    level.var_a1e95710 = undefined;
    level scene::play("p7_fxanim_zm_castle_quest_wolf_skull_roll_down_bundle");
    self function_3313abd5();
    while (true) {
        self.var_67b5dd94 waittill(#"trigger", e_who);
        if (e_who === level.var_52978d72) {
            e_who playsound("zmb_skull_pickup");
            e_who playrumbleonentity("zm_castle_quest_interact_rumble");
            zm_unitrigger::unregister_unitrigger(self.var_67b5dd94);
            self clientfield::set("wolf_howl_bone_fx", 0);
            wait 0.05;
            self delete();
            level notify(#"hash_88b82583");
            return;
        }
    }
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0xaecbdacc, Offset: 0xee20
    // Size: 0x84
    function function_5643d04b() {
        if (level flag::get("<dev string:xa16>")) {
            return;
        }
        if (!level flag::get("<dev string:xa04>")) {
            level function_2a8e7fe2();
        }
        level.var_a1e95710 = undefined;
        level flag::set("<dev string:xa16>");
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xaabf7dd1, Offset: 0xeeb0
// Size: 0x24c
function wolf_howl_escort() {
    /#
        level endon(#"hash_3429d04c");
        if (level flag::get("<dev string:xa29>")) {
            return;
        }
    #/
    var_b0f0d742 = getentarray("aq_wh_dig_volume", "script_noteworthy");
    foreach (var_a2094333 in var_b0f0d742) {
        var_a2094333 flag::init("dig_spot_complete");
        var_a2094333.var_252d000d = 0;
    }
    if (isdefined(level.var_52978d72)) {
        level.var_52978d72.var_a9e7283f = 1;
    }
    level.var_de642fb0 = array("aq_wh_dig_struct_courtyard", "aq_wh_dig_struct_road", "aq_wh_dig_struct_undercroft");
    level function_b9485994();
    level function_f5e9876("wolf", 3);
    mdl_skull = getent("aq_wh_skadi_skull", "targetname");
    mdl_skull show();
    level function_4e530cb();
    wait 2;
    level.var_52978d72 zm_audio::create_and_play_dialog("quest", "skadi_encounter");
    level.var_a94b846f = 1;
    level flag::wait_till("wolf_howl_escort");
    level.var_e6d07014 function_11dbf9f2();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xdf90f7f6, Offset: 0xf108
// Size: 0xe2
function function_b9485994() {
    mdl_skull = getent("aq_wh_skadi_skull", "targetname");
    mdl_skull function_3313abd5();
    while (true) {
        mdl_skull.var_67b5dd94 waittill(#"trigger", e_who);
        if (e_who === level.var_52978d72) {
            mdl_skull playsound("zmb_skull_restore");
            e_who playrumbleonentity("zm_castle_quest_interact_rumble");
            zm_unitrigger::unregister_unitrigger(mdl_skull.var_67b5dd94);
            return;
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x6c394152, Offset: 0xf1f8
// Size: 0x7c
function function_4e530cb() {
    level.var_e6d07014 = function_286f3904();
    wait 0.05;
    level.var_e6d07014 scene::play("ai_zm_dlc1_wolf_howl_entry", array(level.var_e6d07014));
    wait 0.05;
    level.var_e6d07014 thread function_a370259a();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x4292ab51, Offset: 0xf280
// Size: 0x1d0
function function_286f3904() {
    sp_skadi = getent("sp_skadi", "targetname");
    var_e6d07014 = sp_skadi spawnfromspawner("skadi", 1);
    var_e6d07014.allow_zombie_to_target_ai = 0;
    var_e6d07014 setcandamage(0);
    var_e6d07014 ai::set_behavior_attribute("sprint", 0);
    var_e6d07014 ai::set_ignoreall(1);
    var_e6d07014 ai::set_ignoreme(1);
    var_e6d07014 setteam("allies");
    var_e6d07014 function_1762804b(0);
    var_e6d07014 setplayercollision(0);
    var_e6d07014 clientfield::set("wolf_ghost_shader", 1);
    var_e6d07014 clientfield::set("wolf_footprint_fx", 1);
    var_e6d07014 clientfield::set("wolf_trail_fx", 1);
    var_e6d07014 clientfield::set("direwolf_eye_glow_fx", 0);
    var_e6d07014 playloopsound("zmb_wolf_fx");
    return var_e6d07014;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x61a304d5, Offset: 0xf458
// Size: 0x1b4
function function_a370259a() {
    /#
        level endon(#"hash_3429d04c");
    #/
    level endon(#"hash_e168806b");
    foreach (var_60b3742e in level.var_de642fb0) {
        if (var_60b3742e == "aq_wh_dig_struct_road" && !zm_zonemgr::zone_is_enabled("zone_tram_to_gatehouse")) {
            var_a968f748 = struct::get("aq_wh_road_door_struct", "targetname");
            self function_4e1572f1(var_a968f748);
            if (!zm_zonemgr::zone_is_enabled("zone_tram_to_gatehouse")) {
                level thread function_e168806b();
            }
        }
        var_edc16366 = struct::get(var_60b3742e, "targetname");
        self function_4e1572f1(var_edc16366);
        var_edc16366 function_391f894a();
    }
    level flag::set("wolf_howl_escort");
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0xac0f8b1d, Offset: 0xf618
// Size: 0x2cc
function function_4e1572f1(var_fb110e7d) {
    /#
        level endon(#"hash_3429d04c");
    #/
    level endon(#"hash_e168806b");
    self clientfield::set("wolf_trail_fx", 2);
    self setgoal(var_fb110e7d.origin, 0, 24);
    if (isdefined(level.var_52978d72)) {
        level.var_52978d72 thread function_3fe2741d();
    }
    self waittill(#"goal");
    if (var_fb110e7d.targetname != "aq_wh_road_door_struct") {
        self clientfield::set("wolf_footprint_fx", 0);
        self clientfield::set("wolf_trail_fx", 1);
        var_b42dfef4 = struct::get(var_fb110e7d.targetname + "_aggro", "targetname");
        level notify(#"skadi_reached_dig_spot");
        level thread function_560d53c2();
        self scene::play("ai_zm_dlc1_wolf_howl_paw_ground", array(level.var_e6d07014));
        mdl_bones = getent("aq_wh_bones_" + var_fb110e7d.script_label, "targetname");
        mdl_bones clientfield::set("wolf_howl_bone_fx", 1);
        exploder::exploder("lgt_wolf_quest_" + var_fb110e7d.script_label);
        level.var_e6d07014 clientfield::set("wolf_footprint_fx", 1);
        wait 0.05;
        self setgoal(var_b42dfef4.origin, 0, 4);
        self waittill(#"goal");
        level.var_e6d07014 clientfield::set("wolf_footprint_fx", 0);
        self scene::init("ai_zm_dlc1_wolf_howl_aggro", array(level.var_e6d07014));
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xe5939304, Offset: 0xf8f0
// Size: 0xb0
function function_560d53c2() {
    wait 1.5;
    if (isdefined(level.var_52978d72) && level.var_52978d72 util::is_looking_at(level.var_e6d07014, 0.5, 1) && !(isdefined(level.var_52978d72.var_16002883) && level.var_52978d72.var_16002883)) {
        level.var_52978d72 zm_audio::create_and_play_dialog("quest", "skadi_mound");
        level.var_52978d72.var_16002883 = 1;
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xa8c98553, Offset: 0xf9a8
// Size: 0xfc
function function_3fe2741d() {
    /#
        level endon(#"hash_3429d04c");
        level endon(#"hash_4d557400");
    #/
    level endon(#"skadi_reached_dig_spot");
    self notify(#"player_found_skadi");
    self endon(#"player_found_skadi");
    self thread function_75926d72();
    str_notify = self util::function_183e3618("player_found_skadi", "player_lost_skadi", "death", "quest_swap", level, "skadi_reached_dig_spot");
    if (str_notify == "player_lost_skadi") {
        if (isdefined(level.var_a94b846f) && level.var_a94b846f) {
            self thread function_4e062a23();
        }
        wait 16;
    }
    level function_e168806b();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x50f18a04, Offset: 0xfab0
// Size: 0x5e
function function_4e062a23() {
    self endon(#"death");
    self endon(#"quest_swap");
    self endon(#"player_found_skadi");
    wait 2;
    self zm_audio::create_and_play_dialog("quest", "skadi_far");
    level.var_a94b846f = undefined;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x809f2160, Offset: 0xfb18
// Size: 0x12c
function function_e168806b() {
    /#
        level endon(#"hash_3429d04c");
    #/
    level notify(#"hash_e168806b");
    level.var_e6d07014 clientfield::set("wolf_ghost_shader", 0);
    level.var_e6d07014 clientfield::set("wolf_trail_fx", 0);
    level.var_e6d07014 scene::play("ai_zm_dlc1_wolf_howl_howling", array(level.var_e6d07014));
    level.var_e6d07014 clientfield::set("wolf_footprint_fx", 0);
    wait 0.05;
    level.var_e6d07014 delete();
    zm_spawner::deregister_zombie_death_event_callback(&function_d0d62870);
    level function_b9485994();
    level thread function_4e530cb();
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x4636c85d, Offset: 0xfc50
    // Size: 0x84
    function function_5928a2a7() {
        if (!isdefined(level.var_e6d07014) || !level flag::get("<dev string:xa16>") || level flag::get("<dev string:xa29>")) {
            return;
        }
        level notify(#"hash_4d557400");
        level.var_b9c00aec = undefined;
        level function_e168806b();
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x690dfc94, Offset: 0xfce0
// Size: 0x140
function function_75926d72() {
    /#
        level endon(#"hash_3429d04c");
        level endon(#"hash_4d557400");
        self endon(#"hash_3c5d2ca5");
    #/
    level endon(#"skadi_reached_dig_spot");
    level endon(#"hash_e168806b");
    level endon(#"player_found_skadi");
    self endon(#"death");
    self endon(#"quest_swap");
    while (true) {
        if (isdefined(self.var_a9e7283f) && self.var_a9e7283f && !self util::is_looking_at(level.var_e6d07014, 0, 1)) {
            self.var_a9e7283f = 0;
            self notify(#"player_lost_skadi");
        } else if (!(isdefined(self.var_a9e7283f) && self.var_a9e7283f) && self util::is_looking_at(level.var_e6d07014, 0, 1)) {
            self.var_a9e7283f = 1;
            self thread function_3fe2741d();
        }
        wait 0.25;
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x24d3117c, Offset: 0xfe28
// Size: 0x21c
function function_391f894a() {
    /#
        level endon(#"hash_3429d04c");
        level endon(#"hash_4d557400");
    #/
    var_5d60f70c = getent("aq_wh_dig_volume_" + self.script_label, "targetname");
    /#
        level.var_b9c00aec = var_5d60f70c;
    #/
    if (isdefined(level.var_e6d07014)) {
        level.var_e6d07014.var_5c4d212e = var_5d60f70c;
    } else {
        return;
    }
    zm_spawner::register_zombie_death_event_callback(&function_d0d62870);
    var_5d60f70c flag::wait_till("dig_spot_complete");
    /#
        level.var_b9c00aec = undefined;
    #/
    zm_spawner::deregister_zombie_death_event_callback(&function_d0d62870);
    array::pop_front(level.var_de642fb0);
    level.var_e6d07014 scene::play("ai_zm_dlc1_wolf_howl_aggro", array(level.var_e6d07014));
    level.var_e6d07014 clientfield::set("wolf_footprint_fx", 1);
    wait 0.05;
    level.var_e6d07014 setgoal(self.origin, 0, 24);
    level.var_e6d07014 waittill(#"goal");
    level.var_e6d07014 clientfield::set("wolf_footprint_fx", 0);
    self function_af36e4b0();
    level.var_e6d07014 clientfield::set("wolf_footprint_fx", 1);
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x84f19337, Offset: 0x10050
    // Size: 0x34
    function function_a3638154() {
        if (isdefined(level.var_b9c00aec)) {
            level.var_b9c00aec flag::set("<dev string:xb58>");
        }
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x51bcd502, Offset: 0x10090
// Size: 0x24
function function_d0d62870(e_attacker) {
    self thread function_986cf5cf();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x1d9f4427, Offset: 0x100c0
// Size: 0x114
function function_986cf5cf() {
    if (isdefined(level.var_e6d07014)) {
        e_volume = level.var_e6d07014.var_5c4d212e;
    } else {
        return;
    }
    if (self function_ab623d34(level.var_52978d72, e_volume)) {
        mdl_bones = getent(e_volume.target, "targetname");
        level function_55c48922(self.origin, mdl_bones.origin, "wolf", isdefined(self.missinglegs) && self.missinglegs);
        e_volume.var_252d000d++;
        if (e_volume.var_252d000d >= 10) {
            e_volume flag::set("dig_spot_complete");
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x1f81ad53, Offset: 0x101e0
// Size: 0x2ce
function function_af36e4b0() {
    /#
        level endon(#"hash_3429d04c");
    #/
    level thread scene::play("p7_fxanim_zm_castle_quest_wolf_dig_" + self.script_label + "_bundle");
    level.var_e6d07014 scene::play("ai_zm_dlc1_wolf_howl_dig", array(level.var_e6d07014));
    wait 0.05;
    var_5bd66bb5 = struct::get(self.targetname + "_aggro", "targetname");
    level.var_e6d07014 setgoal(var_5bd66bb5.origin, 0, 4);
    mdl_bones = getent("aq_wh_bones_" + self.script_label, "targetname");
    mdl_bones function_3313abd5(undefined, undefined, mdl_bones.origin + (0, 0, 30));
    while (true) {
        mdl_bones.var_67b5dd94 waittill(#"trigger", e_who);
        if (e_who === level.var_52978d72) {
            zm_unitrigger::unregister_unitrigger(mdl_bones.var_67b5dd94);
            playsoundatposition("zmb_bones_pickup", mdl_bones.origin);
            e_who playrumbleonentity("zm_castle_quest_interact_rumble");
            mdl_bones clientfield::set("wolf_howl_bone_fx", 0);
            wait 0.05;
            mdl_bones delete();
            exploder::stop_exploder("lgt_wolf_quest_" + self.script_label);
            if (!(isdefined(level.var_52978d72.var_372a0bf1) && level.var_52978d72.var_372a0bf1)) {
                wait 1;
                level.var_52978d72 zm_audio::create_and_play_dialog("quest", "skadi_dig");
                level.var_52978d72.var_372a0bf1 = 1;
            }
            return;
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xae437344, Offset: 0x104b8
// Size: 0xbc
function function_11dbf9f2() {
    /#
        self.var_b4065427 = 1;
    #/
    self clientfield::set("wolf_trail_fx", 3);
    level scene::init("ai_zm_dlc1_wolf_howl_tomb_arrival", array(level.var_e6d07014));
    self waittill(#"hash_98c906c9");
    /#
        self.var_b4065427 = undefined;
    #/
    self clientfield::set("wolf_footprint_fx", 0);
    self clientfield::set("wolf_trail_fx", 1);
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x858cbf5d, Offset: 0x10580
    // Size: 0xf4
    function function_3429d04c() {
        if (level flag::get("<dev string:xa29>")) {
            return;
        }
        if (!level flag::get("<dev string:xa16>")) {
            level function_5643d04b();
        }
        level flag::set("<dev string:xa29>");
        mdl_skull = getent("<dev string:xb6a>", "<dev string:x141>");
        mdl_skull show();
        zm_spawner::deregister_zombie_death_event_callback(&function_d0d62870);
        level thread function_328260ea();
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x67a3cf9b, Offset: 0x10680
    // Size: 0x84
    function function_328260ea() {
        level endon(#"hash_b6709ba6");
        if (level flag::get("<dev string:xa3c>")) {
            return;
        }
        if (!isdefined(level.var_e6d07014)) {
            level function_b9485994();
            level.var_e6d07014 = function_286f3904();
        }
        level.var_e6d07014 function_11dbf9f2();
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xa6b2a29a, Offset: 0x10710
// Size: 0x19c
function function_47f43d75() {
    if (isdefined(level.var_52978d72)) {
        level.var_52978d72.var_16002883 = undefined;
        level.var_52978d72.var_372a0bf1 = undefined;
    }
    var_dddbfe51 = getent("aq_wh_ledge_collision", "targetname");
    var_dddbfe51 flag::init("ledge_built");
    var_dddbfe51 thread function_c57a36bb();
    level.var_a1e95710 = &function_fafba689;
    if (isdefined(level.var_52978d72)) {
        level.var_52978d72 thread function_7af16606();
    }
    var_52812994 = getent("aq_wh_burial_chamber_damage_trig", "targetname");
    var_52812994 thread function_987776f3();
    level flag::wait_till("wolf_howl_repaired");
    var_52812994 delete();
    var_d29c128e = getent("aq_wh_burial_chamber_symbol", "targetname");
    var_d29c128e delete();
    level thread function_53b41ebe(var_dddbfe51);
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0xc3bc490b, Offset: 0x108b8
// Size: 0x64
function function_53b41ebe(var_dddbfe51) {
    if (var_dddbfe51 flag::get("ledge_built")) {
        var_dddbfe51 flag::wait_till_clear("ledge_built");
        var_dddbfe51 delete();
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x41128255, Offset: 0x10928
// Size: 0x190
function function_987776f3() {
    level endon(#"hash_b12ab80e");
    level endon(#"wolf_howl_repaired");
    var_dddbfe51 = getent("aq_wh_ledge_collision", "targetname");
    while (true) {
        self waittill(#"damage", amount, attacker, direction, point, mod, tagname, modelname, partname, weapon);
        /#
            if (level flag::get("<dev string:xa6a>")) {
                continue;
            }
        #/
        if (isdefined(level.var_52978d72.var_374fd3ef) && function_51a90202(weapon, 1, point, self) && attacker === level.var_52978d72 && level.var_52978d72.var_374fd3ef) {
            var_dddbfe51 function_6ab969b7();
            wait 10;
            var_dddbfe51 function_1676aad7();
        }
    }
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x28f947fb, Offset: 0x10ac0
    // Size: 0x144
    function function_6c8179b7() {
        level endon(#"hash_b12ab80e");
        var_dddbfe51 = getent("<dev string:xb7c>", "<dev string:x141>");
        if (level flag::get("<dev string:xb92>") || level flag::get("<dev string:xa6a>") || !level flag::get("<dev string:xa29>") || var_dddbfe51 flag::get("<dev string:xba5>")) {
            return;
        }
        level flag::set("<dev string:xa6a>");
        var_dddbfe51 function_6ab969b7();
        wait 10;
        var_dddbfe51 function_1676aad7();
        level util::delay(2, undefined, &function_298099e3);
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x7c078e67, Offset: 0x10c10
    // Size: 0x24
    function function_298099e3() {
        level flag::clear("<dev string:xa6a>");
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xcc5ed8c4, Offset: 0x10c40
// Size: 0x1c
function function_fafba689() {
    level.var_52978d72 thread function_7af16606();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x4c53713c, Offset: 0x10c68
// Size: 0x140
function function_7af16606() {
    /#
        level endon(#"hash_b6709ba6");
        if (level flag::get("<dev string:xa3c>")) {
            return;
        }
        self endon(#"hash_3c5d2ca5");
    #/
    level endon(#"wolf_howl_repaired");
    self endon(#"death");
    self endon(#"quest_swap");
    self.var_374fd3ef = 0;
    var_d29c128e = getent("aq_wh_burial_chamber_symbol", "targetname");
    while (true) {
        if (!self.var_374fd3ef) {
            if (self iswallrunning()) {
                self.var_374fd3ef = 1;
                var_d29c128e show();
            }
        } else if (!self iswallrunning() && self isonground()) {
            self.var_374fd3ef = 0;
            var_d29c128e hide();
        }
        wait 0.1;
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xe039891b, Offset: 0x10db0
// Size: 0xa4
function function_6ab969b7() {
    var_25e9d6b = getent("wolfhowl_brokenplatform_collision", "targetname");
    var_25e9d6b notsolid();
    level scene::play("p7_fxanim_zm_castle_quest_wolf_platform_rebuild_bundle");
    self solid();
    self flag::set("ledge_built");
}

// Namespace zm_castle_weap_quest_upgrade
// Params 2, eflags: 0x0
// Checksum 0xa375d1cd, Offset: 0x10e60
// Size: 0x144
function function_1676aad7(n_delay, b_reset) {
    if (!isdefined(n_delay)) {
        n_delay = 0;
    }
    if (!isdefined(b_reset)) {
        b_reset = 0;
    }
    level endon(#"wolf_howl_repaired");
    wait n_delay;
    self notsolid();
    self flag::clear("ledge_built");
    level scene::play("p7_fxanim_zm_castle_quest_wolf_platform_collapse_bundle");
    var_25e9d6b = getent("wolfhowl_brokenplatform_collision", "targetname");
    var_25e9d6b solid();
    if (b_reset) {
        var_52812994 = getent("aq_wh_burial_chamber_damage_trig", "targetname");
        var_52812994 thread function_987776f3();
        /#
            level flag::clear("<dev string:xa6a>");
        #/
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x65e15ebb, Offset: 0x10fb0
// Size: 0x454
function function_c57a36bb() {
    /#
        level endon(#"hash_b6709ba6");
        if (level flag::get("<dev string:xa3c>")) {
            return;
        }
    #/
    var_605e43a9 = struct::get("quest_reforge_wolf_howl", "targetname");
    var_605e43a9 function_3313abd5();
    while (true) {
        var_605e43a9.var_67b5dd94 waittill(#"trigger", e_who);
        if (e_who === level.var_52978d72 && self flag::get("ledge_built")) {
            level notify(#"hash_b179223");
            level notify(#"hash_b12ab80e");
            level.var_a1e95710 = undefined;
            e_who playrumbleonentity("zm_castle_quest_interact_rumble");
            level scene::play("p7_fxanim_zm_castle_quest_wolf_king_skeleton_bundle");
            self thread function_1676aad7(5, 1);
            break;
        }
    }
    var_605e43a9.var_67b5dd94.prompt_and_visibility_func = &function_8c1fd619;
    var_605e43a9.var_67b5dd94 function_c1947ff7();
    while (true) {
        var_605e43a9.var_67b5dd94 waittill(#"trigger", e_who);
        if (isdefined(level.var_52978d72)) {
            if (e_who == level.var_52978d72 && self flag::get("ledge_built")) {
                break;
            }
            continue;
        }
        if (!array::contains(level.var_427e7668, e_who)) {
            level.var_52978d72 = e_who;
            level.var_427e7668[level.var_427e7668.size] = e_who;
            level clientfield::set("quest_owner_wolf", function_85bfa3fd(e_who.characterindex));
            break;
        }
        e_who notify(#"quest_swap");
        level function_7910311b(e_who);
        level.var_52978d72 = e_who;
        level clientfield::set("quest_owner_wolf", function_85bfa3fd(e_who.characterindex));
        break;
    }
    e_who playsound("zmb_arrow_reforged");
    e_who playrumbleonentity("zm_castle_quest_interact_rumble");
    zm_unitrigger::unregister_unitrigger(var_605e43a9.var_67b5dd94);
    var_605e43a9 thread function_42084ad5(level.var_52978d72);
    level flag::set("wolf_howl_repaired");
    level.var_eee1576 delete();
    level.var_eee1576 = getent("quest_wolf_king_arrow", "targetname");
    level.var_eee1576 hide();
    if (isdefined(level.var_e6d07014)) {
        level thread function_b8a99c68();
    }
    if (self flag::get("ledge_built")) {
        self thread function_1676aad7(5);
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x4dc41c09, Offset: 0x11410
// Size: 0x184
function function_b8a99c68() {
    level.var_e6d07014 clientfield::set("wolf_ghost_shader", 0);
    level.var_e6d07014 clientfield::set("wolf_trail_fx", 0);
    level scene::play("ai_zm_dlc1_wolf_howl_tomb_arrival", array(level.var_e6d07014));
    wait 0.05;
    level.var_e6d07014 delete();
    wait 5;
    level thread struct::function_368120a1("scene", "ai_zm_dlc1_wolf_howl_dig");
    level thread struct::function_368120a1("scene", "ai_zm_dlc1_wolf_howl_howling");
    level thread struct::function_368120a1("scene", "ai_zm_dlc1_wolf_howl_tomb_arrival");
    level thread struct::function_368120a1("scene", "ai_zm_dlc1_wolf_howl_entry");
    level thread struct::function_368120a1("scene", "ai_zm_dlc1_wolf_howl_aggro");
    level thread struct::function_368120a1("scene", "ai_zm_dlc1_wolf_howl_paw_ground");
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x972cc300, Offset: 0x115a0
    // Size: 0x24
    function function_d5e44655() {
        level scene::play("<dev string:xbb1>");
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x6e1b01e7, Offset: 0x115d0
    // Size: 0x1a6
    function function_b6709ba6() {
        if (level flag::get("<dev string:xa3c>")) {
            return;
        }
        if (!level flag::get("<dev string:xa29>")) {
            level function_3429d04c();
        }
        level flag::set("<dev string:xa3c>");
        level flag::set("<dev string:xb92>");
        var_605e43a9 = struct::get("<dev string:xbe5>", "<dev string:x141>");
        if (isdefined(var_605e43a9.var_67b5dd94)) {
            zm_unitrigger::unregister_unitrigger(var_605e43a9.var_67b5dd94);
        }
        if (isdefined(level.var_e6d07014)) {
            while (isdefined(level.var_e6d07014.var_b4065427) && level.var_e6d07014.var_b4065427) {
                wait 1;
            }
            level.var_e6d07014 clientfield::set("<dev string:xbfd>", 0);
            level.var_e6d07014 clientfield::set("<dev string:xc0f>", 0);
            wait 0.05;
            level.var_e6d07014 delete();
        }
        level.var_a1e95710 = undefined;
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x1fba0ba5, Offset: 0x11780
// Size: 0x24
function function_e3ef7bf6(e_attacker) {
    self thread function_803f9685();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xc431fd65, Offset: 0x117b0
// Size: 0x174
function function_803f9685() {
    e_volume = getent("aq_statue_volume", "targetname");
    if (self function_ab623d34(level.var_52978d72, e_volume)) {
        var_dcb62646 = struct::get("upgraded_bow_struct_wolf_howl", "targetname");
        level function_55c48922(self.origin, var_dcb62646.origin, "wolf", isdefined(self.missinglegs) && self.missinglegs);
        var_dcb62646.var_ce58f456++;
        if (var_dcb62646.var_ce58f456 >= 20) {
            level flag::set("wolf_howl_upgraded");
            mdl_arrow = getent("pedestal_wolf_bow_place", "targetname");
            mdl_arrow playsound("evt_arrow_souls_ready");
            mdl_arrow thread function_bf26d3fb("arrow_charge_wolf_fx");
        }
    }
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0xca1a4487, Offset: 0x11930
    // Size: 0x2b4
    function function_4bf5f2() {
        if (level flag::get("<dev string:xc1d>")) {
            return;
        }
        if (!level flag::get("<dev string:xa3c>")) {
            level function_b6709ba6();
        }
        level flag::set("<dev string:xa54>");
        zm_spawner::deregister_zombie_death_event_callback(&function_e3ef7bf6);
        var_afd26121 = struct::get("<dev string:xc30>", "<dev string:x141>");
        if (isdefined(var_afd26121.var_67b5dd94)) {
            zm_unitrigger::unregister_unitrigger(var_afd26121.var_67b5dd94);
        }
        if (!(isdefined(level.var_85a25aa6) && level.var_85a25aa6)) {
            level scene::play("<dev string:xc4e>");
        }
        level scene::play("<dev string:xc82>");
        level flag::set("<dev string:xc1d>");
        arrayremovevalue(level.var_427e7668, level.var_52978d72);
        level.var_52978d72 = undefined;
        level clientfield::set("<dev string:xb28>", 0);
        level function_f5e9876("<dev string:xcb5>", 6);
        if (!isdefined(level.var_e8a6b6f7)) {
            level.var_e8a6b6f7 = [];
            array::thread_all(level.players, &function_b584c1e);
            callback::on_connect(&function_7c48f9d8);
        }
        level flag::set("<dev string:xcba>");
        var_afd26121.var_d4a62e6b = getent("<dev string:xccc>", "<dev string:x141>");
        var_afd26121 thread function_fb704679();
        level function_2c1c1d3e("<dev string:xce9>");
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xf80d09b2, Offset: 0x11bf0
// Size: 0x374
function elemental_storm() {
    /#
        level flag::init("<dev string:xcf3>");
        level flag::init("<dev string:xd07>");
        level flag::init("<dev string:xd1b>");
        level flag::init("<dev string:xd31>");
        level flag::init("<dev string:xd45>");
        level flag::init("<dev string:xd5e>");
        level flag::init("<dev string:xd75>");
        level flag::init("<dev string:xd87>");
        level flag::init("<dev string:xda3>");
        level flag::init("<dev string:xdb8>");
        level flag::init("<dev string:xdd7>");
        level flag::init("<dev string:xdea>");
    #/
    level function_47587cf8();
    level function_cd986666();
    /#
        level flag::set("<dev string:xcf3>");
    #/
    level function_f5e9876("storm", 1);
    level function_e1a7c3f0();
    /#
        level flag::set("<dev string:xd07>");
    #/
    level function_f5e9876("storm", 2);
    level elemental_storm_wallrun();
    /#
        level flag::set("<dev string:xd1b>");
    #/
    level function_f5e9876("storm", 3);
    level function_be03e13e();
    /#
        level flag::set("<dev string:xd31>");
    #/
    level function_f5e9876("storm", 4);
    level function_473ebf10();
    /#
        level flag::set("<dev string:xd45>");
    #/
    var_fe3506f1 = struct::get("upgraded_bow_struct_elemental_storm", "targetname");
    var_fe3506f1 function_14dd5ea5();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xadaafb4c, Offset: 0x11f70
// Size: 0x124
function function_47587cf8() {
    level flag::init("elemental_storm_wallrun");
    level flag::init("elemental_storm_batteries");
    level flag::init("elemental_storm_beacons_charged");
    level flag::init("elemental_storm_repaired");
    level flag::init("elemental_storm_placed");
    level flag::init("elemental_storm_upgraded");
    level flag::init("elemental_storm_spawned");
    var_16fe671f = getent("aq_es_weather_vane", "targetname");
    var_16fe671f hide();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x732aac28, Offset: 0x120a0
// Size: 0x258
function function_cd986666() {
    /#
        level endon(#"hash_2db350be");
    #/
    var_6809935d = getent("aq_es_weather_vane_trig", "targetname");
    var_c5caf2d3 = getent("tower_break_fx_anchor", "targetname");
    while (true) {
        var_6809935d waittill(#"damage", amount, attacker, direction, point, mod, tagname, modelname, partname, weapon);
        if (function_51a90202(weapon, 1, point, var_6809935d)) {
            /#
                level.var_188b2459 = 1;
            #/
            var_6809935d delete();
            level thread function_ac08423b(attacker);
            wait 2;
            var_c5caf2d3 clientfield::set("tower_break_fx", 1);
            level thread scene::play("p7_fxanim_zm_castle_quest_storm_tower_break_bundle");
            level scene::init("p7_fxanim_zm_castle_quest_storm_arrow_broken_bundle");
            level waittill(#"hash_4e123b5d");
            level thread scene::play("p7_fxanim_zm_castle_quest_storm_arrow_broken_bundle");
            level.var_18c771ad = getent("quest_storm_arrow_broken", "targetname");
            s_arrow = struct::get("quest_start_elemental_storm");
            s_arrow function_f708e6b2();
            level notify(#"hash_6d0730ef");
            return;
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0xc347452f, Offset: 0x12300
// Size: 0x17c
function function_ac08423b(e_player) {
    /#
        level endon(#"hash_2db350be");
    #/
    level endon(#"hash_6d0730ef");
    level scene::play("p7_fxanim_zm_castle_weather_vane_spin_bundle");
    level function_aaccdd61();
    var_6a955d70 = getent("aq_es_roof_volume", "targetname");
    var_16fe671f = getent("aq_es_weather_vane", "targetname");
    while (e_player istouching(var_6a955d70)) {
        var_933e0d32 = vectortoangles(var_16fe671f.origin - e_player.origin);
        var_16fe671f rotateto((0, var_933e0d32[1], 0), 0.25);
        wait 0.25;
    }
    level function_526fc045();
    level thread scene::init("p7_fxanim_zm_castle_weather_vane_spin_bundle");
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xdb0907cd, Offset: 0x12488
// Size: 0x90
function function_aaccdd61() {
    var_16fe671f = getent("aq_es_weather_vane", "targetname");
    var_16fe671f show();
    var_7775f39a = getent("castle_weather_vane_spin", "targetname");
    var_7775f39a hide();
    level.var_366df00d = 0;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x1cf108f, Offset: 0x12520
// Size: 0xe8
function function_526fc045(v_angles) {
    if (!isdefined(v_angles)) {
        v_angles = (0, 0, 0);
    }
    var_16fe671f = getent("aq_es_weather_vane", "targetname");
    var_16fe671f rotateto(v_angles, 0.25);
    var_16fe671f waittill(#"rotatedone");
    var_7775f39a = getent("castle_weather_vane_spin", "targetname");
    var_7775f39a show();
    var_16fe671f hide();
    level.var_366df00d = 1;
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x87fa47ae, Offset: 0x12610
    // Size: 0x174
    function function_2db350be() {
        if (level flag::get("<dev string:xcf3>")) {
            return;
        }
        level thread zm_castle_weap_quest::function_a01a53de();
        level.var_f8d1dc16 = level.players[0];
        level clientfield::set("<dev string:xe07>", function_85bfa3fd(level.var_f8d1dc16.characterindex));
        level.var_427e7668[level.var_427e7668.size] = level.players[0];
        if (!(isdefined(level.var_188b2459) && level.var_188b2459)) {
            level thread scene::skipto_end("<dev string:xe19>");
            level thread scene::play("<dev string:xe4c>");
        }
        level thread function_9ad758f3();
        s_arrow = struct::get("<dev string:xe80>");
        zm_unitrigger::unregister_unitrigger(s_arrow.var_67b5dd94);
        level flag::set("<dev string:xcf3>");
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x518d4827, Offset: 0x12790
    // Size: 0x4c
    function function_9ad758f3() {
        wait 1;
        level.var_18c771ad = getent("<dev string:xe9c>", "<dev string:x141>");
        level.var_18c771ad hide();
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xc29d5964, Offset: 0x127e8
// Size: 0x178
function function_e1a7c3f0() {
    /#
        level endon(#"hash_cdf5ca22");
        if (level flag::get("<dev string:xd07>")) {
            return;
        }
    #/
    level thread function_a20bce39();
    level.var_c5c6a918 = &function_cad2d4a7;
    level function_cad2d4a7();
    var_bb041e16 = getentarray("aq_es_beacon_trig", "script_noteworthy");
    array::wait_till(var_bb041e16, "beacon_activated");
    if (isdefined(level.var_f8d1dc16)) {
        level.var_f8d1dc16 thread zm_audio::create_and_play_dialog("quest", "wind");
    }
    level.var_c5c6a918 = undefined;
    foreach (var_8005a5f6 in var_bb041e16) {
        var_8005a5f6.b_lit = undefined;
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x1aea42d6, Offset: 0x12968
// Size: 0x7c
function function_a20bce39() {
    if (isdefined(level.var_366df00d) && level.var_366df00d) {
        level function_aaccdd61();
    }
    v_start_angles = (0, 43, 0);
    level function_526fc045(v_start_angles);
    level thread scene::play("p7_fxanim_zm_castle_weather_vane_spin_point_bundle");
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x6daa3469, Offset: 0x129f0
// Size: 0xda
function function_cad2d4a7() {
    var_bb041e16 = getentarray("aq_es_beacon_trig", "script_noteworthy");
    foreach (var_8005a5f6 in var_bb041e16) {
        if (!(isdefined(var_8005a5f6.b_lit) && var_8005a5f6.b_lit)) {
            var_8005a5f6 thread function_6e3cfa55();
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x99635ea0, Offset: 0x12ad8
// Size: 0x18c
function function_6e3cfa55() {
    /#
        level endon(#"hash_cdf5ca22");
        level.var_f8d1dc16 endon(#"hash_3c5d2ca5");
    #/
    level.var_f8d1dc16 endon(#"death");
    level.var_f8d1dc16 endon(#"quest_swap");
    s_beacon = struct::get(self.target);
    while (true) {
        level.var_f8d1dc16 waittill(#"projectile_impact", weapon, point, radius, attacker, normal);
        if (function_51a90202(weapon, 1, point, self)) {
            if (!isdefined(s_beacon.var_41f52afd)) {
                s_beacon.var_41f52afd = util::spawn_model("tag_origin", s_beacon.origin);
            }
            s_beacon.var_41f52afd clientfield::set("beacon_fx", 1);
            self playsound("zmb_beacon_ignite");
            self.b_lit = 1;
            self notify(#"beacon_activated");
            return;
        }
    }
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x7a4269a4, Offset: 0x12c70
    // Size: 0x210
    function function_c57b4999() {
        if (!isdefined(level.var_a6503511)) {
            level.var_a6503511 = level flag::get("<dev string:xd07>");
        }
        a_s_beacons = struct::get_array("<dev string:xeb5>", "<dev string:x1e7>");
        if (level.var_a6503511) {
            foreach (s_beacon in a_s_beacons) {
                if (isdefined(s_beacon.var_41f52afd)) {
                    s_beacon.var_41f52afd clientfield::set("<dev string:xec9>", 0);
                }
            }
            level.var_a6503511 = 0;
            return;
        }
        foreach (s_beacon in a_s_beacons) {
            if (!isdefined(s_beacon.var_41f52afd)) {
                s_beacon.var_41f52afd = util::spawn_model("<dev string:x3d5>", s_beacon.origin);
            }
            s_beacon.var_41f52afd clientfield::set("<dev string:xec9>", 1);
        }
        level.var_a6503511 = 1;
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x6bcfb1ef, Offset: 0x12e88
    // Size: 0x18c
    function function_cdf5ca22() {
        if (level flag::get("<dev string:xd07>")) {
            return;
        }
        if (!level flag::get("<dev string:xcf3>")) {
            level function_2db350be();
        }
        level.var_c5c6a918 = undefined;
        a_s_beacons = struct::get_array("<dev string:xeb5>", "<dev string:x1e7>");
        foreach (s_beacon in a_s_beacons) {
            if (!isdefined(s_beacon.var_41f52afd)) {
                s_beacon.var_41f52afd = util::spawn_model("<dev string:x3d5>", s_beacon.origin);
                s_beacon.var_41f52afd clientfield::set("<dev string:xec9>", 1);
            }
        }
        level flag::set("<dev string:xd07>");
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x2c1f1c52, Offset: 0x13020
// Size: 0x1ea
function elemental_storm_wallrun() {
    var_5c7ef569 = getentarray("aq_es_wallrun_trigger", "targetname");
    array::thread_all(var_5c7ef569, &function_56130b0d);
    array::thread_all(var_5c7ef569, &function_cce911bb);
    level scene::play("p7_fxanim_zm_castle_weather_vane_spin_bundle");
    level function_aaccdd61();
    level function_526fc045();
    level thread scene::init("p7_fxanim_zm_castle_weather_vane_spin_bundle");
    level flag::wait_till("elemental_storm_wallrun");
    foreach (var_634fac89 in var_5c7ef569) {
        mdl_symbol = getent(var_634fac89.target, "targetname");
        var_e9dd177b = getent(mdl_symbol.target, "targetname");
        var_e9dd177b delete();
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x175c99e0, Offset: 0x13218
// Size: 0x178
function function_cce911bb() {
    /#
        level endon(#"hash_5508467e");
        if (level flag::get("<dev string:xd1b>")) {
            return;
        }
    #/
    level endon(#"elemental_storm_wallrun");
    mdl_symbol = getent(self.target, "targetname");
    var_e9dd177b = getent(mdl_symbol.target, "targetname");
    mdl_symbol clientfield::set("wallrun_fx", 1);
    while (true) {
        var_e9dd177b waittill(#"trigger");
        if (!array::contains(level.var_49593fd9, self)) {
            mdl_symbol clientfield::set("wallrun_fx", 2);
        }
        while (array::is_touching(level.players, var_e9dd177b)) {
            wait 0.1;
        }
        if (!array::contains(level.var_49593fd9, self)) {
            mdl_symbol clientfield::set("wallrun_fx", 1);
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x2b5072f, Offset: 0x13398
// Size: 0x25c
function function_56130b0d() {
    /#
        level endon(#"hash_5508467e");
    #/
    while (!level flag::get("elemental_storm_wallrun")) {
        self waittill(#"trigger", e_who);
        if (e_who === level.var_f8d1dc16) {
            if (!isdefined(e_who.var_a4f04654)) {
                e_who.var_a4f04654 = 0;
                level.var_49593fd9 = [];
            }
            if (e_who.var_a4f04654 == 0) {
                level thread function_ba8e8ad8(e_who);
            }
            if (!array::contains(level.var_49593fd9, self)) {
                mdl_symbol = getent(self.target, "targetname");
                mdl_symbol clientfield::set("wallrun_fx", 2);
                exploder::exploder("lgt_rune_wind_" + self.script_int);
                self playsound("zmb_wall_run_rune_cross");
                e_who playrumbleonentity("zm_castle_quest_elemental_storm_wallrun_rumble");
                if (e_who.var_a4f04654 == 4) {
                    level flag::set("elemental_storm_wallrun");
                    self playsound("zmb_wall_run_rune_cross_done");
                    return;
                }
                if (!isdefined(level.var_49593fd9)) {
                    level.var_49593fd9 = [];
                } else if (!isarray(level.var_49593fd9)) {
                    level.var_49593fd9 = array(level.var_49593fd9);
                }
                level.var_49593fd9[level.var_49593fd9.size] = self;
                e_who.var_a4f04654++;
            }
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x9c203399, Offset: 0x13600
// Size: 0x2d4
function function_ba8e8ad8(e_who) {
    /#
        level endon(#"hash_5508467e");
        e_who endon(#"hash_3c5d2ca5");
    #/
    e_who endon(#"death");
    e_who endon(#"quest_swap");
    level endon(#"elemental_storm_wallrun");
    e_who playrumbleonentity("damage_heavy");
    var_968c3922 = 0;
    while (var_968c3922 < 4) {
        while (e_who iswallrunning() || !e_who isonground() || e_who isinmovemode("ufo", "noclip")) {
            var_968c3922 = 0;
            wait 0.1;
        }
        if (e_who.origin[2] < 320) {
            var_968c3922 = 4;
            /#
                iprintlnbold("<dev string:xed3>");
            #/
        } else {
            var_968c3922++;
            /#
                iprintlnbold("<dev string:xeeb>" + var_968c3922 + "<dev string:xf01>");
            #/
        }
        wait 0.05;
    }
    /#
        iprintlnbold("<dev string:xf0f>");
    #/
    e_who.var_a4f04654 = 0;
    e_who playsound("zmb_wall_run_rune_cross_fail");
    foreach (var_634fac89 in level.var_49593fd9) {
        mdl_symbol = getent(var_634fac89.target, "targetname");
        mdl_symbol clientfield::set("wallrun_fx", 1);
        exploder::stop_exploder("lgt_rune_wind_" + var_634fac89.script_int);
    }
    level.var_49593fd9 = [];
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0xba552f01, Offset: 0x138e0
    // Size: 0x1ac
    function function_5508467e() {
        if (level flag::get("<dev string:xd1b>")) {
            return;
        }
        if (!level flag::get("<dev string:xd07>")) {
            level function_cdf5ca22();
        }
        level flag::set("<dev string:xd1b>");
        var_5c7ef569 = getentarray("<dev string:xf2a>", "<dev string:x141>");
        foreach (var_634fac89 in var_5c7ef569) {
            mdl_symbol = getent(var_634fac89.target, "<dev string:x141>");
            mdl_symbol clientfield::set("<dev string:xf40>", 2);
            exploder::exploder("<dev string:xf4b>" + var_634fac89.script_int);
        }
        level flag::set("<dev string:xf5a>");
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x7739776f, Offset: 0x13a98
// Size: 0x2fa
function function_be03e13e() {
    /#
        level endon(#"hash_b1cac6d2");
        if (level flag::get("<dev string:xd31>")) {
            return;
        }
    #/
    if (isdefined(level.var_f8d1dc16)) {
        level.var_f8d1dc16.b_charged = 0;
    }
    level thread function_a20bce39();
    var_9e89bcdc = getentarray("aq_es_battery_volume", "script_noteworthy");
    foreach (var_8f88d1fd in var_9e89bcdc) {
        var_8f88d1fd.b_activated = 0;
        var_8f88d1fd.var_bb486f65 = 0;
        var_d186cfae = struct::get(var_8f88d1fd.target, "targetname");
        var_d186cfae.var_41f52afd = util::spawn_model("tag_origin", var_d186cfae.origin);
        var_d186cfae.var_41f52afd clientfield::set("battery_fx", 1);
    }
    level thread elemental_storm_batteries(var_9e89bcdc);
    level thread elemental_storm_beacons_charged();
    level flag::wait_till_all(array("elemental_storm_batteries", "elemental_storm_beacons_charged"));
    foreach (var_8f88d1fd in var_9e89bcdc) {
        var_d186cfae = struct::get(var_8f88d1fd.target, "targetname");
        if (isdefined(var_d186cfae.var_41f52afd)) {
            var_d186cfae.var_41f52afd clientfield::set("battery_fx", 0);
            var_d186cfae.var_41f52afd delete();
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0xeca1e82e, Offset: 0x13da0
// Size: 0xc4
function elemental_storm_batteries(var_9e89bcdc) {
    /#
        level endon(#"hash_b1cac6d2");
        level endon(#"hash_ae42a737");
    #/
    array::thread_all(var_9e89bcdc, &function_43cb1d81);
    zm_spawner::register_zombie_death_event_callback(&function_71e6353);
    array::wait_till(var_9e89bcdc, "activated");
    zm_spawner::deregister_zombie_death_event_callback(&function_71e6353);
    level flag::set("elemental_storm_batteries");
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xae7c5279, Offset: 0x13e70
// Size: 0x11a
function function_43cb1d81() {
    /#
        level endon(#"hash_b1cac6d2");
        level endon(#"hash_ae42a737");
    #/
    var_d186cfae = struct::get(self.target, "targetname");
    while (true) {
        self waittill(#"killed");
        self.var_bb486f65++;
        if (self.var_bb486f65 >= 5) {
            self notify(#"activated");
            var_d186cfae.var_41f52afd clientfield::set("battery_fx", 2);
            self.b_activated = 1;
            var_a4f8e4d0 = getent(self.targetname + "_charged", "targetname");
            var_a4f8e4d0.b_activated = 1;
            var_a4f8e4d0.b_used = 0;
            return;
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0xd00b8f82, Offset: 0x13f98
// Size: 0x24
function function_71e6353(e_attacker) {
    self thread function_88efea4a();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x51210db6, Offset: 0x13fc8
// Size: 0x16c
function function_88efea4a() {
    var_54697048 = getentarray("aq_es_battery_volume", "script_noteworthy");
    if (self function_ab623d34(level.var_f8d1dc16)) {
        a_e_touching = self array::get_touching(var_54697048);
        if (isdefined(a_e_touching) && a_e_touching.size > 0 && !(isdefined(a_e_touching[0].b_activated) && a_e_touching[0].b_activated)) {
            var_d186cfae = struct::get(a_e_touching[0].target, "targetname");
            level function_55c48922(self.origin, var_d186cfae.origin + (0, 0, 16), "storm", isdefined(self.missinglegs) && self.missinglegs);
            a_e_touching[0] util::delay_notify(0.05, "killed");
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x15cabad2, Offset: 0x14140
// Size: 0x130
function elemental_storm_beacons_charged() {
    /#
        level endon(#"hash_b1cac6d2");
    #/
    level.var_c5c6a918 = &function_94af5935;
    level function_94af5935();
    var_bb041e16 = getentarray("aq_es_beacon_trig", "script_noteworthy");
    array::wait_till(var_bb041e16, "beacon_charged");
    level flag::set("elemental_storm_beacons_charged");
    level.var_c5c6a918 = undefined;
    foreach (var_8005a5f6 in var_bb041e16) {
        var_8005a5f6.b_charged = undefined;
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x29a20394, Offset: 0x14278
// Size: 0xf2
function function_94af5935() {
    level.var_f8d1dc16 thread function_4688cd22();
    var_bb041e16 = getentarray("aq_es_beacon_trig", "script_noteworthy");
    foreach (var_8005a5f6 in var_bb041e16) {
        if (!(isdefined(var_8005a5f6.b_charged) && var_8005a5f6.b_charged)) {
            var_8005a5f6 thread function_1c758ab0();
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x48df3287, Offset: 0x14378
// Size: 0x248
function function_1c758ab0() {
    /#
        level endon(#"hash_b1cac6d2");
        level.var_f8d1dc16 endon(#"hash_3c5d2ca5");
    #/
    level.var_f8d1dc16 endon(#"death");
    level.var_f8d1dc16 endon(#"quest_swap");
    s_beacon = struct::get(self.target);
    while (true) {
        level.var_f8d1dc16 waittill(#"projectile_impact", weapon, point, radius, projectile, normal);
        if (isdefined(projectile.var_e4594d27) && projectile.var_e4594d27) {
            if (function_51a90202(weapon, 1, point, self)) {
                s_beacon.var_41f52afd clientfield::set("beacon_fx", 2);
                self.b_charged = 1;
                /#
                    iprintlnbold("<dev string:xf72>");
                #/
                if (isdefined(projectile.var_8f88d1fd)) {
                    projectile.var_8f88d1fd.b_used = 1;
                    var_d186cfae = struct::get(projectile.var_8f88d1fd.target, "targetname");
                    if (isdefined(var_d186cfae.var_41f52afd)) {
                        var_d186cfae.var_41f52afd clientfield::set("battery_fx", 0);
                    }
                    wait 0.05;
                    if (isdefined(var_d186cfae.var_41f52afd)) {
                        var_d186cfae.var_41f52afd delete();
                    }
                }
                self notify(#"beacon_charged");
                return;
            }
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xe966c34, Offset: 0x145c8
// Size: 0x224
function function_4688cd22() {
    /#
        level endon(#"hash_b1cac6d2");
        self endon(#"hash_3c5d2ca5");
    #/
    self endon(#"death");
    self endon(#"quest_swap");
    var_54697048 = getentarray("aq_es_battery_volume_charged", "script_noteworthy");
    var_e1041201 = getweapon("elemental_bow");
    while (!level flag::get("elemental_storm_beacons_charged")) {
        if (self ischargeshotpending() && self.chargeshotlevel === 4) {
            var_b6ccc8ce = function_7e113f9d(var_54697048);
            e_projectile = undefined;
            if (isdefined(var_b6ccc8ce)) {
                self clientfield::set_to_player("arrow_charge_fx", 1);
                self.var_55301590 = var_b6ccc8ce;
                var_d186cfae = struct::get(var_b6ccc8ce.target, "targetname");
                var_d186cfae.var_41f52afd clientfield::set("battery_fx", 1);
                self function_29163209();
                if (isdefined(var_d186cfae.var_41f52afd)) {
                    var_d186cfae.var_41f52afd clientfield::set("battery_fx", 2);
                }
                self clientfield::set_to_player("arrow_charge_fx", 0);
                self.var_55301590 = undefined;
            }
        }
        wait 0.05;
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x5408ad48, Offset: 0x147f8
// Size: 0xaa
function function_7e113f9d(var_54697048) {
    a_result = self array::get_touching(var_54697048);
    if (isdefined(a_result[0].b_activated) && a_result.size > 0 && a_result[0].b_activated && !(isdefined(a_result[0].b_used) && a_result[0].b_used)) {
        return a_result[0];
    }
    return undefined;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xc8168176, Offset: 0x148b0
// Size: 0x7c
function function_29163209() {
    self endon(#"hash_c9fc8679");
    self thread function_191ae48a();
    self waittill(#"missile_fire", projectile, weapon);
    projectile.var_e4594d27 = 1;
    if (isdefined(self.var_55301590)) {
        projectile.var_8f88d1fd = self.var_55301590;
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xf2e5d7e4, Offset: 0x14938
// Size: 0x3a
function function_191ae48a() {
    self endon(#"weapon_fired");
    while (self.chargeshotlevel === 4) {
        wait 0.05;
    }
    self notify(#"hash_c9fc8679");
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x8e629349, Offset: 0x14980
    // Size: 0x1f8
    function function_6a8283d3() {
        if (!isdefined(level.var_174d6fda)) {
            level.var_174d6fda = 0;
        }
        a_s_beacons = struct::get_array("<dev string:xeb5>", "<dev string:x1e7>");
        if (level.var_174d6fda) {
            foreach (s_beacon in a_s_beacons) {
                if (isdefined(s_beacon.var_41f52afd)) {
                    s_beacon.var_41f52afd clientfield::set("<dev string:xec9>", 0);
                }
            }
            level.var_174d6fda = 0;
            return;
        }
        foreach (s_beacon in a_s_beacons) {
            if (!isdefined(s_beacon.var_41f52afd)) {
                s_beacon.var_41f52afd = util::spawn_model("<dev string:x3d5>", s_beacon.origin);
            }
            s_beacon.var_41f52afd clientfield::set("<dev string:xec9>", 2);
        }
        level.var_174d6fda = 1;
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x4d37d51e, Offset: 0x14b80
    // Size: 0x204
    function function_ae42a737() {
        if (level flag::get("<dev string:xd31>") || level flag::get("<dev string:xf96>") || !level flag::get("<dev string:xd1b>")) {
            return;
        }
        var_9e89bcdc = getentarray("<dev string:xfb0>", "<dev string:x1e7>");
        foreach (var_8f88d1fd in var_9e89bcdc) {
            var_a4f8e4d0 = getent(var_8f88d1fd.targetname + "<dev string:xfc5>", "<dev string:x141>");
            var_a4f8e4d0.b_activated = 1;
            var_a4f8e4d0.b_used = 0;
            var_d186cfae = struct::get(var_8f88d1fd.target, "<dev string:x141>");
            var_d186cfae.var_41f52afd clientfield::set("<dev string:xfce>", 2);
        }
        level flag::set("<dev string:xda3>");
        level flag::set("<dev string:xf96>");
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x7ae152f4, Offset: 0x14d90
    // Size: 0x1a0
    function function_1ad44df5() {
        if (!isdefined(level.var_f3ff8b16)) {
            level.var_f3ff8b16 = 0;
        }
        var_66b0cbbe = struct::get_array("<dev string:xfd9>", "<dev string:x1e7>");
        if (level.var_f3ff8b16) {
            foreach (var_d186cfae in var_66b0cbbe) {
                var_d186cfae.var_41f52afd clientfield::set("<dev string:xfce>", 1);
            }
            level.var_f3ff8b16 = 0;
            return;
        }
        foreach (var_d186cfae in var_66b0cbbe) {
            var_d186cfae.var_41f52afd clientfield::set("<dev string:xfce>", 2);
        }
        level.var_f3ff8b16 = 1;
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x4385159d, Offset: 0x14f38
    // Size: 0x264
    function function_b1cac6d2() {
        if (level flag::get("<dev string:xd31>")) {
            return;
        }
        if (!level flag::get("<dev string:xd1b>")) {
            level function_5508467e();
        }
        level flag::set("<dev string:xd31>");
        level.var_c5c6a918 = undefined;
        a_s_beacons = struct::get_array("<dev string:xeb5>", "<dev string:x1e7>");
        foreach (s_beacon in a_s_beacons) {
            s_beacon.var_41f52afd clientfield::set("<dev string:xec9>", 2);
        }
        var_66b0cbbe = struct::get_array("<dev string:xfd9>", "<dev string:x1e7>");
        foreach (var_d186cfae in var_66b0cbbe) {
            if (isdefined(var_d186cfae.var_41f52afd)) {
                var_d186cfae.var_41f52afd clientfield::set("<dev string:xfce>", 0);
                var_d186cfae.var_41f52afd delete();
            }
        }
        zm_spawner::deregister_zombie_death_event_callback(&function_71e6353);
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x1ee73356, Offset: 0x151a8
// Size: 0x57c
function function_473ebf10() {
    /#
        level endon(#"hash_632adf35");
        if (level flag::get("<dev string:xd45>")) {
            return;
        }
    #/
    level thread scene::play("p7_fxanim_zm_castle_weather_vane_spin_erratic_bundle");
    level scene::init("p7_fxanim_zm_castle_quest_storm_arrow_reform_bundle");
    var_defe3942 = struct::get("aq_es_tornado_struct");
    var_605e43a9 = struct::get("quest_reforge_elemental_storm");
    var_605e43a9 function_3313abd5();
    var_defe3942.var_41f52afd = util::spawn_model("tag_origin", var_defe3942.origin, (-90, 0, 0));
    var_defe3942.var_41f52afd clientfield::set("lightning_fx", 1);
    var_defe3942.var_41f52afd clientfield::set("tornado_fx", 1);
    /#
        level.var_174d6fda = 1;
    #/
    while (true) {
        var_605e43a9.var_67b5dd94 waittill(#"trigger", e_who);
        if (e_who === level.var_f8d1dc16) {
            /#
                level.var_174d6fda = 0;
            #/
            level notify(#"hash_aa9c6a4f");
            e_who playrumbleonentity("zm_castle_quest_interact_rumble");
            level scene::play("p7_fxanim_zm_castle_quest_storm_arrow_reform_bundle");
            level scene::play("p7_fxanim_zm_castle_quest_storm_arrow_whole_bundle");
            level thread scene::play("p7_fxanim_zm_castle_quest_storm_arrow_whole_idle_bundle");
            break;
        }
    }
    var_605e43a9.var_67b5dd94.prompt_and_visibility_func = &function_8c1fd619;
    var_605e43a9.var_67b5dd94 function_c1947ff7();
    while (true) {
        var_605e43a9.var_67b5dd94 waittill(#"trigger", e_who);
        if (isdefined(level.var_f8d1dc16)) {
            if (e_who == level.var_f8d1dc16) {
                break;
            }
            continue;
        }
        if (!array::contains(level.var_427e7668, e_who)) {
            level.var_f8d1dc16 = e_who;
            level.var_427e7668[level.var_427e7668.size] = e_who;
            level clientfield::set("quest_owner_storm", function_85bfa3fd(e_who.characterindex));
            break;
        }
        e_who notify(#"quest_swap");
        level function_7910311b(e_who);
        level.var_f8d1dc16 = e_who;
        level clientfield::set("quest_owner_storm", function_85bfa3fd(e_who.characterindex));
        break;
    }
    e_who playsound("zmb_arrow_reforged");
    e_who playrumbleonentity("zm_castle_quest_interact_rumble");
    zm_unitrigger::unregister_unitrigger(var_605e43a9.var_67b5dd94);
    var_605e43a9 thread function_42084ad5(level.var_f8d1dc16);
    level flag::set("elemental_storm_repaired");
    level.var_18c771ad delete();
    level.var_18c771ad = getent("quest_storm_arrow_whole", "targetname");
    level.var_18c771ad hide();
    var_defe3942.var_41f52afd thread function_4c78e905();
    level scene::stop("p7_fxanim_zm_castle_weather_vane_spin_erratic_bundle");
    level function_aaccdd61();
    level function_526fc045();
    level thread scene::init("p7_fxanim_zm_castle_weather_vane_spin_bundle");
    level function_71419e41();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x8f07178a, Offset: 0x15730
// Size: 0x44
function function_70fc8e89() {
    level scene::play("p7_fxanim_zm_castle_quest_storm_arrow_whole_bundle");
    level scene::play("p7_fxanim_zm_castle_quest_storm_arrow_whole_idle_bundle");
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xd0f15479, Offset: 0x15780
// Size: 0x5c
function function_4c78e905() {
    self clientfield::set("lightning_fx", 0);
    self clientfield::set("tornado_fx", 0);
    wait 2;
    self delete();
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x9b55afe9, Offset: 0x157e8
    // Size: 0x178
    function function_1b2a8d00() {
        if (!isdefined(level.var_e1c25eb8)) {
            level.var_e1c25eb8 = 0;
        }
        var_defe3942 = struct::get("<dev string:xfe7>");
        if (level.var_e1c25eb8) {
            if (isdefined(var_defe3942.var_41f52afd)) {
                var_defe3942.var_41f52afd clientfield::set("<dev string:xffc>", 0);
                var_defe3942.var_41f52afd clientfield::set("<dev string:x1009>", 0);
                level.var_e1c25eb8 = 0;
            }
            return;
        }
        if (!isdefined(var_defe3942.var_41f52afd)) {
            var_defe3942.var_41f52afd = util::spawn_model("<dev string:x3d5>", var_defe3942.origin, (-90, 0, 0));
        }
        var_defe3942.var_41f52afd clientfield::set("<dev string:xffc>", 1);
        var_defe3942.var_41f52afd clientfield::set("<dev string:x1009>", 1);
        level.var_e1c25eb8 = 1;
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xe20c2c5d, Offset: 0x15968
// Size: 0x254
function function_71419e41() {
    var_22e3a725 = getentarray("aq_es_beacon_trig", "script_noteworthy");
    array::run_all(var_22e3a725, &delete);
    a_s_beacons = struct::get_array("aq_es_beacon_struct", "script_noteworthy");
    foreach (s_beacon in a_s_beacons) {
        s_beacon.var_41f52afd thread function_44dae424();
    }
    var_5c7ef569 = getentarray("aq_es_wallrun_trigger", "targetname");
    foreach (var_634fac89 in var_5c7ef569) {
        mdl_symbol = getent(var_634fac89.target, "targetname");
        mdl_symbol thread function_91d15bdf();
        exploder::stop_exploder("lgt_rune_wind_" + var_634fac89.script_int);
    }
    array::run_all(var_5c7ef569, &delete);
    level clientfield::set("storm_variable_cleanup", 1);
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x6f465a4, Offset: 0x15bc8
// Size: 0x44
function function_44dae424() {
    self clientfield::set("beacon_fx", 0);
    wait 1.5;
    self delete();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xad140fc4, Offset: 0x15c18
// Size: 0x44
function function_91d15bdf() {
    self clientfield::set("wallrun_fx", 0);
    wait 0.5;
    self delete();
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x9601ea4e, Offset: 0x15c68
    // Size: 0xb4
    function function_632adf35() {
        if (level flag::get("<dev string:xd45>")) {
            return;
        }
        if (!level flag::get("<dev string:xd31>")) {
            level function_b1cac6d2();
        }
        level flag::set("<dev string:xd45>");
        level flag::set("<dev string:x1014>");
        level function_71419e41();
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x2b1cbe2c, Offset: 0x15d28
// Size: 0x24
function function_c5b609e2(e_attacker) {
    self thread function_392a1ae1();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x7a7da902, Offset: 0x15d58
// Size: 0x174
function function_392a1ae1() {
    e_volume = getent("aq_statue_volume", "targetname");
    if (self function_ab623d34(level.var_f8d1dc16, e_volume)) {
        var_eb2f4ed5 = struct::get("upgraded_bow_struct_elemental_storm", "targetname");
        level function_55c48922(self.origin, var_eb2f4ed5.origin, "storm", isdefined(self.missinglegs) && self.missinglegs);
        var_eb2f4ed5.var_ce58f456++;
        if (var_eb2f4ed5.var_ce58f456 >= 20) {
            level flag::set("elemental_storm_upgraded");
            mdl_arrow = getent("pedestal_storm_bow_place", "targetname");
            mdl_arrow playsound("evt_arrow_souls_ready");
            mdl_arrow thread function_bf26d3fb("arrow_charge_wolf_fx");
        }
    }
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0xafa27929, Offset: 0x15ed8
    // Size: 0x2b4
    function function_b88a3579() {
        if (level flag::get("<dev string:x102d>")) {
            return;
        }
        if (!level flag::get("<dev string:xd45>")) {
            level function_632adf35();
        }
        level flag::set("<dev string:xd5e>");
        zm_spawner::deregister_zombie_death_event_callback(&function_c5b609e2);
        var_fe3506f1 = struct::get("<dev string:x1046>", "<dev string:x141>");
        if (isdefined(var_fe3506f1.var_67b5dd94)) {
            zm_unitrigger::unregister_unitrigger(var_fe3506f1.var_67b5dd94);
        }
        if (!(isdefined(level.var_26f1fa87) && level.var_26f1fa87)) {
            level scene::play("<dev string:x106a>");
        }
        level scene::play("<dev string:x10a4>");
        level flag::set("<dev string:x102d>");
        arrayremovevalue(level.var_427e7668, level.var_f8d1dc16);
        level.var_f8d1dc16 = undefined;
        level clientfield::set("<dev string:xe07>", 0);
        level function_f5e9876("<dev string:x10dd>", 6);
        if (!isdefined(level.var_e8a6b6f7)) {
            level.var_e8a6b6f7 = [];
            array::thread_all(level.players, &function_b584c1e);
            callback::on_connect(&function_7c48f9d8);
        }
        level flag::set("<dev string:x10e3>");
        var_fe3506f1.var_d4a62e6b = getent("<dev string:x10fb>", "<dev string:x141>");
        var_fe3506f1 thread function_fb704679();
        level function_2c1c1d3e("<dev string:x1119>");
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x8aacd325, Offset: 0x16198
// Size: 0x194
function function_f708e6b2() {
    self function_3313abd5(&function_4a58bb9);
    switch (self.script_label) {
    case "elemental_bow_rune_prison":
        var_1493eda1 = "rune_prison";
        mdl_arrow = level.var_2b11065e;
        break;
    case "elemental_bow_demongate":
        var_1493eda1 = "demon_gate";
        mdl_arrow = level.var_72a6d56b;
        break;
    case "elemental_bow_wolf_howl":
        var_1493eda1 = "wolf_howl";
        mdl_arrow = level.var_eee1576;
        break;
    case "elemental_bow_storm":
        var_1493eda1 = "elemental_storm";
        mdl_arrow = level.var_18c771ad;
        break;
    }
    if (isdefined(mdl_arrow)) {
        mdl_arrow show();
    }
    mdl_arrow playloopsound("zmb_ee_arrow_lp", 1);
    e_player = self function_655cb8e();
    e_player playrumbleonentity("zm_castle_quest_interact_rumble");
    if (isdefined(mdl_arrow)) {
        mdl_arrow hide();
        mdl_arrow stoploopsound(1);
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xa867bf7c, Offset: 0x16338
// Size: 0x35e
function function_655cb8e() {
    while (true) {
        self.var_67b5dd94 waittill(#"trigger", e_who);
        level function_e0db1fe7(e_who);
        if (isdefined(e_who) && !array::contains(level.var_427e7668, e_who)) {
            e_who playsound("zmb_broken_arrow_pickup");
            switch (self.script_label) {
            case "elemental_bow_rune_prison":
                level.var_c62829c7 = e_who;
                var_78cede1 = "quest_owner_rune";
                break;
            case "elemental_bow_demongate":
                level.var_6e68c0d8 = e_who;
                var_78cede1 = "quest_owner_demon";
                break;
            case "elemental_bow_wolf_howl":
                level.var_52978d72 = e_who;
                var_78cede1 = "quest_owner_wolf";
                break;
            case "elemental_bow_storm":
                level.var_f8d1dc16 = e_who;
                var_78cede1 = "quest_owner_storm";
                break;
            }
            level clientfield::set(var_78cede1, function_85bfa3fd(e_who.characterindex));
            level.var_427e7668[level.var_427e7668.size] = e_who;
            self thread function_42084ad5(e_who);
            level thread zm_unitrigger::unregister_unitrigger(self.var_67b5dd94);
            return e_who;
        }
        if (isdefined(e_who) && array::contains(level.var_427e7668, e_who)) {
            e_who notify(#"quest_swap");
            level function_7910311b(e_who);
            e_who playsound("zmb_broken_arrow_pickup");
            switch (self.script_label) {
            case "elemental_bow_rune_prison":
                level.var_c62829c7 = e_who;
                var_78cede1 = "quest_owner_rune";
                break;
            case "elemental_bow_demongate":
                level.var_6e68c0d8 = e_who;
                var_78cede1 = "quest_owner_demon";
                break;
            case "elemental_bow_wolf_howl":
                level.var_52978d72 = e_who;
                var_78cede1 = "quest_owner_wolf";
                break;
            case "elemental_bow_storm":
                level.var_f8d1dc16 = e_who;
                var_78cede1 = "quest_owner_storm";
                break;
            }
            level clientfield::set(var_78cede1, function_85bfa3fd(e_who.characterindex));
            self thread function_42084ad5(e_who);
            level thread zm_unitrigger::unregister_unitrigger(self.var_67b5dd94);
            return e_who;
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x25ca6b24, Offset: 0x166a0
// Size: 0x21c
function function_e0db1fe7(e_who) {
    if (!isdefined(e_who) || !array::contains(level.var_427e7668, e_who)) {
        return;
    }
    if (e_who === level.var_f8d1dc16 && level flag::get("elemental_storm_spawned")) {
        level.var_f8d1dc16 = undefined;
        level function_16bdda6f(e_who, "elemental_storm");
        level clientfield::set("quest_owner_storm", 0);
        return;
    }
    if (e_who === level.var_c62829c7 && level flag::get("rune_prison_spawned")) {
        level.var_c62829c7 = undefined;
        level function_16bdda6f(e_who, "rune_prison");
        level clientfield::set("quest_owner_rune", 0);
        return;
    }
    if (e_who === level.var_6e68c0d8 && level flag::get("demon_gate_spawned")) {
        level.var_6e68c0d8 = undefined;
        level function_16bdda6f(e_who, "demon_gate");
        level clientfield::set("quest_owner_demon", 0);
        return;
    }
    if (e_who === level.var_52978d72 && level flag::get("wolf_howl_spawned")) {
        level.var_52978d72 = undefined;
        level function_16bdda6f(e_who, "wolf_howl");
        level clientfield::set("quest_owner_wolf", 0);
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 2, eflags: 0x0
// Checksum 0xd8e91693, Offset: 0x168c8
// Size: 0xb8
function function_16bdda6f(e_player, var_1493eda1) {
    arrayremovevalue(level.var_427e7668, e_player);
    var_5be2705e = struct::get("upgraded_bow_struct_" + var_1493eda1, "targetname");
    var_5be2705e.var_67b5dd94.prompt_and_visibility_func = &function_4b76cf52;
    var_5be2705e.var_67b5dd94 function_c1947ff7();
    level notify(var_1493eda1 + "_complete");
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x752f435a, Offset: 0x16988
// Size: 0x1b4
function function_42084ad5(var_e459d8fb) {
    switch (self.script_label) {
    case "elemental_bow_rune_prison":
        var_1493eda1 = "rune_prison";
        var_78cede1 = "quest_owner_rune";
        break;
    case "elemental_bow_demongate":
        var_1493eda1 = "demon_gate";
        var_78cede1 = "quest_owner_demon";
        break;
    case "elemental_bow_wolf_howl":
        var_1493eda1 = "wolf_howl";
        var_78cede1 = "quest_owner_wolf";
        break;
    case "elemental_bow_storm":
        var_1493eda1 = "elemental_storm";
        var_78cede1 = "quest_owner_storm";
        break;
    }
    level endon(var_1493eda1 + "_complete");
    level endon(var_1493eda1 + "_arrow_reforged");
    /#
        level endon("<dev string:x1129>" + var_1493eda1 + "<dev string:x112e>");
    #/
    str_notify = var_e459d8fb util::function_183e3618("death", "quest_swap", level, var_1493eda1 + "_complete", var_1493eda1 + "_arrow_reforged");
    level clientfield::set(var_78cede1, 0);
    if (str_notify == "death") {
        arrayremovevalue(level.var_427e7668, var_e459d8fb);
    }
    level function_abeafdcb(var_1493eda1);
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x9afeefdc, Offset: 0x16b48
// Size: 0x364
function function_abeafdcb(var_1493eda1) {
    var_d1a0ccb = var_1493eda1 + "_placed";
    var_7ceb9ac6 = var_1493eda1 + "_upgraded";
    var_491b9e06 = var_1493eda1 + "_spawned";
    if (level flag::get(var_491b9e06)) {
        str_struct = "upgraded_bow_struct_" + var_1493eda1;
        var_5be2705e = struct::get(str_struct, "targetname");
        var_5be2705e.var_67b5dd94.prompt_and_visibility_func = &function_4b76cf52;
        var_5be2705e.var_67b5dd94 function_c1947ff7();
    } else if (level flag::get(var_7ceb9ac6)) {
        str_struct = "upgraded_bow_struct_" + var_1493eda1;
        var_5be2705e = struct::get(str_struct, "targetname");
        var_5be2705e.var_67b5dd94.prompt_and_visibility_func = &function_47b1e30a;
        var_5be2705e.var_67b5dd94 function_c1947ff7();
    } else if (level flag::get(var_d1a0ccb)) {
        str_struct = "upgraded_bow_struct_" + var_1493eda1;
        var_5be2705e = struct::get(str_struct, "targetname");
        var_5be2705e function_3313abd5(&function_4a58bb9);
        var_5be2705e function_655cb8e();
        zm_unitrigger::unregister_unitrigger(var_5be2705e.var_67b5dd94);
    } else {
        var_683c1652 = var_1493eda1 + "_repaired";
        if (level flag::get(var_683c1652)) {
            str_struct = "quest_reforge_" + var_1493eda1;
        } else {
            str_struct = "quest_start_" + var_1493eda1;
        }
        var_abce3f8a = struct::get(str_struct, "targetname");
        var_abce3f8a function_f708e6b2();
    }
    switch (var_1493eda1) {
    case "rune_prison":
        var_c047de00 = level.var_bf08cf2d;
        break;
    case "demon_gate":
        var_c047de00 = level.var_59ca9b04;
        break;
    case "wolf_howl":
        var_c047de00 = level.var_a1e95710;
        break;
    case "elemental_storm":
        var_c047de00 = level.var_c5c6a918;
        break;
    }
    if (isdefined(var_c047de00)) {
        [[ var_c047de00 ]]();
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x29f98646, Offset: 0x16eb8
// Size: 0x86
function function_7910311b(e_player) {
    if (e_player === level.var_f8d1dc16) {
        level.var_f8d1dc16 = undefined;
        return;
    }
    if (e_player === level.var_c62829c7) {
        level.var_c62829c7 = undefined;
        return;
    }
    if (e_player === level.var_6e68c0d8) {
        level.var_6e68c0d8 = undefined;
        return;
    }
    if (e_player === level.var_52978d72) {
        level.var_52978d72 = undefined;
    }
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x11da6963, Offset: 0x16f48
    // Size: 0x1a4
    function function_7bbe3a25() {
        var_7774be93 = 1;
        if (level.players[0] === level.var_6e68c0d8) {
            var_1493eda1 = "<dev string:x9f9>";
            var_78cede1 = "<dev string:x667>";
            level.var_6e68c0d8 = undefined;
        } else if (level.players[0] === level.var_c62829c7) {
            var_1493eda1 = "<dev string:x548>";
            var_78cede1 = "<dev string:xfc>";
            level.var_c62829c7 = undefined;
        } else if (level.players[0] === level.var_f8d1dc16) {
            var_1493eda1 = "<dev string:x1119>";
            var_78cede1 = "<dev string:xe07>";
            level.var_f8d1dc16 = undefined;
        } else if (level.players[0] === level.var_52978d72) {
            var_1493eda1 = "<dev string:xce9>";
            var_78cede1 = "<dev string:xb28>";
            level.var_52978d72 = undefined;
        } else {
            return;
        }
        level clientfield::set(var_78cede1, 0);
        level notify("<dev string:x1129>" + var_1493eda1 + "<dev string:x112e>");
        level.players[0] notify(#"hash_3c5d2ca5");
        arrayremovevalue(level.var_427e7668, level.players[0]);
        level function_abeafdcb(var_1493eda1);
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xb7a64e8, Offset: 0x170f8
// Size: 0x8bc
function function_14dd5ea5() {
    switch (self.script_label) {
    case "elemental_bow_rune_prison":
        /#
            level endon(#"hash_44605b46");
            if (level flag::get("<dev string:x8b>")) {
                return;
            }
        #/
        var_1493eda1 = "rune_prison";
        var_febc5f71 = &function_d04d2c23;
        str_exploder = "lgt_rune_bow_plinth";
        var_5cdbaec4 = "rune";
        var_90de5a6f = level.var_2b11065e;
        break;
    case "elemental_bow_demongate":
        /#
            level endon(#"hash_8c23a1c7");
            if (level flag::get("<dev string:x5cc>")) {
                return;
            }
        #/
        var_1493eda1 = "demon_gate";
        var_febc5f71 = &function_983083c;
        str_exploder = "lgt_demon_bow_plinth";
        var_5cdbaec4 = "demon";
        var_90de5a6f = level.var_72a6d56b;
        break;
    case "elemental_bow_wolf_howl":
        /#
            level endon(#"hash_4bf5f2");
            if (level flag::get("<dev string:xa54>")) {
                return;
            }
        #/
        var_1493eda1 = "wolf_howl";
        var_febc5f71 = &function_e3ef7bf6;
        str_exploder = "lgt_wolf_bow_plinth";
        var_5cdbaec4 = "wolf";
        var_90de5a6f = level.var_eee1576;
        break;
    case "elemental_bow_storm":
        /#
            level endon(#"hash_b88a3579");
            if (level flag::get("<dev string:xd5e>")) {
                return;
            }
        #/
        var_1493eda1 = "elemental_storm";
        var_febc5f71 = &function_c5b609e2;
        str_exploder = "lgt_elemental_bow_plinth";
        var_5cdbaec4 = "storm";
        var_90de5a6f = level.var_18c771ad;
        break;
    }
    level function_f5e9876(var_5cdbaec4, 5);
    self function_3313abd5();
    while (true) {
        self.var_67b5dd94 waittill(#"trigger", e_who);
        e_target_player = level function_7b6fdb3e(self.script_label);
        if (e_who === e_target_player) {
            e_who playsound("zmb_give_arrow_piece");
            e_who playrumbleonentity("zm_castle_quest_interact_rumble");
            zm_unitrigger::unregister_unitrigger(self.var_67b5dd94);
            var_d1a0ccb = var_1493eda1 + "_placed";
            level flag::set(var_d1a0ccb);
            if (isdefined(var_90de5a6f)) {
                var_90de5a6f delete();
            }
            level thread zm_powerups::specific_powerup_drop("full_ammo", e_who.origin);
            break;
        }
    }
    exploder::exploder(str_exploder);
    level scene::play("p7_fxanim_zm_castle_quest_pedestal_bundle_" + var_1493eda1);
    /#
        switch (self.script_label) {
        case "<dev string:x113a>":
            level.var_e46b89a6 = 1;
            break;
        case "<dev string:x1154>":
            level.var_3adad02d = 1;
            break;
        case "<dev string:x116c>":
            level.var_85a25aa6 = 1;
            break;
        case "<dev string:x1184>":
            level.var_26f1fa87 = 1;
            break;
        }
    #/
    var_7ceb9ac6 = var_1493eda1 + "_upgraded";
    self.var_ce58f456 = 0;
    zm_spawner::register_zombie_death_event_callback(var_febc5f71);
    level flag::wait_till(var_7ceb9ac6);
    zm_spawner::deregister_zombie_death_event_callback(var_febc5f71);
    self function_3313abd5(&function_3bc663b);
    while (true) {
        self.var_67b5dd94 waittill(#"trigger", e_who);
        if (e_who function_9dfa159b()) {
            continue;
        }
        a_primaries = e_who getweaponslistprimaries();
        if (a_primaries.size == 1 && issubstr(a_primaries[0].name, "elemental_bow")) {
            continue;
        }
        e_target_player = level function_7b6fdb3e(self.script_label);
        if (isdefined(e_target_player)) {
            if (e_who === e_target_player) {
                if (e_who hasweapon(getweapon("elemental_bow"))) {
                    e_who zm_weapons::weapon_take(getweapon("elemental_bow"));
                    e_who notify(#"show_base_bow");
                }
                zm_unitrigger::unregister_unitrigger(self.var_67b5dd94);
                break;
            }
            continue;
        }
        level function_8b295d47(self.script_label);
        if (e_who hasweapon(getweapon("elemental_bow"))) {
            e_who zm_weapons::weapon_take(getweapon("elemental_bow"));
            e_who notify(#"show_base_bow");
        }
        zm_unitrigger::unregister_unitrigger(self.var_67b5dd94);
        break;
    }
    level thread function_f78eeee0(self.origin);
    e_who playrumbleonentity("zm_castle_quest_interact_rumble");
    level scene::play("p7_fxanim_zm_castle_quest_upgrade_bundle_" + var_1493eda1);
    exploder::stop_exploder(str_exploder);
    if (!isdefined(level.var_e8a6b6f7)) {
        level.var_e8a6b6f7 = [];
        array::thread_all(level.players, &function_b584c1e);
        callback::on_connect(&function_7c48f9d8);
    }
    self.var_d4a62e6b = getent(self.script_noteworthy, "targetname");
    e_target_player = level function_7b6fdb3e(self.script_label);
    if (!isdefined(e_target_player)) {
        level function_8b295d47(self.script_label);
    }
    self thread function_fb704679(e_target_player);
    var_491b9e06 = var_1493eda1 + "_spawned";
    level flag::set(var_491b9e06);
    level thread function_2c1c1d3e(var_1493eda1);
    level function_f5e9876(var_5cdbaec4, 6);
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x55df7715, Offset: 0x179c0
// Size: 0x84
function function_f78eeee0(v_position) {
    var_27dcb74b = spawn("script_origin", v_position);
    var_27dcb74b playsoundwithnotify("zmb_bow_upgrade", "sounddone");
    var_27dcb74b waittill(#"sounddone");
    var_27dcb74b delete();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x94498886, Offset: 0x17a50
// Size: 0x54
function function_bf26d3fb(var_e93a0115) {
    self clientfield::set(var_e93a0115, 1);
    self waittill(#"hash_894076d7");
    self clientfield::set(var_e93a0115, 0);
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0xe4cd2cac, Offset: 0x17ab0
// Size: 0x5b4
function function_2c1c1d3e(var_1493eda1) {
    wait 5;
    switch (var_1493eda1) {
    case "rune_prison":
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_rune_clock_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_rune_clock_wall_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_rune_orb_trail_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_rune_orb_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_rune_fireplace_arrow_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_rune_orb_scale_down_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_rune_orb_crust_bundle");
        break;
    case "demon_gate":
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_demongate_ceiling_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_demon_arrow_broken_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_demongate_urn_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_demongate_flagstones_bundle");
        level thread struct::function_368120a1("scene", "ai_zm_dlc1_zombie_demongate_fossil_attack_crawler");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_demongate_urn_destroy_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_demon_arrow_broken_reform_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_demon_arrow_whole_reform_bundle");
        level clientfield::set("demongate_client_cleanup", 0);
        break;
    case "wolf_howl":
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_wolf_arrow_broken_reveal_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_wolf_skull_roll_down_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_wolf_wall_explode_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_wolf_king_skeleton_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_wolf_platform_collapse_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_wolf_platform_rebuild_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_wolf_dig_courtyard_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_wolf_dig_road_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_wolf_dig_undercroft_bundle");
        break;
    case "elemental_storm":
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_storm_tower_break_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_storm_arrow_broken_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_weather_vane_spin_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_weather_vane_spin_point_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_weather_vane_spin_erratic_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_storm_arrow_reform_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_storm_arrow_whole_bundle");
        level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_storm_arrow_whole_idle_bundle");
        break;
    }
    level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_upgrade_bundle_" + var_1493eda1);
    level thread struct::function_368120a1("scene", "p7_fxanim_zm_castle_quest_pedestal_bundle_" + var_1493eda1);
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x17615c07, Offset: 0x18070
    // Size: 0x298
    function function_1a76d37c() {
        level scene::stop("<dev string:x4dd>", 1);
        level scene::stop("<dev string:x975>", 1);
        level scene::stop("<dev string:xc82>", 1);
        level scene::stop("<dev string:x10a4>", 1);
        exploder::exploder("<dev string:x1198>");
        exploder::exploder("<dev string:x11b1>");
        exploder::exploder("<dev string:x11c5>");
        exploder::exploder("<dev string:x11da>");
        level thread scene::play("<dev string:x4a7>");
        level thread scene::play("<dev string:x940>");
        level thread scene::play("<dev string:xc4e>");
        level scene::play("<dev string:x106a>");
        var_682d4b77 = getent("<dev string:x11ee>", "<dev string:x141>");
        var_682d4b77 thread function_bf26d3fb("<dev string:x1206>");
        var_5d79f228 = getent("<dev string:x121b>", "<dev string:x141>");
        var_5d79f228 thread function_bf26d3fb("<dev string:x1206>");
        var_3133abfb = getent("<dev string:x1234>", "<dev string:x141>");
        var_3133abfb thread function_bf26d3fb("<dev string:x1206>");
        var_48ce3e52 = getent("<dev string:x124c>", "<dev string:x141>");
        var_48ce3e52 thread function_bf26d3fb("<dev string:x1206>");
        level.var_89b2cd5c = 1;
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x38f8a90, Offset: 0x18310
    // Size: 0xfc
    function function_8bbebef2() {
        if (!(isdefined(level.var_89b2cd5c) && level.var_89b2cd5c)) {
            return;
        }
        level thread scene::play("<dev string:x4dd>");
        level thread scene::play("<dev string:x975>");
        level thread scene::play("<dev string:xc82>");
        level scene::play("<dev string:x10a4>");
        exploder::stop_exploder("<dev string:x1198>");
        exploder::stop_exploder("<dev string:x11b1>");
        exploder::stop_exploder("<dev string:x11c5>");
        exploder::stop_exploder("<dev string:x11da>");
    }

#/

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0xb5f946d7, Offset: 0x18418
// Size: 0x63a
function function_fb704679(e_target_player) {
    if (!isdefined(e_target_player)) {
        e_target_player = undefined;
    }
    if (isdefined(e_target_player)) {
        e_target_player notify(#"hash_ea0c887b");
        level notify(#"hash_ea0c887b");
        self function_3313abd5(&function_87cf409b);
    } else {
        self function_3313abd5(&function_4b76cf52);
    }
    if (!isdefined(level.var_e8a6b6f7)) {
        level.var_e8a6b6f7 = [];
    } else if (!isarray(level.var_e8a6b6f7)) {
        level.var_e8a6b6f7 = array(level.var_e8a6b6f7);
    }
    level.var_e8a6b6f7[level.var_e8a6b6f7.size] = self.var_67b5dd94;
    w_upgrade = getweapon(self.script_label);
    while (true) {
        self.var_67b5dd94 waittill(#"trigger", e_who);
        if (e_who function_9dfa159b() || e_who hasweapon(w_upgrade)) {
            continue;
        }
        e_target_player = level function_7b6fdb3e(self.script_label);
        if (e_who function_5facaaf9(e_target_player, self.script_label)) {
            if (e_who hasweapon(getweapon("elemental_bow"))) {
                e_who zm_weapons::weapon_take(getweapon("elemental_bow"));
            } else if (e_who hasweapon(getweapon("elemental_bow_storm"))) {
                e_who zm_weapons::weapon_take(getweapon("elemental_bow_storm"));
            } else if (e_who hasweapon(getweapon("elemental_bow_demongate"))) {
                e_who zm_weapons::weapon_take(getweapon("elemental_bow_demongate"));
            } else if (e_who hasweapon(getweapon("elemental_bow_wolf_howl"))) {
                e_who zm_weapons::weapon_take(getweapon("elemental_bow_wolf_howl"));
            } else if (e_who hasweapon(getweapon("elemental_bow_rune_prison"))) {
                e_who zm_weapons::weapon_take(getweapon("elemental_bow_rune_prison"));
            }
            e_who zm_weapons::weapon_give(w_upgrade, 0, 0, 1);
            if (isdefined(level.var_7df95fd1) && isdefined(level.var_7df95fd1[w_upgrade.name])) {
                e_who setweaponammostock(w_upgrade, level.var_7df95fd1[w_upgrade.name]);
            }
            if (isdefined(level.var_67616e8e) && isdefined(level.var_67616e8e[w_upgrade.name])) {
                e_who setweaponammoclip(w_upgrade, level.var_67616e8e[w_upgrade.name]);
            } else {
                e_who setweaponammoclip(w_upgrade, w_upgrade.clipsize);
            }
            e_who switchtoweapon(w_upgrade);
            e_who playsound("zmb_bow_pickup");
            self.var_d4a62e6b hide();
            arrayremovevalue(level.var_e8a6b6f7, self.var_67b5dd94);
            zm_unitrigger::unregister_unitrigger(self.var_67b5dd94);
            if (e_who hasperk("specialty_additionalprimaryweapon")) {
                a_w_weapons = e_who getweaponslistprimaries();
                if (a_w_weapons.size >= 3) {
                    for (i = 2; i < a_w_weapons.size; i++) {
                        if (a_w_weapons[i] == w_upgrade) {
                            e_who.var_bec0aa15 = 1;
                            break;
                        }
                    }
                }
            }
            level thread function_a4861409(e_who, self);
            self thread function_971e3797();
            e_who thread function_cdfce37d(self.script_label);
            return;
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xfc7e5cfc, Offset: 0x18a60
// Size: 0x1fa
function function_971e3797() {
    self function_3313abd5(&function_6041c7d9);
    w_upgrade = getweapon(self.script_label);
    while (true) {
        self.var_67b5dd94 waittill(#"trigger", e_who);
        if (e_who function_9dfa159b() || !e_who hasweapon(w_upgrade)) {
            continue;
        }
        e_who playsound("zmb_bow_return");
        level.var_7df95fd1[w_upgrade.name] = e_who getweaponammostock(w_upgrade);
        level.var_67616e8e[w_upgrade.name] = e_who getweaponammoclip(w_upgrade);
        e_who zm_weapons::weapon_take(w_upgrade);
        zm_unitrigger::unregister_unitrigger(self.var_67b5dd94);
        e_who.var_bec0aa15 = undefined;
        str_notify = self.script_label + "_returned";
        level notify(str_notify);
        e_who notify(#"show_base_bow");
        self.var_d4a62e6b show();
        self thread function_fb704679();
        level function_8b295d47(self.script_label);
        return;
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 2, eflags: 0x0
// Checksum 0xe1e655ef, Offset: 0x18c68
// Size: 0x31a
function function_a4861409(e_player, var_285c992d) {
    str_endon = var_285c992d.script_label + "_returned";
    level endon(str_endon);
    var_bbdf3539 = 0;
    while (true) {
        str_notify = e_player util::function_183e3618("death", "weapon_change", "bgb_about_to_take_on_bled_out", "bled_out", "player_revived", level, str_endon);
        var_285c992d.var_67b5dd94 function_c1947ff7();
        if (str_notify == "death") {
            zm_unitrigger::unregister_unitrigger(var_285c992d.var_67b5dd94);
            var_285c992d.var_d4a62e6b show();
            var_285c992d thread function_fb704679();
            return;
        }
        if (str_notify == "bgb_about_to_take_on_bled_out") {
            if (e_player bgb::is_enabled("zm_bgb_arms_grace")) {
                var_bbdf3539 = 1;
            }
            continue;
        }
        var_e1041201 = getweapon(var_285c992d.script_label);
        if (isdefined(e_player.laststand) && isdefined(e_player.var_bec0aa15) && e_player.var_bec0aa15 && e_player.laststand && str_notify != "bled_out") {
            continue;
        }
        if (var_bbdf3539) {
            if (e_player hasweapon(var_e1041201)) {
                var_bbdf3539 = 0;
            }
            continue;
        }
        if (!e_player hasweapon(var_e1041201) && !e_player bgb::is_enabled("zm_bgb_disorderly_combat")) {
            e_player.var_bec0aa15 = undefined;
            zm_unitrigger::unregister_unitrigger(var_285c992d.var_67b5dd94);
            var_285c992d.var_d4a62e6b show();
            var_285c992d thread function_fb704679();
            level notify(var_285c992d.script_label + "_stop_tracking");
            level function_8b295d47(var_285c992d.script_label);
            return;
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xa1948fee, Offset: 0x18f90
// Size: 0xae
function function_b584c1e() {
    self endon(#"death");
    while (true) {
        self waittill(#"weapon_change");
        foreach (var_4e85a5a3 in level.var_e8a6b6f7) {
            var_4e85a5a3 function_c1947ff7();
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xb1322863, Offset: 0x19048
// Size: 0x1c
function function_7c48f9d8() {
    self thread function_b584c1e();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0xf90a5c6d, Offset: 0x19070
// Size: 0xee
function function_cdfce37d(var_87e87273) {
    self endon(#"death");
    level endon(var_87e87273 + "_stop_tracking");
    level endon(var_87e87273 + "_returned");
    var_48e2fc20 = getweapon(var_87e87273);
    while (true) {
        self util::waittill_either("missile_fire", "zmb_max_ammo");
        if (self hasweapon(var_48e2fc20)) {
            level.var_7df95fd1[var_87e87273] = self getweaponammostock(var_48e2fc20);
            level.var_67616e8e[var_87e87273] = self getweaponammoclip(var_48e2fc20);
        }
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 2, eflags: 0x0
// Checksum 0x3143109d, Offset: 0x19168
// Size: 0x108
function function_5facaaf9(e_target_player, str_weapon_name) {
    if (isdefined(e_target_player)) {
        if (self === e_target_player) {
            arrayremovevalue(level.var_427e7668, e_target_player);
            switch (str_weapon_name) {
            case "elemental_bow_rune_prison":
                level.var_c62829c7 = undefined;
                level notify(#"hash_f2225849");
                break;
            case "elemental_bow_demongate":
                level.var_6e68c0d8 = undefined;
                level notify(#"hash_3a8af95a");
                break;
            case "elemental_bow_wolf_howl":
                level.var_52978d72 = undefined;
                level notify(#"hash_22816b8");
                break;
            case "elemental_bow_storm":
                level.var_f8d1dc16 = undefined;
                level notify(#"hash_cd9f0cdc");
                break;
            }
            return true;
        }
    } else {
        level function_3b0f7209(str_weapon_name, self.characterindex);
    }
    return true;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x23dea051, Offset: 0x19278
// Size: 0x8a
function function_7b6fdb3e(var_1493eda1) {
    switch (var_1493eda1) {
    case "elemental_bow_rune_prison":
        e_target_player = level.var_c62829c7;
        break;
    case "elemental_bow_demongate":
        e_target_player = level.var_6e68c0d8;
        break;
    case "elemental_bow_wolf_howl":
        e_target_player = level.var_52978d72;
        break;
    case "elemental_bow_storm":
        e_target_player = level.var_f8d1dc16;
        break;
    }
    return e_target_player;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 4, eflags: 0x0
// Checksum 0xf030e344, Offset: 0x19310
// Size: 0x13e
function function_51a90202(w_weapon, var_859c4788, v_impact, t_damage) {
    if (!isdefined(var_859c4788)) {
        var_859c4788 = 0;
    }
    if (!isdefined(v_impact)) {
        v_impact = undefined;
    }
    if (!isdefined(t_damage)) {
        t_damage = undefined;
    }
    if (!isdefined(w_weapon) || !isdefined(w_weapon.name)) {
        return false;
    }
    if (var_859c4788 && isdefined(v_impact) && isdefined(t_damage)) {
        var_64deb4b = spawn("script_origin", v_impact);
        if (!var_64deb4b istouching(t_damage)) {
            var_64deb4b delete();
            return false;
        }
        var_64deb4b delete();
    }
    if (issubstr(w_weapon.name, "elemental_bow")) {
        return true;
    }
    return false;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x6ec3f1e1, Offset: 0x19458
// Size: 0xc6
function function_fae23b43() {
    if (self hasweapon(getweapon("elemental_bow_wolf_howl")) || self hasweapon(getweapon("elemental_bow_storm")) || self hasweapon(getweapon("elemental_bow_rune_prison")) || self hasweapon(getweapon("elemental_bow_demongate"))) {
        return true;
    }
    return false;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x5e474e53, Offset: 0x19528
// Size: 0xc6
function function_9dfa159b() {
    if (!self weaponcyclingenabled() || !self offhandweaponsenabled()) {
        return true;
    }
    w_current = self getcurrentweapon();
    if (zm_utility::is_placeable_mine(w_current) || zm_equipment::is_equipment_that_blocks_purchase(w_current) || self hasweapon(getweapon("minigun"))) {
        return true;
    }
    return false;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 2, eflags: 0x0
// Checksum 0xcb18e992, Offset: 0x195f8
// Size: 0x9e
function function_ab623d34(var_e459d8fb, e_volume) {
    if (!isdefined(e_volume)) {
        e_volume = undefined;
    }
    if (!isdefined(self) || self.isdog || self.archetype === "mechz") {
        return false;
    }
    if (!isdefined(var_e459d8fb) || self.attacker !== var_e459d8fb) {
        return false;
    }
    if (isdefined(e_volume)) {
        if (!self istouching(e_volume)) {
            return false;
        }
    }
    return true;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 4, eflags: 0x0
// Checksum 0x8a47b4b, Offset: 0x196a0
// Size: 0x1d4
function function_55c48922(v_origin, v_target, var_25c1c42e, var_7364b0dd) {
    if (!isdefined(v_origin) || !isdefined(v_target)) {
        return;
    }
    str_clientfield_name = "zombie_soul_" + var_25c1c42e + "_fx";
    if (!var_7364b0dd) {
        v_origin += (0, 0, 48);
    }
    v_angles = vectortoangles(v_target - v_origin);
    mdl_anchor = util::spawn_model("tag_origin", v_origin, v_angles);
    mdl_anchor playsound("zmb_ee_soul_start");
    mdl_anchor playloopsound("zmb_ee_soul_lp");
    mdl_anchor clientfield::set(str_clientfield_name, 1);
    mdl_anchor moveto(v_target, 1.75, 0.75);
    mdl_anchor waittill(#"movedone");
    mdl_anchor playsound("zmb_ee_soul_impact");
    level notify(#"hash_d8b279ab");
    mdl_anchor clientfield::set(str_clientfield_name, 0);
    wait 0.05;
    mdl_anchor delete();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 4, eflags: 0x0
// Checksum 0xa391f78d, Offset: 0x19880
// Size: 0x1fc
function function_3313abd5(var_81e39ef9, str_hint, v_origin, var_9eb6cf96) {
    if (!isdefined(var_81e39ef9)) {
        var_81e39ef9 = undefined;
    }
    if (!isdefined(str_hint)) {
        str_hint = undefined;
    }
    if (!isdefined(v_origin)) {
        v_origin = undefined;
    }
    if (!isdefined(var_9eb6cf96)) {
        var_9eb6cf96 = undefined;
    }
    s_unitrigger = spawnstruct();
    if (isdefined(v_origin)) {
        s_unitrigger.origin = v_origin;
    } else {
        s_unitrigger.origin = self.origin;
    }
    s_unitrigger.angles = self.angles;
    s_unitrigger.script_unitrigger_type = "unitrigger_radius_use";
    if (isdefined(var_9eb6cf96)) {
        s_unitrigger.radius = var_9eb6cf96;
    } else {
        s_unitrigger.radius = 72;
    }
    s_unitrigger.cursor_hint = "HINT_NOICON";
    s_unitrigger.require_look_at = 1;
    zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger, 1);
    if (isdefined(str_hint)) {
        s_unitrigger.str_hint = str_hint;
    }
    if (isdefined(self.script_label)) {
        s_unitrigger.str_weapon = self.script_label;
        s_unitrigger.prompt_and_visibility_func = &function_c2dcccdc;
    }
    if (isdefined(var_81e39ef9)) {
        s_unitrigger.prompt_and_visibility_func = var_81e39ef9;
    }
    self.var_67b5dd94 = s_unitrigger;
    zm_unitrigger::register_static_unitrigger(s_unitrigger, &function_573ca470);
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0xb264dfab, Offset: 0x19a88
// Size: 0x72
function function_c2dcccdc(e_player) {
    e_target_player = level function_7b6fdb3e(self.stub.str_weapon);
    self sethintstring(%);
    if (e_player === e_target_player) {
        return true;
    }
    return false;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0xd8e5cf83, Offset: 0x19b08
// Size: 0xb4
function function_573ca470() {
    self endon(#"kill_trigger");
    self.stub thread function_c1947ff7();
    while (true) {
        self waittill(#"trigger", e_player);
        if (e_player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (e_player.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(e_player)) {
            continue;
        }
        self.stub notify(#"trigger", e_player);
    }
}

// Namespace zm_castle_weap_quest_upgrade
// Params 0, eflags: 0x0
// Checksum 0x580830bf, Offset: 0x19bc8
// Size: 0x1c
function function_c1947ff7() {
    self zm_unitrigger::run_visibility_function_for_all_triggers();
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x84534c5f, Offset: 0x19bf0
// Size: 0x30
function function_47b1e30a(e_player) {
    self sethintstring(%);
    return true;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x79878d81, Offset: 0x19c28
// Size: 0x70
function function_4a58bb9(e_player) {
    if (array::contains(level.var_427e7668, e_player)) {
        self sethintstring(%ZM_CASTLE_TRADE_UPGRADE_QUEST);
    } else {
        self sethintstring(%ZM_CASTLE_BIND_TO_QUEST);
    }
    return true;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x2372cea0, Offset: 0x19ca0
// Size: 0x11e
function function_8c1fd619(e_player) {
    e_target_player = function_7b6fdb3e(self.stub.str_weapon);
    if (isdefined(e_target_player)) {
        if (e_player == e_target_player) {
            self sethintstring(%ZM_CASTLE_REFORGED_ARROW);
            return true;
        }
    } else if (!array::contains(level.var_427e7668, e_player)) {
        self sethintstring(%ZM_CASTLE_BIND_TO_QUEST);
        return true;
    } else if (array::contains(level.var_427e7668, e_player)) {
        self sethintstring(%ZM_CASTLE_TRADE_UPGRADE_QUEST);
        return true;
    }
    self sethintstring(%);
    return false;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x504d54cc, Offset: 0x19dc8
// Size: 0x8e
function function_3bc663b(e_player) {
    self sethintstring(%);
    if (e_player function_9dfa159b()) {
        return false;
    }
    e_target_player = level function_7b6fdb3e(self.stub.str_weapon);
    if (e_player === e_target_player) {
        return true;
    }
    return false;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x34a7e09c, Offset: 0x19e60
// Size: 0x158
function function_87cf409b(e_player) {
    if (e_player function_9dfa159b()) {
        self sethintstring(%);
        return 0;
    }
    switch (self.stub.str_weapon) {
    case "elemental_bow_wolf_howl":
        var_e459d8fb = level.var_52978d72;
        str_hint = %ZM_CASTLE_PICK_UP_WIND_BOW;
        break;
    case "elemental_bow_rune_prison":
        var_e459d8fb = level.var_c62829c7;
        str_hint = %ZM_CASTLE_PICK_UP_ICE_BOW;
        break;
    case "elemental_bow_demongate":
        var_e459d8fb = level.var_6e68c0d8;
        str_hint = %ZM_CASTLE_PICK_UP_FIRE_BOW;
        break;
    case "elemental_bow_storm":
        var_e459d8fb = level.var_f8d1dc16;
        str_hint = %ZM_CASTLE_PICK_UP_LIGHTNING_BOW;
        break;
    }
    if (e_player === var_e459d8fb) {
        self sethintstring(str_hint);
        return 1;
    }
    self sethintstring(%);
    return 0;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0xe0800134, Offset: 0x19fc0
// Size: 0x10a
function function_4b76cf52(e_player) {
    if (e_player function_9dfa159b()) {
        self sethintstring(%);
        return false;
    } else {
        switch (self.stub.str_weapon) {
        case "elemental_bow_wolf_howl":
            self sethintstring(%ZM_CASTLE_PICK_UP_WIND_BOW);
            break;
        case "elemental_bow_rune_prison":
            self sethintstring(%ZM_CASTLE_PICK_UP_ICE_BOW);
            break;
        case "elemental_bow_demongate":
            self sethintstring(%ZM_CASTLE_PICK_UP_FIRE_BOW);
            break;
        case "elemental_bow_storm":
            self sethintstring(%ZM_CASTLE_PICK_UP_LIGHTNING_BOW);
            break;
        }
    }
    return true;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x51b1f7f1, Offset: 0x1a0d8
// Size: 0x286
function function_6041c7d9(e_player) {
    if (e_player function_9dfa159b()) {
        self sethintstring(%);
        return false;
    }
    a_primaries = e_player getweaponslistprimaries();
    if (a_primaries.size == 1 && issubstr(a_primaries[0].name, "elemental_bow")) {
        self sethintstring(%);
        return false;
    }
    switch (self.stub.str_weapon) {
    case "elemental_bow_wolf_howl":
        if (e_player hasweapon(getweapon("elemental_bow_wolf_howl"))) {
            self sethintstring(%ZM_CASTLE_RETURN_WIND_BOW);
            return true;
        }
        break;
    case "elemental_bow_rune_prison":
        if (e_player hasweapon(getweapon("elemental_bow_rune_prison"))) {
            self sethintstring(%ZM_CASTLE_RETURN_ICE_BOW);
            return true;
        }
        break;
    case "elemental_bow_demongate":
        if (e_player hasweapon(getweapon("elemental_bow_demongate"))) {
            self sethintstring(%ZM_CASTLE_RETURN_FIRE_BOW);
            return true;
        }
        break;
    case "elemental_bow_storm":
        if (e_player hasweapon(getweapon("elemental_bow_storm"))) {
            self sethintstring(%ZM_CASTLE_RETURN_LIGHTNING_BOW);
            return true;
        }
        break;
    }
    self sethintstring(%);
    return false;
}

// Namespace zm_castle_weap_quest_upgrade
// Params 2, eflags: 0x0
// Checksum 0x61c079e9, Offset: 0x1a368
// Size: 0xbc
function function_3b0f7209(str_weapon_name, n_character_index) {
    switch (str_weapon_name) {
    case "elemental_bow_rune_prison":
        var_78cede1 = "quest_owner_rune";
        break;
    case "elemental_bow_demongate":
        var_78cede1 = "quest_owner_demon";
        break;
    case "elemental_bow_wolf_howl":
        var_78cede1 = "quest_owner_wolf";
        break;
    case "elemental_bow_storm":
        var_78cede1 = "quest_owner_storm";
        break;
    }
    level clientfield::set(var_78cede1, function_85bfa3fd(n_character_index));
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x3a1235e6, Offset: 0x1a430
// Size: 0xa4
function function_8b295d47(str_weapon_name) {
    switch (str_weapon_name) {
    case "elemental_bow_rune_prison":
        var_78cede1 = "quest_owner_rune";
        break;
    case "elemental_bow_demongate":
        var_78cede1 = "quest_owner_demon";
        break;
    case "elemental_bow_wolf_howl":
        var_78cede1 = "quest_owner_wolf";
        break;
    case "elemental_bow_storm":
        var_78cede1 = "quest_owner_storm";
        break;
    }
    level clientfield::set(var_78cede1, 0);
}

// Namespace zm_castle_weap_quest_upgrade
// Params 1, eflags: 0x0
// Checksum 0x5eec25d0, Offset: 0x1a4e0
// Size: 0x56
function function_85bfa3fd(n_character_index) {
    switch (n_character_index) {
    case 0:
        return 1;
    case 1:
        return 2;
    case 2:
        return 3;
    case 3:
        return 4;
    }
}

/#

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0xaaced37f, Offset: 0x1a540
    // Size: 0x38
    function function_2449723c() {
        if (isdefined(self.var_8665ab89)) {
            if (self.var_8665ab89 == gettime()) {
                return 1;
            }
        }
        self.var_8665ab89 = gettime();
        return 0;
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 0, eflags: 0x0
    // Checksum 0x753bbc5e, Offset: 0x1a580
    // Size: 0x5ac
    function function_952cba55() {
        level flagsys::wait_till("<dev string:x1265>");
        wait 1;
        zm_devgui::add_custom_devgui_callback(&function_50564c39);
        zm_devgui::add_custom_devgui_callback(&function_23e16ccd);
        zm_devgui::add_custom_devgui_callback(&function_f31ec4b7);
        zm_devgui::add_custom_devgui_callback(&function_5a256cec);
        zm_devgui::add_custom_devgui_callback(&function_144e821b);
        adddebugcommand("<dev string:x127e>");
        adddebugcommand("<dev string:x12e6>");
        adddebugcommand("<dev string:x134b>");
        adddebugcommand("<dev string:x13b4>");
        adddebugcommand("<dev string:x141b>");
        adddebugcommand("<dev string:x1481>");
        adddebugcommand("<dev string:x14ed>");
        adddebugcommand("<dev string:x155b>");
        adddebugcommand("<dev string:x15c3>");
        adddebugcommand("<dev string:x162f>");
        adddebugcommand("<dev string:x16a5>");
        adddebugcommand("<dev string:x170d>");
        adddebugcommand("<dev string:x1784>");
        adddebugcommand("<dev string:x1806>");
        adddebugcommand("<dev string:x1873>");
        adddebugcommand("<dev string:x18ee>");
        adddebugcommand("<dev string:x195f>");
        adddebugcommand("<dev string:x19d0>");
        adddebugcommand("<dev string:x1a45>");
        adddebugcommand("<dev string:x1ab6>");
        adddebugcommand("<dev string:x1b31>");
        adddebugcommand("<dev string:x1b9e>");
        adddebugcommand("<dev string:x1c1e>");
        adddebugcommand("<dev string:x1c9c>");
        adddebugcommand("<dev string:x1d22>");
        adddebugcommand("<dev string:x1da4>");
        adddebugcommand("<dev string:x1e1f>");
        adddebugcommand("<dev string:x1e8c>");
        adddebugcommand("<dev string:x1eff>");
        adddebugcommand("<dev string:x1f6f>");
        adddebugcommand("<dev string:x1fdc>");
        adddebugcommand("<dev string:x2052>");
        adddebugcommand("<dev string:x20ba>");
        adddebugcommand("<dev string:x212f>");
        adddebugcommand("<dev string:x2195>");
        adddebugcommand("<dev string:x220d>");
        adddebugcommand("<dev string:x2285>");
        adddebugcommand("<dev string:x22ff>");
        adddebugcommand("<dev string:x2371>");
        adddebugcommand("<dev string:x23de>");
        adddebugcommand("<dev string:x2456>");
        adddebugcommand("<dev string:x24cc>");
        adddebugcommand("<dev string:x253a>");
        adddebugcommand("<dev string:x25a3>");
        adddebugcommand("<dev string:x2614>");
        adddebugcommand("<dev string:x2688>");
        adddebugcommand("<dev string:x26ee>");
        adddebugcommand("<dev string:x2761>");
        adddebugcommand("<dev string:x27d5>");
        adddebugcommand("<dev string:x283f>");
        adddebugcommand("<dev string:x28b2>");
        adddebugcommand("<dev string:x2925>");
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 1, eflags: 0x0
    // Checksum 0x398117c6, Offset: 0x1ab38
    // Size: 0x146
    function function_50564c39(cmd) {
        switch (cmd) {
        case "<dev string:x2998>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_7bbe3a25();
            return 1;
        case "<dev string:x29ac>":
            if (level function_2449723c()) {
                return 1;
            }
            level flag::set("<dev string:x29bb>");
            level thread zm_castle_weap_quest::function_a01a53de();
            return 1;
        case "<dev string:x29d1>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_1a76d37c();
            return 1;
        case "<dev string:x29dd>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_8bbebef2();
            return 1;
        }
        return 0;
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 1, eflags: 0x0
    // Checksum 0xd7d0b46a, Offset: 0x1ac88
    // Size: 0x2e6
    function function_23e16ccd(cmd) {
        switch (cmd) {
        case "<dev string:x29eb>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_4e281784();
            return 1;
        case "<dev string:x29f8>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_ff914e7a();
            return 1;
        case "<dev string:x2a08>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_de755a0();
            return 1;
        case "<dev string:x2a19>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_2d151482();
            return 1;
        case "<dev string:x2a27>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_e896a88d();
            return 1;
        case "<dev string:x2a36>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_dc66bbef();
            return 1;
        case "<dev string:x2a4b>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_8c23a1c7();
            return 1;
        case "<dev string:x2a5e>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_c0165d14();
            return 1;
        case "<dev string:x2a75>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_4cb8f913();
            return 1;
        case "<dev string:x2a8e>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_b2f7fb48();
            return 1;
        case "<dev string:x2a9b>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_8d7d2896();
            return 1;
        }
        return 0;
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 1, eflags: 0x0
    // Checksum 0x694aec58, Offset: 0x1af78
    // Size: 0x2e6
    function function_f31ec4b7(cmd) {
        switch (cmd) {
        case "<dev string:x2ab0>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_2db350be();
            return 1;
        case "<dev string:x2ac0>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_cdf5ca22();
            return 1;
        case "<dev string:x2ad0>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_5508467e();
            return 1;
        case "<dev string:x2ae2>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_b1cac6d2();
            return 1;
        case "<dev string:x2af2>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_632adf35();
            return 1;
        case "<dev string:x2b07>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_b88a3579();
            return 1;
        case "<dev string:x2b1a>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_c57b4999();
            return 1;
        case "<dev string:x2b32>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_ae42a737();
            return 1;
        case "<dev string:x2b43>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_1ad44df5();
            return 1;
        case "<dev string:x2b5e>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_6a8283d3();
            return 1;
        case "<dev string:x2b77>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_1b2a8d00();
            return 1;
        }
        return 0;
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 1, eflags: 0x0
    // Checksum 0x8563326c, Offset: 0x1b268
    // Size: 0x3e6
    function function_5a256cec(cmd) {
        switch (cmd) {
        case "<dev string:x2b89>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_c272bd2a();
            return 1;
        case "<dev string:x2b99>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_6c9ecb6();
            return 1;
        case "<dev string:x2ba9>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_6de95813();
            return 1;
        case "<dev string:x2bb7>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_e09edb0();
            return 1;
        case "<dev string:x2bc4>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_57edd5aa();
            return 1;
        case "<dev string:x2bd8>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_44605b46();
            return 1;
        case "<dev string:x2bea>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_7a965585();
            return 1;
        case "<dev string:x2bfc>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_3d19bfe5();
            return 1;
        case "<dev string:x2c0a>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_d326a001();
            return 1;
        case "<dev string:x2c21>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_35cccade();
            return 1;
        case "<dev string:x2c38>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_23e77c95();
            return 1;
        case "<dev string:x2c50>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_455e5c02();
            return 1;
        case "<dev string:x2c64>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_e7cc5223();
            return 1;
        case "<dev string:x2c72>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_798d8c4d();
            return 1;
        case "<dev string:x2c89>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_e83bfb3();
            return 1;
        }
        return 0;
    }

    // Namespace zm_castle_weap_quest_upgrade
    // Params 1, eflags: 0x0
    // Checksum 0xd64e839d, Offset: 0x1b658
    // Size: 0x2e6
    function function_144e821b(cmd) {
        switch (cmd) {
        case "<dev string:x2c9f>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_2a8e7fe2();
            return 1;
        case "<dev string:x2cad>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_5643d04b();
            return 1;
        case "<dev string:x2cbc>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_3429d04c();
            return 1;
        case "<dev string:x2ccb>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_b6709ba6();
            return 1;
        case "<dev string:x2cdf>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_4bf5f2();
            return 1;
        case "<dev string:x2cf1>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_2bac97b4();
            return 1;
        case "<dev string:x2d04>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_64b2bde9();
            return 1;
        case "<dev string:x2d16>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_5928a2a7();
            return 1;
        case "<dev string:x2d27>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_a3638154();
            return 1;
        case "<dev string:x2d39>":
            if (level function_2449723c()) {
                return 1;
            }
            level function_6c8179b7();
            return 1;
        case "<dev string:x2d47>":
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_d5e44655();
            return 1;
        }
        return 0;
    }

#/
