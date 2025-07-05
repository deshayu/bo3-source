#using scripts/codescripts/struct;
#using scripts/mp/gametypes/_loadout;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/_oob;
#using scripts/shared/ai/blackboard_vehicle;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/gameskill_shared;
#using scripts/shared/math_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/weapons/_spike_charge_siegebot;

#using_animtree("generic");

#namespace siegebot;

// Namespace siegebot
// Params 0, eflags: 0x2
// Checksum 0x14749885, Offset: 0x6b0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("siegebot_mp", &__init__, undefined, undefined);
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0x9543b715, Offset: 0x6f0
// Size: 0x8c
function __init__() {
    vehicle::add_main_callback("siegebot_mp", &function_fcf49d56);
    clientfield::register("vehicle", "siegebot_retract_right_arm", 15000, 1, "int");
    clientfield::register("vehicle", "siegebot_retract_left_arm", 15000, 1, "int");
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0x15d1e957, Offset: 0x788
// Size: 0x48c
function function_fcf49d56() {
    self useanimtree(#generic);
    blackboard::createblackboardforentity(self);
    self blackboard::registervehicleblackboardattributes();
    self.health = self.healthdefault;
    self.spawntime = gettime();
    self.var_8a47a759 = 1;
    self.isstunned = 0;
    self.var_f9eb37d1 = 0;
    self.numberrockets = 3;
    self vehicle::friendly_fire_shield();
    self.targetoffset = (0, 0, 84);
    self enableaimassist();
    self setneargoalnotifydist(40);
    self.fovcosine = 0.5;
    self.fovcosinebusy = 0.5;
    self.maxsightdistsqrd = 10000 * 10000;
    assert(isdefined(self.scriptbundlesettings));
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    self.goalradius = 9999999;
    self.goalheight = 5000;
    self setgoal(self.origin, 0, self.goalradius, self.goalheight);
    self.overridevehicledamage = &function_3b05fc1b;
    self function_f3e02741();
    self function_6e075bdf(0, self.settings.gunner_turret_on_target_range);
    self asmrequestsubstate("locomotion@movement");
    if (self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
        self asmsetanimationrate(0.5);
        self hidepart("tag_turret_canopy_animate");
        self hidepart("tag_turret_panel_01_d0");
        self hidepart("tag_turret_panel_02_d0");
        self hidepart("tag_turret_panel_03_d0");
        self hidepart("tag_turret_panel_04_d0");
        self hidepart("tag_turret_panel_05_d0");
    } else if (self.vehicletype == "zombietron_veh_siegebot") {
        self asmsetanimationrate(1.429);
    }
    self function_5a6e3cac();
    if (isdefined(level.vehicle_initializer_cb)) {
        [[ level.vehicle_initializer_cb ]](self);
    }
    self.var_375cf54a = 1;
    self.var_3a087745 = 1;
    self vehicle_ai::function_a767f9b4();
    self thread vehicle_ai::target_hijackers();
    self.ignoreme = 1;
    killstreak_bundles::register_killstreak_bundle("siegebot");
    self.maxhealth = killstreak_bundles::get_max_health("siegebot");
    self.var_b1f078bb = self.maxhealth;
    self thread function_916a796c();
    self thread watch_game_ended();
    self thread function_d0c5071a();
    self thread watch_death();
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0xa6e495, Offset: 0xc20
// Size: 0xa8
function function_f3e02741() {
    value = gameskill::function_1ef3d569();
    var_7b6ddca7 = mapfloat(0, 9, 0.8, 2, value);
    var_fc916d4 = mapfloat(0, 9, 1, 0.5, value);
    self.var_cf0b2b03 = var_7b6ddca7;
    self.var_e8674008 = var_fc916d4;
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0xaf1977dd, Offset: 0xcd0
// Size: 0x2ac
function defaultrole() {
    self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
    self vehicle_ai::get_state_callbacks("combat").exit_func = &state_combat_exit;
    self vehicle_ai::get_state_callbacks("driving").update_func = &function_dcb2cf5;
    self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
    self vehicle_ai::get_state_callbacks("pain").update_func = &function_f71fc8b7;
    self vehicle_ai::get_state_callbacks("emped").enter_func = &function_881b0951;
    self vehicle_ai::get_state_callbacks("emped").update_func = &function_6b70970a;
    self vehicle_ai::get_state_callbacks("emped").exit_func = &function_4208588d;
    self vehicle_ai::get_state_callbacks("emped").reenter_func = &function_13a253c0;
    self vehicle_ai::add_state("jump", &function_bf7dfc58, &function_911f1aa5, &function_309fca92);
    vehicle_ai::add_utility_connection("combat", "jump", &function_ccaeca3);
    vehicle_ai::add_utility_connection("jump", "combat");
    self vehicle_ai::add_state("unaware", undefined, &state_unaware_update, undefined);
    vehicle_ai::startinitialstate("combat");
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0xd7a0fd31, Offset: 0xf88
// Size: 0x2d4
function state_death_update(params) {
    self endon(#"death");
    self endon(#"nodeath_thread");
    streamermodelhint(self.deathmodel, 6);
    death_type = vehicle_ai::get_death_type(params);
    if (!isdefined(death_type)) {
        params.death_type = "gibbed";
        death_type = params.death_type;
    }
    self function_84e7c9e7();
    self setturretspinning(0);
    self function_144b90e8();
    self vehicle::set_damage_fx_level(0);
    self playsound("veh_quadtank_sparks");
    if (self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
        self asmsetanimationrate(1);
    }
    self.turretrotscale = 3;
    self function_d013f7fa((0, 0, 0), 0);
    self function_d013f7fa((0, 0, 0), 1);
    self function_d013f7fa((0, 0, 0), 2);
    self asmrequestsubstate("death@stationary");
    self waittill(#"model_swap");
    self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
    self vehicle::do_death_dynents();
    self vehicle_death::death_radius_damage();
    self waittill(#"bodyfall large");
    self radiusdamage(self.origin + (0, 0, 10), self.radius * 0.8, -106, 60, self, "MOD_CRUSH");
    vehicle_ai::waittill_asm_complete("death@stationary", 3);
    self thread vehicle_death::cleanup();
    self vehicle_death::freewhensafe();
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0xac5163e9, Offset: 0x1268
// Size: 0x84
function function_dcb2cf5(params) {
    self thread function_5beec115();
    self thread function_cc487332();
    self cleartargetentity();
    self cancelaimove();
    self clearvehgoalpos();
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0xf357488d, Offset: 0x12f8
// Size: 0x108
function function_cc487332() {
    self endon(#"death");
    self endon(#"exit_vehicle");
    tilecount = 0;
    while (true) {
        var_6a22f6ec = anglestoup(self.angles);
        worldup = (0, 0, 1);
        if (vectordot(var_6a22f6ec, worldup) < 0.64) {
            tilecount += 1;
        } else {
            tilecount = 0;
        }
        if (tilecount > 20) {
            driver = self getseatoccupant(0);
            self kill(self.origin);
        }
        wait 0.05;
    }
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0xb862035, Offset: 0x1408
// Size: 0xdc
function function_5beec115() {
    self endon(#"death");
    self endon(#"exit_vehicle");
    weapon = self seatgetweapon(2);
    driver = self getseatoccupant(0);
    self thread function_bd6a90ca();
    while (true) {
        if (driver fragbuttonpressed() && !self.var_f9eb37d1) {
            self fireweapon(2);
            wait weapon.firetime;
            continue;
        }
        wait 0.05;
    }
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0x140c8491, Offset: 0x14f0
// Size: 0x1c8
function function_bd6a90ca() {
    self endon(#"death");
    self endon(#"exit_vehicle");
    var_4ac3a295 = 0;
    var_25aad16e = 1;
    while (true) {
        if (var_4ac3a295 == 0 && self function_39a73cfe(var_25aad16e)) {
            var_4ac3a295 = 10;
            var_25aad16e = 1;
        }
        if (var_4ac3a295 > 0) {
            aim_origin = self gettagorigin("tag_turret");
            var_f49e0cbb = self gettagangles("tag_turret");
            forward = anglestoforward(var_f49e0cbb);
            right = anglestoright(var_f49e0cbb);
            aim_origin += forward * 100 + right * 40;
            aim_origin += (0, 0, 500);
            self function_6521eb5d(aim_origin, 1);
            var_4ac3a295--;
        } else {
            self function_6521eb5d(self function_d24a7ea9(0), 1);
            var_25aad16e = 0;
        }
        wait 0.05;
    }
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0x4873f9c6, Offset: 0x16c0
// Size: 0xac
function function_881b0951(params) {
    if (!isdefined(self.abnormal_status)) {
        self.abnormal_status = spawnstruct();
    }
    self.abnormal_status.emped = 1;
    self.abnormal_status.attacker = params.var_6e0794d4[1];
    self.abnormal_status.inflictor = params.var_6e0794d4[2];
    self vehicle::toggle_emp_fx(1);
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0xfcc29c4, Offset: 0x1778
// Size: 0xe4
function function_6b70970a(params) {
    self endon(#"death");
    self endon(#"change_state");
    self function_144b90e8();
    if (self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
        self asmsetanimationrate(1);
    }
    asmstate = "damage_2@pain";
    self asmrequestsubstate(asmstate);
    self vehicle_ai::waittill_asm_complete(asmstate, 3);
    self setbrake(0);
    self vehicle_ai::evaluate_connections();
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0xeb424ace, Offset: 0x1868
// Size: 0xc
function function_4208588d(params) {
    
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0x496176a8, Offset: 0x1880
// Size: 0xe
function function_13a253c0(params) {
    return false;
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0x291b042, Offset: 0x1898
// Size: 0x18
function function_d56305c8(enabled) {
    self.var_72861401 = enabled;
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0xbbc8f17, Offset: 0x18b8
// Size: 0x104
function function_f71fc8b7(params) {
    self endon(#"death");
    self endon(#"change_state");
    self function_144b90e8();
    if (self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
        self asmsetanimationrate(1);
    }
    if (self.newdamagelevel == 3) {
        asmstate = "damage_2@pain";
    } else {
        asmstate = "damage_1@pain";
    }
    self asmrequestsubstate(asmstate);
    self vehicle_ai::waittill_asm_complete(asmstate, 1.5);
    self setbrake(0);
    self vehicle_ai::evaluate_connections();
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0x531e7823, Offset: 0x19c8
// Size: 0xae
function state_unaware_update(params) {
    self endon(#"death");
    self endon(#"change_state");
    self function_d013f7fa((0, 90, 0), 1);
    self function_d013f7fa((0, 90, 0), 2);
    self thread function_ef0b7db5();
    while (true) {
        self vehicle_ai::evaluate_connections();
        wait 1;
    }
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0xdbd161e6, Offset: 0x1a80
// Size: 0x12c
function function_ef0b7db5() {
    self endon(#"death");
    self endon(#"change_state");
    self notify(#"end_movement_thread");
    self endon(#"end_movement_thread");
    while (true) {
        self.current_pathto_pos = self function_d92aa446();
        foundpath = self setvehgoalpos(self.current_pathto_pos, 0, 1);
        if (foundpath) {
            function_59d0ca33();
            self thread path_update_interrupt();
            self vehicle_ai::waittill_pathing_done();
            self notify(#"near_goal");
            self cancelaimove();
            self clearvehgoalpos();
            scan();
        } else {
            wait 1;
        }
        wait 0.05;
    }
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0xb9b783b8, Offset: 0x1bb8
// Size: 0x47e
function function_d92aa446() {
    if (self.goalforced) {
        return self.goalpos;
    }
    minsearchradius = 500;
    maxsearchradius = 1500;
    halfheight = 400;
    spacing = 80;
    queryresult = positionquery_source_navigation(self.origin, minsearchradius, maxsearchradius, halfheight, spacing, self, spacing);
    positionquery_filter_distancetogoal(queryresult, self);
    vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
    forward = anglestoforward(self.angles);
    foreach (point in queryresult.data) {
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:x28>"] = randomfloatrange(0, 30);
        #/
        point.score += randomfloatrange(0, 30);
        pointdirection = vectornormalize(point.origin - self.origin);
        factor = vectordot(pointdirection, forward);
        if (factor > 0.7) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x2f>"] = 600;
            #/
            point.score += 600;
            continue;
        }
        if (factor > 0) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x2f>"] = 0;
            #/
            point.score += 0;
            continue;
        }
        if (factor > -0.5) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x2f>"] = -600;
            #/
            point.score += -600;
            continue;
        }
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:x2f>"] = -1200;
        #/
        point.score += -1200;
    }
    vehicle_ai::positionquery_postprocess_sortscore(queryresult);
    self vehicle_ai::positionquery_debugscores(queryresult);
    if (queryresult.data.size == 0) {
        return self.origin;
    }
    return queryresult.data[0].origin;
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0x8d329172, Offset: 0x2040
// Size: 0x44
function function_84e7c9e7() {
    if (isdefined(self.jump) && isdefined(self.jump.linkent)) {
        self.jump.linkent delete();
    }
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0x6bfe5641, Offset: 0x2090
// Size: 0x3c
function function_e377aade(enttowatch) {
    self endon(#"death");
    enttowatch waittill(#"death");
    self delete();
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0xe5a2e152, Offset: 0x20d8
// Size: 0x12c
function function_5a6e3cac() {
    if (isdefined(self.jump)) {
        self unlink();
        self.jump.linkent delete();
        self.jump delete();
    }
    self.jump = spawnstruct();
    self.jump.linkent = spawn("script_origin", self.origin);
    self.jump.linkent thread function_e377aade(self);
    self.jump.in_air = 0;
    self.jump.var_6829bbf7 = struct::get_array("balcony_point");
    self.jump.groundpoints = struct::get_array("ground_point");
}

// Namespace siegebot
// Params 3, eflags: 0x0
// Checksum 0x497c1b8d, Offset: 0x2210
// Size: 0x48
function function_ccaeca3(from_state, to_state, connection) {
    if (isdefined(self.nojumping) && self.nojumping) {
        return false;
    }
    return self.vehicletype === "spawner_enemy_boss_siegebot_zombietron";
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0xcf3dbca, Offset: 0x2260
// Size: 0x1e4
function function_bf7dfc58(params) {
    goal = params.var_dbe18cc;
    trace = physicstrace(goal + (0, 0, 500), goal - (0, 0, 10000), (-10, -10, -10), (10, 10, 10), self, 2);
    if (false) {
        /#
            debugstar(goal, 60000, (0, 1, 0));
        #/
        /#
            debugstar(trace["<dev string:x3d>"], 60000, (0, 1, 0));
        #/
        /#
            line(goal, trace["<dev string:x3d>"], (0, 1, 0), 1, 0, 60000);
        #/
    }
    if (trace["fraction"] < 1) {
        goal = trace["position"];
    }
    self.jump.goal = goal;
    params.var_bc1a4954 = 40;
    params.var_a1e09ed6 = (0, 0, -6);
    params.var_3a388f84 = 50;
    params.var_fb532e19 = "land@jump";
    self function_d56305c8(0);
    self function_144b90e8();
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0xe9dc6dc4, Offset: 0x2450
// Size: 0xbfc
function function_911f1aa5(params) {
    self endon(#"change_state");
    self endon(#"death");
    goal = self.jump.goal;
    self face_target(goal);
    self.jump.linkent.origin = self.origin;
    self.jump.linkent.angles = self.angles;
    wait 0.05;
    self linkto(self.jump.linkent);
    self.jump.in_air = 1;
    if (false) {
        /#
            debugstar(goal, 60000, (0, 1, 0));
        #/
        /#
            debugstar(goal + (0, 0, 100), 60000, (0, 1, 0));
        #/
        /#
            line(goal, goal + (0, 0, 100), (0, 1, 0), 1, 0, 60000);
        #/
    }
    totaldistance = distance2d(goal, self.jump.linkent.origin);
    forward = (((goal - self.jump.linkent.origin) / totaldistance)[0], ((goal - self.jump.linkent.origin) / totaldistance)[1], 0);
    var_a2961d4 = mapfloat(500, 2000, 46, 52, totaldistance);
    var_920c55a7 = 0;
    var_f1e5d209 = (0, 0, 1) * (var_a2961d4 + params.var_3a388f84);
    var_e6651399 = forward * params.var_bc1a4954 * mapfloat(500, 2000, 0.8, 1, totaldistance);
    velocity = var_f1e5d209 + var_e6651399;
    if (self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
        self asmsetanimationrate(1);
    }
    self asmrequestsubstate("inair@jump");
    self waittill(#"engine_startup");
    self vehicle::impact_fx(self.settings.var_2ba72ce7);
    self waittill(#"leave_ground");
    self vehicle::impact_fx(self.settings.var_f209c6c6);
    while (true) {
        distancetogoal = distance2d(self.jump.linkent.origin, goal);
        var_570dcf42 = 1;
        var_7e526cf9 = 1;
        var_8ef0e611 = (0, 0, 0);
        if (false) {
            /#
                line(self.jump.linkent.origin, self.jump.linkent.origin + var_8ef0e611, (0, 1, 0), 1, 0, 60000);
            #/
        }
        var_8a7223d3 = mapfloat(self.radius * 1, self.radius * 4, 0.2, 1, distancetogoal);
        var_9fc4c6cf = var_e6651399 * var_8a7223d3;
        if (false) {
            /#
                line(self.jump.linkent.origin, self.jump.linkent.origin + var_9fc4c6cf, (0, 1, 0), 1, 0, 60000);
            #/
        }
        var_588fc985 = velocity[2];
        velocity = (0, 0, velocity[2]);
        velocity += var_9fc4c6cf + params.var_a1e09ed6 + var_8ef0e611;
        if (var_588fc985 > 0 && velocity[2] < 0) {
            self asmrequestsubstate("fall@jump");
        }
        if (velocity[2] < 0 && self.jump.linkent.origin[2] + velocity[2] < goal[2]) {
            break;
        }
        var_f44f4d9 = goal[2] + 110;
        var_55f62e61 = self.jump.linkent.origin[2];
        self.jump.linkent.origin += velocity;
        if (var_588fc985 > 0 && (var_55f62e61 > var_f44f4d9 || self.jump.linkent.origin[2] < var_f44f4d9 && velocity[2] < 0)) {
            self notify(#"start_landing");
            self asmrequestsubstate(params.var_fb532e19);
        }
        if (false) {
            /#
                debugstar(self.jump.linkent.origin, 60000, (1, 0, 0));
            #/
        }
        wait 0.05;
    }
    self.jump.linkent.origin = (self.jump.linkent.origin[0], self.jump.linkent.origin[1], 0) + (0, 0, goal[2]);
    self notify(#"land_crush");
    foreach (player in level.players) {
        player.var_31d70948 = player.takedamage;
        player.takedamage = 0;
    }
    self radiusdamage(self.origin + (0, 0, 15), self.radiusdamageradius, self.radiusdamagemax, self.radiusdamagemin, self, "MOD_EXPLOSIVE");
    foreach (player in level.players) {
        player.takedamage = player.var_31d70948;
        player.var_31d70948 = undefined;
        if (distance2dsquared(self.origin, player.origin) < -56 * -56) {
            direction = ((player.origin - self.origin)[0], (player.origin - self.origin)[1], 0);
            if (abs(direction[0]) < 0.01 && abs(direction[1]) < 0.01) {
                direction = (randomfloatrange(1, 2), randomfloatrange(1, 2), 0);
            }
            direction = vectornormalize(direction);
            strength = 700;
            player setvelocity(player getvelocity() + direction * strength);
            if (player.health > 80) {
                player dodamage(player.health - 70, self.origin, self);
            }
        }
    }
    self vehicle::impact_fx(self.settings.var_9f4c9669);
    self function_144b90e8();
    wait 0.3;
    self unlink();
    wait 0.05;
    self.jump.in_air = 0;
    self notify(#"jump_finished");
    vehicle_ai::cooldown("jump", 7);
    self vehicle_ai::waittill_asm_complete(params.var_fb532e19, 3);
    self vehicle_ai::evaluate_connections();
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0x33416f3a, Offset: 0x3058
// Size: 0xc
function function_309fca92(params) {
    
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0xcda706ae, Offset: 0x3070
// Size: 0x64
function state_combat_update(params) {
    self endon(#"death");
    self endon(#"change_state");
    self thread movement_thread();
    self thread function_3a94fda4();
    self thread function_76333d5f();
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0xc2560090, Offset: 0x30e0
// Size: 0x3c
function state_combat_exit(params) {
    self clearturrettarget();
    self setturretspinning(0);
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0x67420718, Offset: 0x3128
// Size: 0x54
function function_59d0ca33() {
    if (self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
        self asmsetanimationrate(0.5);
    }
    self asmrequestsubstate("locomotion@movement");
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0x2c6f91ac, Offset: 0x3188
// Size: 0x476
function getnextmoveposition_tactical() {
    if (self.goalforced) {
        return self.goalpos;
    }
    maxsearchradius = 800;
    halfheight = 400;
    innerspacing = 50;
    outerspacing = 60;
    queryresult = positionquery_source_navigation(self.origin, 0, maxsearchradius, halfheight, innerspacing, self, outerspacing);
    positionquery_filter_distancetogoal(queryresult, self);
    vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
    if (isdefined(self.enemy)) {
        positionquery_filter_sight(queryresult, self.enemy.origin, self geteye() - self.origin, self, 0, self.enemy);
        self vehicle_ai::positionquery_filter_engagementdist(queryresult, self.enemy, self.settings.engagementdistmin, self.settings.engagementdistmax);
    }
    foreach (point in queryresult.data) {
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:x28>"] = randomfloatrange(0, 30);
        #/
        point.score += randomfloatrange(0, 30);
        if (point.disttoorigin2d < 120) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x46>"] = (120 - point.disttoorigin2d) * -1.5;
            #/
            point.score += (120 - point.disttoorigin2d) * -1.5;
        }
        if (isdefined(self.enemy)) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x55>"] = point.distawayfromengagementarea * -1;
            #/
            point.score += point.distawayfromengagementarea * -1;
            if (!point.visibility) {
                /#
                    if (!isdefined(point._scoredebug)) {
                        point._scoredebug = [];
                    }
                    point._scoredebug["<dev string:x64>"] = -600;
                #/
                point.score += -600;
            }
        }
    }
    vehicle_ai::positionquery_postprocess_sortscore(queryresult);
    self vehicle_ai::positionquery_debugscores(queryresult);
    if (queryresult.data.size == 0) {
        return self.origin;
    }
    return queryresult.data[0].origin;
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0xaefbeb5c, Offset: 0x3608
// Size: 0x484
function path_update_interrupt() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"near_goal");
    self endon(#"reached_end_node");
    var_9da987db = 0;
    old_enemy = self.enemy;
    startpath = gettime();
    old_origin = self.origin;
    var_755108a1 = 300;
    wait 1.5;
    while (true) {
        self setmaxspeedscale(1);
        self setmaxaccelerationscale(1);
        self setspeed(self.settings.defaultmovespeed);
        if (isdefined(self.enemy)) {
            selfdisttotarget = distance2d(self.origin, self.enemy.origin);
            var_5b28a10d = self.settings.engagementdistmax + -106;
            var_9f7fb26 = self.settings.engagementdistmin - -106;
            if (self function_4246bc05(self.enemy)) {
                self setlookatent(self.enemy);
                self setturrettargetent(self.enemy);
                if (selfdisttotarget < var_5b28a10d && selfdisttotarget > var_9f7fb26) {
                    var_9da987db++;
                    if (vehicle_ai::timesince(startpath) > 5 || var_9da987db > 3 && distance2dsquared(old_origin, self.origin) > var_755108a1 * var_755108a1) {
                        self notify(#"near_goal");
                    }
                } else {
                    self setmaxspeedscale(2.5);
                    self setmaxaccelerationscale(3);
                    self setspeed(self.settings.defaultmovespeed * 2);
                }
            } else if (!self function_6d424c6f(self.enemy, 1.5) && self function_6d424c6f(self.enemy, 15) || selfdisttotarget > var_5b28a10d) {
                self setmaxspeedscale(1.8);
                self setmaxaccelerationscale(2);
                self setspeed(self.settings.defaultmovespeed * 1.5);
            }
        } else {
            var_9da987db = 0;
        }
        if (isdefined(self.enemy)) {
            if (!isdefined(old_enemy)) {
                self notify(#"near_goal");
            } else if (self.enemy != old_enemy) {
                self notify(#"near_goal");
            }
            if (self function_4246bc05(self.enemy) && distance2dsquared(self.origin, self.enemy.origin) < -106 * -106 && distance2dsquared(old_origin, self.enemy.origin) > -105 * -105) {
                self notify(#"near_goal");
            }
        }
        wait 0.2;
    }
}

// Namespace siegebot
// Params 2, eflags: 0x0
// Checksum 0x6e1228f8, Offset: 0x3a98
// Size: 0x84
function function_92467705(isopen, waittime) {
    if (!isdefined(waittime)) {
        waittime = 0;
    }
    self endon(#"death");
    self notify(#"hash_92467705");
    self endon(#"hash_92467705");
    if (isdefined(waittime) && waittime > 0) {
        wait waittime;
    }
    self vehicle::toggle_ambient_anim_group(1, isopen);
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0xde78561, Offset: 0x3b28
// Size: 0x2d8
function movement_thread() {
    self endon(#"death");
    self endon(#"change_state");
    self notify(#"end_movement_thread");
    self endon(#"end_movement_thread");
    while (true) {
        self.current_pathto_pos = self getnextmoveposition_tactical();
        if (self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
            if (vehicle_ai::iscooldownready("jump")) {
                params = spawnstruct();
                params.var_dbe18cc = self.current_pathto_pos;
                function_59d0ca33();
                wait 0.5;
                self vehicle_ai::evaluate_connections(undefined, params);
                wait 0.5;
            }
        }
        foundpath = self setvehgoalpos(self.current_pathto_pos, 0, 1);
        if (foundpath) {
            if (isdefined(self.enemy) && self function_6d424c6f(self.enemy, 1)) {
                self setlookatent(self.enemy);
                self setturrettargetent(self.enemy);
            }
            function_59d0ca33();
            self thread path_update_interrupt();
            self vehicle_ai::waittill_pathing_done();
            self notify(#"near_goal");
            self cancelaimove();
            self clearvehgoalpos();
            if (isdefined(self.enemy) && self function_6d424c6f(self.enemy, 2)) {
                self face_target(self.enemy.origin);
            }
        }
        wait 1;
        var_2d0a77d9 = gettime();
        while (isdefined(self.enemy) && self function_4246bc05(self.enemy) && vehicle_ai::timesince(var_2d0a77d9) < 1.5) {
            wait 0.4;
        }
    }
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0x8151b83d, Offset: 0x3e08
// Size: 0x94
function function_144b90e8() {
    self notify(#"end_movement_thread");
    self notify(#"near_goal");
    self cancelaimove();
    self clearvehgoalpos();
    self clearturrettarget();
    self clearlookatent();
    self setbrake(1);
}

// Namespace siegebot
// Params 2, eflags: 0x0
// Checksum 0xae034a3d, Offset: 0x3ea8
// Size: 0x20c
function face_target(position, var_cd8c9d1a) {
    if (!isdefined(var_cd8c9d1a)) {
        var_cd8c9d1a = 30;
    }
    v_to_enemy = ((position - self.origin)[0], (position - self.origin)[1], 0);
    v_to_enemy = vectornormalize(v_to_enemy);
    goalangles = vectortoangles(v_to_enemy);
    anglediff = absangleclamp180(self.angles[1] - goalangles[1]);
    if (anglediff <= var_cd8c9d1a) {
        return;
    }
    self function_b4518657(position);
    self setturrettargetvec(position);
    self function_59d0ca33();
    var_278525e3 = gettime();
    while (anglediff > var_cd8c9d1a && vehicle_ai::timesince(var_278525e3) < 4) {
        anglediff = absangleclamp180(self.angles[1] - goalangles[1]);
        wait 0.05;
    }
    self clearvehgoalpos();
    self clearlookatent();
    self clearturrettarget();
    self cancelaimove();
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0x83a4e11c, Offset: 0x40c0
// Size: 0x24c
function scan() {
    angles = self gettagangles("tag_barrel");
    angles = (0, angles[1], 0);
    rotate = 360;
    while (rotate > 0) {
        angles += (0, 30, 0);
        rotate -= 30;
        forward = anglestoforward(angles);
        aimpos = self.origin + forward * 1000;
        self setturrettargetvec(aimpos);
        msg = self util::waittill_any_timeout(0.5, "turret_on_target");
        wait 0.1;
        if (isdefined(self.enemy) && self function_4246bc05(self.enemy)) {
            self setturrettargetent(self.enemy);
            self setlookatent(self.enemy);
            self face_target(self.enemy);
            return;
        }
    }
    forward = anglestoforward(self.angles);
    aimpos = self.origin + forward * 1000;
    self setturrettargetvec(aimpos);
    msg = self util::waittill_any_timeout(3, "turret_on_target");
    self clearturrettarget();
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0x5cc1613c, Offset: 0x4318
// Size: 0x270
function function_3a94fda4() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"end_attack_thread");
    self notify(#"hash_eda479de");
    self endon(#"hash_eda479de");
    self.turretrotscale = 1 * self.var_cf0b2b03;
    spinning = 0;
    while (true) {
        if (isdefined(self.enemy) && self function_4246bc05(self.enemy)) {
            self setlookatent(self.enemy);
            self setturrettargetent(self.enemy);
            if (!spinning) {
                spinning = 1;
                self setturretspinning(1);
                wait 0.5;
                continue;
            }
            self function_9af49228(self.enemy, (0, 0, 0), 0);
            self function_9af49228(self.enemy, (0, 0, 0), 1);
            self vehicle_ai::fire_for_time(randomfloatrange(0.75, 1.5) * self.var_cf0b2b03, 1);
            if (isdefined(self.enemy) && isai(self.enemy)) {
                wait randomfloatrange(0.1, 0.2);
            } else {
                wait randomfloatrange(0.2, 0.3) * self.var_e8674008;
            }
            continue;
        }
        spinning = 0;
        self setturretspinning(0);
        self function_bb5f9faa(0);
        self function_bb5f9faa(1);
        wait 0.4;
    }
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0x70f825f0, Offset: 0x4590
// Size: 0xc4
function function_b04ee378(target) {
    if (isdefined(target)) {
        self setturrettargetent(target);
        self function_9af49228(target, (0, 0, -10), 2);
        msg = self util::waittill_any_timeout(1, "turret_on_target");
        self fireweapon(2, target, (0, 0, -10));
        self function_bb5f9faa(1);
    }
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0x84511bb4, Offset: 0x4660
// Size: 0x230
function function_76333d5f() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"end_attack_thread");
    self notify(#"hash_77eb1a59");
    self endon(#"hash_77eb1a59");
    vehicle_ai::cooldown("rocket", 3);
    while (true) {
        if (isdefined(self.enemy) && self function_6d424c6f(self.enemy, 3) && vehicle_ai::iscooldownready("rocket", 1.5)) {
            self function_9af49228(self.enemy, (0, 0, 0), 0);
            self function_9af49228(self.enemy, (0, 0, -10), 2);
            self thread function_92467705(1);
            wait 1.5;
            if (isdefined(self.enemy) && self function_6d424c6f(self.enemy, 1)) {
                vehicle_ai::cooldown("rocket", 5);
                function_b04ee378(self.enemy);
                wait 1;
                if (isdefined(self.enemy)) {
                    function_b04ee378(self.enemy);
                }
                self thread function_92467705(0, 1);
            } else {
                self thread function_92467705(0);
            }
            continue;
        }
        self function_bb5f9faa(0);
        self function_bb5f9faa(1);
        wait 0.4;
    }
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0xac12294d, Offset: 0x4898
// Size: 0x78
function function_916a796c() {
    self endon(#"death");
    player = undefined;
    while (true) {
        self function_430d01a3(player);
        self waittill(#"enter_vehicle", player);
        self vehicle_occupied(player);
        self waittill(#"exit_vehicle", player);
    }
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0xf44a11a7, Offset: 0x4918
// Size: 0x17c
function vehicle_occupied(player) {
    self clientfield::set("enemyvehicle", 1);
    /#
    #/
    self.ignoreme = 0;
    self thread function_5beec115();
    self thread function_92467705(1);
    self thread function_b2e25d35();
    self thread function_f4b605de();
    if (isplayer(player)) {
        player.var_4c98b889 = 1;
        player.ignoreme = 1;
        self.var_ec643db5 = player;
        player setclientuivisibilityflag("weapon_hud_visible", 0);
        player vehicle::update_damage_as_occupant(self.maxhealth - self.health, self.maxhealth);
        player disableweaponcycling();
        self thread function_a8ed4a70(player);
        self function_909adbe5();
    }
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0xc3d14d43, Offset: 0x4aa0
// Size: 0xde
function function_430d01a3(player) {
    self clientfield::set("enemyvehicle", 0);
    self.ignoreme = 1;
    self thread function_92467705(0);
    if (isplayer(player)) {
        player.var_4c98b889 = undefined;
        player.ignoreme = 0;
        player setclientuivisibilityflag("weapon_hud_visible", 1);
        player enableweaponcycling();
        function_89c55bf4(player, 0);
    }
    self.var_ec643db5 = undefined;
}

// Namespace siegebot
// Params 15, eflags: 0x0
// Checksum 0x78f443ee, Offset: 0x4b88
// Size: 0x2f8
function function_3b05fc1b(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    time_alive = gettime() - self.spawntime;
    if (time_alive < 500 && smeansofdeath == "MOD_TRIGGER_HURT") {
        return 0;
    }
    idamage = self killstreaks::ondamageperweapon("siegebot", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, 0, undefined, 1, 1);
    fmj = loadout::isfmjdamage(weapon, smeansofdeath, eattacker);
    if (isdefined(fmj) && fmj) {
        idamage /= 2;
    }
    if (vehicle_ai::should_emp(self, weapon, smeansofdeath, einflictor, eattacker)) {
        minempdowntime = 0.8 * self.settings.empdowntime;
        maxempdowntime = 1.2 * self.settings.empdowntime;
        self notify(#"emped", randomfloatrange(minempdowntime, maxempdowntime), eattacker, einflictor);
    }
    if (!isdefined(self.damagelevel)) {
        self.damagelevel = 0;
    }
    newdamagelevel = vehicle::should_update_damage_fx_level(self.health, idamage, self.healthdefault);
    if (newdamagelevel > self.damagelevel) {
        self.damagelevel = newdamagelevel;
        vehicle::set_damage_fx_level(self.damagelevel);
    }
    driver = self getseatoccupant(0);
    if (isplayer(driver)) {
        driver vehicle::update_damage_as_occupant(self.maxhealth - self.health - idamage, self.maxhealth);
    }
    return idamage;
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0x806a1203, Offset: 0x4e88
// Size: 0x68
function function_d0c5071a() {
    self endon(#"death");
    while (true) {
        self waittill(#"emped", down_time, attacker, inflictor);
        self thread emped(down_time);
    }
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0x15887bc, Offset: 0x4ef8
// Size: 0xac
function emped(down_time) {
    self notify(#"hash_1576e3ac");
    self endon(#"death");
    self endon(#"hash_1576e3ac");
    self setbrake(1);
    self.emped = 1;
    self function_909adbe5();
    wait down_time;
    self setbrake(0);
    self.emped = 0;
    self function_909adbe5();
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0x5dfe0ad0, Offset: 0x4fb0
// Size: 0x34
function function_909adbe5() {
    function_89c55bf4(self getseatoccupant(0), self.emped);
}

// Namespace siegebot
// Params 2, eflags: 0x0
// Checksum 0xcf0a52fc, Offset: 0x4ff0
// Size: 0xb4
function function_89c55bf4(driver, emped) {
    if (isplayer(driver)) {
        value = isdefined(emped) ? emped : 0 ? 1 : 0;
        driver clientfield::set_to_player("empd", value);
        driver clientfield::set_to_player("static_postfx", value);
        driver setempjammed(value);
    }
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0xcb490c1d, Offset: 0x50b0
// Size: 0x54
function watch_game_ended() {
    self endon(#"death");
    level waittill(#"game_ended");
    self thread function_23b7fd8f(3);
    self function_8a453ed4();
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0xf67de96e, Offset: 0x5110
// Size: 0x54
function function_8a453ed4() {
    self dodamage(self.health + 1, self.origin + (0, 0, 60), undefined, undefined, "none", "MOD_EXPLOSIVE", 0);
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0xb55edf6b, Offset: 0x5170
// Size: 0x2c
function function_23b7fd8f(wait_time) {
    wait wait_time;
    if (isdefined(self)) {
        self hide();
    }
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0x7695dbed, Offset: 0x51a8
// Size: 0xfc
function watch_death() {
    self notify(#"hash_9c901cd6");
    self endon(#"hash_9c901cd6");
    self waittill(#"death");
    if (isplayer(self.var_ec643db5)) {
        self function_430d01a3(self.var_ec643db5);
    }
    streamermodelhint(self.deathmodel, 6);
    self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
    self vehicle::do_death_dynents();
    self vehicle_death::death_radius_damage();
    self vehicle_death::deletewhensafe(0.25);
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0x3017cb01, Offset: 0x52b0
// Size: 0xfc
function reload_rockets(player) {
    bundle = level.killstreakbundle["siegebot"];
    self function_624413d();
    weapon_wait_duration_ms = int(bundle.ksweaponreloadtime * 1000);
    player setvehicleweaponwaitduration(weapon_wait_duration_ms);
    player setvehicleweaponwaitendtime(gettime() + weapon_wait_duration_ms);
    wait bundle.ksweaponreloadtime;
    self function_526fb1ce(3);
    wait 0.4;
    if (!self.isstunned) {
        self function_59477890();
    }
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0x8af3886d, Offset: 0x53b8
// Size: 0x34
function function_526fb1ce(rocket_count) {
    self.numberrockets = rocket_count;
    self update_client_ammo(self.numberrockets);
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0xc6451684, Offset: 0x53f8
// Size: 0x2c
function function_59477890() {
    self.var_f9eb37d1 = 0;
    self disablegunnerfiring(1, 0);
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0x4bec5653, Offset: 0x5430
// Size: 0x2c
function function_624413d() {
    self.var_f9eb37d1 = 1;
    self disablegunnerfiring(1, 1);
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0x6744563, Offset: 0x5468
// Size: 0x110
function function_a8ed4a70(player) {
    self endon(#"death");
    self endon(#"exit_vehicle");
    if (self.numberrockets <= 0) {
        self reload_rockets(player);
    } else {
        self update_client_ammo(self.numberrockets);
    }
    if (!self.isstunned) {
        self function_59477890();
    }
    while (true) {
        player waittill(#"missile_fire", missile);
        missile.ignore_team_kills = self.ignore_team_kills;
        self function_526fb1ce(self.numberrockets - 1);
        if (self.numberrockets <= 0) {
            self reload_rockets(player);
        }
    }
}

// Namespace siegebot
// Params 2, eflags: 0x0
// Checksum 0x15c238f1, Offset: 0x5580
// Size: 0x8c
function update_client_ammo(ammo_count, driver_only_update) {
    if (!isdefined(driver_only_update)) {
        driver_only_update = 0;
    }
    if (!driver_only_update) {
        self clientfield::set("ai_tank_missile_fire", ammo_count);
    }
    if (isplayer(self.var_ec643db5)) {
        self.var_ec643db5 clientfield::increment_to_player("ai_tank_update_hud", 1);
    }
}

/#

    // Namespace siegebot
    // Params 0, eflags: 0x0
    // Checksum 0xa3c64d5, Offset: 0x5618
    // Size: 0xb6
    function function_39ea378c() {
        self notify(#"hash_39ea378c");
        self endon(#"hash_39ea378c");
        level endon(#"game_ended");
        delay = 10;
        while (true) {
            self thread function_5c502497();
            self thread function_d12a9af0();
            wait delay;
            self thread function_ffe3f04();
            self thread function_ce4c51d5();
            wait delay;
        }
    }

#/

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0xa635c211, Offset: 0x56d8
// Size: 0xc4
function function_5c502497() {
    if (!isdefined(self.var_98333a80)) {
        self.var_98333a80 = 0;
    }
    if (self.var_98333a80) {
        return;
    }
    self.var_98333a80 = 1;
    self useanimtree(#generic);
    self clientfield::set("siegebot_retract_left_arm", 1);
    self clearanim(generic%ai_siegebot_base_mp_left_arm_extend, 0.2);
    self setanim(generic%ai_siegebot_base_mp_left_arm_retract, 1);
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0xc62385b, Offset: 0x57a8
// Size: 0x10c
function function_ffe3f04() {
    if (!isdefined(self.var_98333a80)) {
        self.var_98333a80 = 0;
    }
    if (!self.var_98333a80) {
        return;
    }
    self.var_98333a80 = 0;
    self useanimtree(#generic);
    self clientfield::set("siegebot_retract_left_arm", 0);
    self clearanim(generic%ai_siegebot_base_mp_left_arm_retract, 0.2);
    self setanim(generic%ai_siegebot_base_mp_left_arm_extend, 1, 0);
    wait 0.1;
    if (self.var_98333a80 == 0) {
        self clearanim(generic%ai_siegebot_base_mp_left_arm_extend, 0.1);
    }
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0xf8e5f4ab, Offset: 0x58c0
// Size: 0xc4
function function_d12a9af0() {
    if (!isdefined(self.var_14670f4f)) {
        self.var_14670f4f = 0;
    }
    if (self.var_14670f4f) {
        return;
    }
    self.var_14670f4f = 1;
    self useanimtree(#generic);
    self clientfield::set("siegebot_retract_right_arm", 1);
    self clearanim(generic%ai_siegebot_base_mp_right_arm_extend, 0.2);
    self setanim(generic%ai_siegebot_base_mp_right_arm_retract, 1);
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0xd4917d2c, Offset: 0x5990
// Size: 0x104
function function_ce4c51d5() {
    if (!isdefined(self.var_14670f4f)) {
        self.var_14670f4f = 0;
    }
    if (!self.var_14670f4f) {
        return;
    }
    self.var_14670f4f = 0;
    self useanimtree(#generic);
    self clientfield::set("siegebot_retract_right_arm", 0);
    self clearanim(generic%ai_siegebot_base_mp_right_arm_retract, 0.2);
    self setanim(generic%ai_siegebot_base_mp_right_arm_extend, 1);
    wait 0.1;
    if (self.var_14670f4f == 0) {
        self clearanim(generic%ai_siegebot_base_mp_right_arm_extend, 0.1);
    }
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0x6fd2b5f0, Offset: 0x5aa0
// Size: 0x1c8
function function_b2e25d35() {
    self endon(#"death");
    self endon(#"exit_vehicle");
    wait randomfloatrange(0.05, 0.3);
    while (true) {
        var_c33c5d95 = self gettagorigin("tag_turret");
        var_f49e0cbb = self gettagangles("tag_turret");
        forward = anglestoforward(var_f49e0cbb);
        right = anglestoright(var_f49e0cbb);
        var_c33c5d95 += right * -60;
        trace_start = var_c33c5d95 + forward * 40;
        trace_end = var_c33c5d95 + forward * -30;
        trace = physicstrace(trace_start, trace_end, (-8, -8, -8), (8, 8, 8), self, 1 | 8);
        if (trace["fraction"] < 1) {
            self function_5c502497();
        } else {
            self function_ffe3f04();
        }
        wait 0.2;
    }
}

// Namespace siegebot
// Params 0, eflags: 0x0
// Checksum 0xc6d73411, Offset: 0x5c70
// Size: 0x1c8
function function_f4b605de() {
    self endon(#"death");
    self endon(#"exit_vehicle");
    wait randomfloatrange(0.05, 0.3);
    while (true) {
        var_c33c5d95 = self gettagorigin("tag_turret");
        var_f49e0cbb = self gettagangles("tag_turret");
        forward = anglestoforward(var_f49e0cbb);
        right = anglestoright(var_f49e0cbb);
        var_c33c5d95 += right * 60;
        trace_start = var_c33c5d95 + forward * 40;
        trace_end = var_c33c5d95 + forward * -30;
        trace = physicstrace(trace_start, trace_end, (-8, -8, -8), (8, 8, 8), self, 1 | 8);
        if (trace["fraction"] < 1) {
            self function_d12a9af0();
        } else {
            self function_ce4c51d5();
        }
        wait 0.2;
    }
}

// Namespace siegebot
// Params 1, eflags: 0x0
// Checksum 0x41c2a5c8, Offset: 0x5e40
// Size: 0x32c
function function_39a73cfe(var_25aad16e) {
    if (var_25aad16e && isdefined(self.var_6a8ffa0d)) {
        var_89bbb25e = self gettagangles("tag_turret");
        var_39329f2c = anglestoforward(var_89bbb25e);
        var_4d5dd8a9 = anglestoright(var_89bbb25e);
        var_98f9d946 = anglestoup(var_89bbb25e);
        offset = self.var_6a8ffa0d;
        var_c33c5d95 = self.origin + offset[0] * var_39329f2c + offset[1] * var_4d5dd8a9 + offset[2] * var_98f9d946;
        var_f49e0cbb = var_89bbb25e + self.var_94a7a823;
    } else {
        var_c33c5d95 = self gettagorigin("tag_gunner_flash2b");
        var_f49e0cbb = self gettagangles("tag_gunner_flash2b");
    }
    forward = anglestoforward(var_f49e0cbb);
    trace_start = var_c33c5d95 + forward * 12;
    trace_end = var_c33c5d95 + forward * -12;
    trace = physicstrace(trace_start, trace_end, (-2, -2, -2), (2, 2, 2), self, 1 | 8);
    var_c6cd5f6b = trace["fraction"] < 1;
    if (var_c6cd5f6b) {
        if (!isdefined(var_89bbb25e)) {
            var_89bbb25e = self gettagangles("tag_turret");
            var_39329f2c = anglestoforward(var_89bbb25e);
            var_4d5dd8a9 = anglestoright(var_89bbb25e);
            var_98f9d946 = anglestoup(var_89bbb25e);
        }
        var_49319ee6 = var_c33c5d95 - self.origin;
        self.var_6a8ffa0d = (vectordot(var_49319ee6, var_39329f2c), vectordot(var_49319ee6, var_4d5dd8a9), vectordot(var_49319ee6, var_98f9d946));
        self.var_94a7a823 = var_f49e0cbb - var_89bbb25e;
    }
    return var_c6cd5f6b;
}

