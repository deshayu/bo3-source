#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_traps;
#using scripts/zm/_zm_utility;

#namespace zm_trap_electric;

// Namespace zm_trap_electric
// Params 0, eflags: 0x2
// Checksum 0xc1b3b3d1, Offset: 0x340
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_trap_electric", &__init__, undefined, undefined);
}

// Namespace zm_trap_electric
// Params 0, eflags: 0x0
// Checksum 0x357c8cf, Offset: 0x380
// Size: 0x1aa
function __init__() {
    zm_traps::register_trap_basic_info("electric", &trap_activate_electric, &trap_audio);
    zm_traps::register_trap_damage("electric", &player_damage, &damage);
    if (!isdefined(level.vsmgr_prio_overlay_zm_trap_electrified)) {
        level.vsmgr_prio_overlay_zm_trap_electrified = 60;
    }
    visionset_mgr::register_info("overlay", "zm_trap_electric", 1, level.vsmgr_prio_overlay_zm_trap_electrified, 15, 1, &visionset_mgr::duration_lerp_thread_per_player, 0);
    level.var_20537efa = 1;
    a_traps = struct::get_array("trap_electric", "targetname");
    foreach (trap in a_traps) {
        clientfield::register("world", trap.script_noteworthy, 1, 1, "int");
    }
}

// Namespace zm_trap_electric
// Params 0, eflags: 0x0
// Checksum 0x75835fe, Offset: 0x538
// Size: 0x174
function trap_activate_electric() {
    self._trap_duration = 40;
    self._trap_cooldown_time = 60;
    if (isdefined(level.sndtrapfunc)) {
        level thread [[ level.sndtrapfunc ]](self, 1);
    }
    self notify(#"trap_activate");
    level notify(#"trap_activate", self);
    level clientfield::set(self.target, 1);
    fx_points = struct::get_array(self.target, "targetname");
    for (i = 0; i < fx_points.size; i++) {
        util::wait_network_frame();
        fx_points[i] thread trap_audio(self);
    }
    self thread zm_traps::trap_damage();
    self util::waittill_notify_or_timeout("trap_deactivate", self._trap_duration);
    self notify(#"trap_done");
    level clientfield::set(self.target, 0);
}

// Namespace zm_trap_electric
// Params 1, eflags: 0x0
// Checksum 0xde349fec, Offset: 0x6b8
// Size: 0x11c
function trap_audio(trap) {
    sound_origin = spawn("script_origin", self.origin);
    sound_origin playsound("wpn_zmb_inlevel_trap_start");
    sound_origin playloopsound("wpn_zmb_inlevel_trap_loop");
    self thread play_electrical_sound(trap);
    trap util::waittill_any_timeout(trap._trap_duration, "trap_done");
    if (isdefined(sound_origin)) {
        playsoundatposition("wpn_zmb_inlevel_trap_stop", sound_origin.origin);
        sound_origin stoploopsound();
        wait 0.05;
        sound_origin delete();
    }
}

// Namespace zm_trap_electric
// Params 1, eflags: 0x0
// Checksum 0x60302e5, Offset: 0x7e0
// Size: 0x68
function play_electrical_sound(trap) {
    trap endon(#"trap_done");
    while (true) {
        wait randomfloatrange(0.1, 0.5);
        playsoundatposition("amb_sparks", self.origin);
    }
}

// Namespace zm_trap_electric
// Params 0, eflags: 0x0
// Checksum 0x5acaab79, Offset: 0x850
// Size: 0x2c
function player_damage() {
    if (!(isdefined(self.b_no_trap_damage) && self.b_no_trap_damage)) {
        self thread zm_traps::player_elec_damage();
    }
}

// Namespace zm_trap_electric
// Params 1, eflags: 0x0
// Checksum 0xcf0fb80d, Offset: 0x888
// Size: 0x3ac
function damage(trap) {
    self endon(#"death");
    n_param = randomint(100);
    self.marked_for_death = 1;
    if (isdefined(trap.activated_by_player) && isplayer(trap.activated_by_player)) {
        trap.activated_by_player zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_KILL_TRAP");
        if (isdefined(trap.activated_by_player.var_83a6b1fd)) {
            trap.activated_by_player.var_83a6b1fd++;
            trap.activated_by_player notify(#"zombie_zapped");
        }
    }
    if (isdefined(self.animname) && self.animname != "zombie_dog" && isactor(self)) {
        if (n_param > 90 && level.burning_zombies.size < 6) {
            level.burning_zombies[level.burning_zombies.size] = self;
            self thread zm_traps::zombie_flame_watch();
            self playsound("zmb_ignite");
            self thread zombie_death::flame_death_fx();
            playfxontag(level._effect["character_fire_death_torso"], self, "J_SpineLower");
            wait randomfloat(1.25);
        } else {
            refs[0] = "guts";
            refs[1] = "right_arm";
            refs[2] = "left_arm";
            refs[3] = "right_leg";
            refs[4] = "left_leg";
            refs[5] = "no_legs";
            refs[6] = "head";
            self.a.gib_ref = refs[randomint(refs.size)];
            playsoundatposition("wpn_zmb_electrap_zap", self.origin);
            if (randomint(100) > 50) {
                self thread zm_traps::electroctute_death_fx();
            }
            self notify(#"bhtn_action_notify", "electrocute");
            wait randomfloat(1.25);
            self playsound("wpn_zmb_electrap_zap");
        }
    }
    if (isdefined(self.var_3925c480)) {
        self [[ self.var_3925c480 ]](trap);
        return;
    }
    level notify(#"trap_kill", self, trap);
    self dodamage(self.health + 666, self.origin, trap);
}

