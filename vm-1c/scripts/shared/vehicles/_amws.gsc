#using scripts/codescripts/struct;
#using scripts/shared/ai/blackboard_vehicle;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/array_shared;
#using scripts/shared/math_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/weapons/_heatseekingmissile;

#using_animtree("generic");

#namespace amws;

// Namespace amws
// Params 0, eflags: 0x2
// Checksum 0x8b599a3e, Offset: 0x3d8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("amws", &__init__, undefined, undefined);
}

// Namespace amws
// Params 0, eflags: 0x0
// Checksum 0x2e17a590, Offset: 0x418
// Size: 0x2c
function __init__() {
    vehicle::add_main_callback("amws", &amws_initialize);
}

// Namespace amws
// Params 0, eflags: 0x0
// Checksum 0x376b90e4, Offset: 0x450
// Size: 0x274
function amws_initialize() {
    self useanimtree(#generic);
    target_set(self, (0, 0, 0));
    blackboard::createblackboardforentity(self);
    self blackboard::registervehicleblackboardattributes();
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    self enableaimassist();
    self setneargoalnotifydist(40);
    self.fovcosine = 0;
    self.fovcosinebusy = 0.574;
    self.vehaircraftcollisionenabled = 1;
    assert(isdefined(self.scriptbundlesettings));
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    self.goalradius = 999999;
    self.goalheight = 512;
    self setgoal(self.origin, 0, self.goalradius, self.goalheight);
    self.delete_on_death = 0;
    self.overridevehicledamage = &drone_callback_damage;
    self thread vehicle_ai::nudge_collision();
    self.cobra = 0;
    self asmrequestsubstate("locomotion@movement");
    self.variant = "light_weight";
    if (issubstr(self.vehicletype, "pamws")) {
        self.variant = "armored";
    }
    self vehicle_ai::cooldown("cobra_up", 10);
    if (isdefined(level.vehicle_initializer_cb)) {
        [[ level.vehicle_initializer_cb ]](self);
    }
    defaultrole();
}

// Namespace amws
// Params 0, eflags: 0x0
// Checksum 0x53e6f4df, Offset: 0x6d0
// Size: 0x30c
function defaultrole() {
    self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::get_state_callbacks("combat").enter_func = &state_combat_enter;
    self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
    self vehicle_ai::get_state_callbacks("driving").update_func = &state_driving_update;
    self vehicle_ai::get_state_callbacks("emped").update_func = &state_emped_update;
    self vehicle_ai::get_state_callbacks("surge").update_func = &function_91f83259;
    self vehicle_ai::get_state_callbacks("surge").exit_func = &function_f9bbc086;
    self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
    self vehicle_ai::add_state("stationary", &state_stationary_enter, &state_stationary_update, &state_stationary_exit);
    vehicle_ai::add_interrupt_connection("stationary", "scripted", "enter_scripted");
    vehicle_ai::add_interrupt_connection("stationary", "emped", "emped");
    vehicle_ai::add_interrupt_connection("stationary", "off", "shut_off");
    vehicle_ai::add_interrupt_connection("stationary", "driving", "enter_vehicle");
    vehicle_ai::add_interrupt_connection("stationary", "pain", "pain");
    vehicle_ai::add_interrupt_connection("stationary", "surge", "surge");
    vehicle_ai::add_utility_connection("stationary", "combat");
    vehicle_ai::add_utility_connection("combat", "stationary");
    self vehicle_ai::startinitialstate("combat");
}

// Namespace amws
// Params 1, eflags: 0x0
// Checksum 0xd370a46b, Offset: 0x9e8
// Size: 0xac
function state_death_update(params) {
    self endon(#"death");
    death_type = vehicle_ai::get_death_type(params);
    if (!isdefined(death_type)) {
        params.death_type = "gibbed";
        death_type = params.death_type;
    }
    if (death_type === "suicide_crash") {
        self death_suicide_crash(params);
    }
    self vehicle_ai::defaultstate_death_update(params);
}

// Namespace amws
// Params 1, eflags: 0x0
// Checksum 0x37eef556, Offset: 0xaa0
// Size: 0x1dc
function death_suicide_crash(params) {
    self endon(#"death");
    goaldir = anglestoforward(self.angles);
    goaldist = randomfloatrange(300, 400);
    goalpos = self.origin + goaldir * goaldist;
    self setmaxspeedscale(880 / self getmaxspeed(1));
    self setmaxaccelerationscale(50 / self getdefaultacceleration());
    self setspeed(self.settings.var_c46e96db * self.settings.defaultmovespeed);
    self setvehgoalpos(goalpos, 0);
    self util::waittill_any_timeout(3.5, "near_goal", "veh_collision");
    self setmaxspeedscale(0.1);
    self setspeed(0.1);
    self vehicle_ai::clearallmovement();
    self vehicle_ai::clearalllookingandtargeting();
    self.death_type = "gibbed";
}

// Namespace amws
// Params 1, eflags: 0x0
// Checksum 0x1c59f4b2, Offset: 0xc88
// Size: 0xc8
function state_driving_update(params) {
    self endon(#"change_state");
    self endon(#"death");
    driver = self getseatoccupant(0);
    if (isplayer(driver)) {
        while (true) {
            driver endon(#"disconnect");
            driver util::waittill_vehicle_move_up_button_pressed();
            if (self.cobra === 0) {
                self cobra_raise();
                continue;
            }
            self cobra_retract();
        }
    }
}

// Namespace amws
// Params 0, eflags: 0x0
// Checksum 0xfb2bb9ee, Offset: 0xd58
// Size: 0xc4
function cobra_raise() {
    self.cobra = 1;
    if (isdefined(self.settings.cobra_fx_1) && isdefined(self.settings.cobra_tag_1)) {
        playfxontag(self.settings.cobra_fx_1, self, self.settings.cobra_tag_1);
    }
    self asmrequestsubstate("cobra@stationary");
    self vehicle_ai::waittill_asm_complete("cobra@stationary", 4);
    self laseron();
}

// Namespace amws
// Params 0, eflags: 0x0
// Checksum 0xd09bb11b, Offset: 0xe28
// Size: 0x6c
function cobra_retract() {
    self.cobra = 0;
    self laseroff();
    self notify(#"disable_lens_flare");
    self asmrequestsubstate("locomotion@movement");
    self vehicle_ai::waittill_asm_complete("locomotion@movement", 4);
}

// Namespace amws
// Params 1, eflags: 0x0
// Checksum 0x712cc0d1, Offset: 0xea0
// Size: 0xf4
function state_emped_update(params) {
    self endon(#"death");
    self endon(#"change_state");
    angles = self gettagangles("tag_turret");
    self function_d013f7fa((45, angles[1] - self.angles[1], 0), 0);
    angles = self gettagangles("tag_gunner_turret1");
    self function_d013f7fa((45, angles[1] - self.angles[1], 0), 1);
    self vehicle_ai::defaultstate_emped_update(params);
}

// Namespace amws
// Params 1, eflags: 0x0
// Checksum 0x5bbfee9e, Offset: 0xfa0
// Size: 0x94
function function_91f83259(params) {
    self endon(#"change_state");
    self endon(#"death");
    self setmaxspeedscale(880 / self getmaxspeed(1));
    self setmaxaccelerationscale(50 / self getdefaultacceleration());
    self vehicle_ai::function_2995bfc0(params);
}

// Namespace amws
// Params 1, eflags: 0x0
// Checksum 0x7e2fc0e5, Offset: 0x1040
// Size: 0x7c
function function_f9bbc086(params) {
    self setmaxspeedscale(0.1);
    self setspeed(0.1);
    self vehicle_ai::clearallmovement();
    self vehicle_ai::clearalllookingandtargeting();
}

// Namespace amws
// Params 1, eflags: 0x0
// Checksum 0xa9d0aec7, Offset: 0x10c8
// Size: 0x44
function state_stationary_enter(params) {
    vehicle_ai::clearalllookingandtargeting();
    vehicle_ai::clearallmovement();
    self setbrake(1);
}

// Namespace amws
// Params 1, eflags: 0x0
// Checksum 0x3cf7adeb, Offset: 0x1118
// Size: 0x49c
function state_stationary_update(params) {
    self endon(#"death");
    self endon(#"change_state");
    self notify(#"stop_rocket_firing_thread");
    vehicle_ai::clearalllookingandtargeting();
    vehicle_ai::clearallmovement();
    wait 1;
    self cobra_raise();
    mintime = 6;
    maxtime = 12;
    transformwhenenemyclose = randomint(100) < 25;
    losepatienttime = 3 + randomfloat(2);
    starttime = gettime();
    vehicle_ai::cooldown("rocket", 2);
    evade_now = 0;
    while (true) {
        evade_now = self.settings.evade_enemies_locking_on_me === 1 && (self.settings.evade_enemies_locked_on_me === 1 && self.locked_on || self.locking_on);
        if (vehicle_ai::timesince(starttime) > maxtime || evade_now) {
            break;
        }
        if (isdefined(self.enemy)) {
            distsqr = distancesquared(self.enemy.origin, self.origin);
            if (vehicle_ai::timesince(starttime) > mintime) {
                if (transformwhenenemyclose && distsqr < -56 * -56) {
                    break;
                }
                if (!self function_6d424c6f(self.enemy, losepatienttime)) {
                    break;
                }
            }
            if (self function_4246bc05(self.enemy)) {
                if (distsqr < self.settings.engagementdistmax * 3 * self.settings.engagementdistmax * 3) {
                    self setturrettargetent(self.enemy, (0, 0, -5));
                    self function_9af49228(self.enemy, (0, 0, -5), 0);
                    if (vehicle_ai::iscooldownready("rocket") && self.turretontarget && self.gib_rocket !== 1) {
                        self thread firerocketlauncher(self.enemy);
                        vehicle_ai::cooldown("rocket", self.settings.rocketcooldown);
                    }
                    weapon = self seatgetweapon(1);
                    if (weapon.name == "none") {
                        idx = 0;
                    } else {
                        idx = 1;
                    }
                    self vehicle_ai::fire_for_time(1, idx, self.enemy, 0.5);
                } else {
                    break;
                }
            }
        }
        wait 0.1;
    }
    self notify(#"stop_rocket_firing_thread");
    vehicle_ai::clearalllookingandtargeting();
    vehicle_ai::clearallmovement();
    if (evade_now) {
        self wait_evasion_reaction_time();
    } else {
        self state_stationary_update_wait(0.5);
    }
    self cobra_retract();
    self vehicle_ai::evaluate_connections();
}

// Namespace amws
// Params 1, eflags: 0x0
// Checksum 0x8584797, Offset: 0x15c0
// Size: 0x24
function state_stationary_update_wait(wait_time) {
    waittill_weapon_lock_or_timeout(wait_time);
}

// Namespace amws
// Params 1, eflags: 0x0
// Checksum 0xcc1af1ce, Offset: 0x15f0
// Size: 0x64
function state_stationary_exit(params) {
    vehicle_ai::clearalllookingandtargeting();
    vehicle_ai::clearallmovement();
    self setbrake(0);
    self vehicle_ai::cooldown("cobra_up", 10);
}

// Namespace amws
// Params 1, eflags: 0x0
// Checksum 0x87029bf, Offset: 0x1660
// Size: 0x24
function state_combat_enter(params) {
    self thread turretfireupdate();
}

// Namespace amws
// Params 0, eflags: 0x0
// Checksum 0x7d36ad10, Offset: 0x1690
// Size: 0x2e
function is_ai_using_minigun() {
    return isdefined(self.settings.ai_uses_minigun) ? self.settings.ai_uses_minigun : 1;
}

// Namespace amws
// Params 0, eflags: 0x0
// Checksum 0x4599f70c, Offset: 0x16c8
// Size: 0x320
function turretfireupdate() {
    weapon = self seatgetweapon(1);
    if (weapon.name == "none") {
        return;
    }
    self endon(#"death");
    self endon(#"change_state");
    self function_2ea2374c(7);
    self function_2ea2374c(7, 0);
    while (true) {
        if (self.avoid_shooting_owner === 1 && isdefined(self.owner)) {
            if (self vehicle_ai::owner_in_line_of_fire()) {
                wait 0.5;
                continue;
            }
        }
        if (isdefined(self.enemy) && self function_4246bc05(self.enemy) && distancesquared(self.enemy.origin, self.origin) < self.settings.engagementdistmax * 3 * self.settings.engagementdistmax * 3) {
            self function_9af49228(self.enemy, (0, 0, 0), 0);
            if (self is_ai_using_minigun()) {
                self setturretspinning(1);
            }
            wait 0.05;
            if (!self.gunner1ontarget) {
                wait 0.5;
            }
            if (self.gunner1ontarget) {
                if (isdefined(self.enemy) && self function_4246bc05(self.enemy)) {
                    self vehicle_ai::fire_for_time(randomfloatrange(self.settings.burstfiredurationmin, self.settings.burstfiredurationmax), 1, self.enemy);
                }
                if (self is_ai_using_minigun()) {
                    self setturretspinning(0);
                }
                if (isdefined(self.enemy) && isai(self.enemy)) {
                    wait randomfloatrange(self.settings.burstfireaidelaymin, self.settings.burstfireaidelaymax);
                } else {
                    wait randomfloatrange(self.settings.burstfiredelaymin, self.settings.burstfiredelaymax);
                }
            } else {
                wait 0.5;
            }
            continue;
        }
        wait 0.4;
    }
}

// Namespace amws
// Params 1, eflags: 0x0
// Checksum 0x92373bde, Offset: 0x19f0
// Size: 0x750
function state_combat_update(params) {
    self endon(#"change_state");
    self endon(#"death");
    lasttimechangeposition = 0;
    self.shouldgotonewposition = 0;
    self.lasttimetargetinsight = 0;
    heatseekingmissile::initlockfield(self);
    self.lock_evading = 0;
    for (;;) {
        if (self.lock_evading == 0) {
            self setspeed(self.settings.defaultmovespeed);
            self setacceleration(isdefined(self.settings.default_move_acceleration) ? self.settings.default_move_acceleration : 10);
        }
        if (randomint(100) < 3 && vehicle_ai::iscooldownready("cobra_up") && self.lock_evading == 0) {
            if (isdefined(self.enemy) && distancesquared(self.enemy.origin, self.origin) > -56 * -56) {
                if (distancesquared(self.enemy.origin, self.origin) < self.settings.engagementdistmax * 2 * self.settings.engagementdistmax * 2) {
                    self vehicle_ai::evaluate_connections();
                }
            }
        }
        if (self.settings.engage_enemies_locked_on_me === 1 && self.locked_on) {
            self vehicle_ai::function_54289651(isdefined(self.settings.var_97076f98) ? self.settings.var_97076f98 : 5000, isdefined(self.settings.var_a293b67) ? self.settings.var_a293b67 : 1);
            self.shouldgotonewposition = 1;
        } else if (self.settings.engage_enemies_locking_on_me === 1 && self.locking_on) {
            self vehicle_ai::function_b4b8a386(isdefined(self.settings.var_392335b9) ? self.settings.var_392335b9 : 2000, isdefined(self.settings.var_9623f214) ? self.settings.var_9623f214 : 1);
            self.shouldgotonewposition = 1;
        }
        self.lock_evading = 0;
        if (self.settings.evade_enemies_locked_on_me === 1) {
            self.lock_evading |= self.locked_on;
        }
        if (self.settings.evade_enemies_locking_on_me === 1) {
            self.lock_evading |= self.locking_on;
            self.lock_evading |= self.locking_on_hacking;
        }
        if (isdefined(self.inpain) && self.inpain) {
            wait 0.1;
            continue;
        }
        if (!isdefined(self.enemy)) {
            should_slow_down_at_goal = 1;
            if (self.lock_evading) {
                self.current_pathto_pos = getnextmoveposition_evasive(self.lock_evading);
                should_slow_down_at_goal = 0;
            } else {
                self.current_pathto_pos = getnextmoveposition_wander();
            }
            if (isdefined(self.current_pathto_pos)) {
                if (self setvehgoalpos(self.current_pathto_pos, should_slow_down_at_goal, 1)) {
                    self thread path_update_interrupt_by_attacker();
                    self thread path_update_interrupt();
                    self vehicle_ai::waittill_pathing_done();
                    self notify(#"amws_end_interrupt_watch");
                    self playsound("veh_amws_scan");
                }
            }
            self state_combat_update_wait(0.5);
            continue;
        }
        self setturrettargetent(self.enemy);
        if (self function_4246bc05(self.enemy)) {
            self.lasttimetargetinsight = gettime();
        }
        if (self.shouldgotonewposition == 0) {
            if (gettime() > lasttimechangeposition + 1000) {
                self.shouldgotonewposition = 1;
            } else if (gettime() > self.lasttimetargetinsight + 500) {
                self.shouldgotonewposition = 1;
            }
        }
        if (self.shouldgotonewposition) {
            should_slow_down_at_goal = 1;
            if (self.lock_evading) {
                self.current_pathto_pos = getnextmoveposition_evasive(self.lock_evading);
                should_slow_down_at_goal = 0;
            } else {
                self.current_pathto_pos = getnextmoveposition_tactical(self.enemy);
            }
            if (isdefined(self.current_pathto_pos)) {
                if (self setvehgoalpos(self.current_pathto_pos, should_slow_down_at_goal, 1)) {
                    self thread path_update_interrupt_by_attacker();
                    self thread path_update_interrupt();
                    self vehicle_ai::waittill_pathing_done();
                    self notify(#"amws_end_interrupt_watch");
                }
                if (isdefined(self.enemy) && vehicle_ai::iscooldownready("rocket", 0.5) && self function_4246bc05(self.enemy) && self.gib_rocket !== 1) {
                    self thread aim_and_fire_rocket_launcher(0.4);
                }
                lasttimechangeposition = gettime();
                self.shouldgotonewposition = 0;
            }
        }
        self state_combat_update_wait(0.5);
    }
}

// Namespace amws
// Params 1, eflags: 0x0
// Checksum 0x1b0f2d31, Offset: 0x2148
// Size: 0xac
function aim_and_fire_rocket_launcher(aim_time) {
    self endon(#"death");
    self endon(#"change_state");
    self notify(#"stop_rocket_firing_thread");
    self endon(#"stop_rocket_firing_thread");
    if (!self.turretontarget) {
        wait aim_time;
    }
    if (isdefined(self.enemy) && self.turretontarget) {
        vehicle_ai::cooldown("rocket", self.settings.rocketcooldown);
        self thread firerocketlauncher(self.enemy);
    }
}

// Namespace amws
// Params 1, eflags: 0x0
// Checksum 0xc4b60e4c, Offset: 0x2200
// Size: 0x24
function state_combat_update_wait(wait_time) {
    self waittill_weapon_lock_or_timeout(wait_time);
}

// Namespace amws
// Params 1, eflags: 0x0
// Checksum 0x9daf4c59, Offset: 0x2230
// Size: 0x1cc
function waittill_weapon_lock_or_timeout(wait_time) {
    if (self.lock_evade_now === 1) {
        perform_evasion_reaction_wait = 1;
    } else {
        locked_on_notify = undefined;
        locking_on_notify = undefined;
        reacting_to_locks = self.settings.evade_enemies_locked_on_me === 1 || self.settings.engage_enemies_locked_on_me === 1;
        reacting_to_locking = self.settings.evade_enemies_locking_on_me === 1 || self.settings.engage_enemies_locking_on_me === 1;
        previous_locked_on_to_me = self.locked_on;
        previous_locking_on_to_me = self.locking_on;
        if (reacting_to_locks) {
            locked_on_notify = "missle_lock";
        }
        if (reacting_to_locking) {
            locking_on_notify = "locking on";
        }
        self util::waittill_any_timeout(wait_time, "damage", locking_on_notify, locked_on_notify);
        locked_on_to_me_just_changed = previous_locked_on_to_me != self.locked_on && self.locked_on;
        locking_on_to_me_just_changed = previous_locking_on_to_me != self.locking_on && self.locking_on;
        perform_evasion_reaction_wait = reacting_to_locking && (reacting_to_locks && locked_on_to_me_just_changed || locking_on_to_me_just_changed);
    }
    if (perform_evasion_reaction_wait) {
        self wait_evasion_reaction_time();
    }
}

// Namespace amws
// Params 0, eflags: 0x0
// Checksum 0x9d8515ed, Offset: 0x2408
// Size: 0x74
function wait_evasion_reaction_time() {
    wait randomfloatrange(isdefined(self.settings.enemy_evasion_reaction_time_min) ? self.settings.enemy_evasion_reaction_time_min : 0.1, isdefined(self.settings.enemy_evasion_reaction_time_max) ? self.settings.enemy_evasion_reaction_time_max : 0.2);
}

// Namespace amws
// Params 1, eflags: 0x0
// Checksum 0xd51f859e, Offset: 0x2488
// Size: 0xcc
function firerocketlauncher(enemy) {
    self endon(#"death");
    self endon(#"change_state");
    self notify(#"stop_rocket_firing_thread");
    self endon(#"stop_rocket_firing_thread");
    if (isdefined(enemy)) {
        self setturrettargetent(enemy);
        self util::waittill_any_timeout(1, "turret_on_target");
        if (self.variant == "armored") {
            vehicle_ai::fire_for_rounds(1, 0, enemy);
            return;
        }
        vehicle_ai::fire_for_rounds(2, 0, enemy);
    }
}

// Namespace amws
// Params 0, eflags: 0x0
// Checksum 0xbe426544, Offset: 0x2560
// Size: 0x34a
function getnextmoveposition_wander() {
    if (self.goalforced) {
        return self.goalpos;
    }
    querymultiplier = 1.5;
    queryresult = positionquery_source_navigation(self.origin, 80, 500 * querymultiplier, 250, 3 * self.radius * querymultiplier, self, self.radius * querymultiplier);
    if (queryresult.data.size == 0) {
        queryresult = positionquery_source_navigation(self.origin, 36, 120, -16, self.radius, self);
    }
    positionquery_filter_distancetogoal(queryresult, self);
    vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
    positionquery_filter_inclaimedlocation(queryresult, self);
    best_point = undefined;
    best_score = -999999;
    foreach (point in queryresult.data) {
        randomscore = randomfloatrange(0, 100);
        disttooriginscore = point.disttoorigin2d * 0.2;
        if (point.inclaimedlocation) {
            point.score -= 500;
        }
        point.score += randomscore + disttooriginscore;
        if (point.score > best_score) {
            best_score = point.score;
            best_point = point;
        }
    }
    /#
        self.debug_ai_move_to_points_considered = queryresult.data;
    #/
    if (!isdefined(best_point)) {
        /#
            self.debug_ai_movement_type = "<dev string:x28>" + queryresult.data.size + "<dev string:x36>";
        #/
        /#
            self.debug_ai_move_to_point = undefined;
        #/
        return undefined;
    }
    /#
        self.debug_ai_movement_type = "<dev string:x39>" + queryresult.data.size;
    #/
    /#
        self.debug_ai_move_to_point = best_point.origin;
    #/
    return best_point.origin;
}

// Namespace amws
// Params 1, eflags: 0x0
// Checksum 0xfe62b7c5, Offset: 0x28b8
// Size: 0x89a
function getnextmoveposition_evasive(client_flags) {
    assert(isdefined(client_flags));
    self setspeed(self.settings.defaultmovespeed * (isdefined(self.settings.lock_evade_speed_boost) ? self.settings.lock_evade_speed_boost : 2));
    self setacceleration((isdefined(self.settings.default_move_acceleration) ? self.settings.default_move_acceleration : 10) * (isdefined(self.settings.lock_evade_acceleration_boost) ? self.settings.lock_evade_acceleration_boost : 2));
    queryresult = positionquery_source_navigation(self.origin, isdefined(self.settings.lock_evade_dist_min) ? self.settings.lock_evade_dist_min : 120, isdefined(self.settings.lock_evade_dist_max) ? self.settings.lock_evade_dist_max : 360, math::clamp(isdefined(self.settings.lock_evade_dist_half_height) ? self.settings.lock_evade_dist_half_height : 250, 0.1, 99000), (isdefined(self.settings.lock_evade_point_spacing_factor) ? self.settings.lock_evade_point_spacing_factor : 1.5) * self.radius, self);
    positionquery_filter_inclaimedlocation(queryresult, self);
    foreach (point in queryresult.data) {
        if (point.inclaimedlocation) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x43>"] = -500;
            #/
            point.score += -500;
        }
    }
    remaining_lock_threats_to_evaluate = 3;
    remaining_flags_to_process = client_flags;
    for (i = 0; remaining_flags_to_process && remaining_lock_threats_to_evaluate > 0 && i < level.players.size; i++) {
        attacker = level.players[i];
        if (isdefined(attacker)) {
            client_flag = 1 << attacker getentitynumber();
            if (client_flag & remaining_flags_to_process) {
                positionquery_filter_directness(queryresult, self.origin, attacker.origin);
                foreach (point in queryresult.data) {
                    abs_directness = abs(point.directness);
                    if (abs_directness < 0.2) {
                        /#
                            if (!isdefined(point._scoredebug)) {
                                point._scoredebug = [];
                            }
                            point._scoredebug["<dev string:x55>"] = -56;
                        #/
                        point.score += -56;
                        continue;
                    }
                    if (abs_directness > (isdefined(self.settings.lock_evade_enemy_line_of_sight_directness) ? self.settings.lock_evade_enemy_line_of_sight_directness : 0.9)) {
                        /#
                            if (!isdefined(point._scoredebug)) {
                                point._scoredebug = [];
                            }
                            point._scoredebug["<dev string:x68>"] = -101;
                        #/
                        point.score += -101;
                    }
                }
                remaining_flags_to_process &= ~client_flag;
                remaining_lock_threats_to_evaluate--;
            }
        }
    }
    positionquery_filter_directness(queryresult, self.origin, self.origin + anglestoforward(self.angles) * 360);
    foreach (point in queryresult.data) {
        if (point.directness > 0.5) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x89>"] = 105;
            #/
            point.score += 105;
        }
    }
    best_point = undefined;
    best_score = -999999;
    foreach (point in queryresult.data) {
        if (point.score > best_score) {
            best_score = point.score;
            best_point = point;
        }
    }
    self.lock_evade_now = 0;
    self vehicle_ai::positionquery_debugscores(queryresult);
    /#
        self.debug_ai_move_to_points_considered = queryresult.data;
    #/
    if (!isdefined(best_point)) {
        /#
            self.debug_ai_movement_type = "<dev string:x9f>" + queryresult.data.size + "<dev string:x36>";
        #/
        /#
            self.debug_ai_move_to_point = undefined;
        #/
        return undefined;
    }
    /#
        self.debug_ai_movement_type = "<dev string:xae>" + queryresult.data.size;
    #/
    /#
        self.debug_ai_move_to_point = best_point.origin;
    #/
    return best_point.origin;
}

// Namespace amws
// Params 1, eflags: 0x0
// Checksum 0x55b81ef9, Offset: 0x3160
// Size: 0x91a
function getnextmoveposition_tactical(enemy) {
    if (self.goalforced) {
        return self.goalpos;
    }
    selfdisttotarget = distance2d(self.origin, enemy.origin);
    gooddist = 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax);
    tooclosedist = 0.4 * (self.settings.engagementdistmin + self.settings.engagementdistmax);
    closedist = 1.2 * gooddist;
    fardist = 3 * gooddist;
    querymultiplier = mapfloat(closedist, fardist, 1, 3, selfdisttotarget);
    prefereddirectness = 0;
    if (selfdisttotarget > gooddist) {
        prefereddirectness = mapfloat(closedist, fardist, 0, 1, selfdisttotarget);
    } else {
        prefereddirectness = mapfloat(tooclosedist * 0.4, tooclosedist, -1, -0.6, selfdisttotarget);
    }
    prefereddistawayfromorigin = 300;
    randomness = 30;
    queryresult = positionquery_source_navigation(self.origin, 80, 500 * querymultiplier, 250, 2 * self.radius * querymultiplier, self, 1 * self.radius * querymultiplier);
    positionquery_filter_directness(queryresult, self.origin, enemy.origin);
    positionquery_filter_distancetogoal(queryresult, self);
    vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
    positionquery_filter_inclaimedlocation(queryresult, self);
    vehicle_ai::positionquery_filter_engagementdist(queryresult, enemy, self.settings.engagementdistmin, self.settings.engagementdistmax);
    if (isdefined(self.avoidentities) && isdefined(self.avoidentitiesdistance)) {
        vehicle_ai::positionquery_filter_distawayfromtarget(queryresult, self.avoidentities, self.avoidentitiesdistance, -500);
    }
    best_point = undefined;
    best_score = -999999;
    foreach (point in queryresult.data) {
        difftoprefereddirectness = abs(point.directness - prefereddirectness);
        directnessscore = mapfloat(0, 1, 100, 0, difftoprefereddirectness);
        if (difftoprefereddirectness > 0.2) {
            directnessscore -= -56;
        }
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:xb9>"] = point.directness;
        #/
        point.score += point.directness;
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:xc7>"] = directnessscore;
        #/
        point.score += directnessscore;
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:xd2>"] = mapfloat(0, prefereddistawayfromorigin, 0, 100, point.disttoorigin2d);
        #/
        point.score += mapfloat(0, prefereddistawayfromorigin, 0, 100, point.disttoorigin2d);
        targetdistscore = 0;
        if (point.targetdist < tooclosedist) {
            targetdistscore -= -56;
        }
        if (point.inclaimedlocation) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x43>"] = -500;
            #/
            point.score += -500;
        }
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:xdf>"] = targetdistscore;
        #/
        point.score += targetdistscore;
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:xec>"] = randomfloatrange(0, randomness);
        #/
        point.score += randomfloatrange(0, randomness);
        if (point.score > best_score) {
            best_score = point.score;
            best_point = point;
        }
    }
    self vehicle_ai::positionquery_debugscores(queryresult);
    /#
        self.debug_ai_move_to_points_considered = queryresult.data;
    #/
    if (!isdefined(best_point)) {
        /#
            self.debug_ai_movement_type = "<dev string:xf3>" + queryresult.data.size + "<dev string:x36>";
        #/
        /#
            self.debug_ai_move_to_point = undefined;
        #/
        return undefined;
    }
    /#
        if (isdefined(getdvarint("<dev string:x103>")) && getdvarint("<dev string:x103>")) {
            recordline(self.origin, best_point.origin, (0.3, 1, 0));
            recordline(self.origin, enemy.origin, (1, 0, 0.4));
        }
    #/
    /#
        self.debug_ai_movement_type = "<dev string:x11b>" + queryresult.data.size;
    #/
    /#
        self.debug_ai_move_to_point = best_point.origin;
    #/
    return best_point.origin;
}

// Namespace amws
// Params 0, eflags: 0x0
// Checksum 0x6373a229, Offset: 0x3a88
// Size: 0xde
function path_update_interrupt_by_attacker() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"near_goal");
    self endon(#"reached_end_node");
    self endon(#"amws_end_interrupt_watch");
    self util::waittill_any("locking on", "missile_lock", "damage");
    if (self.locked_on || self.locking_on) {
        /#
            self.debug_ai_move_to_points_considered = [];
        #/
        /#
            self.debug_ai_movement_type = "<dev string:x127>";
        #/
        /#
            self.debug_ai_move_to_point = undefined;
        #/
        self clearvehgoalpos();
        self.lock_evade_now = 1;
    }
    self notify(#"near_goal");
}

// Namespace amws
// Params 0, eflags: 0x0
// Checksum 0x4cf3b255, Offset: 0x3b70
// Size: 0x1d0
function path_update_interrupt() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"near_goal");
    self endon(#"reached_end_node");
    self endon(#"amws_end_interrupt_watch");
    wait 1;
    while (true) {
        if (isdefined(self.current_pathto_pos)) {
            if (distance2dsquared(self.current_pathto_pos, self.goalpos) > self.goalradius * self.goalradius) {
                wait 0.2;
                self notify(#"near_goal");
            }
        }
        if (isdefined(self.enemy)) {
            if (self function_4246bc05(self.enemy) && distance2dsquared(self.origin, self.enemy.origin) < 0.4 * (self.settings.engagementdistmin + self.settings.engagementdistmax) * 0.4 * (self.settings.engagementdistmin + self.settings.engagementdistmax)) {
                self notify(#"near_goal");
            }
            if (vehicle_ai::iscooldownready("rocket") && vehicle_ai::iscooldownready("rocket_launcher_check")) {
                vehicle_ai::cooldown("rocket_launcher_check", 2.5);
                self notify(#"near_goal");
            }
        }
        wait 0.2;
    }
}

// Namespace amws
// Params 1, eflags: 0x0
// Checksum 0x17b123d9, Offset: 0x3d48
// Size: 0x84
function gib(attacker) {
    if (self.gibbed !== 1) {
        self vehicle::do_gib_dynents();
        self.gibbed = 1;
        self.death_type = "suicide_crash";
        self kill(self.origin + (0, 0, 10), attacker);
    }
}

// Namespace amws
// Params 15, eflags: 0x0
// Checksum 0x65936a9b, Offset: 0x3dd8
// Size: 0xd4
function drone_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    idamage = vehicle_ai::shared_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    return idamage;
}

