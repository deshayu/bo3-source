#using scripts/codescripts/struct;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_gibs;
#using scripts/cp/doa/_doa_hazard;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_utility;
#using scripts/cp/gametypes/_globallogic_score;
#using scripts/shared/ai/archetype_locomotion_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/math_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#using_animtree("generic");

#namespace doa_enemy;

// Namespace doa_enemy
// Params 0, eflags: 0x1 linked
// Checksum 0x929ea01d, Offset: 0xa98
// Size: 0x48
function init() {
    level registerdefaultnotetrackhandlerfunctions();
    level registerbehaviorscriptfunctions();
    level.doa.var_25eb370 = [];
}

// Namespace doa_enemy
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xae8
// Size: 0x4
function registerdefaultnotetrackhandlerfunctions() {
    
}

// Namespace doa_enemy
// Params 0, eflags: 0x1 linked
// Checksum 0xaca98e45, Offset: 0xaf8
// Size: 0x284
function registerbehaviorscriptfunctions() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("doaUpdateToGoal", &doaUpdateToGoal);
    behaviortreenetworkutility::registerbehaviortreescriptapi("doaUpdateSilverbackGoal", &doaUpdateSilverbackGoal);
    behaviortreenetworkutility::registerbehaviortreescriptapi("doaActorShouldMelee", &function_f31da0d1);
    behaviortreenetworkutility::registerbehaviortreescriptapi("doaActorShouldMove", &function_d597e3fc);
    behaviortreenetworkutility::registerbehaviortreescriptapi("doaSilverbackShouldMove", &function_323b0769);
    behaviortreenetworkutility::registerbehaviortreeaction("doaMeleeAction", &doaLocomotionDeathAction, undefined, undefined);
    behaviortreenetworkutility::registerbehaviortreescriptapi("doawasKilledByTesla", &function_f8d04082);
    behaviortreenetworkutility::registerbehaviortreeaction("doaZombieMoveAction", undefined, undefined, undefined);
    behaviortreenetworkutility::registerbehaviortreeaction("doaZombieIdleAction", undefined, undefined, undefined);
    behaviortreenetworkutility::registerbehaviortreeaction("doaLocomotionDeathAction", &doaLocomotionDeathAction, undefined, undefined);
    behaviortreenetworkutility::registerbehaviortreeaction("doavoidAction", undefined, undefined, undefined);
    behaviortreenetworkutility::registerbehaviortreeaction("zombieTraverseAction", &zombietraverseaction, undefined, &zombietraverseactionterminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("doaZombieTraversalDoesAnimationExist", &doaZombieTraversalDoesAnimationExist);
    behaviortreenetworkutility::registerbehaviortreeaction("doaSpecialTraverseAction", &function_34a5b8e4, undefined, &function_f821465d);
    animationstatenetwork::registeranimationmocomp("mocomp_doa_special_traversal", &function_e57c0c7b, undefined, &function_c97089da);
}

// Namespace doa_enemy
// Params 1, eflags: 0x1 linked
// Checksum 0x973b01d4, Offset: 0xd88
// Size: 0x3a
function function_f8d04082(behaviortreeentity) {
    if (isdefined(behaviortreeentity.tesla_death) && behaviortreeentity.tesla_death) {
        return true;
    }
    return false;
}

// Namespace doa_enemy
// Params 1, eflags: 0x5 linked
// Checksum 0x520b75be, Offset: 0xdd0
// Size: 0xa2
function private doaZombieTraversalDoesAnimationExist(entity) {
    if (entity.missinglegs === 1) {
        var_be841c75 = entity astsearch(istring("traverse_legless@zombie"));
    } else {
        var_be841c75 = entity astsearch(istring("traverse@zombie"));
    }
    if (isdefined(var_be841c75["animation"])) {
        return true;
    }
    return false;
}

// Namespace doa_enemy
// Params 2, eflags: 0x5 linked
// Checksum 0xb21add4e, Offset: 0xe80
// Size: 0x60
function private function_34a5b8e4(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    entity ghost();
    entity notsolid();
    return 5;
}

// Namespace doa_enemy
// Params 2, eflags: 0x5 linked
// Checksum 0xa285ea83, Offset: 0xee8
// Size: 0x48
function private function_f821465d(entity, asmstatename) {
    entity show();
    entity solid();
    return 4;
}

// Namespace doa_enemy
// Params 5, eflags: 0x5 linked
// Checksum 0x9753f87c, Offset: 0xf38
// Size: 0x1d0
function private function_e57c0c7b(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", entity.angles[1]);
    entity setrepairpaths(0);
    locomotionspeed = blackboard::getblackboardattribute(entity, "_locomotion_speed");
    if (locomotionspeed == "locomotion_speed_walk") {
        rate = 1;
    } else if (locomotionspeed == "locomotion_speed_run") {
        rate = 2;
    } else {
        rate = 3;
    }
    entity asmsetanimationrate(rate);
    if (entity haspath()) {
        entity.var_51ea7126 = entity.pathgoalpos;
    }
    assert(isdefined(entity.traverseendnode));
    entity forceteleport(entity.traverseendnode.origin, entity.angles);
    entity animmode("noclip", 0);
    entity.blockingpain = 1;
}

// Namespace doa_enemy
// Params 5, eflags: 0x5 linked
// Checksum 0x1babbaf1, Offset: 0x1110
// Size: 0xbc
function private function_c97089da(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity.blockingpain = 0;
    entity setrepairpaths(1);
    if (isdefined(entity.var_51ea7126)) {
        entity setgoal(entity.var_51ea7126);
    }
    entity asmsetanimationrate(1);
    entity finishtraversal();
}

// Namespace doa_enemy
// Params 2, eflags: 0x1 linked
// Checksum 0x8ff40ec5, Offset: 0x11d8
// Size: 0x30
function zombietraverseaction(behaviortreeentity, asmstatename) {
    aiutility::traverseactionstart(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace doa_enemy
// Params 2, eflags: 0x1 linked
// Checksum 0xa23f4d61, Offset: 0x1210
// Size: 0x18
function zombietraverseactionterminate(behaviortreeentity, asmstatename) {
    return 4;
}

// Namespace doa_enemy
// Params 2, eflags: 0x0
// Checksum 0xded4b7f6, Offset: 0x1230
// Size: 0x2c
function function_293af6de(animationentity, asmstatename) {
    animationentity melee();
}

// Namespace doa_enemy
// Params 2, eflags: 0x1 linked
// Checksum 0xa19186c8, Offset: 0x1268
// Size: 0x30
function doaLocomotionDeathAction(behaviortreeentity, asmstatename) {
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace doa_enemy
// Params 2, eflags: 0x1 linked
// Checksum 0x92963f34, Offset: 0x12a0
// Size: 0x1ac
function function_d30fe558(origin, force) {
    if (!isdefined(force)) {
        force = 0;
    }
    if (!isdefined(self) || !isdefined(origin)) {
        return;
    }
    if (!isdefined(self.var_99315107)) {
        self.var_99315107 = 0;
    }
    if (force) {
        self.var_99315107 = 0;
    }
    time = gettime();
    var_bea0505e = time > self.var_99315107;
    distsq = distancesquared(self.origin, origin);
    if (distsq < -128 * -128) {
        var_bea0505e = 1;
    }
    if (var_bea0505e) {
        self setgoal(origin, 1);
        frac = math::clamp(distsq / 1000 * 1000, 0, 1);
        if (isdefined(self.zombie_move_speed)) {
            if (isdefined(self.missinglegs) && (self.zombie_move_speed == "walk" || self.missinglegs)) {
                frac += 0.2;
            }
        }
        self.var_99315107 = time + int(frac * 1600);
    }
}

// Namespace doa_enemy
// Params 1, eflags: 0x1 linked
// Checksum 0xf61e3088, Offset: 0x1458
// Size: 0x5cc
function function_b0edb6ef(var_12ebe63d) {
    aiprofile_beginentry("zombieUpdateZigZagGoal");
    shouldrepath = 0;
    if (!shouldrepath && isdefined(self.enemy)) {
        if (!isdefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime()) {
            shouldrepath = 1;
        } else if (distancesquared(self.origin, self.enemy.origin) <= -56 * -56) {
            shouldrepath = 1;
        } else if (isdefined(self.pathgoalpos)) {
            distancetogoalsqr = distancesquared(self.origin, self.pathgoalpos);
            shouldrepath = distancetogoalsqr < 72 * 72;
        }
    }
    if (isdefined(self.keep_moving) && self.keep_moving) {
        if (gettime() > self.keep_moving_time) {
            self.keep_moving = 0;
        }
    }
    if (shouldrepath) {
        goalpos = var_12ebe63d;
        self setgoal(goalpos);
        if (distancesquared(self.origin, goalpos) > -56 * -56) {
            self.keep_moving = 1;
            self.keep_moving_time = gettime() + -6;
            path = self calcapproximatepathtoposition(goalpos, 0);
            /#
                if (getdvarint("<dev string:x28>")) {
                    for (index = 1; index < path.size; index++) {
                        recordline(path[index - 1], path[index], (1, 0.5, 0), "<dev string:x37>", self);
                    }
                }
            #/
            if (isdefined(level._zombiezigzagdistancemin) && isdefined(level._zombiezigzagdistancemax)) {
                min = level._zombiezigzagdistancemin;
                max = level._zombiezigzagdistancemax;
            } else {
                min = 600;
                max = 900;
            }
            deviationdistance = randomintrange(min, max);
            segmentlength = 0;
            for (index = 1; index < path.size; index++) {
                currentseglength = distance(path[index - 1], path[index]);
                if (segmentlength + currentseglength > deviationdistance) {
                    remaininglength = deviationdistance - segmentlength;
                    seedposition = path[index - 1] + vectornormalize(path[index] - path[index - 1]) * remaininglength;
                    /#
                        recordcircle(seedposition, 2, (1, 0.5, 0), "<dev string:x37>", self);
                    #/
                    innerzigzagradius = 0;
                    outerzigzagradius = -56;
                    queryresult = positionquery_source_navigation(seedposition, innerzigzagradius, outerzigzagradius, 0.5 * 72, 16, self, 16);
                    positionquery_filter_inclaimedlocation(queryresult, self);
                    if (queryresult.data.size > 0) {
                        point = queryresult.data[randomint(queryresult.data.size)];
                        self function_d30fe558(point.origin, 1);
                    }
                    break;
                }
                segmentlength += currentseglength;
            }
        }
        if (isdefined(level._zombiezigzagtimemin) && isdefined(level._zombiezigzagtimemax)) {
            mintime = level._zombiezigzagtimemin;
            maxtime = level._zombiezigzagtimemax;
        } else {
            mintime = 3500;
            maxtime = 5500;
        }
        self.nextgoalupdate = gettime() + randomintrange(mintime, maxtime);
    }
    aiprofile_endentry();
}

// Namespace doa_enemy
// Params 1, eflags: 0x1 linked
// Checksum 0x8cc664ea, Offset: 0x1a30
// Size: 0x7b4
function doaUpdateToGoal(behaviortreeentity) {
    if (level flag::get("doa_game_is_over")) {
        behaviortreeentity function_d30fe558(behaviortreeentity.origin);
        return true;
    }
    if (isdefined(behaviortreeentity.doa) && behaviortreeentity.doa.stunned != 0) {
        if (!(isdefined(behaviortreeentity.doa.var_da2f5272) && behaviortreeentity.doa.var_da2f5272)) {
            behaviortreeentity function_d30fe558(behaviortreeentity.doa.original_origin, behaviortreeentity.doa.stunned == 1);
            behaviortreeentity.doa.stunned = 2;
        } else {
            behaviortreeentity function_d30fe558(behaviortreeentity.origin);
        }
        return true;
    }
    if (isdefined(behaviortreeentity.var_8f12ed02)) {
        behaviortreeentity function_d30fe558(behaviortreeentity.var_8f12ed02);
        return true;
    }
    if (!(isdefined(behaviortreeentity.var_2d8174e3) && behaviortreeentity.var_2d8174e3)) {
        poi = namespace_49107f3a::function_1acb8a7c(behaviortreeentity.origin, level.doa.rules.var_187f2874);
        if (isdefined(poi)) {
            behaviortreeentity.doa.poi = poi;
            if (isdefined(poi.var_111c7bbb)) {
                behaviortreeentity function_d30fe558(poi.var_111c7bbb);
            } else {
                behaviortreeentity function_d30fe558(poi.origin);
            }
            return true;
        }
    }
    if (isdefined(behaviortreeentity.enemy)) {
        time = gettime();
        if (!isdefined(behaviortreeentity.var_dc3adfc7)) {
            behaviortreeentity.var_dc3adfc7 = 0;
        }
        if (time > behaviortreeentity.var_dc3adfc7) {
            behaviortreeentity.var_dc3adfc7 = time + 1500;
            if (behaviortreeentity.team == "axis") {
                validtargets = arraycombine(getaiteamarray("team3"), doa_player_utility::function_5eb6e4d1(), 0, 0);
                if (isdefined(level.doa.var_1332e37a) && level.doa.var_1332e37a.size) {
                    validtargets = arraycombine(validtargets, level.doa.var_1332e37a, 0, 0);
                }
                closest = arraygetclosest(behaviortreeentity.origin, validtargets);
            } else if (behaviortreeentity.team == "allies") {
                closest = arraygetclosest(behaviortreeentity.origin, getaiteamarray("axis"));
            }
            if (isdefined(closest) && behaviortreeentity.enemy != closest) {
                if (doa_player_utility::function_5eb6e4d1().size > 1 && isplayer(closest)) {
                    behaviortreeentity.favoriteenemy = closest;
                    behaviortreeentity setpersonalthreatbias(closest, 5000, 1.5);
                } else {
                    distsq = distancesquared(closest.origin, self.origin);
                    if (distsq <= -128 * -128) {
                        behaviortreeentity.favoriteenemy = closest;
                    }
                }
            }
        }
        origin = behaviortreeentity function_69b8254();
        point = getclosestpointonnavmesh(origin, 20, 16);
        if (isdefined(point)) {
            behaviortreeentity.lastknownenemypos = origin;
            if (getdvarint("scr_doa_zigzag_enabled", 0)) {
                behaviortreeentity function_b0edb6ef(behaviortreeentity.lastknownenemypos);
            }
        } else {
            point = getclosestpointonnavmesh(origin, 40, 8);
            if (isdefined(point)) {
                behaviortreeentity.lastknownenemypos = point;
                origin = point;
            } else if (isdefined(behaviortreeentity.lastknownenemypos)) {
                origin = behaviortreeentity.lastknownenemypos;
            }
        }
        behaviortreeentity function_d30fe558(origin);
        return true;
    } else {
        if (behaviortreeentity.team == "team3") {
            return false;
        }
        players = getplayers();
        foreach (player in players) {
            if (!isdefined(player.doa)) {
                continue;
            }
            if (!isalive(player)) {
                continue;
            }
            behaviortreeentity.favoriteenemy = player;
            behaviortreeentity function_d30fe558(behaviortreeentity.favoriteenemy.origin, 1);
            return true;
        }
        if (isdefined(behaviortreeentity.lastknownenemypos)) {
            behaviortreeentity function_d30fe558(behaviortreeentity.lastknownenemypos);
            return true;
        }
    }
    return false;
}

// Namespace doa_enemy
// Params 1, eflags: 0x1 linked
// Checksum 0x5ce536d7, Offset: 0x21f0
// Size: 0x212
function doaUpdateSilverbackGoal(behaviortreeentity) {
    if (isdefined(behaviortreeentity.var_88168473) && behaviortreeentity.var_88168473) {
        return false;
    }
    if (isdefined(behaviortreeentity.enemy)) {
        behaviortreeentity.favoriteenemy = behaviortreeentity.enemy;
        origin = behaviortreeentity function_69b8254();
        point = getclosestpointonnavmesh(origin, 20, 16);
        if (isdefined(point)) {
            behaviortreeentity.lastknownenemypos = origin;
        } else {
            point = getclosestpointonnavmesh(origin, 40, 8);
            if (isdefined(point)) {
                behaviortreeentity.lastknownenemypos = point;
                origin = point;
            } else if (isdefined(behaviortreeentity.lastknownenemypos)) {
                origin = behaviortreeentity.lastknownenemypos;
            }
        }
        behaviortreeentity function_d30fe558(origin);
        return true;
    }
    if (isdefined(behaviortreeentity.var_f4a5c4fe)) {
        point = getclosestpointonnavmesh(behaviortreeentity.var_f4a5c4fe, 20, 16);
        if (isdefined(point)) {
            behaviortreeentity setgoal(behaviortreeentity.var_f4a5c4fe, 1);
        } else {
            behaviortreeentity setgoal(behaviortreeentity.origin, 1);
        }
        behaviortreeentity.var_f4a5c4fe = undefined;
        return true;
    }
    return false;
}

// Namespace doa_enemy
// Params 0, eflags: 0x5 linked
// Checksum 0x215a1a8e, Offset: 0x2410
// Size: 0x100
function private function_f5ef629b() {
    self endon(#"death");
    self endon(#"hash_d96c599c");
    while (level flag::get("doa_round_spawning")) {
        wait 1;
    }
    if (!isdefined(self.zombie_move_speed)) {
        self.zombie_move_speed = "run";
    }
    while (true) {
        left = namespace_49107f3a::function_b99d78c7();
        if (left <= 5) {
            if (self.zombie_move_speed == "walk") {
                self.zombie_move_speed = "run";
            } else if (self.zombie_move_speed == "run") {
                self.zombie_move_speed = "sprint";
            } else {
                return;
            }
        }
        wait randomfloatrange(1, 4);
    }
}

// Namespace doa_enemy
// Params 0, eflags: 0x1 linked
// Checksum 0x343c22d6, Offset: 0x2518
// Size: 0x138
function updatespeed() {
    self thread function_f5ef629b();
    if (isdefined(self.var_2317157c)) {
        self.zombie_move_speed = "crawl";
        return;
    }
    if (isdefined(self.var_4d621ba4)) {
        self.zombie_move_speed = "walk";
        return;
    }
    if (isdefined(self.var_9c10604e)) {
        self.zombie_move_speed = "run";
        return;
    }
    if (isdefined(self.var_72932907)) {
        self.zombie_move_speed = "sprint";
        return;
    }
    rand = randomintrange(level.doa.zombie_move_speed - 25, level.doa.zombie_move_speed + 20);
    if (rand <= 40) {
        self.zombie_move_speed = "walk";
        return;
    }
    if (rand <= 70) {
        self.zombie_move_speed = "run";
        return;
    }
    self.zombie_move_speed = "sprint";
}

// Namespace doa_enemy
// Params 1, eflags: 0x1 linked
// Checksum 0x40117bd1, Offset: 0x2658
// Size: 0x22
function function_d597e3fc(behaviortreeentity) {
    return behaviortreeentity haspath();
}

// Namespace doa_enemy
// Params 1, eflags: 0x1 linked
// Checksum 0xbd629d4c, Offset: 0x2688
// Size: 0x22
function function_323b0769(behaviortreeentity) {
    return behaviortreeentity haspath();
}

// Namespace doa_enemy
// Params 0, eflags: 0x1 linked
// Checksum 0x443a07e, Offset: 0x26b8
// Size: 0x122
function function_69b8254() {
    if (isdefined(self.enemy)) {
        if (isdefined(self.enemy.doa) && isdefined(self.enemy.doa.vehicle)) {
            self.lastknownenemypos = self.enemy.doa.vehicle.origin;
            if (!isdefined(self.lastknownenemypos) && isdefined(self.enemy.doa.vehicle.groundpos)) {
                self.lastknownenemypos = self.enemy.doa.vehicle.groundpos;
            }
            if (isdefined(self.enemy.doa.var_8d2d32e7)) {
                self.lastknownenemypos = self.enemy.doa.var_8d2d32e7;
            }
            return self.lastknownenemypos;
        } else {
            return self.enemy.origin;
        }
    }
    return self.origin;
}

// Namespace doa_enemy
// Params 1, eflags: 0x1 linked
// Checksum 0xcd5e1ed0, Offset: 0x27e8
// Size: 0xfc
function function_f31da0d1(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.enemy)) {
        return false;
    }
    yaw = abs(namespace_49107f3a::getyawtoenemy());
    if (yaw > 45) {
        return false;
    }
    targetorigin = behaviortreeentity function_69b8254();
    if (distancesquared(behaviortreeentity.origin, targetorigin) > 92 * 92) {
        return false;
    }
    if (distance2dsquared(behaviortreeentity.origin, targetorigin) < 2304) {
        return true;
    }
    return false;
}

// Namespace doa_enemy
// Params 15, eflags: 0x1 linked
// Checksum 0x19cea63e, Offset: 0x28f0
// Size: 0x63c
function function_2241fc21(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal) {
    self endon(#"death");
    if (isdefined(eattacker) && isdefined(eattacker.meleedamage)) {
        idamage = eattacker.meleedamage;
    }
    if (self.team == "allies") {
        /#
            namespace_49107f3a::debugmsg("<dev string:x42>" + self.archetype + "<dev string:x53>" + idamage);
        #/
    }
    if (isdefined(self.allowdeath) && self.allowdeath == 0 && idamage >= self.health) {
        idamage = self.health - 1;
    }
    if (isdefined(eattacker) && (isdefined(einflictor) && einflictor.team == self.team || eattacker.team == self.team)) {
        self finishactordamage(einflictor, eattacker, 0, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, surfacetype, surfacenormal);
        return;
    }
    if (isdefined(self.fx) && self.health <= idamage) {
        self thread namespace_eaa992c::turnofffx(self.fx);
        self.fx = undefined;
    }
    if (isdefined(weapon) && isdefined(level.doa.var_7808fc8c[weapon.name])) {
        level [[ level.doa.var_7808fc8c[weapon.name] ]](self, idamage, eattacker, vdir, smeansofdeath, weapon);
    }
    if (!(isdefined(self.boss) && self.boss)) {
        self namespace_fba031c8::function_15a268a6(eattacker, idamage, smeansofdeath, weapon, shitloc, vdir);
    }
    if (smeansofdeath == "MOD_BURNED") {
        /#
            namespace_49107f3a::debugmsg("<dev string:x62>" + idamage + "<dev string:x6e>" + self.health + (idamage > self.health ? "<dev string:x7c>" : "<dev string:x8a>"));
        #/
    }
    if (smeansofdeath == "MOD_CRUSH") {
        if (isdefined(self.boss) && self.boss) {
            idamage = 0;
        } else {
            idamage = self.health;
        }
    }
    if (weapon == level.doa.var_69899304) {
        idamage += int(3 * level.doa.round_number);
    }
    if (isdefined(self.overrideactordamage)) {
        idamage = self [[ self.overrideactordamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, timeoffset, boneindex, modelindex);
    } else if (isdefined(level.overrideactordamage)) {
        idamage = self [[ level.overrideactordamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, timeoffset, boneindex, modelindex);
    }
    if (isdefined(self.aioverridedamage)) {
        if (isarray(self.aioverridedamage)) {
            foreach (cb in self.aioverridedamage) {
                idamage = self [[ cb ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, timeoffset, boneindex, modelindex);
            }
        } else {
            idamage = self [[ self.aioverridedamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, timeoffset, boneindex, modelindex);
        }
    }
    if (idamage >= self.health) {
        self zombie_eye_glow_stop();
    }
    if (isdefined(eattacker) && isdefined(eattacker.owner)) {
        eattacker = eattacker.owner;
    }
    self finishactordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, surfacetype, surfacenormal);
}

// Namespace doa_enemy
// Params 14, eflags: 0x1 linked
// Checksum 0x9bca2599, Offset: 0x2f38
// Size: 0x4fc
function function_ff217d39(einflictor, eattacker, idamage, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (isdefined(einflictor)) {
        self.damageinflictor = einflictor;
    }
    self asmsetanimationrate(1);
    if (self.team == "allies") {
        /#
            namespace_49107f3a::debugmsg("<dev string:x8b>" + self.archetype);
        #/
    }
    if (isdefined(self.fx)) {
        self thread namespace_eaa992c::turnofffx(self.fx);
    }
    if (randomint(100) < 20) {
        switch (randomint(3)) {
        case 0:
            self thread namespace_eaa992c::function_285a2999("headshot");
            break;
        case 1:
            self thread namespace_eaa992c::function_285a2999("headshot_nochunks");
            break;
        default:
            self thread namespace_eaa992c::function_285a2999("bloodspurt");
            break;
        }
    }
    if (isdefined(self.doa) && !(isdefined(self.boss) && self.boss) && !(isdefined(self.doa.var_4d252af6) && self.doa.var_4d252af6)) {
        roll = randomint(isdefined(self.var_2ea42113) ? self.var_2ea42113 : getdvarint("scr_doa_drop_rate_perN", -56));
        if (roll == 0) {
            namespace_a7e6beb5::function_16237a19(self.origin, 1, 85, 1, 0, undefined, level.doa.var_9bf7e61b);
        }
    }
    if (isdefined(self.interdimensional_gun_kill) && self.interdimensional_gun_kill) {
        self namespace_fba031c8::function_7b3e39cb();
        level thread namespace_a7e6beb5::function_16237a19(self.origin, 1, 1, 1, 1);
    }
    if (isdefined(eattacker)) {
        if (isactor(eattacker) && isdefined(eattacker.owner) && isplayer(eattacker.owner)) {
            eattacker = eattacker.owner;
        }
        if (isplayer(eattacker) && isdefined(eattacker.doa) && isdefined(self.doa) && isdefined(self.doa.points)) {
            eattacker.kills = math::clamp(eattacker.kills + 1, 0, 65535);
            eattacker.doa.kills++;
            eattacker namespace_64c6b720::function_80eb303(self.doa.points);
        }
    }
    if (smeansofdeath == "MOD_CRUSH") {
        assert(!(isdefined(self.boss) && self.boss));
        self namespace_fba031c8::function_ddf685e8(undefined, eattacker);
        if (isdefined(eattacker)) {
            eattacker notify(#"hash_108fd845");
        }
    }
    if (smeansofdeath == "MOD_ELECTROCUTED" && isdefined(einflictor)) {
        dir = self.origin - einflictor.origin;
        self thread namespace_49107f3a::function_e3c30240(dir);
    }
}

// Namespace doa_enemy
// Params 15, eflags: 0x1 linked
// Checksum 0x1560aa28, Offset: 0x3440
// Size: 0x254
function function_c26b6656(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (isdefined(eattacker) && eattacker.team == self.team) {
        idamage = 0;
    }
    if (isdefined(self.playercontrolled) && isdefined(self.owner) && isplayer(self.owner) && self.playercontrolled) {
        if (isdefined(eattacker.var_dcdf7239) && isdefined(eattacker) && eattacker.var_dcdf7239) {
        }
        idamage = 0;
    }
    if (isdefined(self.overridevehicledamage)) {
        idamage = self [[ self.overridevehicledamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    } else if (isdefined(level.overridevehicledamage)) {
        idamage = self [[ level.overridevehicledamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    }
    if (idamage == 0) {
        return;
    }
    idamage = int(idamage);
    self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, 0);
}

// Namespace doa_enemy
// Params 8, eflags: 0x1 linked
// Checksum 0x2f9efbe4, Offset: 0x36a0
// Size: 0x230
function function_90772ac6(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    if (isdefined(einflictor)) {
        self.damageinflictor = einflictor;
    }
    if (isdefined(eattacker) && isplayer(eattacker) && isdefined(eattacker.doa) && isdefined(self.doa)) {
        eattacker.kills = math::clamp(eattacker.kills + 1, 0, 65535);
        eattacker.doa.kills++;
        eattacker namespace_64c6b720::function_80eb303(self.doa.points);
    }
    params = spawnstruct();
    params.einflictor = einflictor;
    params.eattacker = eattacker;
    params.idamage = idamage;
    params.smeansofdeath = smeansofdeath;
    params.weapon = weapon;
    params.vdir = vdir;
    params.shitloc = shitloc;
    params.psoffsettime = psoffsettime;
    self callback::callback(#"hash_acb66515", params);
    if (isdefined(self.overridevehiclekilled)) {
        self [[ self.overridevehiclekilled ]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    }
}

// Namespace doa_enemy
// Params 0, eflags: 0x1 linked
// Checksum 0x3b856dc6, Offset: 0x38d8
// Size: 0x58
function function_e77599c() {
    level.doa.var_b351e5fb++;
    self waittill(#"death");
    level.doa.var_b351e5fb--;
    if (level.doa.var_b351e5fb < 0) {
        level.doa.var_b351e5fb = 0;
    }
}

// Namespace doa_enemy
// Params 0, eflags: 0x0
// Checksum 0xe272b44c, Offset: 0x3938
// Size: 0xae
function function_7c435737() {
    self endon(#"death");
    self endon(#"hash_10fd80ee");
    while (isalive(self)) {
        target = doa_player_utility::function_35f36dec(self.origin);
        if (isdefined(target) && !(isdefined(self.ignoreall) && self.ignoreall)) {
            self setentitytarget(target);
        } else {
            self clearentitytarget();
        }
        wait 1;
    }
}

// Namespace doa_enemy
// Params 3, eflags: 0x1 linked
// Checksum 0x9d76cabc, Offset: 0x39f0
// Size: 0x568
function function_a4e16560(var_1e913765, s_spawn_loc, force) {
    if (!isdefined(force)) {
        force = 0;
    }
    /#
    #/
    if (!force && level.doa.var_b351e5fb >= level.doa.rules.max_enemy_count) {
        return;
    }
    if (!mayspawnentity()) {
        return;
    }
    var_1e913765.lastspawntime = 0;
    if (!isdefined(s_spawn_loc.angles)) {
        s_spawn_loc.angles = (0, 0, 0);
    }
    var_1e913765.count = 9999;
    ai_spawned = var_1e913765 spawner::spawn(1, "doa enemy", s_spawn_loc.origin, s_spawn_loc.angles, 1);
    if (!isdefined(ai_spawned)) {
        return;
    }
    ai_spawned.spawner = var_1e913765;
    ai_spawned setthreatbiasgroup("zombies");
    ai_spawned.doa = spawnstruct();
    ai_spawned.doa.original_origin = ai_spawned.origin;
    ai_spawned.doa.points = level.doa.rules.var_c7b07ba9;
    ai_spawned.doa.stunned = 0;
    ai_spawned.no_eye_glow = 1;
    ai_spawned.holdfire = 1;
    ai_spawned.meleedamage = 123;
    ai_spawned thread function_e77599c();
    ai_spawned thread function_53055b45();
    ai_spawned thread function_155957e9();
    ai_spawned thread function_755b8a2e();
    ai_spawned thread function_8abf3753();
    ai_spawned thread namespace_49107f3a::function_783519c1("cleanUpAI", 1);
    ai_spawned thread function_ab6f6263();
    ai_spawned thread function_462594a2();
    if (isvehicle(ai_spawned)) {
        ai_spawned.origin = s_spawn_loc.origin;
        ai_spawned.angles = s_spawn_loc.angles;
        return ai_spawned;
    } else {
        ai_spawned.var_ccaea265 = &function_d30fe558;
        gibserverutils::togglespawngibs(ai_spawned, 1);
    }
    if (isdefined(var_1e913765.script_noteworthy) && issubstr(var_1e913765.script_noteworthy, "has_eyes")) {
        ai_spawned.no_eye_glow = undefined;
        ai_spawned zombie_eye_glow();
    }
    ai_spawned forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
    ai_spawned.goalradius = 8;
    ai_spawned updatespeed();
    ai_spawned.health = level.doa.zombie_health;
    ai_spawned.maxhealth = level.doa.zombie_health;
    ai_spawned.animname = "zombie";
    ai_spawned.var_a7d1d70c = 0;
    ai_spawned.updatesight = 0;
    ai_spawned.maxsightdistsqrd = 512 * 512;
    ai_spawned.fovcosine = 0.77;
    ai_spawned.anim_rate = level.doa.var_c061227e;
    if (isdefined(var_1e913765.var_8d1af144) && var_1e913765.var_8d1af144) {
        ai_spawned asmsetanimationrate(ai_spawned.anim_rate);
        ai_spawned.var_96437a17 = 1;
    }
    ai_spawned.badplaceawareness = 0;
    ai_spawned setrepairpaths(0);
    return ai_spawned;
}

// Namespace doa_enemy
// Params 0, eflags: 0x0
// Checksum 0x73a4e661, Offset: 0x3f60
// Size: 0x1c
function function_71a4f1d5() {
    self waittill(#"actor_corpse", corpse);
}

// Namespace doa_enemy
// Params 0, eflags: 0x1 linked
// Checksum 0x8a45f0a1, Offset: 0x3f88
// Size: 0x4c
function zombie_eye_glow() {
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(self.no_eye_glow) || !self.no_eye_glow) {
        self clientfield::set("zombie_has_eyes", 1);
    }
}

// Namespace doa_enemy
// Params 0, eflags: 0x1 linked
// Checksum 0xd3e64dc3, Offset: 0x3fe0
// Size: 0x210
function function_462594a2() {
    self endon(#"death");
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(self.aitype)) {
        return;
    }
    alias = "zmb_vocals_zombie_default";
    switch (self.aitype) {
    case "spawner_zombietron_zombie":
        alias = "zmb_vocals_zombie_default";
        break;
    case "spawner_zombietron_smokeman":
        alias = "zmb_vocals_zombie_default";
        break;
    case "spawner_zombietron_cellbreaker":
        alias = "zmb_vocals_warlord";
        break;
    case "spawner_zombietron_warlord":
        alias = "zmb_vocals_warlord";
        break;
    case "spawner_zombietron_silverback":
        alias = "zmb_simianaut_vocal";
        break;
    case "spawner_zombietron_robot":
        alias = "zmb_vocals_bot_ambient";
        break;
    case "spawner_zombietron_riser":
        alias = "zmb_vocals_zombie_default";
        break;
    case "spawner_zombietron_bloodriser":
        alias = "zmb_vocals_zombie_default";
        break;
    case "spawner_zombietron_poor_urban":
        alias = "zmb_vocals_zombie_default";
        break;
    case "spawner_zombietron_margwa":
        alias = undefined;
        break;
    case "spawner_zombietron_dog":
        alias = "zmb_vocals_hellhound_ambient";
        break;
    case "spawner_zombietron_collector":
        alias = "zmb_vocals_collector";
        break;
    case "spawner_zombietron_skeleton":
        alias = "zmb_vocals_skel_ambient";
        break;
    case "spawner_zombietron_54i_robot":
        alias = "zmb_vocals_bot_ambient";
        break;
    }
    if (!isdefined(alias)) {
        return;
    }
    wait randomfloatrange(1, 4);
    while (isdefined(self)) {
        if (mayspawnentity()) {
            self playsound(alias);
        }
        wait randomintrange(4, 10);
    }
}

// Namespace doa_enemy
// Params 0, eflags: 0x1 linked
// Checksum 0xff347dfd, Offset: 0x41f8
// Size: 0x4c
function zombie_eye_glow_stop() {
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(self.no_eye_glow) || !self.no_eye_glow) {
        self clientfield::set("zombie_has_eyes", 0);
    }
}

// Namespace doa_enemy
// Params 1, eflags: 0x5 linked
// Checksum 0xf0aead23, Offset: 0x4250
// Size: 0x48
function private function_8abf3753(time) {
    if (!isdefined(time)) {
        time = 1;
    }
    self endon(#"death");
    wait time;
    self.doa.original_origin = self.origin;
}

// Namespace doa_enemy
// Params 1, eflags: 0x1 linked
// Checksum 0x120a4639, Offset: 0x42a0
// Size: 0xc4
function function_8a4222de(time) {
    if (!isactor(self)) {
        return;
    }
    self endon(#"death");
    self endon(#"hash_67a97d62");
    self setavoidancemask("avoid none");
    var_e0bc9b4c = self function_1762804b(0);
    wait time;
    self setavoidancemask("avoid all");
    if (isdefined(var_e0bc9b4c)) {
        self function_1762804b(var_e0bc9b4c);
    }
}

// Namespace doa_enemy
// Params 0, eflags: 0x1 linked
// Checksum 0xa5b23d9f, Offset: 0x4370
// Size: 0x198
function function_155957e9() {
    self endon(#"death");
    self endon(#"hash_67a97d62");
    if (isdefined(self.boss)) {
        return;
    }
    var_2f36e0eb = 0;
    while (!level flag::get("doa_game_is_over")) {
        wait 1;
        var_d88cc53c = namespace_3ca3c537::function_dc34896f();
        if (!self istouching(var_d88cc53c)) {
            var_2f36e0eb++;
        } else {
            var_2f36e0eb = 0;
        }
        if (var_2f36e0eb == 5) {
            /#
                namespace_49107f3a::debugmsg("<dev string:xa3>" + self.origin + "<dev string:xb6>" + self.spawner.targetname);
            #/
            self.var_802ce72 = 1;
            self.allowdeath = 1;
            self kill();
        }
        if (var_2f36e0eb == 6) {
            /#
                namespace_49107f3a::debugmsg("<dev string:xa3>" + self.origin + "<dev string:xb6>" + self.spawner.targetname);
            #/
            self.var_802ce72 = 1;
            self delete();
        }
    }
}

// Namespace doa_enemy
// Params 0, eflags: 0x1 linked
// Checksum 0xc0b8ca77, Offset: 0x4510
// Size: 0x84
function function_755b8a2e() {
    self endon(#"death");
    self endon(#"hash_6dcbb83e");
    wait 1;
    while (level flag::get("doa_round_spawning")) {
        wait 0.05;
    }
    if (namespace_49107f3a::function_b99d78c7() > 5) {
        wait 0.05;
    }
    self thread namespace_49107f3a::function_ba30b321(60);
}

// Namespace doa_enemy
// Params 0, eflags: 0x1 linked
// Checksum 0xa369ca9a, Offset: 0x45a0
// Size: 0x3d8
function function_53055b45() {
    self endon(#"death");
    self endon(#"hash_6e8326fc");
    if (isdefined(self.boss)) {
        return;
    }
    if (isdefined(self.doa.mini_boss)) {
    }
    fails = 0;
    while (!level flag::get("doa_game_is_over")) {
        if (isdefined(self.var_58acb0e3) && (isdefined(level.hostmigrationtimer) && (isdefined(self.var_9da96e67) && (isdefined(self.var_dd70dacd) && (isdefined(self.traversestartnode) || isdefined(self.doa.poi) || self.doa.stunned != 0 || self.var_dd70dacd) || self.var_9da96e67) || level.hostmigrationtimer) || self.var_58acb0e3)) {
            wait 1;
            continue;
        }
        if (fails == 0) {
            if (isdefined(self.var_b7e79322) && self.var_b7e79322) {
                checkpos = (self.origin[0], self.origin[1], self.origin[2]);
                time = 2;
            } else {
                checkpos = (self.origin[0], self.origin[1], 0);
                time = 1;
            }
        }
        wait time;
        if (isdefined(self.var_b7e79322) && self.var_b7e79322) {
            mindistsq = 4 * 4;
            var_3faea97b = (self.origin[0], self.origin[1], self.origin[2]);
        } else {
            mindistsq = 32 * 32;
            var_3faea97b = (self.origin[0], self.origin[1], 0);
        }
        distsq = distancesquared(checkpos, var_3faea97b);
        if (distsq < mindistsq) {
            fails++;
            if (fails == 2) {
                self thread function_8a4222de(3);
            }
            if (fails == 5) {
                /#
                    namespace_49107f3a::debugmsg("<dev string:xa3>" + self.origin + "<dev string:xe5>" + self.spawner.targetname);
                #/
                self dodamage(self.health + 666, self.origin);
            }
        } else {
            fails = 0;
        }
        if (level flag::get("doa_round_spawning") || isdefined(self.doa.poi)) {
            continue;
        }
        if (isdefined(self.iscrawler) && (isdefined(self.missinglegs) && self.missinglegs || self.iscrawler)) {
            self dodamage(int(self.maxhealth * 0.1), self.origin);
        }
    }
}

// Namespace doa_enemy
// Params 0, eflags: 0x1 linked
// Checksum 0x534c6208, Offset: 0x4980
// Size: 0x254
function function_ab6f6263() {
    var_2c143867 = array(generic%ai_zombie_base_idle_ad_v1, generic%ai_zombie_base_idle_au_v1, generic%bo3_ai_zombie_attack_v1, generic%bo3_ai_zombie_attack_v2, generic%bo3_ai_zombie_attack_v3, generic%bo3_ai_zombie_attack_v4, generic%bo3_ai_zombie_attack_v6);
    self endon(#"death");
    self notify(#"hash_ab6f6263");
    self endon(#"hash_ab6f6263");
    self.var_58acb0e3 = undefined;
    while (!(isdefined(level.hostmigrationtimer) && level.hostmigrationtimer)) {
        wait 1;
    }
    self.ignoreall = 1;
    self clearentitytarget();
    while (isdefined(level.hostmigrationtimer) && level.hostmigrationtimer) {
        self.var_58acb0e3 = 1;
        if (isdefined(self.var_96437a17) && self.var_96437a17 && !(isdefined(self.var_9da96e67) && self.var_9da96e67)) {
            idleanim = var_2c143867[randomint(var_2c143867.size)];
            self animscripted("zombieanim", self.origin, self.angles, idleanim, "normal", generic%body, 1, 0.3, 0.3);
            self waittillmatch(#"zombieanim", "end");
            continue;
        }
        self setgoal(self.origin, 0);
        wait 1;
    }
    wait 0.05;
    self.ignoreall = 0;
    self.var_58acb0e3 = undefined;
    self thread function_ab6f6263();
}

