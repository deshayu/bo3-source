#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_ai_mechz;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_hero_weapon;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_perk_electric_cherry;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_traps;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/zm_genesis_achievements;
#using scripts/zm/zm_genesis_challenges;
#using scripts/zm/zm_genesis_ee_quest;
#using scripts/zm/zm_genesis_margwa;
#using scripts/zm/zm_genesis_util;
#using scripts/zm/zm_genesis_vo;

#namespace zm_genesis_skull_turret;

// Namespace zm_genesis_skull_turret
// Params 0, eflags: 0x2
// Checksum 0x9dc1e11d, Offset: 0x898
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_genesis_skull_turret", &__init__, &__main__, undefined);
}

// Namespace zm_genesis_skull_turret
// Params 0, eflags: 0x0
// Checksum 0x4367ea42, Offset: 0x8e0
// Size: 0x144
function __init__() {
    clientfield::register("vehicle", "skull_turret", 15000, 2, "int");
    clientfield::register("vehicle", "skull_turret_beam_fire", 15000, 1, "int");
    clientfield::register("vehicle", "turret_beam_fire_crystal", 15000, 1, "int");
    clientfield::register("actor", "skull_turret_shock_fx", 15000, 1, "int");
    clientfield::register("actor", "skull_turret_shock_eye_fx", 15000, 1, "int");
    clientfield::register("actor", "skull_turret_explode_fx", 15000, 1, "counter");
    zm::register_player_damage_callback(&function_bfe01277);
}

// Namespace zm_genesis_skull_turret
// Params 1, eflags: 0x0
// Checksum 0xb2c5e218, Offset: 0xa30
// Size: 0xe4
function function_3f4e5049(eattacker) {
    if (isalive(self)) {
        if (eattacker.health <= 1000) {
            eattacker thread zm_perk_electric_cherry::electric_cherry_death_fx();
            if (isdefined(self.var_5d79e160)) {
                self.var_5d79e160++;
            }
            self zm_score::add_to_player_score(40);
        } else {
            eattacker thread zm_perk_electric_cherry::electric_cherry_stun();
            eattacker thread zm_perk_electric_cherry::electric_cherry_shock_fx();
        }
        eattacker dodamage(1000, self.origin, self, self, "none");
    }
}

// Namespace zm_genesis_skull_turret
// Params 10, eflags: 0x0
// Checksum 0xd0da9b62, Offset: 0xb20
// Size: 0x58
function function_bfe01277(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime) {
    return -1;
}

// Namespace zm_genesis_skull_turret
// Params 0, eflags: 0x0
// Checksum 0x34543185, Offset: 0xb80
// Size: 0x6c
function __main__() {
    var_53acb497 = spawner::simple_spawn("skull_turret", &function_aeaa2ee6);
    level thread function_7fd518ea();
    /#
        level thread function_881d11a1(var_53acb497);
    #/
}

// Namespace zm_genesis_skull_turret
// Params 0, eflags: 0x0
// Checksum 0xb0d29ff7, Offset: 0xbf8
// Size: 0x338
function function_aeaa2ee6() {
    self flag::init("turret_active");
    self flag::init("turret_cooldown");
    self makeusable();
    s_trigger = struct::get(self.target, "targetname");
    s_unitrigger = s_trigger zm_unitrigger::create_unitrigger(%, 32, &function_ff090b49);
    s_unitrigger.require_look_at = 1;
    zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger, 1);
    s_unitrigger.var_b8f9a884 = self;
    s_unitrigger.script_int = s_trigger.script_int;
    self thread function_838f52ad(s_trigger.script_int);
    self thread function_b759bcc1();
    while (true) {
        s_trigger waittill(#"trigger_activated", e_player);
        if (e_player zm_hero_weapon::function_f3451c9f()) {
            continue;
        }
        if (e_player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (e_player.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(e_player)) {
            continue;
        }
        if (self flag::get("turret_active")) {
            continue;
        }
        if (isdefined(self.var_5015d1a3)) {
            if (e_player === self.var_5015d1a3) {
                self thread function_d4781758(e_player);
            }
            continue;
        }
        if (e_player zm_score::can_player_purchase(2000)) {
            e_player zm_score::minus_to_player_score(2000);
            self thread function_4b8fea3(e_player);
            self thread function_d4781758(e_player);
            continue;
        }
        zm_utility::play_sound_at_pos("no_purchase", self.origin);
        if (isdefined(level.custom_generic_deny_vo_func)) {
            e_player thread [[ level.custom_generic_deny_vo_func ]](1);
            continue;
        }
        e_player zm_audio::create_and_play_dialog("general", "outofmoney");
    }
}

// Namespace zm_genesis_skull_turret
// Params 1, eflags: 0x0
// Checksum 0x8fb2d3f0, Offset: 0xf38
// Size: 0x1ac
function function_4b8fea3(e_player) {
    var_9f570f70 = 1;
    /#
        if (isdefined(level.var_dc188362) && level.var_dc188362) {
            var_9f570f70 = 0;
        }
    #/
    self.var_5015d1a3 = e_player;
    if (var_9f570f70) {
        str_return = self util::waittill_any_timeout(20, "turret_locked");
    } else {
        str_return = self util::waittill_any("turret_locked", "turret_timeout_changed");
    }
    self notify(#"turret_timeout");
    self.var_5015d1a3 = undefined;
    self flag::set("turret_cooldown");
    function_677988();
    if (isdefined(self.b_locked) && self.b_locked) {
        self waittill(#"hash_e39db36d");
    }
    self function_d013f7fa((0, 0, 0), 0);
    level util::waittill_notify_or_timeout("devgui_skull_turret_skip_timeout", 120);
    self playsound("wpn_skull_turret_ready");
    self flag::clear("turret_cooldown");
    function_eed68f1e();
}

// Namespace zm_genesis_skull_turret
// Params 1, eflags: 0x0
// Checksum 0x846402, Offset: 0x10f0
// Size: 0x244
function function_d4781758(e_player) {
    self flag::set("turret_active");
    if (math::cointoss()) {
        self thread zm_genesis_vo::function_bc8dac38(e_player, "turret");
    } else {
        e_player notify(#"gen_pos");
    }
    v_start_origin = e_player.origin;
    v_start_angles = e_player.angles;
    e_player.var_db95a9b0 = 1;
    self usevehicle(e_player, 0);
    e_player hideviewmodel();
    self function_67c99c8d();
    e_player thread namespace_c20cb06c::function_817b1327();
    str_return = self util::waittill_any("turret_timeout", "exit_vehicle", "turret_locked");
    e_player.var_db95a9b0 = undefined;
    self function_e4ac9f57();
    e_player notify(#"hash_720f4d71");
    if (str_return === "turret_locked") {
        self usevehicle(e_player, 0);
        level flag::wait_till("sophia_activated");
    } else if (str_return !== "exit_vehicle") {
        self usevehicle(e_player, 0);
    }
    thread function_c31e47a5(e_player, v_start_origin, v_start_angles);
    self flag::clear("turret_active");
}

// Namespace zm_genesis_skull_turret
// Params 3, eflags: 0x0
// Checksum 0x3bae7d7c, Offset: 0x1340
// Size: 0x74
function function_c31e47a5(e_player, v_start_origin, v_start_angles) {
    util::wait_network_frame();
    e_player setorigin(v_start_origin);
    e_player setplayerangles(v_start_angles);
    e_player showviewmodel();
}

// Namespace zm_genesis_skull_turret
// Params 1, eflags: 0x0
// Checksum 0xa4f7eb5a, Offset: 0x13c0
// Size: 0x222
function function_ff090b49(e_player) {
    if (isdefined(e_player.zombie_vars["zombie_powerup_minigun_on"]) && e_player.zombie_vars["zombie_powerup_minigun_on"]) {
        self sethintstring(%);
        return 0;
    }
    if (isdefined(self.stub.script_int) && !level flag::get("power_on" + self.stub.script_int)) {
        self sethintstring(%);
        return 0;
    }
    if (self.stub.var_b8f9a884 flag::get("turret_active")) {
        self sethintstring(%);
        return 0;
    }
    if (self.stub.var_b8f9a884 flag::get("turret_cooldown")) {
        self sethintstring(%ZM_GENESIS_SKULL_TURRET_COOLDOWN);
        return 0;
    }
    if (self.stub.var_b8f9a884.var_5015d1a3 === e_player) {
        self sethintstring(%ZM_GENESIS_REUSE_TURRET);
        return 1;
    }
    if (isdefined(self.stub.var_b8f9a884.var_5015d1a3)) {
        self sethintstring(%ZM_GENESIS_TURRET_IN_USE);
        return 0;
    }
    self sethintstring(%ZM_GENESIS_USE_TURRET, 2000);
    return 1;
}

// Namespace zm_genesis_skull_turret
// Params 2, eflags: 0x0
// Checksum 0x77f5fdb9, Offset: 0x15f0
// Size: 0x64
function render_debug_sphere(origin, color) {
    if (getdvarint("turret_debug_server")) {
        /#
            sphere(origin, 2, color, 0.75, 1, 10, 100);
        #/
    }
}

// Namespace zm_genesis_skull_turret
// Params 3, eflags: 0x0
// Checksum 0x8a4022d9, Offset: 0x1660
// Size: 0x64
function function_cd048702(origin1, origin2, color) {
    if (getdvarint("turret_debug_server")) {
        /#
            line(origin1, origin2, color, 0.75, 1, 100);
        #/
    }
}

// Namespace zm_genesis_skull_turret
// Params 2, eflags: 0x0
// Checksum 0xaa9832bd, Offset: 0x16d0
// Size: 0x64
function reflect_shot(d, n) {
    perp = 2 * vectordot(d, n);
    var_e47d2859 = d - perp * n;
    return var_e47d2859;
}

// Namespace zm_genesis_skull_turret
// Params 0, eflags: 0x0
// Checksum 0xa67d174, Offset: 0x1740
// Size: 0x778
function function_f2c7fc31() {
    self endon(#"stop_damage");
    while (true) {
        e_player = self getvehicleowner();
        var_c18b4417 = 1;
        v_position = self gettagorigin("tag_aim");
        v_forward = anglestoforward(self gettagangles("tag_aim"));
        a_trace = beamtrace(v_position, v_position + v_forward * 20000, 1, self);
        var_fc46c711 = a_trace["position"];
        function_cd048702(v_position, var_fc46c711, (1, 1, 0));
        render_debug_sphere(v_position, (1, 1, 0));
        render_debug_sphere(var_fc46c711, (1, 0, 0));
        if (isdefined(a_trace["entity"])) {
            e_last_target = a_trace["entity"];
            if (e_last_target.archetype === "zombie" || e_last_target.archetype === "parasite" || e_last_target.archetype === "keeper" || e_last_target.archetype === "apothicon_fury") {
                e_last_target thread function_67cc41d(self);
                var_9449eaa2 = "ai_zombie";
            } else if (isai(e_last_target)) {
                if (!isdefined(e_last_target.maxhealth)) {
                    e_last_target.maxhealth = e_last_target.health;
                }
                if (e_last_target.archetype == "margwa") {
                    e_last_target dodamage(level.var_6b7244b4, var_fc46c711, e_player, self);
                    if (e_last_target zm_genesis_margwa::function_2a03f05f()) {
                        e_last_target.var_9e59b56e = 1;
                    }
                } else if (e_last_target.archetype == "mechz") {
                    if (e_last_target zm_ai_mechz::function_58655f2a()) {
                        e_last_target.stun = 1;
                    }
                    e_last_target dodamage(30, var_fc46c711, e_player, self, undefined, "MOD_PROJECTILE_SPLASH", 0, getweapon("none"));
                } else {
                    e_last_target dodamage(e_last_target.maxhealth * 0.01, var_fc46c711, e_player, self);
                }
                var_9449eaa2 = "ai_boss";
            } else if (isdefined(e_last_target.targetname) && issubstr(e_last_target.targetname, "sophia_crystal") && level flag::get("phased_sophia_start")) {
                e_last_target notify(#"beam_damage", self, e_player);
                var_c18b4417 = 0;
            }
        } else {
            var_c18b4417 = 0;
            switch (a_trace["surfacetype"]) {
            case "glass":
            case "glasscar":
            case "metal":
            case "metalcar":
            case "rock":
                var_c18b4417 = 1;
                var_9449eaa2 = "reflective_geo";
                break;
            }
        }
        if (var_c18b4417) {
            if (e_last_target.archetype !== "zombie" && (!isdefined(e_last_target) || e_last_target.archetype !== "parasite")) {
                v_forward = reflect_shot(v_forward, a_trace["normal"]);
            }
            v_position = var_fc46c711;
            a_trace = beamtrace(v_position, v_position + v_forward * 20000, 1, self);
            var_fc46c711 = a_trace["position"];
            function_cd048702(v_position, var_fc46c711, (1, 1, 0));
            render_debug_sphere(var_fc46c711, (1, 0, 0));
            if (isdefined(a_trace["entity"])) {
                if (a_trace["entity"].archetype === "zombie" || a_trace["entity"].archetype === "parasite" || a_trace["entity"].archetype === "keeper" || a_trace["entity"].archetype === "apothicon_fury") {
                    a_trace["entity"] thread function_67cc41d(self);
                    var_6e477039 = "ai_zombie";
                } else if (isai(a_trace["entity"])) {
                    if (!isdefined(a_trace["entity"].maxhealth)) {
                        a_trace["entity"].maxhealth = a_trace["entity"].health;
                    }
                    a_trace["entity"] dodamage(a_trace["entity"].maxhealth * 0.01, a_trace["entity"].origin);
                    var_6e477039 = "ai_boss";
                }
            } else {
                var_6e477039 = "geo";
            }
            self thread function_b859045(var_9449eaa2, var_6e477039);
        }
        e_last_target = undefined;
        wait 0.05;
    }
}

// Namespace zm_genesis_skull_turret
// Params 2, eflags: 0x0
// Checksum 0x2848700b, Offset: 0x1ec0
// Size: 0xa2
function function_b859045(var_9449eaa2, var_6e477039) {
    e_player = self getvehicleowner();
    if (var_9449eaa2 === "ai_zombie" && var_6e477039 === "ai_zombie") {
        level notify(#"hash_11ab530d", e_player);
        return;
    }
    if (var_9449eaa2 === "reflective_geo" && var_6e477039 === "ai_zombie") {
        level notify(#"hash_b1a8571a", e_player);
    }
}

// Namespace zm_genesis_skull_turret
// Params 0, eflags: 0x0
// Checksum 0xd1ab87c4, Offset: 0x1f70
// Size: 0x11e
function function_b759bcc1() {
    while (true) {
        self waittill(#"weapon_fired");
        self function_3d36386();
        self clientfield::set("skull_turret_beam_fire", 1);
        e_player = self getvehicleowner();
        self thread function_f2c7fc31();
        do {
            wait 0.05;
        } while (zm_utility::is_player_valid(e_player) && e_player attackbuttonpressed() && e_player === self getvehicleowner());
        self clientfield::set("skull_turret_beam_fire", 0);
        self function_d54746f0();
        self notify(#"stop_damage");
    }
}

// Namespace zm_genesis_skull_turret
// Params 1, eflags: 0x0
// Checksum 0x93161e18, Offset: 0x2098
// Size: 0xc4
function function_838f52ad(var_97d8811) {
    wait 0.05;
    self hidepart("tag_turret_glow");
    self hidepart("tag_jaw_glow");
    self hidepart("tag_barrel_glow");
    self clientfield::set("skull_turret", 0);
    level flag::wait_till("power_on" + var_97d8811);
    function_eed68f1e();
}

// Namespace zm_genesis_skull_turret
// Params 1, eflags: 0x0
// Checksum 0x6864f28e, Offset: 0x2168
// Size: 0xa4
function function_eed68f1e(glow) {
    if (!isdefined(glow)) {
        glow = 2;
    }
    self clientfield::set("skull_turret", glow);
    self showpart("tag_turret_glow");
    self showpart("tag_jaw_glow");
    self showpart("tag_barrel_glow");
}

// Namespace zm_genesis_skull_turret
// Params 0, eflags: 0x0
// Checksum 0x9d6deacb, Offset: 0x2218
// Size: 0x84
function function_677988() {
    self clientfield::set("skull_turret", 0);
    self hidepart("tag_turret_glow");
    self hidepart("tag_jaw_glow");
    self hidepart("tag_barrel_glow");
}

// Namespace zm_genesis_skull_turret
// Params 1, eflags: 0x0
// Checksum 0xec178b3c, Offset: 0x22a8
// Size: 0x20
function function_67c99c8d(glow) {
    if (!isdefined(glow)) {
        glow = 2;
    }
}

// Namespace zm_genesis_skull_turret
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x22d0
// Size: 0x4
function function_e4ac9f57() {
    
}

// Namespace zm_genesis_skull_turret
// Params 0, eflags: 0x0
// Checksum 0x4ae91913, Offset: 0x22e0
// Size: 0x44
function function_3d36386() {
    playsoundatposition("wpn_skull_turret_start", self.origin);
    self playloopsound("wpn_skull_turret_loop");
}

// Namespace zm_genesis_skull_turret
// Params 0, eflags: 0x0
// Checksum 0x194fe304, Offset: 0x2330
// Size: 0x3c
function function_d54746f0() {
    playsoundatposition("wpn_skull_turret_stop", self.origin);
    self stoploopsound();
}

// Namespace zm_genesis_skull_turret
// Params 0, eflags: 0x0
// Checksum 0x4c89a248, Offset: 0x2378
// Size: 0x282
function function_7fd518ea() {
    var_9d322e2e = struct::get_array("115_crystals", "script_noteworthy");
    var_8ddaf045 = struct::get_array("115_crystal_decoy", "script_noteworthy");
    level.var_49483427 = 0;
    foreach (var_30c2e117 in var_9d322e2e) {
        var_618c7145 = util::spawn_model("p7_zm_ctl_crystal", var_30c2e117.origin, var_30c2e117.angles);
        var_618c7145 setscale(2);
        var_618c7145 thread function_13eaa39c();
        /#
            var_618c7145.script_string = var_30c2e117.script_string;
        #/
        var_618c7145 thread function_c4a9de44();
        var_618c7145.targetname = var_30c2e117.targetname;
    }
    foreach (var_9d1acd49 in var_8ddaf045) {
        var_40ff3b03 = util::spawn_model("p7_zm_ctl_crystal", var_9d1acd49.origin, var_9d1acd49.angles);
        var_40ff3b03 setscale(2);
        var_40ff3b03 thread function_13eaa39c();
    }
}

// Namespace zm_genesis_skull_turret
// Params 0, eflags: 0x0
// Checksum 0x5feb8de5, Offset: 0x2608
// Size: 0xc8
function function_13eaa39c() {
    while (true) {
        n_random = randomfloatrange(5, 7);
        self rotateto((randomintrange(-90, 90), randomintrange(-90, 90), randomintrange(-90, 90)), n_random);
        wait n_random;
        while (isdefined(self.var_827db0f2) && self.var_827db0f2) {
            wait 1;
        }
    }
}

// Namespace zm_genesis_skull_turret
// Params 0, eflags: 0x0
// Checksum 0x23c7f963, Offset: 0x26d8
// Size: 0x178
function function_c4a9de44() {
    /#
        if (level flag::get("<dev string:x28>")) {
            return;
        }
        self thread function_b52693fa();
    #/
    level flag::wait_till("phased_sophia_start");
    while (true) {
        self waittill(#"beam_damage", w_weapon, e_player);
        if (isdefined(w_weapon) && isdefined(e_player)) {
            n_start_time = gettime();
            n_total_time = 0;
            while (e_player attackbuttonpressed() && n_total_time < 0.15 && e_player function_1d6baeec(self)) {
                n_current_time = gettime();
                n_total_time = (n_current_time - n_start_time) / 1000;
                util::wait_network_frame();
            }
            if (n_total_time >= 0.15) {
                self sophia_beam_locked(w_weapon, e_player);
            }
        }
    }
}

/#

    // Namespace zm_genesis_skull_turret
    // Params 0, eflags: 0x0
    // Checksum 0x3e9982d1, Offset: 0x2858
    // Size: 0x84
    function function_b52693fa() {
        level endon(#"sophia_activated");
        level waittill(#"sophia_beam_locked");
        if (!(isdefined(self.var_827db0f2) && self.var_827db0f2)) {
            a_vehicles = getvehiclearray(self.script_string, "<dev string:x39>");
            self thread sophia_beam_locked(a_vehicles[0], level.players[0]);
        }
    }

#/

// Namespace zm_genesis_skull_turret
// Params 2, eflags: 0x0
// Checksum 0x13d4a846, Offset: 0x28e8
// Size: 0x1a2
function sophia_beam_locked(w_weapon, e_player) {
    /#
        if (level flag::get("<dev string:x28>")) {
            return;
        }
    #/
    self.var_827db0f2 = 1;
    w_weapon.b_locked = 1;
    level.var_49483427++;
    if (level.var_49483427 >= 4) {
        exploder::exploder("lgt_ee_sophia");
        level flag::set("sophia_beam_locked");
    }
    w_weapon clientfield::set("turret_beam_fire_crystal", 1);
    w_weapon notify(#"turret_locked");
    w_weapon setturrettargetent(self);
    e_player thread function_13705ce6(self);
    level flag::wait_till("sophia_activated");
    w_weapon clientfield::set("turret_beam_fire_crystal", 0);
    level.var_49483427--;
    if (level.var_49483427 <= 0) {
        exploder::delete_exploder_on_clients("lgt_ee_sophia");
    }
    w_weapon notify(#"hash_e39db36d");
    self.var_827db0f2 = undefined;
    w_weapon.b_locked = undefined;
}

// Namespace zm_genesis_skull_turret
// Params 1, eflags: 0x0
// Checksum 0x326854f9, Offset: 0x2a98
// Size: 0x6c
function function_13705ce6(e_target) {
    util::wait_network_frame();
    v_look = vectortoangles(e_target.origin - self.origin);
    self setplayerangles(v_look);
}

// Namespace zm_genesis_skull_turret
// Params 1, eflags: 0x0
// Checksum 0xf51abdbc, Offset: 0x2b10
// Size: 0xe6
function function_1d6baeec(var_618c7145) {
    e_turret = self.viewlockedentity;
    if (!isdefined(e_turret)) {
        return false;
    }
    v_position = e_turret gettagorigin("tag_aim");
    v_forward = anglestoforward(e_turret gettagangles("tag_aim"));
    a_trace = beamtrace(v_position, v_position + v_forward * 20000, 1, e_turret);
    if (var_618c7145 === a_trace["entity"]) {
        return true;
    }
    return false;
}

// Namespace zm_genesis_skull_turret
// Params 1, eflags: 0x0
// Checksum 0x86b17d6, Offset: 0x2c00
// Size: 0x334
function function_67cc41d(var_b8f9a884) {
    self endon(#"death");
    if (isdefined(self.var_26a94458) && self.var_26a94458) {
        return;
    }
    self.var_26a94458 = 1;
    if (self.archetype === "parasite") {
        self dodamage(self.health + 100, self.origin);
        return;
    }
    self.allowdeath = 0;
    self.magic_bullet_shield = 1;
    self notsolid();
    self clientfield::set("skull_turret_shock_fx", 1);
    self thread function_41ecbdf9();
    e_player = var_b8f9a884 getvehicleowner();
    self.no_damage_points = 1;
    self.deathpoints_already_given = 1;
    self zombie_utility::zombie_eye_glow_stop();
    if (self.archetype === "zombie") {
        level notify(#"hash_98ea05", e_player);
    }
    if (self.archetype === "keeper") {
        level notify(#"hash_353fc85a", e_player);
    }
    if (isdefined(self.archetype) && self.archetype == "margwa") {
        level notify(#"hash_d41bd8b0", e_player);
    }
    if (math::cointoss()) {
        if (isdefined(self.tesla_head_gib_func) && !self.head_gibbed) {
            self [[ self.tesla_head_gib_func ]]();
        }
    } else {
        self clientfield::set("skull_turret_shock_eye_fx", 1);
    }
    if (isalive(self)) {
        self scene::play("cin_zm_dlc1_zombie_dth_deathray_0" + randomintrange(1, 5), self);
    }
    self clientfield::set("skull_turret_shock_eye_fx", 0);
    self clientfield::set("skull_turret_shock_fx", 0);
    self clientfield::increment("skull_turret_explode_fx");
    self.allowdeath = 1;
    self.magic_bullet_shield = 0;
    self notify(#"exploding");
    self notify(#"end_melee");
    self playsound("zmb_deathray_zombie_poof");
    self thread function_218cc1b();
}

// Namespace zm_genesis_skull_turret
// Params 0, eflags: 0x0
// Checksum 0xb4b86248, Offset: 0x2f40
// Size: 0x4c
function function_218cc1b() {
    self notify(#"death");
    self ghost();
    self util::delay(0.25, undefined, &zm_utility::self_delete);
}

// Namespace zm_genesis_skull_turret
// Params 0, eflags: 0x0
// Checksum 0x8335ae72, Offset: 0x2f98
// Size: 0x80
function function_41ecbdf9() {
    self endon(#"death");
    self.var_128cd975 = 1;
    self.ignoreall = 1;
    self setgoal(self.origin);
    while (isdefined(self.var_26a94458) && self.var_26a94458) {
        if (!self.var_128cd975) {
            self.var_128cd975 = 1;
        }
        wait 0.1;
    }
}

/#

    // Namespace zm_genesis_skull_turret
    // Params 1, eflags: 0x0
    // Checksum 0x1c5bd53b, Offset: 0x3020
    // Size: 0xa4
    function function_881d11a1(var_53acb497) {
        level.var_81e4859 = var_53acb497;
        if (!isdefined(level.var_dc188362)) {
            level.var_dc188362 = 0;
        }
        level thread zm_genesis_util::function_72260d3a("<dev string:x4b>", "<dev string:x6b>", 1, &devgui_skull_turret_skip_timeout);
        level thread zm_genesis_util::function_72260d3a("<dev string:x85>", "<dev string:xab>", 1, &function_1f8c58a1);
    }

    // Namespace zm_genesis_skull_turret
    // Params 1, eflags: 0x0
    // Checksum 0x4b905de4, Offset: 0x30d0
    // Size: 0x1e
    function devgui_skull_turret_skip_timeout(n_val) {
        level notify(#"devgui_skull_turret_skip_timeout");
    }

    // Namespace zm_genesis_skull_turret
    // Params 1, eflags: 0x0
    // Checksum 0x85b9c9f2, Offset: 0x30f8
    // Size: 0xaa
    function function_1f8c58a1(n_val) {
        level.var_dc188362 = !(isdefined(level.var_dc188362) && level.var_dc188362);
        foreach (turret in level.var_81e4859) {
            turret notify(#"turret_timeout_changed");
        }
    }

#/
