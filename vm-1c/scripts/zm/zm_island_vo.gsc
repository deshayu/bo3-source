#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_timer;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/zm_island_util;

#namespace zm_island_vo;

// Namespace zm_island_vo
// Params 0, eflags: 0x2
// Checksum 0x767aed28, Offset: 0x1998
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_island_vo", &__init__, undefined, undefined);
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x7f5fc30b, Offset: 0x19d8
// Size: 0x1ec
function __init__() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    level.var_5db32b5b = [];
    level.var_cdd49d24 = &function_642e6aef;
    function_267933e4();
    level thread function_772aa229();
    level thread function_c426b455();
    level flag::init("thrasher_spotted");
    level flag::init("vo_lock_thrasher_appear_roar");
    level flag::init("takeofight_wave_spawning");
    level thread function_8eebdc4d();
    level thread function_5ca4424();
    level thread function_a5b6f9c0();
    level.var_bac3b790 = [];
    level.var_38d92be7 = [];
    level.var_c6455b5 = [];
    level.var_2c67f767 = [];
    level.var_4b332a77 = [];
    level.var_bc80de72 = [];
    level.var_9c6abc49 = [];
    level.var_caa91bc0 = [];
    level flag::init("skull_s_pickup_vo_locked");
    zm_spawner::register_zombie_death_event_callback(&function_b978ce37);
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x1836a727, Offset: 0x1bd0
// Size: 0x9c4
function on_player_spawned() {
    self.var_10f58653 = [];
    self.var_bac3b790 = [];
    self.var_38d92be7 = [];
    self.var_c6455b5 = [];
    self.var_2c67f767 = [];
    self.var_4b332a77 = [];
    self.var_bc80de72 = [];
    self.var_9c6abc49 = [];
    self.var_caa91bc0 = [];
    self.isspeaking = 0;
    self.n_vo_priority = 0;
    self thread zm_audio::water_vox();
    self function_65f8953a("player_filled_bucket", "bucket", "fill", 10, 3);
    self function_65f8953a("player_watered_plant", "water", "plant", 5, 3);
    self function_65f8953a("player_opened_bunker", "access", "bunker", 10, 1);
    self function_65f8953a("island_riotshield_pickup_from_table", "pickup", "zombie_shield", 5);
    self function_65f8953a("player_has_gasmask", "pickup", "gas_mask", 5, 1);
    self function_65f8953a("player_lost_gasmask", "break", "gas_mask", 5, 3);
    self function_65f8953a("flag_player_completed_challenge_1", "response", "positive", 5);
    self function_65f8953a("flag_player_completed_challenge_2", "response", "positive", 5);
    self function_65f8953a("flag_player_completed_challenge_3", "response", "positive", 5);
    self function_65f8953a("player_opened_pap", "response", "positive", 5);
    self function_65f8953a("player_spore_enhanced", "response", "positive", 30);
    self function_65f8953a("player_revealed_cache_plant_good", "response", "positive", 60, 0, 1);
    self function_65f8953a("player_ate_fruit_success", "response", "positive", 60, 0);
    self function_65f8953a("player_got_gasmask_part", "pickup", "generic", 5);
    self function_65f8953a("player_got_ww_part", "pickup", "generic", 5);
    self function_65f8953a("player_got_valve_part", "pickup", "generic", 5);
    self function_65f8953a("player_got_craftable_piece_for_craft_shield_zm", "pickup", "generic", 5);
    self function_65f8953a("player_revealed_cache_plant_bad", "response", "negative", 60, 0, 1);
    self function_65f8953a("player_got_gold_bucket", "ee", "bucket", 5);
    self function_65f8953a("player_upgraded_ww", "quest_ww", "pickup", 5);
    self function_65f8953a("player_got_mirg2000", "quest_ww", "pickup", 5);
    self function_65f8953a("player_tried_pickup_mirg2000", "quest_ww", "pickup_attempt", 30, 0);
    self function_65f8953a("player_killed_zombie_with_mirg2000", "kill", "kt4", 60);
    self function_65f8953a("player_hit_plant_with_mirg2000", "use", "kt4", 60, 3);
    self function_65f8953a("player_got_lightning_shield", "ee", "shield", 20);
    self function_65f8953a("player_saw_good_thrasher_creation", "ee", "thrasher_create", 10, 1, 1);
    self function_65f8953a("player_saw_good_thrasher_death", "ee", "thrasher_dies", 10, 1, 1);
    self function_65f8953a("skullweapon_killed_zombie", "keeperskull", "kill", 60);
    self function_65f8953a("skullweapon_mesmerized_zombie", "keeperskull", "protect", 60);
    self function_65f8953a("skullweapon_revealed_location", "keeperskull", "reveal", 10, 0, 5);
    self function_65f8953a("skull_weapon_fully_charged", "keeperskull", "recharged", 10, 0, 1);
    self function_65f8953a("player_killed_spider", "spider", "kill", 30, 5, 1);
    self function_65f8953a("tearing_web", "web", "remove", 30, 5);
    self function_65f8953a("aquired_spider_equipment", "ee", "spider_equip", 10, 1);
    self function_65f8953a("player_used_controllable_spider", "ee", "spider_use", 10, 3);
    self function_65f8953a("player_eaten_by_thrasher", "thrasher", "eaten", 1, 0, 1);
    self function_65f8953a("player_enraged_thrasher", "thrasher", "enraged", 120, 0, 1);
    self function_65f8953a("player_stunned_thrasher", "thrasher", "stun", 120);
    self function_65f8953a("player_killed_thrasher", "thrasher", "kill", 120);
    self function_65f8953a("sewer_over", "sewer", "use", 10, 5);
    self function_65f8953a("zipline_start", "zipline", "use", 10, 5);
    self function_65f8953a("player_started_proptrap", "trap", "prop_start", 5, 0);
    self function_65f8953a("player_started_walltrap", "trap", "fan_start", 5, 0);
    self function_65f8953a("player_saw_proptrap_kill", "trap", "prop_kill", 10, 0);
    self function_65f8953a("player_saw_walltrap_kill", "trap", "fan_kill", 10, 0);
    self thread function_81d644a1();
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x761138f8, Offset: 0x25a0
// Size: 0x34
function main() {
    level thread function_c261e8aa();
    level thread function_3f78fe22();
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x25e0
// Size: 0x4
function on_player_connect() {
    
}

// Namespace zm_island_vo
// Params 1, eflags: 0x0
// Checksum 0x20571fc8, Offset: 0x25f0
// Size: 0x16a
function function_218256bd(var_eca8128e) {
    foreach (player in level.activeplayers) {
        if (isdefined(player)) {
            player.dontspeak = var_eca8128e;
            player clientfield::set_to_player("isspeaking", var_eca8128e);
        }
    }
    if (var_eca8128e) {
        foreach (player in level.activeplayers) {
            while (isdefined(player.isspeaking) && isdefined(player) && player.isspeaking) {
                wait 0.1;
            }
        }
    }
}

// Namespace zm_island_vo
// Params 1, eflags: 0x0
// Checksum 0x6641ec93, Offset: 0x2768
// Size: 0x70
function function_cf8fccfe(var_eca8128e) {
    self.dontspeak = var_eca8128e;
    self clientfield::set_to_player("isspeaking", var_eca8128e);
    if (var_eca8128e) {
        while (isdefined(self.isspeaking) && isdefined(self) && self.isspeaking) {
            wait 0.1;
        }
    }
}

// Namespace zm_island_vo
// Params 5, eflags: 0x0
// Checksum 0xa390cf39, Offset: 0x27e0
// Size: 0x360
function vo_say(str_vo_alias, n_delay, b_wait_if_busy, n_priority, var_d1295208) {
    if (!isdefined(n_delay)) {
        n_delay = 0;
    }
    if (!isdefined(b_wait_if_busy)) {
        b_wait_if_busy = 0;
    }
    if (!isdefined(n_priority)) {
        n_priority = 0;
    }
    if (!isdefined(var_d1295208)) {
        var_d1295208 = 0;
    }
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"hash_14c495c1");
    if (isdefined(self.var_e1f8edd6) && self.var_e1f8edd6) {
        return false;
    }
    if (zm_audio::function_bbc477e0(10000) && !(isdefined(var_d1295208) && var_d1295208)) {
        return false;
    }
    if (isdefined(level.sndvoxoverride) && (isdefined(self.isspeaking) && self.isspeaking || level.sndvoxoverride) || self isplayerunderwater()) {
        if (isdefined(b_wait_if_busy) && b_wait_if_busy) {
            while (isdefined(level.sndvoxoverride) && (isdefined(self.isspeaking) && self.isspeaking || level.sndvoxoverride) || self isplayerunderwater()) {
                wait 0.1;
            }
            wait 0.35;
        } else {
            return false;
        }
    }
    if (n_delay > 0) {
        wait n_delay;
    }
    if (isdefined(self.b_wait_if_busy) && isdefined(self.isspeaking) && self.isspeaking && self.b_wait_if_busy) {
        while (isdefined(self.isspeaking) && self.isspeaking) {
            wait 0.1;
        }
    } else if (isdefined(level.sndvoxoverride) && (isdefined(self.isspeaking) && self.isspeaking && !(isdefined(self.b_wait_if_busy) && self.b_wait_if_busy) || level.sndvoxoverride)) {
        return false;
    }
    self.isspeaking = 1;
    level.sndvoxoverride = 1;
    self.n_vo_priority = n_priority;
    self.str_vo_being_spoken = str_vo_alias;
    array::add(level.var_5db32b5b, self, 1);
    var_2df3d133 = str_vo_alias + "_vo_done";
    if (isactor(self) || isplayer(self)) {
        self playsoundwithnotify(str_vo_alias, var_2df3d133, "J_head");
    } else {
        self playsoundwithnotify(str_vo_alias, var_2df3d133);
    }
    self waittill(var_2df3d133);
    self vo_clear();
    return true;
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x958edb42, Offset: 0x2b48
// Size: 0xfc
function vo_clear() {
    self.str_vo_being_spoken = "";
    self.n_vo_priority = 0;
    self.isspeaking = 0;
    level.sndvoxoverride = 0;
    var_22677cee = 0;
    foreach (var_a3ddaa95 in level.var_5db32b5b) {
        if (var_a3ddaa95 == self) {
            var_22677cee = 1;
            break;
        }
    }
    if (isdefined(var_22677cee) && var_22677cee) {
        arrayremovevalue(level.var_5db32b5b, self);
    }
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x507c1e94, Offset: 0x2c50
// Size: 0x5c
function vo_stop() {
    self endon(#"death");
    if (isdefined(self.str_vo_being_spoken) && self.str_vo_being_spoken != "") {
        self stopsound(self.str_vo_being_spoken);
    }
    vo_clear();
}

// Namespace zm_island_vo
// Params 2, eflags: 0x0
// Checksum 0x4e10a72c, Offset: 0x2cb8
// Size: 0x232
function function_2426269b(v_pos, n_range) {
    if (!isdefined(n_range)) {
        n_range = 1000;
    }
    if (isdefined(level.var_5db32b5b)) {
        foreach (var_d211180f in level.var_5db32b5b) {
            if (!isdefined(var_d211180f)) {
                continue;
            }
            if (!isdefined(v_pos) || distancesquared(var_d211180f.origin, v_pos) <= n_range * n_range) {
                if (isdefined(var_d211180f.str_vo_being_spoken) && var_d211180f.str_vo_being_spoken != "") {
                    var_d211180f stopsound(var_d211180f.str_vo_being_spoken);
                }
                var_d211180f.deleteme = 1;
                var_d211180f.str_vo_being_spoken = "";
                var_d211180f.n_vo_priority = 0;
                var_d211180f.isspeaking = 0;
            }
        }
        for (i = 0; isdefined(level.var_5db32b5b) && i < level.var_5db32b5b.size; i++) {
            if (isdefined(level.var_5db32b5b[i].deleteme) && level.var_5db32b5b[i].deleteme == 1) {
                arrayremovevalue(level.var_5db32b5b, level.var_5db32b5b[i]);
                i = 0;
                continue;
            }
        }
    }
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x117596b6, Offset: 0x2ef8
// Size: 0xb4
function function_cf763858() {
    if (isdefined(self.var_6d3681c9) && self.var_6d3681c9 != "") {
        self stopsound(self.var_6d3681c9);
        self.var_6d3681c9 = "";
        self.isspeaking = 0;
    }
    if (isdefined(self.str_vo_being_spoken) && self.str_vo_being_spoken != "") {
        self stopsound(self.str_vo_being_spoken);
        self vo_clear();
    }
}

// Namespace zm_island_vo
// Params 5, eflags: 0x0
// Checksum 0x1261864, Offset: 0x2fb8
// Size: 0x1f4
function function_897246e4(str_vo_alias, n_wait, b_wait_if_busy, n_priority, var_d1295208) {
    if (!isdefined(n_wait)) {
        n_wait = 0;
    }
    if (!isdefined(b_wait_if_busy)) {
        b_wait_if_busy = 0;
    }
    if (!isdefined(n_priority)) {
        n_priority = 0;
    }
    if (!isdefined(var_d1295208)) {
        var_d1295208 = 0;
    }
    var_942373f4 = 0;
    var_9689ca97 = 0;
    var_81132431 = strtok(str_vo_alias, "_");
    if (var_81132431[1] === "grop") {
        var_942373f4 = 1;
    } else if (var_81132431[7] === "pa") {
        var_9689ca97 = 1;
    } else if (var_81132431[1] === "plr") {
        var_edf0b06 = int(var_81132431[2]);
        e_speaker = zm_utility::function_a157d632(var_edf0b06);
    } else {
        e_speaker = undefined;
        assert(0, "<dev string:x28>" + str_vo_alias + "<dev string:x45>");
    }
    if (!var_942373f4 && !var_9689ca97) {
        if (zm_utility::is_player_valid(e_speaker)) {
            return e_speaker vo_say(str_vo_alias, n_wait, b_wait_if_busy, n_priority);
        }
    }
}

// Namespace zm_island_vo
// Params 5, eflags: 0x0
// Checksum 0xacd4376a, Offset: 0x31b8
// Size: 0x14c
function function_63c44c5a(a_str_vo, var_e21e86b8, b_wait_if_busy, n_priority, var_d1295208) {
    if (!isdefined(b_wait_if_busy)) {
        b_wait_if_busy = 0;
    }
    if (!isdefined(n_priority)) {
        n_priority = 0;
    }
    if (!isdefined(var_d1295208)) {
        var_d1295208 = 0;
    }
    function_218256bd(1);
    for (i = 0; i < a_str_vo.size; i++) {
        if (isdefined(var_e21e86b8)) {
            var_e27770b1 = var_e21e86b8[i];
        } else {
            var_e27770b1 = 0;
        }
        var_4f1e87a6 = self vo_say(a_str_vo[i], var_e27770b1, b_wait_if_busy, n_priority, var_d1295208);
        if (!isdefined(var_4f1e87a6)) {
            return;
        }
    }
    function_218256bd(0);
}

// Namespace zm_island_vo
// Params 5, eflags: 0x0
// Checksum 0x9d32d349, Offset: 0x3310
// Size: 0x15c
function function_7aa5324a(a_str_vo, var_e21e86b8, b_wait_if_busy, n_priority, var_d1295208) {
    if (!isdefined(b_wait_if_busy)) {
        b_wait_if_busy = 0;
    }
    if (!isdefined(n_priority)) {
        n_priority = 0;
    }
    if (!isdefined(var_d1295208)) {
        var_d1295208 = 0;
    }
    function_218256bd(1);
    for (i = 0; i < a_str_vo.size; i++) {
        if (isdefined(var_e21e86b8)) {
            var_e27770b1 = var_e21e86b8[i];
        } else {
            var_e27770b1 = 0.5;
        }
        var_4f1e87a6 = function_897246e4(a_str_vo[i], var_e27770b1, b_wait_if_busy, n_priority, var_d1295208);
        if (!isdefined(var_4f1e87a6) || !(isdefined(var_4f1e87a6) && var_4f1e87a6)) {
            function_218256bd(0);
            return;
        }
    }
    function_218256bd(0);
}

// Namespace zm_island_vo
// Params 7, eflags: 0x0
// Checksum 0xc21e8f, Offset: 0x3478
// Size: 0x3c6
function function_642e6aef(impact, mod, weapon, zombie, instakill, dist, player) {
    close_dist = 4096;
    med_dist = 15376;
    far_dist = 160000;
    if (zombie.damageweapon.name == "sticky_grenade_widows_wine") {
        return "default";
    }
    if (weapon.name == "hero_mirg2000") {
        return undefined;
    }
    if (zm_utility::is_placeable_mine(weapon)) {
        if (!instakill) {
            return "betty";
        } else {
            return "weapon_instakill";
        }
    }
    if (zombie.damageweapon.name == "cymbal_monkey") {
        if (instakill) {
            return "weapon_instakill";
        } else {
            return "monkey";
        }
    }
    if ((weapon.name == "ray_gun" || weapon.name == "ray_gun_upgraded") && dist > far_dist) {
        if (!instakill) {
            return "raygun";
        } else {
            return "weapon_instakill";
        }
    }
    if (zm_utility::is_headshot(weapon, impact, mod) && dist >= far_dist) {
        return "headshot";
    }
    if ((mod == "MOD_MELEE" || mod == "MOD_UNKNOWN") && dist < close_dist) {
        if (!instakill) {
            return "melee";
        } else {
            return "melee_instakill";
        }
    }
    if (zm_utility::is_explosive_damage(mod) && weapon.name != "ray_gun" && weapon.name != "ray_gun_upgraded" && !(isdefined(zombie.is_on_fire) && zombie.is_on_fire)) {
        if (!instakill) {
            return "explosive";
        } else {
            return "weapon_instakill";
        }
    }
    if (mod == "MOD_BURNED" || mod == "MOD_GRENADE" || weapon.doesfiredamage && mod == "MOD_GRENADE_SPLASH") {
        if (!instakill) {
            return "flame";
        } else {
            return "weapon_instakill";
        }
    }
    if (!isdefined(impact)) {
        impact = "";
    }
    if (mod != "MOD_MELEE" && zombie.missinglegs) {
        return "crawler";
    }
    if (mod != "MOD_BURNED" && dist < close_dist) {
        return "close";
    }
    if (mod == "MOD_RIFLE_BULLET" || mod == "MOD_PISTOL_BULLET") {
        if (!instakill) {
            return "bullet";
        } else {
            return "weapon_instakill";
        }
    }
    if (instakill) {
        return "default";
    }
    return "default";
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0xbf58149c, Offset: 0x3848
// Size: 0xe8
function function_772aa229() {
    self endon(#"_zombie_game_over");
    while (true) {
        level waittill(#"start_of_round");
        if (function_70e6e39e() == 0) {
            if (level.activeplayers.size == 1) {
                level thread function_54cd030a();
            } else {
                level thread function_cc4d4a7c();
            }
        }
        level waittill(#"end_of_round");
        if (function_70e6e39e() == 0) {
            if (level.activeplayers.size == 1) {
                level thread function_340dc03();
                continue;
            }
            level thread function_7ca05725();
        }
    }
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x73b84154, Offset: 0x3938
// Size: 0x84
function function_54cd030a() {
    if (level.round_number <= 1) {
        e_speaker = level.players[0];
        var_5da47f0d = function_11b41a76(e_speaker.characterindex, "round_start_solo", level.round_number);
        e_speaker function_e4acaa37(var_5da47f0d);
    }
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x16ed1ab0, Offset: 0x39c8
// Size: 0xdc
function function_340dc03() {
    var_5df8c4ee = level.round_number - 1;
    if (var_5df8c4ee <= 2) {
        e_speaker = level.players[0];
        if (var_5df8c4ee == 2 && e_speaker.characterindex === 3 && level.var_7ccadaab === 11) {
            var_380dee9e = "vox_plr_3_round2_end_solo_japalt_0";
        } else {
            var_380dee9e = function_11b41a76(e_speaker.characterindex, "round_end_solo", var_5df8c4ee);
        }
        e_speaker function_e4acaa37(var_380dee9e);
    }
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0xea4ecb1d, Offset: 0x3ab0
// Size: 0x164
function function_cc4d4a7c() {
    a_players = arraycopy(level.activeplayers);
    var_e8669 = zm_utility::function_a157d632(2);
    if (level.round_number <= 2 && isdefined(var_e8669)) {
        var_1a7dfed0 = [];
        var_1a7dfed0[0] = function_11b41a76(var_e8669.characterindex, "round_start_coop", level.round_number);
        arrayremovevalue(a_players, var_e8669);
        var_261100d2 = arraygetclosest(var_e8669.origin, a_players);
        var_1a7dfed0[1] = function_11b41a76(var_261100d2.characterindex, "round_start_coop", level.round_number);
        var_e8669 thread function_280223ba(var_1a7dfed0);
        return;
    }
    if (level.round_number == 1) {
        level thread function_3cdbc215();
    }
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0xa48eaa29, Offset: 0x3c20
// Size: 0x16c
function function_7ca05725() {
    a_players = arraycopy(level.activeplayers);
    var_e8669 = zm_utility::function_a157d632(2);
    var_5df8c4ee = level.round_number - 1;
    if (var_5df8c4ee <= 2 && isdefined(var_e8669)) {
        var_1a7dfed0 = [];
        var_1a7dfed0[0] = function_11b41a76(var_e8669.characterindex, "round_end_coop", var_5df8c4ee);
        arrayremovevalue(a_players, var_e8669);
        var_261100d2 = arraygetclosest(var_e8669.origin, a_players);
        var_1a7dfed0[1] = function_11b41a76(var_261100d2.characterindex, "round_end_coop", var_5df8c4ee);
        var_e8669 thread function_280223ba(var_1a7dfed0);
        return;
    }
    level thread function_3cdbc215();
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0xb37b4bdb, Offset: 0x3d98
// Size: 0x1c4
function function_b83e53a5() {
    var_910a2ebc = 0;
    var_121146b = 0;
    foreach (player in level.activeplayers) {
        if (player.characterindex == 2) {
            var_910a2ebc = 1;
            continue;
        }
        if (player.characterindex == 0) {
            var_121146b = 1;
        }
    }
    if (isdefined(var_910a2ebc) && isdefined(var_121146b) && var_121146b && var_910a2ebc) {
        a_str_lines = array("vox_plr_0_outro_igc_31", "vox_plr_2_outro_igc_32");
        level thread function_7aa5324a(a_str_lines);
        return;
    }
    if (var_910a2ebc) {
        level thread function_897246e4("vox_plr_2_outro_igc_32");
        return;
    }
    s_org = struct::get("ending_igc_exit_" + 2);
    playsoundatposition("vox_plr_2_outro_igc_32", s_org.origin);
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0xd4941ab9, Offset: 0x3f68
// Size: 0x7e6
function function_267933e4() {
    level.var_b7e67f82 = array(0, 0, 0, 0);
    var_85fdde46 = [];
    var_85fdde46[0] = array("vox_plr_0_interaction_demp_niko_1_0", "vox_plr_1_interaction_demp_niko_1_0");
    var_85fdde46[1] = array("vox_plr_0_interaction_demp_niko_2_0", "vox_plr_1_interaction_demp_niko_2_0");
    var_85fdde46[2] = array("vox_plr_1_interaction_demp_niko_3_0", "vox_plr_0_interaction_demp_niko_3_0");
    var_85fdde46[3] = array("vox_plr_1_interaction_demp_niko_4_0", "vox_plr_0_interaction_demp_niko_4_0");
    var_85fdde46[4] = array("vox_plr_0_interaction_demp_niko_5_0", "vox_plr_1_interaction_demp_niko_5_0");
    level.var_85fdde46 = var_85fdde46;
    level.var_5705772e = 0;
    level.var_b7e67f82[0] = level.var_b7e67f82[0] + var_85fdde46.size;
    level.var_b7e67f82[1] = level.var_b7e67f82[1] + var_85fdde46.size;
    var_559f698d = [];
    var_559f698d[0] = array("vox_plr_0_interaction_rich_demp_1_0", "vox_plr_2_interaction_rich_demp_1_0");
    var_559f698d[1] = array("vox_plr_2_interaction_rich_demp_2_0", "vox_plr_0_interaction_rich_demp_2_0");
    var_559f698d[2] = array("vox_plr_2_interaction_rich_demp_3_0", "vox_plr_0_interaction_rich_demp_3_0");
    var_559f698d[3] = array("vox_plr_2_interaction_rich_demp_4_0", "vox_plr_0_interaction_rich_demp_4_0");
    var_559f698d[4] = array("vox_plr_2_interaction_rich_demp_5_0", "vox_plr_0_interaction_rich_demp_5_0");
    level.var_559f698d = var_559f698d;
    level.var_d9e67775 = 0;
    level.var_b7e67f82[0] = level.var_b7e67f82[0] + var_559f698d.size;
    level.var_b7e67f82[2] = level.var_b7e67f82[2] + var_559f698d.size;
    var_b16db601 = [];
    var_b16db601[0] = array("vox_plr_3_interaction_demp_takeo_1_0", "vox_plr_0_interaction_demp_takeo_1_0");
    var_b16db601[1] = array("vox_plr_3_interaction_demp_takeo_2_0", "vox_plr_0_interaction_demp_takeo_2_0");
    var_b16db601[2] = array("vox_plr_0_interaction_demp_takeo_3_0", "vox_plr_3_interaction_demp_takeo_3_0");
    var_b16db601[3] = array("vox_plr_0_interaction_demp_takeo_4_0", "vox_plr_3_interaction_demp_takeo_4_0");
    var_b16db601[4] = array("vox_plr_3_interaction_demp_takeo_5_0", "vox_plr_0_interaction_demp_takeo_5_0");
    level.var_b16db601 = var_b16db601;
    level.var_a47c9479 = 0;
    level.var_b7e67f82[0] = level.var_b7e67f82[0] + var_b16db601.size;
    level.var_b7e67f82[3] = level.var_b7e67f82[3] + var_b16db601.size;
    var_4d918dae = [];
    var_4d918dae[0] = array("vox_plr_1_interaction_rich_niko_1_0", "vox_plr_2_interaction_rich_niko_1_0");
    var_4d918dae[1] = array("vox_plr_1_interaction_rich_niko_2_0", "vox_plr_2_interaction_rich_niko_2_0");
    var_4d918dae[2] = array("vox_plr_1_interaction_rich_niko_3_0", "vox_plr_2_interaction_rich_niko_3_0");
    var_4d918dae[3] = array("vox_plr_1_interaction_rich_niko_4_0", "vox_plr_2_interaction_rich_niko_4_0");
    var_4d918dae[4] = array("vox_plr_2_interaction_rich_niko_5_0", "vox_plr_1_interaction_rich_niko_5_0");
    level.var_4d918dae = var_4d918dae;
    level.var_2ed438a6 = 0;
    level.var_b7e67f82[1] = level.var_b7e67f82[1] + var_4d918dae.size;
    level.var_b7e67f82[2] = level.var_b7e67f82[2] + var_4d918dae.size;
    var_ec060c98 = [];
    var_ec060c98[0] = array("vox_plr_3_interaction_takeo_niko_1_0", "vox_plr_1_interaction_takeo_niko_1_0");
    var_ec060c98[1] = array("vox_plr_3_interaction_takeo_niko_2_0", "vox_plr_1_interaction_takeo_niko_2_0");
    var_ec060c98[2] = array("vox_plr_1_interaction_takeo_niko_3_0", "vox_plr_3_interaction_takeo_niko_3_0");
    var_ec060c98[3] = array("vox_plr_1_interaction_takeo_niko_4_0", "vox_plr_3_interaction_takeo_niko_4_0");
    var_ec060c98[4] = array("vox_plr_1_interaction_takeo_niko_5_0", "vox_plr_3_interaction_takeo_niko_5_0");
    level.var_ec060c98 = var_ec060c98;
    level.var_e06e7300 = 0;
    level.var_b7e67f82[1] = level.var_b7e67f82[1] + var_ec060c98.size;
    level.var_b7e67f82[3] = level.var_b7e67f82[3] + var_ec060c98.size;
    var_4303fff9 = [];
    var_4303fff9[0] = array("vox_plr_3_interaction_rich_takeo_1_0", "vox_plr_2_interaction_rich_takeo_1_0");
    var_4303fff9[1] = array("vox_plr_3_interaction_rich_takeo_2_0", "vox_plr_2_interaction_rich_takeo_2_0");
    var_4303fff9[2] = array("vox_plr_3_interaction_rich_takeo_3_0", "vox_plr_2_interaction_rich_takeo_3_0");
    var_4303fff9[3] = array("vox_plr_3_interaction_rich_takeo_4_0", "vox_plr_2_interaction_rich_takeo_4_0");
    var_4303fff9[4] = array("vox_plr_2_interaction_rich_takeo_5_0", "vox_plr_3_interaction_rich_takeo_5_0");
    level.var_4303fff9 = var_4303fff9;
    level.var_2e004fe1 = 0;
    level.var_b7e67f82[2] = level.var_b7e67f82[2] + var_4303fff9.size;
    level.var_b7e67f82[3] = level.var_b7e67f82[3] + var_4303fff9.size;
    var_312fb587 = 11;
    var_7ccadaab = getdvarint("loc_language");
    if (var_7ccadaab === var_312fb587) {
        var_4303fff9[2] = array("vox_plr_3_interaction_rich_takeo_3_jap_alt_0", "vox_plr_2_interaction_rich_takeo_3_japalt_0");
    }
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x3e855167, Offset: 0x4758
// Size: 0x684
function function_3cdbc215() {
    if (level.activeplayers.size > 1) {
        a_players = array::randomize(level.activeplayers);
        var_e8669 = undefined;
        var_261100d2 = undefined;
        do {
            var_e8669 = a_players[0];
            arrayremovevalue(a_players, var_e8669);
        } while (a_players.size > 0 && level.var_b7e67f82[var_e8669.characterindex] === 0);
        if (level.var_b7e67f82[var_e8669.characterindex] > 0) {
            do {
                var_261100d2 = arraygetclosest(var_e8669.origin, a_players, 1000);
                arrayremovevalue(a_players, var_261100d2);
            } while (a_players.size > 0 && isdefined(var_261100d2) && level.var_b7e67f82[var_261100d2.characterindex] === 0);
        }
        var_a40c0bd2 = 0;
        var_b89804c3 = 0;
        if (isdefined(var_e8669)) {
            var_a40c0bd2 = level.var_b7e67f82[var_e8669.characterindex];
        }
        if (isdefined(var_261100d2)) {
            var_b89804c3 = level.var_b7e67f82[var_261100d2.characterindex];
        }
        if (var_a40c0bd2 > 0 && var_b89804c3 > 0) {
            if (var_261100d2.characterindex == 0 && (var_e8669.characterindex == 0 && var_261100d2.characterindex == 1 || var_e8669.characterindex == 1)) {
                if (level.var_5705772e < level.var_85fdde46.size) {
                    var_e8669 thread function_280223ba(level.var_85fdde46[level.var_5705772e]);
                    level.var_5705772e++;
                    level.var_b7e67f82[0]--;
                    level.var_b7e67f82[1]--;
                }
            } else if (var_261100d2.characterindex == 0 && (var_e8669.characterindex == 0 && var_261100d2.characterindex == 2 || var_e8669.characterindex == 2)) {
                if (level.var_d9e67775 < level.var_559f698d.size) {
                    var_e8669 thread function_280223ba(level.var_559f698d[level.var_d9e67775]);
                    level.var_d9e67775++;
                    level.var_b7e67f82[0]--;
                    level.var_b7e67f82[2]--;
                }
            } else if (var_261100d2.characterindex == 0 && (var_e8669.characterindex == 0 && var_261100d2.characterindex == 3 || var_e8669.characterindex == 3)) {
                if (level.var_a47c9479 < level.var_b16db601.size) {
                    var_e8669 thread function_280223ba(level.var_b16db601[level.var_a47c9479]);
                    level.var_a47c9479++;
                    level.var_b7e67f82[0]--;
                    level.var_b7e67f82[3]--;
                }
            } else if (var_261100d2.characterindex == 1 && (var_e8669.characterindex == 1 && var_261100d2.characterindex == 2 || var_e8669.characterindex == 2)) {
                if (level.var_2ed438a6 < level.var_4d918dae.size) {
                    var_e8669 thread function_280223ba(level.var_4d918dae[level.var_2ed438a6]);
                    level.var_2ed438a6++;
                    level.var_b7e67f82[1]--;
                    level.var_b7e67f82[2]--;
                }
            } else if (var_261100d2.characterindex == 1 && (var_e8669.characterindex == 1 && var_261100d2.characterindex == 3 || var_e8669.characterindex == 3)) {
                if (level.var_e06e7300 < level.var_ec060c98.size) {
                    var_e8669 thread function_280223ba(level.var_ec060c98[level.var_e06e7300]);
                    level.var_e06e7300++;
                    level.var_b7e67f82[1]--;
                    level.var_b7e67f82[3]--;
                }
            } else if (var_261100d2.characterindex == 2 && (var_e8669.characterindex == 2 && var_261100d2.characterindex == 3 || var_e8669.characterindex == 3)) {
                if (level.var_2e004fe1 < level.var_4303fff9.size) {
                    var_e8669 thread function_280223ba(level.var_4303fff9[level.var_2e004fe1]);
                    level.var_2e004fe1++;
                    level.var_b7e67f82[2]--;
                    level.var_b7e67f82[3]--;
                }
            }
            return;
        }
        /#
            iprintln("<dev string:x75>");
        #/
    }
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x801bb56a, Offset: 0x4de8
// Size: 0x2e4
function function_3f78fe22() {
    level thread function_7fc6d0cd(array("zone_ruins"), array("connect_swamp_to_ruins"), "ruins");
    level thread function_7fc6d0cd(array("zone_jungle_lab_upper", "zone_swamp_lab_inside"), array("connect_jungle_lab_to_jungle_lab_upper", "connect_swamp_lab_to_swamp_lab_inside"), "lab");
    level thread function_35fd7118(array("zone_bunker_interior_2"), array("connect_bunker_exterior_to_bunker_interior"), "bunker");
    level thread function_7fc6d0cd(array("zone_operating_rooms"), array("connect_bunker_interior_to_operating_rooms"), "experiment", 0, 0, "", 0);
    level thread function_7fc6d0cd(array("zone_bunker_right"), array("connect_bunker_interior_to_bunker_right"), "living", 1, 2);
    level thread function_7fc6d0cd(array("zone_bunker_left"), array("connect_bunker_interior_to_bunker_left"), "power");
    level thread function_7fc6d0cd(array("zone_bunker_prison"), array("enable_zone_bunker_prison"), "m_ee", 1, 0, "5");
    level thread function_7fc6d0cd(array("zone_spider_boss"), array("connect_spider_lair_to_spider_boss"), "m_ee", 1, 0, "4");
    level thread function_7fc6d0cd(array("zone_jungle_lab_secret_room"), array("connect_jungle_lab_to_jungle_lab_upper"), "", 1, 0, "dragon");
}

// Namespace zm_island_vo
// Params 7, eflags: 0x0
// Checksum 0x84e37236, Offset: 0x50d8
// Size: 0x1dc
function function_7fc6d0cd(a_str_zones, var_7a4c869a, var_87fad49a, var_142db61a, n_delay, var_a907ca47, var_b55bf9b4) {
    if (!isdefined(var_142db61a)) {
        var_142db61a = 1;
    }
    if (!isdefined(n_delay)) {
        n_delay = 0;
    }
    if (!isdefined(var_a907ca47)) {
        var_a907ca47 = "";
    }
    if (!isdefined(var_b55bf9b4)) {
        var_b55bf9b4 = 1;
    }
    if (var_b55bf9b4 == 1) {
        level flag::wait_till_any(var_7a4c869a);
    }
    var_b24c0d65 = undefined;
    while (!isdefined(var_b24c0d65)) {
        foreach (player in level.activeplayers) {
            if (player zm_island_util::function_f2a55b5f(a_str_zones)) {
                var_b24c0d65 = player;
                break;
            }
        }
        wait 1;
    }
    if (isdefined(var_b24c0d65)) {
        if (n_delay > 0) {
            wait n_delay;
        }
        if (var_a907ca47 == "") {
            var_b24c0d65 thread function_5ebe7974(var_87fad49a, var_142db61a);
            return;
        }
        var_b24c0d65 thread function_d258c672(var_a907ca47);
    }
}

// Namespace zm_island_vo
// Params 4, eflags: 0x0
// Checksum 0xa3b0ee61, Offset: 0x52c0
// Size: 0x1dc
function function_35fd7118(a_str_zones, var_7a4c869a, var_87fad49a, var_142db61a) {
    if (!isdefined(var_142db61a)) {
        var_142db61a = 1;
    }
    self endon(#"death");
    self endon(#"hash_56cd6f57");
    level flag::wait_till_any(var_7a4c869a);
    t_pap_lookat = getent("t_pap_lookat", "targetname");
    for (var_b24c0d65 = undefined; !zm_utility::is_player_valid(var_b24c0d65); var_b24c0d65 = undefined) {
        t_pap_lookat waittill(#"trigger", var_b24c0d65);
        if (zm_utility::is_player_valid(var_b24c0d65)) {
            foreach (player in level.activeplayers) {
                if (player != var_b24c0d65) {
                    player notify(#"hash_56cd6f57");
                }
            }
            if (!level flag::get("pap_water_drained")) {
                var_b24c0d65 thread function_5ebe7974(var_87fad49a, var_142db61a);
            }
            t_pap_lookat delete();
            continue;
        }
    }
}

// Namespace zm_island_vo
// Params 2, eflags: 0x0
// Checksum 0x43c9ce99, Offset: 0x54a8
// Size: 0x22c
function function_5ebe7974(var_87fad49a, var_142db61a) {
    self endon(#"death");
    if (zm_utility::is_player_valid(self)) {
        while (isdefined(self.var_7a36438e) && self.var_7a36438e) {
            self waittill(#"sewer_over");
            wait 3;
        }
        var_e1bda0d1 = "vox_plr_" + self.characterindex + "_" + var_87fad49a + "_encounter_0";
        foreach (player in level.players) {
            if (player.characterindex === 2) {
                var_1c428c3 = player;
            }
        }
        if (isdefined(var_142db61a) && self.characterindex !== 2 && var_142db61a && isdefined(var_1c428c3) && distancesquared(self.origin, var_1c428c3.origin) < 1048576) {
            var_7c01b3a = "vox_plr_" + 2 + "_" + var_87fad49a + "_encounter_0";
            a_str_vo = array(var_e1bda0d1, var_7c01b3a);
            level thread function_7aa5324a(a_str_vo, undefined, 1);
            return;
        }
        level thread function_897246e4(var_e1bda0d1, 0, 1);
    }
}

// Namespace zm_island_vo
// Params 1, eflags: 0x0
// Checksum 0x2b15a1ed, Offset: 0x56e0
// Size: 0x10c
function function_d258c672(var_a907ca47) {
    self endon(#"death");
    if (zm_utility::is_player_valid(self)) {
        var_7c01b3a = "vox_plr_" + 2 + "_mq_ee_" + var_a907ca47 + "_response_0_0";
        if (self.characterindex !== 2) {
            var_e1bda0d1 = "vox_plr_" + self.characterindex + "_mq_ee_" + var_a907ca47 + "_0";
            a_str_vo = array(var_e1bda0d1, var_7c01b3a);
            level thread function_7aa5324a(a_str_vo, undefined, 1);
            return;
        }
        level thread function_897246e4(var_7c01b3a, 0, 1);
    }
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0xb0251a48, Offset: 0x57f8
// Size: 0xac
function function_6fc10b64() {
    self endon(#"disconnect");
    wait 1.5;
    if (zm_utility::is_player_valid(self)) {
        self clientfield::set("player_vomit_fx", 1);
        self util::delay(5, "disconnect", &clientfield::set, "player_vomit_fx", 0);
        self function_1881817("fruit", "vomit", 10, 0);
    }
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x6fb81aec, Offset: 0x58b0
// Size: 0x10c
function function_97ed7288() {
    if (!level flag::exists("first_skull_s_pickedup_vo_done")) {
        self thread function_cdc8a72a("_quest_skull_pickup_0");
        level flag::init("first_skull_s_pickedup_vo_done");
        level flag::set("first_skull_s_pickedup_vo_done");
        level flag::set("skull_s_pickup_vo_locked");
        return;
    }
    if (!level flag::get("skull_s_pickup_vo_locked")) {
        self thread function_1881817("quest_skull", "pickup_generic", 60);
        level flag::set("skull_s_pickup_vo_locked");
    }
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x2a59b9bf, Offset: 0x59c8
// Size: 0x84
function function_9984d8f0() {
    if (!level flag::exists("first_skull_s_placed_vo_done")) {
        self thread function_cdc8a72a("_quest_skull_place_0");
        level flag::init("first_skull_s_placed_vo_done");
        level flag::set("first_skull_s_placed_vo_done");
    }
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x61e455e5, Offset: 0x5a58
// Size: 0x84
function function_87d97caa() {
    if (!level flag::exists("skull_p_pickup_vo_done")) {
        self thread function_cdc8a72a("_quest_skull_pickup_purified_0");
        level flag::init("skull_p_pickup_vo_done");
        level flag::set("skull_p_pickup_vo_done");
    }
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x90b8f326, Offset: 0x5ae8
// Size: 0xa4
function function_64f4c27() {
    if (!level flag::exists("skull_p_place_vo_done")) {
        self thread function_cdc8a72a("_quest_skull_place_purified_0");
        level flag::init("skull_p_place_vo_done");
        level flag::set("skull_p_place_vo_done");
    }
    level flag::clear("skull_s_pickup_vo_locked");
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x8d6b7641, Offset: 0x5b98
// Size: 0x24
function function_5dbba1d3() {
    self thread function_cdc8a72a("_quest_skull_place_purified_final_0");
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x42d66795, Offset: 0x5bc8
// Size: 0x24
function function_ab027b72() {
    self thread function_cdc8a72a("_quest_skull_weapon_trap_0");
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0xe970d58b, Offset: 0x5bf8
// Size: 0x24
function function_b2a7853b() {
    self thread function_cdc8a72a("quest_skull_weapon_success_0");
}

// Namespace zm_island_vo
// Params 1, eflags: 0x0
// Checksum 0x41f9e3d1, Offset: 0x5c28
// Size: 0x10c
function function_cdc8a72a(var_8d8f9222) {
    if (!isdefined(level.var_aa673a57)) {
        level.var_aa673a57 = [];
    }
    if (!(isdefined(level.var_aa673a57[var_8d8f9222]) && level.var_aa673a57[var_8d8f9222])) {
        level.var_aa673a57[var_8d8f9222] = 1;
        var_217a1cbf = "vo_plr_2_" + var_8d8f9222;
        if (self.characterindex !== 2) {
            var_6a57fbd1 = "vox_plr_" + self.characterindex + var_8d8f9222;
            a_str_vo = array(var_6a57fbd1, var_217a1cbf);
            level thread function_7aa5324a(a_str_vo);
            return;
        }
        level thread function_897246e4(var_217a1cbf);
    }
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x29d993c, Offset: 0x5d40
// Size: 0x140
function function_c426b455() {
    while (true) {
        level waittill(#"hash_9c49b4a8");
        if (!level flag::exists("first_spider_round")) {
            level flag::init("first_spider_round");
            foreach (player in level.activeplayers) {
                player thread function_5943b45();
            }
            continue;
        }
        do {
            e_player = array::random(level.activeplayers);
        } while (!zm_utility::is_player_valid(e_player));
        e_player zm_audio::create_and_play_dialog("spider", "start");
    }
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x5cea0fb9, Offset: 0x5e88
// Size: 0x214
function function_5943b45() {
    self endon(#"death");
    self endon(#"hash_cbca0f35");
    var_e8356f9e = 2560000;
    var_90d45ead = 0;
    while (!(isdefined(var_90d45ead) && var_90d45ead)) {
        wait 0.5;
        var_388bdc38 = getentarray("zombie_spider", "targetname");
        if (zm_utility::is_player_valid(self)) {
            foreach (spider in var_388bdc38) {
                if (distancesquared(self.origin, spider.origin) <= var_e8356f9e && self islookingat(spider)) {
                    var_90d45ead = 1;
                    foreach (var_3c6a24bf in level.players) {
                        if (var_3c6a24bf != self) {
                            var_3c6a24bf notify(#"hash_cbca0f35");
                        }
                    }
                    break;
                }
            }
        }
    }
    self zm_audio::create_and_play_dialog("spider", "start");
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x948fb22, Offset: 0x60a8
// Size: 0xec
function function_c8bcaf11() {
    if (!level flag::exists("temp_power_on_1")) {
        level flag::init("temp_power_on_1");
    }
    if (zm_utility::is_player_valid(self)) {
        if (!level flag::get("temp_power_on_1")) {
            level thread function_c57ccaa9();
            self thread function_7f4cb4c("temp_power", "first_switch", 3);
            return;
        }
        self thread function_7f4cb4c("temp_power", "second_switch", 3);
    }
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x371321a6, Offset: 0x61a0
// Size: 0x6c
function function_c57ccaa9() {
    level flag::set("temp_power_on_1");
    if (level.activeplayers.size > 1) {
        wait level.var_7b5a9e65;
    } else {
        wait level.var_7b5a9e65 * 2;
    }
    level flag::clear("temp_power_on_1");
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0xbfd372c3, Offset: 0x6218
// Size: 0x318
function function_8eebdc4d() {
    while (true) {
        wait 1;
        if (!level flag::get("vo_lock_thrasher_appear_roar")) {
            var_bb184d70 = level.var_35a5aa88;
            e_speaker = undefined;
            var_d582de1 = undefined;
            foreach (player in level.activeplayers) {
                if (zm_utility::is_player_valid(player)) {
                    str_player_zone = player zm_zonemgr::get_player_zone();
                    if (!isdefined(var_d582de1) && isdefined(str_player_zone)) {
                        foreach (var_e3372b59 in var_bb184d70) {
                            if (!(isdefined(var_e3372b59.var_dbb0b3dd) && var_e3372b59.var_dbb0b3dd) && !(isdefined(var_e3372b59.var_36ba10fd) && var_e3372b59.var_36ba10fd) && var_e3372b59 zm_zonemgr::entity_in_zone(str_player_zone) && player islookingat(var_e3372b59)) {
                                e_speaker = player;
                                var_e3372b59.var_dbb0b3dd = 1;
                                var_d582de1 = var_e3372b59;
                                break;
                            }
                        }
                    }
                    continue;
                }
                break;
            }
            if (!level flag::get("vo_lock_thrasher_appear_roar") && zm_utility::is_player_valid(e_speaker) && !level flag::get("takeofight_wave_spawning")) {
                level flag::set("thrasher_spotted");
                level thread flag::set_for_time(5, "vo_lock_thrasher_appear_roar");
                e_speaker function_1881817("thrasher", "appear", 60);
            }
        }
    }
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0xa02f1836, Offset: 0x6538
// Size: 0x226
function function_5ca4424() {
    var_1430cde = 640000;
    level flag::wait_till("thrasher_spotted");
    while (true) {
        if (!level flag::get("vo_lock_thrasher_appear_roar")) {
            level waittill(#"hash_9b1446c2", var_f363f596);
            if (!(isdefined(var_f363f596.var_dbb0b3dd) && var_f363f596.var_dbb0b3dd) && isalive(var_f363f596) && !(isdefined(var_f363f596.var_9d252861) && var_f363f596.var_9d252861)) {
                e_speaker = undefined;
                e_closest_player = arraygetclosest(var_f363f596.origin, level.activeplayers);
                if (!e_closest_player zm_island_util::is_facing(var_f363f596) && distancesquared(var_f363f596.origin, e_closest_player.origin) <= var_1430cde) {
                    e_speaker = e_closest_player;
                }
                if (!level flag::get("vo_lock_thrasher_appear_roar") && zm_utility::is_player_valid(e_speaker)) {
                    var_f363f596.var_9d252861 = 1;
                    wait 1;
                    level thread flag::set_for_time(5, "vo_lock_thrasher_appear_roar");
                    e_speaker function_1881817("thrasher", "roar", 10);
                }
            }
        }
        wait 1;
    }
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x13017c64, Offset: 0x6768
// Size: 0x226
function function_a5b6f9c0() {
    var_1430cde = 640000;
    level flag::wait_till("thrasher_spotted");
    while (true) {
        level waittill(#"hash_49c2b21f", var_f363f596);
        if (isalive(var_f363f596) && !(isdefined(var_f363f596.var_36ba10fd) && var_f363f596.var_36ba10fd)) {
            e_speaker = undefined;
            foreach (e_player in level.activeplayers) {
                if (zm_utility::is_player_valid(e_player)) {
                    str_player_zone = e_player zm_zonemgr::get_player_zone();
                    if (isdefined(str_player_zone) && var_f363f596 zm_zonemgr::entity_in_zone(str_player_zone) && e_player islookingat(var_f363f596)) {
                        e_speaker = e_player;
                        break;
                    }
                }
            }
            if (zm_utility::is_player_valid(e_speaker) && !level flag::get("takeofight_wave_spawning")) {
                var_f363f596.var_36ba10fd = 1;
                e_speaker function_1881817("thrasher", "create", 10);
            }
        }
        wait 1;
    }
}

// Namespace zm_island_vo
// Params 1, eflags: 0x0
// Checksum 0x592874bf, Offset: 0x6998
// Size: 0x68
function function_b978ce37(e_attacker) {
    if (self.archetype === "thrasher" && zm_utility::is_player_valid(e_attacker) && !level flag::get("takeofight_wave_spawning")) {
        e_attacker notify(#"player_killed_thrasher");
    }
}

// Namespace zm_island_vo
// Params 7, eflags: 0x0
// Checksum 0xee4623aa, Offset: 0x6a08
// Size: 0x238
function function_1e767f71(e_target, n_min_dist, str_cat, var_b03cc213, var_a099ce87, var_ac3beede, n_duration) {
    if (!isdefined(n_min_dist)) {
        n_min_dist = 600;
    }
    if (!isdefined(var_a099ce87)) {
        var_a099ce87 = 1;
    }
    if (!isdefined(var_ac3beede)) {
        var_ac3beede = 0;
    }
    if (!isdefined(n_duration)) {
        n_duration = 0;
    }
    e_target endon(#"hash_9ed7f404");
    e_target endon(#"death");
    while (true) {
        var_45edf029 = arraysortclosest(level.players, e_target.origin);
        foreach (player in var_45edf029) {
            if (zm_utility::is_player_valid(player) && player util::is_player_looking_at(e_target getcentroid(), 0.5, 1, e_target) && distance2dsquared(player.origin, e_target.origin) <= n_min_dist * n_min_dist) {
                player thread function_1881817(str_cat, var_b03cc213, var_a099ce87, var_ac3beede);
                return;
            }
        }
        if (n_duration > 0) {
            n_duration--;
        } else if (n_duration < 0) {
            wait 1;
            continue;
        } else {
            return;
        }
        wait 1;
    }
}

// Namespace zm_island_vo
// Params 8, eflags: 0x0
// Checksum 0x9bda9508, Offset: 0x6c48
// Size: 0x13e
function function_65f8953a(str_event, str_cat, var_b03cc213, var_a099ce87, var_32802234, n_delay, v_loc, var_c2a3d8e1) {
    if (!isdefined(var_a099ce87)) {
        var_a099ce87 = 10;
    }
    if (!isdefined(var_32802234)) {
        var_32802234 = 0;
    }
    if (!isdefined(n_delay)) {
        n_delay = 0;
    }
    if (!isdefined(var_c2a3d8e1)) {
        var_c2a3d8e1 = 1;
    }
    if (isdefined(str_event)) {
        array::add(self.var_bac3b790, str_event);
        self.var_38d92be7[str_event] = str_cat;
        self.var_8bcf7c3a[str_event] = var_b03cc213;
        self.var_2c67f767[str_event] = var_a099ce87;
        self.var_4b332a77[str_event] = var_32802234;
        self.var_bc80de72[str_event] = n_delay;
        self.var_9c6abc49[str_event] = v_loc;
        self.var_caa91bc0[str_event] = var_c2a3d8e1;
    }
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0xf5690bd0, Offset: 0x6d90
// Size: 0x128
function function_81d644a1() {
    self endon(#"death");
    array::add(self.var_bac3b790, "death");
    array::add(self.var_bac3b790, "disconnect");
    while (true) {
        str_event = self util::function_ec87322b(self.var_bac3b790);
        if (self.var_bc80de72[str_event] > 0) {
            wait self.var_bc80de72[str_event];
        }
        if (zm_utility::is_player_valid(self) || !(isdefined(self.var_caa91bc0[str_event]) && self.var_caa91bc0[str_event])) {
            self function_1881817(self.var_38d92be7[str_event], self.var_8bcf7c3a[str_event], self.var_2c67f767[str_event], self.var_4b332a77[str_event]);
        }
    }
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x8cff18f8, Offset: 0x6ec0
// Size: 0xe8
function function_c261e8aa() {
    while (true) {
        str_event = level util::function_ec87322b(level.var_bac3b790);
        if (level.var_bc80de72[str_event] > 0) {
            wait level.var_bc80de72[str_event];
        }
        e_player = zm_island_util::function_4bf4ac40(level.var_9c6abc49[str_event]);
        if (zm_utility::is_player_valid(e_player)) {
            e_player function_1881817(level.var_38d92be7[str_event], level.var_8bcf7c3a[str_event], level.var_2c67f767[str_event], level.var_4b332a77[str_event]);
        }
    }
}

// Namespace zm_island_vo
// Params 4, eflags: 0x0
// Checksum 0x5422bf17, Offset: 0x6fb0
// Size: 0x198
function function_1881817(str_cat, var_b03cc213, var_a099ce87, var_32802234) {
    if (!isdefined(var_a099ce87)) {
        var_a099ce87 = 10;
    }
    if (!isdefined(var_32802234)) {
        var_32802234 = 0;
    }
    self endon(#"death");
    var_4aa3754 = 0;
    if (zm_utility::is_player_valid(self) && !(isdefined(self.var_e1f8edd6) && self.var_e1f8edd6)) {
        var_346d981 = str_cat + var_b03cc213 + "_vo";
        if (!self flag::exists(var_346d981)) {
            self flag::init(var_346d981);
        }
        if (!self flag::get(var_346d981)) {
            self flag::set(var_346d981);
            if (var_32802234 == 0) {
                self thread zm_audio::create_and_play_dialog(str_cat, var_b03cc213);
            } else {
                self thread function_7f4cb4c(str_cat, var_b03cc213, var_32802234);
            }
            var_4aa3754 = 1;
            self thread function_ecc335b6(var_346d981, var_a099ce87);
        }
    }
    return var_4aa3754;
}

// Namespace zm_island_vo
// Params 2, eflags: 0x0
// Checksum 0x2db2bd48, Offset: 0x7150
// Size: 0x3c
function function_ecc335b6(var_346d981, var_a099ce87) {
    self endon(#"disconnect");
    wait var_a099ce87;
    self flag::clear(var_346d981);
}

// Namespace zm_island_vo
// Params 3, eflags: 0x0
// Checksum 0x315a514b, Offset: 0x7198
// Size: 0xb2
function function_7f4cb4c(str_cat, var_b03cc213, var_41d7d192) {
    if (!isdefined(var_41d7d192)) {
        var_41d7d192 = 3;
    }
    str_index = str_cat + "_" + var_b03cc213;
    if (!isdefined(self.var_10f58653[str_index])) {
        self.var_10f58653[str_index] = 0;
    }
    if (self.var_10f58653[str_index] < var_41d7d192) {
        self thread zm_audio::create_and_play_dialog(str_cat, var_b03cc213);
        self.var_10f58653[str_index]++;
    }
}

// Namespace zm_island_vo
// Params 1, eflags: 0x0
// Checksum 0xaebab2b4, Offset: 0x7258
// Size: 0x74
function function_e4acaa37(str_vo) {
    function_218256bd(1);
    function_2426269b(self.origin);
    self vo_say(str_vo, undefined, 1);
    function_218256bd(0);
}

// Namespace zm_island_vo
// Params 1, eflags: 0x0
// Checksum 0xe5865865, Offset: 0x72d8
// Size: 0x7c
function function_280223ba(var_d44b84c3) {
    function_218256bd(1);
    function_2426269b(self.origin, 10000);
    function_7aa5324a(var_d44b84c3, undefined, 1);
    function_218256bd(0);
}

// Namespace zm_island_vo
// Params 5, eflags: 0x0
// Checksum 0xd9d63220, Offset: 0x7360
// Size: 0x18e
function function_11b41a76(n_player_index, str_type, var_f73f0bfc, var_69467b37, var_434400ce) {
    if (!isdefined(var_69467b37)) {
        var_69467b37 = 0;
    }
    if (!isdefined(var_434400ce)) {
        var_434400ce = 0;
    }
    switch (str_type) {
    case "round_start_solo":
        str_vo = "vox_plr_" + n_player_index + "_round" + var_f73f0bfc + "_start_solo_0";
        break;
    case "round_end_solo":
        str_vo = "vox_plr_" + n_player_index + "_round" + var_f73f0bfc + "_end_solo_0";
        break;
    case "round_start_coop":
        str_vo = "vox_plr_" + n_player_index + "_round" + var_f73f0bfc + "_start_0";
        break;
    case "round_end_coop":
        str_vo = "vox_plr_" + n_player_index + "_round" + var_f73f0bfc + "_end_0";
        break;
    default:
        str_vo = "vox_plr_" + n_player_index + "_" + str_type + var_f73f0bfc + "_" + var_69467b37;
        break;
    }
    return str_vo;
}

// Namespace zm_island_vo
// Params 2, eflags: 0x0
// Checksum 0x7b65682a, Offset: 0x74f8
// Size: 0x82
function function_5803cf05(n_max, var_6e653641) {
    assert(!isdefined(var_6e653641) || var_6e653641 < n_max, "<dev string:x98>");
    do {
        n_new_value = randomint(n_max);
    } while (n_new_value === var_6e653641);
    return n_new_value;
}

// Namespace zm_island_vo
// Params 1, eflags: 0x0
// Checksum 0x76a244b6, Offset: 0x7588
// Size: 0x22
function function_574a0ffc(n_char_index) {
    return zm_utility::function_a157d632(n_char_index);
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x10c84649, Offset: 0x75b8
// Size: 0x92
function function_70e6e39e() {
    var_28ff596b = 0;
    for (i = 1; i <= 4; i++) {
        str_flag = "skullquest_ritual_inprogress" + i;
        if (level flag::exists(str_flag) && level flag::get(str_flag)) {
            var_28ff596b++;
        }
    }
    return var_28ff596b;
}

// Namespace zm_island_vo
// Params 4, eflags: 0x0
// Checksum 0xb7483df6, Offset: 0x7658
// Size: 0x412
function function_3bf2d62a(event_string, var_c57fa913, bunker, var_82860e04) {
    if (!isdefined(var_c57fa913)) {
        var_c57fa913 = 0;
    }
    if (!isdefined(bunker)) {
        bunker = 0;
    }
    if (!isdefined(var_82860e04)) {
        var_82860e04 = 0;
    }
    wait 1;
    soundalias = "vox_faci_pa_" + event_string + "_0";
    var_f6dffc36 = "vox_faci_pa_" + event_string + "_int" + "_0";
    if (var_c57fa913) {
        level.var_b7d1a34e = struct::get_array("sndJungleLabPa", "targetname");
        if (!isdefined(level.var_b7d1a34e)) {
            return;
        }
        foreach (location in level.var_b7d1a34e) {
            if (location.script_string == "interior") {
                playsoundatposition(var_f6dffc36, location.origin);
                wait 0.05;
                continue;
            }
            playsoundatposition(soundalias, location.origin);
            wait 0.05;
        }
    }
    if (bunker) {
        level.var_e2b8ee4d = struct::get_array("sndBunkerPa", "targetname");
        if (!isdefined(level.var_e2b8ee4d)) {
            return;
        }
        foreach (location in level.var_e2b8ee4d) {
            if (location.script_string == "interior") {
                playsoundatposition(var_f6dffc36, location.origin);
                wait 0.05;
                continue;
            }
            playsoundatposition(soundalias, location.origin);
            wait 0.05;
        }
    }
    if (var_82860e04) {
        level.var_eef090b3 = struct::get_array("sndSwampLabPa", "targetname");
        if (!isdefined(level.var_eef090b3)) {
            return;
        }
        foreach (location in level.var_eef090b3) {
            if (location.script_string == "interior") {
                playsoundatposition(var_f6dffc36, location.origin);
                wait 0.05;
                continue;
            }
            playsoundatposition(soundalias, location.origin);
            wait 0.05;
        }
    }
}

// Namespace zm_island_vo
// Params 0, eflags: 0x0
// Checksum 0x5b3fb671, Offset: 0x7a78
// Size: 0x2c
function function_5f161c52() {
    self function_7f4cb4c("ee", "spider", 1);
}

