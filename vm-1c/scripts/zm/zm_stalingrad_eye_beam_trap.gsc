#using scripts/codescripts/struct;
#using scripts/shared/_burnplayer;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_stalingrad;
#using scripts/zm/zm_stalingrad_util;
#using scripts/zm/zm_stalingrad_vo;

#namespace zm_stalingrad_eye_beam_trap;

// Namespace zm_stalingrad_eye_beam_trap
// Params 0, eflags: 0x2
// Checksum 0x51e0ee53, Offset: 0x530
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_stalingrad_eye_beam_trap", &__init__, undefined, undefined);
}

// Namespace zm_stalingrad_eye_beam_trap
// Params 0, eflags: 0x0
// Checksum 0xcad13822, Offset: 0x570
// Size: 0x2a0
function __init__() {
    clientfield::register("toplayer", "eye_beam_trap_postfx", 12000, 1, "int");
    clientfield::register("world", "eye_beam_rumble_factory", 12000, 1, "int");
    clientfield::register("world", "eye_beam_rumble_library", 12000, 1, "int");
    var_4c2cabd5 = getentarray("beam_trap_killzone", "targetname");
    foreach (var_12b7bb35 in var_4c2cabd5) {
        a_s_switches = struct::get_array(var_12b7bb35.target, "targetname");
        foreach (s_target in a_s_switches) {
            s_unitrigger = s_target zm_unitrigger::create_unitrigger("", undefined, &function_a2abac9c, &function_fd8775a2);
            s_unitrigger.hint_parm1 = 1500;
            s_unitrigger flag::init("beam_cooldown");
            s_unitrigger flag::init("beam_on");
            s_unitrigger.var_cbf27250 = "fxexp_" + var_12b7bb35.script_int;
            s_unitrigger.var_4ae7f8db = var_12b7bb35;
        }
    }
}

// Namespace zm_stalingrad_eye_beam_trap
// Params 1, eflags: 0x0
// Checksum 0xaf83ccba, Offset: 0x818
// Size: 0x150
function function_a2abac9c(e_player) {
    if (e_player.is_drinking > 0) {
        self sethintstring("");
        return false;
    } else if (!level flag::get("power_on")) {
        self sethintstring(%ZOMBIE_NEED_POWER);
        return false;
    } else if (self.stub flag::get("beam_on")) {
        self sethintstring(%ZOMBIE_TRAP_ACTIVE);
        return false;
    } else if (self.stub flag::get("beam_cooldown")) {
        self sethintstring(%ZM_STALINGRAD_TRAP_COOLDOWN);
        return false;
    } else {
        self sethintstring(%ZM_STALINGRAD_EYE_BEAM_TRAP, self.stub.hint_parm1);
    }
    return true;
}

// Namespace zm_stalingrad_eye_beam_trap
// Params 0, eflags: 0x0
// Checksum 0xfd45b1c8, Offset: 0x970
// Size: 0x1b0
function function_fd8775a2() {
    a_s_switches = struct::get_array(self.stub.var_4ae7f8db.target, "targetname");
    while (true) {
        if (self.stub flag::get("beam_cooldown")) {
            self.stub flag::wait_till_clear("beam_cooldown");
        }
        self waittill(#"trigger", e_who);
        if (!self.stub flag::get("beam_on") && !self.stub flag::get("beam_cooldown")) {
            if (!e_who zm_score::can_player_purchase(1500)) {
                zm_utility::play_sound_at_pos("no_purchase", self.origin);
                e_who zm_audio::create_and_play_dialog("general", "outofmoney");
                continue;
            }
            e_who clientfield::increment_to_player("interact_rumble");
            e_who zm_score::minus_to_player_score(1500);
            self.stub thread function_3ae55c2d(e_who, a_s_switches);
        }
    }
}

// Namespace zm_stalingrad_eye_beam_trap
// Params 2, eflags: 0x0
// Checksum 0x85a77903, Offset: 0xb28
// Size: 0x10c
function function_3ae55c2d(var_f2bd831, a_s_switches) {
    foreach (s_target in a_s_switches) {
        s_target.s_unitrigger flag::set("beam_on");
        playsoundatposition("zmb_robo_eye_beam_start", s_target.origin);
    }
    s_target zm_stalingrad_util::function_903f6b36(1);
    self thread function_8bc8cc13(var_f2bd831, a_s_switches);
}

// Namespace zm_stalingrad_eye_beam_trap
// Params 2, eflags: 0x0
// Checksum 0xcafafa64, Offset: 0xc40
// Size: 0x702
function function_8bc8cc13(var_f2bd831, a_s_switches) {
    n_start_time = gettime();
    n_total_time = 0;
    var_47326 = self.var_4ae7f8db;
    var_cbf27250 = self.var_cbf27250;
    exploder::exploder(var_cbf27250);
    var_f7261317 = getent("eye_beam_volume_" + var_47326.script_string, "targetname");
    var_f2bd831 thread zm_stalingrad_vo::function_176ac3fa();
    level clientfield::set("eye_beam_rumble_" + var_47326.script_string, 1);
    level thread function_78f79e79(1);
    n_total_kills = 0;
    while (30 > n_total_time) {
        var_910826d7 = var_47326 array::get_touching(level.players);
        a_ai_enemies = getaiteamarray(level.zombie_team);
        var_5d263f41 = var_47326 array::get_touching(a_ai_enemies);
        var_21d30559 = getvehicleteamarray("axis");
        var_f7291731 = var_f7261317 array::get_touching(var_21d30559);
        foreach (var_5307d079 in var_f7291731) {
            array::add(var_5d263f41, var_5307d079, 0);
        }
        foreach (ai_target in var_5d263f41) {
            if (ai_target.archetype === "zombie" || ai_target.archetype === "raz" || isdefined(ai_target) && ai_target.archetype === "sentinel_drone") {
                if (ai_target.archetype != "sentinel_drone") {
                    ai_target clientfield::increment("zm_nuked");
                }
                ai_target dodamage(ai_target.health, ai_target.origin, undefined, undefined, "none", "MOD_IMPACT");
                if (isdefined(var_f2bd831)) {
                    var_f2bd831 notify(#"hash_696f953");
                    var_f2bd831 zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_KILL_TRAP");
                }
                n_total_kills++;
            }
        }
        foreach (e_player in var_910826d7) {
            if (zm_utility::is_player_valid(e_player) && !(isdefined(e_player.var_5a524cf9) && e_player.var_5a524cf9)) {
                e_player thread function_6009178e(var_47326);
            }
        }
        wait 0.25;
        n_total_time = (gettime() - n_start_time) / 1000;
    }
    if (isdefined(var_f2bd831)) {
        var_f2bd831 notify(#"hash_c925c266", n_total_kills);
    }
    level notify(#"hash_278aa663", var_cbf27250);
    level thread function_78f79e79(0);
    exploder::stop_exploder(var_cbf27250);
    foreach (s_target in a_s_switches) {
        s_target.s_unitrigger flag::clear("beam_on");
        s_target.s_unitrigger flag::set("beam_cooldown");
        playsoundatposition("zmb_robo_eye_beam_stop", s_target.origin);
    }
    level clientfield::set("eye_beam_rumble_" + var_47326.script_string, 0);
    wait 60;
    s_target zm_stalingrad_util::function_903f6b36(0);
    foreach (s_target in a_s_switches) {
        s_target.s_unitrigger flag::clear("beam_cooldown");
    }
}

// Namespace zm_stalingrad_eye_beam_trap
// Params 1, eflags: 0x0
// Checksum 0x94c79d6c, Offset: 0x1350
// Size: 0xbc
function function_78f79e79(var_66a9cd70) {
    mdl_head = getent("robot_head_clocktower", "targetname");
    if (var_66a9cd70) {
        mdl_head playsound("zmb_robo_eye_head_start");
        mdl_head playloopsound("zmb_robo_eye_head_lp", 1.5);
        return;
    }
    mdl_head playsound("zmb_robo_eye_head_stop");
    mdl_head stoploopsound(1);
}

// Namespace zm_stalingrad_eye_beam_trap
// Params 1, eflags: 0x0
// Checksum 0x46473d35, Offset: 0x1418
// Size: 0x166
function function_6009178e(var_47326) {
    level endon(#"tesla_coil_cooldown");
    /#
        if (isgodmode(self)) {
            return;
        }
    #/
    self.var_5a524cf9 = 1;
    self clientfield::set_to_player("eye_beam_trap_postfx", 1);
    while (zm_utility::is_player_valid(self) && self istouching(var_47326)) {
        var_7929bbd6 = gettime();
        if (!isdefined(self.var_6850f846) || var_7929bbd6 - self.var_6850f846 > 200) {
            self.var_6850f846 = var_7929bbd6;
            self playrumbleonentity("damage_heavy");
            self dodamage(40, self.origin, undefined, undefined, undefined, "MOD_BURNED");
        }
        wait 0.2;
    }
    self clientfield::set_to_player("eye_beam_trap_postfx", 0);
    self.var_5a524cf9 = undefined;
    self.var_6850f846 = undefined;
}

